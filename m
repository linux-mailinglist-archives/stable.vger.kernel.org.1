Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3F775B94
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjHILSv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHILSu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:18:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E311724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A979763194
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA09AC433C9;
        Wed,  9 Aug 2023 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579929;
        bh=9eA43b5hxcwOqZ8FmnCj8mcCmk3oLMDuCQpe1Y0BvpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ge/+x4szG/9B90qp0U51M+luqUlLHyidlf7t7peTG2b3gWVtjmK3A+/FhuxtNq1Q7
         B/byhe1GiKaKiiDFKDJwYtvqI3LxXmEA4bjvOwnxpUwZ0DoJxJP6l4mn0hcz1mzJl1
         uhrqlYVE511xai8g6BkOZo5gP+vmTN9SPVtNc9mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 4.19 165/323] PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
Date:   Wed,  9 Aug 2023 12:40:03 +0200
Message-ID: <20230809103705.703005411@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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

From: Rick Wertenbroek <rick.wertenbroek@gmail.com>

commit 9dd3c7c4c8c3f7f010d9cdb7c3f42506d93c9527 upstream.

The RK3399 PCIe controller should wait until the PHY PLLs are locked.
Add poll and timeout to wait for PHY PLLs to be locked. If they cannot
be locked generate error message and jump to error handler. Accessing
registers in the PHY clock domain when PLLs are not locked causes hang
The PHY PLLs status is checked through a side channel register.
This is documented in the TRM section 17.5.8.1 "PCIe Initialization
Sequence".

Link: https://lore.kernel.org/r/20230418074700.1083505-5-rick.wertenbroek@gmail.com
Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Tested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-rockchip.c |   17 +++++++++++++++++
 drivers/pci/controller/pcie-rockchip.h |    2 ++
 2 files changed, 19 insertions(+)

--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -154,6 +155,12 @@ int rockchip_pcie_parse_dt(struct rockch
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
 
+#define rockchip_pcie_read_addr(addr) rockchip_pcie_read(rockchip, addr)
+/* 100 ms max wait time for PHY PLLs to lock */
+#define RK_PHY_PLL_LOCK_TIMEOUT_US 100000
+/* Sleep should be less than 20ms */
+#define RK_PHY_PLL_LOCK_SLEEP_US 1000
+
 int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
@@ -255,6 +262,16 @@ int rockchip_pcie_init_port(struct rockc
 		}
 	}
 
+	err = readx_poll_timeout(rockchip_pcie_read_addr,
+				 PCIE_CLIENT_SIDE_BAND_STATUS,
+				 regs, !(regs & PCIE_CLIENT_PHY_ST),
+				 RK_PHY_PLL_LOCK_SLEEP_US,
+				 RK_PHY_PLL_LOCK_TIMEOUT_US);
+	if (err) {
+		dev_err(dev, "PHY PLLs could not lock, %d\n", err);
+		goto err_power_off_phy;
+	}
+
 	/*
 	 * Please don't reorder the deassert sequence of the following
 	 * four reset pins.
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -37,6 +37,8 @@
 #define   PCIE_CLIENT_MODE_EP            HIWORD_UPDATE(0x0040, 0)
 #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
 #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
+#define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
+#define   PCIE_CLIENT_PHY_ST			BIT(12)
 #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
 #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
 #define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18


