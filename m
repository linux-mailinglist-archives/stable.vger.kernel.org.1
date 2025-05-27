Return-Path: <stable+bounces-147569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D087AC5836
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08354C0626
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF127F16D;
	Tue, 27 May 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y4z9Qsql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6C1DC998;
	Tue, 27 May 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367747; cv=none; b=epolqNP7tnMN3oMnKQnwxSMnQx4SvyJXSHnRcBv0MJPOwy/4gYR3dultcE0YRPm/DQeXhffnmkBSemzcZoPfRP8GSOHNcarK+IzGJVLjEiSZq9D4UsRtdszoQKQKhELsSnOK9ur7Etz61G8Fg25c6c1pvBgH8/r0jSqCAjBJ41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367747; c=relaxed/simple;
	bh=jkncdQHC09SPNuqXnGHPDxDF3djKy4Yb502XZyMTK2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrV9rSR85C/Njd8n4lY9zVnGYm4r/dhAsJWVqANQpnrgfmHg8QJqg8jZfpZRTYUhp3g35tdrUSMGF7hXFYoep3lq3wpUdrwibZxbVpKt2wzd6j9Lij7So4zXXufNWNNhV9AG2umtBZlQPIwIb2o1Is97E4U1pPU4cPcLdZfb4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y4z9Qsql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB1C4CEE9;
	Tue, 27 May 2025 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367747;
	bh=jkncdQHC09SPNuqXnGHPDxDF3djKy4Yb502XZyMTK2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4z9QsqlJuoZmuQJoZWlQEM0MRbLVHz3ayVBqJsOH/61z2Y+TW2RRQ5JrcnEvF/Nj
	 2BO7+SX4q76hoikh+t2cQQX8AL/Rb+g9NTVKgU/BUiPhBnFjI9c0JfNCl37jPXJ7Ro
	 ZXG9b5mQkyFs9SPnvCgAGAiD1T/xm91qu3MDG9DE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charlene Liu <charlene.liu@amd.com>,
	Brandon Syu <Brandon.Syu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 487/783] Revert "drm/amd/display: Exit idle optimizations before attempt to access PHY"
Date: Tue, 27 May 2025 18:24:44 +0200
Message-ID: <20250527162532.958865053@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 94ceccfc04982..2f5f3e749a1ab 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1889,7 +1889,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool can_apply_edp_fast_boot = false;
 	bool can_apply_seamless_boot = false;
 	bool keep_edp_vdd_on = false;
-	struct dc_bios *dcb = dc->ctx->dc_bios;
 	DC_LOGGER_INIT();
 
 
@@ -1966,8 +1965,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
-		if (dcb && dcb->funcs && !dcb->funcs->is_accelerated_mode(dcb))
-			clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 
 		power_down_all_hw_blocks(dc);
 
@@ -1980,8 +1977,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
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




