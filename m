Return-Path: <stable+bounces-87998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC609ADA96
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC4E281B0D
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5B17107F;
	Thu, 24 Oct 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQZNX5Rc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7531016F265
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741146; cv=none; b=Ku+RUsfTA171imsIvgA+8CUkaFBIU2BqEM1WzUAyPaHVecF4GYOp7ArJauNdqNcjzseZTzxDwx6eFiBH6zR4uOxYyfJiRAeCsnCcvNxIdxxl1IVoFkbMaIf81n2UqzgN6gnxcYdhSYhStTJwMjJBvv0AMneAxwdbkYIveh0Ly50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741146; c=relaxed/simple;
	bh=PJ6hOTcpMxobSyC0urP1furALllXHu/pOjWs4SoX528=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbOz4HgtPV0sEcZV/ETu4mI6Ku9YFdSPX6oLBZ4y3iRXzG0VTbF2XLgLvsC1nZpurmjMpuUycU4VBmFGFzyDCZK/nJhvXEcxFgpEbVxxv2N90aWIllAWS6OYG6whnXqsoq3AOLnl3Ko+JmCctKDSnDWtA/HUmhFuMBkzufdff14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQZNX5Rc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741144; x=1761277144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJ6hOTcpMxobSyC0urP1furALllXHu/pOjWs4SoX528=;
  b=YQZNX5RcqimavAfM9ABJkqByx55F1l4iiNl2q7dmRRupErIx7/u0UZju
   6ZNzR4wrClDYq2QzcOtALoLAphdvp4IzQP8t1ojKuvEyiG+yZ2bNco9Dm
   mN74gilgAQcWaPlJyzLS81oRdSnv4a7crQCjHvPVTg1i2OdQlD5sya7jk
   WKGwKqpZxRJoHquO/K+ipB6/9pPx742AaJZTUEUYSUt7IhdK806dkBMrT
   HjfhjhFeID9bmMaTI+6Pu/KhYT0VUv4ilgUBoRzO0yookrlCb03al4rnx
   5Lpe14Cp5v2cgeS+CCfrbpmjsO8bQ2IQtITzu4uNk2pft8JRSCFiAUv7w
   A==;
X-CSE-ConnectionGUID: Zy35PWNbQFajZpjSDaG5KA==
X-CSE-MsgGUID: /agdqEoqR/W4KHJlKHxEgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33265005"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33265005"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:53 -0700
X-CSE-ConnectionGUID: xgwxQAzGSXqaX9x4aoXm+g==
X-CSE-MsgGUID: Og5n8XYRRc2vnHvb6iQdSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384995"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Shekhar Chauhan <shekhar.chauhan@intel.com>,
	Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 20/22] drm/xe/xe2: Add performance turning changes
Date: Wed, 23 Oct 2024 20:38:12 -0700
Message-ID: <20241024033815.3538736-20-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shekhar Chauhan <shekhar.chauhan@intel.com>

commit ecabb5e6ce54711c28706fc794d77adb3ecd0605 upstream.

Update performance tuning according to the hardware spec.

Bspec: 72161
Signed-off-by: Shekhar Chauhan <shekhar.chauhan@intel.com>
Reviewed-by: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>
Reviewed-by: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240805053710.877119-1-shekhar.chauhan@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 4 ++++
 drivers/gpu/drm/xe/xe_tuning.c       | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 5155f2744fd3b..076afe5b5777c 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -80,6 +80,9 @@
 #define   LE_CACHEABILITY_MASK			REG_GENMASK(1, 0)
 #define   LE_CACHEABILITY(value)		REG_FIELD_PREP(LE_CACHEABILITY_MASK, value)
 
+#define STATELESS_COMPRESSION_CTRL		XE_REG(0x4148)
+#define   UNIFIED_COMPRESSION_FORMAT		REG_GENMASK(3, 0)
+
 #define XE2_GAMREQSTRM_CTRL			XE_REG(0x4194)
 #define   CG_DIS_CNTLBUS			REG_BIT(6)
 
@@ -192,6 +195,7 @@
 #define GSCPSMI_BASE				XE_REG(0x880c)
 
 #define CCCHKNREG1				XE_REG_MCR(0x8828)
+#define   L3CMPCTRL				REG_BIT(23)
 #define   ENCOMPPERFFIX				REG_BIT(18)
 
 /* Fuse readout registers for GT */
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index 3817b7743b0ca..faa1bf42e50ed 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -39,7 +39,8 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	},
 	{ XE_RTP_NAME("Tuning: Compression Overfetch"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
-	  XE_RTP_ACTIONS(CLR(CCCHKNREG1, ENCOMPPERFFIX)),
+	  XE_RTP_ACTIONS(CLR(CCCHKNREG1, ENCOMPPERFFIX),
+			 SET(CCCHKNREG1, L3CMPCTRL))
 	},
 	{ XE_RTP_NAME("Tuning: Enable compressible partial write overfetch in L3"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
@@ -50,6 +51,11 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_ACTIONS(SET(L3SQCREG2,
 			     COMPMEMRD256BOVRFETCHEN))
 	},
+	{ XE_RTP_NAME("Tuning: Stateless compression control"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
+	  XE_RTP_ACTIONS(FIELD_SET(STATELESS_COMPRESSION_CTRL, UNIFIED_COMPRESSION_FORMAT,
+				   REG_FIELD_PREP(UNIFIED_COMPRESSION_FORMAT, 0)))
+	},
 	{}
 };
 
-- 
2.47.0


