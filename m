Return-Path: <stable+bounces-26410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74625870E77
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27801F216DE
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3D7BAF3;
	Mon,  4 Mar 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lX9JTDcf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB579DCE
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588647; cv=none; b=qokNvOyynpjcyUPv7HCo9G1ru+ZbP002jgAtTBV8QkscbeUc293vV9/5TzFDPlgu+sBb252xmWDqWbWsxsVK3YhiY/l6MfRVTZhosmIfaG/2TusbTHYAUi4+XBaDX9oULDeDmOpw1btCWzpKbWrseZtQ5J69dE1Qi71VMvbH6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588647; c=relaxed/simple;
	bh=k54BQDnVaDLi9qQtBZIIJpHAK+gAdsb5p17VfnKkCU8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=aSBfLVw58qGkYIQX2k0rBMB+GaKt6P7CxBnDOskbFFxBTIzucPO/IxUuydOPNoPcoEfeKbo2qKT1VEDMheetQKELiC69qgR3VzVBGpSH1i94YXyAUW2v86KEU0hSk4uQZsYswzxxcdSv5GxeOcvtAsII9nzhIHPfDSACootg4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lX9JTDcf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso78129177b3.0
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709588643; x=1710193443; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3MOnsESfIdy6Gd0VffalW28MvP4fdvEt7PkqIUhr4mU=;
        b=lX9JTDcfB9TcK1DeuC56mGtNBz6wM1Dzxo7DwJhoCO4n4HibMI+HR75BC1vJqFf563
         3goIO4tGOsITquL/fnzjSMpf5aJ6cRvn9tvARPFuHEIvhsCj6Vk5f/lJbOY+UqqMJFHK
         uv+oAfmVzdJ7T2gzpJPhzxAOUUTjo1EKhh6E+FPcCJH+nTdFsdGZR0VsGFYHFcTYCFt2
         624aUVM8b4wQG8ESjMAA/lEz82hGmMl+JSxFQxv9pmKvPBI3d4gDMKVbAAV41OgzeZhC
         LJkqgtcuBj5hPi68uLJVYlO1K4tp+CKQgnTkoA2NL70zdR5avE19/jWu8oo9LAc5avxo
         /3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709588643; x=1710193443;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3MOnsESfIdy6Gd0VffalW28MvP4fdvEt7PkqIUhr4mU=;
        b=v1D00tOWXd5fhWuIdO/hE7gXglW5/dI7f6zjYOqN3DW+k4RCT8RyIuB4ywJ3gpBm4+
         fhOoBoyGs4R/D3P4wr7zKuNSzxdAaKsdB8AP5BKCK4a67VwsYN7jZOwySESwSoo18ulQ
         A+h5YqfPFl2m9EqhNytEXLMapj7hTox1Q0aESibr0Tzl1+//2IlBv4+5xOcy2ccXc2a0
         odj82Z6hECRLKZ7CHl0t4S6XsChBw5rV7cyxJWCyPYmE0uHXchAY0xHnX4k8hwJLF4K9
         8wlrcbCRRgI1wfXoUb/p5Xm24OlJnDs8Mum/Ls094T/AlX8s0stXQNPftlqkMFgw6pnf
         F+nw==
X-Forwarded-Encrypted: i=1; AJvYcCW+p6v6OkSVuKZklZoBQF7J0RoymZnJiTRb47+32BoicOhpYNBq+I/L2HdIljPcTjwct5V1JiI1EGzIm+6RqUEe8oN/gbya
X-Gm-Message-State: AOJu0YxXcv2YgB2zBTEtd6z/2lZHXizfcKI35SY4L/85MUPv9pAVFy6w
	gUH2//2PZIhJ8LjHV/IMwGOujEnZqrdUs49FiOChykWFPEzWXY/YTa+sNwNnpBvsqQ==
X-Google-Smtp-Source: AGHT+IGd5VTnz4a2s40nN1Pu7WiZVsCbdLPK96GXidJg40QzZ2VjprVSIdXxjNRiYuuzfE/OpvX2AHk=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:ced5:860f:bb76:b50a])
 (user=pcc job=sendgmr) by 2002:a5b:e86:0:b0:dc7:4ca0:cbf0 with SMTP id
 z6-20020a5b0e86000000b00dc74ca0cbf0mr138369ybr.3.1709588643163; Mon, 04 Mar
 2024 13:44:03 -0800 (PST)
Date: Mon,  4 Mar 2024 13:43:49 -0800
Message-Id: <20240304214350.501253-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3] serial: Lock console when calling into driver before registration
From: Peter Collingbourne <pcc@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During the handoff from earlycon to the real console driver, we have
two separate drivers operating on the same device concurrently. In the
case of the 8250 driver these concurrent accesses cause problems due
to the driver's use of banked registers, controlled by LCR.DLAB. It is
possible for the setup(), config_port(), pm() and set_mctrl() callbacks
to set DLAB, which can cause the earlycon code that intends to access
TX to instead access DLL, leading to missed output and corruption on
the serial line due to unintended modifications to the baud rate.

In particular, for setup() we have:

univ8250_console_setup()
-> serial8250_console_setup()
-> uart_set_options()
-> serial8250_set_termios()
-> serial8250_do_set_termios()
-> serial8250_do_set_divisor()

For config_port() we have:

serial8250_config_port()
-> autoconfig()

For pm() we have:

serial8250_pm()
-> serial8250_do_pm()
-> serial8250_set_sleep()

For set_mctrl() we have (for some devices):

serial8250_set_mctrl()
-> omap8250_set_mctrl()
-> __omap8250_set_mctrl()

To avoid such problems, let's make it so that the console is locked
during pre-registration calls to these callbacks, which will prevent
the earlycon driver from running concurrently.

Remove the partial solution to this problem in the 8250 driver
that locked the console only during autoconfig_irq(), as this would
result in a deadlock with the new approach. The console continues
to be locked during autoconfig_irq() because it can only be called
through uart_configure_port().

Although this patch introduces more locking than strictly necessary
(and in particular it also locks during the call to rs485_config()
which is not affected by this issue as far as I can tell), it follows
the principle that it is the responsibility of the generic console
code to manage the earlycon handoff by ensuring that earlycon and real
console driver code cannot run concurrently, and not the individual
drivers.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Link: https://linux-review.googlesource.com/id/I7cf8124dcebf8618e6b2ee543fa5b25532de55d8
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
v3:
- switch to if (err)

v2:
- add some comments

 drivers/tty/serial/8250/8250_port.c |  6 ------
 drivers/tty/serial/serial_core.c    | 12 ++++++++++++
 kernel/printk/printk.c              | 21 ++++++++++++++++++---
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ca061d3bbb9..1d65055dde27 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1329,9 +1329,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		inb_p(ICP);
 	}
 
-	if (uart_console(port))
-		console_lock();
-
 	/* forget possible initially masked and pending IRQ */
 	probe_irq_off(probe_irq_on());
 	save_mcr = serial8250_in_MCR(up);
@@ -1371,9 +1368,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
 
-	if (uart_console(port))
-		console_unlock();
-
 	port->irq = (irq > 0) ? irq : 0;
 }
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6a58a9e072a..ff85ebd3a007 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2608,7 +2608,12 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 			port->type = PORT_UNKNOWN;
 			flags |= UART_CONFIG_TYPE;
 		}
+		/* Synchronize with possible boot console. */
+		if (uart_console(port))
+			console_lock();
 		port->ops->config_port(port, flags);
+		if (uart_console(port))
+			console_unlock();
 	}
 
 	if (port->type != PORT_UNKNOWN) {
@@ -2616,6 +2621,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_report_port(drv, port);
 
+		/* Synchronize with possible boot console. */
+		if (uart_console(port))
+			console_lock();
+
 		/* Power up port for set_mctrl() */
 		uart_change_pm(state, UART_PM_STATE_ON);
 
@@ -2632,6 +2641,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_rs485_config(port);
 
+		if (uart_console(port))
+			console_unlock();
+
 		/*
 		 * If this driver supports console, and it hasn't been
 		 * successfully registered yet, try to re-register it.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..89f2aa2e1172 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3263,6 +3263,21 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static int console_call_setup(struct console *newcon, char *options)
+{
+	int err;
+
+	if (!newcon->setup)
+		return 0;
+
+	/* Synchronize with possible boot console. */
+	console_lock();
+	err = newcon->setup(newcon, options);
+	console_unlock();
+
+	return err;
+}
+
 /*
  * This is called by register_console() to try to match
  * the newly registered console with any of the ones selected
@@ -3298,8 +3313,8 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (_braille_register_console(newcon, c))
 				return 0;
 
-			if (newcon->setup &&
-			    (err = newcon->setup(newcon, c->options)) != 0)
+			err = console_call_setup(newcon, c->options);
+			if (err)
 				return err;
 		}
 		newcon->flags |= CON_ENABLED;
@@ -3325,7 +3340,7 @@ static void try_enable_default_console(struct console *newcon)
 	if (newcon->index < 0)
 		newcon->index = 0;
 
-	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
+	if (console_call_setup(newcon, NULL) != 0)
 		return;
 
 	newcon->flags |= CON_ENABLED;
-- 
2.44.0.278.ge034bb2e1d-goog


