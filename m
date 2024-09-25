Return-Path: <stable+bounces-77648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C29985FBA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CF7B241ED
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA239225959;
	Wed, 25 Sep 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXjouGJL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E44225957;
	Wed, 25 Sep 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266577; cv=none; b=XVIDTEdtDVu1Uugdqc0q9jKuCaARQ/krYq/1b+xfKN41c3EZvlALBrBNFGBseET5Ch+9+wIIpj8wH6Hy3ipQ3H6FJmsCWv+m2kEatyNX8dvqYaDw5dwJx681pcoT8yp7YeQphH2wQRHqKUoZSo7E2aip6s2Ki+AwGmoRZ8kYf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266577; c=relaxed/simple;
	bh=QR3qXIAiA8bTXbySF8/3erA7jA6YWIXgBvAIy6m3HTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i16hvlkMpzFDhmDPM22Ipjl3/sDAHndmMSiP1UUOlk+EmhikklwpXiNnqNjOYUe6ztyVRkljlGfzAIcAmqIKRWYiEaGKSc0pI4zDTCC73T74eXeiqRPAlFn0kycpA+PqqC2mEm/E7hgRUcHLkEV+ZFSIDCwM85yig8gj03SKyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXjouGJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACBEC4CEC3;
	Wed, 25 Sep 2024 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266577;
	bh=QR3qXIAiA8bTXbySF8/3erA7jA6YWIXgBvAIy6m3HTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXjouGJLfH2oNTfFCmtzmI2cCRhyN6IPY90IaMlxDW8HS+GPEcqHYFWz1R7p3m3pG
	 fmIn/SwL2yPPXVpIR32gU0HwiDouTCeBnb7Zf7xIv+e2g4LxvqI6QcvGszO8q2/ChY
	 ahZe2y3SuknXLlNphDIiCs7TlMkmU7EwGrYiP9VI2qnHrEItQNyzr61RzXZwWPDcRJ
	 sAF/g+os0ftk/e6ttDQ65PVHxe4ibYxzi9Ph2l8RByKoLWmdtoNGOrvplFDe+E5PaS
	 yzeNUVXIpy5Ad+GL56yzaCnP+MqI0Vl3smFgIJchbNNTcCJLrgzkaKxKgz3mAqwW9V
	 5cMk8xAYh+fxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng01@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunil.khatri@amd.com,
	Prike.Liang@amd.com,
	Tim.Huang@amd.com,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 101/139] drm/amdgpu: add raven1 gfxoff quirk
Date: Wed, 25 Sep 2024 08:08:41 -0400
Message-ID: <20240925121137.1307574-101-sashal@kernel.org>
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

From: Peng Liu <liupeng01@kylinos.cn>

[ Upstream commit 0126c0ae11e8b52ecfde9d1b174ee2f32d6c3a5d ]

Fix screen corruption with openkylin.

Link: https://bbs.openkylin.top/t/topic/171497
Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 8168836a08d2e..c28e7ff6ede26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1172,6 +1172,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	/* https://bbs.openkylin.top/t/topic/171497 */
+	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.43.0


