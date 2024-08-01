Return-Path: <stable+bounces-65150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79596943F2A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0B41F22893
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBCD1E09B4;
	Thu,  1 Aug 2024 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWKdkQEu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13041E09A8;
	Thu,  1 Aug 2024 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472664; cv=none; b=dCHXWxR1NoTTs/sgRuzfqM+/0QqX/D4m4P/vT/3QfU6luLXLrhlLdHJtuZee4etXRqU5hufdm5whQipHOwu0uObQfrEmO2ru0skA+pMVoDhBtVIHbH4t4eh9ALrCnkTdIiSV77dGCveKPy0z13CEFzR+iqiFR+Q019p7CMEeSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472664; c=relaxed/simple;
	bh=7vuee0hX1tvccHycJ1qHdHIQFEvjn+IER4RlBpeh7Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stXpbTQZRUpdLb23MCgFbMrQB5DkI2h1nc0atA0foqZE2D+2nncG/dzVMXl8dzgAP5KrvHg56j/GEtKGv/2lHLO6KD3bNlKbjhDGgacbyYRSjOL8uW0DmeCvXse/mJhSPtfvPWBAh3b50nJWQloEdW6oRA0SAZdH8Vqu1R9MMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWKdkQEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0889CC4AF0C;
	Thu,  1 Aug 2024 00:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472663;
	bh=7vuee0hX1tvccHycJ1qHdHIQFEvjn+IER4RlBpeh7Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWKdkQEuz+OOo2QH7/4gp8aezxhsnkjh3c7C1azRt24p4h+YurmuhtQ3EQltQIYmR
	 XgFBFZb1Oq/vxQ94gWWwz7sUjK7tO43yzfr2cQN4u1xG8X4eHgkZL+LiycMxNbD5NC
	 fkd4oZLT+bsKCyas7cVRyudqhbm5cOzx90m9kUFUHWXPbrvamtG8pvtZ5F6ZBwZSTD
	 a/FdJsZWklRAXWN4Xxbkn/oy27hFsT7VaLvcSRlNXVuagjbX1WQ4nlHFDj/M847wHN
	 ZSUH+wwpE990O4JjJ5dbZjjy79pcDmFbONcki4XiBgFz5f6Az8GIXGYYMyRvabXZlT
	 agH5AXb6css0A==
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
Subject: [PATCH AUTOSEL 5.10 13/38] drm/amdgpu: fix ucode out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:35:19 -0400
Message-ID: <20240801003643.3938534-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 78ac6dbe70d84..854b218602574 100644
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


