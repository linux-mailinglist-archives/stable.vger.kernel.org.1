Return-Path: <stable+bounces-23754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504608680E4
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 20:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4994298268
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16412FB10;
	Mon, 26 Feb 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGKIAXvq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC622069
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975420; cv=none; b=MBmwvS3sRb9WrkxJyOb6XEndhgQJ/lJ/aSZSLh0TK14v6MEGvQMkMph6kqb+DcOqpusVhPAkhxoMKKhChwQJVErrJwQXn8uKtAiWl1zcVGM/xXkh/XRh30LXkLK73Flz474V6H03vBg1IhMElWv14gQjCoqFoy/eXpf3gpG8o58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975420; c=relaxed/simple;
	bh=RIaUJYfd1turT62O8XqlowDKwrAPQEYnub3MbudaHOc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=bdUc9/8xseSFPhxeZxCXQsV8SDWbRsAVLIY/fnAgvkwViTeGpJPYlk1YGAOTwQDVWnAoBaH9XLNCYiPmJFuv2nFsMrCF868SXTIJUQH/Z8EQrOGrxandXrAAh7S/4WWklqeweaYtZ600dk5nvfB34CfK2nf4hZ1MJL3guUvtDmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGKIAXvq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ad239f8fso59292897b3.0
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708975417; x=1709580217; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=srrm+S8jUudlxyacmT7eG3M+AguE7ufuIMxy9ow2wbY=;
        b=BGKIAXvq2iHLOk0s5wguMNmoAAVkhDm8x4KWg1aaIS2WowbcZBMuJ6x9bLuiwxvG0l
         jeG+jLXZnSGZRsZap6bCFnk5p+4PyB+dhSyYE7KIvbU/tAkKX4xeN8eluG5fuXRziXe0
         0MDQ59gKJURS0PEMxRP2itj4Oht8GrjDiPDIlgBSzXC+CmcSnOBGop/ndiq0gaJAgiuR
         sUu+Be8smG8LQCEMuYVtyM46WrXtrEEkO8R0OEB7UCLnGufPKQNW7a6tBIXu+eJu4xYi
         voxai8+63kOyNkCSWrzFDbVri6DjuGW8dMnWC056EHZSH/NOwJpA+fuBnwA4t0tnCMts
         COCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708975417; x=1709580217;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srrm+S8jUudlxyacmT7eG3M+AguE7ufuIMxy9ow2wbY=;
        b=ZaFBueAocMinmJDraWPkXWKllSGh75M0VIb7SF6I1YxNrktbgU+URz7plHH1eUzYbx
         6R0hrBfO4qeRaSmMR6Z+zuO59Rx3qLPEsVaoorjnhu2gOYk/8j7eAagvJXRw1fosQ+Hz
         D+pw/Apq+VdO9q7lC+m+O46z3q36Mr1U1JS1COtt65L2cEu1Saamemv91TpQKSKiWIEn
         ZHfNydFpP2AprVsKJahe/+X5jUH6ZXKFKaS4Z/ThQ4TojJCFvBxnV7ip7F0Du8l6I6vX
         7j8pYbW41QCrUH8uQf6uu+gvXgjYBX4rhZUheP2x81SQ7BMUsI1szD4P6Q0jvgf/MaJq
         CvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCTRobcmskOu/ZlrNOTKqwhgp/bWtahiDPpU64Zzteh/PEg78mtiCyDzvuvgemx1wxpQEoqnjmvskmMERhv3bqI17eeT00
X-Gm-Message-State: AOJu0YxHAIdHItShYebRUkAXE+fcm9o3tJHvMlCKFXrKey896Edd3rgh
	fAkgyaAgZuoEd8tXzeUE0uqy8wjXR4jwQoJEXMRBwffA9tLHNdNUevfL8nOrHtbioA==
X-Google-Smtp-Source: AGHT+IE8s0uZISIgBWhNjntfNra4t7Ryjt70aLX4nP2xwzdXstJkzSJ9+ZStoyuI3mzgt3AMV9AAZGw=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:f53b:71ca:7113:2c2b])
 (user=pcc job=sendgmr) by 2002:a05:6902:34b:b0:dcc:6065:2b3d with SMTP id
 e11-20020a056902034b00b00dcc60652b3dmr35640ybs.8.1708975416968; Mon, 26 Feb
 2024 11:23:36 -0800 (PST)
Date: Mon, 26 Feb 2024 11:23:26 -0800
Message-Id: <20240226192329.3281301-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2] serial: Lock console when calling into driver before registration
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
index f2444b581e16..f51e4e5a869d 100644
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
+			if (err != 0)
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
2.44.0.rc1.240.g4c46232300-goog


