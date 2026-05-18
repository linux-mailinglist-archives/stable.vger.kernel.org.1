Return-Path: <stable+bounces-249172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEmDM4N+Cmoo2AQAu9opvQ
	(envelope-from <stable+bounces-249172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:50:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 700505652E3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854FD301906D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687037BE7D;
	Mon, 18 May 2026 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eTswSKoo"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E52405C49;
	Mon, 18 May 2026 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072635; cv=none; b=NpwRMlThahdz+3e/PvTWXY/hTtZo9FMOqcqF3o9Jo+Xiy4nqg4+m2V9AaylAdRYG4FYpjCrICauDfm+N9Es3YWDEnR4O64cu2UNB/eoj/rebTOlbYQ/sXLAiPhkVLmawah2e9KJNHCvsDHa0M8pfE/9OkIjJKejRBU+k19bp0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072635; c=relaxed/simple;
	bh=kXx/uhDwWXesnq94JEolJT/pDNiJ7wGdabHSID0sl6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9YkYP9TE1/skpQwA6MLIRVrRe84KUthOHDaO7WQcMA/gAtUNa4cboMb9s/NPR7l/+HRiNw6vNBoNPsW3CiRVaY7XaoEzDM1QncU6wbSgLzS0WZ9iQmlMzPM13reYC/suVPeat0BV0JfR/nENVe6nhrhAGqol1b86OqxyU64D4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eTswSKoo; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xl
	uZTSIZQlenLHugZ/HZvvlC7d5/oYyPXrnh/ShBstQ=; b=eTswSKoo5dC4y9Gizn
	awRm+dfgSxGheKpbffK7wPGrNyRAp1YeVrfzc6iLEDoqw2Gv3Rte5yzi1SH1MoXS
	4Wk63+lkbLjaJuJvo78itNTFX8SrKqoNgQd9O0n0pbgqTIOt0nT+APRgz3ATXRPe
	859eYWNqEWUxJBHRAVPAs5W2o=
Received: from 163.com (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3hDFPfgpqKzGbEA--.118S2;
	Mon, 18 May 2026 10:50:05 +0800 (CST)
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
Subject: [PATCH v9] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
Date: Mon, 18 May 2026 10:49:49 +0800
Message-Id: <20260518024949.439299-1-w15303746062@163.com>
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
X-CM-TRANSID:PygvCgD3hDFPfgpqKzGbEA--.118S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1fZrWDtw18Xw4rCrWfXwb_yoWfWFW7pF
	W5KF90kr4kXrW2kw1DZF48JF1rKF1fKayayw1fG3y5Jws8tr1YkF12kayF9F18Cryvkr4S
	vr4UXrW5u3W7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jefO7UUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4x3Tt2oKfl1aUwAA3Q
X-Rspamd-Queue-Id: 700505652E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249172-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,molgen.mpg.de,holtmann.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Vulnerabilities leading to Use-After-Free (UAF) and Null Pointer
Dereference (NPD) conditions were observed in the lifecycle management
of hci_uart.

The primary issue arises because the workqueues (init_ready and
write_work) are only flushed/cancelled if the HCI_UART_PROTO_READY
flag is set during TTY close. If a hangup occurs before setup completes,
hci_uart_tty_close() skips the teardown of these workqueues and
proceeds to free the `hu` struct. When the scheduled work executes
later, it blindly dereferences the freed `hu` struct.

Furthermore, several data races and UAFs were identified in the teardown
sequence:
1. Calling hci_uart_flush() from hci_uart_close() without effectively
   disabling write_work causes a race condition where both can concurrently
   double-free hu->tx_skb. This happens because protocol timers can
   concurrently invoke hci_uart_tx_wakeup() and requeue write_work.
2. Calling hci_free_dev(hdev) before hu->proto->close(hu) causes a UAF
   when vendor specific protocol close callbacks dereference hu->hdev.
3. In the initialization error paths, failing to take the proto_lock
   write lock before clearing PROTO_READY leads to races with active
   readers. Additionally, hci_uart_tty_receive() accesses hu->hdev
   outside the read lock, leading to UAFs if the initialization error
   path frees hdev concurrently.

Fix these synchronization and lifecycle issues by:
1. Re-ordering hci_uart_tty_close() to clear HCI_UART_PROTO_READY first,
   followed immediately by a cancel_work_sync(&hu->write_work). Clearing
   the flag locks out concurrent protocol timers from successfully invoking
   hci_uart_tx_wakeup(), effectively rendering the cancellation permanent
   and preventing the tx_skb double-free.
2. Note: Clearing PROTO_READY early causes hci_uart_close() to skip
   hu->proto->flush(). This is perfectly safe in the tty_close path
   because hu->proto->close() executes shortly after, which intrinsically
   purges all protocol SKB queues and tears down the state.
3. Relocating hu->proto->close(hu) strictly prior to hci_free_dev(hdev)
   across all close and error paths to prevent vendor-level UAFs.
4. Moving the hdev->stat.byte_rx increment in hci_uart_tty_receive()
   inside the proto_lock read-side critical section to safely synchronize
   with device unregistration.
5. Adding cancel_work_sync(&hu->write_work) to hci_uart_close() to safely
   flush the workqueue before hci_uart_flush() is invoked via the HCI core.
6. Utilizing cancel_work_sync() instead of disable_work_sync() across
   all paths to prevent permanently breaking user-space retry capabilities.

Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v9:
- Addressed a critical flaw identified in v8 where premature cancellation of write_work allowed active protocol timers to immediately reschedule it. The teardown sequence in hci_uart_tty_close() now strictly clears HCI_UART_PROTO_READY *before* calling cancel_work_sync(&hu->write_work). This permanently locks out hci_uart_tx_wakeup(), completely resolving the lingering UAF and double-free races.
- Documented that skipping hu->proto->flush() via early flag clearance is intrinsically safe, as hu->proto->close() executes subsequently to purge all unacked/rel queues.

Changes in v8:
- Corrected the teardown sequence in hci_uart_tty_close() by unconditionally canceling write_work BEFORE hci_uart_close().
- Moved hu->hdev->stat.byte_rx increment inside the proto_lock read-side critical section in hci_uart_tty_receive() to prevent read-side UAF against concurrent registration failures.
- Added cancel_work_sync(&hu->write_work) inside hci_uart_close() to eliminate the race condition between write_work and hci_uart_flush() when the interface is brought down via the HCI core.

Changes in v7:
- Reverted disable_work_sync() back to cancel_work_sync() across all error and close paths to preserve user-space retry capabilities.
- Synchronized workqueue teardown safely by atomically clearing PROTO_READY / PROTO_INIT under proto_lock prior to calling cancel_work_sync().
- Fixed a Use-After-Free (UAF) vulnerability in the teardown sequence by relocating hu->proto->close(hu) strictly prior to hci_free_dev(hdev).
- Added cancel_work_sync(&hu->init_ready) at the very beginning of hci_uart_tty_close() to serialize teardown against active asynchronous registration.

Changes in v6:
- Fixed missing `hu->proto_lock` write lock in hci_uart_init_work() error path to prevent race with readers (reported by Sashiko).
- Added disable_work_sync() instead of cancel_work_sync() for `hu->write_work` in hci_uart_init_work() and hci_uart_register_dev() error paths.

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

 drivers/bluetooth/hci_ldisc.c | 48 +++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 275ea865bc29..47f4902b40b4 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -194,7 +194,15 @@ void hci_uart_init_work(struct work_struct *work)
 	err = hci_register_dev(hu->hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device");
+
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+
+		/* Safely cancel work after clearing flags */
+		cancel_work_sync(&hu->write_work);
+
+		/* Close protocol before freeing hdev */
 		hu->proto->close(hu);
 		hdev = hu->hdev;
 		hu->hdev = NULL;
@@ -263,8 +271,12 @@ static int hci_uart_open(struct hci_dev *hdev)
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
 	BT_DBG("hdev %p", hdev);
 
+	cancel_work_sync(&hu->write_work);
+
 	hci_uart_flush(hdev);
 	hdev->flush = NULL;
 	return 0;
@@ -531,6 +543,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 {
 	struct hci_uart *hu = tty->disc_data;
 	struct hci_dev *hdev;
+	bool proto_ready;
 
 	BT_DBG("tty %p", tty);
 
@@ -540,24 +553,38 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (!hu)
 		return;
 
-	hdev = hu->hdev;
-	if (hdev)
-		hci_uart_close(hdev);
+	/* Wait for init_ready to finish to prevent registration races */
+	cancel_work_sync(&hu->init_ready);
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	proto_ready = test_bit(HCI_UART_PROTO_READY, &hu->flags);
+	if (proto_ready) {
 		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
+	}
 
-		cancel_work_sync(&hu->init_ready);
-		cancel_work_sync(&hu->write_work);
+	/*
+	 * Unconditionally cancel write_work AFTER clearing PROTO_READY.
+	 * This ensures that concurrent protocol timers cannot requeue
+	 * write_work via hci_uart_tx_wakeup(), permanently preventing
+	 * double-free races and UAFs.
+	 */
+	cancel_work_sync(&hu->write_work);
+
+	hdev = hu->hdev;
+	if (hdev)
+		hci_uart_close(hdev); /* proto->flush is safely skipped */
 
+	if (proto_ready) {
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
-			hci_free_dev(hdev);
 		}
+		/* Close protocol before freeing hdev (intrinsically purges queues) */
 		hu->proto->close(hu);
+
+		if (hdev)
+			hci_free_dev(hdev);
 	}
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
@@ -625,11 +652,12 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 	 * tty caller
 	 */
 	hu->proto->recv(hu, data, count);
-	percpu_up_read(&hu->proto_lock);
 
 	if (hu->hdev)
 		hu->hdev->stat.byte_rx += count;
 
+	percpu_up_read(&hu->proto_lock);
+
 	tty_unthrottle(tty);
 }
 
@@ -695,6 +723,10 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
+		/* Cancel work after clearing flags */
+		cancel_work_sync(&hu->write_work);
+
+		/* Close protocol before freeing hdev */
 		hu->proto->close(hu);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
-- 
2.34.1


