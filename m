Return-Path: <stable+bounces-77309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9B985BAA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52B1B26F7C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642961849D9;
	Wed, 25 Sep 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg8KXFze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0218593F;
	Wed, 25 Sep 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265125; cv=none; b=tUvE+LbwZtDKXmDaHWSI8PWwY/u7n8K37X2lLkfQkgLZi8RT2nBrbArPJW5WL0zahnl++zrjkuAP7ulAXf6U6p4aA5VsbUP3bTyjfcxH2ep9z6vPfsEYJH7z44trHDAGXU5LN3gy+G1Q2t+mOeYRoadD9sI2u9OxfIOOa8ebtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265125; c=relaxed/simple;
	bh=zeJ05WSEzl1ha+6OVUlE3XNTsKCVul+7ao4b/HAavX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwG1b7ta4hOvPGCZZ++w4IJzwz43hp7zHBuFM87d2rkKaRB0is9/E59q8P8N7dPa9Z/4Of1V6FoIHK/6Ldj9BPdoTUkXaOEdwHvSxBDz9AZX+pSaVlEqNXn8nuAs5SUNi1+9Se3WGai7U+FERhISNPdqoBrPcN53Fijw+ZHNL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg8KXFze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D557C4CEC7;
	Wed, 25 Sep 2024 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265124;
	bh=zeJ05WSEzl1ha+6OVUlE3XNTsKCVul+7ao4b/HAavX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cg8KXFzeLv6BLT0hLPlY8CAk09JwIJgIqYX3nl7hfJ+EP3ErOmW6lDoLYjIEguJ0M
	 VVvfg4LeFTIeU1XdWSxCxOyzgfNQwVQEv1n1rOYBsZOV66OdTB9eaw7Z/8pW4SgoR7
	 EhY7PN7dgB7TocTVa6OoaVegAajTa71ClKeU2wgP4vRNz2HR+6tP2yLdVFtzK+BI6V
	 O70ehpY8mF02eh1VlQsj/bOO52uIiyV26At/BXyZ2yPAYsCPakiC2W2p/etoEtkIKh
	 KFYxePnEjWSTXnNEV1T1gSiroLjGu3QQiQVE3KEhDPnUu2p/LTv3FhZ3jloI6KtvSq
	 Ia3rqpo45Y3Aw==
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
	yifan1.zhang@amd.com,
	Tim.Huang@amd.com,
	Jack.Xiao@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 211/244] drm/amdgpu: fix ptr check warning in gfx11 ip_dump
Date: Wed, 25 Sep 2024 07:27:12 -0400
Message-ID: <20240925113641.1297102-211-sashal@kernel.org>
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

[ Upstream commit bd15f805cdc503ac229a14f5fe21db12e6e7f84a ]

Change condition, if (ptr == NULL) to if (!ptr)
for a better format and fix the warning.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index dcef399074492..61e62d846900c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1484,7 +1484,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 	uint32_t inst;
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
@@ -1497,7 +1497,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 		adev->gfx.mec.num_queue_per_pipe;
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
@@ -1510,7 +1510,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 		adev->gfx.me.num_queue_per_pipe;
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
+	if (!ptr) {
 		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
 		adev->gfx.ip_dump_gfx_queues = NULL;
 	} else {
-- 
2.43.0


