Return-Path: <stable+bounces-65199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F2943FA6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E842B1C21201
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3181C8FC4;
	Thu,  1 Aug 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP67vdjj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07872139587;
	Thu,  1 Aug 2024 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472845; cv=none; b=TeSssD44gzzK8Dv5faz77m3JYpaGxw3cKY3lFXEU6aW2kJWOXc+27eejs6H/Y5qssN0OZirpZMKg2uGAKsQdYUKS8LfZ7nJaEKGBpfdpdr/xILzFrdbXPCjJ0hz5f9Sosr6n8vx5+piKfK5SLXFOtEUxThaeGpCbf3hHHwsAhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472845; c=relaxed/simple;
	bh=98MKxWkflC3Po6dUAHRp0v+yDsjlrfI3AI8OMS1fWtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwaE1FOzof3fC5nSMJcAl1yUJKYHYDw5HsApuhlmGyLcOkpImDAhiIhKgRJdo//6Zi9hpfsckDUtq1EkRO8OPQJ52tPP6y8UenbEyBDslxpSQAugmhZr9M0VaabyYoWNV2DjoO6K4KMOgetQS0iIeJ0veXhKUEHDLOQxWpqDRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP67vdjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2856DC32786;
	Thu,  1 Aug 2024 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472844;
	bh=98MKxWkflC3Po6dUAHRp0v+yDsjlrfI3AI8OMS1fWtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OP67vdjjlSlDPbbtiBIVwCj9atzzlXHRFCdqyBViFKNe1ZBp++WqPgTXOR6dbIJ1f
	 uiL0TJoDTtYCJ1LH4j+XKaWZRTEiRwD1t/T0uTXDaDOUGBAdqzA7NxVAQJ7PgW57zY
	 i63DxMUyA2PI+IwiiIXd3TYXx5iP2zogvI5lMQ59SeW25yH3cR0WxogRWy1m4/uGlh
	 vpecqG3Dl2iK9W9XGryCMgQoWE1W7CSC+pZmXvb/ccXcL/5cya+qWq7uHBODM6+YBb
	 qmtyQrxBRFiF9mZHmlpcnLWRxnNyj+BOjkWW6o5zZnOyFpzVSkbpxZPWkf4zPGFvK9
	 YRQpu1b6B4ZTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	guchun.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 02/14] drm/amdgpu: fix ucode out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:40:10 -0400
Message-ID: <20240801004037.3939932-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 8944acd0f9db33e17f387fdc75d33bb473d7936f ]

Clear warning that read ucode[] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 387f1cf1dc207..9e768ff392fec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -212,6 +212,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		struct amdgpu_firmware_info *ucode;
 
 		id = fw_type_convert(cgs_device, type);
+		if (id >= AMDGPU_UCODE_ID_MAXIMUM)
+			return -EINVAL;
+
 		ucode = &adev->firmware.ucode[id];
 		if (ucode->fw == NULL)
 			return -EINVAL;
-- 
2.43.0


