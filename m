Return-Path: <stable+bounces-77671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEBD985FBF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06481F2131F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6DA1B3B00;
	Wed, 25 Sep 2024 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqQRwdta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCA22997C;
	Wed, 25 Sep 2024 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266651; cv=none; b=Xd1oC9AnS7ihW1kW8G5+765wo9HAeuLhY3/ECpKiffIX5TqW6lv6BtCgE+fbKxA/MOKK3+m0b/EGwPicm6vz4l2tYnxYAFPUdnz4jfnmN6tyaQHMbnHHjWoynMp0Hc57x/+GdC3AI6QWdusiJjQErGXZ/pxkX1QuXWjjMuRs49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266651; c=relaxed/simple;
	bh=3uworH+Fy5wViEyD2XoSjiO38p5Ba0tD//i0S3nbEAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5o4ze1WD7exu3G9oUf7qrik5pbGli/H6g2PcQh7mSzA2gj2Iy4/o/gBSK1vxcU/KPt4Ct1FoYBQhFA+qY19paqn4RiEQP9Q3wyAXKBbHixbbhwSH0Jf8U4oUbpy+mQ1R7Vxls7h1G+GpU52o/iCLDlgUmz+YMLilru5u7vY5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqQRwdta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC02C4CEC3;
	Wed, 25 Sep 2024 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266651;
	bh=3uworH+Fy5wViEyD2XoSjiO38p5Ba0tD//i0S3nbEAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqQRwdtaYYs0Qy08hrGpBadZFvhITFUy/S9nX8sXqbsrm1B8anUQFwyGSfnjMXmqB
	 Cl6P2ZbKhRPIkjIJnwC3PuJx+rUF5Lx4s9cfWEgWAx4sbj3X5AqzIimIZYSc+KAIKz
	 RKmY3lwPhimYkwpJLw4t9mmcL7aVh4bA7ugB0n7SV/otJHL32wSOaz164/8bbsLHZw
	 U+lh6b3P8eEV0BplloFT4r6soe96vLa2Tiy4XtCcOx6q+enYTN5mdrbakYw3HP/jcv
	 bo2PByz7MV4laUgKo3h2uaayTYeovhab/52KNLn8XTVHBkQYWrmnuTdAxdLUcVvd/f
	 pS/89QgihvVoQ==
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
Subject: [PATCH AUTOSEL 6.6 123/139] drm/amdgpu/gfx9: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 08:09:03 -0400
Message-ID: <20240925121137.1307574-123-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 00e693c47f3cc..895060f6948f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5709,7 +5709,9 @@ static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
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


