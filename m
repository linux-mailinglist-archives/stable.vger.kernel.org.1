Return-Path: <stable+bounces-20655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F385185AACF
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C2A1F225F3
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF9481AB;
	Mon, 19 Feb 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NRUEJqOK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2145952
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366834; cv=none; b=ndsORVVbP5QxanZ0dJodpsG8F3KzLNu4DMXmUGJczlaYiJ/phsnIJ3Rr48jtcMHjb+tSN7ScIRKzxF4VCTClwlvgk4SfhkEfGho7h00MoIwUKoYx1SSNs0cd0eFh7Z3OuV+d+S9NoCFlcJFFkIc3CSIK2xUvU09yTBxN+Kq+P0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366834; c=relaxed/simple;
	bh=sgGaxnzIAneiCszRSFjdzLgsjFH+BiMEzrn6esJ3bJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a7uuHsKS6Q2Ijts3db+i73iB8gmPyLFLFERbOgAgXq3VYcipm9RtQJjMeGDdS74lr/o2eHS0wWSIfKQ0+grBqCqajoJ3b0zsAqSxHpzW6DRPWF3vvNzYHKFd9HSKbDhh3UsWz3p0R3C7Q46aUrh37z4SRdh3cW6b0S1sssjUQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NRUEJqOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37ECC433F1;
	Mon, 19 Feb 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366834;
	bh=sgGaxnzIAneiCszRSFjdzLgsjFH+BiMEzrn6esJ3bJU=;
	h=Subject:To:Cc:From:Date:From;
	b=NRUEJqOKBD6uiu5j4hIovbIjbnh4uHY8OOIsskk6oDEGBm6OkbD8H2uXp6WFrgPSM
	 b35GSpQQ2UYB4Z8nwVpT0AyIw0N2PQgdzMPBrvT7saood7I5Ijg1E6R9/64PhwPfSY
	 SF7BiUydWR4VSWzUz+ou7XcTAFZ2MbMOSYggxeMw=
Subject: FAILED: patch "[PATCH] serial: core: Fix atomicity violation in uart_tiocmget" failed to apply to 6.1-stable tree
To: 2045gemini@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:20:24 +0100
Message-ID: <2024021924-immerse-spur-af58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 30926783a46841c2d1bbf3f74067ba85d304fd0d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021924-immerse-spur-af58@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

30926783a468 ("serial: core: Fix atomicity violation in uart_tiocmget")
559c7ff4e324 ("serial: core: Use port lock wrappers")
84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
51e45fba14bf ("serial: core: lock port for start_rx() in uart_resume_port()")
abcb0cf1f5b2 ("serial: core: lock port for stop_rx() in uart_suspend_port()")
d5b3d02d0b10 ("serial: Make uart_remove_one_port() return void")
63f4c3456171 ("serial: core: Disable uart_start() on uart_remove_one_port()")
826736a6c7c8 ("serial: Rename uart_change_speed() to uart_change_line_settings()")
8e90cf29aef7 ("serial: Move uart_change_speed() earlier")
b300fb26c59a ("tty: Convert ->carrier_raised() and callchains to bool")
515be7baeddb ("tty: Cleanup tty_port_set_initialized() bool parameter")

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


