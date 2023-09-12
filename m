Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5895879AF1B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjIKUxj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbjIKOgT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC53F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059D1C433C8;
        Mon, 11 Sep 2023 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442974;
        bh=VBS+QXAL3inaCLRDVb8/E1fRSp6iJ6QTkaSIBD4Fdy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyClLwDzvwxsCMxgj0g+MeZ159VQg8pASAACTbfn6DgKRN06FEuziYpBDfyIaxXfV
         QUo8vrmT+rrwl4gHYMUyLSKTsKI+pWHihR0eNnQnjwor13zlqfH1CmP0saOCDaxsHD
         cRiaO3hkk77FEtk71Gthj8JqDlpNrW6jCaTdbpSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 176/737] can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM
Date:   Mon, 11 Sep 2023 15:40:35 +0200
Message-ID: <20230911134655.453430561@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index bd9eb066ecf15..129ef60a577c8 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -633,6 +633,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
 			goto resubmit_urb;
@@ -640,8 +643,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->len = CAN_ERR_DLC;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-		stats->rx_over_errors++;
-		stats->rx_errors++;
 		netif_rx(skb);
 	}
 
-- 
2.40.1



