Return-Path: <stable+bounces-139722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4887AA9894
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A86A5A018E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA715AF6;
	Mon,  5 May 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbKkWsAr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AAC2AF0E
	for <stable@vger.kernel.org>; Mon,  5 May 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461843; cv=none; b=sdD1tKgDEOutZ5r1NOxKWiLi17lrzvnh8qE6sRQXk5x2a70b8x+K79sidBPX/4pFd95KptZuVXkg3/NxJykODCDSNYWqOm0CjO11y+2AMki0zkh0moEWeOWPpNmLDfif7ybKPWSiiWbMQRftklkxNt1pL79y8Fm4j0sDQWPgakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461843; c=relaxed/simple;
	bh=RsWxevde3NYOxElXu6u52MmKAcn95PaDssWMeV3dqjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSveqMO9oGio5kswhdJDJwfHkxnjXMX/N8AyvAAqQzqfqVENZy353P3XE8l02WSc/zbMPIJMepo/2CzmMltrbNulZqJGU2ODXnkLESEu3Qcwbv/isuJlfH33w+QXedC2e6alUeu4vbs35s/ZSvQIu+VpM5pACvSrWkoxIY+v4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbKkWsAr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746461842; x=1777997842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RsWxevde3NYOxElXu6u52MmKAcn95PaDssWMeV3dqjM=;
  b=VbKkWsAr6MflHfQxH1GR+OgzIuIGrs4ZHGn5CU7AwVSNhv3JJojar5bO
   N6P+ZntIGrsuAxOF+ClcQg4li2sPymVmYSJl8+QW5bTJRoMckk76pujPg
   tWCP+ZVbCbjzQq5nB//E4Bf/qfDsWjgeeJUIYHTaK1kgLM5pTS0rXGuRu
   JLCSDI5X7hOWUvMVOdfil8U4vOFbtik8Da533sQMiTL0VwnPs4lB/j2Jo
   IItt01GEa7S4n8DUpeNT8A07nkYKFc987ShaOdraGHD56VCjqBBGxQqjH
   yjA/o2xva5DoNRbBjMZKuMmd7c+ILp99i9i8rxMQpOeWMUtCOO36fGc0X
   g==;
X-CSE-ConnectionGUID: VKzrf3FlQc6LgF1UNEZvPA==
X-CSE-MsgGUID: 4k9vGfcER5Wd7Bu3bjBz8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47990536"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47990536"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 09:16:56 -0700
X-CSE-ConnectionGUID: CEhL8p8GRr6Lp/83xu4QEQ==
X-CSE-MsgGUID: 3oXy6N9rQ5uNWtA6Z5+kOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135277692"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 09:16:55 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.12.y] drm/xe: Ensure fixed_slice_mode gets set after ccs_mode change
Date: Mon,  5 May 2025 09:13:17 -0700
Message-ID: <20250505161316.3451888-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042256-unshackle-unwashed-bd50@gregkh>
References: <2025042256-unshackle-unwashed-bd50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

The RCU_MODE_FIXED_SLICE_CCS_MODE setting is not getting invoked
in the gt reset path after the ccs_mode setting by the user.
Add it to engine register update list (in hw_engine_setup_default_state())
which ensures it gets set in the gt reset and engine reset paths.

v2: Add register update to engine list to ensure it gets updated
after engine reset also.

Fixes: 0d97ecce16bd ("drm/xe: Enable Fixed CCS mode setting")
Cc: stable@vger.kernel.org
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://lore.kernel.org/r/20250327185604.18230-1-niranjana.vishwanathapura@intel.com
(cherry picked from commit 12468e519f98e4d93370712e3607fab61df9dae9)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 262de94a3a7ef23c326534b3d9483602b7af841e)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_hw_engine.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index b11bc0f00dfda..0248597c6269a 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -381,12 +381,6 @@ xe_hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 				 blit_cctl_val,
 				 XE_RTP_ACTION_FLAG(ENGINE_BASE)))
 		},
-		/* Use Fixed slice CCS mode */
-		{ XE_RTP_NAME("RCU_MODE_FIXED_SLICE_CCS_MODE"),
-		  XE_RTP_RULES(FUNC(xe_hw_engine_match_fixed_cslice_mode)),
-		  XE_RTP_ACTIONS(FIELD_SET(RCU_MODE, RCU_MODE_FIXED_SLICE_CCS_MODE,
-					   RCU_MODE_FIXED_SLICE_CCS_MODE))
-		},
 		/* Disable WMTP if HW doesn't support it */
 		{ XE_RTP_NAME("DISABLE_WMTP_ON_UNSUPPORTED_HW"),
 		  XE_RTP_RULES(FUNC(xe_rtp_cfeg_wmtp_disabled)),
@@ -454,6 +448,12 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 		  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0), CS_PRIORITY_MEM_READ,
 				     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
 		},
+		/* Use Fixed slice CCS mode */
+		{ XE_RTP_NAME("RCU_MODE_FIXED_SLICE_CCS_MODE"),
+		  XE_RTP_RULES(FUNC(xe_hw_engine_match_fixed_cslice_mode)),
+		  XE_RTP_ACTIONS(FIELD_SET(RCU_MODE, RCU_MODE_FIXED_SLICE_CCS_MODE,
+					   RCU_MODE_FIXED_SLICE_CCS_MODE))
+		},
 		{}
 	};
 
-- 
2.49.0


