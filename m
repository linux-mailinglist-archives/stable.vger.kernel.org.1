Return-Path: <stable+bounces-140213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE6AAA62D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202011642D9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6023211AD;
	Mon,  5 May 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V31yJiRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6ED321191;
	Mon,  5 May 2025 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484364; cv=none; b=iEwKKj5Mz6wUxrJsMMN/afAvdEO5KmvP49IGMCN1/6fhwbopRgyBT9ddd1j1CT8hKJCVZqgHn7aa1Qi5sZ+YqCFWyGClsR1ziZPat2RD8i3oV86h3Bj1SeHeW0TsRPierzihshz7hQMUnpbXMtZ9qmnRBpFwIG/vKGzm4JToXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484364; c=relaxed/simple;
	bh=am3K3pkTtZNAXymooUv/C/WzV2jM/xN9MVKfp93cxuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sH5ROXSGfmayfs4EZvn5THzFBCawKqAcHRJds6YEU5w+XcGKdKOxQtM7O21tVWolv3w2UvwlBfi/CaH2S2KqxBBb7xHmrLW6+Cm70116yrfRdvQjIG9ESKGTmJjIjhX+TeHlU1AcvrBkzXRJB3WM2XxBfyFgMsiq2IENJF9uBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V31yJiRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C497C4CEE4;
	Mon,  5 May 2025 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484363;
	bh=am3K3pkTtZNAXymooUv/C/WzV2jM/xN9MVKfp93cxuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V31yJiRvNM4cI7yBRIiRMH2cGcHc+d7Nrxto84wBm77kBXTEKeEWIUbgjwA+dY4RQ
	 +/KBA5ut/uq955tcaE6fQn72w54RnANW7RUzjUTOWyLR52OVrers16HtWshrcrXtZG
	 w0jip/+EARvVvjT2gxUnWK74dTnrNFs0ZI3wDn1IbMf2twr/eXsURNyGuAaNV2wbZm
	 QKT8KUpTMgljkpI0sVGh6HQOKGWLms+hi5OIuHHiS9LolZdyjS71NXjlRPFHKPgflS
	 R7Qqmx35Dbk/A/M/cmIYEtSs4U0E6qycSphv4R7trNURx+wDVu5QJijnY8TyB10hZS
	 txf8ZAuqFRJGg==
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
Subject: [PATCH AUTOSEL 6.14 465/642] drm/amd/pm: Skip P2S load for SMU v13.0.12
Date: Mon,  5 May 2025 18:11:21 -0400
Message-Id: <20250505221419.2672473-465-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index da7bd9227afeb..5f2a824918e3b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -450,8 +450,9 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
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


