Return-Path: <stable+bounces-77621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F7986067
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EB1B2C730
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB109220813;
	Wed, 25 Sep 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RobtNMKk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA122080C;
	Wed, 25 Sep 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266500; cv=none; b=SiZMdLb1T66ttXxI7GSAuiba6+zj5q9fO5sFyNiCOYi5SQtNsu8eKpRU1atbxT6+Y1LgnCL4Jy94a7+6GxLztWi2Kw46PtNZ43hY2i1MgkLRf5J/6Pm4xx9iG4TNp4OqAM87MQDhRtLFDqQSEIubNr+zTosXE7rANphmR1gCSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266500; c=relaxed/simple;
	bh=AtIto5lcfkNXDHThGqXctmPj/h6eo8IBcUWG3Q7psmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8J6zTDJZ6la5tWIo3uvsqY24/BJCOmyNlEQRW6UF6ltTTjOe2t0ZiGV6XYKY2Hl6vV7i7ZMmBA219rghYiWE8RMeKFN/TzWYjp9MIMteRGXL1mg61fz3lvbrTqIst/IbOxhg+IvEjg3UdNVRDA8Pjfb5BeZAwew+nP8njG3VZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RobtNMKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E911EC4CEC3;
	Wed, 25 Sep 2024 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266499;
	bh=AtIto5lcfkNXDHThGqXctmPj/h6eo8IBcUWG3Q7psmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RobtNMKkk2WInYmGbAwNKP3RuQ8mIqV6wbSQvHU0Uy3y128cSbd5tA6l3anO4g10S
	 zuykYuXPmhiMe1GMKnTg8hWikG3Xuk2h1Xp2tddhXqACx8ypc0B3R/bDOMEkPtwlZq
	 SUtOIvocA8E0AMlh6P5UcEw0ha38BSxArIhyTM/XNHAESt/f8HL93epjsZoJnV3YkK
	 MsZ7ckcMm438nzrXIc6APm5UnW8ptdMewlwGnzrclDBwJpClb7F6wMcQXJEn040BFM
	 ux5t2OhI5DXiVKs1EqTDWbganl0mbO3VCRHlnDYUBQnuQ4YVQXNZyuHWsgp6QSuKXh
	 HNgnXBNvL/lTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	pjones@redhat.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 074/139] fbdev: efifb: Register sysfs groups through driver core
Date: Wed, 25 Sep 2024 08:08:14 -0400
Message-ID: <20240925121137.1307574-74-sashal@kernel.org>
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

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 95cdd538e0e5677efbdf8aade04ec098ab98f457 ]

The driver core can register and cleanup sysfs groups already.
Make use of that functionality to simplify the error handling and
cleanup.

Also avoid a UAF race during unregistering where the sysctl attributes
were usable after the info struct was freed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/efifb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index f9b4ddd592ce4..88ac24202a1ff 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -571,15 +571,10 @@ static int efifb_probe(struct platform_device *dev)
 		break;
 	}
 
-	err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
-	if (err) {
-		pr_err("efifb: cannot add sysfs attrs\n");
-		goto err_unmap;
-	}
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0) {
 		pr_err("efifb: cannot allocate colormap\n");
-		goto err_groups;
+		goto err_unmap;
 	}
 
 	if (efifb_pci_dev)
@@ -603,8 +598,6 @@ static int efifb_probe(struct platform_device *dev)
 		pm_runtime_put(&efifb_pci_dev->dev);
 
 	fb_dealloc_cmap(&info->cmap);
-err_groups:
-	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
 	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
 		iounmap(info->screen_base);
@@ -624,12 +617,12 @@ static void efifb_remove(struct platform_device *pdev)
 
 	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
-	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 }
 
 static struct platform_driver efifb_driver = {
 	.driver = {
 		.name = "efi-framebuffer",
+		.dev_groups = efifb_groups,
 	},
 	.probe = efifb_probe,
 	.remove_new = efifb_remove,
-- 
2.43.0


