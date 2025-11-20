Return-Path: <stable+bounces-195323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E3C7554C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55A524F2AF1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4836212C;
	Thu, 20 Nov 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ovRxP+Cd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9D34E74B
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655100; cv=none; b=ezj63Gr+sXODgN4GXCcA/4KgVR9YQVD9jpcDvye3pPA7ySO4FGinvKZfv2OsSwgkoix6rPWdi/p84u4z2EfxuKWytwsiLFt4tz2cLS6sJon9ZOWPjPdvoQGhy90qqocKjieoyrncSRUwRH0dEOnlfDYKldMYWcQC2IJRPT6qGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655100; c=relaxed/simple;
	bh=c0+6uVIEdZP32L1tqmuNqzuVWO8rBgvTumxLW+72DWU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z6OOOidPGE+fTmrDldzUyhajtTFvFubvYd5TqGFiX42JGFNQgRHUow2VAPv98EyjpHMgwBVULt6fHxnmvV/SFOKKZBE7SNt++ATCvdCiTg/BWZF/TiLteQOSzLvHUsyEcD0RmVh3OYjs6Ome1fMG3DYqawTGTW24vvtPVlzH/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ovRxP+Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A6C4CEF1;
	Thu, 20 Nov 2025 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655098;
	bh=c0+6uVIEdZP32L1tqmuNqzuVWO8rBgvTumxLW+72DWU=;
	h=Subject:To:Cc:From:Date:From;
	b=ovRxP+CdSYLpVoJ16pSPzEd4L1hQ5zscV2TCF8SxfsJzxuOWWTWCbeF4fol9NywvA
	 rJ9wg6Qpm1EmwC+DdWlB37m5LdP602s6vGzA32why9/gREae8aIo8qKe7UC/TketXe
	 L+z2rTVZFo1w3a3e8I/Wechbv6IQs/M0RxCCPoik=
Subject: FAILED: patch "[PATCH] mm/secretmem: fix use-after-free race in fault handler" failed to apply to 5.15-stable tree
To: lance.yang@linux.dev,akpm@linux-foundation.org,big-sleep-vuln-reports@google.com,david@redhat.com,lorenzo.stoakes@oracle.com,rppt@kernel.org,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:11:23 +0100
Message-ID: <2025112023-overact-rehydrate-ae42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6f86d0534fddfbd08687fa0f01479d4226bc3c3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112023-overact-rehydrate-ae42@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f86d0534fddfbd08687fa0f01479d4226bc3c3d Mon Sep 17 00:00:00 2001
From: Lance Yang <lance.yang@linux.dev>
Date: Fri, 31 Oct 2025 20:09:55 +0800
Subject: [PATCH] mm/secretmem: fix use-after-free race in fault handler

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new folio for it, mark the
underlying page as not-present in the direct map, and add it to the file
mapping.

If two tasks cause a fault in the same page concurrently, both could end
up allocating a folio and removing the page from the direct map, but only
one would succeed in adding the folio to the file mapping.  The task that
failed undoes the effects of its attempt by (a) freeing the folio again
and (b) putting the page back into the direct map.  However, by doing
these two operations in this order, the page becomes available to the
allocator again before it is placed back in the direct mapping.

If another task attempts to allocate the page between (a) and (b), and the
kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.

Fix the ordering to restore the direct map before the folio is freed.

Link: https://lkml.kernel.org/r/20251031120955.92116-1-lance.yang@linux.dev
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..b59350daffe3 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
-			folio_put(folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(folio_page(folio, 0));
+			folio_put(folio);
 			if (err == -EEXIST)
 				goto retry;
 


