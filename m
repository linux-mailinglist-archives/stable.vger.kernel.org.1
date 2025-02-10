Return-Path: <stable+bounces-114567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB91A2EEC9
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F5C1884F95
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A84230988;
	Mon, 10 Feb 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUYEe+oa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627422FDFA
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195442; cv=none; b=HgM/i7PQohm+WWREgdc358zB+RmQC/VBo2mDuZdkurRbeKuwYBaOQNxw9LQT6bD6Dci8+PNoJjNEpHYOPe/0kOuIZyQESTYSpmARCi4eFMq+kT6OLkh0wd1DhO9bEGnfXDFfqXy5O0SRo3WZwx0bAJT9HpuzByljb9/D64V7Ph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195442; c=relaxed/simple;
	bh=DF2TKcYdryiG8XKgflMUmR1wy3IePEX4GC5OhU0LDto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H2Bpy0v5dmvAvfV4wGIMR16optDvO4Sgemd0omL6+p9PrWGdkVoXRbeR/3NODgH1rl0Uqhw3mQKCCsDJec0DbZ1D6FunpCNkqnRKOs+mIf0y4YszL2ItdnerXTVjye1uifKds20fEvIfVnU0HLYdsQwg0DySkmbIqUjl71CfFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aUYEe+oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E094AC4CED1;
	Mon, 10 Feb 2025 13:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195439;
	bh=DF2TKcYdryiG8XKgflMUmR1wy3IePEX4GC5OhU0LDto=;
	h=Subject:To:Cc:From:Date:From;
	b=aUYEe+oagnG2NSm/cROxy6rhDKdjJ6ZefOaXN3HER/hK1vrdpgf4V2pQAXrihf2o7
	 7LhJ+dk8gN9dZ+cMYK7xB3n8/SNrkhLfIIwABJ2mLY9UCSYVUXnW+ITWF0XORXISrW
	 UPQWD9kePeSICgp55ZnBsj4t92WngmxUwpO4JTrk=
Subject: FAILED: patch "[PATCH] serial: sh-sci: Increment the runtime usage counter for the" failed to apply to 5.10-stable tree
To: claudiu.beznea.uj@bp.renesas.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:50:19 +0100
Message-ID: <2025021018-eaten-speech-f2c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021018-eaten-speech-f2c6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


