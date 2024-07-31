Return-Path: <stable+bounces-64846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 137CD943AC1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EB8B23672
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A15B13B5A1;
	Thu,  1 Aug 2024 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sgubpro1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725E13B5AC;
	Thu,  1 Aug 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471031; cv=none; b=PrUFWlf/iuqS85wxkCnfo2/MoLjjDSofb3ytqE5f7mb0+RSJfqH5pylsGgAClZ3P7f6TW9PdVLYqhPc5Hio/bXjb68UisE7fjZBnmWFWQh48SLJXebkBbtkdkGYSmcJjWUrjkuvLcObUUs4o89Lp4hN9gI8EvWvc0cAgKgV6jKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471031; c=relaxed/simple;
	bh=0VXbUl11Rtte8Kli2pOK4K2w0PnCqNRTqNw9MqpWpOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZeAEQ3f+Ul7W1Pn3wp/ThyDcmot9Xqxv2du5Dob0OLB5CUKMc/MS8mdwDh/A4CmuoRrmqbWfYvAahTnftEJJuBBAznZ5nXghAucpw4U2uzsKtE6w4IToOP4tfMpRKQlCHQ2b6jfXDRsaBKXpwhTQEbJrcRQGjSmyKemUbkeRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sgubpro1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46381C116B1;
	Thu,  1 Aug 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471030;
	bh=0VXbUl11Rtte8Kli2pOK4K2w0PnCqNRTqNw9MqpWpOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sgubpro1JN+OpyqCejgJPrCf6zDKUXl3711ZujYC3PdY5spkWt1b9z3OPew4KyIzM
	 TjFuePtE8m9SFvc46Mvda7HIc1kEB6DpM3H+u8BqwRzKA7JCnusIgzSLv+AgxY8rX2
	 rIuBxRWlPXBGXKtvVcWlAVkvkjnb5dmS4KGoSpiKJQkC8hibfdQ+FjMLhMO3wkk+Vy
	 c14Hyf9Yq+U3g7Vs3SvfoLYDisWIZsf8Vd7DGWSQEcbdHumn5rAfTeaPB3ePzCy7v1
	 jzDbdFzwFEOB+N79CxJX0Wky8RMhKBv7EvX0DTRa2Qz4p3zet68PX5KlQd7KBGwDXm
	 BMiWmJqV83CSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 021/121] drm/amd/display: Release state memory if amdgpu_dm_create_color_properties fail
Date: Wed, 31 Jul 2024 19:59:19 -0400
Message-ID: <20240801000834.3930818-21-sashal@kernel.org>
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
index c893cf8f2d36e..fca6f7d4c28e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4206,8 +4206,11 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
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


