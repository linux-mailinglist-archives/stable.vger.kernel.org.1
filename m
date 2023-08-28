Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B4778AD16
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjH1Kpu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjH1KpX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1A9CD3
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5FC0641F0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029E5C433C7;
        Mon, 28 Aug 2023 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219454;
        bh=MFTT5R5u/rNisn1JPmJcJgnd+MRRIvk8KHHgsHAK5po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EszN/Pc4ix1UCLUlTacOePyCHt9mbEif42/fwMdzZsvPTPk9MGZ79Dl+8bxsP79WG
         v4NA/DZ6eBYEOntcJBWo9L3niPWzJwBQHV/bg9RWBJRw3OtxXexQ7obZlwN0PMQtz2
         BRuJksX0IJ0ylC65B3cu0kfAliljbzC4NFAnI9SA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
        Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 41/89] rtnetlink: Reject negative ifindexes in RTM_NEWLINK
Date:   Mon, 28 Aug 2023 12:13:42 +0200
Message-ID: <20230828101151.564388223@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 30188bd7838c16a98a520db1fe9df01ffc6ed368 ]

Negative ifindexes are illegal, but the kernel does not validate the
ifindex in the ancillary header of RTM_NEWLINK messages, resulting in
the kernel generating a warning [1] when such an ifindex is specified.

Fix by rejecting negative ifindexes.

[1]
WARNING: CPU: 0 PID: 5031 at net/core/dev.c:9593 dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
[...]
Call Trace:
 <TASK>
 register_netdevice+0x69a/0x1490 net/core/dev.c:10081
 br_dev_newlink+0x27/0x110 net/bridge/br_netlink.c:1552
 rtnl_newlink_create net/core/rtnetlink.c:3471 [inline]
 __rtnl_newlink+0x115e/0x18c0 net/core/rtnetlink.c:3688
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3701
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6427
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:728 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:751
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2538
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2592
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2621
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 38f7b870d4a6 ("[RTNETLINK]: Link creation API")
Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20230823064348.2252280-1-idosch@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7c1a2fd7d9532..1b71e5c582bbc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3318,6 +3318,9 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
 		dev = __dev_get_by_index(net, ifm->ifi_index);
+	} else if (ifm->ifi_index < 0) {
+		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
 		dev = rtnl_dev_get(net, NULL, tb[IFLA_ALT_IFNAME], ifname);
-- 
2.40.1



