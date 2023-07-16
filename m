Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0085B755680
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjGPUvP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjGPUvM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02BD9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 196DD60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2014FC433C7;
        Sun, 16 Jul 2023 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540666;
        bh=/V99vQXkdA/BtrYVvoFILgfDWPNyj0SQ8bYZf7cULfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XunAhSOEYqu3d1rkqFlZwkE6PhW+mxhyrhGeVCJed2Qa/pM63Uskv7NtspvdkAdei
         gQb0j6wUPxPURCjH3HA4tY/rwyo6m41bCF0xPiHAS3YE7QVOEmgglWP/TIWEWGa4B0
         yHmmf+LTw9d5n/l67y+Sqw3B0NQYrNTSUzXB+OpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 445/591] bus: fsl-mc: dont assume child devices are all fsl-mc devices
Date:   Sun, 16 Jul 2023 21:49:44 +0200
Message-ID: <20230716194935.421065473@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

[ Upstream commit 303c9c63abb9390e906052863f82bb4e9824e5c0 ]

Changes in VFIO caused a pseudo-device to be created as child of
fsl-mc devices causing a crash [1] when trying to bind a fsl-mc
device to VFIO. Fix this by checking the device type when enumerating
fsl-mc child devices.

[1]
Modules linked in:
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
CPU: 6 PID: 1289 Comm: sh Not tainted 6.2.0-rc5-00047-g7c46948a6e9c #2
Hardware name: NXP Layerscape LX2160ARDB (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mc_send_command+0x24/0x1f0
lr : dprc_get_obj_region+0xfc/0x1c0
sp : ffff80000a88b900
x29: ffff80000a88b900 x28: ffff48a9429e1400 x27: 00000000000002b2
x26: ffff48a9429e1718 x25: 0000000000000000 x24: 0000000000000000
x23: ffffd59331ba3918 x22: ffffd59331ba3000 x21: 0000000000000000
x20: ffff80000a88b9b8 x19: 0000000000000000 x18: 0000000000000001
x17: 7270642f636d2d6c x16: 73662e3030303030 x15: ffffffffffffffff
x14: ffffd59330f1d668 x13: ffff48a8727dc389 x12: ffff48a8727dc386
x11: 0000000000000002 x10: 00008ceaf02f35d4 x9 : 0000000000000012
x8 : 0000000000000000 x7 : 0000000000000006 x6 : ffff80000a88bab0
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80000a88b9e8
x2 : ffff80000a88b9e8 x1 : 0000000000000000 x0 : ffff48a945142b80
Call trace:
 mc_send_command+0x24/0x1f0
 dprc_get_obj_region+0xfc/0x1c0
 fsl_mc_device_add+0x340/0x590
 fsl_mc_obj_device_add+0xd0/0xf8
 dprc_scan_objects+0x1c4/0x340
 dprc_scan_container+0x38/0x60
 vfio_fsl_mc_probe+0x9c/0xf8
 fsl_mc_driver_probe+0x24/0x70
 really_probe+0xbc/0x2a8
 __driver_probe_device+0x78/0xe0
 device_driver_attach+0x30/0x68
 bind_store+0xa8/0x130
 drv_attr_store+0x24/0x38
 sysfs_kf_write+0x44/0x60
 kernfs_fop_write_iter+0x128/0x1b8
 vfs_write+0x334/0x448
 ksys_write+0x68/0xf0
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x44/0x108
 el0_svc_common.constprop.1+0x94/0xf8
 do_el0_svc+0x38/0xb0
 el0_svc+0x20/0x50
 el0t_64_sync_handler+0x98/0xc0
 el0t_64_sync+0x174/0x178
Code: aa0103f4 a9025bf5 d5384100 b9400801 (79401260)
---[ end trace 0000000000000000 ]---

Fixes: 3c28a76124b2 ("vfio: Add struct device to vfio_device")
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Message-ID: <20230613160718.29500-1-laurentiu.tudor@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/fsl-mc/dprc-driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 5e70f9775a0e3..d1e2d2987dd38 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -46,6 +46,9 @@ static int __fsl_mc_device_remove_if_not_in_mc(struct device *dev, void *data)
 	struct fsl_mc_child_objs *objs;
 	struct fsl_mc_device *mc_dev;
 
+	if (!dev_is_fsl_mc(dev))
+		return 0;
+
 	mc_dev = to_fsl_mc_device(dev);
 	objs = data;
 
@@ -65,6 +68,9 @@ static int __fsl_mc_device_remove_if_not_in_mc(struct device *dev, void *data)
 
 static int __fsl_mc_device_remove(struct device *dev, void *data)
 {
+	if (!dev_is_fsl_mc(dev))
+		return 0;
+
 	fsl_mc_device_remove(to_fsl_mc_device(dev));
 	return 0;
 }
-- 
2.39.2



