Return-Path: <stable+bounces-64925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F112943C9B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB86B26993
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696014D44F;
	Thu,  1 Aug 2024 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaQNmas0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66014D2BE;
	Thu,  1 Aug 2024 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471462; cv=none; b=ROP49n5DpQgO9oIdvHXl0IJ3Ujf7ExNTupM8ziQ7lrcaDjOi5Dvzxs7R+1hOIB8cnmMg31oJ9/Kt41XqthGnvK31x/1cgrwo2Qn0B2zYdnIkDsh+TMnw4Spb5oMedwQTJP3hanIedB8tQYgRtZdGRcmHi0PcoEKvGXAlsVCeyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471462; c=relaxed/simple;
	bh=j2T65Zj5aWyyXrWFynGBkS47SHJUbO+P6xMKcLEqalk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g09oZivFOtpijpqyXHAhaZncc3hXoanAKDMSS6qBtUP/fMoyDfsMqaClWKkXHIbSDkJSmo+2S+eXg9ZaVWJzSr+PwzefJ+xB+9g71xYz2+byJKv4RtcBqilkHMMKh/EnZQ7b7X/JAnjVov4HTQrrhm7p/T2NFnJXujV21EeQkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaQNmas0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6EBC116B1;
	Thu,  1 Aug 2024 00:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471461;
	bh=j2T65Zj5aWyyXrWFynGBkS47SHJUbO+P6xMKcLEqalk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaQNmas0yDX3IpLFqFkLs6uduhx7lRZB1d/iJoRdaxSjBY5lsXKQRE3W+wGoWhYCM
	 KyrJJ5kRTqjouGtA6buWJ2j0CqKvXD9sEOlAxubaPCTuhS70l0vf+jNpGLZ67HBjZW
	 ANSEVR8H6kiA/CZEYcmFA805mSrisMj2EdZrjENTYJFHg3KIBOIfVLvFoZ+ifK6Y7r
	 xIgcKU2RLOddpH8rXqcqWi1buGQP5ZHMWqoVUMoGtJXJhU3v8DhwwwfUd9hArbR5sK
	 IVLgI1AtxKzmIzqR/6y1AVll81hcIkmT3pWYxW77rbpPZr11wH580KnF4GB5SkgynL
	 Iiw2Jw1FdUHPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nicholas.kazlauskas@amd.com,
	wayne.lin@amd.com,
	duncan.ma@amd.com,
	alvin.lee2@amd.com,
	dillon.varone@amd.com,
	srinivasan.shanmugam@amd.com,
	aurabindo.pillai@amd.com,
	jinze.xu@amd.com,
	Qingqing.Zhuo@amd.com,
	hamza.mahfooz@amd.com,
	martin.leung@amd.com,
	chaitanya.dhere@amd.com,
	chiahsuan.chung@amd.com,
	harikrishna.revalla@amd.com,
	wenjing.liu@amd.com,
	zhikai.zhai@amd.com,
	arnd@arndb.de,
	michael.strauss@amd.com,
	sungjoon.kim@amd.com,
	ivlipski@amd.com,
	cruise.hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 100/121] drm/amd/display: Validate function returns
Date: Wed, 31 Jul 2024 20:00:38 -0400
Message-ID: <20240801000834.3930818-100-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c ]

[WHAT & HOW]
Function return values must be checked before data can be used
in subsequent functions.

This fixes 4 CHECKED_RETURN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c               | 7 +++++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c        | 3 ++-
 .../drm/amd/display/dc/link/protocols/link_dp_training.c   | 3 +--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 2293a92df3bed..22d2ab8ce7f8b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -245,7 +245,9 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 			if (status == DMUB_STATUS_POWER_STATE_D3)
 				return false;
 
-			dmub_srv_wait_for_idle(dmub, 100000);
+			status = dmub_srv_wait_for_idle(dmub, 100000);
+			if (status != DMUB_STATUS_OK)
+				return false;
 
 			/* Requeue the command. */
 			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
@@ -511,7 +513,8 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	union dmub_rb_cmd cmd = { 0 };
 	unsigned int panel_inst = 0;
 
-	dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst);
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+		return;
 
 	memset(&cmd, 0, sizeof(cmd));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index c6f859871d11e..7e4ca2022d649 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -595,7 +595,8 @@ static bool hubbub2_program_watermarks(
 		hubbub1->base.ctx->dc->clk_mgr->clks.p_state_change_support == false)
 		safe_to_lower = true;
 
-	hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
 	REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
 			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index b8e704dbe9567..8c0dea6f75bf1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1659,8 +1659,7 @@ bool perform_link_training_with_retries(
 		if (status == LINK_TRAINING_ABORT) {
 			enum dc_connection_type type = dc_connection_none;
 
-			link_detect_connection_type(link, &type);
-			if (type == dc_connection_none) {
+			if (link_detect_connection_type(link, &type) && type == dc_connection_none) {
 				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
 				break;
 			}
-- 
2.43.0


