Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA17D31F1
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjJWLPB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjJWLPA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:15:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D324A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:14:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D956C433C8;
        Mon, 23 Oct 2023 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059698;
        bh=XNwws2NeYFJKLQFdn1vcFeuoUlJDxB3Mq1nRR7yejFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWv823M9ftCU5ASTx61UyoxeBlxjITif5PCtwtkFI3a7x/gOQhLIL1Trd9QEVkr/m
         EHb5ZZXm4YA8aaDdkqXxbv8U0KHj3w/CY6dQu4N47wbShmPAMvbVpCQKr7SYR4aZGT
         8mmOWiwFnZA/VrHG81XoAopBJjmlQPZJxv81A23Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
Subject: [PATCH 4.19 22/98] net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
Date:   Mon, 23 Oct 2023 12:56:11 +0200
Message-ID: <20231023104814.376075835@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 8f8abb863fa5a4cc18955c6a0e17af0ded3e4a76 upstream.

syzbot has found an uninit-value bug triggered by the dm9601 driver [1].

This error happens because the variable res is not updated if the call
to dm_read_shared_word returns an error. In this particular case -EPROTO
was returned and res stayed uninitialized.

This can be avoided by checking the return value of dm_read_shared_word
and propagating the error if the read operation failed.

[1] https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955

Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-and-tested-by: syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
Acked-by: Peter Korsgaard <peter@korsgaard.com>
Fixes: d0374f4f9c35cdfbee0 ("USB: Davicom DM9601 usbnet driver")
Link: https://lore.kernel.org/r/20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/dm9601.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -221,13 +221,18 @@ static int dm9601_mdio_read(struct net_d
 	struct usbnet *dev = netdev_priv(netdev);
 
 	__le16 res;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(dev->net, "Only internal phy supported\n");
 		return 0;
 	}
 
-	dm_read_shared_word(dev, 1, loc, &res);
+	err = dm_read_shared_word(dev, 1, loc, &res);
+	if (err < 0) {
+		netdev_err(dev->net, "MDIO read error: %d\n", err);
+		return err;
+	}
 
 	netdev_dbg(dev->net,
 		   "dm9601_mdio_read() phy_id=0x%02x, loc=0x%02x, returns=0x%04x\n",


