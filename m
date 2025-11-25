Return-Path: <stable+bounces-196916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E9C85923
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 15:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E583AE261
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F186C31618F;
	Tue, 25 Nov 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEJzU0U5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22391C84BD
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082296; cv=none; b=GFz+IXHFPyH5Gcrj/pPpT2xXqMdR9HyVd1FFsDk8v916SgSOHc5WJ8vb3FyV39h0uwa1wIVPqTZd/RZ16oui5DpXm2081cALgmhNjhBHFSZGYgU3d74ehHB3RS9DqAaBDTSDfGHCCN+e48GkyfQ9LzJxOgfh0O6YS9zPL6+SQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082296; c=relaxed/simple;
	bh=IaSmwr9HabyDBMut3f2vhcmw1eRmxAS7egXbfuDkcoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJDOWc5sO3OTkB5DkvrT232MzVh9iW/l+D/rQEZAAbL4AzUwZW5+FIgFJ/5h6L6/Mm5qZEGLY7smy029q9ckoNawFEt4J/d8Ol2h6u/7N7blPnvjIysDWQUdsvmpT/jUfgK+EttyTuDc3MeT9W6jYzhuizceXIPgiLAg8K/QxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEJzU0U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E81C4CEF1;
	Tue, 25 Nov 2025 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764082296;
	bh=IaSmwr9HabyDBMut3f2vhcmw1eRmxAS7egXbfuDkcoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEJzU0U52JBaMMf9zHta0NEEu0l8I6OIvGf3vUbHD6HcNIymvJJXlNbBO7AW2KFRb
	 aUD+qQ6psdU9EI03IVyHDDz2YeGwaeQw/f1ydlofRDfde/JpCrfKwPvvLlcb8oAgZ8
	 wkILvGSyholjI2EPNqgJpNEMX+yjbHQFn2fqLf9vDf+P7qsb48q0S30XiG6fFmTojx
	 PN2VaWPjf/Se6D49Cb4BCadMIzVLLMDMnh+bmecd0BLsDL7IHqdy6HZzIzqCrqSG2F
	 wcMtQwdVCnylIUG1D44XXxO4+XO/o02bYozzfuoL2X81XMDlrCCC/LharVWv4n8UFv
	 nO+qcUcUuEOfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	"Ovidiu (Ovi) Bunea" <ovidiu.bunea@amd.com>,
	Yihan Zhu <yihan.zhu@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] drm/amd/display: Insert dccg log for easy debug
Date: Tue, 25 Nov 2025 09:51:30 -0500
Message-ID: <20251125145131.660280-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125145131.660280-1-sashal@kernel.org>
References: <2025112425-aspirin-conduit-e44b@gregkh>
 <20251125145131.660280-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit 35bcc9168f3ce6416cbf3f776758be0937f84cb3 ]

[why]
Log for sequence tracking

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: cfa0904a35fd ("drm/amd/display: Prevent Gating DTBCLK before It Is Properly Latched")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index ad910065f463f..a841eaafbaaa8 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -39,6 +39,7 @@
 
 #define CTX \
 	dccg_dcn->base.ctx
+#include "logger_types.h"
 #define DC_LOGGER \
 	dccg->ctx->logger
 
@@ -1132,7 +1133,7 @@ static void dcn35_set_dppclk_enable(struct dccg *dccg,
 	default:
 		break;
 	}
-	//DC_LOG_DEBUG("%s: dpp_inst(%d) DPPCLK_EN = %d\n", __func__, dpp_inst, enable);
+	DC_LOG_DEBUG("%s: dpp_inst(%d) DPPCLK_EN = %d\n", __func__, dpp_inst, enable);
 
 }
 
@@ -1400,6 +1401,10 @@ static void dccg35_set_dtbclk_dto(
 		 * PIPEx_DTO_SRC_SEL should not be programmed during DTBCLK update since OTG may still be on, and the
 		 * programming is handled in program_pix_clk() regardless, so it can be removed from here.
 		 */
+		DC_LOG_DEBUG("%s: OTG%d DTBCLK DTO enabled: pixclk_khz=%d, ref_dtbclk_khz=%d, req_dtbclk_khz=%d, phase=%d, modulo=%d\n",
+				__func__, params->otg_inst, params->pixclk_khz,
+				params->ref_dtbclk_khz, req_dtbclk_khz, phase, modulo);
+
 	} else {
 		switch (params->otg_inst) {
 		case 0:
@@ -1425,6 +1430,8 @@ static void dccg35_set_dtbclk_dto(
 
 		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
 		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
+
+		DC_LOG_DEBUG("%s: OTG%d DTBCLK DTO disabled\n", __func__, params->otg_inst);
 	}
 }
 
@@ -1469,6 +1476,8 @@ static void dccg35_set_dpstreamclk(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: dp_hpo_inst(%d) DPSTREAMCLK_EN = %d, DPSTREAMCLK_SRC_SEL = %d\n",
+			__func__, dp_hpo_inst, (src == REFCLK) ? 0 : 1, otg_inst);
 }
 
 
@@ -1508,6 +1517,8 @@ static void dccg35_set_dpstreamclk_root_clock_gating(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: dp_hpo_inst(%d) DPSTREAMCLK_ROOT_GATE_DISABLE = %d\n",
+			__func__, dp_hpo_inst, enable ? 1 : 0);
 }
 
 
@@ -1547,7 +1558,7 @@ static void dccg35_set_physymclk_root_clock_gating(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
-	//DC_LOG_DEBUG("%s: dpp_inst(%d) PHYESYMCLK_ROOT_GATE_DISABLE:\n", __func__, phy_inst, enable ? 0 : 1);
+	DC_LOG_DEBUG("%s: dpp_inst(%d) PHYESYMCLK_ROOT_GATE_DISABLE: %d\n", __func__, phy_inst, enable ? 0 : 1);
 
 }
 
@@ -1620,6 +1631,8 @@ static void dccg35_set_physymclk(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: phy_inst(%d) PHYxSYMCLK_EN = %d, PHYxSYMCLK_SRC_SEL = %d\n",
+			__func__, phy_inst, force_enable ? 1 : 0, clk_src);
 }
 
 static void dccg35_set_valid_pixel_rate(
@@ -1667,6 +1680,7 @@ static void dccg35_dpp_root_clock_control(
 	}
 
 	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
+	DC_LOG_DEBUG("%s: dpp_inst(%d) clock_on = %d\n", __func__, dpp_inst, clock_on);
 }
 
 static void dccg35_disable_symclk32_se(
@@ -1725,6 +1739,7 @@ static void dccg35_disable_symclk32_se(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+
 }
 
 static void dccg35_init_cb(struct dccg *dccg)
@@ -1732,7 +1747,6 @@ static void dccg35_init_cb(struct dccg *dccg)
 	(void)dccg;
 	/* Any RCG should be done when driver enter low power mode*/
 }
-
 void dccg35_init(struct dccg *dccg)
 {
 	int otg_inst;
@@ -1747,6 +1761,8 @@ void dccg35_init(struct dccg *dccg)
 		for (otg_inst = 0; otg_inst < 2; otg_inst++) {
 			dccg31_disable_symclk32_le(dccg, otg_inst);
 			dccg31_set_symclk32_le_root_clock_gating(dccg, otg_inst, false);
+			DC_LOG_DEBUG("%s: OTG%d SYMCLK32_LE disabled and root clock gating disabled\n",
+					__func__, otg_inst);
 		}
 
 //	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
@@ -1759,6 +1775,8 @@ void dccg35_init(struct dccg *dccg)
 			dccg35_set_dpstreamclk(dccg, REFCLK, otg_inst,
 						otg_inst);
 			dccg35_set_dpstreamclk_root_clock_gating(dccg, otg_inst, false);
+			DC_LOG_DEBUG("%s: OTG%d DPSTREAMCLK disabled and root clock gating disabled\n",
+					__func__, otg_inst);
 		}
 
 /*
-- 
2.51.0


