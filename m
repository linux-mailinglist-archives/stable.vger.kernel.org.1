Return-Path: <stable+bounces-94976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B251B9D71C2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780ED163B5D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4E1E3DF8;
	Sun, 24 Nov 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6LqQG59"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A681B393B;
	Sun, 24 Nov 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455467; cv=none; b=GGeQjQkm6jNxTDRktF7BXOjRtflAgv7qn9hy5LaByiOgkBMDmXQUqCP1El3pGEb1mAoonJbnP24WskWzml8tBF40lfOZMzGzgkSNG5I0AO/URYdMsN38n7qkOcbrKp9DMRmk7EbgbPFi1mXQfGNnBhdX+5D9+67KsCjJ55PV+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455467; c=relaxed/simple;
	bh=oddvh8vUISydeyfq5mfog7VYlX2ELwy6ZEqEGG+WSTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7X1hre1gEfHclXzvF8aSVeAPkQWCX8cJaUlym2xTOigO17OVwRiYb34j2OHUbqN+CsWaoaC3rSDyf/KzJtGTBVig71xALnxiVrOv6JmyDu4fQmo/GlUh8xHmkkjJhTRZvcdGU9VswM4iizS1EbTcbVfihdO+gPDdlGZeSQVfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6LqQG59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA4DC4CECC;
	Sun, 24 Nov 2024 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455467;
	bh=oddvh8vUISydeyfq5mfog7VYlX2ELwy6ZEqEGG+WSTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6LqQG594rggJg616z+AprVS0oBKvhuQUhFN/lve14UN3BEZBXSKHZPbjsKcjKxXa
	 UEyV0m0Jc9Bcctsnlele7Wx1CfCE7goryR4oQvI8wV34RP8B55190jaiKbom8a+uFW
	 wp72lA5GnKCuNvVigpIbPTw2jnG0EtQ6TpJvFyN0s41dtGW4mz+zRZA4yktGo6fAW4
	 bxwGZyUc93waRJ2TvFFMt5F19EuA0mFeqhpu8F2okLKJGEO4x14E931U2IZvtcpvyI
	 ts3z2/ZNVoWQCGHjYq9jiGa+zGpqh515XwO9kMj5uvENaFkzPAhh4vL5lwQtpaSH7i
	 0p5g27ASuvzqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ausef Yousof <Ausef.Yousof@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	nicholas.kazlauskas@amd.com,
	Charlene.Liu@amd.com,
	chiahsuan.chung@amd.com,
	hamza.mahfooz@amd.com,
	Nicholas.Susanto@amd.com,
	sungjoon.kim@amd.com,
	roman.li@amd.com,
	zhongwei.zhang@amd.com,
	michael.strauss@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 080/107] drm/amd/display: Remove hw w/a toggle if on DP2/HPO
Date: Sun, 24 Nov 2024 08:29:40 -0500
Message-ID: <20241124133301.3341829-80-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Ausef Yousof <Ausef.Yousof@amd.com>

[ Upstream commit b4c804628485af2b46f0d24a87190735cac37d61 ]

[why&how]
Applying a hw w/a only relevant to DIG FIFO causing corruption
using HPO, do not apply the w/a if on DP2/HPO

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 7d68006137a97..3bd0d46c17010 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -132,6 +132,8 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+		struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+		struct dccg *dccg = clk_mgr_internal->dccg;
 		struct pipe_ctx *pipe = safe_to_lower
 			? &context->res_ctx.pipe_ctx[i]
 			: &dc->current_state->res_ctx.pipe_ctx[i];
@@ -148,8 +150,13 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 		new_pipe->stream_res.stream_enc &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled(new_pipe->stream_res.stream_enc);
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
-			!pipe->stream->link_enc) && !stream_changed_otg_dig_on) {
+		bool has_active_hpo = dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(old_pipe) && dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(new_pipe);
+
+		if (!has_active_hpo && !dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe) &&
+					(pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
+					!pipe->stream->link_enc) && !stream_changed_otg_dig_on)) {
+
+
 			/* This w/a should not trigger when we have a dig active */
 			if (disable) {
 				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
-- 
2.43.0


