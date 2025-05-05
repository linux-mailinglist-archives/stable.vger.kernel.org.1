Return-Path: <stable+bounces-141230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E59AAB199
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB29188A752
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470D4120DF;
	Tue,  6 May 2025 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo68soao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDB2D29D1;
	Mon,  5 May 2025 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485548; cv=none; b=UacSnVxPGXxtdsrXAJPATI7i23THCs2CfC8unANI5OawoYdTVuJz2v21wa2Bz0gsPEbjpPQOSaCofQ9yKEDLjdA0HB2YrmmUroTViy5rmReq9RJD3WLF5BTitLpoANuTAGzP3+7Z5lIeGr7hi6DAoQyaUeUKbV8EzP+TwYflWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485548; c=relaxed/simple;
	bh=oWGPC7/7Y2jTJLRveUSGLzf+umKCPcm32U+xNhZ4HhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+bcG5CfjtD+rx0Ek1jQLTSE9LGCLGmrpnpmRT7BuXiGL84rf60EisDU+4TyLXYkTHBctfim90W12n4K2F6CU2o2hwqX36spIPsNVfYqpFe42d6gN1vxveU35+JNG5+UC3Ko8LpCMQJe58TNyFbb/tJE6tg8UbJBJIntdukrCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo68soao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239E4C4CEE4;
	Mon,  5 May 2025 22:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485548;
	bh=oWGPC7/7Y2jTJLRveUSGLzf+umKCPcm32U+xNhZ4HhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fo68soao4zPcFaEm8+jfQ+2fkVw/WPvvpQtVVNxTm9gt2KfJtoFcR+8yGzddHkOXi
	 zQEsCvondrDLwuJch8ZbD0wZcZ3MdPxjO3G3Vf8CAki7VhM+B1I/GJ5LDny/35AhoL
	 GLaMaivOodVACXN3nZFkEV1hkjg5OILrClum+rkfqeIRdpv++3YkA41I1O1h1pQFmX
	 cDg+ewn5ehS22yu7Ptq6AOvNUvg3C4Tu8OqzQ2MLCNZYcGlBTf24r6/i1J/83Hd236
	 qBrycav0K/wAAy+abzS1ILSPYj2C5HDAqwirLgMgSuk2BXD9OjyKB4C3haGy42RddA
	 ZfhIudL5+nqNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	kevinyang.wang@amd.com,
	Jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 366/486] drm/amd/pm: Skip P2S load for SMU v13.0.12
Date: Mon,  5 May 2025 18:37:22 -0400
Message-Id: <20250505223922.2682012-366-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Asad Kamal <asad.kamal@amd.com>

[ Upstream commit 1fb85819d629676f1d53f40c3fffa25a33a881e4 ]

Skip P2S table load for SMU v13.0.12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 55ed6247eb61f..9ac694c4f1f7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -275,8 +275,9 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 	int var = (adev->pdev->device & 0xF);
 	char ucode_prefix[15];
 
-	/* No need to load P2S tables in IOV mode */
-	if (amdgpu_sriov_vf(adev))
+	/* No need to load P2S tables in IOV mode or for smu v13.0.12 */
+	if (amdgpu_sriov_vf(adev) ||
+	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)))
 		return 0;
 
 	if (!(adev->flags & AMD_IS_APU)) {
-- 
2.39.5


