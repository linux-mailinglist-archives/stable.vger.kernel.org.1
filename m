Return-Path: <stable+bounces-77248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D783985AE8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B3EB25718
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6098318FDC5;
	Wed, 25 Sep 2024 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbcXC1Kw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33317DFE3;
	Wed, 25 Sep 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264774; cv=none; b=EqSQRGJr1AfTOI55W+qIQ646W+OloT17fJ0xClXcGgAq9hLZxzpp+BkpM+WR7/HuSkm1r5gDHTa3Mr6RLsHg9UiEUXdVrUx4dPPrdHbDmxigATYNYWBiNEC29aOxyyt0iLFSkH+LXaNvdxGAwOS9D5mFqQF8+FzHGvTf0dy1xOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264774; c=relaxed/simple;
	bh=hlE0qSYSzfewwyMkimkKOWLgsjezbHjR0is1R05Wqvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFnzoLS4t6VcilrE09xsfeGR474Fu0SSpRYHNvb00jhpV21w1c0dtAYrizpq9dASBI8sYs2IP10xPuAZnJTPRUiy0V/Nf55H/M2uK7UeQNaptHZ0GL5m1BzViQ9w3rGu17NvY/rCUv2kdicxS+3y49isIYaHOKosEhiUaEsl7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbcXC1Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E44FC4CEC3;
	Wed, 25 Sep 2024 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264773;
	bh=hlE0qSYSzfewwyMkimkKOWLgsjezbHjR0is1R05Wqvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbcXC1Kwd9kN/70/WyUOlM6MxWtp+w8Y/r8knktmO35TiYFg14JsKaUBx59vX025k
	 dePjY3vCqvh4Y1knICBtjy/th1mBYQuDcnMFH41uW8W0bB85mX1aZ0n8aIESqjlA6I
	 gezDDSHevdyjWrtXuM7QQRhE5eETd0ME7gIUpVWgPnus3zVOc9WTIqeDSHUXGTP7lS
	 RIGryMjCDnekr7xtF8fXdKHZX0jseEFHZG38gQbHxjTCLhNUA7UUgVwgWt2y9swyEG
	 YGw/PihFR9aHfGnWWF6ya5aMea1TSGOE8bBx5hf6R937jLUZEr+Lth6nDsmZ90iZmD
	 a5zYvwlrWL//g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Sa <Daniel.Sa@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	sarvinde@amd.com,
	nevenko.stupar@amd.com,
	wenjing.liu@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 150/244] drm/amd/display: Underflow Seen on DCN401 eGPU
Date: Wed, 25 Sep 2024 07:26:11 -0400
Message-ID: <20240925113641.1297102-150-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Daniel Sa <Daniel.Sa@amd.com>

[ Upstream commit ca0fb243c3bb53dbbd71d16c76f319bf923ee3d4 ]

[WHY]
In dcn401 we read clock values before FW is loaded. These incorrect
values cause the driver to believe that we are running higher clocks
than what we actually have. This then causes corruption/underflow for
the eGPU.

[HOW]
When new values are read from HW, update internal structures to
propagate the new/correct value. Fixes issue

Signed-off-by: Daniel Sa <Daniel.Sa@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 324e77ceaf1cf..537a24ec74c85 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -221,6 +221,7 @@ void dcn401_init_hw(struct dc *dc)
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
+	int current_dchub_ref_freq = 0;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -264,6 +265,8 @@ void dcn401_init_hw(struct dc *dc)
 					dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
 					&res_pool->ref_clocks.dccg_ref_clock_inKhz);
 
+			current_dchub_ref_freq = res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
+
 			(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
 					res_pool->ref_clocks.dccg_ref_clock_inKhz,
 					&res_pool->ref_clocks.dchub_ref_clock_inKhz);
@@ -436,8 +439,9 @@ void dcn401_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 		dc->debug.fams2_config.bits.enable &= dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver == 2;
-		if (!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box) {
-			/* update bounding box if FAMS2 disabled */
+		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
+			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
+			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
 			if (dc->clk_mgr)
 				dc->res_pool->funcs->update_bw_bounding_box(dc,
 									    dc->clk_mgr->bw_params);
-- 
2.43.0


