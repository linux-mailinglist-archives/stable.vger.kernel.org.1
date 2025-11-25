Return-Path: <stable+bounces-196907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D6C85406
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62AC93516E5
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16123D298;
	Tue, 25 Nov 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqfljyn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143ECA5A
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078676; cv=none; b=ts3IzpsThuQhbgx2Nm4WzLBhcH6Qc+wE2zK3Jm0h8pqFZePOEzytJU2mzYLz+BzjelRqOWV+GEP7CuTMabdb0+eAVsQSfgxqEVnpaGGFxCDSzsizAsvGxmvuzsa4sY9e9YCoDLgUH2ePCBlExsJ5r22mnOR0a0rcl0jurKQDxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078676; c=relaxed/simple;
	bh=epZ8GmAyYj9Ke1lGipJvZR0swdIewXIZ2do5TqnfS38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRD0Skrq+xd5bLPY1eEAdjAgm+AL/YjS/Ty6mhs0tDsms6AOqBfl/aRZvnoWZ8AUTGwYP5vTU3fxCCqhWKG064ae+s88bhVOBgOUhjb6fEpSIUAPoDHA7eDHMjKmpjKvA6NjyG85vj3DyiVjjDJlLYCE7BuD5lo7/OMC+gc0nTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqfljyn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6C1C4CEF1;
	Tue, 25 Nov 2025 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764078675;
	bh=epZ8GmAyYj9Ke1lGipJvZR0swdIewXIZ2do5TqnfS38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqfljyn8oKBZVEBcHyry/V/a9kHW3VHGfqBNpVwRbaAn1Ccep9ULo6Avl0T8OAd5Q
	 JE16qVhYFm4OMYr+29HfnMxoRjGMqkiqshPyImTFUdOJBN85RKXj+1trghYvEwvdra
	 zTzcI48xt9UegjHmV/9p/ZFMsV3ljCrNGjAKiZqesCN1dHK0pIArrRCGr+jFN4WJch
	 0GHpWK7/6GVbNi/dpBkWRoRYR16Z7vCPKuU4cjpY99sQAhiS6bhfCCzosxI0B9COHn
	 Xh7XZACVqw8C8GPxwS7eKeb6u+VS9nP7fHrZznHlKRmU5HfulvE6rQVppwD7QaIBFW
	 1TeiQxM4JsjTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Roman Li <roman.li@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] drm/amd/display: Prevent Gating DTBCLK before It Is Properly Latched
Date: Tue, 25 Nov 2025 08:51:12 -0500
Message-ID: <20251125135112.591587-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125135112.591587-1-sashal@kernel.org>
References: <2025112424-handball-smolder-0f15@gregkh>
 <20251125135112.591587-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[ Upstream commit cfa0904a35fd0231f4d05da0190f0a22ed881cce ]

[why]
1. With allow_0_dtb_clk enabled, the time required to latch DTBCLK to 600 MHz
depends on the SMU. If DTBCLK is not latched to 600 MHz before set_mode completes,
gating DTBCLK causes the DP2 sink to lose its clock source.

2. The existing DTBCLK gating sequence ungates DTBCLK based on both pix_clk and ref_dtbclk,
but gates DTBCLK when either pix_clk or ref_dtbclk is zero.
pix_clk can be zero outside the set_mode sequence before DTBCLK is properly latched,
which can lead to DTBCLK being gated by mistake.

[how]
Consider both pixel_clk and ref_dtbclk when determining when it is safe to gate DTBCLK;
this is more accurate.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4701
Fixes: 5949e7c4890c ("drm/amd/display: Enable Dynamic DTBCLK Switch")
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d04eb0c402780ca037b62a6aecf23b863545ebca)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c       | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 0e638bc6bf77b..4e4390d565473 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -394,6 +394,8 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	display_count = dcn35_get_active_display_cnt_wa(dc, context, &all_active_disps);
 	if (new_clocks->dtbclk_en && !new_clocks->ref_dtbclk_khz)
 		new_clocks->ref_dtbclk_khz = 600000;
+	else if (!new_clocks->dtbclk_en && new_clocks->ref_dtbclk_khz > 590000)
+		new_clocks->ref_dtbclk_khz = 0;
 
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
@@ -435,7 +437,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			actual_dtbclk = REG_READ(CLK1_CLK4_CURRENT_CNT);
 
-			if (actual_dtbclk) {
+			if (actual_dtbclk > 590000) {
 				clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
 				clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index de6d62401362e..c899c09ea31b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1411,7 +1411,7 @@ static void dccg35_set_dtbclk_dto(
 				__func__, params->otg_inst, params->pixclk_khz,
 				params->ref_dtbclk_khz, req_dtbclk_khz, phase, modulo);
 
-	} else {
+	} else if (!params->ref_dtbclk_khz && !req_dtbclk_khz) {
 		switch (params->otg_inst) {
 		case 0:
 			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, 0);
-- 
2.51.0


