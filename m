Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9727BDD37
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376729AbjJINIc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376731AbjJINIc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:08:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECCCA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:08:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A90C433C8;
        Mon,  9 Oct 2023 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856910;
        bh=ItbGvLZwItZcu/Z7fVRZS6Rki+jf/xGPuoZvDkZfpFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=libevJ1W4GurzIBE7aWVZ2FbHGQ3hjAByg3V2l7OlWUl5CFc9VpQlGAeV6D/MkUQ5
         4qGFfmNtQqjghzdB4jsQEeflV4i1ToxzPq5PWte5kYp6Ij8w8bOnBNdBM9PGhMLd8Y
         mrP5cRBClb0SFGWATRCciNNe7GWk8s2X4cLALt1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.5 031/163] net: ethernet: mediatek: disable irq before schedule napi
Date:   Mon,  9 Oct 2023 14:59:55 +0200
Message-ID: <20231009130124.862706940@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Marangi <ansuelsmth@gmail.com>

commit fcdfc462881d8acf9db77f483b2c821e286ca97b upstream.

While searching for possible refactor of napi_schedule_prep and
__napi_schedule it was notice that the mtk eth driver disable the
interrupt for rx and tx AFTER napi is scheduled.

While this is a very hard to repro case it might happen to have
situation where the interrupt is disabled and never enabled again as the
napi completes and the interrupt is enabled before.

This is caused by the fact that a napi driven by interrupt expect a
logic with:
1. interrupt received. napi prepared -> interrupt disabled -> napi
   scheduled
2. napi triggered. ring cleared -> interrupt enabled -> wait for new
   interrupt

To prevent this case, disable the interrupt BEFORE the napi is
scheduled.

Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20231002140805.568-1-ansuelsmth@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3036,8 +3036,8 @@ static irqreturn_t mtk_handle_irq_rx(int
 
 	eth->rx_events++;
 	if (likely(napi_schedule_prep(&eth->rx_napi))) {
-		__napi_schedule(&eth->rx_napi);
 		mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+		__napi_schedule(&eth->rx_napi);
 	}
 
 	return IRQ_HANDLED;
@@ -3049,8 +3049,8 @@ static irqreturn_t mtk_handle_irq_tx(int
 
 	eth->tx_events++;
 	if (likely(napi_schedule_prep(&eth->tx_napi))) {
-		__napi_schedule(&eth->tx_napi);
 		mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
+		__napi_schedule(&eth->tx_napi);
 	}
 
 	return IRQ_HANDLED;


