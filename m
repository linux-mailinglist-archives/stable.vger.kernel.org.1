Return-Path: <stable+bounces-59448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A99328D4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C854283B60
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C0D1A01CB;
	Tue, 16 Jul 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rANIUQIz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17119D8A9;
	Tue, 16 Jul 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140061; cv=none; b=jqKxQzmFn3NVswFjb8X/Mv5hyr7Go+nw9dB597t0Dw8q8hVjsteACj5YDgvvaV5OMkuh0fVu8wMsiSH26Fkr+AMD2pCNLFRWCbkSqeHoYAAZ6aHgLK87lDe8fF7PICtd6tyiSpIgiSNqBaijCTDgzNzS4tH0VWOfvsNi9vGcCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140061; c=relaxed/simple;
	bh=Sc8IZXB9/qEV7qoIpJ7WDZmVWDIUaYnpdgLUYXmbH1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2LvZ23NUAz3RDVc9YNZf488uX+zK9Wqipxe8cGuie1tsVp7rsr8ziwI1+EnPDNIo14NsUlnwtPttUh+6OvousY7f7KYTxQIdf+m7WtDE3TKfrEO4Zr8tvjencZh7F4JCUZeP9ykdRxQCzda8msctr4JRhEhJgqXezxEvAIu5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rANIUQIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCDBC116B1;
	Tue, 16 Jul 2024 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140061;
	bh=Sc8IZXB9/qEV7qoIpJ7WDZmVWDIUaYnpdgLUYXmbH1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rANIUQIzTgOjrfClMcyPUBTal6tRFNi+o01mTMpS6c+ng2xwnbqYQLyiz4tWPH8uU
	 n1OxI5zl963H3cVteZomUfvI20O4QytZ7H2elXc7pXP7mkF2tAP46bwIe3BpYJgeQp
	 /bhUneEMiHzXuGGLqmQ17SNiyrFZSqdG0uCCp5Z7mkUURXnu9FVW3E5c1CYvSNcGUM
	 cuTjlMY5+TtWjMTGtRNxtNIYtReUIeWr/rLuvkzDRcBtyfZXjM2csdp70wPN7PfhE0
	 Qa14Lr/EyfDTRtQM3mk6/u9NG4I3KLV4VDwZbwv4Sdq+5WjpwBUxL+e1llmiSjAxGK
	 Vwt0anZtHDKPg==
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
Subject: [PATCH AUTOSEL 6.6 10/18] drm/amd/display: Reset freesync config before update new state
Date: Tue, 16 Jul 2024 10:26:45 -0400
Message-ID: <20240716142713.2712998-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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
index 7ed6bb61fe0ad..a1acc8108586f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9517,6 +9517,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
+	reset_freesync_config_for_crtc(dm_new_crtc_state);
 	get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
-- 
2.43.0


