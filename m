Return-Path: <stable+bounces-77675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BD985FC8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C011F21704
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384DF22AA6B;
	Wed, 25 Sep 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="equsjt1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4D22AA68;
	Wed, 25 Sep 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266667; cv=none; b=blmPMcEdBTfz1Pa1NPn7ErTjO6REI1LDKqpuXn7M5l6BVXnWKzu9ELSxgFkhriBIr0Etoeo61QBpbkvWxmPeZrAGie/aWvIhJuv7mjv5/EWErvzvfz55FtYd84AWB/uznNXrpkY6QFkBDkf6V0VhGDHdYl5repgocARPblXWABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266667; c=relaxed/simple;
	bh=OFYyYeZikU7Ju0NLcy2mgTpIR3Amgsd5Ywv3s3wh6CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMRg38VbJY3QDsbv0gnmTfcEvO7NDSpOn7GBaJH58npGDoi/0bQCz2JKJsZg+Phew2t9vNTQ22rerRUUNygCoNn+y5+AzO3NGwEZaI98HC3AgfKLNmItEOXBXb/+oT2IMg/y0UgsHgqZt5JkDF36S7J6qloEuLhd3LeaUJQzdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=equsjt1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67956C4CEC3;
	Wed, 25 Sep 2024 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266666;
	bh=OFYyYeZikU7Ju0NLcy2mgTpIR3Amgsd5Ywv3s3wh6CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=equsjt1RHqDgJUake0v6T8BZoMCymiD5lWFBBNkiBE00ay95TLpe1CYRjbqMWY8bQ
	 uP7+IkvKoCStfWOfziB2N4NeaWUT2//ijoGjszmSAwoRHxaTDWxoea6JcgeuDsgOmv
	 iUP6KlVdq0YnUlz9mDQBf3fJxAz/uajsW+YhBL1VSLq4JBdM+99eYLm3e2oLMtG+zO
	 1gcs6cjXzijz5x4Hcq0XxM9XwLD6AZbcVVkVv2v2ziIOapwhZU1aCI2z+qKiKzDfyP
	 YA2TlJjg/Q0EoGfORIkMAgeFmhYpA5uaTh6qV7K8Kn/423mKDUsQTTyFBjhuX180nL
	 57Ln9MbQrFUpA==
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
	yifan1.zhang@amd.com,
	Tim.Huang@amd.com,
	zhenguo.yin@amd.com,
	Jack.Xiao@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 127/139] drm/amdgpu/gfx11: use rlc safe mode for soft recovery
Date: Wed, 25 Sep 2024 08:09:07 -0400
Message-ID: <20240925121137.1307574-127-sashal@kernel.org>
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

[ Upstream commit 3f2d35c325534c1b7ac5072173f0dc7ca969dec2 ]

Protect the MMIO access with safe mode.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c813cd7b015e1..54ec9b32562c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5701,7 +5701,9 @@ static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
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


