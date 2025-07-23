Return-Path: <stable+bounces-164503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E6B0FA7C
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 20:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2183A189124A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4A72206AA;
	Wed, 23 Jul 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGDtrfPc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D3204C1A
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296567; cv=none; b=uLrp6lqoItd4mOu6gvmOI1ze+x0pHURgenn/OByn1fLr3k2gO34o8+87db1oSNkOKojojaroN0u4ZLDwBYu8Qq2g6M/5pdhCfER6oKKC3wxEO/F/zo6imK3Lfni1dlMnOfPe+MzWOUZMukb4Olwjkfhj9IbG8tWD+id2A6yVtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296567; c=relaxed/simple;
	bh=/8rbsY7DFhBFVC6XpM+Xa9BomdJqcLwJtzrEBoOGjSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHfC1R8TC++SiSTDp80swRMfjVymRLgc40Sc2+zyj+eFmG1G/WkguyHjPCe6ubUTgUnLJmeHxEOYK9MEpKvD+pLmsr9H1X89usQ8Vm47mSdjhIbQ0vFboV9cC3gJtPGWyWg3qPjcWb84i7IbrJDgDppuyYDQpBk88/buyADLJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGDtrfPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D73C4CEE7;
	Wed, 23 Jul 2025 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753296566;
	bh=/8rbsY7DFhBFVC6XpM+Xa9BomdJqcLwJtzrEBoOGjSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGDtrfPc7Vpl8W5JjygCimhWB9+JUj4ZWkgmt71WbGtwi+byQL26HLAxgR3X/BmHW
	 zQdUiyXSHrkXHTzV1AT2/7uNx+Bnp2dMqxJHqikvF8wTdZkc+Czo2gkvQKC10w/D/l
	 8rSbVyGiIEF+NZ5Uz0mp9Iejtdp8Z4Hu1fT4ISpB/wWhpU7ZGsATs8/eXY4YnaDTQI
	 uJW4rAn/n15AuN2coGNwjuDm8AD0hOzz/Mt0h1/+uTyDJQznJkextTxXdkH+aUFLeh
	 VWSIZn7JB3wuEUR5MW3kcxnkBahldg2Y+z0z5pr22aF8WPpsVZEwBObyLJi1qB9kzn
	 AhDuIuHxIrKYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 1/3] drm/amdgpu: Add the new sdma function pointers for amdgpu_sdma.h
Date: Wed, 23 Jul 2025 14:42:40 -0400
Message-Id: <20250723184242.1098689-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025063022-wham-parachute-8574@gregkh>
References: <2025063022-wham-parachute-8574@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

[ Upstream commit 29891842154d7ebca97a94b0d5aaae94e560f61c ]

This patch introduces new function pointers in the amdgpu_sdma structure
to handle queue stop, start and soft reset operations. These will replace
the older callback mechanism.

The new functions are:
- stop_kernel_queue: Stops a specific SDMA queue
- start_kernel_queue: Starts/Restores a specific SDMA queue
- soft_reset_kernel_queue: Performs soft reset on a specific SDMA queue

v2: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Chritian)
v3: move stop_queue/start_queue to struct amdgpu_sdma_instance and rename them. (Alex)
v4: rework the ordering a bit (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 09b585592fa4 ("drm/amdgpu: Fix SDMA engine reset with logical instance ID")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 47d56fd0589fc..bf83d66462380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -50,6 +50,12 @@ enum amdgpu_sdma_irq {
 
 #define NUM_SDMA(x) hweight32(x)
 
+struct amdgpu_sdma_funcs {
+	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
+	int (*start_kernel_queue)(struct amdgpu_ring *ring);
+	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 instance_id);
+};
+
 struct amdgpu_sdma_instance {
 	/* SDMA firmware */
 	const struct firmware	*fw;
@@ -68,7 +74,7 @@ struct amdgpu_sdma_instance {
 	/* track guilty state of GFX and PAGE queues */
 	bool			gfx_guilty;
 	bool			page_guilty;
-
+	const struct amdgpu_sdma_funcs   *funcs;
 };
 
 enum amdgpu_sdma_ras_memory_id {
-- 
2.39.5


