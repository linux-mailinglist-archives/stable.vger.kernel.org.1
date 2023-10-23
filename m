Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBF7D3116
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjJWLFZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjJWLFX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:05:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A89510CA
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:05:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC815C433C8;
        Mon, 23 Oct 2023 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059121;
        bh=vz7sWriVUYyP2TIxIyaIGlvSI7s9Eq/Q4Dp2ZRD0vWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ro0Mrc7Cxpm6nGjriWb1rzyVUZASLdt3ds1v0sVKRGGtpNkU2O543c17P29NCP7+S
         WG5btmzHPolDObHmADhztogwZhzHQtFdsM27LMy5JRuB7qrdhjT47QY/1fb0x2GczF
         9cGW3tTkvvWS0Q5Zxg1qgPonasE5GxatBJB7LWGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 071/241] net: usb: smsc95xx: Fix an error code in smsc95xx_reset()
Date:   Mon, 23 Oct 2023 12:54:17 +0200
Message-ID: <20231023104835.626544347@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

commit c53647a5df9e66dd9fedf240198e1fe50d88c286 upstream.

Return a negative error code instead of success.

Fixes: 2f7ca802bdae ("net: Add SMSC LAN9500 USB2.0 10/100 ethernet adapter driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/147927f0-9ada-45cc-81ff-75a19dd30b76@moroto.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/smsc95xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -897,7 +897,7 @@ static int smsc95xx_reset(struct usbnet
 
 	if (timeout >= 100) {
 		netdev_warn(dev->net, "timeout waiting for completion of Lite Reset\n");
-		return ret;
+		return -ETIMEDOUT;
 	}
 
 	ret = smsc95xx_set_mac_address(dev);


