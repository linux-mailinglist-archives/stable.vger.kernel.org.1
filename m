Return-Path: <stable+bounces-114362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17332A2D377
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 04:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BF2188B263
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 03:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75129D05;
	Sat,  8 Feb 2025 03:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oURtePUE"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBAA23
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738984744; cv=none; b=UGwhILkRhpbuejKkfBnjREisak9Ntjt7e5B+NhBHZj1tlzmnuSg6iNZ2PJkpYhX7fdcyJZxdiFBhE3UcFjS0PJrJ7UzeCj9PhgNska0dudtkJvDZKPyRJnFlImg3wevFdHHiq06gBzW5/7awk/PC2xVzbz7DqJrKdHsZtryvBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738984744; c=relaxed/simple;
	bh=hoSpC7mDXOP6ZiyReLiQXYh6jTg002IszuosWNakHRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lJvQOZ8V2G30G/gQQUThXK3YgrN0/XHZARUzo4udqyTIC8KuZjZiEB3YjTNvOscHo2uMJYrAL3E7vbFqeyCBF6cuEqHsqM9xu+wvhmHN0nHFldkIyuYliWld7EmHCWoel68kyiF68ILgTAzQ17SidaSzD5P21az1sEZeg1BK868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oURtePUE; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZQAai
	xR7p/PO+6OaJM4HdHAR0YYlk6sasWx47QNKzHA=; b=oURtePUEgqXx3mNG++754
	eHxPc5mV7v+FmFCq50Rc3EAu1oSCDNhEgBMt5e1Omoc2HoxSRhi+XPWzB3/td1GA
	EPT8Mz7lNY6f/IqDAeIWmkUrVxKWOCpPxWLq4itErF5MSq9c24POpkOEg6/A/LMw
	G4JkAMo11jed+1o8fEKcD8=
Received: from public (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXr_fhzKZn5NHgKQ--.22307S4;
	Sat, 08 Feb 2025 11:18:13 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y v2] net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events
Date: Sat,  8 Feb 2025 11:17:53 +0800
Message-Id: <20250208031753.988-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXr_fhzKZn5NHgKQ--.22307S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry3Gr1xCF4rKr18uw1UAwb_yoWrWr47pa
	1DGas3GrWUXrWqvw4UZF17CFWYq3Z5Wa4agFn3Gw1F9rsrtryUCryUAr90vr1jkrZ3Cry5
	t3WqvwnY93WYk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pM9avUUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiDwDtyGemwIb-4QAAsz

From: Vladimir Oltean <vladimir.oltean@nxp.com>

commit 844f104790bd69c2e4dbb9ee3eba46fde1fcea7b upstream.

After the blamed commit, we started doing this dereference for every
NETDEV_CHANGEUPPER and NETDEV_PRECHANGEUPPER event in the system.

static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
{
	struct dsa_user_priv *p = netdev_priv(dev);

	return p->dp;
}

Which is obviously bogus, because not all net_devices have a netdev_priv()
of type struct dsa_user_priv. But struct dsa_user_priv is fairly small,
and p->dp means dereferencing 8 bytes starting with offset 16. Most
drivers allocate that much private memory anyway, making our access not
fault, and we discard the bogus data quickly afterwards, so this wasn't
caught.

But the dummy interface is somewhat special in that it calls
alloc_netdev() with a priv size of 0. So every netdev_priv() dereference
is invalid, and we get this when we emit a NETDEV_PRECHANGEUPPER event
with a VLAN as its new upper:

$ ip link add dummy1 type dummy
$ ip link add link dummy1 name dummy1.100 type vlan id 100
[   43.309174] ==================================================================
[   43.316456] BUG: KASAN: slab-out-of-bounds in dsa_user_prechangeupper+0x30/0xe8
[   43.323835] Read of size 8 at addr ffff3f86481d2990 by task ip/374
[   43.330058]
[   43.342436] Call trace:
[   43.366542]  dsa_user_prechangeupper+0x30/0xe8
[   43.371024]  dsa_user_netdevice_event+0xb38/0xee8
[   43.375768]  notifier_call_chain+0xa4/0x210
[   43.379985]  raw_notifier_call_chain+0x24/0x38
[   43.384464]  __netdev_upper_dev_link+0x3ec/0x5d8
[   43.389120]  netdev_upper_dev_link+0x70/0xa8
[   43.393424]  register_vlan_dev+0x1bc/0x310
[   43.397554]  vlan_newlink+0x210/0x248
[   43.401247]  rtnl_newlink+0x9fc/0xe30
[   43.404942]  rtnetlink_rcv_msg+0x378/0x580

Avoid the kernel oops by dereferencing after the type check, as customary.

Fixes: 4c3f80d22b2e ("net: dsa: walk through all changeupper notifier functions")
Reported-and-tested-by: syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000001d4255060e87545c@google.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240110003354.2796778-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
v2: add the upstream commit in this commit log.
---
 net/dsa/slave.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 5fe075bf479e..caeb7e75b287 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2592,13 +2592,14 @@ EXPORT_SYMBOL_GPL(dsa_slave_dev_check);
 static int dsa_slave_changeupper(struct net_device *dev,
 				 struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
+	struct dsa_port *dp;
 
 	if (!dsa_slave_dev_check(dev))
 		return err;
 
+	dp = dsa_slave_to_port(dev);
 	extack = netdev_notifier_info_to_extack(&info->info);
 
 	if (netif_is_bridge_master(info->upper_dev)) {
@@ -2652,11 +2653,13 @@ static int dsa_slave_changeupper(struct net_device *dev,
 static int dsa_slave_prechangeupper(struct net_device *dev,
 				    struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp;
 
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	dp = dsa_slave_to_port(dev);
+
 	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
 		dsa_port_pre_bridge_leave(dp, info->upper_dev);
 	else if (netif_is_lag_master(info->upper_dev) && !info->linking)
-- 
2.43.0


