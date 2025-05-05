Return-Path: <stable+bounces-140677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A53AAAABF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DF43A326E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B589139260F;
	Mon,  5 May 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9e8v6c8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9853703B4;
	Mon,  5 May 2025 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485894; cv=none; b=IMIQTF75q8O2TjnuUM26VSejUceS7kVWu3LXCY6MIVdYnkV/8j6pw22IXlbtGVXLTa0hq0joAwdK7WkC7Q28Dq1fcFoU9qElA96dRpCqWlSl2DmEgdy4yz0xfLHV71EROhYbxuhUb96HT/eNVwwOEMViBw/zFkQvZnsgg+S/apQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485894; c=relaxed/simple;
	bh=j7/CYS3VLTNk26/IFzZOFaFw1rjfX5mJX1MXklRtPcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLfhH+kq5/YzF+2mp/J1Cfr0bTTNHU6jookfESbkTwEH3utAv7VxPVB7FiHhoL0kx1C7xs8dGZ2DotDO4fvGDK4ZW0W477tzfARe1DOOiIe6c1/Dipgxn3GPNxd3ctcS1PSzFhLjAyHpku/4Uw4QShQGpV2C7Nlf+5GfgBvNSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9e8v6c8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE92C4CEED;
	Mon,  5 May 2025 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485893;
	bh=j7/CYS3VLTNk26/IFzZOFaFw1rjfX5mJX1MXklRtPcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9e8v6c8lZsxJ500EtBadpNtbw4a5NSuPZ6Zua6hYbn7Jbzc6npcUps2kd+tOWl8A
	 0kDpPk6EOANyzjY6SjovOXDItedHD4ScYPW8G7qKsJSK3WbQuL8G4RvZ3AwP92kVin
	 Bx4y+8PHGsJ56LQAUnHM4vCmfvjZJQhtHljVvh0HtW2iaxITdwln3gJ8122t0Iebqv
	 LemgIcOTkeZ5crbAmc+Iva3ODn8AYF7apU+xtQRWvnmX0t6okSdxP4pn0lFa5wBwHF
	 CRLuxjUAb7Q6opOIUUp2ij+HtJUMa5m66+pm0IzKvH2hIEYmvSIEbBvmY3kqCDaYI+
	 NYnc7Gihgs+OQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Zhou <Jing.Zhou@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Chris Park <chris.park@amd.com>,
	Eric Yang <eric.yang@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Charlene.Liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 051/294] drm/amd/display: Guard against setting dispclk low for dcn31x
Date: Mon,  5 May 2025 18:52:31 -0400
Message-Id: <20250505225634.2688578-51-sashal@kernel.org>
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

From: Jing Zhou <Jing.Zhou@amd.com>

[ Upstream commit 9c2f4ae64bb6f6d83a54d88b9ee0f369cdbb9fa8 ]

[WHY]
We should never apply a minimum dispclk value while in
prepare_bandwidth or while displays are active. This is
always an optimizaiton for when all displays are disabled.

[HOW]
Defer dispclk optimization until safe_to_lower = true
and display_count reaches 0.

Since 0 has a special value in this logic (ie. no dispclk
required) we also need adjust the logic that clamps it for
the actual request to PMFW.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Eric Yang <eric.yang@amd.com>
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 20 +++++++++++--------
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        | 13 +++++++++---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index d4d3f58a613f7..ebeb969ee180b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -130,7 +130,7 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -204,15 +204,19 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		/* No need to apply the w/a if we haven't taken over from bios yet */
-		if (clk_mgr_base->clks.dispclk_khz)
-			dcn315_disable_otg_wa(clk_mgr_base, context, true);
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
 
+		dcn315_disable_otg_wa(clk_mgr_base, context, true);
+
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
+
+		dcn315_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn315_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		if (clk_mgr_base->clks.dispclk_khz)
-			dcn315_disable_otg_wa(clk_mgr_base, context, false);
+		dcn315_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index a13ead3d21e31..6f1785715dfb7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -140,7 +140,7 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -211,11 +211,18 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
+
 		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
+
+		dcn316_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
 		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
-- 
2.39.5


