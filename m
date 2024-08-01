Return-Path: <stable+bounces-64977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2315943D2C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C9E1C21B0A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EC41C2D6E;
	Thu,  1 Aug 2024 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO94J4Ug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044C1C2D65;
	Thu,  1 Aug 2024 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471824; cv=none; b=rliPQkrJeWYskuf73pChXpi0AR8K4tZS511hy1JVo+y+mSCUbSSWcfRbqrwwGfqL/fe6lVXQnegd5RoldHa4R8tvnkfRH1S1/TyKdR84RL6t1LD8sFfxuPve5kjmYcICLpMIvbU/fw9fjVmy9GwRyQy3DEgkp7S+jI8E8Mm2LD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471824; c=relaxed/simple;
	bh=PC3A9X0FTnF9C7DORI0L8z6V+PNhSju4nSquBPefFt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMdSV4qT+7chAMtvyYSRInG3EfDhaCSMmWpo9YLZx2MXDzdQiPqcDNFOWCsVsSvm45ABBO0INQx9W5ySu/dSJ6ELgZaPHkohHjhnySgmvd2jhBq5uGgUw9GiCwzhM4j1NJ9zhCDde30PVQIr3SJbN4doPbKBgp7g07fqe8UiHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO94J4Ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6962C32786;
	Thu,  1 Aug 2024 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471824;
	bh=PC3A9X0FTnF9C7DORI0L8z6V+PNhSju4nSquBPefFt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fO94J4UghT+N1qMNYs7SpeqgDdnGeMynFmmSsFaxtA1XvD0baJzvQ7P0VUSkCpxmQ
	 O6n0m43k1VIReib89FM96gQX9HIIzZEgBrqRpARq7raNQ556yofYrTT+nQvM4G7AQn
	 XLqRtvPeh55bO2BC9OFLW9H1ikYaGYP8cxNxu3ZH4w0t1uqL7eDC27406WQfPB1oay
	 +1L+P22rHFtgmvVcBmcgxyLeRdwjvowsPd/t4VY6F+IDeqkmu9pu+8E1iGnlF2mugk
	 ogRr+R3+hYYpFpneQFTCTq/9qUmQYM1yDk3XHE8s5NQwlWhqLR/BMkXeHrAxcJJ7uI
	 3dnWlJe35S1pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	asad.kamal@amd.com,
	James.Zhu@amd.com,
	rajneesh.bhardwaj@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 31/83] drm/amdgpu: Fix the warning division or modulo by zero
Date: Wed, 31 Jul 2024 20:17:46 -0400
Message-ID: <20240801002107.3934037-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 1a00f2ac82d6bc6689388c7edcd2a4bd82664f3c ]

Checks the partition mode and returns an error for an invalid mode.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 0284c9198a04a..6c6f9d9b5d897 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -500,6 +500,12 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 
 	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE) {
 		mode = __aqua_vanjaram_get_auto_mode(xcp_mgr);
+		if (mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) {
+			dev_err(adev->dev,
+				"Invalid config, no compatible compute partition mode found, available memory partitions: %d",
+				adev->gmc.num_mem_partitions);
+			return -EINVAL;
+		}
 	} else if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode)) {
 		dev_err(adev->dev,
 			"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",
-- 
2.43.0


