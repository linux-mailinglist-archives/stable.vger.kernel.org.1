Return-Path: <stable+bounces-249164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOQ5Fz5tCmrN1AQAu9opvQ
	(envelope-from <stable+bounces-249164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:37:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6947564D78
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD5BC3018AF8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB99C242D84;
	Mon, 18 May 2026 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RfaTDiuH"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7C243376;
	Mon, 18 May 2026 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779068213; cv=none; b=WbltvcFKA/BV/dSa6Zmo362/c8mCIF2MnOPencHUx3vlCH/axfwrKyhxsBHPD0Y/V5/K1cmABKpaiC+KLTdbLAUQzyZnPELfaV3XplhoXhB5pFy+BN4sL+EjtfDExu+PluaB/sMxVWU1hoJRUuflBfAEbwwT3sfKbb4FwqxCd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779068213; c=relaxed/simple;
	bh=izY9gmTYTh5O4FaHhPXjL2FuiWin5P1oTorQ1ZAn2DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjYm6KrmFitKNEIm0qLORn6skESeQ6NagtmywW1G4OcVYzPM+Pluy1XMAqi70frDdEGvjt1Y8qokaigTVmCWMckd1ll+BKBeO0wkOtDQ9oiJTQgYWdsx4Td/NVTFJHE0V8aiVsQaMe6L1fcXXKUiD9mL7Ngsv1UDWJJ6A5KdEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RfaTDiuH; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=26
	zmB/Y8iqtSiE5skmnsbgDH+S1Kksp79ZmnNcLA2i0=; b=RfaTDiuHmuUvXY56SF
	+BrSk0xEMvZUlP31EbZUfQSy0RfeEY0erTeRbzdBBI76gkTu/n6xmaf/YEQxd3Xj
	75TRU6UEYKEX0Bvr9ZclFOjFl3uCID9kqr1K4L5kp5RtE2jKw0G/jQ1U8M1mJei2
	yaPJ+/ug8TAkqLLmY4FLfFw+Y=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wA37pMEbQpqEaO+Bw--.11011S2;
	Mon, 18 May 2026 09:36:18 +0800 (CST)
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
Subject: [PATCH v8] Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths
Date: Mon, 18 May 2026 09:36:02 +0800
Message-Id: <20260518013602.438835-1-w15303746062@163.com>
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
X-CM-TRANSID:_____wA37pMEbQpqEaO+Bw--.11011S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr1fZrWDtw18Xw47Jw1UJrb_yoW3Gw4rpF
	W5KF90kr4kWFW29w1DZa18JF1rKr1fKayay34fG3y5Jwn8tr1Yk3WIkayF9F18Cryvkr4S
	vr4UXrW5ua4UZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jehFxUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4xJ8YGoKbRJQtwAA3V
X-Rspamd-Queue-Id: E6947564D78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249164-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
1. Calling hci_uart_flush() from hci_uart_close() without canceling
   write_work causes a race condition where both can concurrently
   double-free hu->tx_skb. This occurs both in TTY hangup and when the
   HCI device is closed via the HCI core.
2. Calling hci_free_dev(hdev) before hu->proto->close(hu) causes a UAF
   when vendor specific protocol close callbacks dereference hu->hdev.
3. In the initialization error paths, failing to take the proto_lock
   write lock before clearing PROTO_READY leads to races with active
   readers. Additionally, hci_uart_tty_receive() accesses hu->hdev
   outside the read lock, leading to UAFs if the initialization error
   path frees hdev concurrently.

Fix these synchronization and lifecycle issues by:
1. Re-ordering hci_uart_tty_close() to unconditionally cancel init_ready
   and write_work first. This prevents the double-free race in
   hci_uart_flush(), while preserving the HCI_UART_PROTO_READY flag so
   underlying hu->proto->flush() callbacks can still execute safely.
2. Relocating hu->proto->close(hu) strictly prior to hci_free_dev(hdev)
   across all close and error paths to prevent vendor-level UAFs.
3. Moving the hdev->stat.byte_rx increment in hci_uart_tty_receive()
   inside the proto_lock read-side critical section to safely synchronize
   with device unregistration.
4. Adding cancel_work_sync(&hu->write_work) to hci_uart_close() to safely
   flush the workqueue before hci_uart_flush() is invoked.
5. Utilizing cancel_work_sync() instead of disable_work_sync() after
   flags are cleared to safely flush workqueues without permanently
   breaking user-space retry capabilities.

Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregistering")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v8:
- Corrected the teardown sequence in hci_uart_tty_close() by unconditionally canceling write_work BEFORE hci_uart_close(). This completely prevents the tx_skb double-free without prematurely clearing PROTO_READY, ensuring underlying hu->proto->flush(hu) runs correctly.
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

 drivers/bluetooth/hci_ldisc.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 275ea865bc29..cb56194daad1 100644
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
@@ -540,6 +552,12 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (!hu)
 		return;
 
+	/* Wait for init_ready to finish to prevent registration races */
+	cancel_work_sync(&hu->init_ready);
+
+	/* Unconditionally cancel write_work BEFORE hci_uart_close() to prevent double-free */
+	cancel_work_sync(&hu->write_work);
+
 	hdev = hu->hdev;
 	if (hdev)
 		hci_uart_close(hdev);
@@ -549,15 +567,15 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
 
-		cancel_work_sync(&hu->init_ready);
-		cancel_work_sync(&hu->write_work);
-
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
-			hci_free_dev(hdev);
 		}
+		/* Close protocol before freeing hdev */
 		hu->proto->close(hu);
+
+		if (hdev)
+			hci_free_dev(hdev);
 	}
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
@@ -625,11 +643,12 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
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
 
@@ -695,6 +714,10 @@ static int hci_uart_register_dev(struct hci_uart *hu)
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


