Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26147876FE
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbjHXRVr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbjHXRVi (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF310D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB9F6756B
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF16CC433C7;
        Thu, 24 Aug 2023 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897696;
        bh=z8zDloZQ+YloSddYAkxtFwGDgbr8aaM4Rc/7pTmLkw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXn3jsYz/y/ndWNWfLnJ9cEPe4ICbyq93VK0vG89sX3HKAbig7EcDpVh9bz4Or/pv
         wC9LCm60OGHo6TBHT56nAosz27zzRSkRY4naW3iLVWXvDdSxDkIBZ22Ryw0IxpQ+z0
         AXUH1r2P1vU+ytlvaL6J2unnqCDXjwCvVpLYBoK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@idosch.org>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 089/135] team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves
Date:   Thu, 24 Aug 2023 19:09:21 +0200
Message-ID: <20230824170621.112184136@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ Upstream commit dafcbce07136d799edc4c67f04f9fd69ff1eac1f ]

Similar to commit 01f4fd270870 ("bonding: Fix incorrect deletion of
ETH_P_8021AD protocol vid from slaves"), we can trigger BUG_ON(!vlan_info)
in unregister_vlan_dev() with the following testcase:

  # ip netns add ns1
  # ip netns exec ns1 ip link add team1 type team
  # ip netns exec ns1 ip link add team_slave type veth peer veth2
  # ip netns exec ns1 ip link set team_slave master team1
  # ip netns exec ns1 ip link add link team_slave name team_slave.10 type vlan id 10 protocol 802.1ad
  # ip netns exec ns1 ip link add link team1 name team1.10 type vlan id 10 protocol 802.1ad
  # ip netns exec ns1 ip link set team_slave nomaster
  # ip netns del ns1

Add S-VLAN tag related features support to team driver. So the team driver
will always propagate the VLAN info to its slaves.

Fixes: 8ad227ff89a7 ("net: vlan: add 802.1ad support")
Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230814032301.2804971-1-william.xuanziyang@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 36c7eae776d44..721b536ce8861 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2195,7 +2195,9 @@ static void team_setup(struct net_device *dev)
 
 	dev->hw_features = TEAM_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
-			   NETIF_F_HW_VLAN_CTAG_FILTER;
+			   NETIF_F_HW_VLAN_CTAG_FILTER |
+			   NETIF_F_HW_VLAN_STAG_RX |
+			   NETIF_F_HW_VLAN_STAG_FILTER;
 
 	dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
 	dev->features |= dev->hw_features;
-- 
2.40.1



