Return-Path: <stable+bounces-217928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHIyCZrTnWk0SQQAu9opvQ
	(envelope-from <stable+bounces-217928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 17:36:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3207A189DC8
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D3ED303840D
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC83A7F7E;
	Tue, 24 Feb 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DET58f54"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61973A9615
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950963; cv=none; b=lTbHH8wr3eZ0SeLHfQWkQF9/hH/cFlCcw/aWKGUycWtQewXC4xyFyp3/bcvvEOBlL5OLvbpWNmgFPr0fwFk61sVEFxMyHVGe4bOqYdoSVowFi0KBIq0TDKcRw+U4x8PR+SZSgB9eaDzQulEeUJedQmBDuG8hxhWDG6Pk+YOC9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950963; c=relaxed/simple;
	bh=zvPuGUpLh+rIJq1IhXAbVOw46e69+PW92ASLERc+R1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZEZozLrQ+Ph2Pzr8BcuEBmU+RdlgRC7dYnKkiQBBl+biSEP2tkf9UAr070dtImi5FWGK512Xoeq0dVQEKyojFvqLBrlVy/TWogPdS9K67VEo/0g0NXjkL1Kk5JaeIywiJKN+SXlR64PtNnslSlAKDsj4Xxr2GqT5fACWsn6fEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DET58f54; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771950963; x=1803486963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zvPuGUpLh+rIJq1IhXAbVOw46e69+PW92ASLERc+R1k=;
  b=DET58f54OnFobCKnt370tcC6UgNR8dNYPaXnicnfK1cLj2Iu/3s7LHay
   vz6K7AH7Pri6gQYYLdOmgy2GThkup/VbLWYtp+DxsVO70VA6/ADGKoaVq
   rvXhr0HAvHMlQrKqiMoHkm+boJZ8t8U4ksslJVybW+F1aaqLH/x4mYF37
   eHWBFjJtT4X3VTaLmGfUYN+HCsdqNTvtHV//Ab8rEF2mRAxUg2fYkRCKI
   gihqY1BmJEdLbi6kPhudr3PpW3d1So0SBowyXRSFXFxXn6guQkRWhu2WO
   NnEjsfneh1Mfcj3DGhWJOw0W9SorZ5EaimMQN7czE3AWuFUW8JbGFHEhZ
   A==;
X-CSE-ConnectionGUID: YDCtnDbRS46v0hbaG7BMHg==
X-CSE-MsgGUID: HEwCjOBkTqCmz8cVYv+t5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73040150"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73040150"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 08:35:58 -0800
X-CSE-ConnectionGUID: ZNOXR3lnT/CYKV0R0ps6ew==
X-CSE-MsgGUID: ZLUSOzXjRDSHPPRfoVuMwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220555638"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 08:35:58 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 7/7] drm/xe: Open-code GGTT MMIO access protection
Date: Tue, 24 Feb 2026 11:35:55 -0500
Message-Id: <20260224163555.218750-8-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224163555.218750-1-zhanjun.dong@intel.com>
References: <20260224163555.218750-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217928-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3207A189DC8
X-Rspamd-Action: no action

From: Matthew Brost <matthew.brost@intel.com>

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
 drivers/gpu/drm/xe/xe_ggtt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 79310f565fe3..cf3311f5d140 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -66,6 +66,9 @@
  * give us the correct placement for free.
  */
 
+#define XE_GGTT_FLAGS_64K	BIT(0)
+#define XE_GGTT_FLAGS_ONLINE	BIT(1)
+
 /**
  * struct xe_ggtt_node - A node in GGTT.
  *
@@ -117,6 +120,8 @@ struct xe_ggtt {
 	 * @flags: Flags for this GGTT
 	 * Acceptable flags:
 	 * - %XE_GGTT_FLAGS_64K - if PTE size is 64K. Otherwise, regular is 4K.
+	 * - %XE_GGTT_FLAGS_ONLINE - is GGTT online, protected by ggtt->lock
+	 *   after init
 	 */
 	unsigned int flags;
 	/** @scratch: Internal object allocation used as a scratch page */
@@ -367,6 +372,8 @@ static void dev_fini_ggtt(void *arg)
 {
 	struct xe_ggtt *ggtt = arg;
 
+	scoped_guard(mutex, &ggtt->lock)
+		ggtt->flags &= ~XE_GGTT_FLAGS_ONLINE;
 	drain_workqueue(ggtt->wq);
 }
 
@@ -437,6 +444,7 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 	if (err)
 		return err;
 
+	ggtt->flags |= XE_GGTT_FLAGS_ONLINE;
 	return devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
 }
 ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
@@ -465,13 +473,10 @@ static void ggtt_node_fini(struct xe_ggtt_node *node)
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
 		xe_ggtt_clear(ggtt, xe_ggtt_node_addr(node), xe_ggtt_node_size(node));
 	drm_mm_remove_node(&node->base);
@@ -484,8 +489,6 @@ static void ggtt_node_remove(struct xe_ggtt_node *node)
 	if (node->invalidate_on_remove)
 		xe_ggtt_invalidate(ggtt);
 
-	drm_dev_exit(idx);
-
 free_node:
 	ggtt_node_fini(node);
 }
-- 
2.34.1


