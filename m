Return-Path: <stable+bounces-58089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3B927D2D
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 20:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DF6281892
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25613BAE7;
	Thu,  4 Jul 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dEJZnMR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3149659;
	Thu,  4 Jul 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118076; cv=none; b=gDzouz+S/x6/zsuJdomyxQlFOnRwGlLOtsWA1y2AHVmrSXmqv8vQ23GCxOMC5k1LdMNx741oTKz+TwHF62zcwPuauYbfHpdpsmxF4QGH4c+04qAifSc3eWpVFZ6xwt60RW+q8VLpknxMKjA1PCljuqZENZnx+QY9tin5xP6wCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118076; c=relaxed/simple;
	bh=Ai1UL0srsQQ4neD3uMQP7DBIpKpkhXz4s1mDkEdpMP0=;
	h=Date:To:From:Subject:Message-Id; b=uA+WGJwc57VB/HTxcUvDURmCRKSfww0HewtfWg9Kpph9mmtr/P2xsO5Z4kNXzNIapSyQm+e4r7/xNGe7G7QdmX0hrxxhYsUuHmRve3rBYn7OdZBi+7atelVeaRz1el2nZQWB/ma92gxV/cAZYtV/pQMf314nTkOE52OXy8R1i/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dEJZnMR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137D8C3277B;
	Thu,  4 Jul 2024 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720118076;
	bh=Ai1UL0srsQQ4neD3uMQP7DBIpKpkhXz4s1mDkEdpMP0=;
	h=Date:To:From:Subject:From;
	b=dEJZnMR7w4Jhx+dk+G3sB1qU/ukJSz7SIpBENChj1TDAmqomjabOCV3lVgOAZSTNc
	 mCxJuxqBozEelQRf7lhSFluGO4cWFhQHab3rhD0pCq+ObcmIGAZoaaGdEoiXnUVRSP
	 SOeTAFYlRfGbQdd/8l0SDWTmlBgiyGs0sCe+x/IY=
Date: Thu, 04 Jul 2024 11:34:35 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,shy828301@gmail.com,ioworker0@gmail.com,david@redhat.com,corbet@lwn.net,baolin.wang@linux.alibaba.com,baohua@kernel.org,ryan.roberts@arm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-fix-khugepaged-activation-policy.patch added to mm-unstable branch
Message-Id: <20240704183436.137D8C3277B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: fix khugepaged activation policy
has been added to the -mm mm-unstable branch.  Its filename is
     mm-fix-khugepaged-activation-policy.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-fix-khugepaged-activation-policy.patch

This patch will later appear in the mm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Ryan Roberts <ryan.roberts@arm.com>
Subject: mm: fix khugepaged activation policy
Date: Thu, 4 Jul 2024 10:10:50 +0100

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

Link: https://lkml.kernel.org/r/20240704091051.2411934-1-ryan.roberts@arm.com
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
Closes: https://lore.kernel.org/linux-mm/7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com/
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/admin-guide/mm/transhuge.rst |   11 +++++------
 include/linux/huge_mm.h                    |   15 ++++++++-------
 mm/huge_memory.c                           |    7 +++++++
 mm/khugepaged.c                            |   13 ++++++-------
 4 files changed, 26 insertions(+), 20 deletions(-)

--- a/Documentation/admin-guide/mm/transhuge.rst~mm-fix-khugepaged-activation-policy
+++ a/Documentation/admin-guide/mm/transhuge.rst
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
--- a/include/linux/huge_mm.h~mm-fix-khugepaged-activation-policy
+++ a/include/linux/huge_mm.h
@@ -128,16 +128,17 @@ static inline bool hugepage_global_alway
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
-static inline bool hugepage_flags_enabled(void)
+static inline bool hugepage_pmd_enabled(void)
 {
 	/*
-	 * We cover both the anon and the file-backed case here; we must return
-	 * true if globally enabled, even when all anon sizes are set to never.
-	 * So we don't need to look at huge_anon_orders_inherit.
+	 * We cover both the anon and the file-backed case here; file-backed
+	 * hugepages, when configured in, are determined by the global control.
+	 * Anon pmd-sized hugepages are determined by the pmd-size control.
 	 */
-	return hugepage_global_enabled() ||
-	       READ_ONCE(huge_anon_orders_always) ||
-	       READ_ONCE(huge_anon_orders_madvise);
+	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && hugepage_global_enabled()) ||
+	       test_bit(PMD_ORDER, &huge_anon_orders_always) ||
+	       test_bit(PMD_ORDER, &huge_anon_orders_madvise) ||
+	       (test_bit(PMD_ORDER, &huge_anon_orders_inherit) && hugepage_global_enabled());
 }
 
 static inline int highest_order(unsigned long orders)
--- a/mm/huge_memory.c~mm-fix-khugepaged-activation-policy
+++ a/mm/huge_memory.c
@@ -502,6 +502,13 @@ static ssize_t thpsize_enabled_store(str
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
 
--- a/mm/khugepaged.c~mm-fix-khugepaged-activation-policy
+++ a/mm/khugepaged.c
@@ -449,7 +449,7 @@ void khugepaged_enter_vma(struct vm_area
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    hugepage_flags_enabled()) {
+	    hugepage_pmd_enabled()) {
 		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
 					    PMD_ORDER))
 			__khugepaged_enter(vma->vm_mm);
@@ -2462,8 +2462,7 @@ breakouterloop_mmap_lock:
 
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
 
@@ -2567,7 +2566,7 @@ static void set_recommended_min_free_kby
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
@@ -2643,7 +2642,7 @@ fail:
 void khugepaged_min_free_kbytes_update(void)
 {
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_flags_enabled() && khugepaged_thread)
+	if (hugepage_pmd_enabled() && khugepaged_thread)
 		set_recommended_min_free_kbytes();
 	mutex_unlock(&khugepaged_mutex);
 }
_

Patches currently in -mm which might be from ryan.roberts@arm.com are

mm-fix-khugepaged-activation-policy.patch


