Return-Path: <stable+bounces-4878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84793807CCB
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CD31C20C26
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74119367;
	Thu,  7 Dec 2023 00:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h1N6lD4p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B77E
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A831FC433CB;
	Thu,  7 Dec 2023 00:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701908006;
	bh=2zpaHtZor9sLB7UMb+Hwt1DCdR/acDreEKpsJpXc348=;
	h=Date:To:From:Subject:From;
	b=h1N6lD4p8p5G+Usgwm+ZJUcAdp16AcAi1BdhD+MKrMqapeBHb1u+IvXB1Ccr0GvTg
	 AG+FvoQwCt/41L02bNRlKQUOL/ikea8zhJi9RjjI1s5CkdSiZKIi1KMApf+a8qHEji
	 eIfWXfwWxt8q6Ii93P0kbqoAMaXSYhA9jd+eRvLs=
Date: Wed, 06 Dec 2023 16:13:26 -0800
To: mm-commits@vger.kernel.org,willy@infradead.org,stable@vger.kernel.org,kirill.shutemov@linux.intel.com,jose.pekkarinen@foxhound.fi,jannh@google.com,david@redhat.com,hughd@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-fix-oops-when-filemap_map_pmd-without-prealloc_pte.patch removed from -mm tree
Message-Id: <20231207001326.A831FC433CB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: fix oops when filemap_map_pmd() without prealloc_pte
has been removed from the -mm tree.  Its filename was
     mm-fix-oops-when-filemap_map_pmd-without-prealloc_pte.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Hugh Dickins <hughd@google.com>
Subject: mm: fix oops when filemap_map_pmd() without prealloc_pte
Date: Fri, 17 Nov 2023 00:49:18 -0800 (PST)

syzbot reports oops in lockdep's __lock_acquire(), called from
__pte_offset_map_lock() called from filemap_map_pages(); or when I run the
repro, the oops comes in pmd_install(), called from filemap_map_pmd()
called from filemap_map_pages(), just before the __pte_offset_map_lock().

The problem is that filemap_map_pmd() has been assuming that when it finds
pmd_none(), a page table has already been prepared in prealloc_pte; and
indeed do_fault_around() has been careful to preallocate one there, when
it finds pmd_none(): but what if *pmd became none in between?

My 6.6 mods in mm/khugepaged.c, avoiding mmap_lock for write, have made it
easy for *pmd to be cleared while servicing a page fault; but even before
those, a huge *pmd might be zapped while a fault is serviced.

The difference in symptomatic stack traces comes from the "memory model"
in use: pmd_install() uses pmd_populate() uses page_to_pfn(): in some
models that is strict, and will oops on the NULL prealloc_pte; in other
models, it will construct a bogus value to be populated into *pmd, then
__pte_offset_map_lock() oops when trying to access split ptlock pointer
(or some other symptom in normal case of ptlock embedded not pointer).

Link: https://lore.kernel.org/linux-mm/20231115065506.19780-1-jose.pekkarinen@foxhound.fi/
Link: https://lkml.kernel.org/r/6ed0c50c-78ef-0719-b3c5-60c0c010431c@google.com
Fixes: f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/0000000000005e44550608a0806c@google.com/
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>,
Cc: José Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>    [5.12+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/filemap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/filemap.c~mm-fix-oops-when-filemap_map_pmd-without-prealloc_pte
+++ a/mm/filemap.c
@@ -3371,7 +3371,7 @@ static bool filemap_map_pmd(struct vm_fa
 		}
 	}
 
-	if (pmd_none(*vmf->pmd))
+	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
 		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
 
 	return false;
_

Patches currently in -mm which might be from hughd@google.com are



