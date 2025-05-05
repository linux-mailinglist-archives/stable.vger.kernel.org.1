Return-Path: <stable+bounces-140736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC857AAAEE4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A656A16AB07
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551262F231F;
	Mon,  5 May 2025 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsAfYVgw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B238CEB3;
	Mon,  5 May 2025 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486101; cv=none; b=iKqjokPWy4pabgMtNT6GRmwYBZlaHvlFkqqOZvfegUt2jOlJ4U8QWJykM4nckc/Z6d3JxBHCDKlLpYlvGIRZ9pTJIjJUzWdAX92kHeU01rBBYmNAOIUNE/xctrh2Y4cOo6bBqT8luQ13qAeuzS87CW5dPgJYIvkDURjJ4F61HtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486101; c=relaxed/simple;
	bh=zPTcb5EF+PZ7SBsevaVplteoZZUfmgwh2tLi1WG3G2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bX69CPrgGUdcunUitWNd2HLvvyy6UvRM5MNDpHDXxbTvqGVbeUXnh4scb2DYmwZKwxh99+1zL2/iDiHSICdyJ08/xMvo2H7icamxMgnjyJharQJIFnZpkcW8heIsBvJOaQfgQhJ7HX7G3/v10RRtBMoke2b67335zRUObp1rVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsAfYVgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE437C4CEE4;
	Mon,  5 May 2025 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486100;
	bh=zPTcb5EF+PZ7SBsevaVplteoZZUfmgwh2tLi1WG3G2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsAfYVgwvR9ueLTcHxCp2N253V9wZRjJftpYqYwg3NnkyozjKpewa0tcSH4sRvYRl
	 dGk9I6PlWJMQVP0fT3/GioMWkVLKiIelz8VOxzI0xsgwNKOVGxlRJyL4yYMkM7ssaD
	 qnupt3HeoGSwuUCpnHvxSCGyVLvq6cRXL3Rc6RtHSRTikA1tzUk2Hw4ItM1GdBI7yZ
	 oLznNjgJBXnRdqa/xRz1OGbcqznJ3SKKJ14FpDWwBoUlLbcrLR66yFPeK205wwcjkZ
	 emyFif/QUdwlOtbGzuB/7gGsGyy6IGKVF8Z94LhLHRvXI8S2SagPWk6G8tX1LNnXGV
	 9dxlXj/fTGj6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yihan Zhu <Yihan.Zhu@amd.com>,
	Samson Tam <samson.tam@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 155/294] drm/amd/display: handle max_downscale_src_width fail check
Date: Mon,  5 May 2025 18:54:15 -0400
Message-Id: <20250505225634.2688578-155-sashal@kernel.org>
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[ Upstream commit 02a940da2ccc0cc0299811379580852b405a0ea2 ]

[WHY]
If max_downscale_src_width check fails, we exit early from TAP calculation and left a NULL
value to the scaling data structure to cause the zero divide in the DML validation.

[HOW]
Call set default TAP calculation before early exit in get_optimal_number_of_taps due to
max downscale limit exceed.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 50dc834046446..4ce45f1bdac0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -392,11 +392,6 @@ bool dpp3_get_optimal_number_of_taps(
 	int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 
-	if (scl_data->viewport.width > scl_data->h_active &&
-		dpp->ctx->dc->debug.max_downscale_src_width != 0 &&
-		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
-		return false;
-
 	/*
 	 * Set default taps if none are provided
 	 * From programming guide: taps = min{ ceil(2*H_RATIO,1), 8} for downscaling
@@ -434,6 +429,12 @@ bool dpp3_get_optimal_number_of_taps(
 	else
 		scl_data->taps.h_taps_c = in_taps->h_taps_c;
 
+	// Avoid null data in the scl data with this early return, proceed non-adaptive calcualtion first
+	if (scl_data->viewport.width > scl_data->h_active &&
+		dpp->ctx->dc->debug.max_downscale_src_width != 0 &&
+		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
+		return false;
+
 	/*Ensure we can support the requested number of vtaps*/
 	min_taps_y = dc_fixpt_ceil(scl_data->ratios.vert);
 	min_taps_c = dc_fixpt_ceil(scl_data->ratios.vert_c);
-- 
2.39.5


