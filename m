Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A437ECB9C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjKOTXX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjKOTXW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB241A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F724C433C7;
        Wed, 15 Nov 2023 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076198;
        bh=JDckLiF4Fav6xzJCXN7fS+kXPABwk9142Uk4avtRk3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HH6flqpkwsCErtx0pAO0c+JWinRNZBIkf2tEnCuIvf3k89wgWhX4CDs/Hwql00ufp
         iaIc09z3NoPUbtQQiOLHtikiw1uGuqcHcQRVe/gtOoWAks40bT0GYalCav2i8DGHRj
         yOS7xJpkJL7+TStjVZkrwqJ3pR3WOyPAGT6lUvjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 113/550] wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()
Date:   Wed, 15 Nov 2023 14:11:37 -0500
Message-ID: <20231115191608.528138190@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit de8dd096949820ce5656d41ce409a67603e79327 ]

Both usb_kill_urb() and usb_free_urb() do the NULL check itself, so there
is no need to duplicate it prior to calling.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231008025852.1239450-1-ruanjinjie@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index c279a500b4bdb..a34bc355fa13d 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -628,8 +628,7 @@ static void rtw_usb_cancel_rx_bufs(struct rtw_usb *rtwusb)
 
 	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
 		rxcb = &rtwusb->rx_cb[i];
-		if (rxcb->rx_urb)
-			usb_kill_urb(rxcb->rx_urb);
+		usb_kill_urb(rxcb->rx_urb);
 	}
 }
 
@@ -640,10 +639,8 @@ static void rtw_usb_free_rx_bufs(struct rtw_usb *rtwusb)
 
 	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
 		rxcb = &rtwusb->rx_cb[i];
-		if (rxcb->rx_urb) {
-			usb_kill_urb(rxcb->rx_urb);
-			usb_free_urb(rxcb->rx_urb);
-		}
+		usb_kill_urb(rxcb->rx_urb);
+		usb_free_urb(rxcb->rx_urb);
 	}
 }
 
-- 
2.42.0



