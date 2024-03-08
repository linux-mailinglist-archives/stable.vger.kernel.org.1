Return-Path: <stable+bounces-27191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC93876BC6
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 21:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B7F1F21BC3
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559C5DF0D;
	Fri,  8 Mar 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPijEmq2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E35D75A
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929399; cv=none; b=mlAMFIMjvWsR3xBI8t9IvaPSuEyTSy4tZ3MU71wkZ+EK38vJ0Zu2YHXdaDKSPrAzeZVx3zEtTY2PeCXaa24H6dBaUHkjdmZ9muyi14OqK7YgCe9vryLzqlrLC42k1IIJe/VtS2kl88cnFBTZU/gcFKEvAn1QoFMtq4ZE9a6me/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929399; c=relaxed/simple;
	bh=K++wR686jVfyNeBGSSX6iJ9Bz0PtlvkSTe1jSJ518Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2NfVV7zR4sctnKMykTOTr6QA60lWDfaboubcf5IM6daSBxoiLFWQg9yirJk5VwL5ETs/a/2KlFCbVmd/ODlbMDqaKCTndj42bwL04hbu7RX6xIuv0aibTM2PGJgHRE+wCiZddZ5mdT7H0HGh6WW1iRinpGH7I1L6nbFvGC2o8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPijEmq2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709929398; x=1741465398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K++wR686jVfyNeBGSSX6iJ9Bz0PtlvkSTe1jSJ518Rc=;
  b=mPijEmq2ndZnjWUJUkb3BHDu08wcMa+PCsJKQyBrs0fRv6a9HGvIsPKb
   dZ+ky2OyWtZ8QaAIPYWSLM6xQEsF+MNr0NJ7Ced591210C7XdeOkkny/2
   /UD7mkrxlFjQ8yClwwjOWiBttW2xBYDOX+eFMfVPi7S6pVSpcgNQtg5SX
   XW5tvz1hlkq2Z7FrUutCNJ8naZ9Zo0BmzgBZJ66e9/dND0eUiTefF8mlY
   rVXdwcHvjgXlRPHLDqiBYyYfNsSoQzbhMMv3HsbgAdEAQCKEC//Q1PbZ7
   C5zKXn5Sx5KUtFLBzM21psJpGXS+mt1UGV5QRDFzpyP3rRYAZVTf3ej+1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="22120771"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="22120771"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 12:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15223757"
Received: from unknown (HELO intel.com) ([10.247.118.109])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 12:23:10 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH v5 3/4] drm/i915/gt: Disable tests for CCS engines beyond the first
Date: Fri,  8 Mar 2024 21:22:18 +0100
Message-ID: <20240308202223.406384-4-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308202223.406384-1-andi.shyti@linux.intel.com>
References: <20240308202223.406384-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In anticipation of the upcoming commit that will operate with
only one CCS stream, when more than one CCS slice is present,
create a new for_each_available_engine() that excludes CCS
engines beyond the forst. Begin using it in the hangcheck
selftest.

Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gt.h           | 13 ++++++++++++
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c | 22 ++++++++++----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt.h b/drivers/gpu/drm/i915/gt/intel_gt.h
index 6e7cab60834c..d3ee7aee9c7c 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt.h
@@ -188,6 +188,19 @@ void intel_gt_release_all(struct drm_i915_private *i915);
 	     (id__)++) \
 		for_each_if ((engine__) = (gt__)->engine[(id__)])
 
+/*
+ * Simple iterator over all initialised engines that
+ * takes into account CCS fixed mode load balancing
+ */
+#define for_each_available_engine(engine__, gt__, id__) \
+	for ((id__) = 0; \
+	     (id__) < I915_NUM_ENGINES; \
+	     (id__)++) \
+		for_each_if \
+			(((engine__) = (gt__)->engine[(id__)]) && \
+			 !(engine__->class == COMPUTE_CLASS && \
+			   engine__->instance))
+
 /* Iterator over subset of engines selected by mask */
 #define for_each_engine_masked(engine__, gt__, mask__, tmp__) \
 	for ((tmp__) = (mask__) & (gt__)->info.engine_mask; \
diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 9ce8ff1c04fe..f1e684987ddb 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -296,7 +296,7 @@ static int igt_hang_sanitycheck(void *arg)
 	if (err)
 		return err;
 
-	for_each_engine(engine, gt, id) {
+	for_each_available_engine(engine, gt, id) {
 		struct intel_wedge_me w;
 		long timeout;
 
@@ -360,7 +360,7 @@ static int igt_reset_nop(void *arg)
 	reset_count = i915_reset_count(global);
 	count = 0;
 	do {
-		for_each_engine(engine, gt, id) {
+		for_each_available_engine(engine, gt, id) {
 			struct intel_context *ce;
 			int i;
 
@@ -433,7 +433,7 @@ static int igt_reset_nop_engine(void *arg)
 	if (!intel_has_reset_engine(gt))
 		return 0;
 
-	for_each_engine(engine, gt, id) {
+	for_each_available_engine(engine, gt, id) {
 		unsigned int reset_count, reset_engine_count, count;
 		struct intel_context *ce;
 		IGT_TIMEOUT(end_time);
@@ -553,7 +553,7 @@ static int igt_reset_fail_engine(void *arg)
 	if (!intel_has_reset_engine(gt))
 		return 0;
 
-	for_each_engine(engine, gt, id) {
+	for_each_available_engine(engine, gt, id) {
 		unsigned int count;
 		struct intel_context *ce;
 		IGT_TIMEOUT(end_time);
@@ -700,7 +700,7 @@ static int __igt_reset_engine(struct intel_gt *gt, bool active)
 			return err;
 	}
 
-	for_each_engine(engine, gt, id) {
+	for_each_available_engine(engine, gt, id) {
 		unsigned int reset_count, reset_engine_count;
 		unsigned long count;
 		bool using_guc = intel_engine_uses_guc(engine);
@@ -990,7 +990,7 @@ static int __igt_reset_engines(struct intel_gt *gt,
 	if (!threads)
 		return -ENOMEM;
 
-	for_each_engine(engine, gt, id) {
+	for_each_available_engine(engine, gt, id) {
 		unsigned long device = i915_reset_count(global);
 		unsigned long count = 0, reported;
 		bool using_guc = intel_engine_uses_guc(engine);
@@ -1010,7 +1010,7 @@ static int __igt_reset_engines(struct intel_gt *gt,
 		}
 
 		memset(threads, 0, sizeof(*threads) * I915_NUM_ENGINES);
-		for_each_engine(other, gt, tmp) {
+		for_each_available_engine(other, gt, tmp) {
 			struct kthread_worker *worker;
 
 			threads[tmp].resets =
@@ -1185,7 +1185,7 @@ static int __igt_reset_engines(struct intel_gt *gt,
 		}
 
 unwind:
-		for_each_engine(other, gt, tmp) {
+		for_each_available_engine(other, gt, tmp) {
 			int ret;
 
 			if (!threads[tmp].worker)
@@ -1621,7 +1621,7 @@ static int wait_for_others(struct intel_gt *gt,
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
 
-	for_each_engine(engine, gt, id) {
+	for_each_available_engine(engine, gt, id) {
 		if (engine == exclude)
 			continue;
 
@@ -1649,7 +1649,7 @@ static int igt_reset_queue(void *arg)
 	if (err)
 		goto unlock;
 
-	for_each_engine(engine, gt, id) {
+	for_each_available_engine(engine, gt, id) {
 		struct intel_selftest_saved_policy saved;
 		struct i915_request *prev;
 		IGT_TIMEOUT(end_time);
@@ -1982,7 +1982,7 @@ static int igt_reset_engines_atomic(void *arg)
 		struct intel_engine_cs *engine;
 		enum intel_engine_id id;
 
-		for_each_engine(engine, gt, id) {
+		for_each_available_engine(engine, gt, id) {
 			err = igt_atomic_reset_engine(engine, p);
 			if (err)
 				goto out;
-- 
2.43.0


