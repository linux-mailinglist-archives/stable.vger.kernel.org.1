Return-Path: <stable+bounces-59319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7952931224
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 12:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA531C22626
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A6187359;
	Mon, 15 Jul 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSf2fEQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A51862A2
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038747; cv=none; b=mR4+KYMPclEzHEVvu02FqemYaBQyf9JhHvorJPYmwRrwJN8XQsCMzRlCt4q6Uym7kZoicu5+k5685PTNh/G0U85qauZE/hvIVrjJ+xlq0aPABKMXstwhtDsx7kE6Qe+2IVphdSiiCzDYYp8IRvrzWjzel9xsaP9QCP1pftSmYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038747; c=relaxed/simple;
	bh=YZ6bRon7iK7vpm2HxnEU8pEM8o1/QY4Km9q+kC5odHk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aGFyzvZyy/+J7qKJ3PTzVqK+dDu9SiBxZySHIefLvXMub315uVsOYLI9iJvm0seXVm93SvcBBcZzYCg5HMMN1PzBbzhsIUzRC3w4DCZ3fe73c5hrjmNw70V9uxzgn6q18Ubo1z9gctzZUrIq+sBoBdBqY1ipEi6BvtnelIoK7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSf2fEQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677FFC32782;
	Mon, 15 Jul 2024 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721038746;
	bh=YZ6bRon7iK7vpm2HxnEU8pEM8o1/QY4Km9q+kC5odHk=;
	h=Subject:To:Cc:From:Date:From;
	b=eSf2fEQ/4LJ4Ru8t2RTUJFDHOAI/tL1SBGs1PePsrcbnK9Lg9bZm5jkc1Rm/7JQpd
	 vruzmZHg6XKSZ3sl7Du5cwkXOGQ6zX//EobHn/Ubhtfn4IEhVf3G5N8YOMHXe8AsrZ
	 sH9dB8zy09BztvKzu4PrtbYI3/T052El/mKkGsLo=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix hard lockup on buffer flush" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,dianders@chromium.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 12:18:56 +0200
Message-ID: <2024071555-occupy-tables-792a@gregkh>
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
git cherry-pick -x 507786c51ccf8df726df804ae316a8c52537b407
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071555-occupy-tables-792a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

507786c51ccf ("serial: qcom-geni: fix hard lockup on buffer flush")
2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
40ec6d41c841 ("tty: serial: qcom-geni-serial: use of_device_id data")
0626afe57b1f ("tty: serial: qcom-geni-serial: drop the return value from handle_rx")
bd7955840cbe ("tty: serial: qcom-geni-serial: refactor qcom_geni_serial_send_chunk_fifo()")
d420fb491cbc ("tty: serial: qcom-geni-serial: split out the FIFO tx code")
fe6a00e8fcbe ("tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()")
00ce7c6e86b5 ("tty: serial: qcom-geni-serial: improve the to_dev_port() macro")
6cde11dbf4b6 ("tty: serial: qcom-geni-serial: align #define values")
68c6bd92c86c ("tty: serial: qcom-geni-serial: remove unused symbols")
d0fabb0dc1a6 ("tty: serial: qcom-geni-serial: drop unneeded forward definitions")
35781d8356a2 ("tty: serial: qcom-geni-serial: Add support for Hibernation feature")
654a8d6c93e7 ("tty: serial: qcom-geni-serial: Implement start_rx callback")
c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate.")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 507786c51ccf8df726df804ae316a8c52537b407 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Thu, 4 Jul 2024 12:18:04 +0200
Subject: [PATCH] serial: qcom-geni: fix hard lockup on buffer flush

The Qualcomm GENI serial driver does not handle buffer flushing and used
to continue printing discarded characters when the circular buffer was
cleared. Since commit 1788cf6a91d9 ("tty: serial: switch from circ_buf
to kfifo") this instead results in a hard lockup due to
qcom_geni_serial_send_chunk_fifo() spinning indefinitely in the
interrupt handler.

This is easily triggered by interrupting a command such as dmesg in a
serial console but can also happen when stopping a serial getty on
reboot.

Implement the flush_buffer() callback and use it to cancel any active TX
command when the write buffer has been emptied.

Reported-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/lkml/20240610222515.3023730-1-dianders@chromium.org/
Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Fixes: a1fee899e5be ("tty: serial: qcom_geni_serial: Fix softlock")
Cc: stable@vger.kernel.org	# 5.0
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240704101805.30612-3-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a41360d34790..b2bbd2d79dbb 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -906,13 +906,17 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
 	else
 		pending = kfifo_len(&tport->xmit_fifo);
 
-	/* All data has been transmitted and acknowledged as received */
-	if (!pending && !status && done) {
+	/* All data has been transmitted or command has been cancelled */
+	if (!pending && done) {
 		qcom_geni_serial_stop_tx_fifo(uport);
 		goto out_write_wakeup;
 	}
 
-	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
+	if (active)
+		avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
+	else
+		avail = port->tx_fifo_depth;
+
 	avail *= BYTES_PER_FIFO_WORD;
 
 	chunk = min(avail, pending);
@@ -1091,6 +1095,11 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 	qcom_geni_serial_cancel_tx_cmd(uport);
 }
 
+static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
+{
+	qcom_geni_serial_cancel_tx_cmd(uport);
+}
+
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
@@ -1547,6 +1556,7 @@ static const struct uart_ops qcom_geni_console_pops = {
 	.request_port = qcom_geni_serial_request_port,
 	.config_port = qcom_geni_serial_config_port,
 	.shutdown = qcom_geni_serial_shutdown,
+	.flush_buffer = qcom_geni_serial_flush_buffer,
 	.type = qcom_geni_serial_get_type,
 	.set_mctrl = qcom_geni_serial_set_mctrl,
 	.get_mctrl = qcom_geni_serial_get_mctrl,


