Return-Path: <stable+bounces-214607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HflXF+6LhWmCDQQAu9opvQ
	(envelope-from <stable+bounces-214607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 07:36:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AC0FAB4A
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 07:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D74130086DD
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 06:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F930BF62;
	Fri,  6 Feb 2026 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9hW2VLJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E82BEC2E
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359783; cv=none; b=UaXDAH+MeP072CgUBf42LSv7wikkHxlDm78DUWO8M2uFTuzh3tNzvnMRsamyX12zeWi0f2Q8vp4PRNZcrKDH335YoqRLdAfIt26tJvvMD5u/izCRcHR8Oh6XR1vUigqx0gTbxW2CuuTAXihkKztTTMQ+EYSe63e1hfvzMWQyU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359783; c=relaxed/simple;
	bh=HX1vVO+6xsFWyO7CNKmjFZcqXjiv53S6Ct6HchcxuYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nErHg2fyOHmseMd9HD4L2Y6DfZ5zNjjQ43FT9xfSMEvaMLdnyE4xvyJsgp4I13xCjnzzzYGQu0l///HGLCjo3MyR6+Qs9tN1YPeo1YFd8YYr14/ffYoaQC50W8ohOCTUEnfFxp2G2dC/3FzG2FA9aWCTNTAFqiH0wb0Gba+b4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9hW2VLJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770359782; x=1801895782;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HX1vVO+6xsFWyO7CNKmjFZcqXjiv53S6Ct6HchcxuYs=;
  b=E9hW2VLJBmNiaheqEORPpr6fUqTm88/dVV0MCapaQz9papST2kxL9un/
   7m9x0TQFqqeTg4Ltumu4y0zoShZKO04+QG5KQJVQyu+Ib3h+8tDxnQSrN
   oRO662MOUaGrdlsaHmYd4/xKAbDOhfkwJUO8EHLoo/Hg/En3AYrqrwUyF
   /vksZR0niUPZxKtR0irh38MkWam7DY3KHtmGFgsE2n+FxkEAbOIXOkzqb
   F1ywcNNUVMooICiIRWwAPDsk/4K1h0d2BvKFv0xrfWXsLrMAmOOGQP7fh
   cgmPgm/ks99paY8LOCrOdy6aWUU09SA7HDc0iJjHxgngbuailVT/d/6Iw
   w==;
X-CSE-ConnectionGUID: 5X44IuPaTH27sn9Zu6yufA==
X-CSE-MsgGUID: AoAadY94QWmRkCOdQ61MrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82304269"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82304269"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 22:36:22 -0800
X-CSE-ConnectionGUID: ZHkx62sbQEe4RtOgcwV84A==
X-CSE-MsgGUID: 8c1qgppCRAimXtr/lcwEEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215284972"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 22:36:22 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/xe: Open-code GGTT MMIO access protection
Date: Thu,  5 Feb 2026 22:36:16 -0800
Message-Id: <20260206063616.4111532-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214607-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 97AC0FAB4A
X-Rspamd-Action: no action

GGTT MMIO access is currently protected by hotplug (drm_dev_enter),
which works correctly when the driver loads successfully and is later
unbound or unloaded. However, if driver load fails, this protection is
insufficient because drm_dev_unplug() is never called.

Additionally, devm release functions cannot guarantee that all BOs with
GGTT mappings are destroyed before the GGTT MMIO region is removed, as
some BOs may be freed asynchronously by worker threads.

To address this, introduce an open-coded flag, protected by the GGTT
lock, that guards GGTT MMIO access. The flag is cleared during the
dev_fini_ggtt devm release function to ensure MMIO access is disabled
once teardown begins.

Cc: stable@vger.kernel.org
Fixes: 919bb54e989c ("drm/xe: Fix missing runtime outer protection for ggtt_remove_node")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_ggtt.c       | 10 ++++------
 drivers/gpu/drm/xe/xe_ggtt_types.h |  5 ++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 8b9d7c0bbe90..872f758ad10c 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -313,6 +313,8 @@ static void dev_fini_ggtt(void *arg)
 {
 	struct xe_ggtt *ggtt = arg;
 
+	scoped_guard(mutex, &ggtt->lock)
+		ggtt->flags &= ~XE_GGTT_FLAGS_ONLINE;
 	drain_workqueue(ggtt->wq);
 }
 
@@ -377,6 +379,7 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 	if (err)
 		return err;
 
+	ggtt->flags |= XE_GGTT_FLAGS_ONLINE;
 	err = devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
 	if (err)
 		return err;
@@ -410,13 +413,10 @@ static void xe_ggtt_initial_clear(struct xe_ggtt *ggtt)
 static void ggtt_node_remove(struct xe_ggtt_node *node)
 {
 	struct xe_ggtt *ggtt = node->ggtt;
-	struct xe_device *xe = tile_to_xe(ggtt->tile);
 	bool bound;
-	int idx;
-
-	bound = drm_dev_enter(&xe->drm, &idx);
 
 	mutex_lock(&ggtt->lock);
+	bound = ggtt->flags & XE_GGTT_FLAGS_ONLINE;
 	if (bound)
 		xe_ggtt_clear(ggtt, node->base.start, node->base.size);
 	drm_mm_remove_node(&node->base);
@@ -429,8 +429,6 @@ static void ggtt_node_remove(struct xe_ggtt_node *node)
 	if (node->invalidate_on_remove)
 		xe_ggtt_invalidate(ggtt);
 
-	drm_dev_exit(idx);
-
 free_node:
 	xe_ggtt_node_fini(node);
 }
diff --git a/drivers/gpu/drm/xe/xe_ggtt_types.h b/drivers/gpu/drm/xe/xe_ggtt_types.h
index d82b71a198bc..a69ae01b5b3e 100644
--- a/drivers/gpu/drm/xe/xe_ggtt_types.h
+++ b/drivers/gpu/drm/xe/xe_ggtt_types.h
@@ -28,11 +28,14 @@ struct xe_ggtt {
 	/** @size: Total usable size of this GGTT */
 	u64 size;
 
-#define XE_GGTT_FLAGS_64K BIT(0)
+#define XE_GGTT_FLAGS_64K	BIT(0)
+#define XE_GGTT_FLAGS_ONLINE	BIT(1)
 	/**
 	 * @flags: Flags for this GGTT
 	 * Acceptable flags:
 	 * - %XE_GGTT_FLAGS_64K - if PTE size is 64K. Otherwise, regular is 4K.
+	 * - %XE_GGTT_FLAGS_ONLINE - is GGTT online, protected by ggtt->lock
+	 *   after init
 	 */
 	unsigned int flags;
 	/** @scratch: Internal object allocation used as a scratch page */
-- 
2.34.1


