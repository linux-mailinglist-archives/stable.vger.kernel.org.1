Return-Path: <stable+bounces-127808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7255A7ABF7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281B817855B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C2256C79;
	Thu,  3 Apr 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs2/0C+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2D267AF4;
	Thu,  3 Apr 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707139; cv=none; b=q0T86ZSAu2zWb45W7CbsjuFca8uDkNXJlLJxy2Q04ODTTrijNJTqAIAd82Zd93p68JqinuXqvS8v+iYhmyeD34j/a6gJ4NmGPR6YAgfOWmsuoyBfb8fpRqGPY3y0OOwvLwvYBciHfXH+ZSaJ+lOqi5VesX4mLjJV7RdCFjYkwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707139; c=relaxed/simple;
	bh=yibhtFJ5DZlQJxzjtg7CPuk2D9ALJFnWsZXEG9o6doQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6zHEBM+g/dylKvzsgWZDIxEKwRoEBJWzZIyqyWS0HxXwIkF4vGKYQbq3LKva/ljdK0BVMRyRJBHUGh8mL+dTOTB5kRdyeMlBq38CWHwouG+l+/I4QLabzWA/2X3ToHtYYz8uBJGtrfrLxZckZQ763qUuLM6yrm4tNcQgCh8AS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs2/0C+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F22DC4CEE3;
	Thu,  3 Apr 2025 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707138;
	bh=yibhtFJ5DZlQJxzjtg7CPuk2D9ALJFnWsZXEG9o6doQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rs2/0C+AxuQDTGNlRfIiNbkMJsFiFPYYWIl+CSpCr0/NM/kFzgwZz+YQnWAwet4kF
	 PX+4AYWChFbfUMBU493pJTE2ABWIytZzb9ld/o/gyS9D9XzmHWWDL0hwPOs0NKfGWD
	 cBFFVylSlOO2KzUx1FWOGqwge4X1OOAVyG2eDeeC6EuKccTr/IrMsd+FYkVXD8SOWC
	 b4aDwHn042hA1f2HZutJzjqO1sr5oBiNP5olp9Xn3K0HLmzNiiXo7B25qzmbkEijZ1
	 YTfGigLR+Th+FiocwbBiAWFL+y2dNsZwxPz0BhjubN7vTybx6VcdgmpBtg1SEzKMrO
	 rTwYdF56SdVgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	kory.maincent@bootlin.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 39/49] net: vlan: don't propagate flags on open
Date: Thu,  3 Apr 2025 15:03:58 -0400
Message-Id: <20250403190408.2676344-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Stanislav Fomichev <sdf@fomichev.me>

[ Upstream commit 27b918007d96402aba10ed52a6af8015230f1793 ]

With the device instance lock, there is now a possibility of a deadlock:

[    1.211455] ============================================
[    1.211571] WARNING: possible recursive locking detected
[    1.211687] 6.14.0-rc5-01215-g032756b4ca7a-dirty #5 Not tainted
[    1.211823] --------------------------------------------
[    1.211936] ip/184 is trying to acquire lock:
[    1.212032] ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_set_allmulti+0x4e/0xb0
[    1.212207]
[    1.212207] but task is already holding lock:
[    1.212332] ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x50/0xb0
[    1.212487]
[    1.212487] other info that might help us debug this:
[    1.212626]  Possible unsafe locking scenario:
[    1.212626]
[    1.212751]        CPU0
[    1.212815]        ----
[    1.212871]   lock(&dev->lock);
[    1.212944]   lock(&dev->lock);
[    1.213016]
[    1.213016]  *** DEADLOCK ***
[    1.213016]
[    1.213143]  May be due to missing lock nesting notation
[    1.213143]
[    1.213294] 3 locks held by ip/184:
[    1.213371]  #0: ffffffff838b53e0 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock+0x1b/0xa0
[    1.213543]  #1: ffffffff84e5fc70 (&net->rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock+0x37/0xa0
[    1.213727]  #2: ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x50/0xb0
[    1.213895]
[    1.213895] stack backtrace:
[    1.213991] CPU: 0 UID: 0 PID: 184 Comm: ip Not tainted 6.14.0-rc5-01215-g032756b4ca7a-dirty #5
[    1.213993] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[    1.213994] Call Trace:
[    1.213995]  <TASK>
[    1.213996]  dump_stack_lvl+0x8e/0xd0
[    1.214000]  print_deadlock_bug+0x28b/0x2a0
[    1.214020]  lock_acquire+0xea/0x2a0
[    1.214027]  __mutex_lock+0xbf/0xd40
[    1.214038]  dev_set_allmulti+0x4e/0xb0 # real_dev->flags & IFF_ALLMULTI
[    1.214040]  vlan_dev_open+0xa5/0x170 # ndo_open on vlandev
[    1.214042]  __dev_open+0x145/0x270
[    1.214046]  __dev_change_flags+0xb0/0x1e0
[    1.214051]  netif_change_flags+0x22/0x60 # IFF_UP vlandev
[    1.214053]  dev_change_flags+0x61/0xb0 # for each device in group from dev->vlan_info
[    1.214055]  vlan_device_event+0x766/0x7c0 # on netdevsim0
[    1.214058]  notifier_call_chain+0x78/0x120
[    1.214062]  netif_open+0x6d/0x90
[    1.214064]  dev_open+0x5b/0xb0 # locks netdevsim0
[    1.214066]  bond_enslave+0x64c/0x1230
[    1.214075]  do_set_master+0x175/0x1e0 # on netdevsim0
[    1.214077]  do_setlink+0x516/0x13b0
[    1.214094]  rtnl_newlink+0xaba/0xb80
[    1.214132]  rtnetlink_rcv_msg+0x440/0x490
[    1.214144]  netlink_rcv_skb+0xeb/0x120
[    1.214150]  netlink_unicast+0x1f9/0x320
[    1.214153]  netlink_sendmsg+0x346/0x3f0
[    1.214157]  __sock_sendmsg+0x86/0xb0
[    1.214160]  ____sys_sendmsg+0x1c8/0x220
[    1.214164]  ___sys_sendmsg+0x28f/0x2d0
[    1.214179]  __x64_sys_sendmsg+0xef/0x140
[    1.214184]  do_syscall_64+0xec/0x1d0
[    1.214190]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.214191] RIP: 0033:0x7f2d1b4a7e56

Device setup:

     netdevsim0 (down)
     ^        ^
  bond        netdevsim1.100@netdevsim1 allmulticast=on (down)

When we enslave the lower device (netdevsim0) which has a vlan, we
propagate vlan's allmuti/promisc flags during ndo_open. This causes
(re)locking on of the real_dev.

Propagate allmulti/promisc on flags change, not on the open. There
is a slight semantics change that vlans that are down now propagate
the flags, but this seems unlikely to result in the real issues.

Reproducer:

  echo 0 1 > /sys/bus/netdevsim/new_device

  dev_path=$(ls -d /sys/bus/netdevsim/devices/netdevsim0/net/*)
  dev=$(echo $dev_path | rev | cut -d/ -f1 | rev)

  ip link set dev $dev name netdevsim0
  ip link set dev netdevsim0 up

  ip link add link netdevsim0 name netdevsim0.100 type vlan id 100
  ip link set dev netdevsim0.100 allmulticast on down
  ip link add name bond1 type bond mode 802.3ad
  ip link set dev netdevsim0 down
  ip link set dev netdevsim0 master bond1
  ip link set dev bond1 up
  ip link show

Reported-by: syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/Z9CfXjLMKn6VLG5d@mini-arch/T/#m15ba130f53227c883e79fb969687d69d670337a0
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250313100657.2287455-1-sdf@fomichev.me
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/8021q/vlan_dev.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 91d134961357c..ee7186e4d353b 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -273,17 +273,6 @@ static int vlan_dev_open(struct net_device *dev)
 			goto out;
 	}
 
-	if (dev->flags & IFF_ALLMULTI) {
-		err = dev_set_allmulti(real_dev, 1);
-		if (err < 0)
-			goto del_unicast;
-	}
-	if (dev->flags & IFF_PROMISC) {
-		err = dev_set_promiscuity(real_dev, 1);
-		if (err < 0)
-			goto clear_allmulti;
-	}
-
 	ether_addr_copy(vlan->real_dev_addr, real_dev->dev_addr);
 
 	if (vlan->flags & VLAN_FLAG_GVRP)
@@ -297,12 +286,6 @@ static int vlan_dev_open(struct net_device *dev)
 		netif_carrier_on(dev);
 	return 0;
 
-clear_allmulti:
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
 out:
 	netif_carrier_off(dev);
 	return err;
@@ -315,10 +298,6 @@ static int vlan_dev_stop(struct net_device *dev)
 
 	dev_mc_unsync(real_dev, dev);
 	dev_uc_unsync(real_dev, dev);
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-	if (dev->flags & IFF_PROMISC)
-		dev_set_promiscuity(real_dev, -1);
 
 	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
 		dev_uc_del(real_dev, dev->dev_addr);
@@ -490,12 +469,10 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 
-	if (dev->flags & IFF_UP) {
-		if (change & IFF_ALLMULTI)
-			dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
-			dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
-	}
+	if (change & IFF_ALLMULTI)
+		dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
+	if (change & IFF_PROMISC)
+		dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
 }
 
 static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
-- 
2.39.5


