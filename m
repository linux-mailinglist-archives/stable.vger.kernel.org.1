Return-Path: <stable+bounces-220495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PE3GnU9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF81C6A76
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2865F31D2FB8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2673C7DB7;
	Sat, 28 Feb 2026 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnuA2Nr/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC73C7DAE;
	Sat, 28 Feb 2026 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300380; cv=none; b=YQhdOMoU3RexMltAmt0fujzqgoyBMSt3dj8NKajpeM/smgNqP/pIImm3DPk5/Lsx+jLN6t4Wu7NDiPJK1tupNRu9FaQCszsFFa9b1EC+Vr+FZaOPsHI9eSIYUnjlxm5QEHC0V7Q8CS1CfsBu4/UlG/Cch6HDN2YPPU35xkpMt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300380; c=relaxed/simple;
	bh=m89m20wiqH7mnSq3LhErip9IslFvY+E+ehGPSQd9HaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyJ37pORMitEGHiHUocPRC9NcDFVxE7kOw5zyJmuBuxcJqzSkti7+lBzDiVUqexz0op9TinIfRfYAj9GpZBm76Bwe0ZDDBX4gbj+7xIg1lqPAHJikvhkNU7fwjIsGDyxgZQQEBPqNE2QGiCwu6hjJ7m/92DCcBpBfvR6BBOYiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnuA2Nr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CC6C2BC87;
	Sat, 28 Feb 2026 17:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300380;
	bh=m89m20wiqH7mnSq3LhErip9IslFvY+E+ehGPSQd9HaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnuA2Nr/cb+U9gVnxh+s3wfM6E+H1CMwMQjT9+t/0OPSz2RuYaUe5+GIX46SPg5np
	 HMAodA/gUvnW58HHqLv++JqsXPPFq5OZNZXyzscCfqeI/EgZalY4bn6xDAMxajguWa
	 qFcvbk77nT9kOsLADEl51oFeS2DhEs28WlcoiK4v/KuPCLFUN5cah9QQIyNsg8sIeF
	 u+gmtbpb2ZdqA9jw7vDfU2uGw53rc7HZvDe5xWH+bCstmgVAkGxy3N3D7eH84KiB4W
	 JO08K3hvsQLLY9kHx0DoD3s9wsRkQA70cHINt1QbipNaz6MBKjjDfXiVULDLsRYDm+
	 VI3nNVc6mOYTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 416/844] drm/amd/display: Fix writeback on DCN 3.2+
Date: Sat, 28 Feb 2026 12:25:29 -0500
Message-ID: <20260228173244.1509663-417-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220495-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAEF81C6A76
X-Rspamd-Action: no action

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 9ef84a307582a92ef055ef0bd3db10fd8ac75960 ]

[WHAT]
1. Set no scaling for writeback as they are hardcoded in DCN3.2+.
2. Set no fast plane update for writeback commits.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 209a6e5c713ca..150cc3fc7b2a9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10648,10 +10648,10 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 
 	wb_info->dwb_params.capture_rate = dwb_capture_rate_0;
 
-	wb_info->dwb_params.scaler_taps.h_taps = 4;
-	wb_info->dwb_params.scaler_taps.v_taps = 4;
-	wb_info->dwb_params.scaler_taps.h_taps_c = 2;
-	wb_info->dwb_params.scaler_taps.v_taps_c = 2;
+	wb_info->dwb_params.scaler_taps.h_taps = 1;
+	wb_info->dwb_params.scaler_taps.v_taps = 1;
+	wb_info->dwb_params.scaler_taps.h_taps_c = 1;
+	wb_info->dwb_params.scaler_taps.v_taps_c = 1;
 	wb_info->dwb_params.subsample_position = DWB_INTERSTITIAL_SUBSAMPLING;
 
 	wb_info->mcif_buf_params.luma_pitch = afb->base.pitches[0];
@@ -11667,6 +11667,8 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct dm_crtc_state *old_dm_crtc_state, *new_dm_crtc_state;
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
+	struct drm_connector_state *new_con_state;
+	struct drm_connector *connector;
 	int i;
 
 	/*
@@ -11677,6 +11679,15 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	    state->allow_modeset)
 		return true;
 
+	/* Check for writeback commit */
+	for_each_new_connector_in_state(state, connector, new_con_state, i) {
+		if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		if (new_con_state->writeback_job)
+			return true;
+	}
+
 	if (amdgpu_in_reset(adev) && state->allow_modeset)
 		return true;
 
-- 
2.51.0


