// Chargement automatique de la configuration Supabase
// Remplacez la valeur de key par votre "Anon public key"
// Optionnel: autoMigrate true pour migrer automatiquement les photos locales vers le cloud

window.SUPABASE_CONFIG = {
  url: 'https://yodcgllzpdhzjatyuahf.supabase.co',
  key: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlvZGNnbGx6cGRoemphdHl1YWhmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE2MDg4NzYsImV4cCI6MjA3NzE4NDg3Nn0.MMuGBEDtGN_QUl-snQ2DxG3dcINhwbjZDzwuB6ZNeS8', // <<< clé Anon injectée
  bucket: 'photos',
  hideUI: true,
  autoMigrate: false
};