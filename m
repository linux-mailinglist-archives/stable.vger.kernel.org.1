Return-Path: <stable+bounces-140232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E2AAA68D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121233B8176
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B923247AE;
	Mon,  5 May 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReUULI9B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9393247BF;
	Mon,  5 May 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484463; cv=none; b=uaVIWZQeDU0ykXFFY0mHIZoJnboik0mZZhmavZVOarHidmmD5aVEIkHugHZnoN6725rdrbyjvQB+9RAU9bkXdRBHbV1HJaW2eRppIllP5OzcD41RfLJTWm/Wc7u5+JuRTEymF9uuJmwd1mBHByL08bPNQSchjrerfPPd86so1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484463; c=relaxed/simple;
	bh=+Z8nJzgkLEk+MN5GftpCIrHT+MEi2c7T5NzxCRthY1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQmcr79eu9Dfo2SyTtMSJKS9InQaIe/Z/te+f4Ulil3xBkHhel2UVZ2HWf0biQtjzoOKUyE9uI59YRHq7PuOkxD5wCxC9E+FGOWEfmtrSmVsYZJUP2l59bs8zhpePtPtG0mLcd5Ej3HbWjwmxTe0cuOQfRMYTtQxEs3AtTk+Ja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReUULI9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB6EC4CEE4;
	Mon,  5 May 2025 22:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484463;
	bh=+Z8nJzgkLEk+MN5GftpCIrHT+MEi2c7T5NzxCRthY1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReUULI9BpFCyHW+VwzKUz8gLq0TSlz7XEzrO1CLyKT1c9DT5qSvJcSZcQFmLKebEZ
	 RNyKjaTxzzZXKvYmeN1ldzci8g+MunZKDBS12WZqjU7mJEb41ZSQAxMXN8B0wWdQG4
	 eH+wKIqlW9/+3ScEItZ2j7rD3vD3flTTPImFT4eQLnmWQu2OMxT3/3Lmzvl1iPqVJ3
	 mhNMNEeLjB0mijDfxd7b5wOvaFcMjE+hpRG7bDfxbSUuzQpNOSrrVYPOUxMvoBg3at
	 1s57OUkxvkz8QuUhlwTiVkA0SyVCbl59fTPBQcaaAXdIw352rmlo4ndAWxVRB/aICe
	 XMdYiHfpxio8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	chiahsuan.chung@amd.com,
	sunil.khatri@amd.com,
	aurabindo.pillai@amd.com,
	Yilin.Chen@amd.com,
	mwen@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 484/642] drm/amd/display/dm: drop hw_support check in amdgpu_dm_i2c_xfer()
Date: Mon,  5 May 2025 18:11:40 -0400
Message-Id: <20250505221419.2672473-484-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 33da70bd1e115d7d73f45fb1c09f5ecc448f3f13 ]

DC supports SW i2c as well.  Drop the check.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d51dbac3235ca..5f25fe7721c17 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8394,7 +8394,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
-	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+	if (!ddc_service->ddc_pin)
 		return result;
 
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
-- 
2.39.5


