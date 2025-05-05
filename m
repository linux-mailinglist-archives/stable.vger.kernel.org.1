Return-Path: <stable+bounces-140386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB59AAA850
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3615A45B4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73EF34880B;
	Mon,  5 May 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foHrwPcv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC8348809;
	Mon,  5 May 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484747; cv=none; b=aYB59ruoQXowXrtVM+nFmwDqay60WfG5bhtsudVrT91hJNgHgraNw4u8w2wSEayRGIdpTl5bSeU4t0JJgJhhd7d29oXuMKFYT7J9qdFwKypbhEjmJR+gp0pvjohPmcelVemUhxGn7mG9S7/wkT3RKUCCsdqtlz4Y7LzmLQ/olD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484747; c=relaxed/simple;
	bh=PwWSdU0v4ac350M24sNgCGAuAFFzNWKlDyW/Vpiq864=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VktQgyQgo6eu/gW2MPTc9QghNMT0jLBToT9plrc7AXVSaR2cZZYIF0TeQoinDwlnUSCuxkAGBmccaP19fTA7gN0zIKnO3OPL48/23pFyMPizpWBBbhcsBcjVSMw2DzIrFd4Q/emkcp1O0BgKUIidMn+h0YAdMROht6tccdOuNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foHrwPcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137E2C4CEE4;
	Mon,  5 May 2025 22:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484746;
	bh=PwWSdU0v4ac350M24sNgCGAuAFFzNWKlDyW/Vpiq864=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foHrwPcvuR1z6J1IHfls//0gjk7JsLigB2BXRVTpUD9Jqi/RcAgyAFst5sl66X1J+
	 bHs6iYjZ+qRBYhlEpKKJDgiu1D8VH2iDbwV9kzYOyMHbqjOPZL5zp1q/aXi8phq5oI
	 d6IC/+GlYrMrqOtqaQb5nG6mzlfUumJUcgEgNBbtJ3vtAsEfUm1CgWIc131koct7TX
	 0KQVKaW8vIyQxkmlE+qZD+9UPV3Uuik+CDvaAcNQ7Ojs4FN8kroU72uBvyeP9AMVIN
	 1Clk+7mLy+aBQS6BHXywSl/Nd6UttcEm1Mo+ZguYCzMVQllSZH/URiFDe/vXjXaeVr
	 wdl53EF4YAgNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ovidiu Bunea <Ovidiu.Bunea@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
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
	alvin.lee2@amd.com,
	chiahsuan.chung@amd.com,
	jerry.zuo@amd.com,
	alex.hung@amd.com,
	Kaitlyn.Tse@amd.com,
	ryanseto@amd.com,
	martin.tsai@amd.com,
	yi-lchen@amd.com,
	tjakobi@math.uni-bielefeld.de,
	Sungjoon.Kim@amd.com,
	michael.strauss@amd.com,
	Brandon.Syu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 637/642] drm/amd/display: Exit idle optimizations before accessing PHY
Date: Mon,  5 May 2025 18:14:13 -0400
Message-Id: <20250505221419.2672473-637-sashal@kernel.org>
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

[ Upstream commit c488967488d7eff7b9c527d5469c424c15377502 ]

[why & how]
By default, DCN HW is in idle optimized state which does not allow access
to PHY registers. If BIOS powers up the DCN, it is fine because they will
power up everything. Only exit idle optimized state when not taking control
from VBIOS.

Fixes: be704e5ef4bd ("Revert "drm/amd/display: Exit idle optimizations before attempt to access PHY"")
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 2f5f3e749a1ab..94ceccfc04982 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1889,6 +1889,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
+	struct dc_bios *dcb = dc->ctx->dc_bios;
 	DC_LOGGER_INIT();
 
 
@@ -1965,6 +1966,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
+		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
+			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
 
@@ -1977,6 +1980,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
+		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
+			clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.39.5


