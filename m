Return-Path: <stable+bounces-248966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nVivIAnVB2ogKwMAu9opvQ
	(envelope-from <stable+bounces-248966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:23:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5201559E18
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03FB93017F80
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736BA28313D;
	Sat, 16 May 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VrQQQOYT"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC91CFBA;
	Sat, 16 May 2026 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898181; cv=none; b=HOFic4CY3oROxgAQY99DTabEvkQtJE2H78/ypnVnhlxK3peBTpf3AcP1vZdXSrJ+G76y7Opns9/pO+whxR0JrSpW/f9X+85F2HQpOl+nKeXE7o2VsfJCzubqQK0Kg9xg/UdXc16Z6m4+V0H5EkoNC8vYToKjxggRqgZR3kzfusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898181; c=relaxed/simple;
	bh=vZ8HI72OFbthSBJEsoHa2z/u4GgfSwQeyQsy/GOGEXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGU6PITCWrRKWL4GtwBptUzrSHInGdFTqCH1EtZm+YzGweOoFlysq4qgPj37jSpmr/okzk0YomWpG+napEKbee99y0PDyxx5t6EpSQAbaK7tcBXWSfixqmwE+EBsoIJBnRg62US9Y3MqwBgUBaRGRCAA5YASq3zRIUt5cAZxBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VrQQQOYT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o8
	Z/FOlH+CBwFDIxdt/BJ/uYRlERnR/Hp8g+li8D4z8=; b=VrQQQOYT2D/sBVieqQ
	5pYNcoA55AtWkEPn68KYtgm8wdwfO4PM6fXWrf71YE/mGq+6FZxr7Obxp2CpUhp4
	v5Ir34BEG+ZL37zKwJ8ypgYSpfZ5Ucqqe28+zlRk5JYKka9qqr6XX94KnPLmjXyQ
	lA55Z0kqYUhwNn8gIxheNc3P4=
Received: from 163.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Vy_K1Adq3dBFDg--.212S2;
	Sat, 16 May 2026 10:22:15 +0800 (CST)
From: <w15303746062@163.com>
To: luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greg@kroah.com,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v5] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
Date: Sat, 16 May 2026 10:22:00 +0800
Message-Id: <20260516022200.396369-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
References: <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Vy_K1Adq3dBFDg--.212S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw43Kr1DZFyDZF13JFWfAFb_yoWrCw18pF
	9xKF90ya1DJFWjkFyDZa1xAFyrKFs2g3y2y34fW3y5Xwn8tr1jy3WIyFWI93WUAr95Cr1S
	vFWqq3y5WFyUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlQ6XUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-xfGqmoH1NcPIQAA3E
X-Rspamd-Queue-Id: E5201559E18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-248966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,molgen.mpg.de,holtmann.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xidian.edu.cn:email]
X-Rspamd-Action: no action

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A Use-After-Free (UAF) vulnerability and a subsequent kernel panic were
observed in hci_uart_write_work() due to a race condition between the
initialization of the HCI UART line discipline and concurrent TTY hangup.

This issue was triggered by our custom device emulation and fuzzing
framework (DevGen) on the v6.18 kernel. Due to the highly timing-dependent
nature of this race condition (requiring a precise interleaving of
TIOCVHANGUP and protocol setup), Syzkaller failed to extract a reliable
standalone C reproducer (reproducer is too unreliable: 0.00).

The crash trace is as follows:
  ODEBUG: free active (active state 0) object: ffff88804024e870 object type: work_struct hint: hci_uart_write_work+0x0/0x940
  WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0
  ...
  Call Trace:
   <TASK>
   debug_check_no_obj_freed+0x3ec/0x520
   kfree+0x3f0/0x6c0
   hci_uart_tty_close+0x127/0x2a0
   k_ldisc_close+0x113/0x1a0
   tty_ldisc_kill+0x8e/0x150
   tty_ldisc_hangup+0x3c1/0x730
   __tty_hangup.part.0+0x3fd/0x8a0
   tty_ioctl+0x120f/0x1690
   __x64_sys_ioctl+0x18f/0x210
   do_syscall_64+0xcb/0xfa0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

The issue arises because the workqueues (init_ready and write_work) are
only flushed/cancelled if the HCI_UART_PROTO_READY flag is set. However,
during the protocol initialization phase (HCI_UART_PROTO_INIT), the
underlying protocol may schedule work. If a hangup occurs before the setup
completes and the READY flag is set, hci_uart_tty_close() skips the
teardown of these workqueues and proceeds to free the `hu` struct. When
the scheduled work executes later, it blindly dereferences the freed `hu`
struct.

Fix this by moving the workqueue teardown to the very beginning of
hci_uart_tty_close(), outside the HCI_UART_PROTO_READY check and prior to
calling hci_uart_close(). Furthermore, use disable_work_sync() instead of
cancel_work_sync() to unconditionally disable the works. This ensures that
any pending works are cancelled and no new submissions can occur before or
during the teardown of the device connection. Note that hu->init_ready and
hu->write_work are initialized in hci_uart_tty_open(), so it is always safe
to call disable_work_sync() on them in hci_uart_tty_close(), even if the
protocol was never fully attached.

Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v5:
- Moved disable_work_sync() to the very top of hci_uart_tty_close(), 
  before hci_uart_close(), to prevent any concurrent re-queuing 
  during device shutdown and resolve Sashiko static analysis warnings.

Changes in v4:
- Adopted Luiz's suggestion to use disable_work_sync() instead of 
  cancel_work_sync() to prevent new work submissions during teardown.

Changes in v3:
- Added 'Cc: stable' tag as requested by the stable bot.

Changes in v2:
- Added KASAN/ODEBUG crash trace.

 drivers/bluetooth/hci_ldisc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 275ea865bc29..ebdbcd567cd2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -540,6 +540,15 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (!hu)
 		return;
 
+	/*
+	 * Disable workqueues unconditionally before tearing down the
+	 * connection, as they might be active during the PROTO_INIT phase.
+	 * Using disable_work_sync() ensures no new submissions can occur
+	 * during or after hci_uart_close().
+	 */
+	disable_work_sync(&hu->init_ready);
+	disable_work_sync(&hu->write_work);
+
 	hdev = hu->hdev;
 	if (hdev)
 		hci_uart_close(hdev);
@@ -549,9 +558,6 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
 
-		cancel_work_sync(&hu->init_ready);
-		cancel_work_sync(&hu->write_work);
-
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
-- 
2.34.1


