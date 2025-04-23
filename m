Return-Path: <stable+bounces-136184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA3A992F9
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBD9231ED
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7651428CF42;
	Wed, 23 Apr 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fvMGuTgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E532283C87;
	Wed, 23 Apr 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421879; cv=none; b=IwFZYy0q7OK54CmyxQo/rcM9x0qOMIdodhCGbBRVHKONjhkWGf5zVtOMYX6YBdR9bz46rzxALiuoVpYKyWMUTQSet3ZEzREfqsQPWvzPKEpA1LmR+zkZkbNL91twX4iyJOfYfjVes5GTLngtIlnC/DKAGHByLS5pvnJAT4SN4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421879; c=relaxed/simple;
	bh=bYEp2tUEbt3giAvxXwWzch3wjYtAKG2pqIVwofmPUo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR5iyOT0EKNXm//SKnAPDdVxaRffozrFDJRyluLGv3hmJxotSf87tsKoiBoX7U+5zUKQNn2soLkVYPiedLY8HXTcIwq8IASar53YH9rhjJlAKxAp/hY1uuN3Ka7HVQhKs2TPasmrBJoAzDTZobtmXI7ILyEqr6S5qc1oKiM7Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fvMGuTgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A690EC4CEE3;
	Wed, 23 Apr 2025 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421879;
	bh=bYEp2tUEbt3giAvxXwWzch3wjYtAKG2pqIVwofmPUo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvMGuTgptE0oT5edHTibhy6lZO4GcJtHR+GGlKnrTYcD2LC/Qio4Z3KCPKO3rO9XU
	 YHWg4Goxq+9CKwKwU4ROJ2jZP8+WWwVY+i9eoR0to45MI1nwU5wY7Y8l+M/H4tj1sO
	 waNax3DCdf8NC3UDlypIg7n+g5DPh7E8ETZAO64o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6 238/393] Bluetooth: hci_uart: Fix another race during initialization
Date: Wed, 23 Apr 2025 16:42:14 +0200
Message-ID: <20250423142653.218979886@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arseniy Krasnov <avkrasnov@salutedevices.com>

commit 5df5dafc171b90d0b8d51547a82657cd5a1986c7 upstream.

Do not set 'HCI_UART_PROTO_READY' before call 'hci_uart_register_dev()'.
Possible race is when someone calls 'hci_tty_uart_close()' after this bit
is set, but 'hci_uart_register_dev()' wasn't done. This leads to access
to uninitialized fields. To fix it let's set this bit after device was
registered (as before patch c411c62cc133) and to fix previous problem let's
add one more bit in addition to 'HCI_UART_PROTO_READY' which allows to
perform power up without original bit set (pls see commit c411c62cc133).

Crash backtrace from syzbot report:

RIP: 0010:skb_queue_empty_lockless include/linux/skbuff.h:1887 [inline]
RIP: 0010:skb_queue_purge_reason+0x6d/0x140 net/core/skbuff.c:3936

Call Trace:
 <TASK>
 skb_queue_purge include/linux/skbuff.h:3364 [inline]
 mrvl_close+0x2f/0x90 drivers/bluetooth/hci_mrvl.c:100
 hci_uart_tty_close+0xb6/0x120 drivers/bluetooth/hci_ldisc.c:557
 tty_ldisc_close drivers/tty/tty_ldisc.c:455 [inline]
 tty_ldisc_kill+0x66/0xc0 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0xc9/0x120 drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x10/0x80 drivers/tty/tty_io.c:1690
 tty_release+0x4ef/0x640 drivers/tty/tty_io.c:1861
 __fput+0x86/0x2a0 fs/file_table.c:450
 task_work_run+0x82/0xb0 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xa3/0x1b0 kernel/entry/common.c:218
 do_syscall_64+0x9a/0x190 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
Tested-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com/
Fixes: 366ceff495f9 ("Bluetooth: hci_uart: fix race during initialization")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_ldisc.c |   20 ++++++++++++++------
 drivers/bluetooth/hci_uart.h  |    1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -102,7 +102,8 @@ static inline struct sk_buff *hci_uart_d
 	if (!skb) {
 		percpu_down_read(&hu->proto_lock);
 
-		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+		    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 			skb = hu->proto->dequeue(hu);
 
 		percpu_up_read(&hu->proto_lock);
@@ -124,7 +125,8 @@ int hci_uart_tx_wakeup(struct hci_uart *
 	if (!percpu_down_read_trylock(&hu->proto_lock))
 		return 0;
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		goto no_schedule;
 
 	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
@@ -278,7 +280,8 @@ static int hci_uart_send_frame(struct hc
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return -EUNATCH;
 	}
@@ -582,7 +585,8 @@ static void hci_uart_tty_wakeup(struct t
 	if (tty != hu->tty)
 		return;
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
+	    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 		hci_uart_tx_wakeup(hu);
 }
 
@@ -608,7 +612,8 @@ static void hci_uart_tty_receive(struct
 
 	percpu_down_read(&hu->proto_lock);
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
+	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
 		percpu_up_read(&hu->proto_lock);
 		return;
 	}
@@ -704,13 +709,16 @@ static int hci_uart_set_proto(struct hci
 
 	hu->proto = p;
 
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+	clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	return 0;
 }
 
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -89,6 +89,7 @@ struct hci_uart {
 #define HCI_UART_REGISTERED		1
 #define HCI_UART_PROTO_READY		2
 #define HCI_UART_NO_SUSPEND_NOTIFIER	3
+#define HCI_UART_PROTO_INIT		4
 
 /* TX states  */
 #define HCI_UART_SENDING	1



