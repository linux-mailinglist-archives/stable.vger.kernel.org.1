Return-Path: <stable+bounces-247787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDInEwIuB2oLsgIAu9opvQ
	(envelope-from <stable+bounces-247787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:30:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A881A551765
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2327530A674B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580248C3FE;
	Fri, 15 May 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T3c7MisN"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3248BD48;
	Fri, 15 May 2026 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853999; cv=none; b=cuE0U6YjDjmLJax7yRNc7eVrmS9x3Gs8+9nQrBAcBvOmb0gDP/7CgKnrkTP4hYaKNvALssG0rSXVF/53YPRP/16+3wB3JE6KbQgat4iqjv1atW+yaxcxvm/kXx8vGQqxAaCmFAHSx+H32724U8eHs+dvKrEFoxE8E1UV+gWrxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853999; c=relaxed/simple;
	bh=k+83qw1aBVDXTHI3o0EJipdXbePWlFTgXyIEgtF1wPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbRtZ5Ab9HDYJphjipO1KLlDOydt6M+H75kImV3QHK4cAyx0xsoxLrRh4Dv7Q8CI+v3TnpQ5qDr6s/VRpUj+ZsTi5SOsbHYHsEtisIrrNsdiNuVS+8pN5JQwhoNrMAZr2S4KMXOybaStiunT1Mjz8qMIkZBBz+z0j3KdSYScafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T3c7MisN; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=En
	OKvtLKxGfFtXrnKl47IbY8wmgcrys1YAusjT/5P6A=; b=T3c7MisN4PwQOUSiYt
	M8Fxmt7OnjrKyq4S6U/L3RTD5m0YyioLrKOnkFYcCzmO6iox3tsGkbP3vqq8uMBf
	MhSV1R8hZ8+1JDZKmUsAapITjnf5JL7rJNLdifjpVG2gqai03hyEliUxeiwaAmlg
	9XMcsTyMahQ6SXGaoCWlS4bXs=
Received: from 163.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCH1RY9KAdqHenOEg--.16120S2;
	Fri, 15 May 2026 22:06:01 +0800 (CST)
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
Subject: [PATCH v4] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
Date: Fri, 15 May 2026 22:05:48 +0800
Message-Id: <20260515140548.393865-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZLjreYY_BczAQr2G6L=iJjBYKksFp53CairG-6V0Cb0EA@mail.gmail.com>
References: <CABBYNZLjreYY_BczAQr2G6L=iJjBYKksFp53CairG-6V0Cb0EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCH1RY9KAdqHenOEg--.16120S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw43Kr1DZFyDZF13JFWfAFb_yoWrXw1kpF
	ZxKF90yF4vqFWjkFyDZa1xJFyrKr4ag3y2k34fW3y5Xas8tr4jk3WIyFWIgF1UArs3Cr1S
	vFWDX3y5WryUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQAw3UUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-wl4XGoHKEm-FAAA31
X-Rspamd-Queue-Id: A881A551765
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
	TAGGED_FROM(0.00)[bounces-247787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[163.com:s=s110527];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[gmail.com,molgen.mpg.de,holtmann.org,vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.202];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xidian.edu.cn:email]
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
only flushed/cancelled if the HCI_UART_PROTO_READY flag is set. However,
during the protocol initialization phase (HCI_UART_PROTO_INIT), the
underlying protocol may schedule work. If a hangup occurs before the setup
completes and the READY flag is set, hci_uart_tty_close() skips the
teardown of these workqueues and proceeds to free the `hu` struct. When
the scheduled work executes later, it blindly dereferences the freed `hu`
struct.

Fix this by moving the workqueue teardown outside the HCI_UART_PROTO_READY
check. Furthermore, use disable_work_sync() instead of cancel_work_sync()
to unconditionally disable the works. This ensures that any pending works
are cancelled and no new submissions can occur before the hci_uart
structure is freed. Note that hu->init_ready and hu->write_work are
initialized in hci_uart_tty_open(), so it is always safe to call
disable_work_sync() on them in hci_uart_tty_close(), even if the protocol
was never fully attached.

Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
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
index 275ea865bc29..333c1e1503e8 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -544,14 +544,20 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (hdev)
 		hci_uart_close(hdev);
 
+	/*
+	 * Disable workqueues unconditionally before freeing the hu
+	 * struct, as they might be active during the PROTO_INIT phase.
+	 * Using disable_work_sync() instead of cancel_work_sync()
+	 * ensures no new submissions can occur.
+	 */
+	disable_work_sync(&hu->init_ready);
+	disable_work_sync(&hu->write_work);
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


