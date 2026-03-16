Return-Path: <stable+bounces-225522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N84NrPgt2mcWAEAu9opvQ
	(envelope-from <stable+bounces-225522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:51:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 548452983FB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D760D300D159
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10CC38F659;
	Mon, 16 Mar 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Wg+EpSmr"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEC38F647;
	Mon, 16 Mar 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658148; cv=none; b=h/ToasZI4aLv2/crV2Kz0A+xzyUFnzMLe6V+OOT+9wmi/HucjDGXTOpsl4EU07i0NuE5i8dhn0teDgqcDHDccqqiIz55E88W1pmwz/LUYX6KvpLLN9R0dMm3IdWILzMJ+nb/f2BNL5q6wVtNjYkMNIPQLBiAKGwmcn0fVEw1xgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658148; c=relaxed/simple;
	bh=pcBInRXljuxWY7idQ1IavWdC4W1j9biZUfLQAdA/ZYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQn2vXf8zo1RPg57YDLmoArkY8BTLx3BFNaZr56ffBEyOy4PtIn6QDvJZ645lmhhiCiajqVkn1PtA3CJlrUZ+ReyHhViYcYZcwoHbkfT590G7PcV951uEbc3Wd5xXUirZH4xPs/Hj50LLKV5/QV6yc6644ZcoNXVhIO9NNbYNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Wg+EpSmr; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.34])
	by mail.ispras.ru (Postfix) with ESMTPSA id 08BA5413A4D8;
	Mon, 16 Mar 2026 10:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 08BA5413A4D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1773657568;
	bh=cNyD/KYGWkpwWO1lBjOBW0L9+aqawWpVjwVrtSSo5fs=;
	h=From:To:Cc:Subject:Date:From;
	b=Wg+EpSmryxhx46thTb9IQiXZJqjaAtV4V6NYGkZZ9nQP6TyrsBiyYX2ceuKNVCbn/
	 GzQcf/5P5rG5XQT0RrytCnW/zW6CYv3uj/gHNjM8F3FMvqFrsmjg6NPuJG8lrm3FVt
	 +5uzZ5wuo/NA57vqks736YHjuH5qsBvUrKfUlLN8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rafal Ozieblo <rafalo@cadence.com>,
	"Andrei.Pistirica@microchip.com" <Andrei.Pistirica@microchip.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: macb: fix use-after-free access to PTP clock
Date: Mon, 16 Mar 2026 13:38:24 +0300
Message-ID: <20260316103826.74506-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[ispras.ru,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,cadence.com,microchip.com,vger.kernel.org,linuxtesting.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225522-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,qemu.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ispras.ru:dkim,ispras.ru:email,ispras.ru:mid]
X-Rspamd-Queue-Id: 548452983FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PTP clock is registered on every opening of the interface and destroyed on
every closing.  However it may be accessed via get_ts_info ethtool call
which is possible while the interface is just present in the kernel.

BUG: KASAN: use-after-free in ptp_clock_index+0x47/0x50 drivers/ptp/ptp_clock.c:426
Read of size 4 at addr ffff8880194345cc by task syz.0.6/948

CPU: 1 PID: 948 Comm: syz.0.6 Not tainted 6.1.164+ #109
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xba lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:316 [inline]
 print_report+0x17f/0x496 mm/kasan/report.c:420
 kasan_report+0xd9/0x180 mm/kasan/report.c:524
 ptp_clock_index+0x47/0x50 drivers/ptp/ptp_clock.c:426
 gem_get_ts_info+0x138/0x1e0 drivers/net/ethernet/cadence/macb_main.c:3349
 macb_get_ts_info+0x68/0xb0 drivers/net/ethernet/cadence/macb_main.c:3371
 __ethtool_get_ts_info+0x17c/0x260 net/ethtool/common.c:558
 ethtool_get_ts_info net/ethtool/ioctl.c:2367 [inline]
 __dev_ethtool net/ethtool/ioctl.c:3017 [inline]
 dev_ethtool+0x2b05/0x6290 net/ethtool/ioctl.c:3095
 dev_ioctl+0x637/0x1070 net/core/dev_ioctl.c:510
 sock_do_ioctl+0x20d/0x2c0 net/socket.c:1215
 sock_ioctl+0x577/0x6d0 net/socket.c:1320
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18c/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:46 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 </TASK>

Allocated by task 457:
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:699 [inline]
 ptp_clock_register+0x144/0x10e0 drivers/ptp/ptp_clock.c:235
 gem_ptp_init+0x46f/0x930 drivers/net/ethernet/cadence/macb_ptp.c:375
 macb_open+0x901/0xd10 drivers/net/ethernet/cadence/macb_main.c:2920
 __dev_open+0x2ce/0x500 net/core/dev.c:1501
 __dev_change_flags+0x56a/0x740 net/core/dev.c:8651
 dev_change_flags+0x92/0x170 net/core/dev.c:8722
 do_setlink+0xaf8/0x3a80 net/core/rtnetlink.c:2833
 __rtnl_newlink+0xbf4/0x1940 net/core/rtnetlink.c:3608
 rtnl_newlink+0x63/0xa0 net/core/rtnetlink.c:3655
 rtnetlink_rcv_msg+0x3c6/0xed0 net/core/rtnetlink.c:6150
 netlink_rcv_skb+0x15d/0x430 net/netlink/af_netlink.c:2511
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x6d7/0xa30 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x97e/0xeb0 net/netlink/af_netlink.c:1872
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x14b/0x180 net/socket.c:730
 __sys_sendto+0x320/0x3b0 net/socket.c:2152
 __do_sys_sendto net/socket.c:2164 [inline]
 __se_sys_sendto net/socket.c:2160 [inline]
 __x64_sys_sendto+0xdc/0x1b0 net/socket.c:2160
 do_syscall_x64 arch/x86/entry/common.c:46 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Freed by task 938:
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1729 [inline]
 slab_free_freelist_hook mm/slub.c:1755 [inline]
 slab_free mm/slub.c:3687 [inline]
 __kmem_cache_free+0xbc/0x320 mm/slub.c:3700
 device_release+0xa0/0x240 drivers/base/core.c:2507
 kobject_cleanup lib/kobject.c:681 [inline]
 kobject_release lib/kobject.c:712 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1cd/0x350 lib/kobject.c:729
 put_device+0x1b/0x30 drivers/base/core.c:3805
 ptp_clock_unregister+0x171/0x270 drivers/ptp/ptp_clock.c:391
 gem_ptp_remove+0x4e/0x1f0 drivers/net/ethernet/cadence/macb_ptp.c:404
 macb_close+0x1c8/0x270 drivers/net/ethernet/cadence/macb_main.c:2966
 __dev_close_many+0x1b9/0x310 net/core/dev.c:1585
 __dev_close net/core/dev.c:1597 [inline]
 __dev_change_flags+0x2bb/0x740 net/core/dev.c:8649
 dev_change_flags+0x92/0x170 net/core/dev.c:8722
 dev_ifsioc+0x151/0xe00 net/core/dev_ioctl.c:326
 dev_ioctl+0x33e/0x1070 net/core/dev_ioctl.c:572
 sock_do_ioctl+0x20d/0x2c0 net/socket.c:1215
 sock_ioctl+0x577/0x6d0 net/socket.c:1320
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18c/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:46 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Set the PTP clock pointer to NULL after unregistering.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: c2594d804d5c ("macb: Common code to enable ptp support for MACB/GEM")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index c9e77819196e..d91f7b1aa39c 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -357,8 +357,10 @@ void gem_ptp_remove(struct net_device *ndev)
 {
 	struct macb *bp = netdev_priv(ndev);
 
-	if (bp->ptp_clock)
+	if (bp->ptp_clock) {
 		ptp_clock_unregister(bp->ptp_clock);
+		bp->ptp_clock = NULL;
+	}
 
 	gem_ptp_clear_timer(bp);
 
-- 
2.53.0


