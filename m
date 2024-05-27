Return-Path: <stable+bounces-46546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4B8D079A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E4928CB71
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145215FA63;
	Mon, 27 May 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLCLjfnA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421015F411;
	Mon, 27 May 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825497; cv=none; b=YI017mQ+sKmNX8Zi9jnjxaqnPfHYM0Tk4ZDZAeJE2BOomTq4KTS/S1vqJ3bqj6uydXOgLf+SEP8Ehx2huF/hHdSj6Uma0U/aFq/8KiX/e1nuRiLdNq4uSjjHhvbbA/CcGLXcju3nkNVMniGOhpqwrtz2+hEUJ1fwQmGRkl39GsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825497; c=relaxed/simple;
	bh=uufng8KFeHR5LB7rGOgyEAOrEtol4iygnJ1oL8abpO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U96iwNlNBtbYGIauAN6fNskChTh76/yNZnfEue4kHipeu+0DnsAzbzqLk2S1K/ypCFmQ/TWEjd2DlulBBl5KHD9s90kHVaSIxoVNB+d2GoTpDfs2hCzosngj90mZy+5Q8zkxRiN0IKejLdcHfbNWaSpbAbZGfFKJ0dlTCBsqjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLCLjfnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A00BC2BBFC;
	Mon, 27 May 2024 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825496;
	bh=uufng8KFeHR5LB7rGOgyEAOrEtol4iygnJ1oL8abpO0=;
	h=From:To:Cc:Subject:Date:From;
	b=YLCLjfnA4JeVmJpaiGRo+aX+OIhSFgGyf8r4PVk4t6M+DdHA/QpMxzmTx1fCUnOg/
	 8xNAFyx0nZXvEr+Ogbq2YrIksAFNZJo2dHzQ2nhkjRXsNDmgipl0o/ijiUVLSSb/rR
	 u5m+mJDAZoZp0bY6A1k5bRbFf1qO+CPIlPpQ7zgYaNqMfvA2SlmF6yVDiUm00Vv4jk
	 kmt/EAhx7VBYIvEUqa2KOmMp/UhxwlONy0FvtzFkGlP2aEfWNM7kdQC0rBPTEGcfpI
	 3o0PQlZeDSmCV4aqpDwyRsWofB/o4z2eMr1SWfZeFQtPibAiH29lz7+iDMKirRM+96
	 I57Iu9mWtYDqw==
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
	wayne.lin@amd.com,
	martin.leung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 1/6] drm/amd/display: Exit idle optimizations before HDCP execution
Date: Mon, 27 May 2024 11:57:51 -0400
Message-ID: <20240527155808.3866107-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 3e81850a7ffe3..47bb973669d85 100644
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
@@ -507,6 +515,8 @@ enum mod_hdcp_status mod_hdcp_process_event(struct mod_hdcp *hdcp,
 	memset(&event_ctx, 0, sizeof(struct mod_hdcp_event_context));
 	event_ctx.event = event;
 
+	exit_idle_optimizations(hdcp);
+
 	/* execute and transition */
 	exec_status = execution(hdcp, &event_ctx, &hdcp->auth.trans_input);
 	trans_status = transition(
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index f37101f5a7777..8a620c34396c7 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -154,6 +154,13 @@ struct mod_hdcp_ddc {
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
@@ -269,6 +276,7 @@ struct mod_hdcp_display_query {
 struct mod_hdcp_config {
 	struct mod_hdcp_psp psp;
 	struct mod_hdcp_ddc ddc;
+	struct mod_hdcp_dm dm;
 	uint8_t index;
 };
 
-- 
2.43.0


