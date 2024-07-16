Return-Path: <stable+bounces-59486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7293293C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA80B21BBA
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C5E1A2C06;
	Tue, 16 Jul 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1WiCmqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9B1990D7;
	Tue, 16 Jul 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140213; cv=none; b=ogB7P2uzKgB4PQP968deb1owWBWpHWvlq7DS9OkOU9vJlX7c68eiiYtQBSN8RFjU3LQ+9niQEctZfTtwhh8XO34drqkvIJNu0jbu3+gb7nBHLA/ymrRBc6ldiJDUWA213NCrj0qvBOa3UG3FesabegdpefIWKVSjdxdj9CLusNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140213; c=relaxed/simple;
	bh=U+xuZ+SSYRANK4+OprKoEHOV9pVEOFuelFsbBJh26Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIAFFpDeTZXGppJPan1RKy2a4Iy49ZchGsG8dmL6BvtYK4yf/oMcE7tTjc+OLQd/gtDURxtqCVyGdXcqWs45wVzB0x8b3Ie34C/2X+DDMzVC1c8wgTI51IAjQTqYWrJAW9FhBPx9MyQp7xjtqePl6/Nugh4XRkrAdNWSNP/4Swg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1WiCmqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1676DC116B1;
	Tue, 16 Jul 2024 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140213;
	bh=U+xuZ+SSYRANK4+OprKoEHOV9pVEOFuelFsbBJh26Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1WiCmqFX8uZxL1dZF/IwRnnq5Hq2Ix82vGfVZvRqDQvsRxMhCZC3JQE/wZfCAUGJ
	 BD2L3htuvQzK0VrlUKaBKpgfuonjFEhDsMqCpDUQ0D0Q2mnhKQBRJivKRhCPpADJUN
	 70MTA3T/aMoa5ZW6/kNEmxlWlgMuC59sYRq24LVfRrGRAZnftnJldFB7l1OZtvl5Bi
	 jxiJX3Njz/5SxwoIF+cDZQfVUBFqz6feuXwCOMKArp7d1WyDahUX7RLJaqfkmMLJGP
	 TuhJOwifMdk3vBEdyJ9CtHynAJNvz/nfSrFXU5bSB3lT81Bs83c1Q9bKH4s6ESlVqr
	 9WOYNdpEAutBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	joshua@froggi.es,
	wayne.lin@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 6/7] drm/amd/display: Reset freesync config before update new state
Date: Tue, 16 Jul 2024 10:29:46 -0400
Message-ID: <20240716142953.2714154-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142953.2714154-1-sashal@kernel.org>
References: <20240716142953.2714154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
Content-Transfer-Encoding: 8bit

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit 6b8487cdf9fc7bae707519ac5b5daeca18d1e85b ]

[Why]
Sometimes the new_crtc_state->vrr_infopacket did not sync up with the
current state.
It will affect the update_freesync_state_on_stream() does not update
the state correctly.

[How]
Reset the freesync config before get_freesync_config_for_crtc() to
make sure we have the correct new_crtc_state for VRR.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 29ef0ed44d5f4..c957ef1283f68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8385,6 +8385,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
+	reset_freesync_config_for_crtc(dm_new_crtc_state);
 	get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
-- 
2.43.0


