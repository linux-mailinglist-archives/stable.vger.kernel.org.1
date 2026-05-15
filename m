Return-Path: <stable+bounces-247406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPGdAPbFBmpdngIAu9opvQ
	(envelope-from <stable+bounces-247406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDEA54A4D3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 366AD3068864
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393BB39A068;
	Fri, 15 May 2026 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HCwlnCpV"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99923932F2;
	Fri, 15 May 2026 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827858; cv=none; b=D244a0TI7Kf8QC1JpLSxZs+yk02lEXf3USsiwxFczlSX3qOmE+m6aYlB0i6WdJHNBX6mtkknrLJHlmVhAGceA4U80BDUWeh2Cgzo9WCsH0lkAamyB0etOll3tA3SwNBUJ9IW393gAo8lsBCVF4e5ARxZrWHw3H8dNFtXEwvOBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827858; c=relaxed/simple;
	bh=XRhCa08VVO3TJqLsrQpmWqneu7Yjwmi3yyTGBY2bW1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7mQfQZUe0TaRHyM+6G8ixr98DqitZpSmS/sMTMtgt+wLYAtZzbePCdwSXI9jZ6zCmHj9SZegBTnZ/tye+IXXdkmD8eXDqmJV5/xHmJ0COwA8UDfqRbeWFMwY/6qrtKmWiy93F3lw0EPDg4BDUAFP7cnWhoYKq9kqZs5rM2TAeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HCwlnCpV; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pW
	/tc3tkuQTH/abGF/d2gvg8c3yJSFH791/HNtDzr2k=; b=HCwlnCpV7jFc0lkYl8
	HAbKPZLquktYu03dZuglAKwwLIjCwoIaP2z2w2kcaIGhT0IJN74+8mpSA9liuRfe
	FWTY6ElOHSo2Xd1Ea9K99BDaCgE138aVDnQdS0eR1XvT6tH6tv3fmjuRlCdRpN69
	7jVapihtQrwdF1Oc2DpAqd+tk=
Received: from 163.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB3g_MjwgZqrjbBDg--.3469S2;
	Fri, 15 May 2026 14:50:22 +0800 (CST)
From: <w15303746062@163.com>
To: pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greg@kroah.com,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v3] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
Date: Fri, 15 May 2026 14:50:09 +0800
Message-Id: <20260515065009.383265-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <505b56bd-e5fd-4feb-a6e3-1d8269609277@molgen.mpg.de>
References: <505b56bd-e5fd-4feb-a6e3-1d8269609277@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB3g_MjwgZqrjbBDg--.3469S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw43Kr1DZFyDZF13JFWfAFb_yoW5KF4DpF
	sxKF98AF4ktr4qkF1DZa1xAFyrKF4IgFW2k34fX3y5X3Z8tr4vk3WIkFWIgF1UArZ5Cr4S
	vFWDX3y5W3WUZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQtxgUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-w7Xu2oGwi5OOgAA3p
X-Rspamd-Queue-Id: 7EDEA54A4D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247406-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[163.com:s=s110527];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[molgen.mpg.de,holtmann.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.194];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

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
   tty_ldisc_close+0x113/0x1a0
   tty_ldisc_kill+0x8e/0x150
   tty_ldisc_hangup+0x3c1/0x730
   __tty_hangup.part.0+0x3fd/0x8a0
   tty_ioctl+0x120f/0x1690
   __x64_sys_ioctl+0x18f/0x210
   do_syscall_64+0xcb/0xfa0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

The issue arises because the workqueues (init_ready and write_work) are
only cancelled if the HCI_UART_PROTO_READY flag is set. However, during
the protocol initialization phase (HCI_UART_PROTO_INIT), the underlying
protocol may schedule work. If a hangup occurs before the setup completes
and the READY flag is set, hci_uart_tty_close() skips the cancel_work_sync()
calls and proceeds to free the `hu` struct. When the delayed workqueue
executes, it blindly dereferences the freed `hu` struct.

Fix this by moving the cancel_work_sync() calls outside the
HCI_UART_PROTO_READY check, ensuring that any pending works are
unconditionally cancelled before the hci_uart structure is freed.
Note that hu->init_ready and hu->write_work are initialized in
hci_uart_tty_open(), so it is always safe to call cancel_work_sync()
on them in hci_uart_tty_close(), even if the protocol was never
fully attached.

Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v3:
- Added 'Cc: stable' tag as requested by the stable bot.

Changes in v2:
- Added KASAN/ODEBUG crash trace.

 drivers/bluetooth/hci_ldisc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 275ea865bc29..566e1c525ee2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -544,14 +544,18 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (hdev)
 		hci_uart_close(hdev);
 
+	/*
+	 * Always cancel workqueues unconditionally before freeing the hu
+	 * struct, as they might be active during the PROTO_INIT phase.
+	 */
+	cancel_work_sync(&hu->init_ready);
+	cancel_work_sync(&hu->write_work);
+
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
 		percpu_down_write(&hu->proto_lock);
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


