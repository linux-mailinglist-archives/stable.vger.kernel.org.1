Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D367ED18F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbjKOUCe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344242AbjKOUCa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:02:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE85197
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:02:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB424C433CC;
        Wed, 15 Nov 2023 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078541;
        bh=ZSnzh2u25LsA6nKXTOFSlbM4lJXYnVtdqyiVVj04rik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdOx+fnvzxWIyAZgYmUvo9thEJr+6DBeOIoLGomHFNmR2vaEUNDrUiTst5MjmK55E
         1oZi7mAFgEZPtRP6qbPf7h9Ak2QMbBv+iKWlmI/AA7L/GcZHUcvsy3RZf8APL7nf7f
         tinkKi/1iVt6/PCczu9V4136ebFfjuqV2B3lDnTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 361/379] r8169: respect userspace disabling IFF_MULTICAST
Date:   Wed, 15 Nov 2023 14:27:16 -0500
Message-ID: <20231115192706.512897891@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index c56d3538889b6..d14706265d9cb 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2512,6 +2512,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
 
 	if (dev->flags & IFF_PROMISC) {
 		rx_mode |= AcceptAllPhys;
+	} else if (!(dev->flags & IFF_MULTICAST)) {
+		rx_mode &= ~AcceptMulticast;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
 		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
-- 
2.42.0



