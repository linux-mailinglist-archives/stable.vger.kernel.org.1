Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B776160B
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjGYLfw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjGYLfv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:35:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F910EC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F05461698
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E95DC433C8;
        Tue, 25 Jul 2023 11:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284943;
        bh=L6CnLgU0wqFtJxGAZqX9uWuvsTgpgxpVzxshZHfozlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIDwtTzPpDW+e1rb8An9MbxiOois/dEeeC39GtACi0zicdwx5kn1Dhx9WsrS5/Xd2
         FF0MzpKPWakiUfB0RKx6aGhsMUuEqAxt4xnYZuT3fbsvytOf99DSmEXAS87evReYZf
         vsWzOSe93Wr+hrp/qrVc5VmEVN4pumg1Mqvl2wSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.4 004/313] fbdev: imsttfb: Fix use after free bug in imsttfb_probe
Date:   Tue, 25 Jul 2023 12:42:37 +0200
Message-ID: <20230725104521.375942189@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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
 drivers/video/fbdev/imsttfb.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1346,7 +1346,7 @@ static struct fb_ops imsttfb_ops = {
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
-static void init_imstt(struct fb_info *info)
+static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1419,7 +1419,7 @@ static void init_imstt(struct fb_info *i
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yres, info->var.bits_per_pixel);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}
 
 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac == IBM ? "IBM" : "TVP");
@@ -1455,12 +1455,13 @@ static void init_imstt(struct fb_info *i
 
 	if (register_framebuffer(info) < 0) {
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
@@ -1523,10 +1524,10 @@ static int imsttfb_probe(struct pci_dev
 	if (!par->cmap_regs)
 		goto error;
 	info->pseudo_palette = par->palette;
-	init_imstt(info);
-
-	pci_set_drvdata(pdev, info);
-	return 0;
+	ret = init_imstt(info);
+	if (!ret)
+		pci_set_drvdata(pdev, info);
+	return ret;
 
 error:
 	if (par->dc_regs)


