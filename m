Return-Path: <stable+bounces-140480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20FAAA926
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3619465143
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1E27E7C5;
	Mon,  5 May 2025 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n86hZJU4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4F356E71;
	Mon,  5 May 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484937; cv=none; b=Ea78E+5PE5tuMn9Xd9EG1jTkJI55VrlT0BswdzrKwv6qXf8wp/Ecv6qIJtbhwXgxGU6qKIds9OfsTVYdqfNouQbIQdsDOStDL0iY1gjICgsyJOGm068ZyhQvTMCi0CItlWv7SVqgaOLAUDAXbh+78grT/BK4gw7PPWgqKgsLM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484937; c=relaxed/simple;
	bh=JQgySx1ZAiBLcZYCPGWNau41QHc0ukZYtN/IvnH6UNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grGrKHLnYZcHq/mI6/WxK9Os3crIw/+1tc0UMlMA/HzTU+FlL2BlPBdYtqy9mtYYmq3c/0j0GeJgyyTHALfkFk/iburqqMhFQWVo5D9zCMDpXdVFYXk3KVvulqsM/2dCDyeB4lAd7Ha3VxqLaNX1gZxFSyxcJjaMo156BDLLHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n86hZJU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4824EC4CEE4;
	Mon,  5 May 2025 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484936;
	bh=JQgySx1ZAiBLcZYCPGWNau41QHc0ukZYtN/IvnH6UNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n86hZJU4jrMnIncrlX9+Gxiy+mNEmoNyKZZJTiTR3aB0rGQbR6QhUwcBsP97b3s6r
	 xXkx/v0g/rS4Xii/19PXwWnwLMoVsM5unRZ6wG6X9ew+Vo8J5gELHrpJSa8CZtEoI3
	 6qOq0jpVH1uHCbnPqu4SpXxGZstBZG8rnOWZEtv8OL3XXYBcEhENnfSUyEL94i3hXd
	 oMANG3ZRADO2QSDyum3gf96g0BmoLcH7VuJORakxWb3QVuKuMKuCG7L3kz56RDg691
	 YvaCvHYL/4AhcfQPQbdaVK36s9m4lrbhv2hcSIFFMeowKobt1ptxTLc1GVzq6IcYfj
	 3meTPZFQsP4Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Kent Russell <kent.russell@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	mario.limonciello@amd.com,
	marek.olsak@amd.com,
	rajneesh.bhardwaj@amd.com,
	tzimmermann@suse.de,
	Ramesh.Errabolu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 084/486] drm/amdgpu: adjust drm_firmware_drivers_only() handling
Date: Mon,  5 May 2025 18:32:40 -0400
Message-Id: <20250505223922.2682012-84-sashal@kernel.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit e00e5c223878a60e391e5422d173c3382d378f87 ]

Move to probe so we can check the PCI device type and
only apply the drm_firmware_drivers_only() check for
PCI DISPLAY classes.  Also add a module parameter to
override the nomodeset kernel parameter as a workaround
for platforms that have this hardcoded on their kernel
command lines.

Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a9eb0927a7664..e1d26a479ed87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -172,6 +172,7 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+int amdgpu_modeset = -1;
 
 /* Specifies the default granularity for SVM, used in buffer
  * migration and restoration of backing memory when handling
@@ -1037,6 +1038,13 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 module_param(enforce_isolation, bool, 0444);
 MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
 
+/**
+ * DOC: modeset (int)
+ * Override nomodeset (1 = override, -1 = auto). The default is -1 (auto).
+ */
+MODULE_PARM_DESC(modeset, "Override nomodeset (1 = enable, -1 = auto)");
+module_param_named(modeset, amdgpu_modeset, int, 0444);
+
 /**
  * DOC: seamless (int)
  * Seamless boot will keep the image on the screen during the boot process.
@@ -2248,6 +2256,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	int ret, retry = 0, i;
 	bool supports_atomic = false;
 
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA ||
+	    (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER) {
+		if (drm_firmware_drivers_only() && amdgpu_modeset == -1)
+			return -EINVAL;
+	}
+
 	/* skip devices which are owned by radeon */
 	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
 		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
-- 
2.39.5


