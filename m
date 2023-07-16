Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59B87553DA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGPUXl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGPUXk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1146E9F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3D2960E9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FECC433C7;
        Sun, 16 Jul 2023 20:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539019;
        bh=C0xkU8zMyJ2RmmLy32ucEI2jbZBJp14vEhOEqQbKIJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uzm8LZ6dMgsDBal5jWd0bmPo3+jYZr6XDFLrFpIjqTD4yGiLopy3xfnrJhwYoZSWh
         95RM7q2KCfyVfCWsz8hpIQSQ52dZM5PNYmjqXCKGMnQAUzkuZXacVbRwEjPnMfltoo
         GSJYo2RDn+bakjt4XXqADpGVOpOr3wJSlX2uOok0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nipun Gupta <nipun.gupta@amd.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 628/800] cdx: fix driver managed dma support
Date:   Sun, 16 Jul 2023 21:48:01 +0200
Message-ID: <20230716195003.698272180@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nipun Gupta <nipun.gupta@amd.com>

[ Upstream commit b8c5ff76059ded3758de3db83e04189a072ac01f ]

The devices on cdx could be bound to drivers with the device
DMA managed by kernel drivers or user-space applications.
As multiple devices can be placed in the same IOMMU group, the
DMA on these devices must either be entirely under kernel control
or userspace control. Fix the CDX bus driver to acknowlege the
driver_managed_dma flag and call the appropriate iommu APIs.

Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: https://lore.kernel.org/lkml/20230524134831.28dc97e2.alex.williamson@redhat.com/
Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Message-ID: <20230605131009.6869-1-nipun.gupta@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cdx/cdx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 38511fd363257..d2cad4c670a07 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -62,6 +62,8 @@
 #include <linux/mm.h>
 #include <linux/xarray.h>
 #include <linux/cdx/cdx_bus.h>
+#include <linux/iommu.h>
+#include <linux/dma-map-ops.h>
 #include "cdx.h"
 
 /* Default DMA mask for devices on a CDX bus */
@@ -257,6 +259,7 @@ static void cdx_shutdown(struct device *dev)
 
 static int cdx_dma_configure(struct device *dev)
 {
+	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
 	u32 input_id = cdx_dev->req_id;
 	int ret;
@@ -267,9 +270,23 @@ static int cdx_dma_configure(struct device *dev)
 		return ret;
 	}
 
+	if (!ret && !cdx_drv->driver_managed_dma) {
+		ret = iommu_device_use_default_domain(dev);
+		if (ret)
+			arch_teardown_dma_ops(dev);
+	}
+
 	return 0;
 }
 
+static void cdx_dma_cleanup(struct device *dev)
+{
+	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
+
+	if (!cdx_drv->driver_managed_dma)
+		iommu_device_unuse_default_domain(dev);
+}
+
 /* show configuration fields */
 #define cdx_config_attr(field, format_string)	\
 static ssize_t	\
@@ -405,6 +422,7 @@ struct bus_type cdx_bus_type = {
 	.remove		= cdx_remove,
 	.shutdown	= cdx_shutdown,
 	.dma_configure	= cdx_dma_configure,
+	.dma_cleanup	= cdx_dma_cleanup,
 	.bus_groups	= cdx_bus_groups,
 	.dev_groups	= cdx_dev_groups,
 };
-- 
2.39.2



