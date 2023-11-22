Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9F7F4FFC
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 19:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjKVSyo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 13:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVSyn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 13:54:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A491
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 10:54:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE0EC433C8;
        Wed, 22 Nov 2023 18:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700679279;
        bh=CDDhdqXj90zij1OI03ZAdp72w9Guq+xRS8BFXvA33AY=;
        h=Subject:To:Cc:From:Date:From;
        b=z+GD1aibTAx59LGr79i1Yeo/C2lho9sV4qridF5uuzVsX3ini+9kYjSSgeBIuavHI
         ijMcUa5pdEjGe1KWpwxVPVjh8jOM0o3wp7aPtWuCS23yoi61UoWMRg/yrwGPRPrF0j
         VM1wiWrKUDt7YUMsXRc8GTIIDLf94Pbdx90xp4Q8=
Subject: FAILED: patch "[PATCH] PCI: keystone: Don't discard .remove() callback" failed to apply to 4.14-stable tree
To:     u.kleine-koenig@pengutronix.de, bhelgaas@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 18:54:36 +0000
Message-ID: <2023112236-scone-stinking-706f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 200bddbb3f5202bbce96444fdc416305de14f547
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112236-scone-stinking-706f@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

200bddbb3f52 ("PCI: keystone: Don't discard .remove() callback")
49229238ab47 ("PCI: keystone: Cleanup PHY handling")
b51a625b784a ("PCI: keystone: Use SYSCON APIs to get device ID from control module")
b492aca35c98 ("PCI: keystone: Merge pci-keystone-dw.c and pci-keystone.c")
1f79f98f0575 ("PCI: keystone: Remove unused argument from ks_dw_pcie_host_init()")
00a2c4094f8e ("PCI: keystone: Use quirk to set MRRS for PCI host bridge")
6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller/")
e52d38f4abf4 ("Merge branch 'lorenzo/pci/rockchip'")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 200bddbb3f5202bbce96444fdc416305de14f547 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Sun, 1 Oct 2023 19:02:53 +0200
Subject: [PATCH] PCI: keystone: Don't discard .remove() callback
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With CONFIG_PCIE_KEYSTONE=y and ks_pcie_remove() marked with __exit, the
function is discarded from the driver. In this case a bound device can
still get unbound, e.g via sysfs. Then no cleanup code is run resulting in
resource leaks or worse.

The right thing to do is do always have the remove callback available.
Note that this driver cannot be compiled as a module, so ks_pcie_remove()
was always discarded before this change and modpost couldn't warn about
this issue. Furthermore the __ref annotation also prevents a warning.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Link: https://lore.kernel.org/r/20231001170254.2506508-4-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 49aea6ce3e87..eb3fa17b243f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1302,7 +1302,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
@@ -1320,7 +1320,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 
 static struct platform_driver ks_pcie_driver __refdata = {
 	.probe  = ks_pcie_probe,
-	.remove = __exit_p(ks_pcie_remove),
+	.remove = ks_pcie_remove,
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = ks_pcie_of_match,

