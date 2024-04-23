Return-Path: <stable+bounces-40674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28F8AE711
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36719B219FC
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127886278;
	Tue, 23 Apr 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rjKahbln"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6012BE80
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876905; cv=none; b=M/hNP+eo6wvN9d4122rzLzWx+qfov1dc0xz2qkXZiuQ0/DWVzBOMWRXeUZygZSuVT79QKtvqB4/ismSE3faIu3uKpEjTUvPLmaQWfxZdja+pZ4p9X8pHwq5fF0+tWL7FeSCHHVG+noYuLTv9ejt1/Wvzuy+stcrrO2aQxDK5un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876905; c=relaxed/simple;
	bh=DkhCamW2J3aQ1rbPvXc3MR7TrF9yULn+tDU2usx5jNA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KjELoWqviVWfw677XUe8trSI/LwWbe0IChxbdXumD4S05T9pLJNCTd7cLuODwwI2aFS8bs9Hzh9iF0Xp/kD0mJC7wbyfZ9g04OMHBZKCxpjL035mdx/H554ZYx8TYAEiftAOQa9M6Y8VJL58sOLDyg3SnrFFJ+ti1MXuKyLwx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rjKahbln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A02C2BD11;
	Tue, 23 Apr 2024 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713876905;
	bh=DkhCamW2J3aQ1rbPvXc3MR7TrF9yULn+tDU2usx5jNA=;
	h=Subject:To:Cc:From:Date:From;
	b=rjKahblnA+G3nWbHZJDaSUePl0ZAmmfVPm66+xzW9Cq3i7JMhLevEEks9N4GKNOlC
	 GP3/BtUhwTzx4eUAHfM1QRyyOEK4miBQ8WZxbOo3Lbqfj4qMehRJIU9g6BLKZnFzGe
	 CTKJmOTeR+qB9jdC8Ny8wVNFqQTFlnrvzdydHwWc=
Subject: FAILED: patch "[PATCH] serial: mxs-auart: add spinlock around changing cts state" failed to apply to 5.4-stable tree
To: emil.kronborg@protonmail.com,Frank.Li@nxp.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:54:55 -0700
Message-ID: <2024042355-imagines-such-7bf6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 54c4ec5f8c471b7c1137a1f769648549c423c026
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042355-imagines-such-7bf6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

54c4ec5f8c47 ("serial: mxs-auart: add spinlock around changing cts state")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54c4ec5f8c471b7c1137a1f769648549c423c026 Mon Sep 17 00:00:00 2001
From: Emil Kronborg <emil.kronborg@protonmail.com>
Date: Wed, 20 Mar 2024 12:15:36 +0000
Subject: [PATCH] serial: mxs-auart: add spinlock around changing cts state

The uart_handle_cts_change() function in serial_core expects the caller
to hold uport->lock. For example, I have seen the below kernel splat,
when the Bluetooth driver is loaded on an i.MX28 board.

    [   85.119255] ------------[ cut here ]------------
    [   85.124413] WARNING: CPU: 0 PID: 27 at /drivers/tty/serial/serial_core.c:3453 uart_handle_cts_change+0xb4/0xec
    [   85.134694] Modules linked in: hci_uart bluetooth ecdh_generic ecc wlcore_sdio configfs
    [   85.143314] CPU: 0 PID: 27 Comm: kworker/u3:0 Not tainted 6.6.3-00021-gd62a2f068f92 #1
    [   85.151396] Hardware name: Freescale MXS (Device Tree)
    [   85.156679] Workqueue: hci0 hci_power_on [bluetooth]
    (...)
    [   85.191765]  uart_handle_cts_change from mxs_auart_irq_handle+0x380/0x3f4
    [   85.198787]  mxs_auart_irq_handle from __handle_irq_event_percpu+0x88/0x210
    (...)

Cc: stable@vger.kernel.org
Fixes: 4d90bb147ef6 ("serial: core: Document and assert lock requirements for irq helpers")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
Link: https://lore.kernel.org/r/20240320121530.11348-1-emil.kronborg@protonmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4749331fe618..1e8853eae504 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1086,11 +1086,13 @@ static void mxs_auart_set_ldisc(struct uart_port *port,
 
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
-	u32 istat;
+	u32 istat, stat;
 	struct mxs_auart_port *s = context;
 	u32 mctrl_temp = s->mctrl_prev;
-	u32 stat = mxs_read(s, REG_STAT);
 
+	uart_port_lock(&s->port);
+
+	stat = mxs_read(s, REG_STAT);
 	istat = mxs_read(s, REG_INTR);
 
 	/* ack irq */
@@ -1126,6 +1128,8 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 		istat &= ~AUART_INTR_TXIS;
 	}
 
+	uart_port_unlock(&s->port);
+
 	return IRQ_HANDLED;
 }
 


