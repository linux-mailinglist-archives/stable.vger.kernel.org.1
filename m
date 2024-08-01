Return-Path: <stable+bounces-64971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7116F943D1D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25091C22235
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D43DABF9;
	Thu,  1 Aug 2024 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf2+ExNz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB233DABE9;
	Thu,  1 Aug 2024 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471802; cv=none; b=EBI097f2lKDJ3rZk2ZXyUzrMjtjT8+PlsGt18I0y+Cp4/1WybR54oo/RWMfBIam2dIMloV0WxARsaXJOFL49kCDifDevYu8si/R+lkIttqCPnHNeykW0OIK9u8YYynu9MC8pL2sYDjj2SQGucBEuMFJ3AQX9Alg1glSIiu+wYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471802; c=relaxed/simple;
	bh=EhMJgJrj/2d2tPF75dRdU/U4NNPJAwOKjgeYWJT2DaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFW9WDYgu1V4mvqpuT3GRQB43DwEabSD/qCtNXP+5jO4IrIP/U6uk7ZocC3gbDto637Ev5P4WMEh4G3p5CSHhHZPPO+2dLwSDwh1iHkVYwnO1W0KP04d7hGOt7gbG9sJhaLbAKv4+T42p9bxkFuAPbXioZ+H/zL1gtVDP7TzRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf2+ExNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35BAC116B1;
	Thu,  1 Aug 2024 00:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471802;
	bh=EhMJgJrj/2d2tPF75dRdU/U4NNPJAwOKjgeYWJT2DaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cf2+ExNzLC/UdvmaKBQCNsrGkFfgsLLMXU8oxFXk9BEPkJmYrM1YLRy8mCkgIS8A0
	 vZwXKfEUgZPctOCc8tJ6mFBZ2T3Pmz+33Q9069dbd1C5MT1BeVJY655p2MfMfMh0bk
	 xZYZD/TcyTa0C6L3ktFw5su2b48Qxwk/JweQwp/sa7XmhedHqtSySpCdJ6gwenKgz4
	 QLqUj9I3Nb12xHAtJamFOeV3IaZvBVi7pbSTgWujG8JIU0xbrxqQPTthSMOkvfogCq
	 7+ljWC6D4pw7nLzsfwD3CSDKDN3v1KPyYkfw3MehoMKgFYKfIxejayzRbFIl+acQwA
	 6C6SSJTCsxAyg==
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
Subject: [PATCH AUTOSEL 6.6 25/83] drm/amdgpu: fix ucode out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:17:40 -0400
Message-ID: <20240801002107.3934037-25-sashal@kernel.org>
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


