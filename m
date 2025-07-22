Return-Path: <stable+bounces-164036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46285B0DCA0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4257B4C1F
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15C2E1724;
	Tue, 22 Jul 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SChNzQzI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960A38FA3;
	Tue, 22 Jul 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193038; cv=none; b=Mam5kmA4TxgOifutEcQHQhpw/vWmQ+b0SPR5trJMBRCm7lroxYy6wYtXM65muFm76/U6eoLT/HtOugw6ZL2FjK3DO0x2xBW79a6lkcoEyzsLoeVgwELcXL1QBTIcoJ8yvE67qKLXaY0zEa+2YJNWI4iZUq9D/Ad+TmuyUL7CkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193038; c=relaxed/simple;
	bh=XSMEDRzYUk11GsX1rx3fk7mKz6glI7p3/bfahgxRnFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADqGN23mXapXawQhr1U4DhZxwzt4zVqR/WjXpu2AOV/+SFU+ZM1P1j0hLQLF/4jMYxKPlAXP1YHOi6gLWOZNxBquz/Iy1tytNWRSOyUNKiNlDN0U9icqkbyOoRonwbpry+MAbeCQQF8ZEzWk7VQZjNRW0iW7j3ck/ATkbLZRkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SChNzQzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1604C4CEEB;
	Tue, 22 Jul 2025 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193038;
	bh=XSMEDRzYUk11GsX1rx3fk7mKz6glI7p3/bfahgxRnFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SChNzQzIPq/ioKD0OslHHs0SOAgu2xmeLJHnHcGnpx4fLRvfypm0E/UTBrjR8lxL+
	 8SppcwVjV7Rhe/Byg4O11pGK0BQi8v+ERwCZ/vgTQH8M+JeT2RCYXTiKhbg8E5pZXD
	 H8ZPmsPqHTdrkIKkkQv7st9CZ6p916jUDIgstqW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+a8b046e462915c65b10b@syzkaller.appspotmail.com,
	Ido Schimmel <idosch@idosch.org>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 130/158] net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime
Date: Tue, 22 Jul 2025 15:45:14 +0200
Message-ID: <20250722134345.585230424@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dong Chenchen <dongchenchen2@huawei.com>

[ Upstream commit 579d4f9ca9a9a605184a9b162355f6ba131f678d ]

Assuming the "rx-vlan-filter" feature is enabled on a net device, the
8021q module will automatically add or remove VLAN 0 when the net device
is put administratively up or down, respectively. There are a couple of
problems with the above scheme.

The first problem is a memory leak that can happen if the "rx-vlan-filter"
feature is disabled while the device is running:

 # ip link add bond1 up type bond mode 0
 # ethtool -K bond1 rx-vlan-filter off
 # ip link del dev bond1

When the device is put administratively down the "rx-vlan-filter"
feature is disabled, so the 8021q module will not remove VLAN 0 and the
memory will be leaked [1].

Another problem that can happen is that the kernel can automatically
delete VLAN 0 when the device is put administratively down despite not
adding it when the device was put administratively up since during that
time the "rx-vlan-filter" feature was disabled. null-ptr-unref or
bug_on[2] will be triggered by unregister_vlan_dev() for refcount
imbalance if toggling filtering during runtime:

$ ip link add bond0 type bond mode 0
$ ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
$ ethtool -K bond0 rx-vlan-filter off
$ ifconfig bond0 up
$ ethtool -K bond0 rx-vlan-filter on
$ ifconfig bond0 down
$ ip link del vlan0

Root cause is as below:
step1: add vlan0 for real_dev, such as bond, team.
register_vlan_dev
    vlan_vid_add(real_dev,htons(ETH_P_8021Q),0) //refcnt=1
step2: disable vlan filter feature and enable real_dev
step3: change filter from 0 to 1
vlan_device_event
    vlan_filter_push_vids
        ndo_vlan_rx_add_vid //No refcnt added to real_dev vlan0
step4: real_dev down
vlan_device_event
    vlan_vid_del(dev, htons(ETH_P_8021Q), 0); //refcnt=0
        vlan_info_rcu_free //free vlan0
step5: delete vlan0
unregister_vlan_dev
    BUG_ON(!vlan_info); //vlan_info is null

Fix both problems by noting in the VLAN info whether VLAN 0 was
automatically added upon NETDEV_UP and based on that decide whether it
should be deleted upon NETDEV_DOWN, regardless of the state of the
"rx-vlan-filter" feature.

[1]
unreferenced object 0xffff8880068e3100 (size 256):
  comm "ip", pid 384, jiffies 4296130254
  hex dump (first 32 bytes):
    00 20 30 0d 80 88 ff ff 00 00 00 00 00 00 00 00  . 0.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 81ce31fa):
    __kmalloc_cache_noprof+0x2b5/0x340
    vlan_vid_add+0x434/0x940
    vlan_device_event.cold+0x75/0xa8
    notifier_call_chain+0xca/0x150
    __dev_notify_flags+0xe3/0x250
    rtnl_configure_link+0x193/0x260
    rtnl_newlink_create+0x383/0x8e0
    __rtnl_newlink+0x22c/0xa40
    rtnl_newlink+0x627/0xb00
    rtnetlink_rcv_msg+0x6fb/0xb70
    netlink_rcv_skb+0x11f/0x350
    netlink_unicast+0x426/0x710
    netlink_sendmsg+0x75a/0xc20
    __sock_sendmsg+0xc1/0x150
    ____sys_sendmsg+0x5aa/0x7b0
    ___sys_sendmsg+0xfc/0x180

[2]
kernel BUG at net/8021q/vlan.c:99!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 382 Comm: ip Not tainted 6.16.0-rc3 #61 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:unregister_vlan_dev (net/8021q/vlan.c:99 (discriminator 1))
RSP: 0018:ffff88810badf310 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88810da84000 RCX: ffffffffb47ceb9a
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88810e8b43c8
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff6cefe80
R10: ffffffffb677f407 R11: ffff88810badf3c0 R12: ffff88810e8b4000
R13: 0000000000000000 R14: ffff88810642a5c0 R15: 000000000000017e
FS:  00007f1ff68c20c0(0000) GS:ffff888163a24000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ff5dad240 CR3: 0000000107e56000 CR4: 00000000000006f0
Call Trace:
 <TASK>
rtnl_dellink (net/core/rtnetlink.c:3511 net/core/rtnetlink.c:3553)
rtnetlink_rcv_msg (net/core/rtnetlink.c:6945)
netlink_rcv_skb (net/netlink/af_netlink.c:2535)
netlink_unicast (net/netlink/af_netlink.c:1314 net/netlink/af_netlink.c:1339)
netlink_sendmsg (net/netlink/af_netlink.c:1883)
____sys_sendmsg (net/socket.c:712 net/socket.c:727 net/socket.c:2566)
___sys_sendmsg (net/socket.c:2622)
__sys_sendmsg (net/socket.c:2652)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)

Fixes: ad1afb003939 ("vlan_dev: VLAN 0 should be treated as "no vlan tag" (802.1p packet)")
Reported-by: syzbot+a8b046e462915c65b10b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a8b046e462915c65b10b
Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20250716034504.2285203-2-dongchenchen2@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/8021q/vlan.c | 42 +++++++++++++++++++++++++++++++++---------
 net/8021q/vlan.h |  1 +
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 41be38264493d..49a6d49c23dc5 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -358,6 +358,35 @@ static int __vlan_device_event(struct net_device *dev, unsigned long event)
 	return err;
 }
 
+static void vlan_vid0_add(struct net_device *dev)
+{
+	struct vlan_info *vlan_info;
+	int err;
+
+	if (!(dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		return;
+
+	pr_info("adding VLAN 0 to HW filter on device %s\n", dev->name);
+
+	err = vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
+	if (err)
+		return;
+
+	vlan_info = rtnl_dereference(dev->vlan_info);
+	vlan_info->auto_vid0 = true;
+}
+
+static void vlan_vid0_del(struct net_device *dev)
+{
+	struct vlan_info *vlan_info = rtnl_dereference(dev->vlan_info);
+
+	if (!vlan_info || !vlan_info->auto_vid0)
+		return;
+
+	vlan_info->auto_vid0 = false;
+	vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+}
+
 static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			     void *ptr)
 {
@@ -379,15 +408,10 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			return notifier_from_errno(err);
 	}
 
-	if ((event == NETDEV_UP) &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) {
-		pr_info("adding VLAN 0 to HW filter on device %s\n",
-			dev->name);
-		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
-	}
-	if (event == NETDEV_DOWN &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
-		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+	if (event == NETDEV_UP)
+		vlan_vid0_add(dev);
+	else if (event == NETDEV_DOWN)
+		vlan_vid0_del(dev);
 
 	vlan_info = rtnl_dereference(dev->vlan_info);
 	if (!vlan_info)
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 5eaf38875554b..c7ffe591d5936 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -33,6 +33,7 @@ struct vlan_info {
 	struct vlan_group	grp;
 	struct list_head	vid_list;
 	unsigned int		nr_vids;
+	bool			auto_vid0;
 	struct rcu_head		rcu;
 };
 
-- 
2.39.5




