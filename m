Return-Path: <stable+bounces-141176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FDCAAB122
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4437E1BC1BAD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB2332818;
	Tue,  6 May 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyvL4nf2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548293777AB;
	Mon,  5 May 2025 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485387; cv=none; b=PbAqP9SZ4BtYePTc0xID+HzAcwcxSqxpp5/IuTDmKnM24RduRWj0MeG/86NJEQ/5bzGuWlJbE5iM7jvmlgrt8pJUTASU0LmKve9E/nT+tKTMFbY4t05jFDSOUg6cG1a4IkB+MCoPWS5u3rW14/cWlGP+t3Z3cR+YU/B3LYO0rO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485387; c=relaxed/simple;
	bh=Dj/wqjaxFVPICNVresQ1n3X4G4IA/QoG3r56gNsEk2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHz18+nppJEPzPT90Mr7GDhxJfkklwusVTXkuKRh9iRBgPGfPKnehwKNWqNHCd3PNfuY9a8ZdHmLC7anutr1rvm08Gytw3OAnm1H01t7Y9G+QsuJ8hdGs0OL5zOLDINw+MCuvUzM78vKp0LDdnnr/LBX0sSEWOwlIpyQVb9b3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyvL4nf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA2AC4CEED;
	Mon,  5 May 2025 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485386;
	bh=Dj/wqjaxFVPICNVresQ1n3X4G4IA/QoG3r56gNsEk2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyvL4nf2L0kmbPkuOxfffEii3a0nPxgwy7jBzEbVOpe0BrWAIR6KTCMR8bFT9pbMI
	 Dyy9iTkWIqabxQ1t+NeDMSiqd80blQZxRJc6ZCmQxWv6a1pz7gg8BliFUhjnb/pV4h
	 fKDnDZNTYvhfFLDS0+IGGrpLOxEvnwBVgPoiQv10OZBIggpuJDOnNSUgq06ZA4n4ib
	 1alCKHUwB2042gJCNZp/eaf4FIaaxOQOOyogpQ7DDxz5DHOo+vSnX3rroI5LqOSpCs
	 lvgMRvbIiEOIEY/A9QiIleoRreinS58y2gaVTKrqVeVZQyJJLWG0n6lDM4K4iR80vY
	 r8xRGJgjJAmiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Gabe Teeger <gabe.teeger@amd.com>,
	Leo Chen <leo.chen@amd.com>,
	Syed Hassan <syed.hassan@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Charlene.Liu@amd.com,
	chiahsuan.chung@amd.com,
	alex.hung@amd.com,
	Nicholas.Susanto@amd.com,
	Ausef.Yousof@amd.com,
	sungjoon.kim@amd.com,
	PeiChen.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 301/486] drm/amd/display: Guard against setting dispclk low when active
Date: Mon,  5 May 2025 18:36:17 -0400
Message-Id: <20250505223922.2682012-301-sashal@kernel.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 72d7a7fa1f2404fd31c84a8f808b1b37021a3a9e ]

[Why]
We should never apply a minimum dispclk value while in prepare_bandwidth
or while displays are active. This is always an optimization for when
all displays are disabled.

[How]
Defer dispclk optimization until safe_to_lower = true and display_count
reaches 0.

Since 0 has a special value in this logic (ie. no dispclk required)
we also need adjust the logic that clamps it for the actual request
to PMFW.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Reviewed-by: Leo Chen <leo.chen@amd.com>
Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 7d0d8852ce8d2..a4ac601a30c35 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -452,14 +452,19 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
+
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
-		if (dc->debug.min_disp_clk_khz > 0 && new_clocks->dispclk_khz < dc->debug.min_disp_clk_khz)
-			new_clocks->dispclk_khz = dc->debug.min_disp_clk_khz;
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
 
+		dcn35_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
+
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
-- 
2.39.5


