Return-Path: <stable+bounces-181748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A75BA1AEF
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 23:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A511C824C9
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F20E2E8E11;
	Thu, 25 Sep 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XMsv8+jE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D62275106;
	Thu, 25 Sep 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837018; cv=none; b=Sut+ZoUUFPM3riNy/yxMQf+yQJ0b13xihCA86QG7NVBWBIFhDiGQV9OvmMIEou3gme8MWkvHJ4axQxHF+XQbHdaFtvpVS4BPgV/37CfwIx73aGv6GTe7Il3pNIfJvppg3hfx7+pIX9X17ndTf8ob36fDZI+kllWxwkrB9ETcZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837018; c=relaxed/simple;
	bh=oX+ffFtrNxS4S7E+QeUkUElYRbcpE88o28dPbhem8is=;
	h=Date:To:From:Subject:Message-Id; b=Ty2l5PFIVgDabmKn9aOOaMmgjtTxzDulgV6kdDMQEeI4iAjAKVEzty38ic6TW71/MwMnNrOqUR26PyLTLXq3NSLYGbrU/p2oFVwRuHVeeZv6fwX2rIt6oK9RnR2kLEQDNKt002VvZY2lo1WIDObrOS5tWz4ANW2gWQB35gAJ0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XMsv8+jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0A5C4CEF0;
	Thu, 25 Sep 2025 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758837016;
	bh=oX+ffFtrNxS4S7E+QeUkUElYRbcpE88o28dPbhem8is=;
	h=Date:To:From:Subject:From;
	b=XMsv8+jEExn7TLAEuilIYSzECZOlrqIEByK/EYTheGlcbPbwfZNWF7qdOnPtz/Vqa
	 awmUVwUHTYfQyTKJ1lQqLSykW6EwnF+kE9D0wcJoZRYCMu55jWeqYLjbkjh8CApwlR
	 mAxY8oTfdPdS6/PcBOc4ptRlcn5lViYm3ylTniq0=
Date: Thu, 25 Sep 2025 14:50:15 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,osalvador@suse.de,muchun.song@linux.dev,david@redhat.com,kartikey406@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [failures] hugetlbfs-skip-vmas-without-shareable-locks-in-hugetlb_vmdelete_list.patch removed from -mm tree
Message-Id: <20250925215016.7B0A5C4CEF0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
has been removed from the -mm tree.  Its filename was
     hugetlbfs-skip-vmas-without-shareable-locks-in-hugetlb_vmdelete_list.patch

This patch was dropped because it had testing failures

------------------------------------------------------
From: Deepanshu Kartikey <kartikey406@gmail.com>
Subject: hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
Date: Thu, 25 Sep 2025 20:19:32 +0530

hugetlb_vmdelete_list() uses trylock to acquire VMA locks during truncate
operations.  As per the original design in commit 40549ba8f8e0 ("hugetlb:
use new vma_lock for pmd sharing synchronization"), if the trylock fails
or the VMA has no lock, it should skip that VMA.  Any remaining mapped
pages are handled by remove_inode_hugepages() which is called after
hugetlb_vmdelete_list() and uses proper lock ordering to guarantee
unmapping success.

Currently, when hugetlb_vma_trylock_write() returns success (1) for VMAs
without shareable locks, the code proceeds to call unmap_hugepage_range().
This causes assertion failures in huge_pmd_unshare() →
hugetlb_vma_assert_locked() because no lock is actually held:

  WARNING: CPU: 1 PID: 6594 Comm: syz.0.28 Not tainted
  Call Trace:
   hugetlb_vma_assert_locked+0x1dd/0x250
   huge_pmd_unshare+0x2c8/0x540
   __unmap_hugepage_range+0x6e3/0x1aa0
   unmap_hugepage_range+0x32e/0x410
   hugetlb_vmdelete_list+0x189/0x1f0

Fix by explicitly skipping VMAs without shareable locks after trylock
succeeds, consistent with the original design where such VMAs are deferred
to remove_inode_hugepages() for proper handling.

Link: https://lkml.kernel.org/r/20250925144934.150299-1-kartikey406@gmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/hugetlbfs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/hugetlbfs/inode.c~hugetlbfs-skip-vmas-without-shareable-locks-in-hugetlb_vmdelete_list
+++ a/fs/hugetlbfs/inode.c
@@ -487,7 +487,8 @@ hugetlb_vmdelete_list(struct rb_root_cac
 
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
-
+		if (!__vma_shareable_lock(vma))
+			continue;
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
_

Patches currently in -mm which might be from kartikey406@gmail.com are



