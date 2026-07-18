document.addEventListener('DOMContentLoaded', () => {
  // Flash messages
  setTimeout(() => {
    document.querySelectorAll('.alert').forEach((a) => {
      a.classList.remove('show')
      a.classList.add('fade')
      setTimeout(() => a.remove(), 500)
    })
  }, 4000)
})

document.body.addEventListener('htmx:afterSwap', (evt) => {
  const alerts = evt.detail.elt.querySelectorAll('.alert')
  if (alerts.length > 0) {
    setTimeout(() => {
      alerts.forEach((a) => {
        a.classList.remove('show')
        a.classList.add('fade')
        setTimeout(() => a.remove(), 500)
      })
    }, 4000)
  }
})
