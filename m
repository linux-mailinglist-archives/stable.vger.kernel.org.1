Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AAA7428C6
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjF2Opy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjF2Opw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 10:45:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796081FC1
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688049943; x=1688654743; i=deller@gmx.de;
 bh=rDlTuoc/BYBeiJLtz0AJlgi3bKHeeaAVXLl91gSaSog=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=l8RucVJ+HFlZcMGAw78F4LpJ0Ala/b50CxuUCXUuISQ3kpEYHB4TPYmGV+nOoDlp7N3wTmZ
 ri/xi4pxZNl+uaGh7+nGv1l8gbNP2l8Lwee4O+hr3+ecwDFjh/DyAcV2GzUqyatWCgMoJMZ4Q
 QG7eOEmxfdxYtvHpsHor4bfPsctuR2Vo5nGXUmWpwfLqkjsA/oNKQMBzDrKnm46u/SMvtbqIB
 8xq1UKKK1KlfF3qLczmJTXw4zWrOD7Uj6/gmpy3T9muEw/glPlxRE2QY0bmalrrmRqJsHjdJY
 uDjSRRVTubW+evk2EdRRR+KNCTqVJgPgJiW8lqQZUvjDPTLI+Oaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.146.6]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1pxUfs0lrn-00rsx5; Thu, 29
 Jun 2023 16:45:43 +0200
Date:   Thu, 29 Jun 2023 16:45:41 +0200
From:   Helge Deller <deller@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH][for-4.14] fbdev: imsttfb: Fix use after free bug in
 imsttfb_probe
Message-ID: <ZJ2ZFfH6qos5MFjm@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:OBujH1zUkLZdfemmp84AbkLYuDQGIy3A9axinAzfF/plio5ANDK
 AUGKeOsYCKP9K4xOK3EZHVBoMduo9/DQRTop/gOWA7AUYOWh7p9B9CZvrrZKuYpxAryCR2e
 3/uUNkBNZ/dn4v3sGmipatp6xKGRbSQOqj6HbARQaFwQ2C4fmb09Lgh3yH8Y0CyqyCLF0ZS
 q4RrnXy8oI6hJojoQrnGA==
UI-OutboundReport: notjunk:1;M01:P0:dyeA5wQ7i58=;qG+iEtFi5EK3i62aG5kxsdEl8cA
 jXE3RsRpOMAS8epGHMl9lwvdJWN/12iD1InqG5+HR9jsd40hYfEo33zshmPi/dh5NJsFgofxt
 F0HcdqmtTJB2fnd2QpHhcGY6VUjX8xxWygEJ3mhlEo6JcKRESKAjKFlQ2gzwIyzPIQYtOJszV
 QrBxmaXuDfTwDK9epQ3fVMxQFnTC08RwJUsKdYLBtiyZnXm44dI70506qD6W1MBbCk0e8zJc2
 bYuxDShm1URyZaLLwajclBw2ydS5ttx6sCaYwgkJ5w/So6zrR1H3LXctf2VA9g2QGREvwJWPM
 x5Bl2DCeloqdbZ6LnrCc/W2lwoKVjn/lnGzhkIvrKQurgt7wBa5MDuxWjT+g28MuFxu5Okf1Q
 7OTcmql5l1rSkyMT6JbUWm91cG4DJH8Rd3WGNyqdO1aYtQTgrYD86SHCA9WFNnzJDNzhKpiPo
 cl/mpaLwNNFnUOXYt55oOCKwVEeISFhRNipm+XhtPQnS6l9b/v+NMvP9e0e2d7NcRHamN/C0B
 8t453Nrca07jRqY7PU/Aih9RTb8Rbkglbyo7GUwOH8xtBpq7rxFa0pI9J3/k3B3679xXhi/7d
 hTcquCSTRx4MQXsxSTx018pVqXY6t8GTJDHLOeZq+nN9CZeRhx4gEQYiYIjWeji9JnsgqSvYw
 lTSLfBn8nvQ652G2ji3E5VZCTcncz2SM2NecUUMn7D1CJF0V+fPZIOPVdWe5mqFht0Y+LtNEl
 Yya+D5hP8/a/vFPGfs0uZk9kdJnyCMCH5u5F/pQAxSYcgXl1Xb5sLY94r7IB7yiMgQsPKYtcj
 OTpi1tKo4LsWq/vdboY4FsCuqUNN2XcVMVGSbRNoV5D+KWfFM+X6y57A3ELIaeLN263ruMj9W
 sGrK3prqGtcyjv1MNFaqbc9ODvmPJ8IBLtq3yDQ66YENTM/bMKb2lf8M3K6P9Y+qwQEjTCjt1
 h/uSWQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

below is the manual backport of an upstream patch to fix the build failure
in kernel v4.14 in imsttfb.c.

It's not sufficient to just return from init_imstt() as the kernel then
may crash later when it tries to access the non-existent framebuffer or
cmap. Instead return failure to imsttfb_probe() so that the kernel
will skip using that hardware/driver.

Can you please apply this patch to the v4.14 stable queue?

Thanks,
Helge

=2D----------
From: Zheng Wang <zyytlz.wz@163.com>

This is a manual backport of upstream patch c75f5a55061091030a13fef71b9995=
b89bc86213
to fix a build error in imsttfb.c in kernel v4.14.

A use-after-free bug may occur if init_imstt invokes framebuffer_release
and free the info ptr. The caller, imsttfb_probe didn't notice that and
still keep the ptr as private data in pdev.

If we remove the driver which will call imsttfb_remove to make cleanup,
UAF happens.

Fix it by return error code if bad case happens in init_imstt.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 6589d5f0a5a4..eaaa5f1c0f6f 100644
=2D-- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1348,7 +1348,7 @@ static struct fb_ops imsttfb_ops =3D {
 	.fb_ioctl 	=3D imsttfb_ioctl,
 };

-static void init_imstt(struct fb_info *info)
+static int init_imstt(struct fb_info *info)
 {
 	struct imstt_par *par =3D info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1420,7 +1420,7 @@ static void init_imstt(struct fb_info *info)
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
 		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.y=
res, info->var.bits_per_pixel);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}

 	sprintf(info->fix.id, "IMS TT (%s)", par->ramdac =3D=3D IBM ? "IBM" : "T=
VP");
@@ -1460,12 +1460,13 @@ static void init_imstt(struct fb_info *info)
 	if (register_framebuffer(info) < 0) {
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
-		return;
+		return -ENODEV;
 	}

 	tmp =3D (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
 	fb_info(info, "%s frame buffer; %uMB vram; chip version %u\n",
 		info->fix.id, info->fix.smem_len >> 20, tmp);
+	return 0;
 }

 static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id=
 *ent)
@@ -1474,6 +1475,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
 	struct imstt_par *par;
 	struct fb_info *info;
 	struct device_node *dp;
+	int ret;

 	dp =3D pci_device_to_OF_node(pdev);
 	if(dp)
@@ -1525,10 +1527,10 @@ static int imsttfb_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
 	par->cmap_regs_phys =3D addr + 0x840000;
 	par->cmap_regs =3D (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->pseudo_palette =3D par->palette;
-	init_imstt(info);
-
-	pci_set_drvdata(pdev, info);
-	return 0;
+	ret =3D init_imstt(info);
+	if (!ret)
+		pci_set_drvdata(pdev, info);
+	return ret;
 }

 static void imsttfb_remove(struct pci_dev *pdev)
