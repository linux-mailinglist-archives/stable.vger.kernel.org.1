Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0781078AB80
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjH1KbZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjH1KbG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEF3CD1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72D29617C0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87979C433C7;
        Mon, 28 Aug 2023 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218642;
        bh=Av0p98fLpfEx6ssO/snMS2410v/tbBspOF9HgmxpUo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3/LU0iM0OTrZPI4xG+eY0nx1tYAnI1Dh9d07QBuUYjrC4HcoTks2tvappEuLvYFh
         YWKlTBn9XO+Gz4f3Nl0DlqbEIKRE4gLNhhRuZa7ilSNPOOhoHzbc5rMzxPswl0V+l5
         th+hNzXJ76HLIee5sAbxnRExS7G5qQ/8eNWZVUx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lu Wei <luwei32@huawei.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/122] ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()
Date:   Mon, 28 Aug 2023 12:12:27 +0200
Message-ID: <20230828101157.490617212@linuxfoundation.org>
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
index 796a38f9d7b24..cd16bc8bf154c 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -748,7 +748,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 		write_pnet(&port->pnet, newnet);
 
-		ipvlan_migrate_l3s_hook(oldnet, newnet);
+		if (port->mode == IPVLAN_MODE_L3S)
+			ipvlan_migrate_l3s_hook(oldnet, newnet);
 		break;
 	}
 	case NETDEV_UNREGISTER:
-- 
2.40.1



