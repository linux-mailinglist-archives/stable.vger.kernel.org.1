Return-Path: <stable+bounces-116024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222B9A346EE
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AB23B051C
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3214A605;
	Thu, 13 Feb 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="LgcXtzIT"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960926B0BC;
	Thu, 13 Feb 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460061; cv=none; b=hzgCtfpOgqyXAcxDZL/RV6nbLHVATo481B53UF+jLMPE37mxwRbHxHAFPlHPmcWyug+cMuGhjm1dESH0/KmHbvmmoV6hU6LTrRNs6fM0JsjylSUx84p8IBWR7NQjqyiWemzZwFRczaG/3ELbmDaQrD0F/98vJYOC1q8YUo+f8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460061; c=relaxed/simple;
	bh=nmhmyKSXub73/+aWDhyFdWTvhRwpRULOLtywJYSza5M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JKVJDu9r/foIcWWHODkN0XL/DmdK3kdL95JJ+14Qjim9ljmuHOdqFqr1Y/vhQtxxi3CEVdvJIvnl5snzNkG+7DpsbXrGiDN/CQG7B4k3Unm6lpOF2cqeQv1NoR5f6BHEErHKp/58AnyTutzX00CGAo+bfuMDvJUL/GAwXUnH0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=LgcXtzIT; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 0D1CD107A1FF;
	Thu, 13 Feb 2025 18:20:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 0D1CD107A1FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1739460056; bh=oDBZgS0LvCAOwl9KAI0VZGWj3MzWfjnrSjgqwEu87aM=;
	h=From:To:CC:Subject:Date:From;
	b=LgcXtzIT8JIgaHQV/U9NQ0nS61wlamHG2RCW+IJureXht8PEtmWiPo0vDrBHknbjP
	 GK3OV2VjeOOSYE5ZWsLYKuuS0ITe5twxfcRnHYJYgA5V9gTj/dSoY7K3dZzWZSfaKp
	 v15MLZ1h4939ENEhsfcU6moaXRHhkGEguDGnPlzE=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 0A4C93045BD9;
	Thu, 13 Feb 2025 18:20:56 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Neil Horman <nhorman@tuxdriver.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net v2] drop_monitor: fix incorrect initialization order
Thread-Topic: [PATCH net v2] drop_monitor: fix incorrect initialization order
Thread-Index: AQHbfirgcCODksRtTEas1TVLuluoiQ==
Date: Thu, 13 Feb 2025 15:20:55 +0000
Message-ID: <20250213152054.2785669-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2025/02/13 14:35:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/02/13 13:56:00 #27204801
X-KLMS-AntiVirus-Status: Clean, skipped

Syzkaller reports the following bug:

BUG: spinlock bad magic on CPU#1, syz-executor.0/7995
 lock: 0xffff88805303f3e0, .magic: 00000000, .owner: <none>/-1, .owner_cpu:=
 0
CPU: 1 PID: 7995 Comm: syz-executor.0 Tainted: G            E     5.10.209+=
 #1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference=
 Platform, BIOS 6.00 11/12/2020
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x119/0x179 lib/dump_stack.c:118
 debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
 do_raw_spin_lock+0x1f6/0x270 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
 _raw_spin_lock_irqsave+0x50/0x70 kernel/locking/spinlock.c:159
 reset_per_cpu_data+0xe6/0x240 [drop_monitor]
 net_dm_cmd_trace+0x43d/0x17a0 [drop_monitor]
 genl_family_rcv_msg_doit+0x22f/0x330 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x14d/0x440 net/netlink/af_netlink.c:2497
 genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x54b/0x800 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x914/0xe00 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:651 [inline]
 __sock_sendmsg+0x157/0x190 net/socket.c:663
 ____sys_sendmsg+0x712/0x870 net/socket.c:2378
 ___sys_sendmsg+0xf8/0x170 net/socket.c:2432
 __sys_sendmsg+0xea/0x1b0 net/socket.c:2461
 do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x62/0xc7
RIP: 0033:0x7f3f9815aee9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3f972bf0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3f9826d050 RCX: 00007f3f9815aee9
RDX: 0000000020000000 RSI: 0000000020001300 RDI: 0000000000000007
RBP: 00007f3f981b63bd R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f3f9826d050 R15: 00007ffe01ee6768

If drop_monitor is built as a kernel module, syzkaller may have time
to send a netlink NET_DM_CMD_START message during the module loading.
This will call the net_dm_monitor_start() function that uses
a spinlock that has not yet been initialized.

To fix this, let's place resource initialization above the registration
of a generic netlink family.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller.

Fixes: 9a8afc8d3962 ("Network Drop Monitor: Adding drop monitor implementat=
ion & Netlink protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
V2:
- Move the registration of the netlink family to the end of the module init=
ialization function
 net/core/drop_monitor.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 6efd4cccc9dd..212f0a048cab 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1734,30 +1734,30 @@ static int __init init_net_drop_monitor(void)
 		return -ENOSPC;
 	}
=20
-	rc =3D genl_register_family(&net_drop_monitor_family);
-	if (rc) {
-		pr_err("Could not create drop monitor netlink family\n");
-		return rc;
+	for_each_possible_cpu(cpu) {
+		net_dm_cpu_data_init(cpu);
+		net_dm_hw_cpu_data_init(cpu);
 	}
-	WARN_ON(net_drop_monitor_family.mcgrp_offset !=3D NET_DM_GRP_ALERT);
=20
 	rc =3D register_netdevice_notifier(&dropmon_net_notifier);
 	if (rc < 0) {
 		pr_crit("Failed to register netdevice notifier\n");
+		return rc;
+	}
+
+	rc =3D genl_register_family(&net_drop_monitor_family);
+	if (rc) {
+		pr_err("Could not create drop monitor netlink family\n");
 		goto out_unreg;
 	}
+	WARN_ON(net_drop_monitor_family.mcgrp_offset !=3D NET_DM_GRP_ALERT);
=20
 	rc =3D 0;
=20
-	for_each_possible_cpu(cpu) {
-		net_dm_cpu_data_init(cpu);
-		net_dm_hw_cpu_data_init(cpu);
-	}
-
 	goto out;
=20
 out_unreg:
-	genl_unregister_family(&net_drop_monitor_family);
+	WARN_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 out:
 	return rc;
 }
@@ -1766,19 +1766,18 @@ static void exit_net_drop_monitor(void)
 {
 	int cpu;
=20
-	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
-
 	/*
 	 * Because of the module_get/put we do in the trace state change path
 	 * we are guaranteed not to have any current users when we get here
 	 */
+	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
+
+	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
=20
 	for_each_possible_cpu(cpu) {
 		net_dm_hw_cpu_data_fini(cpu);
 		net_dm_cpu_data_fini(cpu);
 	}
-
-	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
 }
=20
 module_init(init_net_drop_monitor);
--=20
2.39.5

