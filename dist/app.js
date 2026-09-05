const tabs = [...document.querySelectorAll('.concept-tab')];
const concepts = [...document.querySelectorAll('.concept')];

function showConcept(id) {
  tabs.forEach((tab) => {
    const selected = tab.dataset.concept === id;
    tab.classList.toggle('is-active', selected);
    tab.setAttribute('aria-selected', String(selected));
    tab.tabIndex = selected ? 0 : -1;
  });

  concepts.forEach((concept) => {
    const selected = concept.id === `concept-${id}`;
    concept.hidden = !selected;
    concept.classList.toggle('is-active', selected);
  });

  history.replaceState(null, '', `#concept-${id}`);
  window.scrollTo({ top: 0, behavior: 'instant' });
}

tabs.forEach((tab, index) => {
  tab.addEventListener('click', () => showConcept(tab.dataset.concept));
  tab.addEventListener('keydown', (event) => {
    if (!['ArrowLeft', 'ArrowRight'].includes(event.key)) return;
    event.preventDefault();
    const direction = event.key === 'ArrowRight' ? 1 : -1;
    const next = tabs[(index + direction + tabs.length) % tabs.length];
    next.focus();
    showConcept(next.dataset.concept);
  });
});

const initial = window.location.hash.match(/^#concept-([abc])$/)?.[1] || 'a';
showConcept(initial);
