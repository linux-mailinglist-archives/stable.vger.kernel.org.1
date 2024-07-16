Return-Path: <stable+bounces-59493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DB932955
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F2B2339B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1E1A2FA6;
	Tue, 16 Jul 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy7h9R6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B619D89A;
	Tue, 16 Jul 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140241; cv=none; b=HTGyG4UZ+21sLsr8ZKnucuqNyObgFuJPl6CoFdsY9nTbLMVjrsVDD6cn6sItPjwDIVSl1BfYuWAPNpCEMR2cmrpydmFASFopv0sOtfhTx12EtEnSokbiqp5JlZNCTY7iFKy6D1GwDd1qMuLA4fNF+/SdzjKdho9y1sMTZSy/IAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140241; c=relaxed/simple;
	bh=KhMVWtLsznekyBocafD43QGTqTFf8KNG+G8DzrM3yTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCHp86+ra7iUyzWbwKsNSAsbt+0Ey1jRJTYR6P59G8eFR5suFx5s/vzTWVVTmGYk2U78r5x8NIlpnpsC0r8TKp12Dav6JkGD5H4QUMczggMibPXNZ8vXaQ2LCgh2DnKOwCQhbwzoGzrpxd13PjJQ4vdonV3L8934IrjQPbiMSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy7h9R6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE4CC116B1;
	Tue, 16 Jul 2024 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140240;
	bh=KhMVWtLsznekyBocafD43QGTqTFf8KNG+G8DzrM3yTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oy7h9R6NIKlzY7Qm4mdF+Lb+MTx8zsPxwmODkBmu8Lu9NsgckigbILymN2puuoW07
	 JZsI95jKbgo+3jLgA7f517hrXPZ8Yr5YW4Cv544Tv4Y+MyCJt26bQ4kWSDFR1DeLoS
	 YmhWLfZn9Ml87meOMvbN+MHnQXOTEf+X1QI0z6mWB+qQ5gSmel/FiaHvFvHD5dMEzY
	 zg5k0OJ1cYtRauoDlApXdRG+Hep1jsQW2KQk+AygTI0NdeNjnIKW1Ec7H+GvAKIKEc
	 3HkaLau8IrAW+jmBSy2ZAIAW4UGfbLsdBOOSLNXtzfKAugWhXTIymTaF/5dfC5WP3i
	 zXscCE2UOQw6A==
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
Subject: [PATCH AUTOSEL 5.4 6/7] drm/amd/display: Reset freesync config before update new state
Date: Tue, 16 Jul 2024 10:30:14 -0400
Message-ID: <20240716143021.2714348-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716143021.2714348-1-sashal@kernel.org>
References: <20240716143021.2714348-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
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
index 3bfc4aa328c6f..d400f9f4ca7bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6878,6 +6878,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
+	reset_freesync_config_for_crtc(dm_new_crtc_state);
 	get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
-- 
2.43.0


