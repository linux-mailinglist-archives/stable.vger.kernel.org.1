Return-Path: <stable+bounces-223100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM0+GAVoqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:12:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DB4204F31
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43022301DBA1
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F525A2BB;
	Wed,  4 Mar 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvIUSDpV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC0350A1B
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644352; cv=none; b=s3YqpluHVx4sE5yxcAykBuAa2DeVze4TjGq5uM+Hzlbq1KDKdWtMhiubUe8b5+xCaYArI1Qp7Vg3dO3lXuk98E1X700yG4zo/O91RALVC2SVrgLfbFwvF7kFgb4tDwX23n1m/noYzBcFTWukJCeibeWsa7cOLwaWdo9rhqUQON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644352; c=relaxed/simple;
	bh=jAPhIH/5gAtGBZdRl41Q3pWZ+nhABxE5it2ZZZnd1Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eivMQynZ3SJdqNOvlcdyGfJoCDiyn5w0gsMaOTu/5sORCwEoqJ9G0RckSXnmas1BlGS0pZoR9Rze9y9a1/iFX5AJBtQOywhmZxV8Iv6Ec4YPDLN4eCysexcOmdGSLjMWlYCS8C42mQexOpjtt/Q0BwCja037qDoPM5VNtQEWhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvIUSDpV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772644350; x=1804180350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jAPhIH/5gAtGBZdRl41Q3pWZ+nhABxE5it2ZZZnd1Wo=;
  b=UvIUSDpVCAo5sxd9ZNsq71QViRj9kq28lJgwi+PWIJgFFFQMBoP4nuP3
   Vn2/FXiJDE3HsqhrcuKxglv6CbPTy52nKCv3XELUJWQnNv9PlEwC4pQj0
   ITCaqURfiq1IYfrHjoOXZ3j4pyVfYz4R4zoLdkUHUZHJDGW5GaModbyva
   fqd4GjJHiU55hKAkQWOM8Z51eaGeZnNYNbAFGvoCRdeYzUbdaT0iD8Uz/
   HlOIegsuMGKvO5p2facqPof9E0dH8rtqQ5Rm/Pv2gWKtFVS5zrjS/nakc
   b4DK/fs6S0bbPxNTyQVhB2catqqvWYbWbTXgquXCUY/ENxYC/7CHHjUxH
   w==;
X-CSE-ConnectionGUID: vOot+MFpQ4+AEeKRot1hHA==
X-CSE-MsgGUID: hb757Bj5Sni0cx/63z7S9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72739295"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72739295"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 09:12:29 -0800
X-CSE-ConnectionGUID: W+y1doeIRT+1ir3QhI5rVg==
X-CSE-MsgGUID: DQee+wPuQaG+yFeI0bcObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="223370796"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2026 09:12:29 -0800
From: Jia Yao <jia.yao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Alex Zuo <alex.zuo@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Xin Wang <x.wang@intel.com>,
	stable@vger.kernel.org,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v2] drm/i915/dg2: Update workaround 22013059131
Date: Wed,  4 Mar 2026 17:12:26 +0000
Message-ID: <20260304171226.43208-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01DB4204F31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223100-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Setting the LSC chicken bit FORCE_1_SUB_MESSAGE_PER_FRAGMENT is not
required as part of the workaround, so it can be removed.

v2: Update commit message: clarify why LSC chicken bit
    FORCE_1_SUB_MESSAGE_PER_FRAGMENT is removed.

Bspec: 54833
Fixes: 645cc0b9d972 ("drm/i915/dg2: Add initial gt/ctx/engine workarounds")
Cc: Alex Zuo <alex.zuo@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Xin Wang  <x.wang@intel.com>
Cc: stable@vger.kernel.org
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index f78d991ad7bf..404a6ffafbd0 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2867,10 +2867,6 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 				     MAXREQS_PER_BANK,
 				     REG_FIELD_PREP(MAXREQS_PER_BANK, 2));
 
-		/* Wa_22013059131:dg2 */
-		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0,
-				FORCE_1_SUB_MESSAGE_PER_FRAGMENT);
-
 		/*
 		 * Wa_22012654132
 		 *
-- 
2.43.0


