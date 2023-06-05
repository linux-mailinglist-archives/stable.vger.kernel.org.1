Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57897229E5
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjFEOy6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjFEOys (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 10:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB7FA7
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 07:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C792762647
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 14:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0480C433A4;
        Mon,  5 Jun 2023 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685976885;
        bh=V41ptCeIreFPH8d6+AmBzshpP/Ek0ROslMR8DnsJmFg=;
        h=Subject:To:Cc:From:Date:From;
        b=CrK0So2cOKhhG+YoXjBAEh5rL3MFFN8MdOTZWlJfAIvlFrJa5I/sR1T+XB6hLHtJf
         42KufN7HUM0TCcyTlVlLrwGn+LrgdcqKVKn7LhV2vX0RTE47x8KOMeVRSvB4fhRQZY
         LAuTLaO98OTiLmGCWUefaWUp8D1vvfnFRDTV1ygs=
Subject: FAILED: patch "[PATCH] usb: cdns3: fix NCM gadget RX speed 20x slow than expection" failed to apply to 5.10-stable tree
To:     Frank.Li@nxp.com, gregkh@linuxfoundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 05 Jun 2023 16:54:34 +0200
Message-ID: <2023060534-finicky-backyard-49cc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x dbe678f6192f27879ac9ff6bc7a1036aad85aae9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060534-finicky-backyard-49cc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbe678f6192f27879ac9ff6bc7a1036aad85aae9 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 May 2023 11:49:45 -0400
Subject: [PATCH] usb: cdns3: fix NCM gadget RX speed 20x slow than expection
 at iMX8QM

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

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index ccfaebca6faa..1dcadef933e3 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2097,6 +2097,19 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
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

