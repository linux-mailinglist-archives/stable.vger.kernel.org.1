Return-Path: <stable+bounces-43320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FF08BF1B2
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11ECC1F21875
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750BB145B2D;
	Tue,  7 May 2024 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wao8AwrU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B313664C;
	Tue,  7 May 2024 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123380; cv=none; b=CDR9ma/0MUbt7i7ZNja5Sk1T7kgQTmPntj/rzlMqrhzis/SoLSUQwaxGfh4tGTxCbyhvv+tlFNojZvuuzmmgCteywTEOYeoY+WLW9AadXkI2tsPrRIIVKXfJA5MDFHv2yOgJfpGBMan0bKo6Ae/k/nQxT9cuL6VzhwsB16ZKGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123380; c=relaxed/simple;
	bh=o4kHvtL5xP3bfDqpKz/1lp/LoNHKKqwR2ufyRf54P4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bw/BUooInhQPoL9NaTDRLMFDB5ODcbuvijwJ9hirDyh8ZVpAFSN9/LeU4aBCc5alcR48PHPMO64i7AA5IrLUGU7uDVsid+9ag/OeltP3zrYK4CiSOYh9ob8LHRfUmECaWhJS0TJ8DoZltyPqFHq8lRutWcf61VHugfdxxM1qhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wao8AwrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435BBC4AF67;
	Tue,  7 May 2024 23:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123379;
	bh=o4kHvtL5xP3bfDqpKz/1lp/LoNHKKqwR2ufyRf54P4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wao8AwrUxf3PElJFbZDlEtTIde5iRzAL0p6GMBp8OGlr4LqFQ1+LSbKE9EcpFYWQr
	 YML27WFulPqId4/M+uJPz84RCGVysLMTB60c5cYnHZxnKa+BeWTYulafmX24tFH6Um
	 LNkV8JIaLhAJ0iGwGW0Ajh6UrnMVKz79d8Ac0UNJdJlx+eV83HVRK0koQgj6sRTydz
	 GnxEj2wxGlFQchp26zNv7f5vPdUiZy1BkSrYtb+2azGQUEI8CDdFSiYNcNHWOypqJS
	 A4I4Muii6FkL1EJkPFBkk/f/oMwC0u66ZCzFIg/dwWcKHdRY8Tvt8GjYyvBgCUUsGR
	 ZnOR21dFfqgNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Ma <hanghong.ma@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	samson.tam@amd.com,
	stylon.wang@amd.com,
	relja.vojvodic@amd.com,
	etbitnun@amd.com,
	charlene.liu@amd.com,
	wenjing.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 41/52] drm/amd/display: Fix DC mode screen flickering on DCN321
Date: Tue,  7 May 2024 19:07:07 -0400
Message-ID: <20240507230800.392128-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Leo Ma <hanghong.ma@amd.com>

[ Upstream commit ce649bd2d834db83ecc2756a362c9a1ec61658a5 ]

[Why && How]
Screen flickering saw on 4K@60 eDP with high refresh rate external
monitor when booting up in DC mode. DC Mode Capping is disabled
which caused wrong UCLK being used.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index bbdbc78161a00..39c63565baa9a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -696,8 +696,12 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 					 * since we calculate mode support based on softmax being the max UCLK
 					 * frequency.
 					 */
-					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-							dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+					if (dc->debug.disable_dc_mode_overwrite) {
+						dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+					} else
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+								dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
 				} else {
 					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
 				}
@@ -730,8 +734,13 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 		if (clk_mgr_base->clks.p_state_change_support &&
 				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support) &&
-				!dc->work_arounds.clock_update_disable_mask.uclk)
+				!dc->work_arounds.clock_update_disable_mask.uclk) {
+			if (dc->clk_mgr->dc_mode_softmax_enabled && dc->debug.disable_dc_mode_overwrite)
+				dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
+						max((int)dc->clk_mgr->bw_params->dc_mode_softmax_memclk, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz)));
+
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+		}
 
 		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
 				clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
-- 
2.43.0


