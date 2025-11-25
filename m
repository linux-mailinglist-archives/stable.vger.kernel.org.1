Return-Path: <stable+bounces-196917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D1AC858F2
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 15:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07A1F3511B6
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31428326930;
	Tue, 25 Nov 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmNNhdOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCF3246F0
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082298; cv=none; b=oRPkpJGZ+/2c2qUztp2h5wDAH1zjYPhApckOUUuJz1nDbXERPghRMt8X49KeooXtknc2bLI0DDhYQCXAI2H2QNMZ7G0I2xoHgSHvOb7jdOVsCRN5x6cZt6bP4eWty0LSlbEHSDMEOjCLkvWq3hQRDVRJrXMj+0WDehtfJVzy0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082298; c=relaxed/simple;
	bh=bVXKL/C4QEH3rcm6urfUG4mftxdrTmiFp1jdT/r/YlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toPam0OE186eJSa0K+13jJfZlZM8XlD/XBiyEKCXtgWr5ukztIqknBEP9SbdylroIjFhpGYm4k5GTD3cp0ZCrYuwweiGWeHeeJogEP5Xk/QSN9tOZQKGG5UukkKd78qWCzv6h8gK3HaveuVMGpt8ltFkEzQWfahJlxIgtNT/YpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmNNhdOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9152FC116C6;
	Tue, 25 Nov 2025 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764082297;
	bh=bVXKL/C4QEH3rcm6urfUG4mftxdrTmiFp1jdT/r/YlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmNNhdODQfl3iYjlunMav16B9SyxApiHjtYEavdJKPWPMmW9C+x8U2eAWxt5Kqbyo
	 h1KKhaWEuuTuvA8jOYSi5HzkSYlYR27aGooJwym8yJ4VLgh6ZF5cZSXZWyYj4j8xOQ
	 xWR9rTh/4KerEkzDqM5yzNd7iPcpb47hTDxf5hQ9JDb79Y+aspkNS61XiURpfIQs85
	 9Y/qX9d2HH9Vh3DuBysFTY82OAq0M3Mnt6iM6Di6Jqp9hpYN9NpFvuM9khm7VskdGy
	 34ZkCOXMx1g60nhef8Ou2YG1/HtAT3HHdYRirKYCtyl6OBdU+5YCjfKuDvCXIslwMm
	 D+FVXRSuPK0Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Roman Li <roman.li@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] drm/amd/display: Prevent Gating DTBCLK before It Is Properly Latched
Date: Tue, 25 Nov 2025 09:51:31 -0500
Message-ID: <20251125145131.660280-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125145131.660280-1-sashal@kernel.org>
References: <2025112425-aspirin-conduit-e44b@gregkh>
 <20251125145131.660280-1-sashal@kernel.org>
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
index 3114b3fae9eff..6e9d6090b10ff 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -377,6 +377,8 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	display_count = dcn35_get_active_display_cnt_wa(dc, context, &all_active_disps);
 	if (new_clocks->dtbclk_en && !new_clocks->ref_dtbclk_khz)
 		new_clocks->ref_dtbclk_khz = 600000;
+	else if (!new_clocks->dtbclk_en && new_clocks->ref_dtbclk_khz > 590000)
+		new_clocks->ref_dtbclk_khz = 0;
 
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
@@ -418,7 +420,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			actual_dtbclk = REG_READ(CLK1_CLK4_CURRENT_CNT);
 
-			if (actual_dtbclk) {
+			if (actual_dtbclk > 590000) {
 				clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
 				clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index a841eaafbaaa8..57202ef3fd985 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1405,7 +1405,7 @@ static void dccg35_set_dtbclk_dto(
 				__func__, params->otg_inst, params->pixclk_khz,
 				params->ref_dtbclk_khz, req_dtbclk_khz, phase, modulo);
 
-	} else {
+	} else if (!params->ref_dtbclk_khz && !req_dtbclk_khz) {
 		switch (params->otg_inst) {
 		case 0:
 			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, 0);
-- 
2.51.0


