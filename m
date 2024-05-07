Return-Path: <stable+bounces-43316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E298BF1AA
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498411F22DF8
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE214532F;
	Tue,  7 May 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXgKTcKu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125413541F;
	Tue,  7 May 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123363; cv=none; b=YCXVK4YsV5nCirE7sFPWL60XyQLYHsGE6q97vd4/27L8/oGY6rmrGql3Y7YigjJdjcQimpvwpoIp2D8ZTfV/puFCOZDAR31emO98mL3O/lxn3uIZoq4blgwIZj2J+4HJ5d15HGb8b8BKDCeChvFApGs5pBF8QnBuJ35UOE70jCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123363; c=relaxed/simple;
	bh=f4ZwjyZMrs5dHXlwR9n+9/SQ3bYChV9o/PuEE9WNtm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEXt/0SXDKWUnl5v4jpkUU5LH1ndbCEmPq0ukXl3+vqPqruf41TTs6Xt2fBPJKknPbWaiIfZAsq8IJ3Kv04S4n66bHFOXB7ZXR9467+eh9XwTNWk0uHn0LrekOn7NEqxKx6S+8yWAeeLiNB6AZ6YmDDwwJ1LrSec8/GpOnOj7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXgKTcKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD43C3277B;
	Tue,  7 May 2024 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123362;
	bh=f4ZwjyZMrs5dHXlwR9n+9/SQ3bYChV9o/PuEE9WNtm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXgKTcKukrOiGFhwxFa74IRJpAU4laeT2hQcKEvgao5mwmmSp/FgSI6zu+wYmK2Zl
	 Of9sGCJcT81/lkXVBqUrnPL8wZGEAEwD4cT65+5WcCPb0qqdVX9+JbX+/MYyxKPYEI
	 n6iVGnBZjOD2ChQJ0H4Dx5BriBOQyJHXqzO5i5CGzVaI7gxEIX5LkA2f0ttBU/jnnl
	 gD7yxlnL+gYYlBnnn4fZdD6kRtNekQ+JY04Sx6PM5b8gj1gEZ0UbRb9+skYBsit4yb
	 BvOZ50Tkq5ZKlxwTWcNXmIFMQ/EXji0eKu38F048jvl5nQz5QDlADTrJ4naMk/28dZ
	 RLCNe57vX1ZtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Swapnil Patel <swapnil.patel@amd.com>,
	Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
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
	chiahsuan.chung@amd.com,
	charlene.liu@amd.com,
	nicholas.kazlauskas@amd.com,
	qingqing.zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 37/52] drm/amd/display: Add dtbclk access to dcn315
Date: Tue,  7 May 2024 19:07:03 -0400
Message-ID: <20240507230800.392128-37-sashal@kernel.org>
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

From: Swapnil Patel <swapnil.patel@amd.com>

[ Upstream commit a01b64f31d65bdc917d1afb4cec9915beb6931be ]

[Why & How]

Currently DCN315 clk manager is missing code to enable/disable dtbclk.
Because of this, "optimized_required" flag is constantly set
and this prevents FreeSync from engaging for certain high bandwidth
display Modes which require DTBCLK.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 644da46373209..5506cf9b3672f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -145,6 +145,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	 */
 	clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 	if (safe_to_lower) {
+		if (clk_mgr_base->clks.dtbclk_en && !new_clocks->dtbclk_en) {
+			dcn315_smu_set_dtbclk(clk_mgr, false);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
 			display_count = dcn315_get_active_display_cnt_wa(dc, context);
@@ -160,6 +164,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 			}
 		}
 	} else {
+		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
+			dcn315_smu_set_dtbclk(clk_mgr, true);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
 		/* check that we're not already in D0 */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_MISSION_MODE) {
 			union display_idle_optimization_u idle_info = { 0 };
-- 
2.43.0


