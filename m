Return-Path: <stable+bounces-238071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGaSApVW32ndRwAAu9opvQ
	(envelope-from <stable+bounces-238071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:12:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 701BE402643
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4859303534A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433932548B;
	Wed, 15 Apr 2026 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="hvAf9HGv"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798330C615
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244369; cv=none; b=azSGXC9XXLlbb5eyWwDW0OKz0EMhEDrsN2V87PmssfUwJ5I1u31DShnu9XusdKvSqfvFsRWeo/VGk9lw6kTErTWvzWj7xxWb72yponAVqdKKNv1p1w8dUsUJbVK0DqSKjbEb4+onBJkHqymBkR6Z+FZJ9ThsN2AwZZJDdeJ7qK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244369; c=relaxed/simple;
	bh=yfclkAB7E5ds4+hwkFdnTQDSortSjRwz0S9wHkoy6UM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdYAgm7ht07+TFc5spF5I5nKFnZzQ61YfTyjo9wBS6d8mpfWUFeAsEL6hbxBANExVUByLjwFSsX7MKp6mtlJQe6++xus2Qz4O+/500wo42RbUFg5QKXCY0ARepFTa5/V+PElsFoU/Bfvor874KfoWZCL4kNGXdeNWG2+LuoY6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=hvAf9HGv; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=hvAf9HGvxe2eAaOFPmaVwC/zfqTMjUIvuXuyEmJ/fiPKBDlfn9pZUrE4+l1EyrxrW57g2VRZsQyX3
	 Xed+N/7df9wafappMIJ3RJIlJLAkvykdrq4SUTM36YdpGFdnYy1QAGF+A3WlZWvlzylCH3DLpCf66I
	 5l6w6SntB59EcTEw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.104.41.126])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f3769df5680d70-028b0;
	Wed, 15 Apr 2026 17:12:38 +0800 (CST)
X-RM-TRANSID:2f3769df5680d70-028b0
From: Rajani Kantha <681739313@139.com>
To: liuhangbin@gmail.com,
	razor@blackwall.org,
	toke@redhat.com,
	kuba@kernel.org,
	wangliang74@huawei.com,
	joamaki@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y 2/2] bonding: check xdp prog when set bond mode
Date: Wed, 15 Apr 2026 17:12:32 +0800
Message-Id: <20260415091232.3244-3-681739313@139.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260415091232.3244-1-681739313@139.com>
References: <20260415091232.3244-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238071-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,blackwall.org,redhat.com,kernel.org,huawei.com,vger.kernel.org];
	DMARC_NA(0.00)[139.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[139.com:-];
	NEURAL_HAM(-0.00)[-0.912];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: 701BE402643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
[ Ignore changes in bond_xdp_set_features(), it was introduced to kernel
in commit:cb9e6e584d58 ("bonding: add xdp_features support") since 6.4 ]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/bonding/bond_main.c    | 6 +++---
 drivers/net/bonding/bond_options.c | 3 +++
 include/net/bonding.h              | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c6b4f681c70d..14e7439717a3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -320,9 +320,9 @@ bool bond_sk_check(struct bonding *bond)
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
@@ -5636,7 +5636,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond)) {
+	if (!bond_xdp_check(bond, BOND_MODE(bond))) {
 		BOND_NL_ERR(dev, extack,
 			    "No native XDP support for the current bonding mode");
 		return -EOPNOTSUPP;
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 9473e76c6dc9..62b5d29e6db6 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -881,6 +881,9 @@ static bool bond_set_tls_features(struct bonding *bond)
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
index bdfbe77c1842..0a84a63d5e32 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -701,6 +701,7 @@ void bond_debug_register(struct bonding *bond);
 void bond_debug_unregister(struct bonding *bond);
 void bond_debug_reregister(struct bonding *bond);
 const char *bond_mode_name(int mode);
+bool bond_xdp_check(struct bonding *bond, int mode);
 void bond_setup(struct net_device *bond_dev);
 unsigned int bond_get_num_tx_queues(void);
 int bond_netlink_init(void);
-- 
2.35.3



