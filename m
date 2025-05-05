Return-Path: <stable+bounces-140693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942B0AAAEAD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABB616A5C6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2141A2820A5;
	Mon,  5 May 2025 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4eGLx0z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B437BE28;
	Mon,  5 May 2025 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485973; cv=none; b=aSpwHIV6yNV3z7y/qMCEc6H4fsZU4vfSc7odKQllK4y8dDHpsO/JJ6W8pMPODs3vYEYSKMoXLISdGzjr8H4wqv3OYuD7gpKjicVW+1O4o+TjrvhrFZ2x2Y5XUjPnU43VzYkoARxZWEbIo6ac4DgcHSAXSDOHpsBDEFZPz1qwM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485973; c=relaxed/simple;
	bh=sggkn5Buws6iQxZ0z5gA8d/UmGBYOyuOaEJ/3vTAaBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EO2JrUqa6eub7Q/lFWrhBZdaEFN8zThW2F6eh0+GVAdTeELiF2anaAg+0ZokqaITkkzpEQ1By654GkubHduvNBCLneQ1Ggsm1WOO9MIbvB7fuUQDc44aEaLw1SQy3f9rx0xGzP47EkkXKEgFom/22Cc77rPxCGnLMaz/3CXrF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4eGLx0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7117C4CEE4;
	Mon,  5 May 2025 22:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485972;
	bh=sggkn5Buws6iQxZ0z5gA8d/UmGBYOyuOaEJ/3vTAaBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4eGLx0zUEZJqpsqlUH/hPm9GBaYAq7xOW4pAhjGwDQZWkUONoieiA4aoYDSYIAIm
	 6/XD+xnnRlCBjcnxJxU7N9/JJ7Mzl5fHRhEdxBBoFZYhx+pdG/wP/tHfH2h+qPl2eK
	 J9sNE/KHeKYVLJzHH/VYQIq3sBskyL4+A+HGzOIvOcokJrNcsjSEI/+2eszUU5Glzj
	 23XfDIB5POCDJCzbnnTD0yWJQlJ4u4h93cSr+c70ui5JXlY7UYGmDwCUnLl/KiV9km
	 Lz4+j8keZNJknJUdyGrf8Asoray+AxWIDV+UTcaK+xbzHQa43fFhxlxuiUHA9t6SUh
	 Jc49okJTWEqCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	chris.park@amd.com,
	Jing.Zhou@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 093/294] drm/amd/display: remove minimum Dispclk and apply oem panel timing.
Date: Mon,  5 May 2025 18:53:13 -0400
Message-Id: <20250505225634.2688578-93-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit 756e58e83e89d372b94269c0cde61fe55da76947 ]

[why & how]
1. apply oem panel timing (not only on OLED)
2. remove MIN_DPP_DISP_CLK request in driver.

This fix will apply for dcn31x but not
sync with DML's output.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c | 2 --
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c    | 3 ++-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index ebeb969ee180b..327776eeb9f3e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -194,8 +194,6 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
 	if (new_clocks->dppclk_khz < MIN_DPP_DISP_CLK)
 		new_clocks->dppclk_khz = MIN_DPP_DISP_CLK;
-	if (new_clocks->dispclk_khz < MIN_DPP_DISP_CLK)
-		new_clocks->dispclk_khz = MIN_DPP_DISP_CLK;
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 6f1785715dfb7..f95e5e767eb1a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -201,8 +201,6 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
 	if (new_clocks->dppclk_khz < 100000)
 		new_clocks->dppclk_khz = 100000;
-	if (new_clocks->dispclk_khz < 100000)
-		new_clocks->dispclk_khz = 100000;
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 7b5c1498941dd..d389eeb264a79 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1066,7 +1066,8 @@ void dce110_edp_backlight_control(
 			DC_LOG_DC("edp_receiver_ready_T9 skipped\n");
 	}
 
-	if (!enable && link->dpcd_sink_ext_caps.bits.oled) {
+	if (!enable) {
+		/*follow oem panel config's requirement*/
 		pre_T11_delay += link->panel_config.pps.extra_pre_t11_ms;
 		msleep(pre_T11_delay);
 	}
-- 
2.39.5


