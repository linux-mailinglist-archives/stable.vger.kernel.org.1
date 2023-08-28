Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB04678AC90
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjH1KlF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjH1Kkl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978D512F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A7AC6100C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41791C433C8;
        Mon, 28 Aug 2023 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219237;
        bh=f0nmomxz91Y+pKJlz6U60QoqS8sy6/HgWkK8tpbLUvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6RMLrzu2PxavwXP+xBV+METTSdMXSLS9ovEq4O1UCanpUgLhlEHv0p6umBiGAgNw
         MGEoIjAko8fWXkGdlk8nHknaa0cIK3ozNzlOiFenLYU+zFgVBch/58akkto26kJXYq
         rXbBkTV2FczgQqH+Ap/+uLQVojOeC+I0fyoKqoI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lu Wei <luwei32@huawei.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 122/158] ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()
Date:   Mon, 28 Aug 2023 12:13:39 +0200
Message-ID: <20230828101201.476235185@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Wei <luwei32@huawei.com>

[ Upstream commit 043d5f68d0ccdda91029b4b6dce7eeffdcfad281 ]

There are two network devices(veth1 and veth3) in ns1, and ipvlan1 with
L3S mode and ipvlan2 with L2 mode are created based on them as
figure (1). In this case, ipvlan_register_nf_hook() will be called to
register nf hook which is needed by ipvlans in L3S mode in ns1 and value
of ipvl_nf_hook_refcnt is set to 1.

(1)
           ns1                           ns2
      ------------                  ------------

   veth1--ipvlan1 (L3S)

   veth3--ipvlan2 (L2)

(2)
           ns1                           ns2
      ------------                  ------------

   veth1--ipvlan1 (L3S)

         ipvlan2 (L2)                  veth3
     |                                  |
     |------->-------->--------->--------
                    migrate

When veth3 migrates from ns1 to ns2 as figure (2), veth3 will register in
ns2 and calls call_netdevice_notifiers with NETDEV_REGISTER event:

dev_change_net_namespace
    call_netdevice_notifiers
        ipvlan_device_event
            ipvlan_migrate_l3s_hook
                ipvlan_register_nf_hook(newnet)      (I)
                ipvlan_unregister_nf_hook(oldnet)    (II)

In function ipvlan_migrate_l3s_hook(), ipvl_nf_hook_refcnt in ns1 is not 0
since veth1 with ipvlan1 still in ns1, (I) and (II) will be called to
register nf_hook in ns2 and unregister nf_hook in ns1. As a result,
ipvl_nf_hook_refcnt in ns1 is decreased incorrectly and this in ns2
is increased incorrectly. When the second net namespace is removed, a
reference count leak warning in ipvlan_ns_exit() will be triggered.

This patch add a check before ipvlan_migrate_l3s_hook() is called. The
warning can be triggered as follows:

$ ip netns add ns1
$ ip netns add ns2
$ ip netns exec ns1 ip link add veth1 type veth peer name veth2
$ ip netns exec ns1 ip link add veth3 type veth peer name veth4
$ ip netns exec ns1 ip link add ipv1 link veth1 type ipvlan mode l3s
$ ip netns exec ns1 ip link add ipv2 link veth3 type ipvlan mode l2
$ ip netns exec ns1 ip link set veth3 netns ns2
$ ip net del ns2

Fixes: 3133822f5ac1 ("ipvlan: use pernet operations and restrict l3s hooks to master netns")
Signed-off-by: Lu Wei <luwei32@huawei.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Link: https://lore.kernel.org/r/20230817145449.141827-1-luwei32@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipvlan/ipvlan_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 5fbabae2909ee..5fea2e4a93101 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -735,7 +735,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 		write_pnet(&port->pnet, newnet);
 
-		ipvlan_migrate_l3s_hook(oldnet, newnet);
+		if (port->mode == IPVLAN_MODE_L3S)
+			ipvlan_migrate_l3s_hook(oldnet, newnet);
 		break;
 	}
 	case NETDEV_UNREGISTER:
-- 
2.40.1



