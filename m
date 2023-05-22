Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435D70C9B6
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjEVTvB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjEVTu4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D0B138
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F5C62B08
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D930C433D2;
        Mon, 22 May 2023 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785046;
        bh=x3IOLkt/NtxNw7nIjCJz+nxipxQdd/0MFE2onxO6sEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRsxPAMYLRYFnsKcbkz9F1frHBI81uJjmjj4j8rk/qE1JvuZ93a4eTjEb3KejotnC
         nK0k35P365+MNahVJo51GzFyfL8uIUY/GjO3h/e+1GfopGYulg9cBwxzJeWgm7ijJW
         FXGWINC/+BMK1GOndj95mZFSHIhOAxuAx7kzcxZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 282/364] vlan: fix a potential uninit-value in vlan_dev_hard_start_xmit()
Date:   Mon, 22 May 2023 20:09:47 +0100
Message-Id: <20230522190419.776646825@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit dacab578c7c6cd06c50c89dfa36b0e0f10decd4e ]

syzbot triggered the following splat [1], sending an empty message
through pppoe_sendmsg().

When VLAN_FLAG_REORDER_HDR flag is set, vlan_dev_hard_header()
does not push extra bytes for the VLAN header, because vlan is offloaded.

Unfortunately vlan_dev_hard_start_xmit() first reads veth->h_vlan_proto
before testing (vlan->flags & VLAN_FLAG_REORDER_HDR).

We need to swap the two conditions.

[1]
BUG: KMSAN: uninit-value in vlan_dev_hard_start_xmit+0x171/0x7f0 net/8021q/vlan_dev.c:111
vlan_dev_hard_start_xmit+0x171/0x7f0 net/8021q/vlan_dev.c:111
__netdev_start_xmit include/linux/netdevice.h:4883 [inline]
netdev_start_xmit include/linux/netdevice.h:4897 [inline]
xmit_one net/core/dev.c:3580 [inline]
dev_hard_start_xmit+0x253/0xa20 net/core/dev.c:3596
__dev_queue_xmit+0x3c7f/0x5ac0 net/core/dev.c:4246
dev_queue_xmit include/linux/netdevice.h:3053 [inline]
pppoe_sendmsg+0xa93/0xb80 drivers/net/ppp/pppoe.c:900
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
____sys_sendmsg+0xa24/0xe40 net/socket.c:2501
___sys_sendmsg+0x2a1/0x3f0 net/socket.c:2555
__sys_sendmmsg+0x411/0xa50 net/socket.c:2641
__do_sys_sendmmsg net/socket.c:2670 [inline]
__se_sys_sendmmsg net/socket.c:2667 [inline]
__x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2667
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:774
slab_alloc_node mm/slub.c:3452 [inline]
kmem_cache_alloc_node+0x543/0xab0 mm/slub.c:3497
kmalloc_reserve+0x148/0x470 net/core/skbuff.c:520
__alloc_skb+0x3a7/0x850 net/core/skbuff.c:606
alloc_skb include/linux/skbuff.h:1277 [inline]
sock_wmalloc+0xfe/0x1a0 net/core/sock.c:2583
pppoe_sendmsg+0x3af/0xb80 drivers/net/ppp/pppoe.c:867
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
____sys_sendmsg+0xa24/0xe40 net/socket.c:2501
___sys_sendmsg+0x2a1/0x3f0 net/socket.c:2555
__sys_sendmmsg+0x411/0xa50 net/socket.c:2641
__do_sys_sendmmsg net/socket.c:2670 [inline]
__se_sys_sendmmsg net/socket.c:2667 [inline]
__x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2667
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 0 PID: 29770 Comm: syz-executor.0 Not tainted 6.3.0-rc6-syzkaller-gc478e5b17829 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/8021q/vlan_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 5920544e93e82..0fa52bcc296bf 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -108,8 +108,8 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
 	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
 	 * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
 	 */
-	if (veth->h_vlan_proto != vlan->vlan_proto ||
-	    vlan->flags & VLAN_FLAG_REORDER_HDR) {
+	if (vlan->flags & VLAN_FLAG_REORDER_HDR ||
+	    veth->h_vlan_proto != vlan->vlan_proto) {
 		u16 vlan_tci;
 		vlan_tci = vlan->vlan_id;
 		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
-- 
2.39.2



