Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208AF76AD1E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHAJ0d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjHAJ0S (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AAD2709
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7394C613E2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81327C433C8;
        Tue,  1 Aug 2023 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881899;
        bh=6IQpSme99R6/7tZQ93zgVGwFKD0s+2sQIT2uMshNPrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4wEMnZDvPcEE79L/SlOjvb+8x86Zr+tLVgTu9zSHnA/0xcVMGpR4WHEXWKShHLoV
         Ahwl2q3QUftK84MXB5q7jZfG4HIiFmzgEBHCPcuo05OPeXkoubJijzgansyU7AqUMr
         QwOune1SbKq+T6LMjVL9tCyABFVoOYTyA5O6y2ZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang Li <liali@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 069/155] team: reset teams flags when down link is P2P device
Date:   Tue,  1 Aug 2023 11:19:41 +0200
Message-ID: <20230801091912.645031654@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit fa532bee17d15acf8bba4bc8e2062b7a093ba801 ]

When adding a point to point downlink to team device, we neglected to reset
the team's flags, which were still using flags like BROADCAST and
MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
interfaces, such as when adding a GRE device to team device. Fix this by
remove multicast/broadcast flags and add p2p and noarp flags.

After removing the none ethernet interface and adding an ethernet interface
to team, we need to reset team interface flags. Unlike bonding interface,
team do not need restore IFF_MASTER, IFF_SLAVE flags.

Reported-by: Liang Li <liali@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d9386d614a94c..4dfa9c610974a 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2130,6 +2130,15 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	} else if ((port_dev->flags & (IFF_BROADCAST | IFF_MULTICAST)) ==
+		    (IFF_BROADCAST | IFF_MULTICAST)) {
+		dev->flags |= (IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags &= ~(IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
-- 
2.39.2



