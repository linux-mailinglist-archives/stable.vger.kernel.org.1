Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0373532C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjFSKmX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFSKmH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE5EE51
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A77460670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCCCC433C0;
        Mon, 19 Jun 2023 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171325;
        bh=TvKaVSV7PH0o2IDTEJPk7NGATkfqXbuxkh9jlKRJAGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxmxvyvLBp7DpgpNRe23RThHOm/4rIiSGRsvMXwVDO7Ao2lCllPaPdW42x2PY5l7n
         OuTB+GAzWEkE7+r7W7c5iV3v/HkWV2DpRJPQzSIcfhUbFFtkMRpna0yuf6oQNbWISx
         iUvpseufM5svieqXLLLkVODFQ0rukdRWHuW4Zh0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Martin Schiller <ms@dev.tdt.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 41/49] net: lapbether: only support ethernet devices
Date:   Mon, 19 Jun 2023 12:30:19 +0200
Message-ID: <20230619102132.080097967@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
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

[ Upstream commit 9eed321cde22fc1afd76eac563ce19d899e0d6b2 ]

It probbaly makes no sense to support arbitrary network devices
for lapbether.

syzbot reported:

skbuff: skb_under_panic: text:ffff80008934c100 len:44 put:40 head:ffff0000d18dd200 data:ffff0000d18dd1ea tail:0x16 end:0x140 dev:bond1
kernel BUG at net/core/skbuff.c:200 !
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 5643 Comm: dhcpcd Not tainted 6.4.0-rc5-syzkaller-g4641cff8e810 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : skb_panic net/core/skbuff.c:196 [inline]
pc : skb_under_panic+0x13c/0x140 net/core/skbuff.c:210
lr : skb_panic net/core/skbuff.c:196 [inline]
lr : skb_under_panic+0x13c/0x140 net/core/skbuff.c:210
sp : ffff8000973b7260
x29: ffff8000973b7270 x28: ffff8000973b7360 x27: dfff800000000000
x26: ffff0000d85d8150 x25: 0000000000000016 x24: ffff0000d18dd1ea
x23: ffff0000d18dd200 x22: 000000000000002c x21: 0000000000000140
x20: 0000000000000028 x19: ffff80008934c100 x18: ffff8000973b68a0
x17: 0000000000000000 x16: ffff80008a43bfbc x15: 0000000000000202
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
x11: 0000000000000201 x10: 0000000000000000 x9 : f22f7eb937cced00
x8 : f22f7eb937cced00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000973b6b78 x4 : ffff80008df9ee80 x3 : ffff8000805974f4
x2 : 0000000000000001 x1 : 0000000100000201 x0 : 0000000000000086
Call trace:
skb_panic net/core/skbuff.c:196 [inline]
skb_under_panic+0x13c/0x140 net/core/skbuff.c:210
skb_push+0xf0/0x108 net/core/skbuff.c:2409
ip6gre_header+0xbc/0x738 net/ipv6/ip6_gre.c:1383
dev_hard_header include/linux/netdevice.h:3137 [inline]
lapbeth_data_transmit+0x1c4/0x298 drivers/net/wan/lapbether.c:257
lapb_data_transmit+0x8c/0xb0 net/lapb/lapb_iface.c:447
lapb_transmit_buffer+0x178/0x204 net/lapb/lapb_out.c:149
lapb_send_control+0x220/0x320 net/lapb/lapb_subr.c:251
lapb_establish_data_link+0x94/0xec
lapb_device_event+0x348/0x4e0
notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
__dev_notify_flags+0x2bc/0x544
dev_change_flags+0xd0/0x15c net/core/dev.c:8643
devinet_ioctl+0x858/0x17e4 net/ipv4/devinet.c:1150
inet_ioctl+0x2ac/0x4d8 net/ipv4/af_inet.c:979
sock_do_ioctl+0x134/0x2dc net/socket.c:1201
sock_ioctl+0x4ec/0x858 net/socket.c:1318
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:870 [inline]
__se_sys_ioctl fs/ioctl.c:856 [inline]
__arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:856
__invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: aa1803e6 aa1903e7 a90023f5 947730f5 (d4210000)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/lapbether.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 6233805fc032c..b2ede9acb4bcf 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -344,6 +344,9 @@ static int lapbeth_new_device(struct net_device *dev)
 
 	ASSERT_RTNL();
 
+	if (dev->type != ARPHRD_ETHER)
+		return -EINVAL;
+
 	ndev = alloc_netdev(sizeof(*lapbeth), "lapb%d", NET_NAME_UNKNOWN,
 			    lapbeth_setup);
 	if (!ndev)
-- 
2.39.2



