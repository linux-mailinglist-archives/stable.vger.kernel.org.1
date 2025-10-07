Return-Path: <stable+bounces-183526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE9ABC1035
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C2AA4EF029
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5392D7DDB;
	Tue,  7 Oct 2025 10:29:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F18B1E5B94;
	Tue,  7 Oct 2025 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832942; cv=none; b=ny9NMAY2/V5/sjoLNxVPGJc73yugggLmpN18rvbOCGUuC/pQGjRZwTFRfn0RZBOm9H4lzJOMv8zcUtkJUhWHm3V48hl6Vc8qigoWUBpu0sAnJQxh0ndCdZl8wXyDop8XVkog3pYDI8WjCdBurb531GiHvbFyYoFWdNUJQRhS5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832942; c=relaxed/simple;
	bh=A+YqwWb37tzwG0A3miC/nTTjWam4vJUqRM4+bA0TZYg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=f+aGtwThl9qdXv2tpe/cFVLvGirPjnVjslr0QPDxF+QmkBJBqE1ksd1RP4sZ1xuHNanVLrGVInXxsPNoZKyrmWFhEElgcaH2UuYsx2q+VurG+abDTww+2/cRBhlbn8AjtnZf0A1z5Friea2PuySPnGL9azeF9teejNQ97vyp+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cgsmv6XvGz4xNt6;
	Tue, 07 Oct 2025 18:28:47 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 597ASIIs016509;
	Tue, 7 Oct 2025 18:28:18 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 7 Oct 2025 18:28:21 +0800 (CST)
Date: Tue, 7 Oct 2025 18:28:21 +0800 (CST)
X-Zmail-TransId: 2af968e4eb45fc5-6256d
X-Mailer: Zmail v1.0
Message-ID: <20251007182821572h_SoFqYZXEP1mvWI4n9VL@zte.com.cn>
In-Reply-To: <20251007182504440BJgK8VXRHh8TD7IGSUIY4@zte.com.cn>
References: 20251007182504440BJgK8VXRHh8TD7IGSUIY4@zte.com.cn
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <xu.xin16@zte.com.cn>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <shr@devkernel.io>
Cc: <akpm@linux-foundation.org>, <david@redhat.com>, <tujinjiang@huawei.com>,
        <shr@devkernel.io>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjIgMS8yXSBtbS9rc206IGZpeCBleGVjL2ZvcmsgaW5oZXJpdGFuY2Ugc3VwcG9ydCBmb3IgcHJjdGw=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 597ASIIs016509
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 07 Oct 2025 18:28:47 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68E4EB5F.002/4cgsmv6XvGz4xNt6

From: xu xin <xu.xin16@zte.com.cn>

Background
==========

The commit d7597f59d1d33 ("mm: add new api to enable ksm per process") introduce
MMF_VM_MERGE_ANY for mm->flags, and allow user to set it by prctl() so that the
process's VMAs are forcely scanned by ksmd. Sequently, the commit 3c6f33b7273a
("mm/ksm: support fork/exec for prctl") support inheritsingMMF_VM_MERGE_ANY flag
when a task calls execve(). Lastly, The commit 3a9e567ca45fb
("mm/ksm: fix ksm exec support for prctl") fixed the issue that ksmd doesn't scan
the mm_struct with MMF_VM_MERGE_ANY by adding the mm_slot to ksm_mm_head
in __bprm_mm_init().

Problem
=======

In some extreme scenarios, however, this inheritance of MMF_VM_MERGE_ANY during
exec/fork can fail. For example, when the scanning frequency of ksmd is tuned
extremely high, a process carrying MMF_VM_MERGE_ANY may still fail to pass it to
the newly exec'd process. This happens because ksm_execve() is executed too early
in the do_execve flow (prematurely adding the new mm_struct to the ksm_mm_slot list).

As a result, before do_execve completes, ksmd may have already performed a scan and
found that this new mm_struct has no VM_MERGEABLE VMAs, thus clearing its
MMF_VM_MERGE_ANY flag. Consequently, when the new program executes, the flag
MMF_VM_MERGE_ANY inheritance missed.

Root reason
===========

The commit d7597f59d1d33 ("mm: add new api to enable ksm per process") clear the
flag MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE VMAs.

Solution
========

First, Don't clear MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE VMAs, because perhaps
their mm_struct has just been added to ksm_mm_slot list, and its process has not yet
officially started running or has not yet performed mmap/brk to allocate anonymous VMAS.

Second, recheck MMF_VM_MERGEABLE again if a process takes MMF_VM_MERGE_ANY, and create
a mm_slot and join it into ksm_scan_list again.

Fixes: 3c6f33b7273a ("mm/ksm: support fork/exec for prctl")
Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process")
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: stable@vger.kernel.org
Cc: Stefan Roesch <shr@devkernel.io>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
---
 include/linux/ksm.h |  4 ++--
 mm/ksm.c            | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 067538fc4d58..c982694c987b 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -17,7 +17,7 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, vm_flags_t *vm_flags);
-vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+vm_flags_t ksm_vma_flags(struct mm_struct *mm, const struct file *file,
 			 vm_flags_t vm_flags);
 int ksm_enable_merge_any(struct mm_struct *mm);
 int ksm_disable_merge_any(struct mm_struct *mm);
@@ -103,7 +103,7 @@ bool ksm_process_mergeable(struct mm_struct *mm);

 #else  /* !CONFIG_KSM */

-static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+static inline vm_flags_t ksm_vma_flags(struct mm_struct *mm,
 		const struct file *file, vm_flags_t vm_flags)
 {
 	return vm_flags;
diff --git a/mm/ksm.c b/mm/ksm.c
index 04019a15b25d..19efe3d41c75 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2617,8 +2617,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		spin_unlock(&ksm_mmlist_lock);

 		mm_slot_free(mm_slot_cache, mm_slot);
+		/*
+		 * Only clear MMF_VM_MERGEABLE. We must not clear
+		 * MMF_VM_MERGE_ANY, because for those MMF_VM_MERGE_ANY process,
+		 * perhaps their mm_struct has just been added to ksm_mm_slot
+		 * list, and its process has not yet officially started running
+		 * or has not yet performed mmap/brk to allocate anonymous VMAS.
+		 */
 		mm_flags_clear(MMF_VM_MERGEABLE, mm);
-		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
@@ -2736,12 +2742,20 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
  *
  * Returns: @vm_flags possibly updated to mark mergeable.
  */
-vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+vm_flags_t ksm_vma_flags(struct mm_struct *mm, const struct file *file,
 			 vm_flags_t vm_flags)
 {
 	if (mm_flags_test(MMF_VM_MERGE_ANY, mm) &&
-	    __ksm_should_add_vma(file, vm_flags))
+	    __ksm_should_add_vma(file, vm_flags)) {
 		vm_flags |= VM_MERGEABLE;
+		/*
+		 * Generally, the flags here always include MMF_VM_MERGEABLE.
+		 * However, in rare cases, this flag may be cleared by ksmd who
+		 * scans a cycle without finding any mergeable vma.
+		 */
+		if (unlikely(!mm_flags_test(MMF_VM_MERGEABLE, mm)))
+			__ksm_enter(mm);
+	}

 	return vm_flags;
 }
-- 
2.25.1

