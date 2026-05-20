Return-Path: <stable+bounces-253407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJxEMbtIDmoM9gUAu9opvQ
	(envelope-from <stable+bounces-253407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:50:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C679459CEEB
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20D7F303896F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591873CF665;
	Wed, 20 May 2026 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ah57ljzq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB952DC76C
	for <stable@vger.kernel.org>; Wed, 20 May 2026 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320992; cv=none; b=fZDNrEye0r/HR1ubKprSsgHkL8pH1B8f8wc2brjcDP2VsUT9b7uSDu3xKF37I78/arfM2mEPQzEWbZTHkz4F/UGKUGl4Zvc2EeUJJsTS4X75pBkLF26Th15FChlmnDjkNUnM7LrGJcSjYnrB9fTVYtNtyesjBvW8CLs6BwCXLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320992; c=relaxed/simple;
	bh=P77qAkUz0cnFyO5pvDzEyE+dz36m4uDSf+IpfF0k2WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JouOB/bnLtdRl+TwyKMHWaV2n1onFXNphZ4qNGo3IGIBtCOnMJEEBBL9pB3TkmWeXyMwpAituZhDhuozrCzbkxfnNd75AMY/grV4KY/dvcRJpLA5ChT6wbUC2sTZySkNhQbZwm7oX7K0D2Hpp+2CSt+tmQaL5Oje+2gneuDoGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ah57ljzq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779320989; x=1810856989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P77qAkUz0cnFyO5pvDzEyE+dz36m4uDSf+IpfF0k2WI=;
  b=ah57ljzqf3eW9TfT8u6eN3Qw0G35Wbem3W2tTaI6JYoEelfC5GNUA9GH
   21t4RIXrU4uR7swHK2HvzYWtr2EqGOcyE/lYZ6oHijX4ipTSRUypMYTJi
   r57O82AijJCn/9RpUMz90jC2+MT0w4VY44fgpynz7jerGyGSrL+VF+3g+
   DnV1vRSq8dKk00MS98skdquFdEicGf9L38/F+lAd6maprbjlTVXAvHsf6
   31MuKvFAWHB+j9twSu6G4rkuIkzo+RDD6pAkirvKmBPV2gkb3c+YuygOa
   LN0Ji1TtFDvpudtJi0qnlT5Bkw0FXFVUauL70q07rkot5XPosPuJ01xUl
   g==;
X-CSE-ConnectionGUID: k3hTkcZwTiG2995+u4m2zA==
X-CSE-MsgGUID: xCypdDWlRVeSKRG8rEwmbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80213988"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="80213988"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 16:49:47 -0700
X-CSE-ConnectionGUID: lgabgfkOSJ+BVfslUqjJRQ==
X-CSE-MsgGUID: OEBmMMFxSISWP3yIWyilsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="242165617"
Received: from dut4463arlhx.fm.intel.com ([10.105.10.179])
  by fmviesa004.fm.intel.com with ESMTP; 20 May 2026 16:49:47 -0700
From: Brian Nguyen <brian3.nguyen@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Brian Nguyen <brian3.nguyen@intel.com>,
	stable@vger.kernel.org,
	Zongyao Bai <zongyao.bai@intel.com>
Subject: [PATCH] drm/xe: Use PDE mask for 2M page reclaim entries
Date: Wed, 20 May 2026 23:49:47 +0000
Message-ID: <20260520234946.1055572-2-brian3.nguyen@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-253407-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brian3.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: C679459CEEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2M pages use PDE encoding where the physical address occupies bits [51:21],
but generate_reclaim_entry() uses XE_PTE_ADDR_MASK (bits [51:12]) for all
leaf entries. Add XE_PDE_ADDR_MASK and select the correct mask based on
whether the entry is a 2M PDE.

Fixes: 83b914f972bb ("drm/xe: Fix page reclaim entry handling for large pages")
Cc: stable@vger.kernel.org
Suggested-by: Zongyao Bai <zongyao.bai@intel.com>
Signed-off-by: Brian Nguyen <brian3.nguyen@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gtt_defs.h | 1 +
 drivers/gpu/drm/xe/xe_pt.c            | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
index 4d83461e538b..22a6c197ed96 100644
--- a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
@@ -10,6 +10,7 @@
 #define XELPG_GGTT_PTE_PAT1	BIT_ULL(53)
 
 #define XE_PTE_ADDR_MASK	GENMASK_ULL(51, 12)
+#define XE_PDE_ADDR_MASK	GENMASK_ULL(51, 21)
 #define GGTT_PTE_VFID		GENMASK_ULL(11, 2)
 
 #define GUC_GGTT_TOP		0xFEE00000
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 2669ff5ee747..ae5ed0370d72 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1615,7 +1615,11 @@ static int generate_reclaim_entry(struct xe_tile *tile,
 {
 	struct xe_gt *gt = tile->primary_gt;
 	struct xe_guc_page_reclaim_entry *reclaim_entries = prl->entries;
-	u64 phys_addr = pte & XE_PTE_ADDR_MASK;
+	bool is_2m = xe_child->level == 1 && (pte & XE_PDE_PS_2M);
+	/* 2M pages are encoded as PDEs, other reclaimable pages use PTE encoding */
+	u64 addr_mask = is_2m ? XE_PDE_ADDR_MASK : XE_PTE_ADDR_MASK;
+	u64 phys_addr = pte & addr_mask;
+	/* Page address is relative to 4K page regardless of entry level */
 	u64 phys_page = phys_addr >> XE_PTE_SHIFT;
 	int num_entries = prl->num_entries;
 	u32 reclamation_size;
@@ -1641,7 +1645,7 @@ static int generate_reclaim_entry(struct xe_tile *tile,
 		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
 		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_64K); /* reclamation_size = 4 */
 		xe_tile_assert(tile, phys_addr % SZ_64K == 0);
-	} else if (xe_child->level == 1 && pte & XE_PDE_PS_2M) {
+	} else if (is_2m) {
 		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT, 1);
 		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_2M);  /* reclamation_size = 9 */
 		xe_tile_assert(tile, phys_addr % SZ_2M == 0);
-- 
2.43.0


