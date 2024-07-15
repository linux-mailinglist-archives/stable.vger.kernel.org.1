Return-Path: <stable+bounces-59322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BFB93122E
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 12:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACCC1F2359D
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C3187549;
	Mon, 15 Jul 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RhWPe2vK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C818735C
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038969; cv=none; b=L/9jhr2JTWHi37fwaJSL2QirOkZYONuxe7ufKp8xOL8rMpLiGnmLE1rMH46ar+axof68gaaNx43M3LHhryO59GejDvyNbB6KLCvjBcs/avgU70z0Ks9jhUKmseWMFgTiO0762/i8WCNLiw/wr9S3+md9lNB0ac9AwvkebSvHFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038969; c=relaxed/simple;
	bh=A82Iv/gRKzufO6mqNmEPviEGIvaG1YgGA+CQND3iJNM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QYz2apyx9wKfziawuWHCUPsY8fwP5kInsgyxjyzFyEfytSexURLg5DEvwPQC7vNe0BkiN0+moOIHvAe2zmIvgFmZKWzmJ3Hzu3wLof3NQd41wg0DRK1XtrokNjEvbf7mt0zxtur8rzj7THVs+qnm+cW1n9V1oApYzRq577Md+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RhWPe2vK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FED2C32782;
	Mon, 15 Jul 2024 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721038969;
	bh=A82Iv/gRKzufO6mqNmEPviEGIvaG1YgGA+CQND3iJNM=;
	h=Subject:To:Cc:From:Date:From;
	b=RhWPe2vKSz9+q+TnegmNNRTBr8jQgWaDMolJmH9A0wB4hxMgQZtM9UIonebb32Eci
	 Sw8rDbbGWQSXEBeExBYlr6VwI6rCXTkwUAs02Icm7+LsXFD+toFsfExChpwFdpI1w/
	 5rF3o+I8MGuYPAMjsiTsJ760hUoO5sICD45iOyMQ=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix hard lockup on buffer flush" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,dianders@chromium.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 12:22:18 +0200
Message-ID: <2024071518-alfalfa-identify-0afb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 507786c51ccf8df726df804ae316a8c52537b407
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071518-alfalfa-identify-0afb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

507786c51ccf ("serial: qcom-geni: fix hard lockup on buffer flush")

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


