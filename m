Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14C783344
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHUTxA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjHUTxA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D5EE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C178644CB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B726C433C9;
        Mon, 21 Aug 2023 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647577;
        bh=ezisZm18b9jUfQwk6xu89SQhU72JkvxWwDgWU1CXz64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyvW0w6LXS1c+z79fv9zKpZBdiEHmZuEVFkTBaoUsZs/OxtzEGZcO0zy1EcVc61uK
         GrXPpPXL2ucMbPQNdjhUwIOM0bxnlwZfoWoAeA0E4FuSvZNquL2mNmyHDTUzP6oPhP
         yZXtfKJWdFGgdiOKwqL3qApC44hRrMK+rk39/Jbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stylon Wang <stylon.wang@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Jun Lei <jun.lei@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 034/194] drm/amd/display: Skip DPP DTO update if root clock is gated
Date:   Mon, 21 Aug 2023 21:40:13 +0200
Message-ID: <20230821194124.290485323@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 30f90f3c1c2c63c2fa44f61233737d27b72637c2 ]

[Why]
Hardware implements root clock gating by utilizing the DPP DTO registers
with a special case of DTO enabled, phase = 0, modulo = 1. This
conflicts with our policy to always update the DPPDTO for cases where
it's expected to be disabled.

The pipes unexpectedly enter a higher power state than expected because
of this programming flow.

[How]
Guard the upper layers of HWSS against this hardware quirk with
programming the register with an internal state flag in DCCG.

While technically acting as global state for the DCCG, HWSS shouldn't be
expected to understand the hardware quirk for having DTO disabled
causing more power than DTO enabled with this specific setting.

This also prevents sequencing errors from occuring in the future if
we have to program DPP DTO in multiple locations.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c   | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h        | 1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 7d2b982506fd7..cef32a1f91cdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -47,6 +47,14 @@ void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	if (dccg->dpp_clock_gated[dpp_inst]) {
+		/*
+		 * Do not update the DPPCLK DTO if the clock is stopped.
+		 * It is treated the same as if the pipe itself were in PG.
+		 */
+		return;
+	}
+
 	if (dccg->ref_dppclk && req_dppclk) {
 		int ref_dppclk = dccg->ref_dppclk;
 		int modulo, phase;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 85ea3334355c2..97c6a79dfba66 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -296,6 +296,9 @@ static void dccg314_dpp_root_clock_control(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	if (dccg->dpp_clock_gated[dpp_inst] == clock_on)
+		return;
+
 	if (clock_on) {
 		/* turn off the DTO and leave phase/modulo at max */
 		REG_UPDATE(DPPCLK_DTO_CTRL, DPPCLK_DTO_ENABLE[dpp_inst], 0);
@@ -309,6 +312,8 @@ static void dccg314_dpp_root_clock_control(
 			  DPPCLK0_DTO_PHASE, 0,
 			  DPPCLK0_DTO_MODULO, 1);
 	}
+
+	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
 }
 
 static const struct dccg_funcs dccg314_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index ad6acd1b34e1d..9651cccb084a3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -68,6 +68,7 @@ struct dccg {
 	const struct dccg_funcs *funcs;
 	int pipe_dppclk_khz[MAX_PIPES];
 	int ref_dppclk;
+	bool dpp_clock_gated[MAX_PIPES];
 	//int dtbclk_khz[MAX_PIPES];/* TODO needs to be removed */
 	//int audio_dtbclk_khz;/* TODO needs to be removed */
 	//int ref_dtbclk_khz;/* TODO needs to be removed */
-- 
2.40.1



