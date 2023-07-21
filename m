Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498F875D48A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjGUTWR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjGUTWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FA2ED
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1D061D5F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F403C433C7;
        Fri, 21 Jul 2023 19:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967332;
        bh=YAsICtfXFfPotbgmsYNMsV3bJgh3ZWlp+EjzFQI6H54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4GdkVrmp61IwoawxKedEWnIXo5lHTqbMcyoKHaihaqYdeFe+DdRUUc0+vOV2D4en
         +5cBUMx+iAQvi2kgemFLk1uAne91fsUh0oc0nCgQ6Rg9l0XBiSmomngn/LPjuXolxo
         Jnd7+etroxMmZKZdFxTnjPFwrrktNC15ZowmDeY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 6.1 126/223] PCI: rockchip: Assert PCI Configuration Enable bit after probe
Date:   Fri, 21 Jul 2023 18:06:19 +0200
Message-ID: <20230721160526.250404901@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rick Wertenbroek <rick.wertenbroek@gmail.com>

commit f397fd4ac1fa3afcabd8cee030f953ccaed2a364 upstream.

Assert PCI Configuration Enable bit after probe. When this bit is left to
0 in the endpoint mode, the RK3399 PCIe endpoint core will generate
configuration request retry status (CRS) messages back to the root complex.
Assert this bit after probe to allow the RK3399 PCIe endpoint core to reply
to configuration requests from the root complex.
This is documented in section 17.5.8.1.2 of the RK3399 TRM.

Link: https://lore.kernel.org/r/20230418074700.1083505-4-rick.wertenbroek@gmail.com
Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Tested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -631,6 +631,9 @@ static int rockchip_pcie_ep_probe(struct
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
+			    PCIE_CLIENT_CONFIG);
+
 	return 0;
 err_epc_mem_exit:
 	pci_epc_mem_exit(epc);


