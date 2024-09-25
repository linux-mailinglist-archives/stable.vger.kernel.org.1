Return-Path: <stable+bounces-77669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDEA985FBB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A5D1F2599B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF2B1D4353;
	Wed, 25 Sep 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoh6JVwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06D1A42AB;
	Wed, 25 Sep 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266643; cv=none; b=SEvpRheM1YroekQ+2hy+UWW+qIBQTXyy9f0rZSoXg97xSUBJFF3GWy5PBnU5rFZuQQjcI+TSRjPH2srl7a964drTEe3KJBeL1a3iMa1b7hGml0sePtMIu1PvAyju4JZ5Oc/qtkHydCgHTtQUxl4wE8hYfW1F60GbzbXThhRpu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266643; c=relaxed/simple;
	bh=zGmVvdjZI2OxMCY8uvpgnHQNqHm/txbyXC+4jCowR40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AA3BdAteHKAIVvTSQIzv+s8FEL3kziJtdGN8eOKyfdnqFtlaUrjVJLWjlBHS3aqrRB7As0PVSKZUeXRkJ7tCYbrOqRrFyeYnwFqKpoyRhtOYmgsqcYKA2jGWI3dN+y0uTp1fjZO0rjIQWHIXi6VGTZJnxE6iOzoTW5DdJSDLM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoh6JVwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE697C4CEC7;
	Wed, 25 Sep 2024 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266643;
	bh=zGmVvdjZI2OxMCY8uvpgnHQNqHm/txbyXC+4jCowR40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoh6JVwjHWXnKbCR9pJCG0uA8sGRAJYcbXpfgsvBdMql56rmDOSnRLIdo9INGvqa+
	 TV6EHHKGUhxBSz/3mxBhVv7SlJS40gENU+AncbDPuvmHjBnM4KKwtMfZ7icB3oz73a
	 jrSEe9n3ouklTVPPAX7XLF7F16jKQI75Z4pURhIfRR/iBGAThrsekeO6nR6tIj9yCi
	 OWUYew/+9vut/UInABG1HAe/2VPh7GMd5tguto5eq0ic/AoHwmUa59PXoCR6oz2vQb
	 TbDj6rn22nzr8tx3jLUo6Rw98ln6SdaEuOQkbjTOCcsPF9aG1BYlCPK+n/HA6nweUF
	 OZLwZNUE5UvbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 121/139] drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
Date: Wed, 25 Sep 2024 08:09:01 -0400
Message-ID: <20240925121137.1307574-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit c6dbab46324b1742b50dc2fb5c1fee2c28129439 ]

With -Werror:

    In function ‘r100_cp_init_microcode’,
	inlined from ‘r100_cp_init’ at drivers/gpu/drm/radeon/r100.c:1136:7:
    include/linux/printk.h:465:44: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
      465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
	  |                                            ^
    include/linux/printk.h:437:17: note: in definition of macro ‘printk_index_wrap’
      437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
	  |                 ^~~~~~~
    include/linux/printk.h:508:9: note: in expansion of macro ‘printk’
      508 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
	  |         ^~~~~~
    drivers/gpu/drm/radeon/r100.c:1062:17: note: in expansion of macro ‘pr_err’
     1062 |                 pr_err("radeon_cp: Failed to load firmware \"%s\"\n", fw_name);
	  |                 ^~~~~~

Fix this by converting the if/else if/... construct into a proper
switch() statement with a default to handle the error case.

As a bonus, the generated code is ca. 100 bytes smaller (with gcc 11.4.0
targeting arm32).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/r100.c | 70 ++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index cfeca2694d5f9..b63b6b4e9b281 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1015,45 +1015,65 @@ static int r100_cp_init_microcode(struct radeon_device *rdev)
 
 	DRM_DEBUG_KMS("\n");
 
-	if ((rdev->family == CHIP_R100) || (rdev->family == CHIP_RV100) ||
-	    (rdev->family == CHIP_RV200) || (rdev->family == CHIP_RS100) ||
-	    (rdev->family == CHIP_RS200)) {
+	switch (rdev->family) {
+	case CHIP_R100:
+	case CHIP_RV100:
+	case CHIP_RV200:
+	case CHIP_RS100:
+	case CHIP_RS200:
 		DRM_INFO("Loading R100 Microcode\n");
 		fw_name = FIRMWARE_R100;
-	} else if ((rdev->family == CHIP_R200) ||
-		   (rdev->family == CHIP_RV250) ||
-		   (rdev->family == CHIP_RV280) ||
-		   (rdev->family == CHIP_RS300)) {
+		break;
+
+	case CHIP_R200:
+	case CHIP_RV250:
+	case CHIP_RV280:
+	case CHIP_RS300:
 		DRM_INFO("Loading R200 Microcode\n");
 		fw_name = FIRMWARE_R200;
-	} else if ((rdev->family == CHIP_R300) ||
-		   (rdev->family == CHIP_R350) ||
-		   (rdev->family == CHIP_RV350) ||
-		   (rdev->family == CHIP_RV380) ||
-		   (rdev->family == CHIP_RS400) ||
-		   (rdev->family == CHIP_RS480)) {
+		break;
+
+	case CHIP_R300:
+	case CHIP_R350:
+	case CHIP_RV350:
+	case CHIP_RV380:
+	case CHIP_RS400:
+	case CHIP_RS480:
 		DRM_INFO("Loading R300 Microcode\n");
 		fw_name = FIRMWARE_R300;
-	} else if ((rdev->family == CHIP_R420) ||
-		   (rdev->family == CHIP_R423) ||
-		   (rdev->family == CHIP_RV410)) {
+		break;
+
+	case CHIP_R420:
+	case CHIP_R423:
+	case CHIP_RV410:
 		DRM_INFO("Loading R400 Microcode\n");
 		fw_name = FIRMWARE_R420;
-	} else if ((rdev->family == CHIP_RS690) ||
-		   (rdev->family == CHIP_RS740)) {
+		break;
+
+	case CHIP_RS690:
+	case CHIP_RS740:
 		DRM_INFO("Loading RS690/RS740 Microcode\n");
 		fw_name = FIRMWARE_RS690;
-	} else if (rdev->family == CHIP_RS600) {
+		break;
+
+	case CHIP_RS600:
 		DRM_INFO("Loading RS600 Microcode\n");
 		fw_name = FIRMWARE_RS600;
-	} else if ((rdev->family == CHIP_RV515) ||
-		   (rdev->family == CHIP_R520) ||
-		   (rdev->family == CHIP_RV530) ||
-		   (rdev->family == CHIP_R580) ||
-		   (rdev->family == CHIP_RV560) ||
-		   (rdev->family == CHIP_RV570)) {
+		break;
+
+	case CHIP_RV515:
+	case CHIP_R520:
+	case CHIP_RV530:
+	case CHIP_R580:
+	case CHIP_RV560:
+	case CHIP_RV570:
 		DRM_INFO("Loading R500 Microcode\n");
 		fw_name = FIRMWARE_R520;
+		break;
+
+	default:
+		DRM_ERROR("Unsupported Radeon family %u\n", rdev->family);
+		return -EINVAL;
 	}
 
 	err = request_firmware(&rdev->me_fw, fw_name, rdev->dev);
-- 
2.43.0


