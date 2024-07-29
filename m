Return-Path: <stable+bounces-62364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C293EE52
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6EE1C211EB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF037D3EC;
	Mon, 29 Jul 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aODDjdre"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962D6A8DB
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237527; cv=none; b=ZVNzBIpUHJpt5+sQVppDsusIYvaz9lo8uUfHRwH4iibEV4P5+jXYFlTNeTNKyQhgd9zTkrnI805m5PxZvTrx3xWSXvmdaLt4kMTKlKohXArdI91q9CIbE6BVzMTOYs1l102SazNRo6dIFMuRpE0FSYVyS4tUORkuBNdajgoPsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237527; c=relaxed/simple;
	bh=kjIE2CST4mFK3cagWHT8Ckb2kllZp/O5tPA5ohRvW00=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bgAWh8eXeBuE7OuvC5/n4Ci8K60CBl2HH56ND1qi+qN+P5ZcW6PsisucexHq9rO5isMP33yb8aMzcwLiNP8AAlamTupcLP/30XFdeL6fnIOhhTm8snJXZB4sKiEheL/eFHFw7Z5+ia15GUY4FhUAdRiVWoMGjdoCc6yqS4bogMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aODDjdre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C95C32786;
	Mon, 29 Jul 2024 07:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722237526;
	bh=kjIE2CST4mFK3cagWHT8Ckb2kllZp/O5tPA5ohRvW00=;
	h=Subject:To:Cc:From:Date:From;
	b=aODDjdreX5M5z3cg9kl0gGnhQ22rkyUvKBSKM7F+8a/B2OHclyCcHRBjaXBceF6ed
	 SziqvL3w7NrWSGRNAdY5OXDfdKcj/jZanx0/VX3/SlCdLNEMK0z7grhc8Qy+7VR+Zn
	 RqHWdfLQ8KkD/t/AngVG/8CubHFDDsKiZ7h6c5XA=
Subject: FAILED: patch "[PATCH] mm: fix khugepaged activation policy" failed to apply to 6.10-stable tree
To: ryan.roberts@arm.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,corbet@lwn.net,david@redhat.com,ioworker0@gmail.com,shy828301@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:18:43 +0200
Message-ID: <2024072942-compare-unworried-8aec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 00f58104202c472e487f0866fbd38832523fd4f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072942-compare-unworried-8aec@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

00f58104202c ("mm: fix khugepaged activation policy")
7f83bf14603e ("mm/huge_memory: mark racy access onhuge_anon_orders_always")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00f58104202c472e487f0866fbd38832523fd4f9 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Thu, 4 Jul 2024 10:10:50 +0100
Subject: [PATCH] mm: fix khugepaged activation policy

Since the introduction of mTHP, the docuementation has stated that
khugepaged would be enabled when any mTHP size is enabled, and disabled
when all mTHP sizes are disabled.  There are 2 problems with this; 1.
this is not what was implemented by the code and 2.  this is not the
desirable behavior.

Desirable behavior is for khugepaged to be enabled when any PMD-sized THP
is enabled, anon or file.  (Note that file THP is still controlled by the
top-level control so we must always consider that, as well as the PMD-size
mTHP control for anon).  khugepaged only supports collapsing to PMD-sized
THP so there is no value in enabling it when PMD-sized THP is disabled.
So let's change the code and documentation to reflect this policy.

Further, per-size enabled control modification events were not previously
forwarded to khugepaged to give it an opportunity to start or stop.
Consequently the following was resulting in khugepaged eroneously not
being activated:

  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled

[ryan.roberts@arm.com: v3]
  Link: https://lkml.kernel.org/r/20240705102849.2479686-1-ryan.roberts@arm.com
Link: https://lkml.kernel.org/r/20240705102849.2479686-1-ryan.roberts@arm.com
Link: https://lkml.kernel.org/r/20240704091051.2411934-1-ryan.roberts@arm.com
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
Closes: https://lore.kernel.org/linux-mm/7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com/
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index a1bc9b24e29a..fe237825b95c 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -202,12 +202,11 @@ PMD-mappable transparent hugepage::
 
 	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
 
-khugepaged will be automatically started when one or more hugepage
-sizes are enabled (either by directly setting "always" or "madvise",
-or by setting "inherit" while the top-level enabled is set to "always"
-or "madvise"), and it'll be automatically shutdown when the last
-hugepage size is disabled (either by directly setting "never", or by
-setting "inherit" while the top-level enabled is set to "never").
+khugepaged will be automatically started when PMD-sized THP is enabled
+(either of the per-size anon control or the top-level control are set
+to "always" or "madvise"), and it'll be automatically shutdown when
+PMD-sized THP is disabled (when both the per-size anon control and the
+top-level control are "never")
 
 Khugepaged controls
 -------------------
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index cee3c5da8f0e..acb6ac24a07e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -128,18 +128,6 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
-static inline bool hugepage_flags_enabled(void)
-{
-	/*
-	 * We cover both the anon and the file-backed case here; we must return
-	 * true if globally enabled, even when all anon sizes are set to never.
-	 * So we don't need to look at huge_anon_orders_inherit.
-	 */
-	return hugepage_global_enabled() ||
-	       READ_ONCE(huge_anon_orders_always) ||
-	       READ_ONCE(huge_anon_orders_madvise);
-}
-
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 17fb072a0ca1..f8b5cbd4dd71 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -502,6 +502,13 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
 	} else
 		ret = -EINVAL;
 
+	if (ret > 0) {
+		int err;
+
+		err = start_stop_khugepaged();
+		if (err)
+			ret = err;
+	}
 	return ret;
 }
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 409f67a817f1..a5ec03ef8722 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -413,6 +413,26 @@ static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 	       test_bit(MMF_DISABLE_THP, &mm->flags);
 }
 
+static bool hugepage_pmd_enabled(void)
+{
+	/*
+	 * We cover both the anon and the file-backed case here; file-backed
+	 * hugepages, when configured in, are determined by the global control.
+	 * Anon pmd-sized hugepages are determined by the pmd-size control.
+	 */
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    hugepage_global_enabled())
+		return true;
+	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
+		return true;
+	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
+		return true;
+	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
+	    hugepage_global_enabled())
+		return true;
+	return false;
+}
+
 void __khugepaged_enter(struct mm_struct *mm)
 {
 	struct khugepaged_mm_slot *mm_slot;
@@ -449,7 +469,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    hugepage_flags_enabled()) {
+	    hugepage_pmd_enabled()) {
 		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
 					    PMD_ORDER))
 			__khugepaged_enter(vma->vm_mm);
@@ -2462,8 +2482,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 
 static int khugepaged_has_work(void)
 {
-	return !list_empty(&khugepaged_scan.mm_head) &&
-		hugepage_flags_enabled();
+	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled();
 }
 
 static int khugepaged_wait_event(void)
@@ -2536,7 +2555,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}
 
-	if (hugepage_flags_enabled())
+	if (hugepage_pmd_enabled())
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }
 
@@ -2567,7 +2586,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!hugepage_flags_enabled()) {
+	if (!hugepage_pmd_enabled()) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2617,7 +2636,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_flags_enabled()) {
+	if (hugepage_pmd_enabled()) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2643,7 +2662,7 @@ int start_stop_khugepaged(void)
 void khugepaged_min_free_kbytes_update(void)
 {
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_flags_enabled() && khugepaged_thread)
+	if (hugepage_pmd_enabled() && khugepaged_thread)
 		set_recommended_min_free_kbytes();
 	mutex_unlock(&khugepaged_mutex);
 }


