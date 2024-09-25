Return-Path: <stable+bounces-77308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE61985BA8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810F528701E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC6D19CD16;
	Wed, 25 Sep 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diENaWK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1519CD02;
	Wed, 25 Sep 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265121; cv=none; b=RWRBjqDckZ/XcZU/+g8NyzlzFrmCYtmYUqARf9g34B+SekrRM0bce+wcIzGaACJeASR5FPt734cKgmXe0vm3RLmLiD2U3p5tiN0S/t39XE5oojBJZYAZPv5PdYNvk6Pyb3x3/bNf5i4r2ru36cj2I3Ql9NFMhmcvgB5PYSi1cm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265121; c=relaxed/simple;
	bh=VEKGLNJ/0uJz4z0kCY7jCs4S5UPkM3+KRP7c8hmRn1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRp7bYzAXcJl6jUkAF8llGDMg4U37yQNLt9rD1yH6u8w6LXS5VM/aaO+sXtd3j1C2ki32sj7550/ziyVMHay4OBOWSSDxupakFqEXrOgRyTtYJyqT/0WwKaVWPH+4NZI6Aw8H8VcrBJNMS2IClcI1qqGuumejlCXiCU7ZjeUno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diENaWK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04827C4CEC3;
	Wed, 25 Sep 2024 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265120;
	bh=VEKGLNJ/0uJz4z0kCY7jCs4S5UPkM3+KRP7c8hmRn1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diENaWK1m2EahLhgyIqg4BaO25dB5RluQ7nGpTHXraRRHB9rtG0vn6UT2ZhXZ1mr6
	 tUzEPCRAR/e9p7+xLqHU1SWC36ZpPc3ceEM+9/KKccImYCGEIcNcwcJuBlHP54paVr
	 AL6NUjAs+P3waLSZHm1ud8qgFQtFVGglzxhHWY4pzSI4vxzM1rAY3OAIf3p8Fmt6aw
	 ckLZQCKTvfmNbxbvZIufKXeVF0+djzhiT0xbLVqD1HrF//4fB9E9mC2eIRkNrKUxA/
	 IeB8OGLCnhT0yxqiVGIvGjlH9ZbyrZAMX4Np9Cn+vmj39EV2g6Xkq5oJqlGw0Iwj8F
	 pkVXq9NFv2UEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sunil Khatri <sunil.khatri@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	zhenguo.yin@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 210/244] drm/amdgpu: fix ptr check warning in gfx10 ip_dump
Date: Wed, 25 Sep 2024 07:27:11 -0400
Message-ID: <20240925113641.1297102-210-sashal@kernel.org>
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

From: Sunil Khatri <sunil.khatri@amd.com>

[ Upstream commit 98df5a7732e3b78bf8824d2938a8865a45cfc113 ]

Change condition, if (ptr == NULL) to if (!ptr)
for a better format and fix the warning.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e444e621ddaa0..5b41c6a44068c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4649,7 +4649,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 	uint32_t inst;
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
@@ -4662,7 +4662,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 		adev->gfx.mec.num_queue_per_pipe;
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
@@ -4675,7 +4675,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 		adev->gfx.me.num_queue_per_pipe;
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
 		adev->gfx.ip_dump_gfx_queues = NULL;
 	} else {
-- 
2.43.0


