Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4E79B85A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjIKUub (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242257AbjIKP0H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:26:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3541CDB
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:26:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B30DC433C7;
        Mon, 11 Sep 2023 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445962;
        bh=nRlZehmUpsolvezhtgjf5e0aJNhcYggbKWUG57sVAVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4Ji8z3xDMCGgHvyOE/SmgEGeSdyEAkT33tWRGrhioxU8B49V006dAR2s/XMmkM8m
         B/ObviNccQ9QhO3Nbvm2dQurvVUOjX+QlSWfqmi6epV67ZKtUVU1kX2NUV8igv27XC
         XvAO7FXgRYqCCsb4B3AIoXP68MGxauUQ3qTlu3SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.1 533/600] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address
Date:   Mon, 11 Sep 2023 15:49:26 +0200
Message-ID: <20230911134649.361532385@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rick Wertenbroek <rick.wertenbroek@gmail.com>

commit cdb50033dd6dfcf02ae3d4ee56bc1a9555be6d36 upstream.

A 32-bit mask was used on the 64-bit PCI address used for mapping MSIs.
This would result in the upper 32 bits being unintentionally zeroed and
MSIs getting mapped to incorrect PCI addresses if the address had any
of the upper bits set.

Replace 32-bit mask by appropriate 64-bit mask.

[kwilczynski: use GENMASK_ULL() over GENMASK() for 32-bit compatibility]
Fixes: dc73ed0f1b8b ("PCI: rockchip: Fix window mapping and address translation for endpoint")
Closes: https://lore.kernel.org/linux-pci/8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain
Link: https://lore.kernel.org/linux-pci/20230703085845.2052008-1-rick.wertenbroek@gmail.com
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-rockchip.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -158,7 +158,9 @@
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
 
-#define PCIE_ADDR_MASK			0xffffff00
+#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
+#define MIN_AXI_ADDR_BITS_PASSED		8
+#define PCIE_ADDR_MASK			GENMASK_ULL(63, MIN_AXI_ADDR_BITS_PASSED)
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
 #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
 #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
@@ -185,8 +187,6 @@
 #define AXI_WRAPPER_TYPE1_CFG			0xb
 #define AXI_WRAPPER_NOR_MSG			0xc
 
-#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
-#define MIN_AXI_ADDR_BITS_PASSED		8
 #define PCIE_RC_SEND_PME_OFF			0x11960
 #define ROCKCHIP_VENDOR_ID			0x1d87
 #define PCIE_LINK_IS_L2(x) \


