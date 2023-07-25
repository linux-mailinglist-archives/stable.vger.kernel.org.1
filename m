Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46951761577
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjGYL3T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjGYL3S (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F74F3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46643616A2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B8CC433C7;
        Tue, 25 Jul 2023 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284556;
        bh=YAsICtfXFfPotbgmsYNMsV3bJgh3ZWlp+EjzFQI6H54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGUs0V3hzgiaafdVgtyv7oWd6sjpCldkDRMmceGBfLk2MIwJyD3fMDobXpfYRhbZ7
         SUpsWlY9oz7FRFsHO6TiX6SizHvWHVHZcS71BnkiLbZXCCg3sqz5Y6vCONuxmZTdoR
         zV+GxBZkKId7MrFlA5y7W9tRG6paudmBrG2gEZqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 5.10 398/509] PCI: rockchip: Assert PCI Configuration Enable bit after probe
Date:   Tue, 25 Jul 2023 12:45:37 +0200
Message-ID: <20230725104611.975177517@linuxfoundation.org>
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


