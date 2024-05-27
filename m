Return-Path: <stable+bounces-46476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E298D0698
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7792E1F22931
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8717E8EC;
	Mon, 27 May 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U98CLGit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2E17E8E2;
	Mon, 27 May 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825098; cv=none; b=YUYhmBHgiSRMD7KKCWL4n9d8PcMVt8e93zKF0+baCJQx9JdscrKPzaf4KuXUky55BKXtfv4YLiupz8YY/eflGLnTODMieBgs3mwUgMfYLjxAWgsX8xboB/0n/9fFDRBcaTbgXX/ScdE2B6aJn2laL3iSDhYbibUg96voS8+BjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825098; c=relaxed/simple;
	bh=X5KGBxxFXxnv3x0Ob+GF5Asew3YBonDrWe3a4Pa7rZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpEglXhCm3v1zJ3iixgCcD9AVIZHCel4mFq0/K5FFoEHRaYwfTmwEDYfWvy8LtUcMERN7Yl3i92oCBEpUrR3oGZ3nvuwZs1/0NBwLHbRbe26kiyt5a7fBnmX5MKJb1A66mVHEHSpjLymqZvi0+Rsc2I58Fe1x4q235fl3O4B6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U98CLGit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88D2C2BBFC;
	Mon, 27 May 2024 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825098;
	bh=X5KGBxxFXxnv3x0Ob+GF5Asew3YBonDrWe3a4Pa7rZs=;
	h=From:To:Cc:Subject:Date:From;
	b=U98CLGitS+2ZMQaflueQm7lxxUVRkffEOjmyQRpiX1nnuirGGe3goS8OIeBrUaAP+
	 Z8oSVx70fKCVqPTCfPG7x4F3d1yNYB+Lh1rOhl4A9TbtoEc+PgaBdXn40X9xn2Hcvc
	 /DEcBdnz4q7fxY2AGbAhklafjoX3tw09rW2dJTK+bGAL1ADaVuB6m4KXKY99GHu7Rx
	 wW/OUzJp5a7XTDWBiTtqti22LxcZh7ATTV7F/4vMcoalZJlaQI3uJISb7HGiABChai
	 0iC/gVevaQvwFXMtfoNdos4owkFFSPik8jdjHEX9ax9Ny9WPHFIvaF3k8EJ/Pm5z8I
	 svNgRHyw022sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	martin.leung@amd.com,
	wayne.lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 01/23] drm/amd/display: Exit idle optimizations before HDCP execution
Date: Mon, 27 May 2024 11:50:02 -0400
Message-ID: <20240527155123.3863983-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit f30a3bea92bdab398531129d187629fb1d28f598 ]

[WHY]
PSP can access DCN registers during command submission and we need
to ensure that DCN is not in PG before doing so.

[HOW]
Add a callback to DM to lock and notify DC for idle optimization exit.
It can't be DC directly because of a potential race condition with the
link protection thread and the rest of DM operation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    | 10 ++++++++++
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 5e01c6e24cbc8..9a5a1726acaf8 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -88,6 +88,14 @@ static uint8_t is_cp_desired_hdcp2(struct mod_hdcp *hdcp)
 			!hdcp->connection.is_hdcp2_revoked;
 }
 
+static void exit_idle_optimizations(struct mod_hdcp *hdcp)
+{
+	struct mod_hdcp_dm *dm = &hdcp->config.dm;
+
+	if (dm->funcs.exit_idle_optimizations)
+		dm->funcs.exit_idle_optimizations(dm->handle);
+}
+
 static enum mod_hdcp_status execution(struct mod_hdcp *hdcp,
 		struct mod_hdcp_event_context *event_ctx,
 		union mod_hdcp_transition_input *input)
@@ -543,6 +551,8 @@ enum mod_hdcp_status mod_hdcp_process_event(struct mod_hdcp *hdcp,
 	memset(&event_ctx, 0, sizeof(struct mod_hdcp_event_context));
 	event_ctx.event = event;
 
+	exit_idle_optimizations(hdcp);
+
 	/* execute and transition */
 	exec_status = execution(hdcp, &event_ctx, &hdcp->auth.trans_input);
 	trans_status = transition(
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index a4d344a4db9e1..cdb17b093f2b8 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -156,6 +156,13 @@ struct mod_hdcp_ddc {
 	} funcs;
 };
 
+struct mod_hdcp_dm {
+	void *handle;
+	struct {
+		void (*exit_idle_optimizations)(void *handle);
+	} funcs;
+};
+
 struct mod_hdcp_psp {
 	void *handle;
 	void *funcs;
@@ -272,6 +279,7 @@ struct mod_hdcp_display_query {
 struct mod_hdcp_config {
 	struct mod_hdcp_psp psp;
 	struct mod_hdcp_ddc ddc;
+	struct mod_hdcp_dm dm;
 	uint8_t index;
 };
 
-- 
2.43.0


