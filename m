Return-Path: <stable+bounces-77520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76C985E07
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFBA1F21F9E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770831B5EC1;
	Wed, 25 Sep 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4JIoIUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8A1B5EB7;
	Wed, 25 Sep 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266102; cv=none; b=s+Bdi/3pkiCPleMo8QmVyODVriDKnW0upr531lwuJYz2s0kw6HUtgyTf24Z5suzdi/jjPoDaoeTUig/q8gp0q/J9UJVPcN0Ueo6uSJacQmmw6ByhYzj6vrEbfSjLyIiMTtXk5bEmHjthpfHTBedaLITPhgwQcXEwUUX8woeW6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266102; c=relaxed/simple;
	bh=W+Zd2pV+nCWMmAUcvf/lr5FrxsX0rSz9ACQ+NIcKdRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JScdUjST4wZ+8Ki+CTt7YenX5eNwBIaSmutcOEalcf0olCL99RFP8K1zCU+pU1uUETMYQ6mZaEq/wfa37Ialy4u+esYQiL24Kc4fV7qj5OcZsg11vwU8udu+YJmMH1NiyPbRX7nvv69DNWJk7L18VHIYXxm9UNPfidOk1azMU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4JIoIUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D99C4CEC3;
	Wed, 25 Sep 2024 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266101;
	bh=W+Zd2pV+nCWMmAUcvf/lr5FrxsX0rSz9ACQ+NIcKdRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4JIoIUdPTAOCD0LUiRk78aOLPqE74GMIebBoxVsCbs8e3IFuiha6oHM4S7wk3J4V
	 4Cc+2n8zt5xV6zm/DX3Al8I7+KUKZIN2Uw4nDF0Z4h8Qm5SEBZyfIiR44RIst3Z2ZI
	 bVxBsZNSS2EUTf9oAsOAfEiGaYtfm8jdzpTaHxTCKfABitkchzMwrqR0dOhlAYTvoL
	 gr6fLxV9BILSJmPBdjELkY6GlkKgvFkxlNTbTqFUtS8UaQ/nGsVWdMpABbYiQjp4O8
	 qKkXPN28+nhDvYMxrYegoD3EnSdccsqLdBQjyh77oxPFcjBKq6mZgUlXRjYDdr0LIb
	 C6VC6Fw46Anig==
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
Subject: [PATCH AUTOSEL 6.10 172/197] drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
Date: Wed, 25 Sep 2024 07:53:11 -0400
Message-ID: <20240925115823.1303019-172-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit b5be054c585110b2c5c1b180136800e8c41c7bb4 ]

Need to enter safe mode before touching GC MMIO.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4ba8eb45ac174..0bcdcb2101577 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4497,6 +4497,8 @@ static int gfx_v11_0_soft_reset(void *handle)
 	int r, i, j, k;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	gfx_v11_0_set_safe_mode(adev, 0);
+
 	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CMP_BUSY_INT_ENABLE, 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CNTX_BUSY_INT_ENABLE, 0);
@@ -4504,8 +4506,6 @@ static int gfx_v11_0_soft_reset(void *handle)
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 0);
 	WREG32_SOC15(GC, 0, regCP_INT_CNTL, tmp);
 
-	gfx_v11_0_set_safe_mode(adev, 0);
-
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-- 
2.43.0


