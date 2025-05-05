Return-Path: <stable+bounces-140132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F33AAA570
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B008718852E8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA403103D2;
	Mon,  5 May 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSNYfxbI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5B3103C0;
	Mon,  5 May 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484170; cv=none; b=HlgJ77uE++BatIJLPu6wDGzGlN/Ef9v0KcqpUKEXXPeT1Nx7no9CTQ9eQX2b9v4Z9xUAHqZAvZG64x5WyGRgOVS1gisPkqbmYUN77cKawGjyTnmSn/1Cb9gdAJAD3tG1WfFoZL0xqv9uuPMktlQrVK0AG41wA5FCNLF8S065JWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484170; c=relaxed/simple;
	bh=WkH9QAzOg9qFlj+eC8SmU7hdqXPvZNALVFTPQXnoYgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRaI1gUbDw3tastE0PL4gxlczMc2RdUp4nskLJyv0xzJCx44/ppN2hwnedk19wUfZ4D9/QbUHRS9WIM0Mlr7sJ/fRTcnCydQq9jAuHnOWVPsuMqGkzt3IcapE0e1HA9JoGDpNnzlDO1DbvAu+U6qGGcS4DtqWktazrgkULTYfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSNYfxbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A715C4CEEF;
	Mon,  5 May 2025 22:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484170;
	bh=WkH9QAzOg9qFlj+eC8SmU7hdqXPvZNALVFTPQXnoYgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSNYfxbIgEcckqhWz0E7LYaR8RUD1pTTcLOcNHSZnBfmHrS9Di3zf/XwYHIuxMLgL
	 ytk26zcy7c4++rdVSQQKGfzlz2vheKFWqQ3iD2GinLHi34x60hreJjLxNA7zPyQwLl
	 xE47MujzjG1s2RYkIy0kmINTsUOIQfOnJgCs2wq4JCBm0mDJ2fd5lh2nyRFNUsVQ+F
	 veJebaUZjmahHuuFp1Ein5Y9YXNBuoVnjFf63i/8czn5OiP2zTZ0VV4PQDpLzNwqd0
	 FdBhLxk4bkKv5OTrQ2ulo5GEp77cE2oNG+lUENySVCrnBAEJt0Japt5rFvMzCTbJ37
	 eT+b7yDzT5fwQ==
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
	alex.hung@amd.com,
	zaeem.mohamed@amd.com,
	Ausef.Yousof@amd.com,
	Nicholas.Susanto@amd.com,
	sungjoon.kim@amd.com,
	PeiChen.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 385/642] drm/amd/display: Guard against setting dispclk low when active
Date: Mon,  5 May 2025 18:10:01 -0400
Message-Id: <20250505221419.2672473-385-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 1648226586e22..1f47931c2dafc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -467,14 +467,19 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
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


