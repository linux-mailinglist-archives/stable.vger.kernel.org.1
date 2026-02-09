Return-Path: <stable+bounces-215336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNZDATn0iWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:50:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0322A111102
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33F373036EA6
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D8528725B;
	Mon,  9 Feb 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWfuCYgE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210137BE8C
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648463; cv=none; b=m6VKGZE1WHvMys95nLSWhIEJWK4HnWlH8WqY4bGBM/g4IyF9vhiK456cGUF16/FlC7F1hs3RPY0Z55KRLtCLLAnvidXCQFVf3cBwnTZw8d4C6PEiCALu6mFCnyhztfAPxc/5flEqe1lx/pUuS8C/+NeqhDGbcUvR7VqxvKGZUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648463; c=relaxed/simple;
	bh=ojeQRBv8bzl/j97EeAF06BrN9pveqc9QIkYGezj3hXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5JPE5uDwLcdv/kzNNlFKIt0arI/U6jN4ryRKPfsljM/qbiu2yIIMs2YN0yZ60kRdAr94uZv5Gx3moBb5KM7//YiIpaYw6yD3XXQA2eGO/U6FQ0dQ+Z/CRcSMUXHPbN1GhwKfAVEtfetkc+QQeqg4hbgeC2nhGgMHCSQV8fmb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWfuCYgE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770648463; x=1802184463;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ojeQRBv8bzl/j97EeAF06BrN9pveqc9QIkYGezj3hXM=;
  b=IWfuCYgE+aMrx4Sj+je1m0lKvdw8Xrob4Temro0g0zx0MhkguSQQX8PO
   SXNfAO0lbpcPMh8/9vDbjx73FdvYgTF+sg7W2a1W9eFZHM9FaTd3qlPaN
   Q+DEHqWG4UgQxhaPpvE8DdwnnctIBR/2oxhuGZAyCfEhHJHElPIIA0R3F
   HkNVHEdaCz9CaPUeFP+cSbvJkTbV7c+kYnsyhC5VuHaL0j0fi3fzILPSv
   nnnCEcxGzKAAxw+vTG5Izr0oH6g6lZpbhXifkI1bYr2PQBXrz41j1R68z
   0Dv0e7ki2ZxWBABw7lf32QT4/Il25f3mqacl7r8ESCb/+t3DxkHS3iUkG
   w==;
X-CSE-ConnectionGUID: 8JohLCyuT8y4bIdVO3ABFg==
X-CSE-MsgGUID: SMnW8g/2RPqzKFYa5h95hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="83129944"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="83129944"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 06:47:43 -0800
X-CSE-ConnectionGUID: ON98wxCIRHu35vc14P9ZiA==
X-CSE-MsgGUID: bjaKtFV/QKqKQsgPUhRYhw==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.245.179]) ([10.245.245.179])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 06:47:40 -0800
Message-ID: <89cb1d4744789702cd80dba8eb40dd50bf053b4e.camel@linux.intel.com>
Subject: Re: [PATCH v4] mm: Fix a hmm_range_fault() livelock / starvation
 problem
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alistair Popple <apopple@nvidia.com>, Ralph Campbell
 <rcampbell@nvidia.com>,  Christoph Hellwig	 <hch@lst.de>, Jason Gunthorpe
 <jgg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>,  Leon Romanovsky	
 <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Matthew Brost
	 <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	linux-mm@kvack.org, dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Date: Mon, 09 Feb 2026 15:47:38 +0100
In-Reply-To: <20260205111028.200506-1-thomas.hellstrom@linux.intel.com>
References: <20260205111028.200506-1-thomas.hellstrom@linux.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-215336-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0322A111102
X-Rspamd-Action: no action

@Alistair, any chance of an R-B for the below version?
@Andrew, will this go through the -mm tree or alternaltively an ack for
merging through drm-xe-fixes?

/Thomas

8<-------------------------------------------------------------------

On Thu, 2026-02-05 at 12:10 +0100, Thomas Hellstr=C3=B6m wrote:
> If hmm_range_fault() fails a folio_trylock() in do_swap_page,
> trying to acquire the lock of a device-private folio for migration,
> to ram, the function will spin until it succeeds grabbing the lock.
>=20
> However, if the process holding the lock is depending on a work
> item to be completed, which is scheduled on the same CPU as the
> spinning hmm_range_fault(), that work item might be starved and
> we end up in a livelock / starvation situation which is never
> resolved.
>=20
> This can happen, for example if the process holding the
> device-private folio lock is stuck in
> =C2=A0=C2=A0 migrate_device_unmap()->lru_add_drain_all()
> The lru_add_drain_all() function requires a short work-item
> to be run on all online cpus to complete.
>=20
> A prerequisite for this to happen is:
> a) Both zone device and system memory folios are considered in
> =C2=A0=C2=A0 migrate_device_unmap(), so that there is a reason to call
> =C2=A0=C2=A0 lru_add_drain_all() for a system memory folio while a
> =C2=A0=C2=A0 folio lock is held on a zone device folio.
> b) The zone device folio has an initial mapcount > 1 which causes
> =C2=A0=C2=A0 at least one migration PTE entry insertion to be deferred to
> =C2=A0=C2=A0 try_to_migrate(), which can happen after the call to
> =C2=A0=C2=A0 lru_add_drain_all().
> c) No or voluntary only preemption.
>=20
> This all seems pretty unlikely to happen, but indeed is hit by
> the "xe_exec_system_allocator" igt test.
>=20
> Resolve this by waiting for the folio to be unlocked if the
> folio_trylock() fails in the do_swap_page() function.
>=20
> Rename the migration_entry_wait_on_locked() function to
> softleaf_entry_wait_unlock() and update its documentation to
> indicate the new use-case.
>=20
> Future code improvements might consider moving
> the lru_add_drain_all() call in migrate_device_unmap() to be
> called *after* all pages have migration entries inserted.
> That would eliminate also b) above.
>=20
> v2:
> - Instead of a cond_resched() in the hmm_range_fault() function,
> =C2=A0 eliminate the problem by waiting for the folio to be unlocked
> =C2=A0 in do_swap_page() (Alistair Popple, Andrew Morton)
> v3:
> - Add a stub migration_entry_wait_on_locked() for the
> =C2=A0 !CONFIG_MIGRATION case. (Kernel Test Robot)
> v4:
> - Rename migrate_entry_wait_on_locked() to
> =C2=A0 softleaf_entry_wait_on_locked() and update docs (Alistair Popple)
>=20
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Fixes: 1afaeb8293c9 ("mm/migrate: Trylock device page in
> do_swap_page")
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: <dri-devel@lists.freedesktop.org>
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.15+
> Reviewed-by: John Hubbard <jhubbard@nvidia.com> #v3
> ---
> =C2=A0include/linux/migrate.h |=C2=A0 8 +++++++-
> =C2=A0mm/filemap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 15 ++++++++++-----
> =C2=A0mm/memory.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0mm/migrate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A0mm/migrate_device.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A05 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 26ca00c325d9..3cc387f1957d 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -65,7 +65,7 @@ bool isolate_folio_to_list(struct folio *folio,
> struct list_head *list);
> =C2=A0
> =C2=A0int migrate_huge_page_move_mapping(struct address_space *mapping,
> =C2=A0		struct folio *dst, struct folio *src);
> -void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t
> *ptl)
> +void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t
> *ptl)
> =C2=A0		__releases(ptl);
> =C2=A0void folio_migrate_flags(struct folio *newfolio, struct folio
> *folio);
> =C2=A0int folio_migrate_mapping(struct address_space *mapping,
> @@ -97,6 +97,12 @@ static inline int set_movable_ops(const struct
> movable_operations *ops, enum pag
> =C2=A0	return -ENOSYS;
> =C2=A0}
> =C2=A0
> +static inline void softleaf_entry_wait_on_locked(softleaf_t entry,
> spinlock_t *ptl)
> +	__releases(ptl)
> +{
> +	spin_unlock(ptl);
> +}
> +
> =C2=A0#endif /* CONFIG_MIGRATION */
> =C2=A0
> =C2=A0#ifdef CONFIG_NUMA_BALANCING
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ebd75684cb0a..d98e4883f13d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1379,14 +1379,16 @@ static inline int
> folio_wait_bit_common(struct folio *folio, int bit_nr,
> =C2=A0
> =C2=A0#ifdef CONFIG_MIGRATION
> =C2=A0/**
> - * migration_entry_wait_on_locked - Wait for a migration entry to be
> removed
> - * @entry: migration swap entry.
> + * softleaf_entry_wait_on_locked - Wait for a migration entry or
> + * device_private entry to be removed.
> + * @entry: migration or device_private swap entry.
> =C2=A0 * @ptl: already locked ptl. This function will drop the lock.
> =C2=A0 *
> - * Wait for a migration entry referencing the given page to be
> removed. This is
> + * Wait for a migration entry referencing the given page, or
> device_private
> + * entry referencing a dvice_private page to be unlocked. This is
> =C2=A0 * equivalent to folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE)
> except
> =C2=A0 * this can be called without taking a reference on the page.
> Instead this
> - * should be called while holding the ptl for the migration entry
> referencing
> + * should be called while holding the ptl for @entry referencing
> =C2=A0 * the page.
> =C2=A0 *
> =C2=A0 * Returns after unlocking the ptl.
> @@ -1394,7 +1396,7 @@ static inline int folio_wait_bit_common(struct
> folio *folio, int bit_nr,
> =C2=A0 * This follows the same logic as folio_wait_bit_common() so see th=
e
> comments
> =C2=A0 * there.
> =C2=A0 */
> -void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t
> *ptl)
> +void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t
> *ptl)
> =C2=A0	__releases(ptl)
> =C2=A0{
> =C2=A0	struct wait_page_queue wait_page;
> @@ -1428,6 +1430,9 @@ void migration_entry_wait_on_locked(softleaf_t
> entry, spinlock_t *ptl)
> =C2=A0	 * If a migration entry exists for the page the migration
> path must hold
> =C2=A0	 * a valid reference to the page, and it must take the ptl
> to remove the
> =C2=A0	 * migration entry. So the page is valid until the ptl is
> dropped.
> +	 * Similarly any path attempting to drop the last reference
> to a
> +	 * device-private page needs to grab the ptl to remove the
> device-private
> +	 * entry.
> =C2=A0	 */
> =C2=A0	spin_unlock(ptl);
> =C2=A0
> diff --git a/mm/memory.c b/mm/memory.c
> index da360a6eb8a4..20172476a57f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4684,7 +4684,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> =C2=A0				unlock_page(vmf->page);
> =C2=A0				put_page(vmf->page);
> =C2=A0			} else {
> -				pte_unmap_unlock(vmf->pte, vmf-
> >ptl);
> +				pte_unmap(vmf->pte);
> +				softleaf_entry_wait_on_locked(entry,
> vmf->ptl);
> =C2=A0			}
> =C2=A0		} else if (softleaf_is_hwpoison(entry)) {
> =C2=A0			ret =3D VM_FAULT_HWPOISON;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4688b9e38cd2..cf6449b4202e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -499,7 +499,7 @@ void migration_entry_wait(struct mm_struct *mm,
> pmd_t *pmd,
> =C2=A0	if (!softleaf_is_migration(entry))
> =C2=A0		goto out;
> =C2=A0
> -	migration_entry_wait_on_locked(entry, ptl);
> +	softleaf_entry_wait_on_locked(entry, ptl);
> =C2=A0	return;
> =C2=A0out:
> =C2=A0	spin_unlock(ptl);
> @@ -531,10 +531,10 @@ void migration_entry_wait_huge(struct
> vm_area_struct *vma, unsigned long addr, p
> =C2=A0		 * If migration entry existed, safe to release vma
> lock
> =C2=A0		 * here because the pgtable page won't be freed
> without the
> =C2=A0		 * pgtable lock released.=C2=A0 See comment right above
> pgtable
> -		 * lock release in migration_entry_wait_on_locked().
> +		 * lock release in softleaf_entry_wait_on_locked().
> =C2=A0		 */
> =C2=A0		hugetlb_vma_unlock_read(vma);
> -		migration_entry_wait_on_locked(entry, ptl);
> +		softleaf_entry_wait_on_locked(entry, ptl);
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> @@ -552,7 +552,7 @@ void pmd_migration_entry_wait(struct mm_struct
> *mm, pmd_t *pmd)
> =C2=A0	ptl =3D pmd_lock(mm, pmd);
> =C2=A0	if (!pmd_is_migration_entry(*pmd))
> =C2=A0		goto unlock;
> -	migration_entry_wait_on_locked(softleaf_from_pmd(*pmd),
> ptl);
> +	softleaf_entry_wait_on_locked(softleaf_from_pmd(*pmd), ptl);
> =C2=A0	return;
> =C2=A0unlock:
> =C2=A0	spin_unlock(ptl);
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 23379663b1e1..deab89fd4541 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -176,7 +176,7 @@ static int migrate_vma_collect_huge_pmd(pmd_t
> *pmdp, unsigned long start,
> =C2=A0		}
> =C2=A0
> =C2=A0		if (softleaf_is_migration(entry)) {
> -			migration_entry_wait_on_locked(entry, ptl);
> +			softleaf_entry_wait_on_locked(entry, ptl);
> =C2=A0			spin_unlock(ptl);
> =C2=A0			return -EAGAIN;
> =C2=A0		}

