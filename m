Return-Path: <stable+bounces-58132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F99286C7
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 12:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D193B1C22956
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E71487C0;
	Fri,  5 Jul 2024 10:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3B147C98;
	Fri,  5 Jul 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175349; cv=none; b=sMJTCEw5J5R1b/ClwgPO5Tge1OIaIigHn6D+n5GAqHCb6K2f4RYxRmp5rUOylDNW+9DnhgZ57dmXU9gAmw+riFd/ocbKnnSzBhNwwjLvjdVQxO2e8LmCbOXrcds3g9bPmlY/+ZcYKEmbucPGak/3nGET3bq3U1EPPTW2nrHCJLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175349; c=relaxed/simple;
	bh=j8PC3/bFEJc4hrrkNC2wpYRwrt5cpmo4+GPpXHQqED0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tf2yEgYd6hjHvC7Ph+c3h9HI4TTSwJSrGmGt8q7bnoeFHp7Zrsrdmy1qruKpA+vaZ7oLo/soXjMSCaX990n3vwAX8GUqMa6taWEaUFb0wzdQ0t8FwyurWuQuyJOjGcUHnNE56VCAHZ/ytLO54aJRS+F8c0HP5S0p+mxsTWVKUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D69BC367;
	Fri,  5 Jul 2024 03:29:24 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17CCC3F766;
	Fri,  5 Jul 2024 03:28:57 -0700 (PDT)
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
Subject: [PATCH v3] mm: Fix khugepaged activation policy
Date: Fri,  5 Jul 2024 11:28:48 +0100
Message-ID: <20240705102849.2479686-1-ryan.roberts@arm.com>
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

Applies on top of mm-unstable from a couple of days ago (9bb8753acdd8). No
regressions observed in mm selftests.

When fixing this I also noticed that khugepaged doesn't get (and never has been)
activated/deactivated by `shmem_enabled=`. I've concluded that this is
definitely a (separate) bug. But I'm waiting for the conclusion of the
conversation at [3] before fixing, so will send separately.

Changes since v1 [1]
====================

  - hugepage_pmd_enabled() now considers CONFIG_READ_ONLY_THP_FOR_FS as part of
    decision; means that for kernels without this config, khugepaged will not be
    started when only the top-level control is enabled.

Changes since v2 [2]
====================

  - Make hugepage_pmd_enabled() out-of-line static in khugepaged.c (per Andrew)
  - Refactor hugepage_pmd_enabled() for better readability (per Andrew)

[1] https://lore.kernel.org/linux-mm/20240702144617.2291480-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20240704091051.2411934-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/65c37315-2741-481f-b433-cec35ef1af35@arm.com/

Thanks,
Ryan

 Documentation/admin-guide/mm/transhuge.rst | 11 ++++----
 include/linux/huge_mm.h                    | 12 --------
 mm/huge_memory.c                           |  7 +++++
 mm/khugepaged.c                            | 33 +++++++++++++++++-----
 4 files changed, 38 insertions(+), 25 deletions(-)

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
index 4d155c7a4792..107da5c4eba4 100644
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
--
2.43.0


