Return-Path: <stable+bounces-200102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8CFCA5F9B
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 04:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC2DD30B6508
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 03:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4022C235E;
	Fri,  5 Dec 2025 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MHEW5oZm"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076178C9C;
	Fri,  5 Dec 2025 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904504; cv=none; b=YEIoWeFS2VgQDPi/f+lluUsm9yUYbUuj2ycbuDhE9KF11oJu84D7vTLsdZy3nLMoE1bGGpnrmlDovKSGy2iUjLF+a4mUlaMovrueFDbdI5sNGt7i6dsoTriBqSNclHmfQB2fmg5u2nq/OV/2O1y0YcZn1KRZ8O7UqHsqi/ICwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904504; c=relaxed/simple;
	bh=h4HHb+hkJjZQ/yqHZB+Fb1tsqnk5hnbJ811KUMYBWOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EnyKoeOQkSkngO0vQBgI93yi2Q3M0HsDdwPYZyx4D8w18J8lsarVli/wbmma/J9FYnLILX26cdNk6XkqwlQSqYQ2GDuRGJmrofZVTuRJentwmvuZAPcUNey1EpIiVgGOO2ZjSzbQbPDjBl+ymArsjxkRyas0IudmalNxS1L1hQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MHEW5oZm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HJ
	+a7VyQ+SlJV2GrWFWNFWYRILhDpZouGhOhZPumriI=; b=MHEW5oZmhhbGtxHl3p
	3V7A11JTKgB4MVbZmkfHDw5vXcngpGRFpzCDEAxXRKRot3XNllLnqk00TcACvKOI
	W00EfLPHtjYUlmKrHH8vDHEqOQFfPJpIKZjtZ7ufDPeW8rhh+wQju3pQcqEoR4Co
	lMTQfJcs44jXdzRGfYibfSoag=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXrRT8TTJp6PtjEw--.54747S4;
	Fri, 05 Dec 2025 11:14:06 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrzej.hajda@intel.com,
	kyungmin.park@samsung.com,
	treding@nvidia.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND] drm: mipi-dsi: Fix an API misuse in mipi_dsi_device_register_full()
Date: Fri,  5 Dec 2025 11:14:03 +0800
Message-Id: <20251205031403.129227-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXrRT8TTJp6PtjEw--.54747S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWDKFyrJrWfJw13GrW3Wrg_yoWfKFb_CF
	10qwn7Zr4kC3s7tF13Aa1fZrWay3Z0vr4ruF1UtFn5A3yaqrWDX3s8urWFq34UWF47AF98
	Z3Wjqr1fAa13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRApnDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxh5552kyTf4yyAAA3U

mipi_dsi_device_alloc() calls device_initialize() to initialize value
"&dsi->dev". Thus "dsi" should be freed using put_device() in error
handling path.

Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index a712e177b350..e47950009126 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -233,7 +233,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 	ret = mipi_dsi_device_add(dsi);
 	if (ret) {
 		dev_err(host->dev, "failed to add DSI device %d\n", ret);
-		kfree(dsi);
+		put_device(&dsi->dev);
 		return ERR_PTR(ret);
 	}
 
-- 
2.25.1


