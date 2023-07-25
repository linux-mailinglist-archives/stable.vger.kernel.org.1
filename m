Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C059761578
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjGYL3V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjGYL3V (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C2F2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0549A6168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5E5C433C7;
        Tue, 25 Jul 2023 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284559;
        bh=Owi/QjIHX5cSUbEgRPggfw458L5ZgqIgxYoPhkQrOII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHr7jnAfj4uJE/ZiHV4QRAsRLzxePLELKZ9EXr6Hngdf6ywNhd/he2+jmGHv/uDOU
         Ue9fab2stwSPvBdi2dZMR086T0pCORDeTYIzdTTP4DHEVvqFkUPFMuYWH7aXrbyYsR
         eKv1+EevTr5ewozt3eGmXZfSvD56bB/av1xG68sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 5.10 399/509] PCI: rockchip: Write PCI Device ID to correct register
Date:   Tue, 25 Jul 2023 12:45:38 +0200
Message-ID: <20230725104612.017197271@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rick Wertenbroek <rick.wertenbroek@gmail.com>

commit 1f1c42ece18de365c976a060f3c8eb481b038e3a upstream.

Write PCI Device ID (DID) to the correct register. The Device ID was not
updated through the correct register. Device ID was written to a read-only
register and therefore did not work. The Device ID is now set through the
correct register. This is documented in the RK3399 TRM section 17.6.6.1.1

Link: https://lore.kernel.org/r/20230418074700.1083505-3-rick.wertenbroek@gmail.com
Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Tested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c |    6 ++++--
 drivers/pci/controller/pcie-rockchip.h    |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -125,6 +125,7 @@ static void rockchip_pcie_prog_ep_ob_atu
 static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 					 struct pci_epf_header *hdr)
 {
+	u32 reg;
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
@@ -137,8 +138,9 @@ static int rockchip_pcie_ep_write_header
 				    PCIE_CORE_CONFIG_VENDOR);
 	}
 
-	rockchip_pcie_write(rockchip, hdr->deviceid << 16,
-			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) + PCI_VENDOR_ID);
+	reg = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_DID_VID);
+	reg = (reg & 0xFFFF) | (hdr->deviceid << 16);
+	rockchip_pcie_write(rockchip, reg, PCIE_EP_CONFIG_DID_VID);
 
 	rockchip_pcie_write(rockchip,
 			    hdr->revid |
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -132,6 +132,8 @@
 #define PCIE_RC_RP_ATS_BASE		0x400000
 #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define   PCIE_RC_CONFIG_SCC_SHIFT		16
 #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)


