Return-Path: <stable+bounces-233375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL86G/6s02nHkAcAu9opvQ
	(envelope-from <stable+bounces-233375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 14:54:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A23A365E
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F523012EB1
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDD236F42C;
	Mon,  6 Apr 2026 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqXfamBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D736E487;
	Mon,  6 Apr 2026 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775480056; cv=none; b=EvnJW4qOcsb+gJCgHTCDpMkapHTIzdyoFXSlWtQkDd9P3fe1R04OHcVntfFx58/XMKeH6PgtNBSM7hFOus7zXn6SUGqFg1BkyMRYqiZpiYYDwLQ77qNrRw1fYkzTNyfzUNhrMvo1uOJ7z7z2i80t+v1BXWLzoTN89v74ofdrFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775480056; c=relaxed/simple;
	bh=lmE4691xD8knfB5Qasc9kqe2NEgfhceQd9mqYaNZSg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqEP5IRLd5gddvQv7dlGrjDLAIiRVF6dpkMDskZdD98olU5krvLLsig61CQjqSD+fSmuNLDko93lGOKSMQd5pcbp3Pb2F5u5IKazSsUZrYQhEKtpbxH+caw828wHkt6+rYeAdx3sozcLA+ek7xrDBWh/8+YxWk2hC8uGKyf77JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqXfamBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F839C4CEF7;
	Mon,  6 Apr 2026 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775480056;
	bh=lmE4691xD8knfB5Qasc9kqe2NEgfhceQd9mqYaNZSg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqXfamBMiO+cbLoEGuW6uTNbJ99c6BU05Y3w7YvRuPst2gGOuyr1shCiZ2tLlUvqE
	 9FB1hwefQoxk98pRkBOjMpgAQJplh58S8Qk9J1aJqWZYToVDi+kgmJTtTfVmAtE772
	 peaTipxc3+YTMfhQNey2BcKc8LG9c3Fy1mv7/bWPmnFayV5svW9JTvi/DhlngTBVc7
	 kXV6ycNx5Nd9Epyd8bxLC8lRwXdhlSLDIDmxFGDglgIvrhm9zsGPbV7w62nJfrWdr7
	 qvmg0gzmNxj22TedBleto/Ot5KmJs4NJ07WxmfSQmNj9NZNZVV7juxUrfaq/FJwVlp
	 t+3afvVxm5O8w==
Date: Mon, 6 Apr 2026 13:54:13 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>, 
	Ralph Campbell <rcampbell@nvidia.com>, Christoph Hellwig <hch@lst.de>, 
	Jason Gunthorpe <jgg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-ID: <adOqU0UDzpxvQuwA@lucifer>
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233375-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,nvidia.com,lst.de,mellanox.com,ziepe.ca,kernel.org,linux-foundation.org,intel.com,kvack.org,vger.kernel.org,gmail.com,sk.com,gourry.net,linux.alibaba.com,infradead.org,oracle.com,google.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF6A23A365E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi guys,

+cc missing M/R, fsdevel list

So this was merged upstream, and touches mm/, and even has a mm:
prefix... but was taken through a non-mm tree.

I'm confused as to why an mm: patch didn't go through the mm tree, but when
we do stuff like this, isn't the done thing to get maintainer signoff
before doing something like that, anyway?

I see John gave a tag (and he's great so that gives me confidence here),
but we should really follow the procedure on this properly.

So:

$ scripts/get_maintainer.pl --no-git include/linux/migrate.h mm/filemap.c mm/memory.c mm/migrate.c mm/migrate_device.c | grep maintainer
Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT - MEMORY POLICY AND MIGRATION)
David Hildenbrand <david@kernel.org> (maintainer:MEMORY MANAGEMENT - MEMORY POLICY AND MIGRATION)
"Matthew Wilcox (Oracle)" <willy@infradead.org> (maintainer:PAGE CACHE)

Are the maintainers, and there are also 14 reviewers too.

None were even cc'd here which isn't helpful :)

I realise mm process has _perhaps_ not been quite so prescriptive as this
in the past, but we definitely require this going forward, and in general
you should run get_maintainers.pl and cc relevant people to help with the
pain that is kernel email :)

As I don't _think_ anybody noticed it, unfortunately. linux-mm is just too
busy to keep track there, generally.

We are semi-tetchy about this as we've had... fun in the past with some
bigger changes that went through other trees. This is, at least, very
isolated.

Thanks, Lorenzo

On Tue, Feb 10, 2026 at 12:56:53PM +0100, Thomas Hellström wrote:
> If hmm_range_fault() fails a folio_trylock() in do_swap_page,
> trying to acquire the lock of a device-private folio for migration,
> to ram, the function will spin until it succeeds grabbing the lock.
>
> However, if the process holding the lock is depending on a work
> item to be completed, which is scheduled on the same CPU as the
> spinning hmm_range_fault(), that work item might be starved and
> we end up in a livelock / starvation situation which is never
> resolved.
>
> This can happen, for example if the process holding the
> device-private folio lock is stuck in
>    migrate_device_unmap()->lru_add_drain_all()
> sinc lru_add_drain_all() requires a short work-item
> to be run on all online cpus to complete.
>
> A prerequisite for this to happen is:
> a) Both zone device and system memory folios are considered in
>    migrate_device_unmap(), so that there is a reason to call
>    lru_add_drain_all() for a system memory folio while a
>    folio lock is held on a zone device folio.
> b) The zone device folio has an initial mapcount > 1 which causes
>    at least one migration PTE entry insertion to be deferred to
>    try_to_migrate(), which can happen after the call to
>    lru_add_drain_all().
> c) No or voluntary only preemption.
>
> This all seems pretty unlikely to happen, but indeed is hit by
> the "xe_exec_system_allocator" igt test.
>
> Resolve this by waiting for the folio to be unlocked if the
> folio_trylock() fails in do_swap_page().
>
> Rename migration_entry_wait_on_locked() to
> softleaf_entry_wait_unlock() and update its documentation to
> indicate the new use-case.
>
> Future code improvements might consider moving
> the lru_add_drain_all() call in migrate_device_unmap() to be
> called *after* all pages have migration entries inserted.
> That would eliminate also b) above.
>
> v2:
> - Instead of a cond_resched() in hmm_range_fault(),
>   eliminate the problem by waiting for the folio to be unlocked
>   in do_swap_page() (Alistair Popple, Andrew Morton)
> v3:
> - Add a stub migration_entry_wait_on_locked() for the
>   !CONFIG_MIGRATION case. (Kernel Test Robot)
> v4:
> - Rename migrate_entry_wait_on_locked() to
>   softleaf_entry_wait_on_locked() and update docs (Alistair Popple)
> v5:
> - Add a WARN_ON_ONCE() for the !CONFIG_MIGRATION
>   version of softleaf_entry_wait_on_locked().
> - Modify wording around function names in the commit message
>   (Andrew Morton)
>
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Fixes: 1afaeb8293c9 ("mm/migrate: Trylock device page in do_swap_page")
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
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.15+
> Reviewed-by: John Hubbard <jhubbard@nvidia.com> #v3
> ---
>  include/linux/migrate.h | 10 +++++++++-
>  mm/filemap.c            | 15 ++++++++++-----
>  mm/memory.c             |  3 ++-
>  mm/migrate.c            |  8 ++++----
>  mm/migrate_device.c     |  2 +-
>  5 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 26ca00c325d9..d5af2b7f577b 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -65,7 +65,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list);
>
>  int migrate_huge_page_move_mapping(struct address_space *mapping,
>  		struct folio *dst, struct folio *src);
> -void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
> +void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
>  		__releases(ptl);
>  void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
>  int folio_migrate_mapping(struct address_space *mapping,
> @@ -97,6 +97,14 @@ static inline int set_movable_ops(const struct movable_operations *ops, enum pag
>  	return -ENOSYS;
>  }
>
> +static inline void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
> +	__releases(ptl)
> +{
> +	WARN_ON_ONCE(1);
> +
> +	spin_unlock(ptl);
> +}
> +
>  #endif /* CONFIG_MIGRATION */
>
>  #ifdef CONFIG_NUMA_BALANCING
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ebd75684cb0a..d98e4883f13d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1379,14 +1379,16 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>
>  #ifdef CONFIG_MIGRATION
>  /**
> - * migration_entry_wait_on_locked - Wait for a migration entry to be removed
> - * @entry: migration swap entry.
> + * softleaf_entry_wait_on_locked - Wait for a migration entry or
> + * device_private entry to be removed.
> + * @entry: migration or device_private swap entry.
>   * @ptl: already locked ptl. This function will drop the lock.
>   *
> - * Wait for a migration entry referencing the given page to be removed. This is
> + * Wait for a migration entry referencing the given page, or device_private
> + * entry referencing a dvice_private page to be unlocked. This is
>   * equivalent to folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE) except
>   * this can be called without taking a reference on the page. Instead this
> - * should be called while holding the ptl for the migration entry referencing
> + * should be called while holding the ptl for @entry referencing
>   * the page.
>   *
>   * Returns after unlocking the ptl.
> @@ -1394,7 +1396,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
>   * This follows the same logic as folio_wait_bit_common() so see the comments
>   * there.
>   */
> -void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
> +void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
>  	__releases(ptl)

I mean I have to say though I'm happy you propagated the softleaf thing
further at least ;)

>  {
>  	struct wait_page_queue wait_page;
> @@ -1428,6 +1430,9 @@ void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
>  	 * If a migration entry exists for the page the migration path must hold
>  	 * a valid reference to the page, and it must take the ptl to remove the
>  	 * migration entry. So the page is valid until the ptl is dropped.
> +	 * Similarly any path attempting to drop the last reference to a
> +	 * device-private page needs to grab the ptl to remove the device-private
> +	 * entry.
>  	 */
>  	spin_unlock(ptl);
>
> diff --git a/mm/memory.c b/mm/memory.c
> index da360a6eb8a4..20172476a57f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4684,7 +4684,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				unlock_page(vmf->page);
>  				put_page(vmf->page);
>  			} else {
> -				pte_unmap_unlock(vmf->pte, vmf->ptl);
> +				pte_unmap(vmf->pte);
> +				softleaf_entry_wait_on_locked(entry, vmf->ptl);
>  			}
>  		} else if (softleaf_is_hwpoison(entry)) {
>  			ret = VM_FAULT_HWPOISON;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4688b9e38cd2..cf6449b4202e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -499,7 +499,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
>  	if (!softleaf_is_migration(entry))
>  		goto out;
>
> -	migration_entry_wait_on_locked(entry, ptl);
> +	softleaf_entry_wait_on_locked(entry, ptl);
>  	return;
>  out:
>  	spin_unlock(ptl);
> @@ -531,10 +531,10 @@ void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, p
>  		 * If migration entry existed, safe to release vma lock
>  		 * here because the pgtable page won't be freed without the
>  		 * pgtable lock released.  See comment right above pgtable
> -		 * lock release in migration_entry_wait_on_locked().
> +		 * lock release in softleaf_entry_wait_on_locked().
>  		 */
>  		hugetlb_vma_unlock_read(vma);
> -		migration_entry_wait_on_locked(entry, ptl);
> +		softleaf_entry_wait_on_locked(entry, ptl);
>  		return;
>  	}
>
> @@ -552,7 +552,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>  	ptl = pmd_lock(mm, pmd);
>  	if (!pmd_is_migration_entry(*pmd))
>  		goto unlock;
> -	migration_entry_wait_on_locked(softleaf_from_pmd(*pmd), ptl);
> +	softleaf_entry_wait_on_locked(softleaf_from_pmd(*pmd), ptl);
>  	return;
>  unlock:
>  	spin_unlock(ptl);
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 23379663b1e1..deab89fd4541 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -176,7 +176,7 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
>  		}
>
>  		if (softleaf_is_migration(entry)) {
> -			migration_entry_wait_on_locked(entry, ptl);
> +			softleaf_entry_wait_on_locked(entry, ptl);
>  			spin_unlock(ptl);
>  			return -EAGAIN;
>  		}
> --
> 2.52.0
>
>

