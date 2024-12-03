Return-Path: <stable+bounces-96270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0F9E1902
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A189162A7A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D1192583;
	Tue,  3 Dec 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBlMFgcM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD61DF722
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221028; cv=none; b=bYEQSwX9Lv7V5JyyL73gNiALYXfeOy3F2MPECJLxw996kXYGn42FFmvHtVMh87Lx0Iq6c1dxgTf8pNMDrzHp4Qm4yl18yP4Z+WA5e4MRhUOXa8Xh55PazSPutWHwLr8w9BtRjwsuZi9HK51knJJC8H79pz4kElfcTj4/OTNtNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221028; c=relaxed/simple;
	bh=9yJQvk3g+M8/MM4knmWDr4AV3oZll7efJKHE4LxwgOk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iFBDGTykmqfaCRL1uYZtucJwxHvPjwKurj21bhzfKELCDSPITYUzjRYbZbPkKr1ZUtgKLTEzZdfzo6qfLmMFl0Ah1NMk1+qQWl6otCRRdXsRss+kZus2WyjFWsuEFo5dS9Zu5fSoMgp45hSLff6Ls+Bf+XozsNMQugzrsKzqV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBlMFgcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F3FC4CECF;
	Tue,  3 Dec 2024 10:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733221027;
	bh=9yJQvk3g+M8/MM4knmWDr4AV3oZll7efJKHE4LxwgOk=;
	h=Subject:To:Cc:From:Date:From;
	b=WBlMFgcMp0LkTgEVpj+QaYJf1e2n+cyZ6RBxsEIMWTuwX+XPGD5p09rMi6gTqkfwV
	 YP6mq7ky4bRcWLbMv1lEMjok5KqICrl/1N23sRQMPJjAv4G40dZsiPoayB6X5qj+Hx
	 awZ+gUzKVfbnnCWUTfQAqMf/E3v9tRuOQ8pForQc=
Subject: FAILED: patch "[PATCH] serial: 8250_fintek: Add support for F81216E" failed to apply to 5.10-stable tree
To: fbrozovic@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:17:04 +0100
Message-ID: <2024120304-postnasal-shoptalk-c764@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 166105c9030a30ba08574a9998afc7b60bc72dd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120304-postnasal-shoptalk-c764@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 166105c9030a30ba08574a9998afc7b60bc72dd7 Mon Sep 17 00:00:00 2001
From: Filip Brozovic <fbrozovic@gmail.com>
Date: Sun, 10 Nov 2024 12:17:00 +0100
Subject: [PATCH] serial: 8250_fintek: Add support for F81216E

The F81216E is a LPC/eSPI to 4 UART Super I/O and is mostly compatible with
the F81216H, but does not support RS-485 auto-direction delays on any port.

Signed-off-by: Filip Brozovic <fbrozovic@gmail.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20241110111703.15494-1-fbrozovic@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index f59c01f48480..b4461a89b8d0 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -21,6 +21,7 @@
 #define CHIP_ID_F81866 0x1010
 #define CHIP_ID_F81966 0x0215
 #define CHIP_ID_F81216AD 0x1602
+#define CHIP_ID_F81216E 0x1617
 #define CHIP_ID_F81216H 0x0501
 #define CHIP_ID_F81216 0x0802
 #define VENDOR_ID1 0x23
@@ -158,6 +159,7 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 	case CHIP_ID_F81866:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		break;
@@ -181,6 +183,7 @@ static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
 		return 0;
 
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		*min = F81216_LDN_LOW;
@@ -250,6 +253,7 @@ static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 		break;
 
 	case CHIP_ID_F81216AD:
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
 		sio_write_mask_reg(pdata, FINTEK_IRQ_MODE, IRQ_SHARE,
@@ -263,7 +267,8 @@ static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 {
 	switch (pdata->pid) {
-	case CHIP_ID_F81216H: /* 128Bytes FIFO */
+	case CHIP_ID_F81216E: /* 128Bytes FIFO */
+	case CHIP_ID_F81216H:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		sio_write_mask_reg(pdata, FIFO_CTRL,
@@ -297,6 +302,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
 		goto exit;
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 		reg = RS485;
 		break;
@@ -346,6 +352,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
 	struct fintek_8250 *pdata = uart->port.private_data;
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81216E:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
@@ -438,6 +445,11 @@ static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
 			uart->port.rs485_supported = fintek_8250_rs485_supported;
 		break;
 
+	case CHIP_ID_F81216E: /* F81216E does not support RS485 delays */
+		uart->port.rs485_config = fintek_8250_rs485_config;
+		uart->port.rs485_supported = fintek_8250_rs485_supported;
+		break;
+
 	default: /* No RS485 Auto direction functional */
 		break;
 	}


