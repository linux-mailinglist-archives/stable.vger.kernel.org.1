Return-Path: <stable+bounces-20659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDF85AAD3
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4461C21E0F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DAC481DC;
	Mon, 19 Feb 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svBqzWwY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06587481B2
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366848; cv=none; b=a7CH8hm2ktRYqpPhQCBSVKB0vZ5213ZDd31WuYav9fsXJUkpwo3+tLSpQ3B16e9dAxvHJzs6FKobcyP5uwAFYYoxPq0P7Oehl1C818hj82+WQOhVkeUF4eljZc2sYzS2yzO24EWUU8urVJkQKHa6yzuBWGi7UBJAGOsHUMzk9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366848; c=relaxed/simple;
	bh=eQWtWvaoT5+t6kDy24wQR3KWr0evxDe/gmv3ZcIGDwE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n8Fs4qhVXxf2fLVv0KodSCrrHxzVyOi0v7awGItxCQ/1hLj1h5HO2AEqMQzt8PttZt4z+/OrCeNI5sxgFud1huFyoMhnuPFPmnzRbw5T8uYwMZB/PRpuxDu8S4N6zWf1U5oqbUYnnjKzZhXr84guqdwmYWTSobjR+j65RIYP0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svBqzWwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B41CC433F1;
	Mon, 19 Feb 2024 18:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366847;
	bh=eQWtWvaoT5+t6kDy24wQR3KWr0evxDe/gmv3ZcIGDwE=;
	h=Subject:To:Cc:From:Date:From;
	b=svBqzWwYY+anU3zNL0S+NvKv/5CnuI7z7Mqog9Ie0pQYKFvt1veJXl+5lMIrBxcMZ
	 kdSNmtlOajlo4NntSe1Yy8apO7jt1Nhcl881R1SMYlmSOnI02ydgwGJdsOUGEchDqb
	 ES9JrdRlQjD+Jjm0wVFBC8th+IUjeVvYjSSUw8oo=
Subject: FAILED: patch "[PATCH] serial: core: Fix atomicity violation in uart_tiocmget" failed to apply to 4.19-stable tree
To: 2045gemini@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:20:31 +0100
Message-ID: <2024021931-chop-dumping-2981@gregkh>
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
git cherry-pick -x 30926783a46841c2d1bbf3f74067ba85d304fd0d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021931-chop-dumping-2981@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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
7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in driver-specific way")
a12c68920918 ("Merge 7e2cd21e02b3 ("Merge tag 'tty-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty") into tty-next")

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


