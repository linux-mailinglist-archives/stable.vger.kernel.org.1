Return-Path: <stable+bounces-88001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F59ADA99
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B52F2828F8
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613C1662F4;
	Thu, 24 Oct 2024 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0Gz3hfB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22C170A3A
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741148; cv=none; b=MhGtpoEnUJvnXbjh2AdrGwxFBx5e9EuGWp7eeQCgzCxfF84A+jAQWvrVmw6MJecBF54ASlJbDFpwKEqQh6x7sAUMt8UWaxqEpTFnuew5SEab/UObhMxDj7adAYiLBzTu2n7ZpNn4F0+Lmuk2Gj5CTDHcyu/fd4mM7z/k6XniXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741148; c=relaxed/simple;
	bh=4fPuVrDCFVRden5PnsQGE8+Iu/bTWXbW4/ys+/7mELw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn0vAbMZeIVSPbuR6baIKNEMn6yBE47VKXDYEiQy6fuScH5BShRNf70xco6JpnCkvCAGgt4vjDV1/4uR2vOl4UOdPZ/YPj/3NXsvVLdqNstJesKzBSnWsPVmdNZhNPykc9ytDkxS82umT8BqdOBH1oLFhG/FVwIY+/vXrF+gcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0Gz3hfB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741146; x=1761277146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4fPuVrDCFVRden5PnsQGE8+Iu/bTWXbW4/ys+/7mELw=;
  b=l0Gz3hfBBGBSWbjoBSvnmYXfPO8KutZEaWsIEtNLgrvE3Opl2Q7TY9YG
   zXWHqx2V8trSTMchaM8gP8U/D2ZtwEwXdX5mLT2JqQrt5tY64bMJT3z5V
   hQX0yt+bg2/vqV48Zj29S275yvsaM0LSf5ADZhv91jEtgktN2+4alMc4Y
   /PhULkYgeiQ6kibGcNG65xrktpB3cB053Dd7c1fUqlxofnA39m6txqXyA
   AtugrzE9Jbz8tYXT4Yt75xdt+eOIjwPk08YRv8bkHC5MWbQNzx9qh6sMN
   acRWIvJJmgUqHmjLGMSjMm68gQIN/2FrYk2jUJ8tsRcZgIUKBrc3ad8wm
   w==;
X-CSE-ConnectionGUID: zGQGdkz4TY23aV9Rxon5Hw==
X-CSE-MsgGUID: L6YBz8q8QOSNqspyopQdjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33265008"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33265008"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:53 -0700
X-CSE-ConnectionGUID: 39D5daaaSxabncf9hYLWRQ==
X-CSE-MsgGUID: BxsMExS6RP6m9a8wVrJBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384980"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 15/22] drm/xe/xe2hpg: Add Wa_15016589081
Date: Wed, 23 Oct 2024 20:38:07 -0700
Message-ID: <20241024033815.3538736-15-lucas.demarchi@intel.com>
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

From: Tejas Upadhyay <tejas.upadhyay@intel.com>

commit da9a73b7b25eab574cb9c984fcce0b5e240bdd2c upstream.

Wa_15016589081 applies to xe2_hpg renderCS

V2(Gustavo)
  - rename bit macro

Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240904101333.2049655-1-tejas.upadhyay@intel.com
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
(cherry picked from commit 9db969b36b2fbca13ad4088aff725ebd5e8142f5)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 1 +
 drivers/gpu/drm/xe/xe_wa.c           | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 3c28650400586..a4ee6b579f132 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -100,6 +100,7 @@
 
 #define CHICKEN_RASTER_1			XE_REG_MCR(0x6204, XE_REG_OPTION_MASKED)
 #define   DIS_SF_ROUND_NEAREST_EVEN		REG_BIT(8)
+#define   DIS_CLIP_NEGATIVE_BOUNDING_BOX	REG_BIT(6)
 
 #define CHICKEN_RASTER_2			XE_REG_MCR(0x6208, XE_REG_OPTION_MASKED)
 #define   TBIMR_FAST_CLIP			REG_BIT(5)
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index e648265d081be..e2d7ccc6f144b 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -733,6 +733,10 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 			     DIS_PARTIAL_AUTOSTRIP |
 			     DIS_AUTOSTRIP))
 	},
+	{ XE_RTP_NAME("15016589081"),
+	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
+	},
 
 	{}
 };
-- 
2.47.0


