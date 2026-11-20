import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fiitwgetqkpyapsfnrfd.supabase.co',
    anonKey: 'sb_publishable_AgSKsm8GlzwnHOkwM90Enw_fkjnCvCC',
  );
  runApp(const RepZeroApp());
}

class RepZeroApp extends StatelessWidget {
  const RepZeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepZero - Solo Leveling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const EcranIntroduction(),
    );
  }
}

// ==========================================
// 1. INTRODUCTION STYLE SYSTÈME
// ==========================================
class EcranIntroduction extends StatefulWidget {
  const EcranIntroduction({super.key});

  @override
  State<EcranIntroduction> createState() => _EcranIntroductionState();
}

class _EcranIntroductionState extends State<EcranIntroduction> {
  int _etapeTexte = 0;
  final List<String> _lignesSysteme = [
    "[ Alerte : Connexion au réseau neuronal du Joueur... ]",
    "[ Analyse des capacités physiques... Évaluation : Rang E ]",
    "[ Protocole d'évolution de Monarque activé : Synchronisation avec le Serveur Central. ]",
    "[ Veuillez vous identifier pour initialiser le système. ]"
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_etapeTexte < _lignesSysteme.length - 1) {
        setState(() {
          _etapeTexte++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color bleuSysteme = Color(0xFF00E5FF);

    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0D1522),
                    border: Border.all(color: bleuSysteme, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: bleuSysteme.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 5),
                    ],
                  ),
                  child:
                      const Icon(Icons.flash_on, color: bleuSysteme, size: 50),
                ),
                const SizedBox(height: 20),
                const Text(
                  'REPZERO',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1522),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: bleuSysteme, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.shield, color: bleuSysteme, size: 22),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '[ MESSAGE DU SYSTÈME ]',
                              style: TextStyle(
                                  color: bleuSysteme,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 1.5),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: bleuSysteme, height: 25),
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          itemCount: _etapeTexte + 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                _lignesSysteme[index],
                                style: TextStyle(
                                  color: index == _lignesSysteme.length - 1
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 13,
                                  fontWeight: index == _lignesSysteme.length - 1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  height: 1.3,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bleuSysteme,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EcranConnexionCompte()),
                    );
                  },
                  child: const Text('« ACCÉDER À LA CONNEXION »',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1.2 ÉCRAN DE CONNEXION / COMPTE & SUPABASE
// ==========================================
class EcranConnexionCompte extends StatefulWidget {
  const EcranConnexionCompte({super.key});

  @override
  State<EcranConnexionCompte> createState() => _EcranConnexionCompteState();
}

class _EcranConnexionCompteState extends State<EcranConnexionCompte> {
  final TextEditingController _pseudoController =
      TextEditingController(text: 'SungJinWoo');
  final TextEditingController _emailController =
      TextEditingController(text: 'chasseur@repzero.net');
  final TextEditingController _passwordController =
      TextEditingController(text: 'motdepasse123');
  bool _modeInscription = false;
  bool _isLoading = false;

  Future<void> _validerConnexion({bool estInvite = false}) async {
    if (estInvite) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const EcranChoixMode(
                pseudoJoueur: 'Chasseur Anonyme',
                emailJoueur: 'invite@repzero.net')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_modeInscription) {
        await Supabase.instance.client.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Compte créé avec succès ! Connectez-vous.')),
        );
        setState(() => _modeInscription = false);
      } else {
        await Supabase.instance.client.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EcranChoixMode(
              pseudoJoueur: _pseudoController.text.trim().isEmpty
                  ? 'Chasseur'
                  : _pseudoController.text.trim(),
              emailJoueur: _emailController.text.trim(),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Erreur : $e', style: const TextStyle(color: Colors.red))),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color bleu = Color(0xFF00E5FF);

    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Icon(Icons.lock_person, color: bleu, size: 55)),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    _modeInscription
                        ? '[ CRÉATION DE COMPTE SUPABASE ]'
                        : '[ CONNEXION AU RÉSEAU ]',
                    style: const TextStyle(
                        color: bleu,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ),
                const SizedBox(height: 25),
                if (_modeInscription) ...[
                  const Text('PSEUDO DU CHASSEUR :',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _pseudoController,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0D1522),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: bleu.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: bleu, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
                const Text('ADRESSE EMAIL :',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF0D1522),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: bleu.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: bleu, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                const Text('MOT DE PASSE :',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF0D1522),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: bleu.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: bleu, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 25),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: bleu))
                    : Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bleu,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () =>
                                _validerConnexion(estInvite: false),
                            child: Text(
                              _modeInscription
                                  ? 'VALIDER L\'INSCRIPTION'
                                  : 'SE CONNECTER AU COMPTE',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  letterSpacing: 1),
                            ),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side:
                                  const BorderSide(color: Colors.orangeAccent),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => _validerConnexion(estInvite: true),
                            child: const Text(
                              '👤 CONNEXION EN TANT QU\'INVITÉ',
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 15),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        setState(() => _modeInscription = !_modeInscription),
                    child: Text(
                      _modeInscription
                          ? 'Déjà un compte ? Se connecter'
                          : 'Pas de compte ? S\'inscrire au Système',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1.5 ÉCRAN DE SÉLECTION DU MODE (SALLE / MAISON)
// ==========================================
class EcranChoixMode extends StatelessWidget {
  final String pseudoJoueur;
  final String emailJoueur;

  const EcranChoixMode(
      {super.key, required this.pseudoJoueur, required this.emailJoueur});

  @override
  Widget build(BuildContext context) {
    const Color bleu = Color(0xFF00E5FF);

    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fitness_center, color: bleu, size: 55),
              const SizedBox(height: 12),
              Text('Chasseur : $pseudoJoueur',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Email : $emailJoueur',
                  style: const TextStyle(color: Colors.grey, fontSize: 11)),
              const SizedBox(height: 30),
              const Text(
                '[ CHOIX DU PROTOCOLE D\'ENTRAÎNEMENT ]',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: bleu,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D1522),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  side: const BorderSide(color: bleu, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EcranPrincipalNavigation(
                            modeSalle: false,
                            pseudo: pseudoJoueur,
                            email: emailJoueur)),
                  );
                },
                child: const Text('🏠 SANS MATÉRIEL (À la maison)',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EcranPrincipalNavigation(
                            modeSalle: true,
                            pseudo: pseudoJoueur,
                            email: emailJoueur)),
                  );
                },
                child: const Text('🏋️ AVEC SALLE DE SPORT (Machines & Poids)',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. NAVIGATION & GESTION GLOBALE
// ==========================================
class EcranPrincipalNavigation extends StatefulWidget {
  final bool modeSalle;
  final String pseudo;
  final String email;

  const EcranPrincipalNavigation(
      {super.key,
      required this.modeSalle,
      required this.pseudo,
      required this.email});

  @override
  State<EcranPrincipalNavigation> createState() =>
      _EcranPrincipalNavigationState();
}

class _EcranPrincipalNavigationState extends State<EcranPrincipalNavigation> {
  int _ongletActuel = 0;
  int _niveau = 1;
  int _xp = 0;
  int _or = 350;
  final int _xpMax = 100;

  int _potionsMana = 2;
  int _elixirXP = 1;
  int _clesDonjonE = 1;
  int _clesDonjonC = 0;
  int _clesDonjonS = 0;
  int _ombresExtraites = 0;
  String _titreActuel = 'Novice Égaré';

  int _repsSport = 0;
  late bool _modeSalleActuel = widget.modeSalle;
  late String _exerciceActuel =
      _modeSalleActuel ? 'DÉVELOPPÉ COUCHÉ (Pecs)' : 'POMPES CLASSIQUES (Pecs)';

  int get _objectifActuel => 5 + ((_niveau - 1) * 3);
  int get _tempsLimiteActuel => (45 - ((_niveau - 1) * 2)).clamp(15, 45);

  late final List _messagesSysteme = [
    {
      'titre': '[COMPTE SYNCHRONISÉ]',
      'corps':
          'Connexion établie pour ${widget.email}. Bon entraînement Chasseur !',
      'temps': 'À l\'instant'
    }
  ];

  String get _rang {
    if (_niveau >= 20) return 'S (Monarque)';
    if (_niveau >= 15) return 'A';
    if (_niveau >= 10) return 'B';
    if (_niveau >= 6) return 'C';
    if (_niveau >= 3) return 'D';
    return 'E';
  }

  void _basculerMode() {
    setState(() {
      _modeSalleActuel = !_modeSalleActuel;
      _repsSport = 0;
      _exerciceActuel = _modeSalleActuel
          ? 'DÉVELOPPÉ COUCHÉ (Pecs)'
          : 'POMPES CLASSIQUES (Pecs)';
    });
    _ajouterMessage('[ SYSTÈME ]',
        'Mode basculé vers : ${_modeSalleActuel ? "SALLE DE SPORT" : "MAISON"}');
  }

  void _ajouterXP(int points, String raison) {
    setState(() {
      _xp += points;
      _or += points ~/ 2;
      while (_xp >= _xpMax) {
        _xp -= _xpMax;
        _niveau++;
        _ajouterMessage('[ LEVEL UP ! ]',
            'Niveau $_niveau atteint ! Objectif : $_objectifActuel reps.');
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF0A192F),
        content: Text('[SYSTÈME] $raison (+$points EXP, +${points ~/ 2} Or)',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _ajouterMessage(String titre, String corps) {
    setState(() {
      _messagesSysteme
          .insert(0, {'titre': titre, 'corps': corps, 'temps': 'À l\'instant'});
    });
  }

  void _lancerPenalite() async {
    _ajouterMessage('[PÉNALITÉ ACTIVÉE]',
        'Échec de la série ! Transfert en Zone de Pénalité.');
    final reussi = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EcranPenalite()));
    if (reussi == true) {
      _ajouterXP(40, 'SURVIE EN ZONE DE PÉNALITÉ !');
    }
  }

  void _entrerDansDonjon(String rangDonjon) async {
    int pvBoss = 1000;
    int recompenseXP = 150;

    if (rangDonjon == 'C') {
      pvBoss = 2500;
      recompenseXP = 350;
      if (_clesDonjonC <= 0) return;
      setState(() => _clesDonjonC--);
    } else if (rangDonjon == 'S') {
      pvBoss = 6000;
      recompenseXP = 800;
      if (_clesDonjonS <= 0) return;
      setState(() => _clesDonjonS--);
    } else {
      if (_clesDonjonE <= 0) return;
      setState(() => _clesDonjonE--);
    }

    final victoire = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EcranDonjon(
              nomBoss: 'Boss Rang $rangDonjon',
              pvInitial: pvBoss,
              modeSalle: _modeSalleActuel)),
    );

    if (victoire == true) {
      setState(() => _ombresExtraites++);
      _ajouterXP(recompenseXP, 'DONJON RANG $rangDonjon NETTOYÉ !');
    }
  }

  void _regarderPubRecompensee() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0D1522),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF00E5FF), width: 2),
            borderRadius: BorderRadius.circular(12)),
        title: const Text('[ TRANSMISSION EN COURS ]',
            style: TextStyle(
                color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF00E5FF)),
            SizedBox(height: 20),
            Text(
                'Connexion au réseau du Système...\nVisionnage de la transmission.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context);
      setState(() {
        _or += 75;
        _potionsMana += 1;
      });
      _ajouterMessage(
          '[BOUTIQUE]', 'Transmission reçue : +75 Or et +1 Potion.');
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color bleuSysteme = Color(0xFF00E5FF);

    final pages = [
      ModeCompteur(
        repsActuelles: _repsSport,
        exerciceActuel: _exerciceActuel,
        objectifReps: _objectifActuel,
        tempsMax: _tempsLimiteActuel,
        modeSalle: _modeSalleActuel,
        onChangerExercice: (exo) => setState(() {
          _exerciceActuel = exo;
          _repsSport = 0;
        }),
        onIncrementerReps: () => setState(() => _repsSport++),
        onReinitialiserReps: () => setState(() => _repsSport = 0),
        onEchecChrono: _lancerPenalite,
        onValiderSerie: () => _ajouterXP(50, 'Série validée !'),
        onMessageSysteme: _ajouterMessage,
      ),
      ModeQuetes(
        onGagnerXP: _ajouterXP,
        onEchecQuete: _lancerPenalite,
        clesE: _clesDonjonE,
        clesC: _clesDonjonC,
        clesS: _clesDonjonS,
        onEntrerDonjon: _entrerDansDonjon,
      ),
      ModeMessagerie(messages: _messagesSysteme),
      ModeBoutique(
        orActuel: _or,
        potionsMana: _potionsMana,
        elixirXP: _elixirXP,
        clesE: _clesDonjonE,
        clesC: _clesDonjonC,
        clesS: _clesDonjonS,
        titreActuel: _titreActuel,
        onAcheter: (prix, type, {String? nouveauTitre}) {
          setState(() {
            _or -= prix;
            if (type == 'potion') _potionsMana++;
            if (type == 'elixir') {
              _elixirXP++;
              _ajouterXP(50, 'Élixir consommé !');
            }
            if (type == 'cleE') _clesDonjonE++;
            if (type == 'cleC') _clesDonjonC++;
            if (type == 'cleS') _clesDonjonS++;
            if (type == 'titre' && nouveauTitre != null)
              _titreActuel = nouveauTitre;
          });
        },
        onRegarderPub: _regarderPubRecompensee,
      ),
      ModeProfilCompte(
        pseudo: widget.pseudo,
        email: widget.email,
        niveau: _niveau,
        rang: _rang,
        titre: _titreActuel,
        ombres: _ombresExtraites,
        or: _or,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text('REPZERO // ${widget.pseudo}',
                style: const TextStyle(
                    color: bleuSysteme,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
            const Spacer(),
            InkWell(
              onTap: _basculerMode,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _modeSalleActuel
                      ? Colors.purpleAccent.withOpacity(0.3)
                      : bleuSysteme.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color:
                          _modeSalleActuel ? Colors.purpleAccent : bleuSysteme),
                ),
                child: Row(
                  children: [
                    Icon(_modeSalleActuel ? Icons.fitness_center : Icons.home,
                        size: 12,
                        color: _modeSalleActuel
                            ? Colors.purpleAccent
                            : bleuSysteme),
                    const SizedBox(width: 4),
                    Text(
                      _modeSalleActuel ? 'SALLE' : 'MAISON',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _modeSalleActuel
                              ? Colors.purpleAccent
                              : bleuSysteme),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 12, left: 6),
              child: Text('💰 $_or Or',
                  style: const TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 11)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1522),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: bleuSysteme.withOpacity(0.5)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('NIV. $_niveau • [$_titreActuel]',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10.5)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: bleuSysteme.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: bleuSysteme),
                      ),
                      child: Text('RANG $_rang',
                          style: const TextStyle(
                              color: bleuSysteme,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                    value: _xp / _xpMax,
                    minHeight: 4,
                    backgroundColor: Colors.grey.shade900,
                    color: bleuSysteme),
              ],
            ),
          ),
          Expanded(child: pages[_ongletActuel]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0D1522),
        selectedItemColor: bleuSysteme,
        unselectedItemColor: Colors.grey,
        currentIndex: _ongletActuel,
        onTap: (i) => setState(() => _ongletActuel = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: 'Sport'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_late), label: 'Quêtes'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Boutique'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Compte'),
        ],
      ),
    );
  }
}

// ==========================================
// 3. MODE 1 : COMPTEUR & BIBLIOTHÈQUE D'EXERCICES
// ==========================================
class ModeCompteur extends StatefulWidget {
  final int repsActuelles;
  final String exerciceActuel;
  final int objectifReps;
  final int tempsMax;
  final bool modeSalle;
  final Function(String) onChangerExercice;
  final VoidCallback onIncrementerReps;
  final VoidCallback onReinitialiserReps;
  final VoidCallback onEchecChrono;
  final VoidCallback onValiderSerie;
  final Function(String, String) onMessageSysteme;

  const ModeCompteur({
    super.key,
    required this.repsActuelles,
    required this.exerciceActuel,
    required this.objectifReps,
    required this.tempsMax,
    required this.modeSalle,
    required this.onChangerExercice,
    required this.onIncrementerReps,
    required this.onReinitialiserReps,
    required this.onEchecChrono,
    required this.onValiderSerie,
    required this.onMessageSysteme,
  });

  @override
  State<ModeCompteur> createState() => _ModeCompteurState();
}

class _ModeCompteurState extends State<ModeCompteur>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _enRepos = false;
  bool _chronoActif = false;
  late int _tempsRestant = widget.tempsMax;
  int _chronoRepos = 45;
  Timer? _timer;

  final Map<String, String> _instructionsExercices = {
    'POMPES CLASSIQUES (Pecs)':
        'Corps aligné, mains sous les épaules, descendez la poitrine.',
    'POMPES DIAMANT (Bras/Triceps)':
        'Mains rapprochées sous la poitrine pour cibler les triceps.',
    'SQUATS AU CORPS (Jambes)':
        'Pieds largeur d\'épaules, descendez les fesses en arrière.',
    'ABDOS CRUNCH (Ventre)': 'Allongé, décollez les omoplates du sol.',
    'GAINAGE PLANCHE (Core)':
        'Appui sur les avant-bras, gardez le corps gainé.',
    'FENTES ALTERNÉES (Jambes)':
        'Pas en avant, fléchissez les genoux à 90 degrés.',
    'DIPS SUR CHAISE (Bras)': 'Mains sur une chaise, fléchissez les bras.',
    'TRACTIONS PORTE (Dos)': 'Tirez votre menton au-dessus de la barre fixe.',
    'DÉVELOPPÉ COUCHÉ (Pecs)':
        'Barre contrôlée sur le bas des pecs, poussez explosivement.',
    'DÉVELOPPÉ INCLINÉ (Pecs/Haut)':
        'Banc incliné à 30°, cible le haut des pectoraux.',
    'TRACTIONS POULIE HAUTE (Dos)':
        'Saisie large, tirez la barre vers la poitrine.',
    'SOULEVÉ DE TERRE (Dos/Jambes)':
        'Dos droit, tirez la charge en poussant sur les cuisses.',
  };

  void _demarrerChrono() {
    if (_chronoActif) return;
    setState(() {
      _chronoActif = true;
      _tempsRestant = widget.tempsMax;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_tempsRestant > 0) {
        setState(() => _tempsRestant--);
      } else {
        timer.cancel();
        setState(() => _chronoActif = false);
        widget.onEchecChrono();
      }
    });
  }

  void _demarrerRepos() {
    _timer?.cancel();
    setState(() {
      _enRepos = true;
      _chronoActif = false;
      _chronoRepos = 45;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_chronoRepos > 0) {
        setState(() => _chronoRepos--);
      } else {
        timer.cancel();
        setState(() => _enRepos = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const Color bleuSysteme = Color(0xFF00E5FF);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1522),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: bleuSysteme),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('EXERCICE ACTUEL :',
                        style: TextStyle(
                            color: bleuSysteme,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: widget.modeSalle
                              ? Colors.purple.withOpacity(0.3)
                              : Colors.blue.withOpacity(0.3)),
                      child: Text(widget.modeSalle ? 'SALLE' : 'MAISON',
                          style: TextStyle(
                              fontSize: 10,
                              color: widget.modeSalle
                                  ? Colors.purpleAccent
                                  : bleuSysteme,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                DropdownButton<String>(
                  value: widget.exerciceActuel,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF0D1522),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  items: (widget.modeSalle
                          ? [
                              'DÉVELOPPÉ COUCHÉ (Pecs)',
                              'DÉVELOPPÉ INCLINÉ (Pecs/Haut)',
                              'TRACTIONS POULIE HAUTE (Dos)',
                              'SOULEVÉ DE TERRE (Dos/Jambes)'
                            ]
                          : [
                              'POMPES CLASSIQUES (Pecs)',
                              'POMPES DIAMANT (Bras/Triceps)',
                              'SQUATS AU CORPS (Jambes)',
                              'ABDOS CRUNCH (Ventre)',
                              'GAINAGE PLANCHE (Core)'
                            ])
                      .map((exo) =>
                          DropdownMenuItem(value: exo, child: Text(exo)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) widget.onChangerExercice(val);
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  _instructionsExercices[widget.exerciceActuel] ??
                      'Exécutez l\'exercice avec une forme parfaite.',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0D1522),
              border: Border.all(
                  color: _enRepos
                      ? Colors.greenAccent
                      : (_chronoActif ? bleuSysteme : Colors.grey),
                  width: 3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _enRepos
                      ? 'REPOS'
                      : (_chronoActif ? '$_tempsRestant s' : 'OBJECTIF'),
                  style: TextStyle(
                      color: _enRepos ? Colors.greenAccent : bleuSysteme,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${widget.repsActuelles} / ${widget.objectifReps}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                const Text('REPS',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: bleuSysteme,
                    foregroundColor: Colors.black),
                onPressed: () {
                  if (!_chronoActif && !_enRepos) _demarrerChrono();
                  widget.onIncrementerReps();
                  if (widget.repsActuelles + 1 >= widget.objectifReps) {
                    _timer?.cancel();
                    setState(() {
                      _chronoActif = false;
                    });
                    widget.onValiderSerie();
                    _demarrerRepos();
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('+1 REP'),
              ),
              const SizedBox(width: 15),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.redAccent)),
                onPressed: widget.onReinitialiserReps,
                icon: const Icon(Icons.refresh, color: Colors.redAccent),
                label: const Text('RESET',
                    style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. MODE QUÊTES & DONJONS
// ==========================================
class ModeQuetes extends StatelessWidget {
  final Function(int, String) onGagnerXP;
  final VoidCallback onEchecQuete;
  final int clesE;
  final int clesC;
  final int clesS;
  final Function(String) onEntrerDonjon;

  const ModeQuetes({
    super.key,
    required this.onGagnerXP,
    required this.onEchecQuete,
    required this.clesE,
    required this.clesC,
    required this.clesS,
    required this.onEntrerDonjon,
  });

  @override
  Widget build(BuildContext context) {
    const Color bleu = Color(0xFF00E5FF);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('[ QUÊTE QUOTIDIENNE DU SYSTÈME ]',
            style: TextStyle(
                color: bleu, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: const Color(0xFF0D1522),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: bleu)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Entraînement de Monarque (Quotidien)',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('• 50 Pompes\n• 50 Squats\n• 10 km de Course',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: bleu,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 40)),
                onPressed: () => onGagnerXP(100, 'QUÊTE QUOTIDIENNE VALIDÉE !'),
                child: const Text('VALIDER LA QUÊTE (+100 XP)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text('[ PORTAILS DE DONJONS ]',
            style: TextStyle(
                color: bleu, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 10),
        ListTile(
          tileColor: const Color(0xFF0D1522),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: const Icon(Icons.vpn_key, color: Colors.blueAccent),
          title: const Text('Portail Rang E',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text('Clés disponibles : $clesE',
              style: const TextStyle(color: Colors.grey, fontSize: 11)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.black),
            onPressed: () => onEntrerDonjon('E'),
            child: const Text('ENTRER'),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          tileColor: const Color(0xFF0D1522),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: const Icon(Icons.vpn_key, color: Colors.purpleAccent),
          title: const Text('Portail Rang C',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text('Clés disponibles : $clesC',
              style: const TextStyle(color: Colors.grey, fontSize: 11)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                foregroundColor: Colors.black),
            onPressed: () => onEntrerDonjon('C'),
            child: const Text('ENTRER'),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 5. BOUTIQUE, MESSAGERIE, PROFIL & COMBATS
// ==========================================
class ModeBoutique extends StatelessWidget {
  final int orActuel;
  final int potionsMana;
  final int elixirXP;
  final int clesE;
  final int clesC;
  final int clesS;
  final String titreActuel;
  final Function(int, String, {String? nouveauTitre}) onAcheter;
  final VoidCallback onRegarderPub;

  const ModeBoutique({
    super.key,
    required this.orActuel,
    required this.potionsMana,
    required this.elixirXP,
    required this.clesE,
    required this.clesC,
    required this.clesS,
    required this.titreActuel,
    required this.onAcheter,
    required this.onRegarderPub,
  });

  @override
  Widget build(BuildContext context) {
    const Color bleu = Color(0xFF00E5FF);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('[ BOUTIQUE DU SYSTÈME ]',
            style: TextStyle(
                color: bleu, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 45)),
          onPressed: onRegarderPub,
          icon: const Icon(Icons.video_library),
          label: const Text('VISIONNER UNE TRANSMISSION (+75 Or)',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 15),
        ListTile(
          tileColor: const Color(0xFF0D1522),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Clé de Donjon Rang E',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: const Text('Prix : 100 Or',
              style: TextStyle(color: Colors.amberAccent, fontSize: 11)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: bleu, foregroundColor: Colors.black),
            onPressed: orActuel >= 100 ? () => onAcheter(100, 'cleE') : null,
            child: const Text('ACHETER'),
          ),
        ),
      ],
    );
  }
}

class ModeMessagerie extends StatelessWidget {
  final List messages;
  const ModeMessagerie({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    const Color bleu = Color(0xFF00E5FF);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final m = messages[index];
        return Card(
          color: const Color(0xFF0D1522),
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: bleu.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Text(m['titre'],
                style: const TextStyle(
                    color: bleu, fontWeight: FontWeight.bold, fontSize: 12)),
            subtitle: Text(m['corps'],
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
        );
      },
    );
  }
}

class ModeProfilCompte extends StatelessWidget {
  final String pseudo;
  final String email;
  final int niveau;
  final String rang;
  final String titre;
  final int ombres;
  final int or;

  const ModeProfilCompte({
    super.key,
    required this.pseudo,
    required this.email,
    required this.niveau,
    required this.rang,
    required this.titre,
    required this.ombres,
    required this.or,
  });

  @override
  Widget build(BuildContext context) {
    const Color bleu = Color(0xFF00E5FF);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(child: Icon(Icons.account_circle, size: 70, color: bleu)),
        const SizedBox(height: 10),
        Center(
            child: Text(pseudo,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))),
        Center(
            child: Text(email,
                style: const TextStyle(color: Colors.grey, fontSize: 12))),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: const Color(0xFF0D1522),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: bleu)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Niveau : $niveau',
                  style: const TextStyle(color: Colors.white)),
              Text('Rang : $rang',
                  style: const TextStyle(
                      color: bleu, fontWeight: FontWeight.bold)),
              Text('Titre : $titre',
                  style: const TextStyle(color: Colors.amberAccent)),
              Text('Ombres extraites : $ombres',
                  style: const TextStyle(color: Colors.white70)),
              Text('Or total : $or',
                  style: const TextStyle(color: Colors.amberAccent)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const EcranConnexionCompte()));
          },
          child: const Text('DÉCONNEXION'),
        ),
      ],
    );
  }
}

class EcranPenalite extends StatelessWidget {
  const EcranPenalite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, color: Colors.yellow, size: 60),
              const SizedBox(height: 20),
              const Text('ZONE DE PÉNALITÉ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              const Text('Vous avez échoué ! Survivez en validant l\'épreuve.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('SURVIVRE (+40 XP)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EcranDonjon extends StatelessWidget {
  final String nomBoss;
  final int pvInitial;
  final bool modeSalle;

  const EcranDonjon(
      {super.key,
      required this.nomBoss,
      required this.pvInitial,
      required this.modeSalle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      appBar: AppBar(title: Text(nomBoss)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.pets, size: 80, color: Colors.purpleAccent),
            const SizedBox(height: 20),
            Text('Combat contre $nomBoss',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.black),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('VAINCRE LE BOSS'),
            ),
          ],
        ),
      ),
    );
  }
}
