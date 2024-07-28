Return-Path: <stable+bounces-62153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971D93E626
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA381F21555
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B41F77114;
	Sun, 28 Jul 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6TaXEVG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A16F2F0;
	Sun, 28 Jul 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181395; cv=none; b=i0O7dRy6mMXT1YAPaOieTETFp5qsKqQAhIuNznTUsAKpIZ9pO8IisCRNLo9Po7T3mX3R13I4k80U8UHWjBYoYf1bePIbJiRYXV+o6Z+XWjC3kYAEsGE+kV9eSQbi1TLu7YIIstsSQT4rtGzWPN+WatFnuUTdwpNhmmtUbtE0N78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181395; c=relaxed/simple;
	bh=JABj1VJui9x8PYcBm1rzFpwv4RYcS2x/fBr0GFLpPQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5bnAZh1DMP1rz4r2fDtTnp0KH0wKg9bpvgvZ3UjCpuce4j8959qLQXt395nH8jhUCTpe4NufTjjDLuZ/Z8RPiMzg/x4aW8CBn3w2fNI3qqEV0dJTSpwIeVanWcPP8vhUWYZdGE3+0y8eu4xXAKKt9FvciL+9j8GnW3i3Hj9cGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6TaXEVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3621C32782;
	Sun, 28 Jul 2024 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181394;
	bh=JABj1VJui9x8PYcBm1rzFpwv4RYcS2x/fBr0GFLpPQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6TaXEVGzrGK4txGLZy/tUdaEe9ZdpuvKF8Z/qquOw0Aak8N11IsqBRkorORZGyLk
	 /vR4T192p931NHgCyqtW5MCnuX+eRLDJ07TufWtPkZkbTnjs7K5u7F7TbqPdv4htJD
	 xo0F6Urg50M8grYcD+CK9Rabq6yIetFK17mSWrM02i8Y4ULgPtTmRp4is9tSqNBjj7
	 s0wx3T82+AoyiaM6G/sJt92/ZNLIV31+dA3Uo6uVPekBRhXuw8S5pNu/ar1PD8BFzb
	 gn0znfVvV2EKSkr8sBb0bWJrTM01+ZLC9Bqim2SPckX5wiThX5fcm8yIO8PxoallXm
	 ElCrq4CeJa0HA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	tao.zhou1@amd.com,
	kevinyang.wang@amd.com,
	YiPeng.Chai@amd.com,
	Stanley.Yang@amd.com,
	candice.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 09/34] drm/amdgpu: Fix the null pointer dereference to ras_manager
Date: Sun, 28 Jul 2024 11:40:33 -0400
Message-ID: <20240728154230.2046786-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit 4c11d30c95576937c6c35e6f29884761f2dddb43 ]

Check ras_manager before using it

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1adc81a55734d..0c4ee06451e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2172,12 +2172,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
 int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 		struct ras_dispatch_if *info)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
-	struct ras_ih_data *data = &obj->ih_data;
+	struct ras_manager *obj;
+	struct ras_ih_data *data;
 
+	obj = amdgpu_ras_find_obj(adev, &info->head);
 	if (!obj)
 		return -EINVAL;
 
+	data = &obj->ih_data;
+
 	if (data->inuse == 0)
 		return 0;
 
-- 
2.43.0


