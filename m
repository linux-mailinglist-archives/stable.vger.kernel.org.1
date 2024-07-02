Return-Path: <stable+bounces-56355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D7E924136
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A4287524
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216D1B4C5D;
	Tue,  2 Jul 2024 14:46:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FDC1E48A;
	Tue,  2 Jul 2024 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931590; cv=none; b=bKe6ym918avWEOJjcbg8OsV9iPcUhTV5+AieTwjm7nBxqhXxjDycjjacBm1jtSOCXuKtr/gPVU0qMfjoShja7Cahn/L2Bfo/PpbCw1Srt5a0wLpZG9vxh2OFQWuUlUlyB2+h6Dnrr0oiYdqJQZGNQ9DGvevTmMCgjErop0Ciwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931590; c=relaxed/simple;
	bh=tfbXEDM67LJIeWeBawXPL/+exKqsdKpe3pypdG3HYK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMyWWOR7AonZfNOXWk5lgKoncwz16/2VMLr1IqriTTeHZmIdc1Phgi15XzED9Q6gZrMPGgwRCwgTkQpmgnksOnYy+rSEQ49YcjVbdWwKgx2IgaAkPF9eqUBCr7H53djjTzOLYgZeHHCL6qrT3HCXq9KzaQ4XzhEOGC4T/NjvcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78B8C339;
	Tue,  2 Jul 2024 07:46:52 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A8D63F766;
	Tue,  2 Jul 2024 07:46:26 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>,
	Yang Shi <shy828301@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] mm: Fix khugepaged activation policy
Date: Tue,  2 Jul 2024 15:46:14 +0100
Message-ID: <20240702144617.2291480-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of mTHP, the docuementation has stated that
khugepaged would be enabled when any mTHP size is enabled, and disabled
when all mTHP sizes are disabled. There are 2 problems with this; 1.
this is not what was implemented by the code and 2. this is not the
desirable behavior.

Desirable behavior is for khugepaged to be enabled when any PMD-sized
THP is enabled, anon or file. (Note that file THP is still controlled by
the top-level control so we must always consider that, as well as the
PMD-size mTHP control for anon). khugepaged only supports collapsing to
PMD-sized THP so there is no value in enabling it when PMD-sized THP is
disabled. So let's change the code and documentation to reflect this
policy.

Further, per-size enabled control modification events were not
previously forwarded to khugepaged to give it an opportunity to start or
stop. Consequently the following was resulting in khugepaged eroneously
not being activated:

  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
Closes: https://lore.kernel.org/linux-mm/7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com/
Cc: stable@vger.kernel.org
---

Hi All,

Applies on top of today's mm-unstable (9bb8753acdd8). No regressions observed in
mm selftests.

When fixing this I also noticed that khugepaged doesn't get (and never has been)
activated/deactivated by `shmem_enabled=`. I'm not sure if khugepaged knows how
to collapse shmem - perhaps it should be activated in this case?

Thanks,
Ryan

 Documentation/admin-guide/mm/transhuge.rst | 11 +++++------
 include/linux/huge_mm.h                    | 13 +++++++------
 mm/huge_memory.c                           |  7 +++++++
 mm/khugepaged.c                            | 13 ++++++-------
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 709fe10b60f4..fc321d40b8ac 100644
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
index 4d155c7a4792..ce1b47b49cc3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -128,16 +128,17 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }

-static inline bool hugepage_flags_enabled(void)
+static inline bool hugepage_pmd_enabled(void)
 {
 	/*
-	 * We cover both the anon and the file-backed case here; we must return
-	 * true if globally enabled, even when all anon sizes are set to never.
-	 * So we don't need to look at huge_anon_orders_inherit.
+	 * We cover both the anon and the file-backed case here; for
+	 * file-backed, we must return true if globally enabled, regardless of
+	 * the anon pmd size control status. So we don't need to look at
+	 * huge_anon_orders_inherit.
 	 */
 	return hugepage_global_enabled() ||
-	       READ_ONCE(huge_anon_orders_always) ||
-	       READ_ONCE(huge_anon_orders_madvise);
+	       test_bit(PMD_ORDER, &huge_anon_orders_always) ||
+	       test_bit(PMD_ORDER, &huge_anon_orders_madvise);
 }

 static inline int highest_order(unsigned long orders)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 251d6932130f..085f5e973231 100644
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
index 409f67a817f1..708d0e74b61f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -449,7 +449,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    hugepage_flags_enabled()) {
+	    hugepage_pmd_enabled()) {
 		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
 					    PMD_ORDER))
 			__khugepaged_enter(vma->vm_mm);
@@ -2462,8 +2462,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,

 static int khugepaged_has_work(void)
 {
-	return !list_empty(&khugepaged_scan.mm_head) &&
-		hugepage_flags_enabled();
+	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled();
 }

 static int khugepaged_wait_event(void)
@@ -2536,7 +2535,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}

-	if (hugepage_flags_enabled())
+	if (hugepage_pmd_enabled())
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }

@@ -2567,7 +2566,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;

-	if (!hugepage_flags_enabled()) {
+	if (!hugepage_pmd_enabled()) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2617,7 +2616,7 @@ int start_stop_khugepaged(void)
 	int err = 0;

 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_flags_enabled()) {
+	if (hugepage_pmd_enabled()) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2643,7 +2642,7 @@ int start_stop_khugepaged(void)
 void khugepaged_min_free_kbytes_update(void)
 {
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_flags_enabled() && khugepaged_thread)
+	if (hugepage_pmd_enabled() && khugepaged_thread)
 		set_recommended_min_free_kbytes();
 	mutex_unlock(&khugepaged_mutex);
 }
--
2.43.0


