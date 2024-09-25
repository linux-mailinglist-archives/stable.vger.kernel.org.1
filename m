Return-Path: <stable+bounces-77307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B254985BA6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2011C23A41
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146FC19CC06;
	Wed, 25 Sep 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWN+jicr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4919CC01;
	Wed, 25 Sep 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265116; cv=none; b=QV7MUIawhFts1KG9DctA2+XfSYzmHf6oG3IO1XY5TzsOOhfAA1UAeTxvzRhxEGJwcpwGwREz2ddo+wEkGfnuLQZMs6HaklMHr7B1OJO6Uyp7ZWZfSRR0BoVYZRRS9ytxfjbUna+x0CuuWaSVw4voaWRK5H7CUbJsaeyKkfPBAE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265116; c=relaxed/simple;
	bh=ntd3Vca1hW/4kpwUxZ/lZ6Q9Nk7kOo/IuegIR/xbjN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur7Kq01dSLe/wZB6J8W1B0R2PCtJWXu3L89HL40mTmXB6gG4FPzLFKw33pjaGu9Ik9niZg5oFN82QRPF15KqpkJqSjkH696KsTUhXAMrx+s0uuXM6JsRhcVyNUZ6Fr5OQIS76AwLW8n6hdZuxFxpkQGzzCNL9vPQ07cMIKtqakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWN+jicr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE814C4CEC3;
	Wed, 25 Sep 2024 11:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265116;
	bh=ntd3Vca1hW/4kpwUxZ/lZ6Q9Nk7kOo/IuegIR/xbjN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWN+jicr00gU82S1i19ew+TWpoamwb815JlfKQTlabid6ljZvA0l/18xXkkcxueU5
	 XhmBw+RMeKCNHzxj/TBEtQUQhCgxWHKe5yw806/iX9bcW0hBZ3j/JkAhp6iQqZhAZx
	 fbV1DJT1zTnGDnNIMD7T1bvVxWk/6ICNEwE7n0gxyHbIthsfFz2VuMzYiMjrM6J6B0
	 WdRdlrF67OpV6YtEDa7C6h8GbJyoe8BGRE4PxWVrJBV6TXK4xQAuWlOtRtFbOXIW2n
	 7eyc69nfPPJ58YqkT9pCqDLrxFRCZXISDAimv4ipvOOJtQzd8iP7tueMDc6P/3HTr1
	 UKDtLIKVdsh/Q==
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
	Prike.Liang@amd.com,
	Tim.Huang@amd.com,
	liupeng01@kylinos.cn,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 209/244] drm/amdgpu: fix ptr check warning in gfx9 ip_dump
Date: Wed, 25 Sep 2024 07:27:10 -0400
Message-ID: <20240925113641.1297102-209-sashal@kernel.org>
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

[ Upstream commit 07f4f9c00ec545dfa6251a44a09d2c48a76e7ee5 ]

Change if (ptr == NULL) to if (!ptr) for a better
format and fix the warning.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7d517c94c3efb..6f178bfb8f104 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2133,7 +2133,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 	uint32_t inst;
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
@@ -2146,7 +2146,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 		adev->gfx.mec.num_queue_per_pipe;
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
-- 
2.43.0


