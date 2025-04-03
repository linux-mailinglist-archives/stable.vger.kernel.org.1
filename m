Return-Path: <stable+bounces-128088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5050A7AF14
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A33B9CD0
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3652122DF85;
	Thu,  3 Apr 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpypAbuP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908422D795;
	Thu,  3 Apr 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707940; cv=none; b=PdBDgN9qqsdph1T/YSDKE+ZnUyqDiV/uf5mKrWiOORZPQnRQvd+CPt0Vcj/xsGGEpCwpmot3rNBUtNRsBTXJIz8/4/UKJI2W0iwySpUF7/bMWP44vs10zEDIKvy9ZFz1de4V+9xhlBfmmKl8FEU2CDYQNAtRsjCrs+yRsU3MfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707940; c=relaxed/simple;
	bh=qvy3tuoLOCZhXeuxIf6q4Awd/gqafDFYWMVWh6AfAMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TT328OfbMr/5hxI+OMY3TB9G9tneNwkihfeD+kXx1+A1xDEKBoPwfvkxkhmTWBmkY8139xg1MvL+a6kQC21PxGJYeOpWSSYjyYxMEQtJOYGDlcsduoswyUFf34dkNRc+pc2JZRw2thVqHIGTzwpQRNrLcp17bnR6cHZZ5iwRa5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpypAbuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B96EC4CEEB;
	Thu,  3 Apr 2025 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707939;
	bh=qvy3tuoLOCZhXeuxIf6q4Awd/gqafDFYWMVWh6AfAMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpypAbuPQPyZxD/hrxA7754fHKp1DWu6JZQEBR6X63638jKWIRCoY4fWB5MAnA1xY
	 JAkb77ifQheymtPkud/V1qu/yz5jtMoRHIDNMPKjLiWYRPldQuhBjK+YRroxmvSauO
	 4w/pJ0yqIB9XJX9ZkBS/MMgQe0iI54k29rx42dfcKuL8KbEm+vHfA88ZSBcAhULDx6
	 Z+j9ODkVIB4wB525WxtITc7FMWgDNyipKGWyKwSeLd+VvV+CdmqhDJh/gOJ2TVp5h0
	 pXtdrEDrZPfq/ZnaTWBs74xzRMRKr6/C4I+gU0pOsFacnjGL8CB9KzTKCY9PIQMh3J
	 NFR2V63uofN0w==
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
	Jun.Ma2@amd.com,
	boyuan.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 17/23] drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
Date: Thu,  3 Apr 2025 15:18:10 -0400
Message-Id: <20250403191816.2681439-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191816.2681439-1-sashal@kernel.org>
References: <20250403191816.2681439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 86f95a291d65f..bef6578ac4bfe 100644
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


