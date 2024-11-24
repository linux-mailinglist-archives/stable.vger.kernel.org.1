Return-Path: <stable+bounces-95188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4AC9D7405
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72A8281986
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913223790F;
	Sun, 24 Nov 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnhNo0IJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF823790B;
	Sun, 24 Nov 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456275; cv=none; b=M+JdIGVE4aMBcewb3nyE914bSnXMy2olsDXb9JSDjm7EnHjSWJf0a4vELGMF+sZMf382WXIqm9YrzWA9sI0QCJFA3RLa0MgCbcdyLe6yGoncSD6aopMkYihZUbAxS6JWhSMulrN2Y2l2UE8YLiSwEqeBmo8jSvdtYxssTmoOvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456275; c=relaxed/simple;
	bh=7173Sfum1638PYNZS2Fp2zqj1dCtajz82DzuU7SudRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWm+5KIjNjQ2zLjwsPalH1qQ21lYsTWy1hD4AIxVP7Uvr4pHpqqzqVRAOAqQo5psA9guZX7yjVwQfStAa/6UVmUcgyeqNo3A7RNoV6cltpBWOBZ6aapxbaEDoDSbyWnEPIKuUji5/EL5TpnN3M0MTN0LJ14R7M8KP4LexKPMrOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnhNo0IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1568C4CED1;
	Sun, 24 Nov 2024 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456275;
	bh=7173Sfum1638PYNZS2Fp2zqj1dCtajz82DzuU7SudRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnhNo0IJCY2opU95W7vYixa8GTUobW4lAPm7wiaeYh63OWjOPbGFL797QsCAZ9zed
	 onsB0LzgcNyVZYpFH121gI6iG4i57p9Q1dstoEqiYv9kW2LFqKQCj1/iQtkJeY7b4a
	 GM88eyWRG2sLBBxm42EuVHthKdJd1KIzZPOjNLZ8naBgbDgUhaYcjuYLrUusubrVxn
	 w3Eu2XSh6ACbL1l4t513kQKjo5pfchfNqNmHG0z1spdiXDclhdvukdf8Zznq1Q+EZU
	 K6SDPqdtnjQIKiMGbLUDO8TbCSPKiqbFkU4jW87lAb8MSTZRTxZBt1XRpuMxcVmvPY
	 ZKkLZZ2sHXsCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Zhao <Victor.Zhao@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	mario.limonciello@amd.com,
	Jun.Ma2@amd.com,
	Yunxiang.Li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 37/48] drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov
Date: Sun, 24 Nov 2024 08:49:00 -0500
Message-ID: <20241124134950.3348099-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Victor Zhao <Victor.Zhao@amd.com>

[ Upstream commit afe260df55ac280cd56306248cb6d8a6b0db095c ]

Under sriov, host driver will save and restore vf pci cfg space during
reset. And during device init, under sriov, pci_restore_state happens after
fullaccess released, and it can have race condition with mmio protection
enable from host side leading to missing interrupts.

So skip amdgpu_device_cache_pci_state for sriov.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1d0f6628f1d69..aca1a4e9b7ae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6013,6 +6013,9 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
 	r = pci_save_state(pdev);
 	if (!r) {
 		kfree(adev->pci_state);
-- 
2.43.0


