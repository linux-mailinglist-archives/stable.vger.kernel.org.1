Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4478F7613E3
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjGYLO6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjGYLMt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55722689
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68F5F61682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAD1C433C7;
        Tue, 25 Jul 2023 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283519;
        bh=W/ommO/fTyWLnvh84ukbSdB/1HtUbU8bHiIlBdYE5DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPXdTkSezbg8Hw+/ImAu0MHlnB8DJviHSVkTEZX/FENzfyWezMS9K4whu+Dqnakfs
         VeA+BEOQuG7ce2N6zUcIV2t2rGygeA5/Hje0C4tdy+kJIQMoTUmRDZXTfroLYiC/2r
         IN4TTaf5K2tt9Jolv4fsm5uBeDBsgsomsLWHnDKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Finn Thain <fthain@telegraphics.com.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.10 004/509] video: imsttfb: check for ioremap() failures
Date:   Tue, 25 Jul 2023 12:39:03 +0200
Message-ID: <20230725104553.808190038@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 13b7c0390a5d3840e1e2cda8f44a310fdbb982de upstream.

We should check if ioremap() were to somehow fail in imsttfb_probe() and
handle the unwinding of the resources allocated here properly.

Ideally if anyone cares about this driver (it's for a PowerMac era PCI
display card), they wouldn't even be using fbdev anymore.  Or the devm_*
apis could be used, but that's just extra work for diminishing
returns...

Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210503115736.2104747-68-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/imsttfb.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1469,6 +1469,7 @@ static int imsttfb_probe(struct pci_dev
 	struct imstt_par *par;
 	struct fb_info *info;
 	struct device_node *dp;
+	int ret = -ENOMEM;
 	
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
@@ -1504,23 +1505,37 @@ static int imsttfb_probe(struct pci_dev
 		default:
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
-			release_mem_region(addr, size);
-			framebuffer_release(info);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto error;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
+	if (!info->screen_base)
+		goto error;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
+	if (!par->dc_regs)
+		goto error;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
+	if (!par->cmap_regs)
+		goto error;
 	info->pseudo_palette = par->palette;
 	init_imstt(info);
 
 	pci_set_drvdata(pdev, info);
 	return 0;
+
+error:
+	if (par->dc_regs)
+		iounmap(par->dc_regs);
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(addr, size);
+	framebuffer_release(info);
+	return ret;
 }
 
 static void imsttfb_remove(struct pci_dev *pdev)


