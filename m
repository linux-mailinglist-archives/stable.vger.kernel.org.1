Return-Path: <stable+bounces-59465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC4C932905
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6F52841E1
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020811A0AE7;
	Tue, 16 Jul 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUIAN+us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389919DFA3;
	Tue, 16 Jul 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140131; cv=none; b=LdHeLH/kDS1Ph7B6QkHdBnVBBvKr5ysWFewO3Gtv5YJaZCUW+kVXj93KrHe/qjR369GGBMWI1T84W4dzeqejBzdCqd1wKdr1bbYVuuWBz/ykVI7p6Eic37Nn3kBewHBFqUPWWQbRux7nB+GHStZ/IYOfUHuVRU1fasDXBR7UuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140131; c=relaxed/simple;
	bh=pMeVGCYsEGtTSm6MdBRjPhxWBAHKsx4pkgme6I3Lnc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABBblj+HTsmL1nKmCOmaMf9yUSvCvP1qatmZe4zc2Onqa0iVX6jRgsLNmva7aVAgHzMiOY3wyQ/pwA1jp/M9dY+6svnwQhupiCBegvMOi9W3xAajmSMrCFx+9GiBeeukIaXpOFqZ2Em2EvJrBMuocg3Z33AMpCs/K8mL18HbsKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUIAN+us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82041C116B1;
	Tue, 16 Jul 2024 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140131;
	bh=pMeVGCYsEGtTSm6MdBRjPhxWBAHKsx4pkgme6I3Lnc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUIAN+usbWtz0sFzscvaJNKrO3DTbWbMFMYaNLtlWwoaePsq3rI3XOS7QV3whwxhn
	 QC6C/6zpDW9JI2MxhXUVEn+/MVWHCuQQJ4Kvi++h/adGSmEB+dpJBBOf9KwXsuc0tS
	 Rw7tvncJNyELsCe1I/D44MnDqUmOWzQMF95zjMwNZ3eZfaeXa8n41LQO07BnnozfSt
	 yepQIm0O/ZtAPWljV+3zivWiwGFL7b8u+nGHMbNPLhOeomgtZK8CqKBPnFyIty4TYl
	 dhmsgFS8uJyk9s56uyIOKKG3k8s9eJgNMDPBG6VxGsqUFqFjvVeunpMhvpFm3FK/BF
	 GfMbtkWpxP/2g==
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
Subject: [PATCH AUTOSEL 6.1 09/15] drm/amd/display: Reset freesync config before update new state
Date: Tue, 16 Jul 2024 10:28:06 -0400
Message-ID: <20240716142825.2713416-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
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
index 31bae620aeffc..ebf53a9a9dc89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9278,6 +9278,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
+	reset_freesync_config_for_crtc(dm_new_crtc_state);
 	get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
-- 
2.43.0


