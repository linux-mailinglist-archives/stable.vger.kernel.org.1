Return-Path: <stable+bounces-95476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C34319D90AA
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 04:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684FF169BDF
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 03:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A83E47A73;
	Tue, 26 Nov 2024 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBqAjxI3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE07528E3F
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590829; cv=none; b=p9DTLIXouuRLOuscAHxrdXREfY511YE+QgxPwXa1c0xoRO9ctzhc32g4SAXq0NyBV6oFcFmhH/Y4WNAPfKH2WXJp/HForlv4dlLLxAvxuy4Ru5Ti7Hd1+MbKDZGwKOgWnagAxzDviqyyAnxHSZE72TI4nnJoXlBv1e1KpoF6M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590829; c=relaxed/simple;
	bh=WrNs0BaLYFWIS7n3OyBC8g9aVRUlG0bGGSlm4SBxTOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbvThJKsuVwDHq93E3OSvSdEE7GSkBav5T6mKCwp3YtbaAJ5t+zFDMaSLhk23+V1ygbv/3K1mmrSmhG9329c+eVNvUTciltZLK4suNJLuvyZv7gGReL4MN8oHeitXqaCW3H8SdM5tSMHYjIojBmjGjmwS9YzSsvAb2dC3IethmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBqAjxI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C53C4CECE;
	Tue, 26 Nov 2024 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732590828;
	bh=WrNs0BaLYFWIS7n3OyBC8g9aVRUlG0bGGSlm4SBxTOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBqAjxI32bDIb0M52HgO8k3RIDAsUmmfHHUnYhCsmufoeXktzO9NE236wnUp1iAss
	 8McajqyoboSXGYR0bm2upe60IPEyKElsAXq3U5cXF0fGDK36pgKJTe6LRke03gBzLk
	 hDHK4PFMmtp0MD4CIkuIWGEAjUDM+QRz0JjxZ8D/MKwoCIE6ytSQ3OEF2AJY2Ir/pp
	 nWx0x2a7J4x3O4/0vL2aySI/7Un9Fb8UTcBadWIzJRDLMXtOcuWmsKNmfmcIFxGdBs
	 eCk130N2OZAW1Ylp99Vya/tYQqqi6FTgA8VHVdkrHwCUiG2XJFk/mMEtBDZfigKTsf
	 LcZ0dJhUEnTdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fbdev: efifb: Register sysfs groups through driver core
Date: Mon, 25 Nov 2024 22:13:45 -0500
Message-ID: <20241125214548-4997e8afca371bec@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126023900.357636-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 95cdd538e0e5677efbdf8aade04ec098ab98f457

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Thomas Weißschuh <linux@weissschuh.net>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 4684d69b9670)
6.6.y | Present (different SHA1: 36bfefb6baaa)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 21:40:25.872982840 -0500
+++ /tmp/tmp.oieDEbdQgp	2024-11-25 21:40:25.860889130 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 95cdd538e0e5677efbdf8aade04ec098ab98f457 ]
+
 The driver core can register and cleanup sysfs groups already.
 Make use of that functionality to simplify the error handling and
 cleanup.
@@ -7,15 +9,17 @@
 
 Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
 Signed-off-by: Helge Deller <deller@gmx.de>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/video/fbdev/efifb.c | 11 ++---------
  1 file changed, 2 insertions(+), 9 deletions(-)
 
 diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
-index 8dd82afb3452b..595b8e27bea66 100644
+index 16c1aaae9afa..53944bcc990c 100644
 --- a/drivers/video/fbdev/efifb.c
 +++ b/drivers/video/fbdev/efifb.c
-@@ -561,15 +561,10 @@ static int efifb_probe(struct platform_device *dev)
+@@ -570,15 +570,10 @@ static int efifb_probe(struct platform_device *dev)
  		break;
  	}
  
@@ -31,27 +35,32 @@
 +		goto err_unmap;
  	}
  
- 	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
-@@ -587,8 +582,6 @@ static int efifb_probe(struct platform_device *dev)
+ 	if (efifb_pci_dev)
+@@ -597,8 +592,6 @@ static int efifb_probe(struct platform_device *dev)
+ 		pm_runtime_put(&efifb_pci_dev->dev);
  
- err_fb_dealloc_cmap:
  	fb_dealloc_cmap(&info->cmap);
 -err_groups:
 -	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
  err_unmap:
  	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
  		iounmap(info->screen_base);
-@@ -608,12 +601,12 @@ static void efifb_remove(struct platform_device *pdev)
+@@ -618,7 +611,6 @@ static int efifb_remove(struct platform_device *pdev)
  
  	/* efifb_destroy takes care of info cleanup */
  	unregister_framebuffer(info);
 -	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
- }
  
+ 	return 0;
+ }
+@@ -626,6 +618,7 @@ static int efifb_remove(struct platform_device *pdev)
  static struct platform_driver efifb_driver = {
  	.driver = {
  		.name = "efi-framebuffer",
 +		.dev_groups = efifb_groups,
  	},
  	.probe = efifb_probe,
- 	.remove_new = efifb_remove,
+ 	.remove = efifb_remove,
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

