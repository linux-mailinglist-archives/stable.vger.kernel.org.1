Return-Path: <stable+bounces-114564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF391A2EEC5
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119D21884F92
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5BA22FDE5;
	Mon, 10 Feb 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gzf/fWJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA81C07D8
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195430; cv=none; b=kOOyhuHeSHrdSFUKc+52JGJtk2zEauV82RBtuV1IHJZO5q32WPIhY6PhaU63/6GlLLrGke7YpdxJ5qEGnQjdfKz6PEEvBA8cfWRPh7nMkMFdmqVO0XIZ5FaPb5xbgM0r/Aj76QojZbH+afdQU9WL7+zRN7lxKXxBA1F6dlHssDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195430; c=relaxed/simple;
	bh=1LuAnCnQyVPEL2VcePh/9057it1v9S5Iw1ezuSW9rq8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FlwM8hyIoQkp4dWIGqcXR6VQ42mQ6seIVmSqcWVCcX0v7Dkk2fnF8Z/MYMCp8h3tkqhu0SxyQVLX6r2cO5GLz/Cr7CTbMFPiimRuZjXlg7naCFE+9gYjWIt5ol3Y36B/qnKJMuFY+xFVIRYTfWLilzLRvpPApXEOY7UzOSwcX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gzf/fWJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49886C4CED1;
	Mon, 10 Feb 2025 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195429;
	bh=1LuAnCnQyVPEL2VcePh/9057it1v9S5Iw1ezuSW9rq8=;
	h=Subject:To:Cc:From:Date:From;
	b=Gzf/fWJlKdaeQlWSoFA4sEaVW+bykllCaZXFA9KG2WQa4z9nKKgCtDEclFmPcK1tV
	 CjibQDZ75XCyRaoNdZYfJ3Mht0BSahOiHe/14fJ+8G4M8DRlFpUf9QFgaUckdrj5G/
	 szTuQpB2r7a5U/ZfFs8AcM2GHCu1uCy0FIFoTvL4=
Subject: FAILED: patch "[PATCH] serial: sh-sci: Increment the runtime usage counter for the" failed to apply to 6.6-stable tree
To: claudiu.beznea.uj@bp.renesas.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:50:16 +0100
Message-ID: <2025021016-jackknife-duplicity-3312@gregkh>
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
git cherry-pick -x 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021016-jackknife-duplicity-3312@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Thu, 16 Jan 2025 20:22:49 +0200
Subject: [PATCH] serial: sh-sci: Increment the runtime usage counter for the
 earlycon device

In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
with earlycon mapped at index zero.

The uart_add_one_port() function eventually calls __device_attach(),
which, in turn, calls pm_request_idle(). The identified code path is as
follows:

uart_add_one_port() ->
  serial_ctrl_register_port() ->
    serial_core_register_port() ->
      serial_core_port_device_add() ->
        serial_base_port_add() ->
          device_add() ->
            bus_probe_device() ->
              device_initial_probe() ->
                __device_attach() ->
                  // ...
                  if (dev->p->dead) {
                    // ...
                  } else if (dev->driver) {
                    // ...
                  } else {
                    // ...
                    pm_request_idle(dev);
                    // ...
                  }

The earlycon device clocks are enabled by the bootloader. However, the
pm_request_idle() call in __device_attach() disables the SCI port clocks
while earlycon is still active.

The earlycon write function, serial_console_write(), calls
sci_poll_put_char() via serial_console_putchar(). If the SCI port clocks
are disabled, writing to earlycon may sometimes cause the SR.TDFE bit to
remain unset indefinitely, causing the while loop in sci_poll_put_char()
to never exit. On single-core SoCs, this can result in the system being
blocked during boot when this issue occurs.

To resolve this, increment the runtime PM usage counter for the earlycon
SCI device before registering the UART port.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e64d59888ecd..b1ea48f38248 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3436,6 +3436,22 @@ static int sci_probe_single(struct platform_device *dev,
 	}
 
 	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * In case:
+		 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+		 * - it now maps to an alias other than zero and
+		 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+		 *   available in bootargs)
+		 *
+		 * we need to avoid disabling clocks and PM domains through the runtime
+		 * PM APIs called in __device_attach(). For this, increment the runtime
+		 * PM reference counter (the clocks and PM domains were already enabled
+		 * by the bootloader). Otherwise the earlycon may access the HW when it
+		 * has no clocks enabled leading to failures (infinite loop in
+		 * sci_poll_put_char()).
+		 */
+		pm_runtime_get_noresume(&dev->dev);
+
 		/*
 		 * Skip cleanup the sci_port[0] in early_console_exit(), this
 		 * port is the same as the earlycon one.


