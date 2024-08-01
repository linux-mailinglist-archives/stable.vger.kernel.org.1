Return-Path: <stable+bounces-64955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190AD943CF6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7ED1C20A56
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8AF14F9CC;
	Thu,  1 Aug 2024 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxvm9q7x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53812E1D1;
	Thu,  1 Aug 2024 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471713; cv=none; b=uNgOTY3uZBQHBvPmgyz4aKmf37T0L75FqBfPxaDP1179X4tmI68+OokcEMBPdPdoedxVYsohMniKZ0301cq13OEfM0s10lxEe12slXOMzcZdLHQfh55hKYPDhVPWpYcurUJJ78KBLwc5yC0KaLWOjk36V1Qd6eK3KlgoFFzbfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471713; c=relaxed/simple;
	bh=+zuTLK1ZQgh3EOdx9Tj637JC/P/f2GOPL0shaDH8ZCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJibzRkuP7LrfHw81OE6I7ZWgXfAmyk9XrK97P30fdiu67gt3wMuhcWBR8lGKnLH5YF1sTiOiPEBT49gchqUSJm8G5A7thiuhCiiGMWwSZ0LGB/JQXGq5cV4MuZsfUQA+R3xnGpnFpQijB2CrPTcB7t3inV23GZ79NcFAyhyEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxvm9q7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EB5C32786;
	Thu,  1 Aug 2024 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471713;
	bh=+zuTLK1ZQgh3EOdx9Tj637JC/P/f2GOPL0shaDH8ZCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gxvm9q7x+RZONl82+HYyQrlvNrqkkV6XL2n3vjPCaaTTfp9LiF1fzQC0ZXgAVf15k
	 qtrbO2noyz63SBd6ac8jAAXEtRG+REetZb9shE/Rao350fJ7Gn1xioWkO9dkc5Tdme
	 ny6yKNrp6P/U/FlEbLHi7fs/9VKlnRmhTsh434TZUUvHZCJpVuE9xaoq/vmyE0ggO8
	 UOwGZiAb/KN+NgM/UFarIOYiABM08VpFWFWsfqFA2O1UFDK6UfoSxtwIrlkbymtXH8
	 g3d3Bb8/Nc3f9I351Y5c3a/ivYHzpTvzm0IN8v8v0bsakvU2XFG5D/P3pX//TSTRt7
	 /uhEDqXFA/6LA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
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
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 09/83] drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
Date: Wed, 31 Jul 2024 20:17:24 -0400
Message-ID: <20240801002107.3934037-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 84723eb6068c50610c5c0893980d230d7afa2105 ]

[Why]
Coverity reports OVERRUN warning. Should abort amdgpu_dm
initialize.

[How]
Return failure to amdgpu_dm_init.

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
index 7fa95a81b69bd..5eef17f092ceb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4443,7 +4443,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	/* There is one primary plane per CRTC */
 	primary_planes = dm->dc->caps.max_streams;
-	ASSERT(primary_planes <= AMDGPU_MAX_PLANES);
+	if (primary_planes > AMDGPU_MAX_PLANES) {
+		DRM_ERROR("DM: Plane nums out of 6 planes\n");
+		return -EINVAL;
+	}
 
 	/*
 	 * Initialize primary planes, implicit planes for legacy IOCTLS.
-- 
2.43.0


