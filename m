Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8283977599E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjHILCG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjHILCG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB1ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 382E66309F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47787C433C7;
        Wed,  9 Aug 2023 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578924;
        bh=aR2qafydWa2RUIZDD16zu3uN114bm7NQb3ViPEPiPNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCrwK4vi90NfSOI8yZpHloCL2vMijnYJtMbu33Mwl4LLsv4jAsA0ymR4Z0JHTmPOO
         3SRsSmxQn9GJSIRdWaAcs5pD5Mu7iG4S0HeDrFIBJJ1cKn+uyssaDiviUbDs0rQ5QD
         6vGjLRrtUCmxzQ/SN+kT3nZvPuNxpKwGXu9I8FQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.14 004/204] fbdev: imsttfb: Fix use after free bug in imsttfb_probe
Date:   Wed,  9 Aug 2023 12:39:02 +0200
Message-ID: <20230809103642.700560020@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zheng Wang <zyytlz.wz@163.com>

commit c75f5a55061091030a13fef71b9995b89bc86213 upstream.

A use-after-free bug may occur if init_imstt invokes framebuffer_release
and free the info ptr. The caller, imsttfb_probe didn't notice that and
still keep the ptr as private data in pdev.

If we remove the driver which will call imsttfb_remove to make cleanup,
UAF happens.

Fix it by return error code if bad case happens in init_imstt.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/imsttfb.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1348,7 +1348,7 @@ static struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void init_imstt(struct fb_info *info)
+static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1420,7 +1420,7 @@ static void init_imstt(struct fb_info *i
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac == IBM ? "IBM" : "TVP");
@@ -1460,12 +1460,13 @@ static void init_imstt(struct fb_info *i
 	if (register_framebuffer(info) < 0) {
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	tmp = (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 	fb_info(info, "%s frame buffer; %uMB vram; chip version %u\n",
 		info->fix.id, info->fix.smem_len >> 20, tmp);
+	return 0;
 }
 
 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -1474,7 +1475,8 @@ static int imsttfb_probe(struct pci_dev
 	struct imstt_par *par;
 	struct fb_info *info;
 	struct device_node *dp;
-	
+	int ret;
+
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
 		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
@@ -1525,10 +1527,10 @@ static int imsttfb_probe(struct pci_dev
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->pseudo_palette = par->palette;
-	init_imstt(info);
-
-	pci_set_drvdata(pdev, info);
-	return 0;
+	ret = init_imstt(info);
+	if (!ret)
+		pci_set_drvdata(pdev, info);
+	return ret;
 }
 
 static void imsttfb_remove(struct pci_dev *pdev)


