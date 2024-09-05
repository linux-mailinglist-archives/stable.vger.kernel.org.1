Return-Path: <stable+bounces-73225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA096D3DE
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4375289A97
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DEA198E89;
	Thu,  5 Sep 2024 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fsH9Bzt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A91990C1;
	Thu,  5 Sep 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529542; cv=none; b=cHdIslQ2e97+FsTcLGl05faWy1Grkl0RQlDlwsL0lmAeMZHLP9NtA3dbeizcNCN3ZKQuBBGPQBDJn2axcqYU9gq0PtMlXI+smK/RKI5LU3Fm/fA5IIcFT5c4uiXwF7CJHTceRzYOjYPGjJSoSc9FAz5dHzy3gD/2KVN4rRzMJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529542; c=relaxed/simple;
	bh=TK63gSxKgPzdHwfx0+JOxpDAnWQa3hlhQKOYkMKFRq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIam9clZDDhfFwx929CHjOCoWfllz8Y2Mx0Wac8JHGJziUHA6FFCf7DGvA5bWRFANo8X+0owgiwsprYyoD8VzAS0KhWc+3qA+UgZGYC71UIvDRCjjLrIwh86gqpl3HUhF/XoaN2FyWBSrlTc1+gy3UMPDjrbAg9TBAtpvxiy9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fsH9Bzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03973C4CEC3;
	Thu,  5 Sep 2024 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529542;
	bh=TK63gSxKgPzdHwfx0+JOxpDAnWQa3hlhQKOYkMKFRq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1fsH9BztvV7gx9XJFVtYkBG6CBLjbAuu5fkjb3ZeH+T0G6t7Xq3BzteFezA68BtuP
	 96mtMpRG5PSli1bnZx5irMDZk9IzVAR21UFJUlJ7yUYH/11n6gpq7nwMSl1d8Zrx1X
	 uYxQSmkTC8rk4XkXEOoeN/bhP8Smg8nnlQg5iByM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 067/184] drm/amd/display: Release state memory if amdgpu_dm_create_color_properties fail
Date: Thu,  5 Sep 2024 11:39:40 +0200
Message-ID: <20240905093734.854970731@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 52cbcf980509e6190740dd1e2a1a437e8fb8101b ]

[Why]
Coverity reports RESOURCE_LEAK warning. State memory
is not released if dm_create_color_properties fail.

[How]
Call kfree(state) before return.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9cf9c8f917a1..c00d96ec8be4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4129,8 +4129,11 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	}
 
 #ifdef AMD_PRIVATE_COLOR
-	if (amdgpu_dm_create_color_properties(adev))
+	if (amdgpu_dm_create_color_properties(adev)) {
+		dc_state_release(state->context);
+		kfree(state);
 		return -ENOMEM;
+	}
 #endif
 
 	r = amdgpu_dm_audio_init(adev);
-- 
2.43.0




