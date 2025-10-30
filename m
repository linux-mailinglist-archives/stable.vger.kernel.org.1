Return-Path: <stable+bounces-191695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C113C1EA85
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5189E1884F96
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AED2EA48F;
	Thu, 30 Oct 2025 07:00:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEED189F3B
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807614; cv=none; b=JZW6R0ex9/gdqchei/HZqCBie2aLjfo1EMyxjXy5SqdegIxL8EcZZpWUyJaW9CBW3St3v/ozUtoKEnpiXI81pooL9l64c7BcxiXlbRE556E2ns+B5Z60is+76UiuDzyuA9rTeWDyIYUflA8Qf5c0XghDExpQwGnwXTZ1BXJF6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807614; c=relaxed/simple;
	bh=TwpBx720NbRIWpSZrX3RIk1BE617c0MB7uxFP5O62qU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frvJutGA4iVg3Yu06XC8Z4nVamZCgxnGzejt/4E/1g2hA4HUFjJBslG1s2o5qZboh7PpTn9xA+N8fj6Vd9IHmLXXNpieE4354S1/RbgNRMenbchD/v6ooxGYoDBDLCu86yq/igFgmoSik3fcFUlPs3XhYEnzYaL9Zgw3NkuBv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-01-12079 (RichMail) with SMTP id 2f2f69030cef717-4dea7;
	Thu, 30 Oct 2025 15:00:01 +0800 (CST)
X-RM-TRANSID:2f2f69030cef717-4dea7
From: Rajani Kantha <681739313@139.com>
To: razor@blackwall.org,
	toke@redhat.com,
	liuhangbin@gmail.com,
	kuba@kernel.org,
	joamaki@gmail.com,
	wangliang74@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 2/2] bonding: check xdp prog when set bond mode
Date: Thu, 30 Oct 2025 14:59:59 +0800
Message-Id: <20251030065959.8773-3-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251030065959.8773-1-681739313@139.com>
References: <20251030065959.8773-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit 094ee6017ea09c11d6af187935a949df32803ce0 ]

Following operations can trigger a warning[1]:

    ip netns add ns1
    ip netns exec ns1 ip link add bond0 type bond mode balance-rr
    ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
    ip netns exec ns1 ip link set bond0 type bond mode broadcast
    ip netns del ns1

When delete the namespace, dev_xdp_uninstall() is called to remove xdp
program on bond dev, and bond_xdp_set() will check the bond mode. If bond
mode is changed after attaching xdp program, the warning may occur.

Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
with xdp program attached is not good. Add check for xdp program when set
bond mode.

    [1]
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_many_notify+0x8d9/0x930
    Modules linked in:
    CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
    Workqueue: netns cleanup_net
    RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
    Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
    RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
    RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
    RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
    RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
    R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
    R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
    FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
    Call Trace:
     <TASK>
     ? __warn+0x83/0x130
     ? unregister_netdevice_many_notify+0x8d9/0x930
     ? report_bug+0x18e/0x1a0
     ? handle_bug+0x54/0x90
     ? exc_invalid_op+0x18/0x70
     ? asm_exc_invalid_op+0x1a/0x20
     ? unregister_netdevice_many_notify+0x8d9/0x930
     ? bond_net_exit_batch_rtnl+0x5c/0x90
     cleanup_net+0x237/0x3d0
     process_one_work+0x163/0x390
     worker_thread+0x293/0x3b0
     ? __pfx_worker_thread+0x10/0x10
     kthread+0xec/0x1e0
     ? __pfx_kthread+0x10/0x10
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x2f/0x50
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    ---[ end trace 0000000000000000 ]---

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Acked-by: Jussi Maki <joamaki@gmail.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://patch.msgid.link/20250321044852.1086551-1-wangliang74@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/bonding/bond_main.c    | 8 ++++----
 drivers/net/bonding/bond_options.c | 3 +++
 include/net/bonding.h              | 1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 93e6d069dfc6..f17a170d1be4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -322,9 +322,9 @@ static bool bond_sk_check(struct bonding *bond)
 	}
 }
 
-static bool bond_xdp_check(struct bonding *bond)
+bool bond_xdp_check(struct bonding *bond, int mode)
 {
-	switch (BOND_MODE(bond)) {
+	switch (mode) {
 	case BOND_MODE_ROUNDROBIN:
 	case BOND_MODE_ACTIVEBACKUP:
 		return true;
@@ -1930,7 +1930,7 @@ void bond_xdp_set_features(struct net_device *bond_dev)
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond) || !bond_has_slaves(bond)) {
+	if (!bond_xdp_check(bond, BOND_MODE(bond)) || !bond_has_slaves(bond)) {
 		xdp_clear_features_flag(bond_dev);
 		return;
 	}
@@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond)) {
+	if (!bond_xdp_check(bond, BOND_MODE(bond))) {
 		BOND_NL_ERR(dev, extack,
 			    "No native XDP support for the current bonding mode");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index e27d913b487b..28c53f1b1382 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -868,6 +868,9 @@ static bool bond_set_xfrm_features(struct bonding *bond)
 static int bond_option_mode_set(struct bonding *bond,
 				const struct bond_opt_value *newval)
 {
+	if (bond->xdp_prog && !bond_xdp_check(bond, newval->value))
+		return -EOPNOTSUPP;
+
 	if (!bond_mode_uses_arp(newval->value)) {
 		if (bond->params.arp_interval) {
 			netdev_dbg(bond->dev, "%s mode is incompatible with arp monitoring, start mii monitoring\n",
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 8bb5f016969f..95f67b308c19 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -695,6 +695,7 @@ void bond_debug_register(struct bonding *bond);
 void bond_debug_unregister(struct bonding *bond);
 void bond_debug_reregister(struct bonding *bond);
 const char *bond_mode_name(int mode);
+bool bond_xdp_check(struct bonding *bond, int mode);
 void bond_setup(struct net_device *bond_dev);
 unsigned int bond_get_num_tx_queues(void);
 int bond_netlink_init(void);
-- 
2.17.1



