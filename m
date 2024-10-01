Return-Path: <stable+bounces-78429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD098B998
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE27D1F234C1
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4819DF77;
	Tue,  1 Oct 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NH6jDQNx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4523209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778370; cv=none; b=JfPnitaLMP8J13dsS55JaCrGguJJ1iyqwvxHxkURaMpkOQ4SYOfKFl/9C2lN1mtJ/PEe4Wvi7JeQU1xT3P603X//Dexabxk2Mp0+e8bnGCqRHa1c5Fg70BpAFzuWowAFJ5WCevPeUL/hQKxEmKCXa3F6PXZmgWUPxUEHpX+vTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778370; c=relaxed/simple;
	bh=cVZ7rD7oRu9u9KkzFnW7N0nex9N4sdIPOON/MNk49j0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lzTyJ3UB5MmLEWiB2xxr347hC23YTwUP6zM0FSFKRJgaAn3z2hN23AijvRsKztE14libCWt75+q5xUJ5Xf/S64Ogpw26q0ozYlgmtgEUde83FCvbcnVWJ+SuI42fNQpZAf8pU1HUzXpr7A5Vp1bMvLUkDojVxET7GMpREL0Ykrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NH6jDQNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C385C4CEC6;
	Tue,  1 Oct 2024 10:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778369;
	bh=cVZ7rD7oRu9u9KkzFnW7N0nex9N4sdIPOON/MNk49j0=;
	h=Subject:To:Cc:From:Date:From;
	b=NH6jDQNxB9R+d5/avStSq1qSJKsA+jgtXf4WO1vbZzXm7H9b5l1bVTDJrqHaGCD/a
	 t/LjJaNOXnkwHcMKHw+XdSLphW1SSQKvohS9uKSdavBP/1F+GQHvPF1B0nbZfCZJbS
	 wFD1ndufBSSFnI7CUstMZtwab3B5Rc6pew1C8NM0=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix fifo polling timeout" failed to apply to 4.19-stable tree
To: johan+linaro@kernel.org,dianders@chromium.org,gregkh@linuxfoundation.org,nfraprado@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:25:58 +0200
Message-ID: <2024100158-stoke-upfront-79a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c80ee36ac8f9e9c27d8e097a2eaaf198e7534c83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100158-stoke-upfront-79a9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c80ee36ac8f9 ("serial: qcom-geni: fix fifo polling timeout")
8ece7b754bc3 ("serial: qcom-geni: fix opp vote on shutdown")
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
d6efb3ac3e6c ("Merge tag 'tty-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c80ee36ac8f9e9c27d8e097a2eaaf198e7534c83 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Fri, 6 Sep 2024 15:13:29 +0200
Subject: [PATCH] serial: qcom-geni: fix fifo polling timeout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The qcom_geni_serial_poll_bit() can be used to wait for events like
command completion and is supposed to wait for the time it takes to
clear a full fifo before timing out.

As noted by Doug, the current implementation does not account for start,
stop and parity bits when determining the timeout. The helper also does
not currently account for the shift register and the two-word
intermediate transfer register.

A too short timeout can specifically lead to lost characters when
waiting for a transfer to complete as the transfer is cancelled on
timeout.

Instead of determining the poll timeout on every call, store the fifo
timeout when updating it in set_termios() and make sure to take the
shift and intermediate registers into account. Note that serial core has
already added a 20 ms margin to the fifo timeout.

Also note that the current uart_fifo_timeout() interface does
unnecessary calculations on every call and did not exist in earlier
kernels so only store its result once. This facilitates backports too as
earlier kernels can derive the timeout from uport->timeout, which has
since been removed.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Cc: stable@vger.kernel.org	# 4.17
Reported-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240906131336.23625-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 69a632fefc41..309c0bddf26a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -124,7 +124,7 @@ struct qcom_geni_serial_port {
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
 	bool setup;
-	unsigned int baud;
+	unsigned long poll_timeout_us;
 	unsigned long clk_rate;
 	void *rx_buf;
 	u32 loopback;
@@ -270,22 +270,13 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 {
 	u32 reg;
 	struct qcom_geni_serial_port *port;
-	unsigned int baud;
-	unsigned int fifo_bits;
 	unsigned long timeout_us = 20000;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
 	if (private_data->drv) {
 		port = to_dev_port(uport);
-		baud = port->baud;
-		if (!baud)
-			baud = 115200;
-		fifo_bits = port->tx_fifo_depth * port->tx_fifo_width;
-		/*
-		 * Total polling iterations based on FIFO worth of bytes to be
-		 * sent at current baud. Add a little fluff to the wait.
-		 */
-		timeout_us = ((fifo_bits * USEC_PER_SEC) / baud) + 500;
+		if (port->poll_timeout_us)
+			timeout_us = port->poll_timeout_us;
 	}
 
 	/*
@@ -1244,11 +1235,11 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	unsigned long clk_rate;
 	u32 ver, sampling_rate;
 	unsigned int avg_bw_core;
+	unsigned long timeout;
 
 	qcom_geni_serial_stop_rx(uport);
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 4000000);
-	port->baud = baud;
 
 	sampling_rate = UART_OVERSAMPLING;
 	/* Sampling rate is halved for IP versions >= 2.5 */
@@ -1326,9 +1317,21 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	else
 		tx_trans_cfg |= UART_CTS_MASK;
 
-	if (baud)
+	if (baud) {
 		uart_update_timeout(uport, termios->c_cflag, baud);
 
+		/*
+		 * Make sure that qcom_geni_serial_poll_bitfield() waits for
+		 * the FIFO, two-word intermediate transfer register and shift
+		 * register to clear.
+		 *
+		 * Note that uart_fifo_timeout() also adds a 20 ms margin.
+		 */
+		timeout = jiffies_to_usecs(uart_fifo_timeout(uport));
+		timeout += 3 * timeout / port->tx_fifo_depth;
+		WRITE_ONCE(port->poll_timeout_us, timeout);
+	}
+
 	if (!uart_console(uport))
 		writel(port->loopback,
 				uport->membase + SE_UART_LOOPBACK_CFG);


