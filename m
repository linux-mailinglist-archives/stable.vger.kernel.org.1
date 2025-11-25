Return-Path: <stable+bounces-196906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB4EC85412
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9434F3B279E
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BA123817D;
	Tue, 25 Nov 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fodp/36H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2ACA5A
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078675; cv=none; b=hPdnXCofo7+NiiuQCfpCNXtgPAz9Jir68GsmHnUlCzNVLT+cfLmX3cfwi26kHDrwzUJi7frBD2lEosqmIRSxcY6N/KaiUPRjOEUQT77XM1cAGvI9oHzdHf1rDMHc6jPZtQ4iX1H5zLLBASNLPGdYAF8Cl9hPdccXLVofVMhSayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078675; c=relaxed/simple;
	bh=gQQUq15/5O7zMwEp5yo0ECZ2VS0pen039cgkhD0dos0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEpHwswp+6MFmTphbGV+UIc6VpGoMBmc/vo4LX8GE1WN1t4SXN/EGK9jPBfvQ00jKHRR+IlvvBu8OcucgVgJWlp2P3L0aqJDriwVpe3/l79IALFwLofyBclTtVNHdhI5OxCNz2nkaIzuflVwuzfrw0zzAujMomZS0yUxATMTf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fodp/36H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9336C19422;
	Tue, 25 Nov 2025 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764078674;
	bh=gQQUq15/5O7zMwEp5yo0ECZ2VS0pen039cgkhD0dos0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fodp/36HTx8fPpRasNjoiDZ4ix9M3twDXpdEtPCdxxWoirLj2bZ8T0dbg8ZSo3rBN
	 E1hoUFlJ66IsLMW3WCPj5BSTRtAZr0MOr6p+6Mf0XDxIyByUnLST1exRcB4Qc0ncm4
	 wuCCuJ7oCtgvcUD+dlNCwDBBc0g1RuA+plQutNjpRAzyZ6iA7PZTsfREERSUGfHgDb
	 7fA2YgHi0JJCBNgwES/YRjNNastbPeHHbO83/HrhXqcAOvZv/vN63NHch436njYfnD
	 1WzqZQiV9KNWoz0sNftTgsm68MrvB+YPa5tqStquhfClw2ZcSj0kAZ20LzCDf/iLGs
	 T8P6in/+JMBqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	"Ovidiu (Ovi) Bunea" <ovidiu.bunea@amd.com>,
	Yihan Zhu <yihan.zhu@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] drm/amd/display: Insert dccg log for easy debug
Date: Tue, 25 Nov 2025 08:51:11 -0500
Message-ID: <20251125135112.591587-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112424-handball-smolder-0f15@gregkh>
References: <2025112424-handball-smolder-0f15@gregkh>
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
index 0ce9489ac6b72..de6d62401362e 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -39,6 +39,7 @@
 
 #define CTX \
 	dccg_dcn->base.ctx
+#include "logger_types.h"
 #define DC_LOGGER \
 	dccg->ctx->logger
 
@@ -1136,7 +1137,7 @@ static void dcn35_set_dppclk_enable(struct dccg *dccg,
 	default:
 		break;
 	}
-	//DC_LOG_DEBUG("%s: dpp_inst(%d) DPPCLK_EN = %d\n", __func__, dpp_inst, enable);
+	DC_LOG_DEBUG("%s: dpp_inst(%d) DPPCLK_EN = %d\n", __func__, dpp_inst, enable);
 
 }
 
@@ -1406,6 +1407,10 @@ static void dccg35_set_dtbclk_dto(
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
@@ -1431,6 +1436,8 @@ static void dccg35_set_dtbclk_dto(
 
 		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
 		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
+
+		DC_LOG_DEBUG("%s: OTG%d DTBCLK DTO disabled\n", __func__, params->otg_inst);
 	}
 }
 
@@ -1475,6 +1482,8 @@ static void dccg35_set_dpstreamclk(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: dp_hpo_inst(%d) DPSTREAMCLK_EN = %d, DPSTREAMCLK_SRC_SEL = %d\n",
+			__func__, dp_hpo_inst, (src == REFCLK) ? 0 : 1, otg_inst);
 }
 
 
@@ -1514,6 +1523,8 @@ static void dccg35_set_dpstreamclk_root_clock_gating(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: dp_hpo_inst(%d) DPSTREAMCLK_ROOT_GATE_DISABLE = %d\n",
+			__func__, dp_hpo_inst, enable ? 1 : 0);
 }
 
 
@@ -1553,7 +1564,7 @@ static void dccg35_set_physymclk_root_clock_gating(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
-	//DC_LOG_DEBUG("%s: dpp_inst(%d) PHYESYMCLK_ROOT_GATE_DISABLE:\n", __func__, phy_inst, enable ? 0 : 1);
+	DC_LOG_DEBUG("%s: dpp_inst(%d) PHYESYMCLK_ROOT_GATE_DISABLE: %d\n", __func__, phy_inst, enable ? 0 : 1);
 
 }
 
@@ -1626,6 +1637,8 @@ static void dccg35_set_physymclk(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: phy_inst(%d) PHYxSYMCLK_EN = %d, PHYxSYMCLK_SRC_SEL = %d\n",
+			__func__, phy_inst, force_enable ? 1 : 0, clk_src);
 }
 
 static void dccg35_set_valid_pixel_rate(
@@ -1673,6 +1686,7 @@ static void dccg35_dpp_root_clock_control(
 	}
 
 	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
+	DC_LOG_DEBUG("%s: dpp_inst(%d) clock_on = %d\n", __func__, dpp_inst, clock_on);
 }
 
 static void dccg35_disable_symclk32_se(
@@ -1731,6 +1745,7 @@ static void dccg35_disable_symclk32_se(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+
 }
 
 static void dccg35_init_cb(struct dccg *dccg)
@@ -1738,7 +1753,6 @@ static void dccg35_init_cb(struct dccg *dccg)
 	(void)dccg;
 	/* Any RCG should be done when driver enter low power mode*/
 }
-
 void dccg35_init(struct dccg *dccg)
 {
 	int otg_inst;
@@ -1753,6 +1767,8 @@ void dccg35_init(struct dccg *dccg)
 		for (otg_inst = 0; otg_inst < 2; otg_inst++) {
 			dccg31_disable_symclk32_le(dccg, otg_inst);
 			dccg31_set_symclk32_le_root_clock_gating(dccg, otg_inst, false);
+			DC_LOG_DEBUG("%s: OTG%d SYMCLK32_LE disabled and root clock gating disabled\n",
+					__func__, otg_inst);
 		}
 
 //	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
@@ -1765,6 +1781,8 @@ void dccg35_init(struct dccg *dccg)
 			dccg35_set_dpstreamclk(dccg, REFCLK, otg_inst,
 						otg_inst);
 			dccg35_set_dpstreamclk_root_clock_gating(dccg, otg_inst, false);
+			DC_LOG_DEBUG("%s: OTG%d DPSTREAMCLK disabled and root clock gating disabled\n",
+					__func__, otg_inst);
 		}
 
 /*
-- 
2.51.0


