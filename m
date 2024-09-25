Return-Path: <stable+bounces-77322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B50985BC9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89D81C24935
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827701C5784;
	Wed, 25 Sep 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOL+Kae6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E73170A01;
	Wed, 25 Sep 2024 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265176; cv=none; b=NftXz62E3oCJh/F3WpikgM6ofijO8PqEV3/bIfj+FmldmEtsxTTYOm0qif79Ls2aQ+GbvhbkkdEemcO79t2mjHLiZnWYR/YOjMRYfvafj+NOshTtt/z6jEWfdUtjWDDP5EmZ6hwX0sSjSIk3eQ8U1CrmC+dIKrNtsDgEbrCUDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265176; c=relaxed/simple;
	bh=FHyjA7h00J//ss2wPPygMBEMnaJjWnwDsb2cofkS1UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj275sFqmjBTl9EHd1+gjPHEoJ3F2vLtABzLRkrNEdsvmOq6JluEmXRGOmfaEgV5HwjwLy3jXs7kmps4qQcj2JsOIDox2ifqDy4JHNn75Mr+Wf+TootXZZxhXnUBi2TidGrMR9sarH1STZ+2Vm7Z8dLiDEblyrnB7UfKlvdm3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOL+Kae6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2196C4CEC3;
	Wed, 25 Sep 2024 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265175;
	bh=FHyjA7h00J//ss2wPPygMBEMnaJjWnwDsb2cofkS1UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOL+Kae69+d3EYTLoB/Fj9bf5gWzK9oaFpum+a0YCBUf6lpBDEyvedy2lM6+J3fco
	 vDUwNf7p7ZU3BDkTF4icC9QQj7jp+XgujCP737BKijz9oe9Nr11POFjciKKA0R+9qE
	 msQeLbSG0FmGXLjYi5gf+IIylbd5T1qkmOTmYkYWzub4oeRVsDpoytvys7jj0ZfAzu
	 c5DwaPZCt08QnsPB9W9+anyN7rMr+g2X+eO8v0n2hAT0JHoPu/Ff1snn1Wt4/fUTKn
	 0uswBbFTmYthlcC2KaA6eciy81Qh515oIMo12Q/0VEOMh1hyHFv8Jp5uFDW8pTWBO1
	 70jNJHm5XqtTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	yifan1.zhang@amd.com,
	sunil.khatri@amd.com,
	Tim.Huang@amd.com,
	zhenguo.yin@amd.com,
	Jack.Xiao@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 224/244] drm/amdgpu/gfx11: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 07:27:25 -0400
Message-ID: <20240925113641.1297102-224-sashal@kernel.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 3f2d35c325534c1b7ac5072173f0dc7ca969dec2 ]

Protect the MMIO access with safe mode.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 228124b389541..b80b1b6f2eea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6008,7 +6008,9 @@ static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, regSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
-- 
2.43.0


