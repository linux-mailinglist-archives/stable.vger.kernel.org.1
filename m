Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632AE7A3D55
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbjIQUli (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbjIQUlR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:41:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083912F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:41:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D697DC433C7;
        Sun, 17 Sep 2023 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983271;
        bh=dW/vucEDjBMUCTZ+P5SQlbZEhMFaOzIVcIE8Oc13YJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1xgSfDyslD0jWuIBXqTruPBIhsIZ0xg+Lfm56zntW+9F0/A/TbOK9IOH4YN9Ymr79
         ZBwBYcXebjFcVgIIuNaarPX49D8dRudwdqp6OE2goboTqfJJF/S9noSpKh+HbNHeTb
         z1V+vuY+pyYzmfMtpQi8gXgu6YufjLID1A8dVavo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liu Jian <liujian56@huawei.com>,
        Julian Anastasov <ja@ssi.bg>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 493/511] net: ipv4: fix one memleak in __inet_del_ifa()
Date:   Sun, 17 Sep 2023 21:15:20 +0200
Message-ID: <20230917191125.635188170@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit ac28b1ec6135649b5d78b028e47264cb3ebca5ea ]

I got the below warning when do fuzzing test:
unregister_netdevice: waiting for bond0 to become free. Usage count = 2

It can be repoduced via:

ip link add bond0 type bond
sysctl -w net.ipv4.conf.bond0.promote_secondaries=1
ip addr add 4.117.174.103/0 scope 0x40 dev bond0
ip addr add 192.168.100.111/255.255.255.254 scope 0 dev bond0
ip addr add 0.0.0.4/0 scope 0x40 secondary dev bond0
ip addr del 4.117.174.103/0 scope 0x40 dev bond0
ip link delete bond0 type bond

In this reproduction test case, an incorrect 'last_prim' is found in
__inet_del_ifa(), as a result, the secondary address(0.0.0.4/0 scope 0x40)
is lost. The memory of the secondary address is leaked and the reference of
in_device and net_device is leaked.

Fix this problem:
Look for 'last_prim' starting at location of the deleted IP and inserting
the promoted IP into the location of 'last_prim'.

Fixes: 0ff60a45678e ("[IPV4]: Fix secondary IP addresses after promotion")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/devinet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 9ac41ffdc6344..c511751c2f41a 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -351,14 +351,14 @@ static void __inet_del_ifa(struct in_device *in_dev,
 {
 	struct in_ifaddr *promote = NULL;
 	struct in_ifaddr *ifa, *ifa1;
-	struct in_ifaddr *last_prim;
+	struct in_ifaddr __rcu **last_prim;
 	struct in_ifaddr *prev_prom = NULL;
 	int do_promote = IN_DEV_PROMOTE_SECONDARIES(in_dev);
 
 	ASSERT_RTNL();
 
 	ifa1 = rtnl_dereference(*ifap);
-	last_prim = rtnl_dereference(in_dev->ifa_list);
+	last_prim = ifap;
 	if (in_dev->dead)
 		goto no_promotions;
 
@@ -372,7 +372,7 @@ static void __inet_del_ifa(struct in_device *in_dev,
 		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {
 			if (!(ifa->ifa_flags & IFA_F_SECONDARY) &&
 			    ifa1->ifa_scope <= ifa->ifa_scope)
-				last_prim = ifa;
+				last_prim = &ifa->ifa_next;
 
 			if (!(ifa->ifa_flags & IFA_F_SECONDARY) ||
 			    ifa1->ifa_mask != ifa->ifa_mask ||
@@ -436,9 +436,9 @@ static void __inet_del_ifa(struct in_device *in_dev,
 
 			rcu_assign_pointer(prev_prom->ifa_next, next_sec);
 
-			last_sec = rtnl_dereference(last_prim->ifa_next);
+			last_sec = rtnl_dereference(*last_prim);
 			rcu_assign_pointer(promote->ifa_next, last_sec);
-			rcu_assign_pointer(last_prim->ifa_next, promote);
+			rcu_assign_pointer(*last_prim, promote);
 		}
 
 		promote->ifa_flags &= ~IFA_F_SECONDARY;
-- 
2.40.1



