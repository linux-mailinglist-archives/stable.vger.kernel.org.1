Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5EF7ED6F5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbjKOWEh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344425AbjKOWEg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:04:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FAD19B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:04:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C382C433C8;
        Wed, 15 Nov 2023 22:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085872;
        bh=PvbB4Y/1xh5+MJrTUnX7Cdrp91l6j4ivUy1miRTzGMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4PoQJnnOwnNv+dQ90tOsDmQxSmIDB9zvCGt3hJ/7uphPrcxXMCu7FQCzhTWwJHw5
         kxPLbArPy+tgwqntwJ6sVGrHt6p9fuc9vmsVSGg661DNCIbZ2sek9FOGKYu6Om+sRh
         T7FnLckSxuLv73kIyL0qZT2f8gHcbPNxVniuoOSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 109/119] r8169: respect userspace disabling IFF_MULTICAST
Date:   Wed, 15 Nov 2023 17:01:39 -0500
Message-ID: <20231115220136.031810143@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 8999ce4cfc87e61b4143ec2e7b93d8e92e11fa7f ]

So far we ignore the setting of IFF_MULTICAST. Fix this and clear bit
AcceptMulticast if IFF_MULTICAST isn't set.

Note: Based on the implementations I've seen it doesn't seem to be 100% clear
what a driver is supposed to do if IFF_ALLMULTI is set but IFF_MULTICAST
is not. This patch is based on the understanding that IFF_MULTICAST has
precedence.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/4a57ba02-d52d-4369-9f14-3565e6c1f7dc@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d5dba2f04de09..28e2cd9c386a1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4288,6 +4288,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		/* Unconditionally log net taps. */
 		netif_notice(tp, link, dev, "Promiscuous mode enabled\n");
 		rx_mode |= AcceptAllPhys;
+	} else if (!(dev->flags & IFF_MULTICAST)) {
+		rx_mode &= ~AcceptMulticast;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
 		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
-- 
2.42.0



