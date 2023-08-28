Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39278AA75
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjH1KWS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjH1KWJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA0312D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A926390A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FECC433C8;
        Mon, 28 Aug 2023 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218107;
        bh=4reE90F1eYhI4SK7PaSeQ7QPQgnJJOMQJh5LMwA5+d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAg7fwKxisw0huLYO+TTYY6QAZ088zbdyu2FCQ7WxQJTud1cx8fhe43UG7uBL9K56
         dflnw0IKbn8kc4RnCZvhBX8wFwe8qsPS7JFuXkwTWpzRPwuoByn8paZi6OsIhRgCzW
         0cix1lRHc26fRhKjPxPTheqGY4NKXjG/FbsieU7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com,
        Sven Eckelmann <sven@narfation.org>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 097/129] batman-adv: Hold rtnl lock during MTU update via netlink
Date:   Mon, 28 Aug 2023 12:12:56 +0200
Message-ID: <20230828101200.568887579@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 987aae75fc1041072941ffb622b45ce2359a99b9 upstream.

The automatic recalculation of the maximum allowed MTU is usually triggered
by code sections which are already rtnl lock protected by callers outside
of batman-adv. But when the fragmentation setting is changed via
batman-adv's own batadv genl family, then the rtnl lock is not yet taken.

But dev_set_mtu requires that the caller holds the rtnl lock because it
uses netdevice notifiers. And this code will then fail the check for this
lock:

  RTNL: assertion failed at net/core/dev.c (1953)

Cc: stable@vger.kernel.org
Reported-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
Fixes: c6a953cce8d0 ("batman-adv: Trigger events for auto adjusted MTU")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/netlink.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -495,7 +495,10 @@ static int batadv_netlink_set_mesh(struc
 		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
 
 		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+
+		rtnl_lock();
 		batadv_update_min_mtu(bat_priv->soft_iface);
+		rtnl_unlock();
 	}
 
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {


