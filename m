Return-Path: <stable+bounces-77254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305A985B18
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C3C282A2A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02017191F71;
	Wed, 25 Sep 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpw+kbvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE21917FA;
	Wed, 25 Sep 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264823; cv=none; b=Hn7qjBGD5ZaPz85JtAx5DMDbH3uC+BeRjL2ImZu7/QX/UVjtq4kw2NBYppjv3DHr5b49mJksrv0HRjA1Bqo/1Oy0SbVkmcBy3V7CckR2t5UfoGHSlWgLoBvS1YjoB253ohakfXxYL7AgwshuQrG6Jp+3gAjLVO0z60eO5qNakNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264823; c=relaxed/simple;
	bh=ZiA89dA0fIoW6p3uq4lMOWaU2nG0xRO7domC7scYm2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQdkhl9thlnxKoUwdJNfS1M9dkgAgUP+c+GvceZWyttrtzzRTFxwwA6SJ+nPQtpegpeueGT5gy1ecya796xNvUhTNC6+0tR6UQm71f8MVmTnfhBiBm8k7UqJtuwfuXDw1UExgIhI+l1W1CqP0PcsB1APAMtSCxfQG+Hsi2AyEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpw+kbvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D223DC4CEC7;
	Wed, 25 Sep 2024 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264823;
	bh=ZiA89dA0fIoW6p3uq4lMOWaU2nG0xRO7domC7scYm2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpw+kbvrfjDzx9OEIo1jqrPu5/sF4PnfHSIgYGsjPRTzyp8D93HaFAHWR0AZ6p4tN
	 rVsoZ4i2ejpVrAtz/mNek7gMFmSVH5N8UzyKcbt8npjq0guodGPjafBiD6/irKVYFv
	 RwbjOm0wdv2rNynUjfZafnFW4rxtEm+I0QGjAQadAsjR4cV7lfVrWHE/t2iFUujDU7
	 z+teLGsnSyj51hLMOAm2GjIPUmPfvW356XHLz4KqmJTef3eVv7qOF1kLtabWs9ECIq
	 gJpw8KE5CP2HrKTf4Ywm1zBDXo1joUdltyjmCOilJauSl8feK+Y8vTBjgw5izwCyRT
	 59pyRE8yvoGig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hamza.mahfooz@amd.com,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 156/244] drm/amd/display: Add null check for 'afb' in amdgpu_dm_update_cursor (v2)
Date: Wed, 25 Sep 2024 07:26:17 -0400
Message-ID: <20240925113641.1297102-156-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 0fe20258b4989b9112b5e9470df33a0939403fd4 ]

This commit adds a null check for the 'afb' variable in the
amdgpu_dm_update_cursor function. Previously, 'afb' was assumed to be
null at line 8388, but was used later in the code without a null check.
This could potentially lead to a null pointer dereference.

Changes since v1:
- Moved the null check for 'afb' to the line where 'afb' is used. (Alex)

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8433 amdgpu_dm_update_cursor()
	error: we previously assumed 'afb' could be null (see line 8388)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Co-developed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 264e67634dcdc..f59cca515fe22 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8753,7 +8753,8 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 	    adev->dm.dc->caps.color.dpp.gamma_corr)
 		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
 
-	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
+	if (afb)
+		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {
 		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
-- 
2.43.0


