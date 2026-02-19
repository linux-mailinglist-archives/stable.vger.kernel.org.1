Return-Path: <stable+bounces-217493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8gSFMVRRl2kKxAIAu9opvQ
	(envelope-from <stable+bounces-217493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:07:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F8716178A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ED01302689A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FA3502B6;
	Thu, 19 Feb 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdaxBshJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3A352C2E
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524428; cv=none; b=eZ2dEnoibM7AGE3htTStZBTzXqQ7QRswb0VkOfhPBOFlFULR6m498o+2inZNaGvfThtjdeMdt6jRoIHfRs3BY0wF7RhI30T/MQ7GnMkgE0jd+gDe3zv9F79lpzpQSY4BXyDAhD2rSvH5x2xppkWrr2G2TsmTCrmZE6mFO+WwR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524428; c=relaxed/simple;
	bh=zvPuGUpLh+rIJq1IhXAbVOw46e69+PW92ASLERc+R1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdDW7LcGFsbONA+Ev82N+HjGkn9OQO/soNt4cHjEx2jxl199k+Is+MF4tXlwLwH3etOuvpII8yA/TIXJQSvbk4S2YfVnz3ALWSm/tqxa6wmB58do5d85sYkWvURf7TlLmfcWEQtTrHG66/T44FVveZ+5M9VJGvd0DiKPhTXuLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdaxBshJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771524427; x=1803060427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zvPuGUpLh+rIJq1IhXAbVOw46e69+PW92ASLERc+R1k=;
  b=WdaxBshJgtQimYlUMFN4rY8ZOzv/n3pKDrAVsC1H86oNjwWjhhPW+Rh7
   NanbuJiboSHEf/ZAtULENtivFUjV+/dsRcMQGWW7B8D1sj3CchgbkbHnk
   4oPSWQuo8Pp3XjiNO5blTGgunPDUHk7Rj0IfpmMzcZzOOoRkHnbh01GOk
   fDUGnJb4UhILIoHXa7HeBOCq+6jBxoxgB1OS6zm67kJ8xapNziGGqh8rK
   vS7yRhnQ0zY/GOWsEpR58xhqVIw2MVAU8w88uTXsN0drVnhv/QIwD5Pk/
   G6334NSsv+aOoVdE3WizP7bgTFGUTnV3OBSNjYp+9uBCpqBUQUvijOoq1
   w==;
X-CSE-ConnectionGUID: QtH/cJMvQhmQ94tTU06kVQ==
X-CSE-MsgGUID: UKr4/yy6Q2iH4L0UwffTrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76482821"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76482821"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:07:04 -0800
X-CSE-ConnectionGUID: +0MQ79l6Sh24AxOz2bdaQg==
X-CSE-MsgGUID: lc7eCGrvS6euCRPqnzC7wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="245189040"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by orviesa002.jf.intel.com with ESMTP; 19 Feb 2026 10:07:04 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Wajdeczko@web.codeaurora.org,
	Michal <Michal.Wajdeczko@intel.com>,
	Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Subject: [PATCH v7 7/7] drm/xe: Open-code GGTT MMIO access protection
Date: Thu, 19 Feb 2026 13:07:01 -0500
Message-Id: <20260219180701.2418453-8-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219180701.2418453-1-zhanjun.dong@intel.com>
References: <20260219180701.2418453-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[intel.com:s=Intel];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54F8716178A
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


