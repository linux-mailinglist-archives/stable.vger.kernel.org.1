Return-Path: <stable+bounces-20654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C385AACB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDCE282523
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DE481AF;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1y5WUoiX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF3B446A2
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366826; cv=none; b=TMQXYkH14EpVKS/AGiACR6aK6LI0XKLMFgxF5MmGqyJhUdhxcWNKszJ77Pu1XtaJSMQE9twR3xlQTl5yP5+60M0zPwUlveOpNQb/FrLUgl4qwDdonEn8qnUQRVBCTj751u9khfeHL+kvF0AyPveCYIo2GZ0LyY8glzQbca0PU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366826; c=relaxed/simple;
	bh=vhqdCMGpzS+7qyZnGOFAcveT8GRBxqa6u5Z9ds21oOw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yd6Zo2pS8nXGVp4mUNXwzPVEjQt2DNoR8Q/qMgHVKxYUH/qAcoMK+HJRDa6OqXxLonQOoSyO4JQxtfFx/N2aUsBNi2SibdMiLJHenqeiV8nYdkFL4vBrWMebaEfQUwRdZIEKGBCJZY9shro9rJ2WhDzuWYkQdsmt3RgX5vcGRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1y5WUoiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596DCC433F1;
	Mon, 19 Feb 2024 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366825;
	bh=vhqdCMGpzS+7qyZnGOFAcveT8GRBxqa6u5Z9ds21oOw=;
	h=Subject:To:Cc:From:Date:From;
	b=1y5WUoiXzT4Wlxcmr5fxeMzUE5pnMPYoaMO0XeSKoELrSfRzK2GCkr2etcUksbv73
	 s4d5ih94RzzlaLJeFuX1O2qFPFeSSoObLq2P7npLr3SPse4t5AYyRM/qTQMpgXZvoy
	 N9Wt5pvtrHpjEXdiwOAngLcH+S1UwMC+oJiQUqqU=
Subject: FAILED: patch "[PATCH] serial: core: Fix atomicity violation in uart_tiocmget" failed to apply to 6.6-stable tree
To: 2045gemini@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:20:23 +0100
Message-ID: <2024021922-tribute-surround-40c2@gregkh>
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
git cherry-pick -x 30926783a46841c2d1bbf3f74067ba85d304fd0d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021922-tribute-surround-40c2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

30926783a468 ("serial: core: Fix atomicity violation in uart_tiocmget")
559c7ff4e324 ("serial: core: Use port lock wrappers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30926783a46841c2d1bbf3f74067ba85d304fd0d Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Fri, 12 Jan 2024 19:36:24 +0800
Subject: [PATCH] serial: core: Fix atomicity violation in uart_tiocmget

In uart_tiocmget():
    result = uport->mctrl;
    uart_port_lock_irq(uport);
    result |= uport->ops->get_mctrl(uport);
    uart_port_unlock_irq(uport);
    ...
    return result;

In uart_update_mctrl():
    uart_port_lock_irqsave(port, &flags);
    ...
    port->mctrl = (old & ~clear) | set;
    ...
    port->ops->set_mctrl(port, port->mctrl);
    ...
    uart_port_unlock_irqrestore(port, flags);

An atomicity violation is identified due to the concurrent execution of
uart_tiocmget() and uart_update_mctrl(). After assigning
result = uport->mctrl, the mctrl value may change in uart_update_mctrl(),
leading to a mismatch between the value returned by
uport->ops->get_mctrl(uport) and the mctrl value previously read.
This can result in uart_tiocmget() returning an incorrect value.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 5.17.

To address this issue, it is suggested to move the line
result = uport->mctrl inside the uart_port_lock block to ensure atomicity
and prevent the mctrl value from being altered during the execution of
uart_tiocmget(). With this patch applied, our tool no longer reports the
bug, with the kernel configuration allyesconfig for x86_64. Due to the
absence of the requisite hardware, we are unable to conduct runtime
testing of the patch. Therefore, our verification is solely based on code
logic analysis.

[1] https://sites.google.com/view/basscheck/

Fixes: c5f4644e6c8b ("[PATCH] Serial: Adjust serial locking")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
Link: https://lore.kernel.org/r/20240112113624.17048-1-2045gemini@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b56ed8c376b2..d6a58a9e072a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1084,8 +1084,8 @@ static int uart_tiocmget(struct tty_struct *tty)
 		goto out;
 
 	if (!tty_io_error(tty)) {
-		result = uport->mctrl;
 		uart_port_lock_irq(uport);
+		result = uport->mctrl;
 		result |= uport->ops->get_mctrl(uport);
 		uart_port_unlock_irq(uport);
 	}


