Return-Path: <stable+bounces-87018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA7B9A5DB3
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC0E281ABE
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063ED1E0E0A;
	Mon, 21 Oct 2024 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQUI3XIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E5192D6E
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497252; cv=none; b=G97/62r4WV1x/8Zt1NGLpAjtG/f2F+ImKs7zcGrBkD6GZaH+Pl77i9xepES4y8M4XKwe4cI7tb941CwLBlWgM2S73WzsuDqMXR9DftBvvAcvbmnYECPJOTJ8EVLLfBjouwn3PtV1287XPPodQuDGD19LTBkwGYM9Mj2Cjpc9M1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497252; c=relaxed/simple;
	bh=NGgsIgCt2Rx1g3+5xKIUwtfv/vTziybo1Vi2Pp+XflE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sMaPEy8ZUIABXXTaqOEFJJ4Czs9lK0tD9EOOfjQRc8r1dukan7Lh0DEawjcw0nBwczk9+5CWYREM9/VBiVBrCuRE1MamOO6rgjgqNAX01GKkuG+b76/LCY5oNIC7xp7DNv40XRoOcd3eXk6BjIRitndF6Z09OR0DBzdL6qivH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQUI3XIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2912DC4CEE5;
	Mon, 21 Oct 2024 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729497252;
	bh=NGgsIgCt2Rx1g3+5xKIUwtfv/vTziybo1Vi2Pp+XflE=;
	h=Subject:To:Cc:From:Date:From;
	b=OQUI3XIrIuHnzVlkn3xFCir6Xma4vhLknW4hNEvMdLr6qQqEBnUjOGaxxKepOvtLm
	 HiE9WpBLA9ulaDuQD8mA0WLR7E22xgUCkjLxMv7TMG1n55XQtto/lHCpR8/V0eW0sv
	 RL5h//Lc1St0fYcbFYdEQZQBFZlLlQQcuxJN3naI=
Subject: FAILED: patch "[PATCH] serial: imx: Update mctrl old_status on RTSD interrupt" failed to apply to 4.19-stable tree
To: marex@denx.de,esben@geanix.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 09:54:01 +0200
Message-ID: <2024102101-glacial-outsell-b7f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 40d7903386df4d18f04d90510ba90eedee260085
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102101-glacial-outsell-b7f5@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40d7903386df4d18f04d90510ba90eedee260085 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Wed, 2 Oct 2024 20:40:38 +0200
Subject: [PATCH] serial: imx: Update mctrl old_status on RTSD interrupt

When sending data using DMA at high baudrate (4 Mbdps in local test case) to
a device with small RX buffer which keeps asserting RTS after every received
byte, it is possible that the iMX UART driver would not recognize the falling
edge of RTS input signal and get stuck, unable to transmit any more data.

This condition happens when the following sequence of events occur:
- imx_uart_mctrl_check() is called at some point and takes a snapshot of UART
  control signal status into sport->old_status using imx_uart_get_hwmctrl().
  The RTSS/TIOCM_CTS bit is of interest here (*).
- DMA transfer occurs, the remote device asserts RTS signal after each byte.
  The i.MX UART driver recognizes each such RTS signal change, raises an
  interrupt with USR1 register RTSD bit set, which leads to invocation of
  __imx_uart_rtsint(), which calls uart_handle_cts_change().
  - If the RTS signal is deasserted, uart_handle_cts_change() clears
    port->hw_stopped and unblocks the port for further data transfers.
  - If the RTS is asserted, uart_handle_cts_change() sets port->hw_stopped
    and blocks the port for further data transfers. This may occur as the
    last interrupt of a transfer, which means port->hw_stopped remains set
    and the port remains blocked (**).
- Any further data transfer attempts will trigger imx_uart_mctrl_check(),
  which will read current status of UART control signals by calling
  imx_uart_get_hwmctrl() (***) and compare it with sport->old_status .
  - If current status differs from sport->old_status for RTS signal,
    uart_handle_cts_change() is called and possibly unblocks the port
    by clearing port->hw_stopped .
  - If current status does not differ from sport->old_status for RTS
    signal, no action occurs. This may occur in case prior snapshot (*)
    was taken before any transfer so the RTS is deasserted, current
    snapshot (***) was taken after a transfer and therefore RTS is
    deasserted again, which means current status and sport->old_status
    are identical. In case (**) triggered when RTS got asserted, and
    made port->hw_stopped set, the port->hw_stopped will remain set
    because no change on RTS line is recognized by this driver and
    uart_handle_cts_change() is not called from here to unblock the
    port->hw_stopped.

Update sport->old_status in __imx_uart_rtsint() accordingly to make
imx_uart_mctrl_check() detect such RTS change. Note that TIOCM_CAR
and TIOCM_RI bits in sport->old_status do not suffer from this problem.

Fixes: ceca629e0b48 ("[ARM] 2971/1: i.MX uart handle rts irq")
Cc: stable <stable@kernel.org>
Reviewed-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20241002184133.19427-1-marex@denx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 67d4a72eda77..90974d338f3c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -762,6 +762,21 @@ static irqreturn_t __imx_uart_rtsint(int irq, void *dev_id)
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
 	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
+	/*
+	 * Update sport->old_status here, so any follow-up calls to
+	 * imx_uart_mctrl_check() will be able to recognize that RTS
+	 * state changed since last imx_uart_mctrl_check() call.
+	 *
+	 * In case RTS has been detected as asserted here and later on
+	 * deasserted by the time imx_uart_mctrl_check() was called,
+	 * imx_uart_mctrl_check() can detect the RTS state change and
+	 * trigger uart_handle_cts_change() to unblock the port for
+	 * further TX transfers.
+	 */
+	if (usr1 & USR1_RTSS)
+		sport->old_status |= TIOCM_CTS;
+	else
+		sport->old_status &= ~TIOCM_CTS;
 	uart_handle_cts_change(&sport->port, usr1);
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 


