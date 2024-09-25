Return-Path: <stable+bounces-77312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388DD985BB0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F001C240A6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE9319EEC9;
	Wed, 25 Sep 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+nw9TSv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4B184101;
	Wed, 25 Sep 2024 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265139; cv=none; b=AuiOhYa0V8SC9sL2napsZrsewjKzmU+nHh13sRE2JMuIAzXmVy5B7z2/BGqIWJy2VDhNPmd8zUkm+8NMUB1Q3orZ4I2eQGLv/qwD1Y3Op8Yurx3pTgrTsgWvPmE9X+muLGSobbr6jOB2cyZSgj8AsnUocaGOT7rw1RM7gW34EGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265139; c=relaxed/simple;
	bh=QUJl8+QxVVEFChsF4M2i+QQOHusoscWVS4IFxvOB8SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3v+eChvIgFfwcco4m68rZc2+rfB+6Zn1+L5cMLIltlgo48ahO3j+ABrdETTAg6jRcFDJ6zwycC/LCfkEjMcdHDglS65sGzXkfDnukt9Fx9rd7bxe8WwtksUapE9i5iMUV824aBXSb7+2/kovwC3SRrKi0e8vGETkp2TXKDblrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+nw9TSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90714C4CEC3;
	Wed, 25 Sep 2024 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265137;
	bh=QUJl8+QxVVEFChsF4M2i+QQOHusoscWVS4IFxvOB8SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+nw9TSvvh4uMG+JIBlVxPiUo0UlqQ0ZnCqpvfvMRAB1kuzv8cXVm330eMbH0jxpO
	 7EOcYdcLMcGeLGFwxBtBXatU9Z/9FYmKMvcvJZCuw5eUWHJucBzxZP/6/G55LRDjgs
	 zZhnMzv0cD6geuUfbI8SUAL7mcNoWoz+UpoJrml+jYJTyxIrtzPtQel3KWSwIvPelN
	 obYKC70H7Qn4YaIyvjXt8AhCsz9f9RShoWHZqBlONsbTNjXXciO+hTcp3cbzYzkCHs
	 bfLVeHWnGhszNEU4ViE8wrjQU51XpNTcdqqEchW5Q64MJCYoj+KHtbRqRaCjJxShzJ
	 hb2c6HySfe6Xg==
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
	Jack.Xiao@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 214/244] drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
Date: Wed, 25 Sep 2024 07:27:15 -0400
Message-ID: <20240925113641.1297102-214-sashal@kernel.org>
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

[ Upstream commit b5be054c585110b2c5c1b180136800e8c41c7bb4 ]

Need to enter safe mode before touching GC MMIO.

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 61e62d846900c..228124b389541 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4707,6 +4707,8 @@ static int gfx_v11_0_soft_reset(void *handle)
 	int r, i, j, k;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	gfx_v11_0_set_safe_mode(adev, 0);
+
 	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CMP_BUSY_INT_ENABLE, 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CNTX_BUSY_INT_ENABLE, 0);
@@ -4714,8 +4716,6 @@ static int gfx_v11_0_soft_reset(void *handle)
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 0);
 	WREG32_SOC15(GC, 0, regCP_INT_CNTL, tmp);
 
-	gfx_v11_0_set_safe_mode(adev, 0);
-
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-- 
2.43.0


