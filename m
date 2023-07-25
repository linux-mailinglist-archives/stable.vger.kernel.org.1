Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2D57612D2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjGYLFq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjGYLFb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD323581
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 750AB61656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835E4C433C7;
        Tue, 25 Jul 2023 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283007;
        bh=WEOaO7BEOGhQyAmyLB1gu0n2EK/YGGXqFbag93UijTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpSVoQlAHn62WV0lcRGNjbpSOf6cxJHjuytLc8fTRFC0YSSNYxh8J7ZpoztBrWlsp
         kGark3hhFnEOJg3jlIO1uE2wLkSC2MDmYHYUQB6xEjTwSperOjIfw5qTpZoVyHUKgQ
         aqM1rTYlneImS8fYFXWP6VaVPkPDr/F73CyajysE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Coin <hcoin@quietfountain.com>,
        Ido Schimmel <idosch@idosch.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 106/183] bridge: Add extack warning when enabling STP in netns.
Date:   Tue, 25 Jul 2023 12:45:34 +0200
Message-ID: <20230725104511.753165688@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 56a16035bb6effb37177867cea94c13a8382f745 ]

When we create an L2 loop on a bridge in netns, we will see packets storm
even if STP is enabled.

  # unshare -n
  # ip link add br0 type bridge
  # ip link add veth0 type veth peer name veth1
  # ip link set veth0 master br0 up
  # ip link set veth1 master br0 up
  # ip link set br0 type bridge stp_state 1
  # ip link set br0 up
  # sleep 30
  # ip -s link show br0
  2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
      link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
      RX: bytes  packets  errors  dropped missed  mcast
      956553768  12861249 0       0       0       12861249  <-. Keep
      TX: bytes  packets  errors  dropped carrier collsns     |  increasing
      1027834    11951    0       0       0       0         <-'   rapidly

This is because llc_rcv() drops all packets in non-root netns and BPDU
is dropped.

Let's add extack warning when enabling STP in netns.

  # unshare -n
  # ip link add br0 type bridge
  # ip link set br0 type bridge stp_state 1
  Warning: bridge: STP does not work in non-root netns.

Note this commit will be reverted later when we namespacify the whole LLC
infra.

Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
Suggested-by: Harry Coin <hcoin@quietfountain.com>
Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_stp_if.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 75204d36d7f90..b65962682771f 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,6 +201,9 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
+	if (!net_eq(dev_net(br->dev), &init_net))
+		NL_SET_ERR_MSG_MOD(extack, "STP does not work in non-root netns");
+
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
-- 
2.39.2



