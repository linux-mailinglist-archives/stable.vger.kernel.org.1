Return-Path: <stable+bounces-249485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF8ADL4VDGoZVQUAu9opvQ
	(envelope-from <stable+bounces-249485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:48:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC24857963F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB6A83088341
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2DA3D8131;
	Tue, 19 May 2026 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msFTfQJP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19913D1712
	for <stable@vger.kernel.org>; Tue, 19 May 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176539; cv=none; b=KHdzZA24bHWAU2/aYd1/JN4Q0tqLac5qahjrLtG+XuvNyAspPS2o3k9V+/k/Wvie2EmOOOpTQawDUxwXxMJVIc6NdFiAvXAFXvYTrLg6LO9TZQNpZwIbrR1qCTcLZU2HipvNhVlyjlGYHrT8LvOEYN3+ow0KJBC7OGmS4KmcGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176539; c=relaxed/simple;
	bh=3hIsISCVTPH0EQKueOEFFXhsxHwXcccPYq7/eFktsxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t07kWPuNHch5sLRPuiw5ynDMYJschQ3WgdazG8b8p4Zir96gdndw/SZ06LtrFiC/Ecfwct6Vwkmep0FnO1qGlh0b0TYn/98C4DKD+tJ0x1A2vpVezOYtX09Rkp9JyKnLVZBjNk5g6izXSZPsYgaQtB3NoDlJcIra+MWupvQGKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msFTfQJP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779176538; x=1810712538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3hIsISCVTPH0EQKueOEFFXhsxHwXcccPYq7/eFktsxo=;
  b=msFTfQJPWi4OHpMNhVvVED+aoEtQirsjIsGm/S1gRt4oIdXgEVZDunEe
   hKROrrkQB2DOF6Qq3Xza6bVjBMMQ2QEPk4sZOJ3vl4byr/4YzOoKn/Mds
   KyfIqQ9hfQJ4z7W8j554ntF6T3+PXWIndUc5uh0DOe++hagNMicTAhYd/
   6MRzQ79m8eY3rBbQ6SikiQrRs1kupCe1xcQAoJKMYgc/vuduoS6TU+Zav
   DCbGM3q7KYyLqfHNRuqOLqR7OB26BVDxEWAYxH5YKmvw1wBrAb+pWJHan
   CCDRxfr00m3s7xrOOtjkaY3Lxz9vMFgBZV4cUqpE5FKs57ZXPvXb8YmDJ
   A==;
X-CSE-ConnectionGUID: xuVo68aJRpO2+gBJ5jUD+g==
X-CSE-MsgGUID: uOK+YXVfRF+uUEpRDPy1qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80025934"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80025934"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 00:42:15 -0700
X-CSE-ConnectionGUID: TbYNip3lRyGEJZIYxGIQ1g==
X-CSE-MsgGUID: IzBxqd6vTlmJdYSsUZS4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239561932"
Received: from pranay-x299-aorus-gaming-3-pro.iind.intel.com ([10.223.74.54])
  by orviesa008.jf.intel.com with ESMTP; 19 May 2026 00:42:12 -0700
From: Pranay Samala <pranay.samala@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: karthik.b.s@intel.com,
	sameer.lattannavar@intel.com,
	pranay.samala@intel.com,
	stable@vger.kernel.org,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Uma Shankar <uma.shankar@intel.com>
Subject: [PATCH] drm/i915/color: Fix HDR pre-CSC LUT programming loop
Date: Tue, 19 May 2026 13:23:08 +0530
Message-Id: <20260519075308.383877-1-pranay.samala@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249485-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pranay.samala@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CC24857963F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The integer lut programming loop never executes completely due to
incorrect condition (i++ > 130).

Fix to properly program 129th+ entries for values > 1.0.

Cc: <stable@vger.kernel.org> #v6.19
Fixes: 82caa1c8813f ("drm/i915/color: Program Pre-CSC registers")
Signed-off-by: Pranay Samala <pranay.samala@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 2d318e922671..3bfe09d81a4c 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3976,7 +3976,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
 						   (1 << 24));
-			} while (i++ > 130);
+			} while (i++ < 130);
 		} else {
 			for (i = 0; i < lut_size; i++) {
 				u32 v = (i * ((1 << 24) - 1)) / (lut_size - 1);
-- 
2.34.1


