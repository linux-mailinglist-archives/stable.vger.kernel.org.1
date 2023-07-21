Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6511375D29B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGUTBj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjGUTBh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8430DF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A517D61D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A5EC433C8;
        Fri, 21 Jul 2023 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966095;
        bh=6cGkrUU7LDYQ8nN+eo2Fq2xw0LwJDH2xOA/LZ3KJo8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHCGXJ2Zf+TtItxcBs49flNeTdsMnk38WmiZ80A33aLjeiC+bIQfuNEr4h0DMADGx
         eV39N928NBi5pEzZ9PASsShtSjdr92e7LQrvXC8ldNX+j8VPOtoGSZfMDPEg5mERMo
         InQgglsX1lStN9arce7rtGhW7bFf9PF6U9YUBoSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 194/532] PCI: vmd: Reset VMD config register between soft reboots
Date:   Fri, 21 Jul 2023 18:01:38 +0200
Message-ID: <20230721160624.928929485@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

From: Nirmal Patel <nirmal.patel@linux.intel.com>

[ Upstream commit b61cf04c49c3dfa70a0d6725d3eb40bf9b35cf71 ]

VMD driver can disable or enable MSI remapping by changing
VMCONFIG_MSI_REMAP register. This register needs to be set to the
default value during soft reboots. Drives failed to enumerate
when Windows boots after performing a soft reboot from Linux.
Windows doesn't support MSI remapping disable feature and stale
register value hinders Windows VMD driver initialization process.
Adding vmd_shutdown function to make sure to set the VMCONFIG
register to the default value.

Link: https://lore.kernel.org/r/20230224202811.644370-1-nirmal.patel@linux.intel.com
Fixes: ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8dce71142e10f..f49001ba96c75 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -881,6 +881,13 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_remove_irq_domain(vmd);
 }
 
+static void vmd_shutdown(struct pci_dev *dev)
+{
+        struct vmd_dev *vmd = pci_get_drvdata(dev);
+
+        vmd_remove_irq_domain(vmd);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int vmd_suspend(struct device *dev)
 {
@@ -946,6 +953,7 @@ static struct pci_driver vmd_drv = {
 	.id_table	= vmd_ids,
 	.probe		= vmd_probe,
 	.remove		= vmd_remove,
+	.shutdown	= vmd_shutdown,
 	.driver		= {
 		.pm	= &vmd_dev_pm_ops,
 	},
-- 
2.39.2



