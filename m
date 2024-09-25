Return-Path: <stable+bounces-77237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8574985ABE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464B2B26FD1
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109918661D;
	Wed, 25 Sep 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHy/PIoB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8A1684A3;
	Wed, 25 Sep 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264711; cv=none; b=kvF+O1fWVFTLJX3UT/jIhYnhhmEqVEZI9kE0/v7CjlqMTNz2exR5FWxBgZeFMFqjjOaWF2nOKrkHtWLCL+dTxr0aVnza8aMc+ieQSUm4fgTk5T+nL5V2qzZPDHSUhlnzpH/3gZUzbVe78bcLg0XTF0q4Xr0IHMANW4Wz2/mmRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264711; c=relaxed/simple;
	bh=2umWCApZyNpk4A0pT5pMgijLZdoRk0VLQXP0JmuqwL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOAeUMRAwXPR8QNYrPt0ZLWewB7z/2ID+v0/1eD3zN199ncSFbUljcf1r8LFI4y4UeTOB8kgMyN7J03iDibdH/uMrS+JptK2T79Hp3G/1Mgxl53QXgRWHWDGZn0xwN4sWm5qPfLZK9ImoCOX34coHd0FjhXGSbBT+401stlXqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHy/PIoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0369CC4CEC3;
	Wed, 25 Sep 2024 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264711;
	bh=2umWCApZyNpk4A0pT5pMgijLZdoRk0VLQXP0JmuqwL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHy/PIoBFH1oTd8dklxDrJ2hHioHIch2WE8fx2cStyoyS7OQ6/ULV8w3yDedPUjLe
	 /L9i18gHrIdxTSg61cssWtJ9//RtOHrgH1ikAwDXjLyHXZyEU/HrM+7ahr5LOF3Usw
	 CcSdAJ1K5EkoSXxA2AbOxcScXIugqMEUsJYbZJX2I/CqOktMvrjp4kaBIZLca2mlUJ
	 xfz1/gEHRdnVG0xNodUT6nRExxgNJOIkNqub1I4ljE3Na1rJmzba9PeGcUCGtrdYK2
	 pFoY4dgJ3bXJAOmsaSHF2JTvRW4g1Jm7fr9y2C6R/F3Zp5Q0Lbe1M5Wn6IuHawMmO/
	 CzlFwiCDDm26g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sarvinde@amd.com,
	alvin.lee2@amd.com,
	nevenko.stupar@amd.com,
	wenjing.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 139/244] drm/amd/display: Add NULL check for clk_mgr and clk_mgr->funcs in dcn401_init_hw
Date: Wed, 25 Sep 2024 07:26:00 -0400
Message-ID: <20240925113641.1297102-139-sashal@kernel.org>
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 4b6377f0e96085cbec96eb7f0b282430ccdd3d75 ]

This commit addresses a potential null pointer dereference issue in the
`dcn401_init_hw` function. The issue could occur when `dc->clk_mgr` or
`dc->clk_mgr->funcs` is null.

The fix adds a check to ensure `dc->clk_mgr` and `dc->clk_mgr->funcs` is
not null before accessing its functions. This prevents a potential null
pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c:416 dcn401_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 225)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 2c50c0f745a0b..324e77ceaf1cf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -222,7 +222,7 @@ void dcn401_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks) {
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 		// mark dcmode limits present if any clock has distinct AC and DC values from SMU
@@ -413,7 +413,7 @@ void dcn401_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
 	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
@@ -438,7 +438,9 @@ void dcn401_init_hw(struct dc *dc)
 		dc->debug.fams2_config.bits.enable &= dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver == 2;
 		if (!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box) {
 			/* update bounding box if FAMS2 disabled */
-			dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
+			if (dc->clk_mgr)
+				dc->res_pool->funcs->update_bw_bounding_box(dc,
+									    dc->clk_mgr->bw_params);
 		}
 	}
 }
-- 
2.43.0


