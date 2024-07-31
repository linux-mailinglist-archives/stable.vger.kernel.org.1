Return-Path: <stable+bounces-64860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66442943AFB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BC41C2179D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FD155A3C;
	Thu,  1 Aug 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHGaHB5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46B13D8B0;
	Thu,  1 Aug 2024 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471158; cv=none; b=qLDOIMBIoMg+LmWsAbiKr7nxCsHNQwDmLKx79e2DKvNddDF463LiTZSHrTWJp32k/mY1niSl1FcmyZzJoO6gmLpBSrqfdPLaYNjJ2VksNVp7ngmlJs2J3WZPME1n7e0FEu8PQmNdgSEurbHMj7Ohv7pe4pSVE54GQyxz3ZibYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471158; c=relaxed/simple;
	bh=EhMJgJrj/2d2tPF75dRdU/U4NNPJAwOKjgeYWJT2DaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g74uNJmu98m2ug5oiwCR6cubrJxst7U1f9Mn8GKalKLhPkfNeDe/KEauseU1rveF10HFeVei4DnxqVgcKyYs5vnInuflK1mjXdRUkHrCsuwJ/8Eg5WCdiPkUPR5tQ7iOCWOiyeCqniTglFX20adHcpK1ZUFK+BdtVHOgIaD+rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHGaHB5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57380C4AF0F;
	Thu,  1 Aug 2024 00:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471157;
	bh=EhMJgJrj/2d2tPF75dRdU/U4NNPJAwOKjgeYWJT2DaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHGaHB5QwIRvxw23y3b/ojdT3jxa3QYHfvuSmYSBHKpEG/wzJb3/y48vZxr5D4sFI
	 J4jIzOYhBSU2NHsmkN0x1qZFpLpuN8Az4aMpVnUWXHenUsC6U8A7sD8bp0IjGDL9X5
	 Erx0Z8LIAvSaF5iMjtPie3CnkCI69txlTjxNzBEtnyVliJmRZVYbiXIwdNqR6Q3FA4
	 WdITXLhpyNsOCv7DjX4HsRnkN/uVRDIQrgrIR0kXw9jphsuSd3dZhsmT/3TACYgk+l
	 sh+LtMPQvlu9iT3TKGWt2v4cUModDZKZip2ED/k0iEmdOyDRGo5oG4UJ5ToFFMMNNW
	 rc1H1EqPvMr/Q==
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
	guchun.chen@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 035/121] drm/amdgpu: fix ucode out-of-bounds read warning
Date: Wed, 31 Jul 2024 19:59:33 -0400
Message-ID: <20240801000834.3930818-35-sashal@kernel.org>
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
index b8280be6225d9..c3d89088123db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -213,6 +213,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
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


