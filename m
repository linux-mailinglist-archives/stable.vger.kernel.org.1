Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33C37ECD9A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjKOThY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjKOThX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C737A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24E3C433C7;
        Wed, 15 Nov 2023 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077040;
        bh=MQTQJ5U6AKIfeWoizrmaejJaSn5x4eyqPHQ5VaKTD7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SirVG28mUDTax6X5bmefDYCYcliK2YuFT0e46osABanGmDiZbkKNSkLI6+y2bNCAL
         Tbv4s35MZ+oqUNoAPbmeA8UqUQD2ZSpLoevF7jtRCIvzxtOjAAt96j42UzxjL/BmyH
         b+ANr2g8+5QQnDt4Z9YBqrh2F7eYJD5sHGqp4frQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shigeru Yoshida <syoshida@redhat.com>,
        Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com,
        syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Subject: [PATCH 6.5 500/550] tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING
Date:   Wed, 15 Nov 2023 14:18:04 -0500
Message-ID: <20231115191635.584657976@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 19b3f72a41a8751e26bffc093bb7e1cef29ad579 ]

syzbot reported the following uninit-value access issue [1]:

=====================================================
BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
 strlen lib/string.c:418 [inline]
 strstr+0xb8/0x2f0 lib/string.c:756
 tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
 genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmsg net/socket.c:2624 [inline]
 __do_sys_sendmsg net/socket.c:2633 [inline]
 __se_sys_sendmsg net/socket.c:2631 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
 netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmsg net/socket.c:2624 [inline]
 __do_sys_sendmsg net/socket.c:2633 [inline]
 __se_sys_sendmsg net/socket.c:2631 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

TIPC bearer-related names including link names must be null-terminated
strings. If a link name which is not null-terminated is passed through
netlink, strstr() and similar functions can cause buffer overrun. This
causes the above issue.

This patch changes the nla_policy for bearer-related names from NLA_STRING
to NLA_NUL_STRING. This resolves the issue by ensuring that only
null-terminated strings are accepted as bearer-related names.

syzbot reported similar uninit-value issue related to bearer names [2]. The
root cause of this issue is that a non-null-terminated bearer name was
passed. This patch also resolved this issue.

Fixes: 7be57fc69184 ("tipc: add link get/dump to new netlink api")
Fixes: 0655f6a8635b ("tipc: add bearer disable/enable to new netlink api")
Reported-and-tested-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574 [1]
Reported-and-tested-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9425c47dccbcb4c17d51 [2]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20231030075540.3784537-1-syoshida@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index e8fd257c0e688..1a9a5bdaccf4f 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -88,7 +88,7 @@ const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 
 const struct nla_policy tipc_nl_link_policy[TIPC_NLA_LINK_MAX + 1] = {
 	[TIPC_NLA_LINK_UNSPEC]		= { .type = NLA_UNSPEC },
-	[TIPC_NLA_LINK_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_LINK_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_LINK_NAME },
 	[TIPC_NLA_LINK_MTU]		= { .type = NLA_U32 },
 	[TIPC_NLA_LINK_BROADCAST]	= { .type = NLA_FLAG },
@@ -125,7 +125,7 @@ const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
 
 const struct nla_policy tipc_nl_bearer_policy[TIPC_NLA_BEARER_MAX + 1]	= {
 	[TIPC_NLA_BEARER_UNSPEC]	= { .type = NLA_UNSPEC },
-	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_BEARER_NAME },
 	[TIPC_NLA_BEARER_PROP]		= { .type = NLA_NESTED },
 	[TIPC_NLA_BEARER_DOMAIN]	= { .type = NLA_U32 }
-- 
2.42.0



