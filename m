Return-Path: <stable+bounces-59323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7133E93122F
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 12:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C73E1C21868
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616AA18754E;
	Mon, 15 Jul 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D37a6wws"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6118735C
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038976; cv=none; b=mYtnDfrDZZrY1R4UDpePwSGo/IRbgajPXl5j//94pqs39wi85A8oEPI0Ya69k5UNmKWJ1XGCKkKgb1HybUa+0JAnOM9jNDsMM5IedZf5HRp2/y7Evv+qSPNXItgXgBeF3kwd9LW8GW9izxFLdOBs0T7i0GUj6x785XWrIi3bj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038976; c=relaxed/simple;
	bh=/JZcg0bdcimX7TbM+JLrQ4l7FbXKl7xzH8IpHVxibz4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eissL0LkgLphJNNNKxC32kzE4Ll385Ta7gX3OIpyWYlI3mjcVwGgB48zA9Yt/5VZhyCH/hMSMAS2asopric3EwQnYhere4BuVbYMTbE1RDnm9iBxhvfLTC2F86ZjIaoLme3JyovW8rNOHlNFNI3NPlw6uK5ZI94g1RcyXDGaIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D37a6wws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748CBC32782;
	Mon, 15 Jul 2024 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721038976;
	bh=/JZcg0bdcimX7TbM+JLrQ4l7FbXKl7xzH8IpHVxibz4=;
	h=Subject:To:Cc:From:Date:From;
	b=D37a6wwsNZEZQ6dA1nBR1xvZYzx2c9Rn3fxH9EbGLISMU4pMiMPlF5NU/2BdKG6BS
	 QMPaJFTsLsLjC+8VZl2AIoTtIOl7o3mbSCgQiOvLVwjNbYekOdJS8gqq7Ka+sZcIwK
	 tuw/LXGAOIDLtdcN4LXOv6d7xjZP3ApGS8SsS1A8=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix soft lockup on sw flow control and" failed to apply to 6.9-stable tree
To: johan+linaro@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 12:22:37 +0200
Message-ID: <2024071536-cope-capillary-34c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 947cc4ecc06cb80a2aa2cebbbbf0e546fbaf0238
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071536-cope-capillary-34c4@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow control and suspend")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 947cc4ecc06cb80a2aa2cebbbbf0e546fbaf0238 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Thu, 4 Jul 2024 12:18:03 +0200
Subject: [PATCH] serial: qcom-geni: fix soft lockup on sw flow control and
 suspend

The stop_tx() callback is used to implement software flow control and
must not discard data as the Qualcomm GENI driver is currently doing
when there is an active TX command.

Cancelling an active command can also leave data in the hardware FIFO,
which prevents the watermark interrupt from being enabled when TX is
later restarted. This results in a soft lockup and is easily triggered
by stopping TX using software flow control in a serial console but this
can also happen after suspend.

Fix this by only stopping any active command, and effectively clearing
the hardware fifo, when shutting down the port. When TX is later
restarted, a transfer command may need to be issued to discard any stale
data that could prevent the watermark interrupt from firing.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Cc: stable@vger.kernel.org	# 4.17
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240704101805.30612-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2bd25afe0d92..a41360d34790 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -649,15 +649,25 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 
 static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
 {
+	unsigned char c;
 	u32 irq_en;
 
-	if (qcom_geni_serial_main_active(uport) ||
-	    !qcom_geni_serial_tx_empty(uport))
-		return;
+	/*
+	 * Start a new transfer in case the previous command was cancelled and
+	 * left data in the FIFO which may prevent the watermark interrupt
+	 * from triggering. Note that the stale data is discarded.
+	 */
+	if (!qcom_geni_serial_main_active(uport) &&
+	    !qcom_geni_serial_tx_empty(uport)) {
+		if (uart_fifo_out(uport, &c, 1) == 1) {
+			writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+			qcom_geni_serial_setup_tx(uport, 1);
+			writel(c, uport->membase + SE_GENI_TX_FIFOn);
+		}
+	}
 
 	irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 	irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
-
 	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 }
@@ -665,13 +675,17 @@ static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
 static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 {
 	u32 irq_en;
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
 	writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	/* Possible stop tx is called multiple times. */
+}
+
+static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
 	if (!qcom_geni_serial_main_active(uport))
 		return;
 
@@ -684,6 +698,8 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
 		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	}
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+
+	port->tx_remaining = 0;
 }
 
 static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
@@ -1069,11 +1085,10 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
 	disable_irq(uport->irq);
 
-	if (uart_console(uport))
-		return;
-
 	qcom_geni_serial_stop_tx(uport);
 	qcom_geni_serial_stop_rx(uport);
+
+	qcom_geni_serial_cancel_tx_cmd(uport);
 }
 
 static int qcom_geni_serial_port_setup(struct uart_port *uport)


