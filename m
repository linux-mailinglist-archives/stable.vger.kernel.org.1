Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8076AF24
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjHAJpT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjHAJpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D9BE67
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2967614FD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9EDC433C7;
        Tue,  1 Aug 2023 09:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882994;
        bh=HF6LJzTsgj8wqrivNMyfSoNxfQIBKK01D4RgUqrW7cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5QoXiL26b+ZkGHoUh0TZx1jBK4hOKpeSqFaxRI47PCWpt/wQuCcI89bMcp9ZM6jg
         FAD1bUcczkKzSuEhBL/1a1Rb4zlS9Kheco8LpqOnL+VuDDQZpHEgn2d5jV0eStxq5m
         mM1SYX6VaGn5VJDyhDNZBOXp1i0DvhLJBQDF2ioA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 077/239] net: fec: avoid tx queue timeout when XDP is enabled
Date:   Tue,  1 Aug 2023 11:19:01 +0200
Message-ID: <20230801091928.481935768@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit bb7a0156365dffe2fcd63e2051145fbe4f8908b4 ]

According to the implementation of XDP of FEC driver, the XDP path
shares the transmit queues with the kernel network stack, so it is
possible to lead to a tx timeout event when XDP uses the tx queue
pretty much exclusively. And this event will cause the reset of the
FEC hardware.
To avoid timeout in this case, we use the txq_trans_cond_update()
interface to update txq->trans_start to jiffies so that watchdog
won't generate a transmit timeout warning.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Link: https://lore.kernel.org/r/20230721083559.2857312-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7659888a96917..a1b0abe54a0e5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3908,6 +3908,8 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 
 	__netif_tx_lock(nq, cpu);
 
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
 	for (i = 0; i < num_frames; i++) {
 		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) != 0)
 			break;
-- 
2.39.2



