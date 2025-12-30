Return-Path: <stable+bounces-204178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D3CE8998
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3FDC30109B5
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9926B2494FE;
	Tue, 30 Dec 2025 02:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny3Wqblb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC71427A
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 02:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767063287; cv=none; b=taNUvAglSuJKNH48Wht+7qdLFX8DqhOiOsEKnwWlFs+7RMeOn4u6gZ+zw1kjGyG6IvDE8Db9gim/VK3V8CJ3XNteiIS79+TLU8rWw2whTsDwV7L++JARSiP87l2jVj68F+ySRoGwSE/MHrhTBnVMu1gDby7jkqOjnxp/0NSLjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767063287; c=relaxed/simple;
	bh=GeQc9UTFkim6ObLNMEA+TRdhwkjmuw0xg5uFoQFfsO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3PmipaQv/Pc1dnjbb+Ppw/EbZBg7zxUA8UQlpDMJG9Ie2Rp2WYW7oxMBnM/O/bLmSx0VfdWnpsgB2N27gnbw3F5VcNIfXS69SgWmTbxXyhTgCjLUVvqCSgXJaKZaYBfQQuIxYMi5+uAFsJHPTswn5Ss0HoH+hk+DrPpGlK8mdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny3Wqblb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7BFC4CEF7;
	Tue, 30 Dec 2025 02:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767063286;
	bh=GeQc9UTFkim6ObLNMEA+TRdhwkjmuw0xg5uFoQFfsO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ny3Wqblb4K+31z2qoERG4Bz8O8Jzdgp8z+ua9gv7M8Sc3lInIvnLqVdReOEotFEtA
	 dE5LoWt7HxSFhL43o/K85VdoOPNxtDUnGJspxVjZ9tH9Gcm298qiF54yQnhD/FAfb2
	 FafiZA/cKT4X4hKrad/IqCMPAph+DwiEZq/xoqwDMuhB1r/bYnpCiaANeGsVlHmNJa
	 sk8HXA6YCaL7VsTAuKfAHQ1mqkT49lC3l8vUBUkIxu0xccMcYGS2vitkS47wjk9ZK/
	 Y6eyRvg0IelurBmzmIAXRXBrtuKgENav/mF55Pxj9r2R5GtmbGKoa9TPYmXLWdibwi
	 37aJW2i686YLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: xu xin <xu.xin16@zte.com.cn>,
	Stefan Roesch <shr@devkernel.io>,
	David Hildenbrand <david@redhat.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Wang Yaxin <wang.yaxin@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/ksm: fix exec/fork inheritance support for prctl
Date: Mon, 29 Dec 2025 21:54:43 -0500
Message-ID: <20251230025443.1980197-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122925-designed-overture-2e7d@gregkh>
References: <2025122925-designed-overture-2e7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xu xin <xu.xin16@zte.com.cn>

[ Upstream commit 590c03ca6a3fbb114396673314e2aa483839608b ]

Patch series "ksm: fix exec/fork inheritance", v2.

This series fixes exec/fork inheritance.  See the detailed description of
the issue below.

This patch (of 2):

Background
==========

commit d7597f59d1d33 ("mm: add new api to enable ksm per process")
introduced MMF_VM_MERGE_ANY for mm->flags, and allowed user to set it by
prctl() so that the process's VMAs are forcibly scanned by ksmd.

Subsequently, the 3c6f33b7273a ("mm/ksm: support fork/exec for prctl")
supported inheriting the MMF_VM_MERGE_ANY flag when a task calls execve().

Finally, commit 3a9e567ca45fb ("mm/ksm: fix ksm exec support for prctl")
fixed the issue that ksmd doesn't scan the mm_struct with MMF_VM_MERGE_ANY
by adding the mm_slot to ksm_mm_head in __bprm_mm_init().

Problem
=======

In some extreme scenarios, however, this inheritance of MMF_VM_MERGE_ANY
during exec/fork can fail.  For example, when the scanning frequency of
ksmd is tuned extremely high, a process carrying MMF_VM_MERGE_ANY may
still fail to pass it to the newly exec'd process.  This happens because
ksm_execve() is executed too early in the do_execve flow (prematurely
adding the new mm_struct to the ksm_mm_slot list).

As a result, before do_execve completes, ksmd may have already performed a
scan and found that this new mm_struct has no VM_MERGEABLE VMAs, thus
clearing its MMF_VM_MERGE_ANY flag.  Consequently, when the new program
executes, the flag MMF_VM_MERGE_ANY inheritance missed.

Root reason
===========

commit d7597f59d1d33 ("mm: add new api to enable ksm per process") clear
the flag MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE VMAs.

Solution
========

Firstly, Don't clear MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE
VMAs, because perhaps their mm_struct has just been added to ksm_mm_slot
list, and its process has not yet officially started running or has not
yet performed mmap/brk to allocate anonymous VMAS.

Secondly, recheck MMF_VM_MERGEABLE again if a process takes
MMF_VM_MERGE_ANY, and create a mm_slot and join it into ksm_scan_list
again.

Link: https://lkml.kernel.org/r/20251007182504440BJgK8VXRHh8TD7IGSUIY4@zte.com.cn
Link: https://lkml.kernel.org/r/20251007182821572h_SoFqYZXEP1mvWI4n9VL@zte.com.cn
Fixes: 3c6f33b7273a ("mm/ksm: support fork/exec for prctl")
Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process")
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ changed mm_flags_test() and mm_flags_clear() calls to test_bit() and clear_bit() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2e4cd681622d..96a0feb19c09 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2451,8 +2451,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		spin_unlock(&ksm_mmlist_lock);
 
 		mm_slot_free(mm_slot_cache, mm_slot);
+		/*
+		 * Only clear MMF_VM_MERGEABLE. We must not clear
+		 * MMF_VM_MERGE_ANY, because for those MMF_VM_MERGE_ANY process,
+		 * perhaps their mm_struct has just been added to ksm_mm_slot
+		 * list, and its process has not yet officially started running
+		 * or has not yet performed mmap/brk to allocate anonymous VMAS.
+		 */
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
-		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
@@ -2567,8 +2573,16 @@ void ksm_add_vma(struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
 		__ksm_add_vma(vma);
+		/*
+		 * Generally, the flags here always include MMF_VM_MERGEABLE.
+		 * However, in rare cases, this flag may be cleared by ksmd who
+		 * scans a cycle without finding any mergeable vma.
+		 */
+		if (unlikely(!test_bit(MMF_VM_MERGEABLE, &mm->flags)))
+			__ksm_enter(mm);
+	}
 }
 
 static void ksm_add_vmas(struct mm_struct *mm)
-- 
2.51.0


