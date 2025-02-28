Return-Path: <stable+bounces-119923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E314A49538
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD277A6703
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635262571A9;
	Fri, 28 Feb 2025 09:36:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9F2561B7;
	Fri, 28 Feb 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735365; cv=none; b=XgY7uy3yo+KT0fgnozbWi0CzoP/xCoWfn6LfbIoOu9gYu+klM5cg64LcXYz807MTtPxlFQyfb0/ZNRu2T/i4VowtOWafTRIcG8iPORUPKK9GqUmzfDbTW7DpIAmUtG9ZlkzHnr1nfhKdL0rzKYFH8Aw8AFAvbvslgwleYofoq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735365; c=relaxed/simple;
	bh=dvVuHsyaV1YMTJAXpLJmRkJdJcnxyYSL+ei2Hl8HF60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DSEmoV1dYge/Zblg6a/6SQCU8QQCuS7X+2TmumjdS4+RNbLo/QreWgchg3Txr+oACbCW9tutBL6xkvM2j2K4OtBal5N33Yx0gJZfEFr4eW6pBpW0L/joK368LhvYNfwo0mzZUwY5qOxzEYwQCunD+O7fLfTcT2GawX0gk/i1P+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id E0F5E1FA1C;
	Fri, 28 Feb 2025 12:35:49 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 28 Feb 2025 12:35:48 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.117])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z433j4lgKzkWxV;
	Fri, 28 Feb 2025 12:35:45 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com,
	Octavian Purdila <tavip@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH 5.10/5.15] team: prevent adding a device which is already a team device lower
Date: Fri, 28 Feb 2025 12:35:04 +0300
Message-Id: <20250228093504.31062-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/02/28 06:59:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_one_url}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;syzkaller.appspot.com:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191369 [Feb 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/02/28 06:44:00 #27492638
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/02/28 07:00:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Octavian Purdila <tavip@google.com>

commit 3fff5da4ca2164bb4d0f1e6cd33f6eb8a0e73e50 upstream.

Prevent adding a device which is already a team device lower,
e.g. adding veth0 if vlan1 was already added and veth0 is a lower of
vlan1.

This is not useful in practice and can lead to recursive locking:

$ ip link add veth0 type veth peer name veth1
$ ip link set veth0 up
$ ip link set veth1 up
$ ip link add link veth0 name veth0.1 type vlan protocol 802.1Q id 1
$ ip link add team0 type team
$ ip link set veth0.1 down
$ ip link set veth0.1 master team0
team0: Port device veth0.1 added
$ ip link set veth0 down
$ ip link set veth0 master team0

============================================
WARNING: possible recursive locking detected
6.13.0-rc2-virtme-00441-ga14a429069bb #46 Not tainted
--------------------------------------------
ip/7684 is trying to acquire lock:
ffff888016848e00 (team->team_lock_key){+.+.}-{4:4}, at: team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)

but task is already holding lock:
ffff888016848e00 (team->team_lock_key){+.+.}-{4:4}, at: team_add_slave (drivers/net/team/team_core.c:1147 drivers/net/team/team_core.c:1977)

other info that might help us debug this:
Possible unsafe locking scenario:

CPU0
----
lock(team->team_lock_key);
lock(team->team_lock_key);

*** DEADLOCK ***

May be due to missing lock nesting notation

2 locks held by ip/7684:

stack backtrace:
CPU: 3 UID: 0 PID: 7684 Comm: ip Not tainted 6.13.0-rc2-virtme-00441-ga14a429069bb #46
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:122)
print_deadlock_bug.cold (kernel/locking/lockdep.c:3040)
__lock_acquire (kernel/locking/lockdep.c:3893 kernel/locking/lockdep.c:5226)
? netlink_broadcast_filtered (net/netlink/af_netlink.c:1548)
lock_acquire.part.0 (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
? trace_lock_acquire (./include/trace/events/lock.h:24 (discriminator 2))
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
? lock_acquire (kernel/locking/lockdep.c:5822)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
__mutex_lock (kernel/locking/mutex.c:587 kernel/locking/mutex.c:735)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
? fib_sync_up (net/ipv4/fib_semantics.c:2167)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
notifier_call_chain (kernel/notifier.c:85)
call_netdevice_notifiers_info (net/core/dev.c:1996)
__dev_notify_flags (net/core/dev.c:8993)
? __dev_change_flags (net/core/dev.c:8975)
dev_change_flags (net/core/dev.c:9027)
vlan_device_event (net/8021q/vlan.c:85 net/8021q/vlan.c:470)
? br_device_event (net/bridge/br.c:143)
notifier_call_chain (kernel/notifier.c:85)
call_netdevice_notifiers_info (net/core/dev.c:1996)
dev_open (net/core/dev.c:1519 net/core/dev.c:1505)
team_add_slave (drivers/net/team/team_core.c:1219 drivers/net/team/team_core.c:1977)
? __pfx_team_add_slave (drivers/net/team/team_core.c:1972)
do_set_master (net/core/rtnetlink.c:2917)
do_setlink.isra.0 (net/core/rtnetlink.c:3117)

Reported-by: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Alexey: fixed path from team_core.c to team.c to resolve merge conflict]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 drivers/net/team/team.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 5e5af71a85ac..015151cd2222 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1166,6 +1166,13 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EBUSY;
 	}
 
+	if (netdev_has_upper_dev(port_dev, dev)) {
+		NL_SET_ERR_MSG(extack, "Device is already a lower device of the team interface");
+		netdev_err(dev, "Device %s is already a lower device of the team interface\n",
+			   portname);
+		return -EBUSY;
+	}
+
 	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
 	    vlan_uses_dev(dev)) {
 		NL_SET_ERR_MSG(extack, "Device is VLAN challenged and team device has VLAN set up");
-- 
2.30.2


