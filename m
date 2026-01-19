Return-Path: <stable+bounces-210402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD88D3B870
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 21:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F85D3046DAC
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFA32EC54C;
	Mon, 19 Jan 2026 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cxRQFFdq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA923F431;
	Mon, 19 Jan 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854655; cv=none; b=bvppOIWUyRT8hvJWZTVb8am9l6LsZfB9MFYJ+L4w1ERBROebn8xcrCTeb+DeUeUFl7KWJQ1sk1bh1EzojAcnc/lAzR5O4Y/AO8ILe5XG4GlzTphS0IdXAyN6JbfLiy6Tj/piF736CJmOP8g+jHrHPkQC8Wwp3EVwoqMhvp1dJpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854655; c=relaxed/simple;
	bh=R57FQTCTmIxrt5+ejU5fbGLnQES3MDAEyI81aaKe/ZI=;
	h=Date:To:From:Subject:Message-Id; b=BcnYW5RPAICfhOwYuIOaXjF1WSUtrq7f8FBS4/2kFK3SeQCnh0Ohblcb1ySTpoGa+z2vK9SrymmnV7OdU1eQQEuYLqZUBRFxD/hD09HGzFiJU7j6iuI4ViVYIf3fg1g9PW7CuW0BStBcYulDDwLDuC5Q2RLxyId7Lea3UcBIUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cxRQFFdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AE8C116C6;
	Mon, 19 Jan 2026 20:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768854654;
	bh=R57FQTCTmIxrt5+ejU5fbGLnQES3MDAEyI81aaKe/ZI=;
	h=Date:To:From:Subject:From;
	b=cxRQFFdqrFA29SjQCbZfvfVIcBGrJnuKbdgRQZt6bM8Vi0EkfaUQUn6MuvLxNzaO6
	 bG6EJZ/usAmV+Niyvmqe+KpMgTrTIWKR6p1oJ2icU/ZD7h/sDvlXBtn9dhe1qI7/vK
	 ydV4pMEvGauLmCYOzScrASO1N8lwX9QnswBZDJUo=
Date: Mon, 19 Jan 2026 12:30:53 -0800
To: mm-commits@vger.kernel.org,surenb@google.com,stable@vger.kernel.org,rppt@kernel.org,pratyush@kernel.org,pasha.tatashin@soleen.com,graf@amazon.com,ran.xiaokai@zte.com.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] kho-init-alloc-tags-when-restoring-pages-from-reserved-memory.patch removed from -mm tree
Message-Id: <20260119203054.70AE8C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: kho: init alloc tags when restoring pages from reserved memory
has been removed from the -mm tree.  Its filename was
     kho-init-alloc-tags-when-restoring-pages-from-reserved-memory.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: kho: init alloc tags when restoring pages from reserved memory
Date: Fri, 9 Jan 2026 10:42:51 +0000

Memblock pages (including reserved memory) should have their allocation
tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
released to the page allocator.  When kho restores pages through
kho_restore_page(), missing this call causes mismatched
allocation/deallocation tracking and below warning message:

alloc_tag was not set
WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
RIP: 0010:___free_pages+0xb8/0x260
 kho_restore_vmalloc+0x187/0x2e0
 kho_test_init+0x3c4/0xa30
 do_one_initcall+0x62/0x2b0
 kernel_init_freeable+0x25b/0x480
 kernel_init+0x1a/0x1c0
 ret_from_fork+0x2d1/0x360

Add missing clear_page_tag_ref() annotation in kho_restore_page() to
fix this.

Link: https://lkml.kernel.org/r/20260113033403.161869-1-ranxiaokai627@163.com
Link: https://lkml.kernel.org/r/20260109104251.157767-1-ranxiaokai627@163.com
Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/liveupdate/kexec_handover.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/liveupdate/kexec_handover.c~kho-init-alloc-tags-when-restoring-pages-from-reserved-memory
+++ a/kernel/liveupdate/kexec_handover.c
@@ -255,6 +255,7 @@ static struct page *kho_restore_page(phy
 	if (is_folio && info.order)
 		prep_compound_page(page, info.order);
 
+	clear_page_tag_ref(page);
 	adjust_managed_page_count(page, nr_pages);
 	return page;
 }
_

Patches currently in -mm which might be from ran.xiaokai@zte.com.cn are

alloc_tag-fix-rw-permission-issue-when-handling-boot-parameter.patch


