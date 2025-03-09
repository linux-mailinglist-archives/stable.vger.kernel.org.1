Return-Path: <stable+bounces-121594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79089A586F2
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 19:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D36169A5F
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567627E105;
	Sun,  9 Mar 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zjRCqj1j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7E288DB
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544151; cv=none; b=qHkq4PLvbgU8f5yL7DrhoOap1McH2ieDbHsKkTBaH48jg/DVIV+SFskUExvhj9cOPsO702NUKcNLanp5jlfWVTrN/Q7vw2lumACu9kmagDoiX3mQZMJCE4oDdkBzV/EeB2Vs+EN+CmtVU83+lkQzjQglabz8zBbPCZjMqnLnoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544151; c=relaxed/simple;
	bh=Gv34yOzzpgtU6O9hnRckPPYpCFZKIV/ip29CTiyZsv4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j9rU7dGqnzEQc57rOz7qEVY/o547FlNp022qfZY3f6oJokCle53d92/FbfONRvCXi+AvMKubBzNRwtklrrMaz2nzOOh1NAGO6hzXzler1MdkmbaDpduWdnkMzEMFIs9ZEZfsu6El1TIT9e0dV0Gr7KFRZ1/qAguBCvKQw26N2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zjRCqj1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363F1C4CEE3;
	Sun,  9 Mar 2025 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741544150;
	bh=Gv34yOzzpgtU6O9hnRckPPYpCFZKIV/ip29CTiyZsv4=;
	h=Subject:To:Cc:From:Date:From;
	b=zjRCqj1jIt4HoEjff8mKPf0sh58FSxVOUCxnQzb2TU2nhBK65sY/GbBRWbcEFW8A2
	 sYLpM2chR/0Du2zpIdqcz90UX2Fbvcn9QWvYYyra+uzbOr21voOAC+7CDyuwi3xBEC
	 XCL88keFlxgpB4xCfHtYYw9Iz17C4ehVOdXSJzL4=
Subject: FAILED: patch "[PATCH] userfaultfd: fix PTE unmapping stack-allocated PTE copies" failed to apply to 6.13-stable tree
To: surenb@google.com,21cnbao@gmail.com,Liam.Howlett@Oracle.com,aarcange@redhat.com,akpm@linux-foundation.org,david@redhat.com,hughd@google.com,jannh@google.com,kaleshsingh@google.com,lokeshgidra@google.com,lorenzo.stoakes@oracle.com,peterx@redhat.com,stable@vger.kernel.org,v-songbaohua@oppo.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 19:15:47 +0100
Message-ID: <2025030947-disloyal-bust-0d23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 927e926d72d9155fde3264459fe9bfd7b5e40d28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030947-disloyal-bust-0d23@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 927e926d72d9155fde3264459fe9bfd7b5e40d28 Mon Sep 17 00:00:00 2001
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 26 Feb 2025 10:55:09 -0800
Subject: [PATCH] userfaultfd: fix PTE unmapping stack-allocated PTE copies

Current implementation of move_pages_pte() copies source and destination
PTEs in order to detect concurrent changes to PTEs involved in the move.
However these copies are also used to unmap the PTEs, which will fail if
CONFIG_HIGHPTE is enabled because the copies are allocated on the stack.
Fix this by using the actual PTEs which were kmap()ed.

Link: https://lkml.kernel.org/r/20250226185510.2732648-3-surenb@google.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index f5c6b3454f76..d06453fa8aba 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1290,8 +1290,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			spin_unlock(src_ptl);
 
 			if (!locked) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
+				pte_unmap(src_pte);
+				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				/* now we can block and wait */
 				folio_lock(src_folio);
@@ -1307,8 +1307,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		/* at this point we have src_folio locked */
 		if (folio_test_large(src_folio)) {
 			/* split_folio() can block */
-			pte_unmap(&orig_src_pte);
-			pte_unmap(&orig_dst_pte);
+			pte_unmap(src_pte);
+			pte_unmap(dst_pte);
 			src_pte = dst_pte = NULL;
 			err = split_folio(src_folio);
 			if (err)
@@ -1333,8 +1333,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				goto out;
 			}
 			if (!anon_vma_trylock_write(src_anon_vma)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
+				pte_unmap(src_pte);
+				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				/* now we can block and wait */
 				anon_vma_lock_write(src_anon_vma);
@@ -1352,8 +1352,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		entry = pte_to_swp_entry(orig_src_pte);
 		if (non_swap_entry(entry)) {
 			if (is_migration_entry(entry)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
+				pte_unmap(src_pte);
+				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				migration_entry_wait(mm, src_pmd, src_addr);
 				err = -EAGAIN;
@@ -1396,8 +1396,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			src_folio = folio;
 			src_folio_pte = orig_src_pte;
 			if (!folio_trylock(src_folio)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
+				pte_unmap(src_pte);
+				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				put_swap_device(si);
 				si = NULL;


