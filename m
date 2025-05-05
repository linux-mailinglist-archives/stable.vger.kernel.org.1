Return-Path: <stable+bounces-139853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DDFAAA0FA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01ED164D2F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65C29899D;
	Mon,  5 May 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl4JjjET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A6298996;
	Mon,  5 May 2025 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483543; cv=none; b=uloIe8CqP3KOgVRzn/1HSrR+zs9kGnW0qQ0P3W7hTLjkj5qsYowqfOLmysacDNGaZMT0hGvHGg81dFODYvdbE+oH4qP6qORGM5TFKjMtJE8F/t7ILl/vCmWuhdeFYDggmBaAge54sef0CukcnmwpPsZGLoajQZT7Vp3bixJRqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483543; c=relaxed/simple;
	bh=Z9IFOu4PacnKKHtb6lAtZ/8jE/G/tPuhMUua38YxDJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEzww6sPAhUtbY+tQpBP3a6iqTLos8qqFHzsxmm8LSoE+4WX23ZeW4mrMiSubXy388DmgOxvxIOZLBiFFWbf9bkW4TOz8FHvDlrBzI20eiudnMUj5mqZaH6sKxLWHCXZ/DA5n88kcPtGA9a+lvjhonTh16QdBF1keR4NnVKu7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl4JjjET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49843C4CEE4;
	Mon,  5 May 2025 22:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483542;
	bh=Z9IFOu4PacnKKHtb6lAtZ/8jE/G/tPuhMUua38YxDJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kl4JjjETWwKbR4SI1xOPcqo0C5DBuoiDv/jHkRKf9yBbBSYE07lZRiOIv1k7faxPn
	 41Aa4OYzOUGJrZjD+zYQ4eI7vuwmzitXT7yzsrpW79GLEvae8YOgNeJmLcT19ftRT1
	 uku05a6erwtGPwu7H56Dfin55faS+pG306bH8I38HrDnCE8jV+IWwQ+AP+dm7fqjdn
	 AuoN/BujPl66d5SUWZzMY9t5TXBgn6MQrXMRxrPNqP2xpPX1jFdwPnHojV40s62teX
	 S9QGae9ctTKry3SyBhq6073evpbpdGUIYKpVtXIy06A0eFij9e8q2KuKfnGLC6V2k8
	 in/mDlc0W7gLQ==
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
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 106/642] drm/amdgpu: don't free conflicting apertures for non-display devices
Date: Mon,  5 May 2025 18:05:22 -0400
Message-Id: <20250505221419.2672473-106-sashal@kernel.org>
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

[ Upstream commit 9deacd6c55f1b31e5ab20db79df2e14ac480203c ]

PCI_CLASS_ACCELERATOR_PROCESSING devices won't ever be
the sysfb, so there is no need to free conflicting
apertures.

Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3e4201a405c8..9cde62b178c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4370,10 +4370,17 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	/* Get rid of things like offb */
-	r = aperture_remove_conflicting_pci_devices(adev->pdev, amdgpu_kms_driver.name);
-	if (r)
-		return r;
+	/*
+	 * No need to remove conflicting FBs for non-display class devices.
+	 * This prevents the sysfb from being freed accidently.
+	 */
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA ||
+	    (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER) {
+		/* Get rid of things like offb */
+		r = aperture_remove_conflicting_pci_devices(adev->pdev, amdgpu_kms_driver.name);
+		if (r)
+			return r;
+	}
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
-- 
2.39.5


