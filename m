Return-Path: <stable+bounces-77529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81982985E1A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F891C2155F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0B1B6535;
	Wed, 25 Sep 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKWh6fwQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6731B653C;
	Wed, 25 Sep 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266129; cv=none; b=hgbevn0UFp4x8NJZckX8wr2cjR34GmT7GkPJyAbCplr12UAK3egVr4+nw3PVrXJsr9rzwRXcWhnW2oAWRRX36qObl2ukTi12TquCcSti590f4CkQoWfM18T8m4Ok8l3KMFeJXjtMKmXy1qm/7yLHF859JLyP0qQtmSHC6MmwUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266129; c=relaxed/simple;
	bh=LC8pAFstEtE61gtgjCCenRyq0lLhQld7aNIfNo1FJsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8fXEmeqszkv5mEuUtzY+VOBDDRmgSVynk8gsv7SbKdqWqGpdKMayuzxqpk60clPYtmTKyIQyc7x2qRxVLpz+dKnbe5Gyl9+sGurFjcg4jEMpsAlgEeatAp+pHxFbxPjzHWuluqb8ie5LL+fbbU048As3LJayrkl4Nl3O44U+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKWh6fwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6880AC4CEC3;
	Wed, 25 Sep 2024 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266129;
	bh=LC8pAFstEtE61gtgjCCenRyq0lLhQld7aNIfNo1FJsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKWh6fwQmWKdOZPeYn8th/oy/7V6qDQRPlB/0LC2uo152HzFRfQnkOXyC11qxgz34
	 6W6VX7/5Zc2upFBjjTd4Z8vy0ZBb6HH0tq2IthgFzbz9VIi7gdyANsYH/OhgjpoUnV
	 41HkzcKZyg3gYFydoxP2H2PsaYcU/JH1khSSspIrUB6x1iaCbWV5TglI4cctoESDOp
	 klOnSelxo6rJFrNQ/yQdkdMforeSexMsuGe0UVoIuyAjiisrh+GlWTH8aPXI+J0E8e
	 9caFFJxwAAw6P5Aji1Y8OeqJbGs3YB9k7pcOWtd81RzN8hLSHIoD1+4fJKs6g58+ef
	 04ggHTmIdYjvA==
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
	sunil.khatri@amd.com,
	zhenguo.yin@amd.com,
	kevinyang.wang@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 181/197] drm/amdgpu/gfx10: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 07:53:20 -0400
Message-ID: <20240925115823.1303019-181-sashal@kernel.org>
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

[ Upstream commit ead60e9c4e29c8574cae1be4fe3af1d9a978fb0f ]

Protect the MMIO access with safe mode.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 536287ddd2ec1..6204336750c6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8897,7 +8897,9 @@ static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
-- 
2.43.0


