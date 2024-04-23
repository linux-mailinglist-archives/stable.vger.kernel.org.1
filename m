Return-Path: <stable+bounces-40702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474418AE7A1
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F2C284E46
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC63D134CC8;
	Tue, 23 Apr 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YHy8Ou6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E7131BBD
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877843; cv=none; b=LtRqE/caXECTh9Lx0OdZKzTNfP3pC/a8rMwlbzwX3iEJ35SjrwqeG9Zf0h8TKl/QmB2W4QNhsPgGnvsPPmcT/9dMIs5E6iBCkYghSoBrAh/BbUbYIdPM2G30PpR0Lr5vitOH0pWc9Cerzh/31BtvKy0oxUaz40VnGYsRHCbdTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877843; c=relaxed/simple;
	bh=o0eOYppfQD97D3jzKQctdp5EM8ijLZgBTaKkGNCH5IU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fqIMhw95Yi8x0IYYknMoMCPs9BqUnbJbppznhYsMrAU5yZYuiIVuYhCy74g+8TUMUXcf/Pj5EUsUmpmnh6fGnXxSOR82KXINLq9OGDfUZyTIlXus1Svby9ROpAI8DrdTK4TJAINR+X159A3GCGzwoMsXLUUNzadj8VAjQEJVM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YHy8Ou6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE19C2BD11;
	Tue, 23 Apr 2024 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877843;
	bh=o0eOYppfQD97D3jzKQctdp5EM8ijLZgBTaKkGNCH5IU=;
	h=Subject:To:Cc:From:Date:From;
	b=YHy8Ou6lwsChXX0tr5DTv0FYDaIWvcXe7UFZRI3W6FGVJgKv7DqKNxpX2nbx5loB1
	 i2jvFb3NJ001xPy62T0nHWWpuqOY4+r7bK2DWuKfh9ivL5DMk7awyHaI9L9r67AYTO
	 RIlQ+FowN58k1AIv3FWFAcVwqw/rfS9Nwyem1Hs4=
Subject: FAILED: patch "[PATCH] userfaultfd: change src_folio after ensuring it's unpinned in" failed to apply to 6.8-stable tree
To: lokeshgidra@google.com,aarcange@redhat.com,akpm@linux-foundation.org,david@redhat.com,kaleshsingh@google.com,ngeoffray@google.com,peterx@redhat.com,stable@vger.kernel.org,willy@infradead.org,zhengqi.arch@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:10:34 -0700
Message-ID: <2024042334-agenda-nutlike-cb77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x c0205eaf3af9f5db14d4b5ee4abacf4a583c3c50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042334-agenda-nutlike-cb77@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

c0205eaf3af9 ("userfaultfd: change src_folio after ensuring it's unpinned in UFFDIO_MOVE")
eb1521dad8f3 ("userfaultfd: handle zeropage moves by UFFDIO_MOVE")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0205eaf3af9f5db14d4b5ee4abacf4a583c3c50 Mon Sep 17 00:00:00 2001
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 4 Apr 2024 10:17:26 -0700
Subject: [PATCH] userfaultfd: change src_folio after ensuring it's unpinned in
 UFFDIO_MOVE

Commit d7a08838ab74 ("mm: userfaultfd: fix unexpected change to src_folio
when UFFDIO_MOVE fails") moved the src_folio->{mapping, index} changing to
after clearing the page-table and ensuring that it's not pinned.  This
avoids failure of swapout+migration and possibly memory corruption.

However, the commit missed fixing it in the huge-page case.

Link: https://lkml.kernel.org/r/20240404171726.2302435-1-lokeshgidra@google.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Nicolas Geoffray <ngeoffray@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..89f58c7603b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2259,9 +2259,6 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 			goto unlock_ptls;
 		}
 
-		folio_move_anon_rmap(src_folio, dst_vma);
-		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
-
 		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
 		/* Folio got pinned from under us. Put it back and fail the move. */
 		if (folio_maybe_dma_pinned(src_folio)) {
@@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 			goto unlock_ptls;
 		}
 
+		folio_move_anon_rmap(src_folio, dst_vma);
+		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+
 		_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
 		/* Follow mremap() behavior and treat the entry dirty after the move */
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);


