Return-Path: <stable+bounces-77311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D689985BAE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0B286F1F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5C1C2DAB;
	Wed, 25 Sep 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/zDWA2z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D919DFB5;
	Wed, 25 Sep 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265133; cv=none; b=qbGNJCgIjXG6XVDZTmBBb2RD5ZuOmxe5fQL3B9aIyRZemcS9AFZSiPGeoE6frzVpuE+vfV8t9rvDUQ95YGmj/b5bqH+MgWcIdQCT1tuDnNWyLHrCzI7BM1uMemcLbtUhrhsDFkveJSKM+CwtOqzd5Dl/GTOMQbQ23GCivIB7ov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265133; c=relaxed/simple;
	bh=eGAtNThMt+M3dIs2VGc02AhDgC+LbEGR7NXPlsCiavU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDIJ8fg0xHUbLab2le93MwJNMGpyzfQyIb4ucCIvUu0A9sV9JtYB8HVXMgs+uVzME1gyBRBc75tYwhUCORcuP/8bhBkL8boCm1/6LS7PxdHkn1q9U0lKCXZFWZRChowlnH3CgaXkOzZm0T+SlH+tWet1s5L5eAAy3SAk7Bx93Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/zDWA2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE437C4CEC3;
	Wed, 25 Sep 2024 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265133;
	bh=eGAtNThMt+M3dIs2VGc02AhDgC+LbEGR7NXPlsCiavU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/zDWA2z04RoqsEeSiX81JhRWYhlKPZZUFuykJvq5wIGMd/X1DcMKsdFif+lIg5mx
	 Rqzvekn8K1cV1ARi6/EgEYRvweCJc6NvyEOJKSQHiLs2ayVZbyIXgLJvWxjXR//fdQ
	 lITiPnqnwXAhkhOfNRSuY7tj4rWRrD7zA9JB0MxCdirJg9ScHx9mboFS3FxBzN3Vdv
	 L9E0A9icyhLpjZp6wL/mBv2shQk4XAxOTArPwR1X1uIZzTAsocOb/9bG4nW83Hjrz8
	 1kWwg3eBhhLK7YBsFsa7RodrJwrMf7f9Guu626ks1vaWs/LUpTZDRVG38hoBmR1AW3
	 5khrF06ejfIWA==
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
	Prike.Liang@amd.com,
	liupeng01@kylinos.cn,
	Tim.Huang@amd.com,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 213/244] drm/amdgpu/gfx9: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 07:27:14 -0400
Message-ID: <20240925113641.1297102-213-sashal@kernel.org>
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

[ Upstream commit 3ec2ad7c34c412bd9264cd1ff235d0812be90e82 ]

Protect the MMIO access with safe mode.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6f178bfb8f104..02eb5bd9d7d82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5862,7 +5862,9 @@ static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
-- 
2.43.0


