Return-Path: <stable+bounces-147934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3CAC65F2
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 11:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AFD1BC5849
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546082777EA;
	Wed, 28 May 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n+W2arJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PLgbUBee";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n+W2arJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PLgbUBee"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D85A79B
	for <stable@vger.kernel.org>; Wed, 28 May 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424474; cv=none; b=JUY+O8SLDbpXFgYFtrpv1DcaiHHHjTzPx+x0GKFLTGpV+b6tlS+baYv2al2Caf3iRtwmjzmUxHBmkHNZBrT0P64vUNQRbaxPulXxwuYNt/6Zm4MeF/b8ZwCrX1qVF1oFwIL2Z5qXKL//rC/P8BImxlL5Vd4O7gLJOGUO1pTFJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424474; c=relaxed/simple;
	bh=QA8Tu+x5uJNtSj2hb1PFx7cIXbvT0/ULNV68F0rxeTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atTwheflpXPl40RpSm2rTUT3TJAmfIKYvy0+b8k8VbW0S/YUsLgxBb1+s+HAekseHhCh4UB9y441DDmAp/+PPCOJWh/w98VWEprwyIeVA21GFRqo/13687ikK48a96K1AUNSTmFGFlLsVMfMCgTAT23u+XHtQPX7eymjCJ1YrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n+W2arJC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PLgbUBee; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n+W2arJC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PLgbUBee; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3959221BFC;
	Wed, 28 May 2025 09:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748424470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4mwwW9r0OHxt1yikCbUfXebtF5UgdxJ9FNgvzHDIfE=;
	b=n+W2arJC9K4LnK8d5fiG8AWGKKHDpg2CEWV2F7309g7HyeUKZS8KPrbC70sqLPwSwr2jZu
	F94CF4I9wfrIvAUic+im00Q29l49NvTK33VFQksiJuk+WfP27KHDdJ6S4RM/oqIiAOrbdE
	9KMGpN56EZlNIg3Quv9Zdg4WW5/vXSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748424470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4mwwW9r0OHxt1yikCbUfXebtF5UgdxJ9FNgvzHDIfE=;
	b=PLgbUBeeeE9X8XNwWP958G8cg9vwCEdd90usoWLBmPLRdkns9WWz6AyA7Mdc+WIgALZnUr
	f75JSjED5VJg2YAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748424470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4mwwW9r0OHxt1yikCbUfXebtF5UgdxJ9FNgvzHDIfE=;
	b=n+W2arJC9K4LnK8d5fiG8AWGKKHDpg2CEWV2F7309g7HyeUKZS8KPrbC70sqLPwSwr2jZu
	F94CF4I9wfrIvAUic+im00Q29l49NvTK33VFQksiJuk+WfP27KHDdJ6S4RM/oqIiAOrbdE
	9KMGpN56EZlNIg3Quv9Zdg4WW5/vXSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748424470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4mwwW9r0OHxt1yikCbUfXebtF5UgdxJ9FNgvzHDIfE=;
	b=PLgbUBeeeE9X8XNwWP958G8cg9vwCEdd90usoWLBmPLRdkns9WWz6AyA7Mdc+WIgALZnUr
	f75JSjED5VJg2YAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8073C136E3;
	Wed, 28 May 2025 09:27:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BQmlHBXXNmgyawAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 28 May 2025 09:27:49 +0000
Date: Wed, 28 May 2025 11:27:46 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	kernel-dev@igalia.com, stable@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, Florent Revest <revest@google.com>,
	Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aDbXEnqnpDnAx4Mw@localhost.localdomain>
References: <20250528023326.3499204-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528023326.3499204-1-gavinguo@igalia.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed, May 28, 2025 at 10:33:26AM +0800, Gavin Guo wrote:
> There is ABBA dead locking scenario happening between hugetlb_fault()
> and hugetlb_wp() on the pagecache folio's lock and hugetlb global mutex,
> which is reproducible with syzkaller [1]. As below stack traces reveal,
> process-1 tries to take the hugetlb global mutex (A3), but with the
> pagecache folio's lock hold. Process-2 took the hugetlb global mutex but
> tries to take the pagecache folio's lock.
> 
> Process-1                               Process-2
> =========                               =========
> hugetlb_fault
>    mutex_lock                  (A1)
>    filemap_lock_hugetlb_folio  (B1)
>    hugetlb_wp
>      alloc_hugetlb_folio       #error
>        mutex_unlock            (A2)
>                                         hugetlb_fault
>                                           mutex_lock                  (A4)
>                                           filemap_lock_hugetlb_folio  (B4)
>        unmap_ref_private
>        mutex_lock              (A3)
> 
> Fix it by releasing the pagecache folio's lock at (A2) of process-1 so
> that pagecache folio's lock is available to process-2 at (B4), to avoid
> the deadlock. In process-1, a new variable is added to track if the
> pagecache folio's lock has been released by its child function
> hugetlb_wp() to avoid double releases on the lock in hugetlb_fault().
> The similar changes are applied to hugetlb_no_page().
> 
> Link: https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link [1]
> Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
> Cc: <stable@vger.kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Florent Revest <revest@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
... 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6a3cf7935c14..560b9b35262a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6137,7 +6137,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>   * Keep the pte_same checks anyway to make transition from the mutex easier.
>   */
>  static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
> -		       struct vm_fault *vmf)
> +		       struct vm_fault *vmf,
> +		       bool *pagecache_folio_locked)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -6234,6 +6235,18 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  			u32 hash;
>  
>  			folio_put(old_folio);
> +			/*
> +			 * The pagecache_folio has to be unlocked to avoid
> +			 * deadlock and we won't re-lock it in hugetlb_wp(). The
> +			 * pagecache_folio could be truncated after being
> +			 * unlocked. So its state should not be reliable
> +			 * subsequently.
> +			 */
> +			if (pagecache_folio) {
> +				folio_unlock(pagecache_folio);
> +				if (pagecache_folio_locked)
> +					*pagecache_folio_locked = false;
> +			}

I am having a problem with this patch as I think it keeps carrying on an
assumption that it is not true.

I was discussing this matter yesterday with Peter Xu (CCed now), who has also some
experience in this field.

Exactly against what pagecache_folio's lock protects us when
pagecache_folio != old_folio?

There are two cases here:

1) pagecache_folio = old_folio  (original page in the pagecache)
2) pagecache_folio != old_folio (original page has already been mapped
                                 privately and CoWed, old_folio contains
				 the new folio)

For case 1), we need to hold the lock because we are copying old_folio
to the new one in hugetlb_wp(). That is clear.

But for case 2), unless I am missing something, we do not really need the
pagecache_folio's lock at all, do we? (only old_folio's one)
The only reason pagecache_folio gets looked up in the pagecache is to check
whether the current task has mapped and faulted in the file privately, which
means that a reservation has been consumed (a new folio was allocated).
That is what the whole dance about "old_folio != pagecache_folio &&
HPAGE_RESV_OWNER" in hugetlb_wp() is about.

And the original mapping cannot really go away either from under us, as
remove_inode_hugepages() needs to take the mutex in order to evict it,
which would be the only reason counters like resv_huge_pages (adjusted in
remove_inode_hugepages()->hugetlb_unreserve_pages()) would
interfere with alloc_hugetlb_folio() from hugetlb_wp().

So, again, unless I am missing something there is no need for the
pagecache_folio lock when pagecache_folio != old_folio, let alone the
need to hold it throughout hugetlb_wp().
I think we could just look up the cache, and unlock it right away.

So, the current situation (previous to this patch) is already misleading
for case 2).

And comments like:

 /*
  * The pagecache_folio has to be unlocked to avoid
  * deadlock and we won't re-lock it in hugetlb_wp(). The
  * pagecache_folio could be truncated after being
  * unlocked. So its state should not be reliable
  * subsequently.
  */

Keep carrying on the assumption that we need the lock.

Now, if the above is true, I would much rather see this reworked (I have
some ideas I discussed with Peter yesterday), than keep it as is.

Let me also CC David who tends to have a good overview in this.

-- 
Oscar Salvador
SUSE Labs

