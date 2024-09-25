Return-Path: <stable+bounces-77519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA5B985E3C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818A2B2E1EF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890A209E78;
	Wed, 25 Sep 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNHCetZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB890209E57;
	Wed, 25 Sep 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266097; cv=none; b=H4pq8KeZ4feKaBfx4N9gmOim6aStxfVWTyp9qM3mRCoOJW7LL1JbP9wtdmmY7iWcxY0laihJHALb8crCaPf7jg/FTAiHKM6ktgl5LmaJ+cWKRtQsl272IGUYEI+FYuON9mqAnkLbJxX9MV7Nxlaya3f1WwTCzRg1MvDyhCW7rMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266097; c=relaxed/simple;
	bh=kU3ZMttcK/39X/N8JZY871FZ/bEsSmPIC2cfgrCaHcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbesICBHfM6wEqP4GiPCy02Bt/j+IzSSuDzEptujK1/LfArsQGGRYHjAlpWub37xmG+hYNCCz+jjKO6CQxoIRHTWWQGOq7GGS2bRDM6rU8QrbxOmKsWc7ePsqBMzFQr3T70TNKTqphpYWZyRXzX9wZ+ZJcJHGnFlHpe968H6G7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNHCetZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDC0C4CEC3;
	Wed, 25 Sep 2024 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266097;
	bh=kU3ZMttcK/39X/N8JZY871FZ/bEsSmPIC2cfgrCaHcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNHCetZZj8aOC9vF28232vwW7YrfhSCR113XZ8pDURZzSvwSIKpe3Ge9TrddGoNR2
	 V6wgHVK6g0DYlikMA83Tu85OjKA6jWV4sv9U3eCTDVR7El63WKiz57Xbtu62LUtVjC
	 06fzsp4tIl2vYure/ppyBW5C0mrwGLQQc8ckVZNCu/DcBjCuR+AFckxLUI63U7Qu2S
	 qxLRVhh1TnQMzJfB8twQAoagJbC6oRrXE2Z5W0C/p21tRBQwtxNIO/beg1z8OhTqP7
	 WsPw1wVQQ1AC091zSRJH59TdfFTwXM1j3sqcTie94UGYQ/frvcmiFfC+UFYckT2RPD
	 j1akeYesqg5hQ==
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
Subject: [PATCH AUTOSEL 6.10 171/197] drm/amdgpu/gfx9: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 07:53:10 -0400
Message-ID: <20240925115823.1303019-171-sashal@kernel.org>
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

[ Upstream commit 3ec2ad7c34c412bd9264cd1ff235d0812be90e82 ]

Protect the MMIO access with safe mode.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b278453cad6d4..d8d3d2c93d8ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5701,7 +5701,9 @@ static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
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


