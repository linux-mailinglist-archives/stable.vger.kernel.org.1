Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6117F4FFF
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 19:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbjKVSzM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 13:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbjKVSzL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 13:55:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6E2D5A
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 10:55:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101C3C433C9;
        Wed, 22 Nov 2023 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700679307;
        bh=MoJtgl9C3OGKVrne8hkaGWjuWlbDHvFrDYrvEWTspCU=;
        h=Subject:To:Cc:From:Date:From;
        b=GIcWipiifSzLvF+kGIqNlgWjZZTy0MMkFsFnTFt2CuJ9ZwXn4WYshwHeduA7wcb6P
         GPkP+xcfwSxdF3JoSp05sptkwTyG47WB4JMCM8H5Kz6S3k7rbm0YG3DEqsRo1elX8O
         egGcGaHXce8tMK3X/rkuD6fM70bC80dG/738NT7M=
Subject: FAILED: patch "[PATCH] PCI: keystone: Don't discard .probe() callback" failed to apply to 4.14-stable tree
To:     u.kleine-koenig@pengutronix.de, bhelgaas@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 18:55:04 +0000
Message-ID: <2023112204-jeeringly-remake-6ff6@gregkh>
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
git cherry-pick -x 7994db905c0fd692cf04c527585f08a91b560144
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112204-jeeringly-remake-6ff6@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

7994db905c0f ("PCI: keystone: Don't discard .probe() callback")
18b0415bc802 ("PCI: keystone: Add support for PCIe RC in AM654x Platforms")
156c6fef75a4 ("PCI: keystone: Explicitly set the PCIe mode")
b1dee41b7692 ("PCI: keystone: Move resources initialization to prepare for EP support")
2341ab4fd5d7 ("PCI: keystone: Use platform_get_resource_byname() to get memory resources")
f3560a9f88ae ("PCI: keystone: Perform host initialization in a single function")
0790eb175ee0 ("PCI: keystone: Cleanup error_irq configuration")
1146c2953dcb ("PCI: keystone: Add separate functions for configuring MSI and legacy interrupt")
1beb55126937 ("PCI: keystone: Cleanup interrupt related macros")
261de72f0169 ("PCI: keystone: Cleanup macros defined in pci-keystone.c")
c0b8558648c2 ("PCI: keystone: Reorder header file in alphabetical order")
daaaa665ca01 ("PCI: keystone: Add debug error message for all errors")
0523cdc6e775 ("PCI: keystone: Use ERR_IRQ_STATUS instead of ERR_IRQ_STATUS_RAW to get interrupt status")
23fe5bd4be90 ("PCI: keystone: Cleanup ks_pcie_link_up()")
f9127db9fbad ("PCI: keystone: Cleanup set_dbi_mode() and get_dbi_mode()")
e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
b4f1af8352fd ("PCI: keystone: Get number of outbound windows from DT")
44c747af2be7 ("PCI: keystone: Cleanup configuration space access")
8047eb55129a ("PCI: keystone: Invoke runtime PM APIs to enable clock")
49229238ab47 ("PCI: keystone: Cleanup PHY handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7994db905c0fd692cf04c527585f08a91b560144 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Sun, 1 Oct 2023 19:02:54 +0200
Subject: [PATCH] PCI: keystone: Don't discard .probe() callback
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The __init annotation makes the ks_pcie_probe() function disappear after
booting completes. However a device can also be bound later. In that case,
we try to call ks_pcie_probe(), but the backing memory is likely already
overwritten.

The right thing to do is do always have the probe callback available.  Note
that the (wrong) __refdata annotation prevented this issue to be noticed by
modpost.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Link: https://lore.kernel.org/r/20231001170254.2506508-5-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index eb3fa17b243f..0def919f89fa 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1100,7 +1100,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
 	const struct dw_pcie_ep_ops *ep_ops;
@@ -1318,7 +1318,7 @@ static int ks_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver ks_pcie_driver __refdata = {
+static struct platform_driver ks_pcie_driver = {
 	.probe  = ks_pcie_probe,
 	.remove = ks_pcie_remove,
 	.driver = {

