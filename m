Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0FB78AB86
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjH1Kbv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjH1Kbc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B57CE7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ABC6619F7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E62C433C7;
        Mon, 28 Aug 2023 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218667;
        bh=8h/nWeH79EWD2Sn/DcNqH8wvxNG5fm5Jdu6QjDaN0Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXCXgdqi6DxzNPYGOEt2Num6JF0ZvcXBcfbywEFHvT5gNshQnk0oz8niLprXUcrf/
         velKbzC+HG7FJfCR69RV549XEWh1zAT3kslob4LPup7ifo/tsdDGR1/2pAj+xfENZD
         hiBLuGxvEPbxe6DcuoYp9qigICGlZgsLxnmnAsLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/122] net: validate veth and vxcan peer ifindexes
Date:   Mon, 28 Aug 2023 12:12:35 +0200
Message-ID: <20230828101157.735520597@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit f534f6581ec084fe94d6759f7672bd009794b07e ]

veth and vxcan need to make sure the ifindexes of the peer
are not negative, core does not validate this.

Using iproute2 with user-space-level checking removed:

Before:

  # ./ip link add index 10 type veth peer index -1
  # ip link show
  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
  2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:74:b2:03 brd ff:ff:ff:ff:ff:ff
  10: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 8a:90:ff:57:6d:5d brd ff:ff:ff:ff:ff:ff
  -1: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether ae:ed:18:e6:fa:7f brd ff:ff:ff:ff:ff:ff

Now:

  $ ./ip link add index 10 type veth peer index -1
  Error: ifindex can't be negative.

This problem surfaced in net-next because an explicit WARN()
was added, the root cause is older.

Fixes: e6f8f1a739b6 ("veth: Allow to create peer link with given ifindex")
Fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/vxcan.c |  7 +------
 drivers/net/veth.c      |  5 +----
 include/net/rtnetlink.h |  4 ++--
 net/core/rtnetlink.c    | 22 ++++++++++++++++++----
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 26a472d2ea583..6d549dbdb4674 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -192,12 +192,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 
 		nla_peer = data[VXCAN_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifla(peer_tb,
-					  nla_data(nla_peer) +
-					  sizeof(struct ifinfomsg),
-					  nla_len(nla_peer) -
-					  sizeof(struct ifinfomsg),
-					  NULL);
+		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		if (err < 0)
 			return err;
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a71786b3e7ba7..727b9278b9fe5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1716,10 +1716,7 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 
 		nla_peer = data[VETH_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifla(peer_tb,
-					  nla_data(nla_peer) + sizeof(struct ifinfomsg),
-					  nla_len(nla_peer) - sizeof(struct ifinfomsg),
-					  NULL);
+		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		if (err < 0)
 			return err;
 
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index bf8bb33578250..9f881b74f32ed 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -189,8 +189,8 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 int rtnl_delete_link(struct net_device *dev);
 int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm);
 
-int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
-			struct netlink_ext_ack *exterr);
+int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
+			     struct netlink_ext_ack *exterr);
 struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2758b3f7c0214..48e300a144ad6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2220,13 +2220,27 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
-int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
-			struct netlink_ext_ack *exterr)
+int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
+			     struct netlink_ext_ack *exterr)
 {
-	return nla_parse_deprecated(tb, IFLA_MAX, head, len, ifla_policy,
+	const struct ifinfomsg *ifmp;
+	const struct nlattr *attrs;
+	size_t len;
+
+	ifmp = nla_data(nla_peer);
+	attrs = nla_data(nla_peer) + sizeof(struct ifinfomsg);
+	len = nla_len(nla_peer) - sizeof(struct ifinfomsg);
+
+	if (ifmp->ifi_index < 0) {
+		NL_SET_ERR_MSG_ATTR(exterr, nla_peer,
+				    "ifindex can't be negative");
+		return -EINVAL;
+	}
+
+	return nla_parse_deprecated(tb, IFLA_MAX, attrs, len, ifla_policy,
 				    exterr);
 }
-EXPORT_SYMBOL(rtnl_nla_parse_ifla);
+EXPORT_SYMBOL(rtnl_nla_parse_ifinfomsg);
 
 struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
 {
-- 
2.40.1



