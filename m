Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB127A7DA2
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjITMKw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjITMKr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:10:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD7D8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:10:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF8BC433C9;
        Wed, 20 Sep 2023 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211839;
        bh=7OTnmHECHLYoQFzH81PtQDAuoFXvltMDqWy1QBoG6ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEmA1UyYbXA1uqIt3Jir46ouOrNi+bmtW+xFLEbHwA3qo6pI/FwkS3NmaBXChvLIH
         USdSjpmk+XSVQ0bz8/V4UCOL3PfvzY/OXS/l7i5+5uaZxQE7rQb7OinYx9bTMt/xt1
         Mz+WMXh5vMGHFmgAYraan6TWs/gyCQ2YwfX7A/L8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/273] can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM
Date:   Wed, 20 Sep 2023 13:28:14 +0200
Message-ID: <20230920112848.100596697@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 6c8bc15f02b85bc8f47074110d8fd8caf7a1e42d ]

In case of an RX overflow error from the CAN controller and an OOM
where no skb can be allocated, the error counters are not incremented.

Fix this by first incrementing the error counters and then allocate
the skb.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Link: https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-7-c3b9154ec605@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/gs_usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b2e48c8595f0f..fd80af775ec75 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -389,6 +389,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
 			goto resubmit_urb;
@@ -396,8 +399,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->can_dlc = CAN_ERR_DLC;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-		stats->rx_over_errors++;
-		stats->rx_errors++;
 		netif_rx(skb);
 	}
 
-- 
2.40.1



