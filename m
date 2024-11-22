Return-Path: <stable+bounces-94658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2F9D652C
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C91161537
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507FE1DFDA7;
	Fri, 22 Nov 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5DQ9Clx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE551DFD95
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309673; cv=none; b=LSWL9kQiCjn37DCHa35gAOs7DBrfJzFygp8xSh1tM+ozH7bhd5R8HeAUPdHIZnP657j5JEWl8VYnMwsDX4SSTDgM7qO8og3JCL3TKRV6xOyqQRWtoK57NIQZZTx09/t1WEJ6jUYfY9zIVtRE78+47qcYrbiclpOqDEjxaooexvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309673; c=relaxed/simple;
	bh=IP+9nw6/iGEX8XXLF8MLHIzI7itTnIwyMcpX+qtKb5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGaikwKTvBu/AfA91+W3FE2IA1+SHk12bshR3ooLYmXY0mo/gr/Q3m57UTWyzls8YPw9CXYYXmL4l5Nr+aide6rIY2YE933sjxBtqRAqoz0vs+PwaV6Vwl98+hX7ZDuBbL7MvlEqLGSNSyrZxBw2bZ95XBm3WOITr/G6zTBJcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5DQ9Clx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309671; x=1763845671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IP+9nw6/iGEX8XXLF8MLHIzI7itTnIwyMcpX+qtKb5k=;
  b=W5DQ9ClxPwq+obhixW6ZmsgVwpyu7dbxPadoqXSoOaI7NZ5WSd0hlTYo
   lmw+GaW5GUvHWJpiuvEMtpdhgbPY3PQ26P9KyvmtivcSTKmT9mSwj6ICI
   9wV1hfXmiFxgQ0vgRJ3RFCQh531SI9R+vV0wlgyPrcj1+gQq9YaDzImNl
   v76C4wNF8qM8Vlyj6BsSv8uSS+MP8O/8ftuGFRBZUvlJ72xItKhK77d5B
   cJ0sArLrQuS/v/KFsD1gw9iABp9UGMIkGtIdzCYo+xwVFvAlKtuI9NAgU
   TRWL+hjtypAkRq0eoPORvO63xlrxAwY3T4MPjV/3TCi2B58TAoF3lmWS1
   g==;
X-CSE-ConnectionGUID: hpe+RQ89T7GXxCYQAIhzUA==
X-CSE-MsgGUID: hGXaBoioTsegne5yVWHaKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878277"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878277"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
X-CSE-ConnectionGUID: tOx5iQb0TQecw8+7dfzY6Q==
X-CSE-MsgGUID: 1CndJWW7SQqJAwqVwssHzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457269"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 21/31] drm/xe/xe2: Extend performance tuning to media GT
Date: Fri, 22 Nov 2024 13:07:09 -0800
Message-ID: <20241122210719.213373-22-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Sousa <gustavo.sousa@intel.com>

commit 3bf90935aafc750c838c8831e96c3ac36cfd48d5 upstream.

With exception of "Tuning: L3 cache - media", we are currently applying
recommended performance tuning settings only for the primary GT. Let's
also implement them for the media GT when applicable.

According to our spec, media GT registers CCCHKNREG1 and L3SQCREG* exist
only in Xe2_LPM and their offsets do not match their primary GT
counterparts. Furthermore, the range where CCCHKNREG1 belongs is not
listed as a multicast range on the media GT. As such, we need to have
Xe2_LPM-specific definitions for those registers and apply the setting
only for that specific IP.

Both Xe2_HPM and Xe2_LPM contain STATELESS_COMPRESSION_CTRL and the
offset on the media GT matches the one on the primary one. So we can
simply have a copy of "Tuning: Stateless compression control" for the
media GT.

v2:
  - Fix implementation with respect to multicast vs non-multicast
    registers. (Matt)
  - Add missing XE2LPM_CCCHKNREG1 on second action of "Tuning:
    Compression Overfetch - media".
v3:
  - STATELESS_COMPRESSION_CTRL on Xe2_HPM is also a multicast register,
    do not define a XE2HPM_STATELESS_COMPRESSION_CTRL register. (Tejas)

Bspec: 72161
Cc: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240920211459.255181-3-gustavo.sousa@intel.com
(cherry picked from commit e1f813947ccf2326cfda4558b7d31430d7860c4b)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h |  6 ++++++
 drivers/gpu/drm/xe/xe_tuning.c       | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 4f0027d93efcb..d1b5be2585eda 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -169,6 +169,8 @@
 #define XEHP_SLICE_COMMON_ECO_CHICKEN1		XE_REG_MCR(0x731c, XE_REG_OPTION_MASKED)
 #define   MSC_MSAA_REODER_BUF_BYPASS_DISABLE	REG_BIT(14)
 
+#define XE2LPM_CCCHKNREG1			XE_REG(0x82a8)
+
 #define VF_PREEMPTION				XE_REG(0x83a4, XE_REG_OPTION_MASKED)
 #define   PREEMPTION_VERTEX_COUNT		REG_GENMASK(15, 0)
 
@@ -391,6 +393,10 @@
 #define SCRATCH1LPFC				XE_REG(0xb474)
 #define   EN_L3_RW_CCS_CACHE_FLUSH		REG_BIT(0)
 
+#define XE2LPM_L3SQCREG2			XE_REG_MCR(0xb604)
+
+#define XE2LPM_L3SQCREG3			XE_REG_MCR(0xb608)
+
 #define XE2LPM_L3SQCREG5			XE_REG_MCR(0xb658)
 
 #define XE2_TDF_CTRL				XE_REG(0xb418)
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index faa1bf42e50ed..c798ae1b3f750 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -42,20 +42,40 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_ACTIONS(CLR(CCCHKNREG1, ENCOMPPERFFIX),
 			 SET(CCCHKNREG1, L3CMPCTRL))
 	},
+	{ XE_RTP_NAME("Tuning: Compression Overfetch - media"),
+	  XE_RTP_RULES(MEDIA_VERSION(2000)),
+	  XE_RTP_ACTIONS(CLR(XE2LPM_CCCHKNREG1, ENCOMPPERFFIX),
+			 SET(XE2LPM_CCCHKNREG1, L3CMPCTRL))
+	},
 	{ XE_RTP_NAME("Tuning: Enable compressible partial write overfetch in L3"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
 	  XE_RTP_ACTIONS(SET(L3SQCREG3, COMPPWOVERFETCHEN))
 	},
+	{ XE_RTP_NAME("Tuning: Enable compressible partial write overfetch in L3 - media"),
+	  XE_RTP_RULES(MEDIA_VERSION(2000)),
+	  XE_RTP_ACTIONS(SET(XE2LPM_L3SQCREG3, COMPPWOVERFETCHEN))
+	},
 	{ XE_RTP_NAME("Tuning: L2 Overfetch Compressible Only"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
 	  XE_RTP_ACTIONS(SET(L3SQCREG2,
 			     COMPMEMRD256BOVRFETCHEN))
 	},
+	{ XE_RTP_NAME("Tuning: L2 Overfetch Compressible Only - media"),
+	  XE_RTP_RULES(MEDIA_VERSION(2000)),
+	  XE_RTP_ACTIONS(SET(XE2LPM_L3SQCREG2,
+			     COMPMEMRD256BOVRFETCHEN))
+	},
 	{ XE_RTP_NAME("Tuning: Stateless compression control"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
 	  XE_RTP_ACTIONS(FIELD_SET(STATELESS_COMPRESSION_CTRL, UNIFIED_COMPRESSION_FORMAT,
 				   REG_FIELD_PREP(UNIFIED_COMPRESSION_FORMAT, 0)))
 	},
+	{ XE_RTP_NAME("Tuning: Stateless compression control - media"),
+	  XE_RTP_RULES(MEDIA_VERSION_RANGE(1301, 2000)),
+	  XE_RTP_ACTIONS(FIELD_SET(STATELESS_COMPRESSION_CTRL, UNIFIED_COMPRESSION_FORMAT,
+				   REG_FIELD_PREP(UNIFIED_COMPRESSION_FORMAT, 0)))
+	},
+
 	{}
 };
 
-- 
2.47.0


