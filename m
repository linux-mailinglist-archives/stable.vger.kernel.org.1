Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD85775D3F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjHILfT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjHILfS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:35:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84C2103
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 982ED62BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A536DC433C8;
        Wed,  9 Aug 2023 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580915;
        bh=TgoMOz8BqJIL1481uM9Dgf5slBrJZ5pC6RSMcVOKUdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xeNinPTVeEfDaGdOQ6NNZ+E4bGL+t3fC2PjP0mE7fdYfmgZd8J2s/Q14GgtzN0zse
         oTaR6PdIi6+4TOvFN5HXfJjDC/eSPF8uqR34f/cbZvJ5PtzYHkFsUV4Mc7fIH29Ad+
         kfJWbo3mn41KiXLKPZrkBFQ//KuxRMbl1PjvKBf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang Li <liali@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 039/201] bonding: reset bonds flags when down link is P2P device
Date:   Wed,  9 Aug 2023 12:40:41 +0200
Message-ID: <20230809103645.164285558@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit da19a2b967cf1e2c426f50d28550d1915214a81d ]

When adding a point to point downlink to the bond, we neglected to reset
the bond's flags, which were still using flags like BROADCAST and
MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
interfaces, such as when adding a GRE device to the bonding.

To address this issue, let's reset the bond's flags for P2P interfaces.

Before fix:
7: gre0@NONE: <POINTOPOINT,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN group default qlen 1000
    link/gre6 2006:70:10::1 peer 2006:70:10::2 permaddr 167f:18:f188::
8: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/gre6 2006:70:10::1 brd 2006:70:10::2
    inet6 fe80::200:ff:fe00:0/64 scope link
       valid_lft forever preferred_lft forever

After fix:
7: gre0@NONE: <POINTOPOINT,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond2 state UNKNOWN group default qlen 1000
    link/gre6 2006:70:10::1 peer 2006:70:10::2 permaddr c29e:557a:e9d9::
8: bond0: <POINTOPOINT,NOARP,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/gre6 2006:70:10::1 peer 2006:70:10::2
    inet6 fe80::1/64 scope link
       valid_lft forever preferred_lft forever

Reported-by: Liang Li <liali@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 381e6cdd603a1..a260740269e9f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1442,6 +1442,11 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	memcpy(bond_dev->broadcast, slave_dev->broadcast,
 		slave_dev->addr_len);
+
+	if (slave_dev->flags & IFF_POINTOPOINT) {
+		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 /* On bonding slaves other than the currently active slave, suppress
-- 
2.39.2



