Return-Path: <stable+bounces-196914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A09FBC8593B
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 15:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 768954EAD87
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66B32573D;
	Tue, 25 Nov 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iChE5rGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC213AD05
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082294; cv=none; b=Ue58SyPqMcnCwX0dfA28w2qDn/vLt40TAszx/Nyf25Flz6iWorXQPwCWUZbBuw/NooVC+tspt6vtLfXaGVLpa+gZ4kUpQZWLO+qSd/6ljjTy5cNKW3gbsL4KIYNU/q8CnsnZaFlQJ76TL4wwabXSxFnPJ3mxWLh0UnzAHiTcvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082294; c=relaxed/simple;
	bh=Ey6w58vLII2CKS6dwmiVSK2wcIv+g4/o3TyfkrW4LLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWnmxnazwwkP5VsihXSaJipmjwrAs996OjUVcAb67VbugLeFEQdyGrnJT/MK5R7ZUjAyk0NI3F5S2VRS16VNG2KqhWDlorR/gdnVttckk5sVp+0R1lFNrD5k3ugZGmEX2AJcIt3MX29gE4Hm+IT22aUjGdrjZaFBnR9J8/UF/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iChE5rGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D88C4CEF1;
	Tue, 25 Nov 2025 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764082294;
	bh=Ey6w58vLII2CKS6dwmiVSK2wcIv+g4/o3TyfkrW4LLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iChE5rGOQHsAuCI+2u58ga6ylnWfUEE6LTpmF3jzdCnHBXiPr7CGDlnqvlK3bvqjG
	 klMl/IDZdNDJJsFtU/fqo2JFjYnkj0qkLOLhLIKoB9vSb9wp3TnmIbahSXZ0B/mxfA
	 oqgWdog9FlM0G5fs5MfEQ0WWPk8GC5OaU76Z7oCw9EzYLPvlndv/hVbPWFHOPoJVJB
	 dhHSPs8ECgLn7yEgjzTtT93jggP5mznlpUcB+45rFXBQaGiiIuvPPcVyj9qs+Dsawj
	 GfwMR3DTngx4nDUUtjjSmdZgLF4fipdRO+Pw6T8Ew5GU0rcN8ui+6Ks3drNtdmQp+u
	 F8aKZooVuzT0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Martin Leung <martin.leung@amd.com>,
	Ausef Yousof <Ausef.Yousof@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] drm/amd/display: avoid reset DTBCLK at clock init
Date: Tue, 25 Nov 2025 09:51:28 -0500
Message-ID: <20251125145131.660280-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112425-aspirin-conduit-e44b@gregkh>
References: <2025112425-aspirin-conduit-e44b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit 0ae47e971b9add8f7b8f8d55ac5f407f6f346758 ]

[why & how]
this is to init to HW real DTBCLK.
and use real HW DTBCLK status to update internal logic state

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: cfa0904a35fd ("drm/amd/display: Prevent Gating DTBCLK before It Is Properly Latched")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index a4ac601a30c35..3114b3fae9eff 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -393,6 +393,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (clk_mgr_base->clks.dtbclk_en && !new_clocks->dtbclk_en) {
 			if (clk_mgr->base.ctx->dc->config.allow_0_dtb_clk)
 				dcn35_smu_set_dtbclk(clk_mgr, false);
+
 			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
 		}
 		/* check that we're not already in lower */
@@ -410,11 +411,17 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 
 		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
-			dcn35_smu_set_dtbclk(clk_mgr, true);
-			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+			int actual_dtbclk = 0;
 
 			dcn35_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
-			clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
+			dcn35_smu_set_dtbclk(clk_mgr, true);
+
+			actual_dtbclk = REG_READ(CLK1_CLK4_CURRENT_CNT);
+
+			if (actual_dtbclk) {
+				clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
+				clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+			}
 		}
 
 		/* check that we're not already in D0 */
@@ -581,12 +588,10 @@ static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
 
 static void init_clk_states(struct clk_mgr *clk_mgr)
 {
-	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
+
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 
-	if (clk_mgr_int->smu_ver >= SMU_VER_THRESHOLD)
-		clk_mgr->clks.dtbclk_en = true; // request DTBCLK disable on first commit
 	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
 	clk_mgr->clks.prev_p_state_change_support = true;
@@ -597,6 +602,7 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
+
 	init_clk_states(clk_mgr);
 
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
-- 
2.51.0


