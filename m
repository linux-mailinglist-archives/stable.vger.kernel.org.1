Return-Path: <stable+bounces-65106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1EB943EA0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED35C1F2260B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3942B1D9157;
	Thu,  1 Aug 2024 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnEVXCUc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EC1D9154;
	Thu,  1 Aug 2024 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472451; cv=none; b=Ts+Ofh2/n+UyXk0WNEueOTIwLpBX1+6OvlOTbUgpMcsyXxRrTErUnI3TXtxvc16WG63wf1Ac+PVhJFHJ3m++sVUYHcLyvm0CzkP1IVIBkO0pCDzxocht+yy/kQrKxnpz7RhueIq26tVUWL5oJ5Jq1lU5rLoYQXo6WouFPLqm6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472451; c=relaxed/simple;
	bh=H9DwXDIaGWACfzvn9LOU8qIZUZNbaRFqtoQigqpipv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWvtg8MJwnKU5wcR4C2JfADnN5A7gL/o12LC7H3Knl/B1G8fNvPqU2UNlvMFEiEigFpgjoiPfglQxglxAhMNzA2lkyBEQCfbwDi/cLXirS9B7vYUqtKl8hLSDan0OEyDl4W204le8ZmSVhg/NmQ7PriuL33UVphTijSc3Fgy5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnEVXCUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F10BC32786;
	Thu,  1 Aug 2024 00:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472450;
	bh=H9DwXDIaGWACfzvn9LOU8qIZUZNbaRFqtoQigqpipv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GnEVXCUcieF+aWqfmnSeRf+ecdb3zGK8Twmm1CLDtJHDLM7WFj8mtBKd8f6CFYEmo
	 bDIlWA7iMsgoXpGt+stsDY0Oif58pJ2Ndr/zA0Ttl04NU0vyuJnnoEb1JatgRzKtBE
	 u+Df/U7prSF50PPl6zbn/3AuxsD1foMzBRSU9i9UY06dQfBdy1bpOdpQV43JZSbmhC
	 1J4XqpnmRGQYG5c0F+8O506TaZlmwsMFJ2YOngj3j1yRc7ex+rEQ+eOuM3QGJPTLgW
	 +2eFNExNZVK6jzIlSuSbjwaB3toyLFF+X83mXOa92Q0DQARnIvtmY6HmWzXlmjVING
	 fMCjrgQmZ1OEw==
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
Subject: [PATCH AUTOSEL 5.15 16/47] drm/amdgpu: fix ucode out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:31:06 -0400
Message-ID: <20240801003256.3937416-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index f1a0503791905..682de88cf91f7 100644
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


