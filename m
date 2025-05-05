Return-Path: <stable+bounces-141107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F2AAB0EA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31ECB7BD58F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D631A0F9;
	Tue,  6 May 2025 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odUNH7Or"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF129B772;
	Mon,  5 May 2025 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485084; cv=none; b=MWhTJoQFGrTk+nSXA3b2Hltl/Wxdpt3uX2hqbQ5kOlaIgVnm5HE7UIvNYytGnzGHy0aNt6O6I4SNb948PCDgR4Q1nC/VQy6FzSsrw1+Tlp8wQRxmkQGmJrAgcafYgjHaDzRbsTYiVa25wOGTg/3Ajab2MOdb5v7iLFkQzwHya6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485084; c=relaxed/simple;
	bh=r4owExykd1gb7SwgvHpNEzM1cVWmLdXMaFCUsw2L4bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLAgxDuhf8rT3BfwrdXktkWDmpUd+22b0E0AdtFpSEWwFJVqnaROG4SpIqgCGibrAYNZKxSzj8rFLL4PkKWHQVius5uRYhMQgd5I+zH6AgQOlkrPEO1QtoQXRcGH3qDNjU1Uu1GsIWy3s7JqnX4cC2/fjKAWu9uzACJClnpLtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odUNH7Or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD522C4CEE4;
	Mon,  5 May 2025 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485083;
	bh=r4owExykd1gb7SwgvHpNEzM1cVWmLdXMaFCUsw2L4bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odUNH7OrAQUrM5AlY5our0p9JnfaV1CMJSMimooHN5wFegjTWETOGerYZ2L69A2Wj
	 LuTjxaoGYdXlp3gEjQM7LviVWATWOCFJRD+uH280l5ett5PpyPztZsyftDGLagUh6d
	 OGIgQOIRDQ5T7Z+c9glOXrkeGOhrf4JgL1kHaQtB1LyGVmzqYBt0kcUiyK/9uKmmLW
	 AtjYrCtcRfYPfweHxG6HEs9K8USl+XGOzMajgQD9w/e4mNWGv1hzKx5gU9klko5sYP
	 KqOl8eOKtAIcD1tkfUA8OpHtWvbNVxwjlY5L9Eo/akx8dtpRxKU3Keh/KaDOoh/K1Y
	 3cZ2uBBn9FqaQ==
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
	hamzamahfooz@linux.microsoft.com,
	Jing.Zhou@amd.com,
	alvin.lee2@amd.com,
	jerry.zuo@amd.com,
	Kaitlyn.Tse@amd.com,
	ryanseto@amd.com,
	martin.tsai@amd.com,
	yi-lchen@amd.com,
	tjakobi@math.uni-bielefeld.de,
	Sungjoon.Kim@amd.com,
	michael.strauss@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 156/486] drm/amd/display: remove minimum Dispclk and apply oem panel timing.
Date: Mon,  5 May 2025 18:33:52 -0400
Message-Id: <20250505223922.2682012-156-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c      | 3 ++-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 827b24b3442ad..e4d22f74f9869 100644
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
index 37c39756fece4..49efea0c8fcff 100644
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
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4fbed0298adfa..297f313794e49 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1064,7 +1064,8 @@ void dce110_edp_backlight_control(
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


