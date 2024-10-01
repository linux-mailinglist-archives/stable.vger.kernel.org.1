Return-Path: <stable+bounces-78435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6022498B99E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A031C23450
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9C192D74;
	Tue,  1 Oct 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWu9QPgr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022B3209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778394; cv=none; b=qZC5UQl1hQlGEy+PGfyKe+6Z9A5Pl+ya5Nng6CAxkp7/soVVBTNaeNdCHyUd4lkKYJQQnnzq9pW+FYj0vydOq/GcoPiTmdfPZUUCTXFuccgLTGybb6k+rbGICZsvmNsKWeb6ZBCN/2/cL8BT1CmnPvcJV1uMqlxWUC0eAqiXPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778394; c=relaxed/simple;
	bh=X1Ftj+0coNDhLRcmsdU4GqMjxIXLZ6tFwrmu3u3S5RU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=okCU958zou6vywIok6bwk66mveN8eiHWBTwFX9Fig7EHeXR/t5zNeexlXjejmhaFMuOGJEQn28/+uV+dS13Zary8Z115WmyHtNtWioaj9ISB9rKKwQvzDzjIzLUlPKl4N8IMZx5eTTCizEA+DgD9X2eRY+UGD4fUEy02sPqrDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nWu9QPgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85ACC4CEC6;
	Tue,  1 Oct 2024 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778394;
	bh=X1Ftj+0coNDhLRcmsdU4GqMjxIXLZ6tFwrmu3u3S5RU=;
	h=Subject:To:Cc:From:Date:From;
	b=nWu9QPgrHGgdJiGQ6HtBKm7LpPC5SgwKBbYrP0U99kGSC1cTu3JxBylH+o6vwgYku
	 5MZfV4tzIQ98LdH0W8ku0Gb2J3k9x40TvhSu+IdbOesj+wxtFtFBj6JqbSviJjszQn
	 pKj+jyDcHiMLGuWBBmJpN6U8G4tyMiEPj9tiQH3A=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix false console tx restart" failed to apply to 4.19-stable tree
To: johan+linaro@kernel.org,dianders@chromium.org,gregkh@linuxfoundation.org,nfraprado@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:26:19 +0200
Message-ID: <2024100118-deodorize-treble-799b@gregkh>
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
git cherry-pick -x f97cdbbf187fefcf1fe19689cd9fdca11fe9c3eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100118-deodorize-treble-799b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

f97cdbbf187f ("serial: qcom-geni: fix false console tx restart")
1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
f8fef2fa419f ("tty: msm_serial: use dmaengine_prep_slave_sg()")
9054605ab846 ("tty: 8250_omap: use dmaengine_prep_slave_sg()")
8192fabb0db2 ("tty: 8250_dma: use dmaengine_prep_slave_sg()")
3bcb0bf65c2b ("Merge tag 'tty-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f97cdbbf187fefcf1fe19689cd9fdca11fe9c3eb Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Fri, 6 Sep 2024 15:13:30 +0200
Subject: [PATCH] serial: qcom-geni: fix false console tx restart
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 663abb1a7a7f ("tty: serial: qcom_geni_serial: Fix UART hang")
addressed an issue with stalled tx after the console code interrupted
the last bytes of a tx command by reenabling the watermark interrupt if
there is data in write buffer. This can however break software flow
control by re-enabling tx after the user has stopped it.

Address the original issue by not clearing the CMD_DONE flag after
polling for command completion. This allows the interrupt handler to
start another transfer when the CMD_DONE interrupt has not been disabled
due to flow control.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Fixes: 663abb1a7a7f ("tty: serial: qcom_geni_serial: Fix UART hang")
Cc: stable@vger.kernel.org	# 4.17
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240906131336.23625-3-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 309c0bddf26a..b88435c0ea50 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -306,18 +306,16 @@ static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 static void qcom_geni_serial_poll_tx_done(struct uart_port *uport)
 {
 	int done;
-	u32 irq_clear = M_CMD_DONE_EN;
 
 	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_DONE_EN, true);
 	if (!done) {
 		writel(M_GENI_CMD_ABORT, uport->membase +
 						SE_GENI_M_CMD_CTRL_REG);
-		irq_clear |= M_CMD_ABORT_EN;
 		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 							M_CMD_ABORT_EN, true);
+		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	}
-	writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
 static void qcom_geni_serial_abort_rx(struct uart_port *uport)
@@ -378,6 +376,7 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 							unsigned char c)
 {
 	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	qcom_geni_serial_setup_tx(uport, 1);
 	WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_TX_FIFO_WATERMARK_EN, true));
@@ -422,6 +421,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
 	}
 
 	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	qcom_geni_serial_setup_tx(uport, bytes_to_send);
 	for (i = 0; i < count; ) {
 		size_t chars_to_write = 0;
@@ -463,7 +463,6 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	bool locked = true;
 	unsigned long flags;
 	u32 geni_status;
-	u32 irq_en;
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
@@ -495,12 +494,6 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		 * has been sent, in which case we need to look for done first.
 		 */
 		qcom_geni_serial_poll_tx_done(uport);
-
-		if (!kfifo_is_empty(&uport->state->port.xmit_fifo)) {
-			irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-			writel(irq_en | M_TX_FIFO_WATERMARK_EN,
-					uport->membase + SE_GENI_M_IRQ_EN);
-		}
 	}
 
 	__qcom_geni_serial_console_write(uport, s, count);


