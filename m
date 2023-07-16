Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103217551B4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGPT7V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjGPT7U (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24521B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75AF960EB7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3C6C433C7;
        Sun, 16 Jul 2023 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537557;
        bh=n/nPPCASgNPtiiRJvsdOWFOszVPSlUKJjEtpxQ4+EaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrwITgNhqa4p5QZV43FD56tOvHYoaRFsQjfDFOzkuE8cmEo2bihQO2PQFSDA0weHi
         Wt4vmjafWVRMWc9+QVz6XeS3awx9+JxuGZBltgdwnEle2/lUEKXQ93yy1TrWCX2C0D
         Au4w4thA1yBiJx5IhiRPm0mTHY2Z0OOJl8VLSN5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 138/800] wifi: rtw88: usb: silence log flooding error message
Date:   Sun, 16 Jul 2023 21:39:51 +0200
Message-ID: <20230716194952.302696844@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit 1f1784a59caf3eefd127908a1a3cf224017ff9c7 ]

When receiving more rx packets than the kernel can handle the driver
drops the packets and issues an error message. This is bad for two
reasons. The logs are flooded with myriads of messages, but then time
consumed for printing messages in that critical code path brings down
the device. After some time of excessive rx load the driver responds
with:

rtw_8822cu 1-1:1.2: failed to get tx report from firmware
rtw_8822cu 1-1:1.2: firmware failed to report density after scan
rtw_8822cu 1-1:1.2: firmware failed to report density after scan

The device stops working until being replugged.

Fix this by lowering the priority to debug level and also by
ratelimiting it.

Fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230524103934.1019096-1-s.hauer@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 44a5fafb99055..976eafa739a2d 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -535,7 +535,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 		}
 
 		if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
-			rtw_err(rtwdev, "failed to get rx_queue, overflow\n");
+			dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
 			dev_kfree_skb_any(skb);
 			continue;
 		}
-- 
2.39.2



