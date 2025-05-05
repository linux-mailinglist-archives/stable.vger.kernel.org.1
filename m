Return-Path: <stable+bounces-140884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D6AAAC2A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4783B168121
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45733C2747;
	Mon,  5 May 2025 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9cqElo+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1A2F15EE;
	Mon,  5 May 2025 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486727; cv=none; b=t1Ze0OcnL+aKBNvQ58ZjO5vCjOc5lf2O0dnudsg1ZRoff+k6Um2cVpHYCuYTtAnP+4cYpNlWCP3+WoArgk245HAhbdOs0weFOm0spjswru47PoxkmXAXulyJd1gjjLPIks4aDT0IA8lZ6ZLdJOoSMMCc/jOPOMESyMlEbSa6O+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486727; c=relaxed/simple;
	bh=KIxa7bKrdNc9vhKHrc8LdMUtM53Ut/YsRCoVGbdw118=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5BzD7BY3V/95IKXTdcP6WAgH0VB8h/eOSV3OwyeAvtRp4EgeZsRKuvzyyBfgeNTavNhbu5ahxxohKxiLYVcI9TFF4Rlt1ls4WuLRO3d7lR3VT+YayFm3G+Zm0vHzItBoLRC/Qz+NwDLqsS4FbmFi4t+lfpLSOG3fRLYAoEZLkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9cqElo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF5BC4CEEE;
	Mon,  5 May 2025 23:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486727;
	bh=KIxa7bKrdNc9vhKHrc8LdMUtM53Ut/YsRCoVGbdw118=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9cqElo+x3wcTnt4Hu/lL5js5u/R7Tge8aXQQ2+XtTDnvAdVXgn3dlgvX9cFtcRTu
	 f2oa2BxL5gnyIwRdLhvz/aKcAoAIsz1gqNb7j7r4YShwhZTsNuCGOkaOpzNnjTkrrh
	 i+vc68GUdgVELQ2/NEs2brZ5r/tM12tgjlfZgAdo0aml9vjUjSdQfbAA5nMgFkWfdG
	 voe0QIWVRVkEJ+csHmxpEgBB9pNzt0fL9e/zJQUW/jnypGVHKkTlUHSPMPKPNArKGL
	 8nO+2XkDWB5/EddQ/F/vFgCMA+PShffooJrDwuw5t++7MrA3HCnldprh3ty+GK92yp
	 2mCojyPIux1Qw==
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
Subject: [PATCH AUTOSEL 6.1 172/212] drm/amdgpu: enlarge the VBIOS binary size limit
Date: Mon,  5 May 2025 19:05:44 -0400
Message-Id: <20250505230624.2692522-172-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index a176b1da03bd3..ae6643c8ade6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -43,7 +43,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
+#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*16)
 
 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
-- 
2.39.5


