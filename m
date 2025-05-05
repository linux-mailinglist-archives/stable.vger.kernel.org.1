Return-Path: <stable+bounces-141237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17349AAB1BB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FFC1B6072D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052627CB29;
	Tue,  6 May 2025 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9c+zyfR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E212D3A6B;
	Mon,  5 May 2025 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485585; cv=none; b=Xa2Cp15bo/Jhh8C05fd1w/OqODG8MgnoKk7kPRSG8Y2Q4fnXDnnH9lRWnv02FV0U43oUy1rsO4gc6/Qrjtq06SwVY2Mibm3zXB47eSCqsHABbGhMgssdHeGhtNa2APRCnQnBowW/knfZs51AhAHav5zm5aeh4OmSMzAf2YyUQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485585; c=relaxed/simple;
	bh=zXaF4H0DlaWSM8LgDckcp1aSwKz4AvAeHUyzLWuCHc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sHEHG5kgw0d7i799UJiaFPoA9TFX6E2BIeNLu7BBCshWaBXMFKw6aWpcz9POs2EMI/XiL3hETw+6MybdJPnGABN7UTo4HCxTcN5T2YPnfMdAE4VKIpgA8KXTA6h1GBvDe/PSz5RXbqkPcaS1YcWGWgcuqUx76JqO+uOwHEh/jSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9c+zyfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45081C4CEEE;
	Mon,  5 May 2025 22:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485585;
	bh=zXaF4H0DlaWSM8LgDckcp1aSwKz4AvAeHUyzLWuCHc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9c+zyfRGz7ExxraaK8HVQmX299p2Uov393KO8Ypc0L4EclLY7a0hshjeb9j+kHZL
	 QGKFaXbAbkpcS2YpQNjNQBh6LCna8We8c9U573Ut0O1keEN7R6seex1fhoYKU7uBE6
	 pKyFDPYMd/uSe/7emIm9DBCubUPosSVvrOycsdDAmiDt22ibKr7sHNQqGNgFFOF9OJ
	 wVG4En4zCjg/jsmBrbDIWSD2WkF4anAmFCSVRrpGmYmP5VxvB/2aWpWSTN0+ANyXon
	 nA2jwJlw0uEA4jOBmY/A6k1ER38XB07xizjs0DI8avKPcCj5SNVV/88wD9ABITmNgz
	 AH9n2+pztpU5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiwu Zhang <shiwu.zhang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	sunil.khatri@amd.com,
	le.ma@amd.com,
	YiPeng.Chai@amd.com,
	gerry@linux.alibaba.com,
	candice.li@amd.com,
	Feifei.Xu@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 375/486] drm/amdgpu: enlarge the VBIOS binary size limit
Date: Mon,  5 May 2025 18:37:31 -0400
Message-Id: <20250505223922.2682012-375-sashal@kernel.org>
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

[ Upstream commit 667b96134c9e206aebe40985650bf478935cbe04 ]

Some chips have a larger VBIOS file so raise the size limit to support
the flashing tool.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 31a376f2742a2..48e30e5f83389 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -44,7 +44,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
+#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*16)
 
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
-- 
2.39.5


