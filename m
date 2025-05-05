Return-Path: <stable+bounces-139854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D23AAA0FB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F70A16AE31
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25242989B6;
	Mon,  5 May 2025 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP7qYfV+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF82989B0;
	Mon,  5 May 2025 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483545; cv=none; b=twk/9vPezCf7yIYyJQ6xxpCx1KD1OC4ZrnSkHGSk0ILb9PHj2NMjCYRZLTAsIcswpTaeJDP5i2dnl1IQHuwt40rcU4MuBibFWmMesEwYv0W5x8rH1OZWq4p03jxJCHFdmABx4jMBuPPJqY8s6pprbnshCfBPgUQDnu9R3m+o4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483545; c=relaxed/simple;
	bh=PUunGMcTzpY998apPoFto9rGLwncwZyyTgV4Dyfxw1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+HzanEEfYLM6KfqfQX9kMR/kP7u3xf9KyVYtV6dF4JDnyEdp0CNZHMLqU4qwvW9wEMRV4njt73zkMNcm9zCt4skyI08Ot0piBTZWszkowWw41WM3dBN+oEzR6TENztp4+A3JoLHA2tScjxvOIvIMJsEoLsicNcackgwFM2m4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP7qYfV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF81C4CEED;
	Mon,  5 May 2025 22:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483545;
	bh=PUunGMcTzpY998apPoFto9rGLwncwZyyTgV4Dyfxw1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GP7qYfV+fdOjNckT3BSVolmLC48Ocjytz1v45paYz/C2mj+bK6TTlv2Wjg97yu9z7
	 P1USsOIiff466qqxlCSDaKDcrgCDSWiItQAYy905tw87s/ALA7p8PTmZs4QgCjmVjq
	 EQMLC2cWjRJqC/5cQjk+i6xxNqHAyTdFr3HU0TIJ4Kg7/sPDUP2Dsx1gyAq1R5fbom
	 DZv3W1bujF2v9rPCnjLqDBjaeoiqp5QWLoXAgd3c41jk5NtTlte0yfMscL05RFER85
	 nUVZtmzpk3SyGEuI5kugeDU2bNgQ6rI+HdYJb8vAARHMU+oaP7CMAEGWUbjEnlvVAH
	 3zZTajXfsmlPQ==
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
	tzimmermann@suse.de,
	rajneesh.bhardwaj@amd.com,
	kenneth.feng@amd.com,
	Ramesh.Errabolu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 107/642] drm/amdgpu: adjust drm_firmware_drivers_only() handling
Date: Mon,  5 May 2025 18:05:23 -0400
Message-Id: <20250505221419.2672473-107-sashal@kernel.org>
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
index f2d77bc04e4a9..7246c54bd2bbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -173,6 +173,7 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+int amdgpu_modeset = -1;
 
 /* Specifies the default granularity for SVM, used in buffer
  * migration and restoration of backing memory when handling
@@ -1033,6 +1034,13 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
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
@@ -2244,6 +2252,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
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


