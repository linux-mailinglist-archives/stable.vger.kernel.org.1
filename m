Return-Path: <stable+bounces-94659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B5E9D652D
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A7C16154F
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B81DFDA8;
	Fri, 22 Nov 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVoam1C3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C671DEFFD
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309673; cv=none; b=RVr6nzk/79ZRI4xMaoOTqeU+/Dt8CgtkfDjol1Z1A0KP3KWI5iv+RLP5WKcRDxXaPqJnRs2kW7BIFd58AjhO3+wAfOrOoPHZLQaF7PU1a8vExYeKZIc7NOqB0q7oLi0edWhuFZETv0hn97H6ggENfcwq0XBOOcCO1WX0pd6EVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309673; c=relaxed/simple;
	bh=nHZqTPFD25n1khgaSL5sPKwXdXcKSO9gF02hr5DMWmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmQKVKmpMipifmU2xK5qnLp835KuqA3FBMnG9nDQzSM9uXkvV0evZ3JXhOeABqO96h/Efn5bIX88GKwJsQ5XvbXLSV8HrgU90GFk0Mhgjpcw5W7/Kyzm93XMAq3ocQBhBZFOJ8v/+DTJ5bp4V0r+AO7skdzzbr7wo3o6NDx5ml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVoam1C3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309671; x=1763845671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHZqTPFD25n1khgaSL5sPKwXdXcKSO9gF02hr5DMWmk=;
  b=EVoam1C3KUJ5yVh6PrxKgCIxRi9TtEzLc3VACoPdyWlIEZcnawYW3WlW
   bh+PQlJB2RuqhQjtDcfIZI055o3o3ZV8/znQk1i/vhnKb1HzEYccspi+D
   R1VwDAUgohg6ceb8XZSqGqNyUm1LD2BDxAIjFiIWdXtveNRqk4kXe9Bs+
   BfYy8MkKw2x09X+TyDNzjUYbYyEJukGa5PE7PG8oiVAwQxyLXCv0GbkK/
   VWf4boF5BnRwO+CzwKn0UitV0rbc67osJhoth+f+wdmGxM6y7VSxtq5aQ
   yZNfVNxC/zzH/EdeYzgCEC87smVUVRt8UHUYzVNGiFV8t+f46s2bcLqS9
   w==;
X-CSE-ConnectionGUID: KkJ/D9N9QdKmJY1VcoZMsw==
X-CSE-MsgGUID: 3hK3WpdlShi8+yw9iENxBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878278"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878278"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
X-CSE-ConnectionGUID: M8aw4093SaeCZQdnAF8Juw==
X-CSE-MsgGUID: gvyp2HY/RImFOZaV35e/BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457274"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 22/31] drm/xe/xe2: Add performance tuning for L3 cache flushing
Date: Fri, 22 Nov 2024 13:07:10 -0800
Message-ID: <20241122210719.213373-23-lucas.demarchi@intel.com>
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

commit 6ef5a04221aaeb858d1a825b2ecb7e200cac80f8 upstream.

A recommended performance tuning for LNL related to L3 cache flushing
was recently introduced in Bspec. Implement it.

Unlike the other existing tuning settings, we limit this one for LNL
only, since there is no info about whether this would be applicable to
other platforms yet. In the future we can come back and use IP version
ranges if applicable.

v2:
  - Fix reference to Bspec. (Sai Teja, Tejas)
  - Use correct register name for "Tuning: L3 RW flush all Cache". (Sai
    Teja)
  - Use SCRATCH3_LBCF (with the underscore) for better readability.
v3:
  - Limit setting to LNL only. (Matt)

Bspec: 72161
Cc: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240920211459.255181-5-gustavo.sousa@intel.com
(cherry picked from commit 876253165f3eaaacacb8c8bed16a9df4b6081479)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 5 +++++
 drivers/gpu/drm/xe/xe_tuning.c       | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index d1b5be2585eda..224ab4a425258 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -380,6 +380,9 @@
 #define L3SQCREG3				XE_REG_MCR(0xb108)
 #define   COMPPWOVERFETCHEN			REG_BIT(28)
 
+#define SCRATCH3_LBCF				XE_REG_MCR(0xb154)
+#define   RWFLUSHALLEN				REG_BIT(17)
+
 #define XEHP_L3SQCREG5				XE_REG_MCR(0xb158)
 #define   L3_PWM_TIMER_INIT_VAL_MASK		REG_GENMASK(9, 0)
 
@@ -397,6 +400,8 @@
 
 #define XE2LPM_L3SQCREG3			XE_REG_MCR(0xb608)
 
+#define XE2LPM_SCRATCH3_LBCF			XE_REG_MCR(0xb654)
+
 #define XE2LPM_L3SQCREG5			XE_REG_MCR(0xb658)
 
 #define XE2_TDF_CTRL				XE_REG(0xb418)
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index c798ae1b3f750..0d5e04158917b 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -75,6 +75,14 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_ACTIONS(FIELD_SET(STATELESS_COMPRESSION_CTRL, UNIFIED_COMPRESSION_FORMAT,
 				   REG_FIELD_PREP(UNIFIED_COMPRESSION_FORMAT, 0)))
 	},
+	{ XE_RTP_NAME("Tuning: L3 RW flush all Cache"),
+	  XE_RTP_RULES(GRAPHICS_VERSION(2004)),
+	  XE_RTP_ACTIONS(SET(SCRATCH3_LBCF, RWFLUSHALLEN))
+	},
+	{ XE_RTP_NAME("Tuning: L3 RW flush all cache - media"),
+	  XE_RTP_RULES(MEDIA_VERSION(2000)),
+	  XE_RTP_ACTIONS(SET(XE2LPM_SCRATCH3_LBCF, RWFLUSHALLEN))
+	},
 
 	{}
 };
-- 
2.47.0


