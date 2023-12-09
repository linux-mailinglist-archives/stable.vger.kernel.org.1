Return-Path: <stable+bounces-5178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E580B5FC
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 20:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66070281029
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37219BD0;
	Sat,  9 Dec 2023 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NmAenHVy"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5977D1BB
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hi2WBFEIOsD7ADtk/1pkq73vsJ0MLNvEbtKDv1om3Rc=; b=NmAenHVyEXJvyACRgp56dIGPcV
	ZIdAidQan/JWZ/pGP7wvWpPEr7LpBGcpSOAFjxrDzZ/8tR57b0pxdkHZJKCbnJPpvccuD3trFPL5D
	erSy1Xax5zIeNpbUzoQcaGrhlsx8sDBgLgSOVlAmjj9L/TreaELkPGXTikKABlDgGEWkjiqHyIvOZ
	ZXgXsvGf2cHMxmPJOfJV9i6at3l2UIYbZN5aq0pKsqgysewxXmiBlmvTMXgXzHxNaugugMJk6AHnz
	WgOHucXzDEz7V9pApa+BCHxwRcRAjmjMgsUkgqwc7vwjQPHXrX0f8AWlDxpTXBip9TpzytawLQ2Gs
	qYXW5ySw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rC2k3-007SMH-C4; Sat, 09 Dec 2023 19:11:59 +0000
Date: Sat, 9 Dec 2023 19:11:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: gregkh@linuxfoundation.org
Cc: hughd@google.com, akpm@linux-foundation.org, david@redhat.com,
	jannh@google.com, jose.pekkarinen@foxhound.fi,
	kirill.shutemov@linux.intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: fix oops when filemap_map_pmd()
 without prealloc_pte" failed to apply to 5.15-stable tree
Message-ID: <ZXS7/8jHrj8XFUoA@casper.infradead.org>
References: <2023120945-citizen-library-9f46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023120945-citizen-library-9f46@gregkh>

On Sat, Dec 09, 2023 at 01:35:45PM +0100, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This should do the job.  It's not clear to me whether this bug remains
latent on 5.15, so it may not be appropriate to apply.  I defer to Hugh.

diff --git a/mm/filemap.c b/mm/filemap.c
index 81e28722edfa..84a5b0213e0e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3209,7 +3209,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	    }
 	}
 
-	if (pmd_none(*vmf->pmd)) {
+	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte) {
 		vmf->ptl = pmd_lock(mm, vmf->pmd);
 		if (likely(pmd_none(*vmf->pmd))) {
 			mm_inc_nr_ptes(mm);

> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 9aa1345d66b8132745ffb99b348b1492088da9e2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120945-citizen-library-9f46@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 9aa1345d66b8 ("mm: fix oops when filemap_map_pmd() without prealloc_pte")
> 03c4f20454e0 ("mm: introduce pmd_install() helper")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 9aa1345d66b8132745ffb99b348b1492088da9e2 Mon Sep 17 00:00:00 2001
> From: Hugh Dickins <hughd@google.com>
> Date: Fri, 17 Nov 2023 00:49:18 -0800
> Subject: [PATCH] mm: fix oops when filemap_map_pmd() without prealloc_pte
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> syzbot reports oops in lockdep's __lock_acquire(), called from
> __pte_offset_map_lock() called from filemap_map_pages(); or when I run the
> repro, the oops comes in pmd_install(), called from filemap_map_pmd()
> called from filemap_map_pages(), just before the __pte_offset_map_lock().
> 
> The problem is that filemap_map_pmd() has been assuming that when it finds
> pmd_none(), a page table has already been prepared in prealloc_pte; and
> indeed do_fault_around() has been careful to preallocate one there, when
> it finds pmd_none(): but what if *pmd became none in between?
> 
> My 6.6 mods in mm/khugepaged.c, avoiding mmap_lock for write, have made it
> easy for *pmd to be cleared while servicing a page fault; but even before
> those, a huge *pmd might be zapped while a fault is serviced.
> 
> The difference in symptomatic stack traces comes from the "memory model"
> in use: pmd_install() uses pmd_populate() uses page_to_pfn(): in some
> models that is strict, and will oops on the NULL prealloc_pte; in other
> models, it will construct a bogus value to be populated into *pmd, then
> __pte_offset_map_lock() oops when trying to access split ptlock pointer
> (or some other symptom in normal case of ptlock embedded not pointer).
> 
> Link: https://lore.kernel.org/linux-mm/20231115065506.19780-1-jose.pekkarinen@foxhound.fi/
> Link: https://lkml.kernel.org/r/6ed0c50c-78ef-0719-b3c5-60c0c010431c@google.com
> Fixes: f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/0000000000005e44550608a0806c@google.com/
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Jann Horn <jannh@google.com>,
> Cc: José Pekkarinen <jose.pekkarinen@foxhound.fi>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: <stable@vger.kernel.org>    [5.12+]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 32eedf3afd45..f1c8c278310f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3371,7 +3371,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
>  		}
>  	}
>  
> -	if (pmd_none(*vmf->pmd))
> +	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
>  		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
>  
>  	return false;
> 

