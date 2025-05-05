Return-Path: <stable+bounces-141229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D8AAB1D8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7755C3ADB63
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846062D43F7;
	Tue,  6 May 2025 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKdz0ItM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E832D29BE;
	Mon,  5 May 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485543; cv=none; b=GwES9WRvN71vqOdIgGm3bTRgFyXHdzhFFHmlX1fFmUr0Sj0hlwAxjmuLl59qdGJ64CZ2ynCWBCpJHyzalgLUPVSOhCV/JKEUvK3A8W0I2m/KHhCZ6way1IKRSiH1NUqAblj3796wl62I0xzZ5voeTfaP0o6vT4LDEIc9yL18mcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485543; c=relaxed/simple;
	bh=XfLgwy/uCBbUx8iwGQV5lnGkrehL9xBdF86fpH3kQyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=le+wC0gIbBJ9Ud3NiZuDLczuJ+HHhlq7uCCs462au3k2F/DxeUUrM/bt1HchNXyBXks1MyAcckxdan76OpuE3NBlJdA2DwruE3BLkAIC5+BaY+Ds/2QFu+oNJKzNMz2d6gifwpNLoAH5zAnFK8eBPr/znCwpVqfvYdnWnQSJXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKdz0ItM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAAEC4CEE4;
	Mon,  5 May 2025 22:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485542;
	bh=XfLgwy/uCBbUx8iwGQV5lnGkrehL9xBdF86fpH3kQyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKdz0ItMl9fnJXI7gkecldBADUSz6l/jhJedXirmnLeMMR/sPYlmLBtUiEMzx4rvN
	 IRAP0Y9fxji4ibdgHdRWrw0ojT0s8WpAKoO7ta6v0mqBdw1G2a3/4MYoKB4YcVcTLQ
	 6WL3cHFHlXc/VEeVAfb9WdxrhhkwS2Mnc6hlRZM6uffIfzkk3lGrkF3yZLnUnP5ewg
	 0gGt13qP7godAJJBWjJj9H98yXaBOnJXcd0I/AclzctxHsPI7gz1HlzQw5WfcB6GX/
	 O8U4xoAQJnRvS7w9JCaHeBuJK7feSbDmlFxfWrJJwqy1pJQ4rmAKpZ2dVphWW5HQ/1
	 Tz5V4Itc9DcZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	chiahsuan.chung@amd.com,
	zaeem.mohamed@amd.com,
	PeiChen.Huang@amd.com,
	michael.strauss@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 364/486] drm/amd/display: Don't try AUX transactions on disconnected link
Date: Mon,  5 May 2025 18:37:20 -0400
Message-Id: <20250505223922.2682012-364-sashal@kernel.org>
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[ Upstream commit e8bffa52e0253cfd689813a620e64521256bc712 ]

[Why]
Setting link DPMS off in response to HPD disconnect creates AUX
transactions on a link that is supposed to be disconnected. This can
cause issues in some cases when the sink re-asserts HPD and expects
source to re-enable the link.

[How]
Avoid AUX transactions on disconnected link.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index bafa52a0165a0..17c57cf98ec5c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -75,7 +75,8 @@ void dp_disable_link_phy(struct dc_link *link,
 	struct dc  *dc = link->ctx->dc;
 
 	if (!link->wa_flags.dp_keep_receiver_powered &&
-		!link->skip_implict_edp_power_control)
+			!link->skip_implict_edp_power_control &&
+			link->type != dc_connection_none)
 		dpcd_write_rx_power_ctrl(link, false);
 
 	dc->hwss.disable_link_output(link, link_res, signal);
@@ -163,8 +164,9 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 	} else {
 		if (link->fec_state == dc_link_fec_ready) {
 			fec_config = 0;
-			core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
-				&fec_config, sizeof(fec_config));
+			if (link->type != dc_connection_none)
+				core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+					&fec_config, sizeof(fec_config));
 
 			link_enc->funcs->fec_set_ready(link_enc, false);
 			link->fec_state = dc_link_fec_not_ready;
-- 
2.39.5


