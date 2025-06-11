Return-Path: <stable+bounces-152481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49002AD61C2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC53175A07
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1C23C516;
	Wed, 11 Jun 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iF1PJULJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC71FFC54
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678326; cv=none; b=Dwrq2Kc7OM736JKjZjkouXxJ5vFGmvnRXaFDfJ2brZ+JO6skE3MIz8TRRo4iDnIhPTAFfrrfbwI3Z4rk5W8cAvvVwUO5/1y5ewcFE3gi2+WAl0FR2fUT62JAEPC9K2RfJXnQiDb1Wi/rxTqM7Y+gsTU6b7C85Wzz3tjCacCwr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678326; c=relaxed/simple;
	bh=4kODtHSYqueizCoB1qCJnZDAZD+0Dg5kD1d/ByyALe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZImatzmklFULbKCcq94RAKaNxRa6mUTjOZbANvCRReVelBX1E0qhD6an5fm1fx+7Cbr/Es6m5jbV6zqPF/SlIYEMw/l7uhYrSrLXcFuJ8E5cg1zgTpwgmg7kN3zbfWxBuwEjmovRUwNC4+DtS7y0VzZUucLkGTRh+XyTmHU9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iF1PJULJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749678325; x=1781214325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4kODtHSYqueizCoB1qCJnZDAZD+0Dg5kD1d/ByyALe4=;
  b=iF1PJULJHiSw2ytmdXUVank0wh4N8Z2dY29iSvfLiod72sCglegE3n7O
   tO20KiA7yFF0F7iZ16ugfgDg6RVHei2qK/3BVpbKfJkwd7MkF2kQNHrxf
   +aZc/F3eM9QW6KOhb/KVdznVfFINbwkaDsOpNyiZQyTYSZUYWNdbbyWYU
   RP7QAhUEq+gRKk/m2yh/RtR5jnthsXq4uORGynri+h4tAC65XLGQdRrXu
   WFhvVhtxSHVxXw8uEfkcMhhMVJiKD4nX3CxGW0GNyjq1KtungRUtx43I+
   knvTek5YRzhjSC8vUgmSDCbkq/7SWVx9QKopZaLxF2TPgZtmPPAeqH6zj
   Q==;
X-CSE-ConnectionGUID: 5Cq3eklFRqa6XdLeEDtiaA==
X-CSE-MsgGUID: l6G9wG3YTLSiqM4k698yoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69276633"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="69276633"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 14:45:24 -0700
X-CSE-ConnectionGUID: uYlHrczvRJi59ExxR4rrrg==
X-CSE-MsgGUID: EHdi5pBvSASMnXYCYeL4IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="152092743"
Received: from valcore-skull-1.fm.intel.com ([10.1.39.17])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 14:45:24 -0700
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix early wedge on GuC load failure
Date: Wed, 11 Jun 2025 14:44:54 -0700
Message-ID: <20250611214453.1159846-2-daniele.ceraolospurio@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the GuC fails to load we declare the device wedged. However, the
very first GuC load attempt on GT0 (from xe_gt_init_hwconfig) is done
before the GT1 GuC objects are initialized, so things go bad when the
wedge code attempts to cleanup GT1. To fix this, check the initialization
status in the functions called during wedge.

Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+: 1e1981b16bb1: drm/xe: Fix taking invalid lock on wedge
Cc: <stable@vger.kernel.org> # v6.12+
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 8 ++++++++
 drivers/gpu/drm/xe/xe_guc_ct.c              | 7 +++++--
 drivers/gpu/drm/xe/xe_guc_ct.h              | 5 +++++
 drivers/gpu/drm/xe/xe_guc_submit.c          | 3 +++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 084cbdeba8ea..e1362e608146 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -137,6 +137,14 @@ void xe_gt_tlb_invalidation_reset(struct xe_gt *gt)
 	struct xe_gt_tlb_invalidation_fence *fence, *next;
 	int pending_seqno;
 
+	/*
+	 * we can get here before the CTs are even initialized if we're wedging
+	 * very early, in which case there are not going to be any pending
+	 * fences so we can bail immediately.
+	 */
+	if (!xe_guc_ct_initialized(&gt->uc.guc.ct))
+		return;
+
 	/*
 	 * CT channel is already disabled at this point. No new TLB requests can
 	 * appear.
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 822f4c33f730..e303fec18174 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -517,6 +517,9 @@ void xe_guc_ct_disable(struct xe_guc_ct *ct)
  */
 void xe_guc_ct_stop(struct xe_guc_ct *ct)
 {
+	if (!xe_guc_ct_initialized(ct))
+		return;
+
 	xe_guc_ct_set_state(ct, XE_GUC_CT_STATE_STOPPED);
 	stop_g2h_handler(ct);
 }
@@ -788,7 +791,7 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 	u16 seqno;
 	int ret;
 
-	xe_gt_assert(gt, ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED);
+	xe_gt_assert(gt, xe_guc_ct_initialized(ct));
 	xe_gt_assert(gt, !g2h_len || !g2h_fence);
 	xe_gt_assert(gt, !num_g2h || !g2h_fence);
 	xe_gt_assert(gt, !g2h_len || num_g2h);
@@ -1424,7 +1427,7 @@ static int g2h_read(struct xe_guc_ct *ct, u32 *msg, bool fast_path)
 	u32 action;
 	u32 *hxg;
 
-	xe_gt_assert(gt, ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED);
+	xe_gt_assert(gt, xe_guc_ct_initialized(ct));
 	lockdep_assert_held(&ct->fast_lock);
 
 	if (ct->state == XE_GUC_CT_STATE_DISABLED)
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
index 5649bda82823..99c5dec446f2 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct.h
@@ -24,6 +24,11 @@ void xe_guc_ct_print(struct xe_guc_ct *ct, struct drm_printer *p, bool want_ctb)
 
 void xe_guc_ct_fixup_messages_with_ggtt(struct xe_guc_ct *ct, s64 ggtt_shift);
 
+static inline bool xe_guc_ct_initialized(struct xe_guc_ct *ct)
+{
+	return ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED;
+}
+
 static inline bool xe_guc_ct_enabled(struct xe_guc_ct *ct)
 {
 	return ct->state == XE_GUC_CT_STATE_ENABLED;
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 4a5bcaf83965..55f6385c63a6 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1787,6 +1787,9 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
 {
 	int ret;
 
+	if (!guc->submission_state.initialized)
+		return 0;
+
 	/*
 	 * Using an atomic here rather than submission_state.lock as this
 	 * function can be called while holding the CT lock (engine reset
-- 
2.43.0


