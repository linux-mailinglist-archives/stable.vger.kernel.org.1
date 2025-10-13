Return-Path: <stable+bounces-185431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD84BD4C16
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB11899DCA
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA11315D40;
	Mon, 13 Oct 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1X36cfrd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02E308F01;
	Mon, 13 Oct 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370275; cv=none; b=NoCrxhtvh8QGxiEBZo/RdAwxpcS8z5IYqW03BDAOjyRlNu3RRqIk3xthrh58V6sXnOabq/FN1D2GWVv/IUCX8ITMCC5WIkmYFr0Q1aICHHYDUh3P1+wbC7JAeKlQW4f+i8Uk8dy+XvU3j3eqUImLMdqnPRx4T2YYmLZrRBDWasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370275; c=relaxed/simple;
	bh=PIuGIzhnIHbntyeEHT8BlkjIpcSm/aeQ8EYh61h9Kyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQLTd+NiQjobXrkb+m4AlykUzmik8tp5sPdOYxzyfLVBzircqrakG70pe5hIDi6lAnKrLe3kEbhZdylEQubqZfOXDAVlzVkQBG27TLTcfmaz/JBKBdTksQ9EWEo2uqaRJsbM1n04C8UGjcEDug+4gx1P3kIJzC48RH4r+f5MiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1X36cfrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D010C4CEE7;
	Mon, 13 Oct 2025 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760370274;
	bh=PIuGIzhnIHbntyeEHT8BlkjIpcSm/aeQ8EYh61h9Kyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1X36cfrdlGZuCqZO0PTdWsyr54BXYIWFcw+w+6hwrpz8V5CR6kWcdZNQO/jUMwIqh
	 QOiy8Sd+rLJZPObyETpyl/O1LQRlFPmb9/aToGwoeJ3IMKgUdHTKhduq62Gf6RvYuW
	 sFOuBbETnGwIhJZEUR6M0HSIpqGxoxKhZCL7ktSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Huhardeaux <tech@tootai.net>,
	Janne Grunau <j@jannau.net>,
	Hans de Goede <hansg@kernel.org>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.17 539/563] fbdev: simplefb: Fix use after free in simplefb_detach_genpds()
Date: Mon, 13 Oct 2025 16:46:40 +0200
Message-ID: <20251013144430.834539197@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janne Grunau <j@jannau.net>

commit da1bb9135213744e7ec398826c8f2e843de4fb94 upstream.

The pm_domain cleanup can not be devres managed as it uses struct
simplefb_par which is allocated within struct fb_info by
framebuffer_alloc(). This allocation is explicitly freed by
unregister_framebuffer() in simplefb_remove().
Devres managed cleanup runs after the device remove call and thus can no
longer access struct simplefb_par.
Call simplefb_detach_genpds() explicitly from simplefb_destroy() like
the cleanup functions for clocks and regulators.

Fixes an use after free on M2 Mac mini during
aperture_remove_conflicting_devices() using the downstream asahi kernel
with Debian's kernel config. For unknown reasons this started to
consistently dereference an invalid pointer in v6.16.3 based kernels.

[    6.736134] BUG: KASAN: slab-use-after-free in simplefb_detach_genpds+0x58/0x220
[    6.743545] Read of size 4 at addr ffff8000304743f0 by task (udev-worker)/227
[    6.750697]
[    6.752182] CPU: 6 UID: 0 PID: 227 Comm: (udev-worker) Tainted: G S                  6.16.3-asahi+ #16 PREEMPTLAZY
[    6.752186] Tainted: [S]=CPU_OUT_OF_SPEC
[    6.752187] Hardware name: Apple Mac mini (M2, 2023) (DT)
[    6.752189] Call trace:
[    6.752190]  show_stack+0x34/0x98 (C)
[    6.752194]  dump_stack_lvl+0x60/0x80
[    6.752197]  print_report+0x17c/0x4d8
[    6.752201]  kasan_report+0xb4/0x100
[    6.752206]  __asan_report_load4_noabort+0x20/0x30
[    6.752209]  simplefb_detach_genpds+0x58/0x220
[    6.752213]  devm_action_release+0x50/0x98
[    6.752216]  release_nodes+0xd0/0x2c8
[    6.752219]  devres_release_all+0xfc/0x178
[    6.752221]  device_unbind_cleanup+0x28/0x168
[    6.752224]  device_release_driver_internal+0x34c/0x470
[    6.752228]  device_release_driver+0x20/0x38
[    6.752231]  bus_remove_device+0x1b0/0x380
[    6.752234]  device_del+0x314/0x820
[    6.752238]  platform_device_del+0x3c/0x1e8
[    6.752242]  platform_device_unregister+0x20/0x50
[    6.752246]  aperture_detach_platform_device+0x1c/0x30
[    6.752250]  aperture_detach_devices+0x16c/0x290
[    6.752253]  aperture_remove_conflicting_devices+0x34/0x50
...
[    6.752343]
[    6.967409] Allocated by task 62:
[    6.970724]  kasan_save_stack+0x3c/0x70
[    6.974560]  kasan_save_track+0x20/0x40
[    6.978397]  kasan_save_alloc_info+0x40/0x58
[    6.982670]  __kasan_kmalloc+0xd4/0xd8
[    6.986420]  __kmalloc_noprof+0x194/0x540
[    6.990432]  framebuffer_alloc+0xc8/0x130
[    6.994444]  simplefb_probe+0x258/0x2378
...
[    7.054356]
[    7.055838] Freed by task 227:
[    7.058891]  kasan_save_stack+0x3c/0x70
[    7.062727]  kasan_save_track+0x20/0x40
[    7.066565]  kasan_save_free_info+0x4c/0x80
[    7.070751]  __kasan_slab_free+0x6c/0xa0
[    7.074675]  kfree+0x10c/0x380
[    7.077727]  framebuffer_release+0x5c/0x90
[    7.081826]  simplefb_destroy+0x1b4/0x2c0
[    7.085837]  put_fb_info+0x98/0x100
[    7.089326]  unregister_framebuffer+0x178/0x320
[    7.093861]  simplefb_remove+0x3c/0x60
[    7.097611]  platform_remove+0x60/0x98
[    7.101361]  device_remove+0xb8/0x160
[    7.105024]  device_release_driver_internal+0x2fc/0x470
[    7.110256]  device_release_driver+0x20/0x38
[    7.114529]  bus_remove_device+0x1b0/0x380
[    7.118628]  device_del+0x314/0x820
[    7.122116]  platform_device_del+0x3c/0x1e8
[    7.126302]  platform_device_unregister+0x20/0x50
[    7.131012]  aperture_detach_platform_device+0x1c/0x30
[    7.136157]  aperture_detach_devices+0x16c/0x290
[    7.140779]  aperture_remove_conflicting_devices+0x34/0x50
...

Reported-by: Daniel Huhardeaux <tech@tootai.net>
Cc: stable@vger.kernel.org
Fixes: 92a511a568e44 ("fbdev/simplefb: Add support for generic power-domains")
Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/simplefb.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -93,6 +93,7 @@ struct simplefb_par {
 
 static void simplefb_clocks_destroy(struct simplefb_par *par);
 static void simplefb_regulators_destroy(struct simplefb_par *par);
+static void simplefb_detach_genpds(void *res);
 
 /*
  * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
@@ -105,6 +106,7 @@ static void simplefb_destroy(struct fb_i
 
 	simplefb_regulators_destroy(info->par);
 	simplefb_clocks_destroy(info->par);
+	simplefb_detach_genpds(info->par);
 	if (info->screen_base)
 		iounmap(info->screen_base);
 
@@ -445,13 +447,14 @@ static void simplefb_detach_genpds(void
 		if (!IS_ERR_OR_NULL(par->genpds[i]))
 			dev_pm_domain_detach(par->genpds[i], true);
 	}
+	par->num_genpds = 0;
 }
 
 static int simplefb_attach_genpds(struct simplefb_par *par,
 				  struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	unsigned int i;
+	unsigned int i, num_genpds;
 	int err;
 
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
@@ -465,26 +468,35 @@ static int simplefb_attach_genpds(struct
 		return err;
 	}
 
-	par->num_genpds = err;
+	num_genpds = err;
 
 	/*
 	 * Single power-domain devices are handled by the driver core, so
 	 * nothing to do here.
 	 */
-	if (par->num_genpds <= 1)
+	if (num_genpds <= 1) {
+		par->num_genpds = num_genpds;
 		return 0;
+	}
 
-	par->genpds = devm_kcalloc(dev, par->num_genpds, sizeof(*par->genpds),
+	par->genpds = devm_kcalloc(dev, num_genpds, sizeof(*par->genpds),
 				   GFP_KERNEL);
 	if (!par->genpds)
 		return -ENOMEM;
 
-	par->genpd_links = devm_kcalloc(dev, par->num_genpds,
+	par->genpd_links = devm_kcalloc(dev, num_genpds,
 					sizeof(*par->genpd_links),
 					GFP_KERNEL);
 	if (!par->genpd_links)
 		return -ENOMEM;
 
+	/*
+	 * Set par->num_genpds only after genpds and genpd_links are allocated
+	 * to exit early from simplefb_detach_genpds() without full
+	 * initialisation.
+	 */
+	par->num_genpds = num_genpds;
+
 	for (i = 0; i < par->num_genpds; i++) {
 		par->genpds[i] = dev_pm_domain_attach_by_id(dev, i);
 		if (IS_ERR(par->genpds[i])) {
@@ -506,9 +518,10 @@ static int simplefb_attach_genpds(struct
 			dev_warn(dev, "failed to link power-domain %u\n", i);
 	}
 
-	return devm_add_action_or_reset(dev, simplefb_detach_genpds, par);
+	return 0;
 }
 #else
+static void simplefb_detach_genpds(void *res) { }
 static int simplefb_attach_genpds(struct simplefb_par *par,
 				  struct platform_device *pdev)
 {
@@ -622,18 +635,20 @@ static int simplefb_probe(struct platfor
 	ret = devm_aperture_acquire_for_platform_device(pdev, par->base, par->size);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to acquire aperture: %d\n", ret);
-		goto error_regulators;
+		goto error_genpds;
 	}
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
-		goto error_regulators;
+		goto error_genpds;
 	}
 
 	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
 
 	return 0;
 
+error_genpds:
+	simplefb_detach_genpds(par);
 error_regulators:
 	simplefb_regulators_destroy(par);
 error_clocks:



