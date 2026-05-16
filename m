Return-Path: <stable+bounces-248971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OebFToBCGq9UgMAu9opvQ
	(envelope-from <stable+bounces-248971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 07:31:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958C55A4AE
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 07:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A1DA300720B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 05:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520FE2BDC2F;
	Sat, 16 May 2026 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sk+JemyJ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5B12FF69;
	Sat, 16 May 2026 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778909491; cv=none; b=M7s2vUlsbQX/B9SpjwxUu3uod18hCr6pGVxcRZrDJZe8zJ5Dnr53Wkmz5RRhuUaeTWzgAfjemwTM5z3ii4qhk1XOmvhgxpFou6qxasrbrKoH1ILcUz6JIZzL9jK8y9Lc3lBd5/TGX7bSvlrHmIM0Ex9Ly4qEhdV166E2Y6kb2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778909491; c=relaxed/simple;
	bh=viFVbCTUEGZlCx/T/JjdBigT2zl5htwyg4XSF9v/S2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3MucToHpixt3s5HCwE/enCOhxtTzOJkwhRDH3OppHvxZRbuBtL/l/pK1qA6ywc8w+MpsumL3PkZ4JsY2iuctdLmMuw6IoHEtgHvBj1Yd4Jjo8Bik2o7Dxkw1uDYh6zDl3PNIyHVxa5j/2YPrkodKhgXq9y2oymnk2F2gTECox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sk+JemyJ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=V+
	jmmf2+0iPvY5sybQeNTfbjIrV4zPW2sciKzAA1t6k=; b=Sk+JemyJ1Jf531qNIR
	YEtkC3yzaPc62dse6ClH9TVxhz12UqMd9JsqLfna7CWP5YNtC/JsiORxA30rYvVb
	BlW123DBuasBQgLhFwGPp2Tw9AgJA08MIiQnPsCfqEh5HOFWSBj2x5t6Xn8hZsUx
	lxhhYVOlnnNraUfrafvoUt5LI=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3hbP+AAhqSd3aDw--.5S2;
	Sat, 16 May 2026 13:30:49 +0800 (CST)
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
Subject: [PATCH v6] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
Date: Sat, 16 May 2026 13:30:36 +0800
Message-Id: <20260516053036.399005-1-w15303746062@163.com>
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
X-CM-TRANSID:QCgvCgA3hbP+AAhqSd3aDw--.5S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1fZw13Zr4rJF18WFWktFb_yoWxGr1fpF
	W5KF90yw4UWFW29FsrZF1xAF1rKF4SgFW3C34fG345X398tryYk3WIkaya9F1UGr97AryS
	vFWUX3y5WFyUAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5_-PUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAAnewmoIAQlXUwAA37
X-Rspamd-Queue-Id: 4958C55A4AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-248971-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Vulnerabilities leading to Use-After-Free (UAF) and Null Pointer
Dereference (NPD) conditions were observed in the lifecycle management
of hci_uart.

The primary issue arises because the workqueues (init_ready and write_work)
are only flushed/cancelled if the HCI_UART_PROTO_READY flag is set during
TTY close. If a hangup occurs before setup completes, hci_uart_tty_close()
skips the teardown of these workqueues and proceeds to free the `hu` struct.
When the scheduled work executes later, it blindly dereferences the freed
`hu` struct. This issue was triggered by our custom device emulation and
fuzzing framework (DevGen) on the v6.18 kernel.

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

Additionally, sister bugs exist in the device registration error paths
within hci_uart_init_work() and hci_uart_register_dev(). If
hci_register_dev() fails, the code frees hdev and sets hu->hdev to NULL,
but leaves hu->write_work active if it was already scheduled during early
protocol setup phase. When the work executes later, it blindly fetches and
dereferences the NULL hu->hdev pointer, triggering an unconditioned kernel
panic.

Furthermore, the error path in hci_uart_init_work() clears the
HCI_UART_PROTO_READY flag and invokes hu->proto->close(hu) without
acquiring the hu->proto_lock write lock. Since concurrent callbacks like
hci_uart_tty_receive() execute under the read lock, this missing
synchronization allows the protocol state to be destroyed while active
readers are accessing it.

Fix these synchronization and lifecycle issues by:
1. Moving the workqueue teardown to the very beginning of
   hci_uart_tty_close() and using disable_work_sync() to unconditionally
   prevent new work submissions.
2. Wrapping the clearance of HCI_UART_PROTO_READY in hci_uart_init_work()
   with percpu_down_write/percpu_up_write of hu->proto_lock.
3. Explicitly invoking disable_work_sync(&hu->write_work) before resetting
   hu->hdev to NULL in both initialization error paths to safely prevent
   any concurrent re-queuing issues.

Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v6:
- Fixed missing `hu->proto_lock` write lock in hci_uart_init_work() error path to prevent race with readers (reported by Sashiko).
- Added disable_work_sync() instead of cancel_work_sync() for `hu->write_work` in hci_uart_init_work() and hci_uart_register_dev() error paths to completely block any concurrent re-queuing window before hdev is freed (reported by Sashiko).

Changes in v5:
- Relocated disable_work_sync() to the very top of hci_uart_tty_close(), 
  before hci_uart_close(), to ensure no new work is submitted during device teardown.

Changes in v4:
- Adopted Luiz's suggestion to use disable_work_sync() instead of 
  cancel_work_sync() in close path to prevent new work submissions.

Changes in v3:
- Added 'Cc: stable' tag as requested by the stable bot.

Changes in v2:
- Added KASAN/ODEBUG crash trace.

 drivers/bluetooth/hci_ldisc.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 275ea865bc29..612fa2890cec 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -194,7 +194,22 @@ void hci_uart_init_work(struct work_struct *work)
 	err = hci_register_dev(hu->hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device");
+
+		/*
+		 * Acquire proto_lock before clearing PROTO_READY and closing
+		 * the protocol to synchronize with active readers.
+		 */
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+
+		/*
+		 * Disable any pending write_work that may have been queued
+		 * during the PROTO_INIT phase to prevent UAF/NPD when hdev
+		 * is freed.
+		 */
+		disable_work_sync(&hu->write_work);
+
 		hu->proto->close(hu);
 		hdev = hu->hdev;
 		hu->hdev = NULL;
@@ -540,6 +555,15 @@ static void hci_uart_tty_close(struct tty_struct *tty)
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
@@ -549,9 +573,6 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
 
-		cancel_work_sync(&hu->init_ready);
-		cancel_work_sync(&hu->write_work);
-
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
@@ -692,6 +713,14 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+
+		/*
+		 * Disable any pending write_work that may have been queued
+		 * during the proto->open() phase to prevent UAF/NPD when
+		 * hdev is freed.
+		 */
+		disable_work_sync(&hu->write_work);
+
 		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
-- 
2.34.1


