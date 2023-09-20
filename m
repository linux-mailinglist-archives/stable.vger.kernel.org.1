Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B027A80EF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbjITMlT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbjITMlS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:41:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2DDC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:41:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C95C433C8;
        Wed, 20 Sep 2023 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213671;
        bh=60X427uDv0zVmJH9YugxC6MtjI/yI60lJRhLcZCKL/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QD7CIMFP7vv+Z1yJEitWVnCMcMak9qdr6oI8xdhAMvV19M5le3tOpTU7z7mXVL+8Y
         8YTNSPyUdu4sC26FjGlHqiffVKPegvh6hxTr9BA/8sXwjc6vjBOz8l3vgvK2zeatFn
         qw4QkejlSAKqJMSYXVLXfGQPe4TWzJHkHQvN+1Ek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liu Jian <liujian56@huawei.com>,
        Julian Anastasov <ja@ssi.bg>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 297/367] net: ipv4: fix one memleak in __inet_del_ifa()
Date:   Wed, 20 Sep 2023 13:31:14 +0200
Message-ID: <20230920112906.233959225@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 4a8ad46397c0e..4c013f8800f0c 100644
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



