Return-Path: <stable+bounces-127986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A4A7ADDD
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F06A18806DB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E28255222;
	Thu,  3 Apr 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxcSm+jI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30146262EEB;
	Thu,  3 Apr 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707682; cv=none; b=NpDTRM9icsT6Z/qhzuDPXaLGwIfQLwCqvRujvpqVNd5tarizAc+3OCQrPmL4ruI1DgamCiZH0ZRjWFSoCFv7YGZOoCAs8Bt3m5ZfYwDROfviTXfav2/sAFrbxu4wftW2zkcMMPD9UcqOcN1qxPAlQ3ye5t/m/WtP8cqCfcs7Ei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707682; c=relaxed/simple;
	bh=gy4JnBXx4PTmo+dmXKxVNJWbwi1sY36BSovfHvFqApw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgRsPeocTwOnq6i3LJ//66Oewt0ULHjAAy9JNupcVXUK35u4ZWzML+gOeS9/ruAOu5bX0zMncDEACmD40RKwBBu/jQnlecI60J1yQW18Q31CLcqjb5Ly83sCz5guLupbgWBbin9eN0ngRhR/rJ/aYkncJvfoz49dyMpIOyk/0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxcSm+jI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE75C4CEEB;
	Thu,  3 Apr 2025 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707681;
	bh=gy4JnBXx4PTmo+dmXKxVNJWbwi1sY36BSovfHvFqApw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxcSm+jIpIsWzAffAWnsjSuEmpCufcEZ6LAozmhfMKgZeyXAcWtIPcYHL4RwA/jry
	 PGR+vSZOnnn2E7kHNn8XYdipgutuyynT03bY6yh9a50mWAl8C+0XOVqR7J6yua9H0m
	 EKGISzd6sJ6d6VA0pIhA2EXFhDInT8VQ1MIwyNGOBlOuEFL0j6HWz22ovyCZFa0PU9
	 PKpd/W2myEmeyNEPDXqyJ+zbb0b5MirtcadEO0E0apKFuQjoEoySmM+giUyz2pE1Pc
	 4W7NgXDlwjD32NMWKFW1fO4crVZXMw2cvd6cM9dv5rwBqBAxXRqjJrGz/qetSi6QYH
	 z3NVL4nPdiZNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	boyuan.zhang@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 31/44] drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
Date: Thu,  3 Apr 2025 15:13:00 -0400
Message-Id: <20250403191313.2679091-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 1435e895d4fc967d64e9f5bf81e992ac32f5ac76 ]

Add error handling to propagate amdgpu_cgs_create_device() failures
to the caller. When amdgpu_cgs_create_device() fails, release hwmgr
and return -ENOMEM to prevent null pointer dereference.

[v1]->[v2]: Change error code from -EINVAL to -ENOMEM. Free hwmgr.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 686345f75f264..6cd327fecebbc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -51,6 +51,11 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
+	if (!hwmgr->device) {
+		kfree(hwmgr);
+		return -ENOMEM;
+	}
+
 	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
 	hwmgr->chip_id = adev->asic_type;
-- 
2.39.5


