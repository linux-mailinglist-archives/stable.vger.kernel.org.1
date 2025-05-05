Return-Path: <stable+bounces-141231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08ABAAB1AC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA52188C914
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC694182C4;
	Tue,  6 May 2025 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLI17ZQ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB42D3209;
	Mon,  5 May 2025 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485559; cv=none; b=ClAXeRBaVOVbfwGxbMS+XECdfoBSDi68ovYenW/ugpBleujEKA1m5pZap8jeIpYSKeUs/N7AP8ln8lXsKKmdVM+PViaskOqJW8evchxAr2JcQQCDRK4LNsu57IrwQAMqtptv1PwWNcOaC0xH643ZOkn5CxIz665yOLQryvhdpX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485559; c=relaxed/simple;
	bh=okfQ0p2BkEh19Ojv1U+9vH9B+4z3vlhl41JYyyWl/RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nubDtsp2jaPtjPrg5nut/1EO18QcD0Q27i2QDk9UYTgzz0yekRCIj85n3BQc3dO+GDxcHLWEqetR7CxGV6OYFLbs1iVbpfNm9eArTcaV1t5b/19lAJgjBiZPJQbYkY/cetSvPptehBSiI3CbHOn0d3sWDdJy0SAxOO5SMX/+X5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLI17ZQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D7C4CEE4;
	Mon,  5 May 2025 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485559;
	bh=okfQ0p2BkEh19Ojv1U+9vH9B+4z3vlhl41JYyyWl/RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLI17ZQ72Yb8rbmTc922eXCL6KhWzCVZQ7XaO5gK/GXWMICW2wCjvB3vXFaiHMngP
	 5MIsB2qOtzQYtAHZT+dDYqRjBo267TTz/MmGpGMELXNt7Ix0z/1UEsn8f3BxweQTQk
	 wXvVibEyod/0TXV1ZcFS5jDq97a6SPDBouJZGsZWhNAj7ELj6PXp2z/yw3X6xSmS10
	 EJ/aaQl68BaWpAPNDriPv5f2FICmxxgoJdDRoXYQdNsp5IH2719nXDtvPwJyh4t6rD
	 5uG6/0LPhFGQqcB1q+0S/WS4DHtVNPfRI9BF6UfK0Ya4VRpI1WeP2PFC627XnHQaz8
	 SsqtQ/5R3rs6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brandon Syu <Brandon.Syu@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
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
	alvin.lee2@amd.com,
	chiahsuan.chung@amd.com,
	jerry.zuo@amd.com,
	Kaitlyn.Tse@amd.com,
	Ovidiu.Bunea@amd.com,
	ryanseto@amd.com,
	martin.tsai@amd.com,
	yi-lchen@amd.com,
	tjakobi@math.uni-bielefeld.de,
	Sungjoon.Kim@amd.com,
	michael.strauss@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 368/486] Revert "drm/amd/display: Exit idle optimizations before attempt to access PHY"
Date: Mon,  5 May 2025 18:37:24 -0400
Message-Id: <20250505223922.2682012-368-sashal@kernel.org>
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

From: Brandon Syu <Brandon.Syu@amd.com>

[ Upstream commit be704e5ef4bd66dee9bb3f876964327e3a247d31 ]

This reverts commit de612738e9771bd66aeb20044486c457c512f684.

Reason to revert: screen flashes or gray screen appeared half of the
screen after resume from S4/S5.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 297f313794e49..809c556f4e7de 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1890,7 +1890,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
-	struct dc_bios *dcb = dc->ctx->dc_bios;
 	DC_LOGGER_INIT();
 
 
@@ -1967,8 +1966,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
-		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
-			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
 
@@ -1981,8 +1978,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
-		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
-			clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.39.5


