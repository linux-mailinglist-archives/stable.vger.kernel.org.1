Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9657876D7
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbjHXRUO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbjHXRUB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE69119B7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63E8567553
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FE3C433C7;
        Thu, 24 Aug 2023 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897598;
        bh=v1B70v50PojW958jlZiiCPev4IGMRNVVEmnbt5EGgm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gw7UWLhmvfEsE9hlmkh5zbZ2eUISQi/AD8QLWEbw9/PEA5dbX5JHYlYln8DoocTgx
         IQOHQxJ7EgDDcaF3/tLtFiCVvtdJlSuz8PpvlVCplC+qwBDA8PUuDj+cj3ixEZ1IkR
         vgSMT71JEbv/4Lmy2LIqszkQckUPfLPjQcVYopi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 057/135] usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM
Date:   Thu, 24 Aug 2023 19:08:49 +0200
Message-ID: <20230824170619.649555165@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit dbe678f6192f27879ac9ff6bc7a1036aad85aae9 ]

At iMX8QM platform, enable NCM gadget and run 'iperf3 -s'.
At host, run 'iperf3 -V -c fe80::6863:98ff:feef:3e0%enxc6e147509498'

[  5]   0.00-1.00   sec  1.55 MBytes  13.0 Mbits/sec   90   4.18 KBytes
[  5]   1.00-2.00   sec  1.44 MBytes  12.0 Mbits/sec   75   4.18 KBytes
[  5]   2.00-3.00   sec  1.48 MBytes  12.4 Mbits/sec   75   4.18 KBytes

Expected speed should be bigger than 300Mbits/sec.

The root cause of this performance drop was found to be data corruption
happening at 4K borders in some Ethernet packets, leading to TCP
checksum errors. This corruption occurs from the position
(4K - (address & 0x7F)) to 4K. The u_ether function's allocation of
skb_buff reserves 64B, meaning all RX addresses resemble 0xXXXX0040.

Force trb_burst_size to 16 can fix this problem.

Cc: stable@vger.kernel.org
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20230518154946.3666662-1-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/gadget.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 24dab7006b823..210c1d6150825 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2098,6 +2098,19 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	else
 		priv_ep->trb_burst_size = 16;
 
+	/*
+	 * In versions preceding DEV_VER_V2, for example, iMX8QM, there exit the bugs
+	 * in the DMA. These bugs occur when the trb_burst_size exceeds 16 and the
+	 * address is not aligned to 128 Bytes (which is a product of the 64-bit AXI
+	 * and AXI maximum burst length of 16 or 0xF+1, dma_axi_ctrl0[3:0]). This
+	 * results in data corruption when it crosses the 4K border. The corruption
+	 * specifically occurs from the position (4K - (address & 0x7F)) to 4K.
+	 *
+	 * So force trb_burst_size to 16 at such platform.
+	 */
+	if (priv_dev->dev_ver < DEV_VER_V2)
+		priv_ep->trb_burst_size = 16;
+
 	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
 	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
 	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
-- 
2.40.1



