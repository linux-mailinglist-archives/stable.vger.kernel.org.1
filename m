Return-Path: <stable+bounces-77212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA9985A56
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D8A1C21019
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8041B5309;
	Wed, 25 Sep 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egiD+eaU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3941B5301;
	Wed, 25 Sep 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264534; cv=none; b=Fdj1N5mp//jyCfTz9wsIvQakEhxagbhhjhEe805s7JaOTsYNP6TxmW3Wc9+s7kp/DRKE6eJ3aqV774tFE3fb0R2wQQYDcl/rcXwlfe8DDnnnsSfk9h1CV/jlF16T3hYXl4yFrCa0SmxkiOoR51zuKomEp2Fw4EpVEkFcve0Ehyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264534; c=relaxed/simple;
	bh=6Rf5F4xR3of/PuGK6m3em5sCuc3QV6oACndIhzGnyQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szAEUazctI3wXOWDBxB27B/Uv4/30ThHbWfLINJWwI2274M14/tYQXiWyJauSGaHcM2BjWSTzD1hS6d4lXif77ffne2ufcxXZXBEKS9ntThKXvERzexQB90TGc1qhNRn+wd1+fXFAhxcBw14acc1dPPr6IFfsvvDYJ6Udv194bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egiD+eaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E02C4CEC3;
	Wed, 25 Sep 2024 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264534;
	bh=6Rf5F4xR3of/PuGK6m3em5sCuc3QV6oACndIhzGnyQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egiD+eaUrhi0hi5RVUYDLv32mDSrakuBPYinrp+v/Pig4VNWm+xT83yEbkkCD+xaj
	 8WUHWxSS9VA2yVlSWmCxdLZ4G8zWKFGZX+rLhA5tQ44COOoG3nx6NUjHqSOBx0qGp6
	 ylGJfbRcTQuPHviDzvGTPR8BdFycn2bZvmiJTsH8IGl/hYekVyWZ7sBjDk0Crsq7+m
	 TvCmPVc34eYI2Uvv7WgPQRWqAlP+fTi/NlX8OxwGlFB2M08j0YfC8lB54pLwFaDBCB
	 XZNKn5OQTCSrFD+knHbaGIfZSDxt6pV284LE4Oc7T9i2sTUPVtmlcMCTXwoq5gb+Gl
	 2Ovp7IL3DaqHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	pjones@redhat.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 114/244] fbdev: efifb: Register sysfs groups through driver core
Date: Wed, 25 Sep 2024 07:25:35 -0400
Message-ID: <20240925113641.1297102-114-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 8dd82afb3452b..595b8e27bea66 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -561,15 +561,10 @@ static int efifb_probe(struct platform_device *dev)
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
 
 	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
@@ -587,8 +582,6 @@ static int efifb_probe(struct platform_device *dev)
 
 err_fb_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
-err_groups:
-	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
 	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
 		iounmap(info->screen_base);
@@ -608,12 +601,12 @@ static void efifb_remove(struct platform_device *pdev)
 
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


