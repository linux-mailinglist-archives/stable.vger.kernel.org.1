Return-Path: <stable+bounces-32987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBFC88E89E
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF551C280D6
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5A1879;
	Wed, 27 Mar 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q7GQ5nc+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4A1272C7
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552228; cv=none; b=ihHRZmMMSHoEset80fYzlh81yPSG9xAczc4rmc9Y8Jp1INPleM5I871zMaqUoMEXWfBV2hpT32kHvwnB7M+7VuVfKRWhf19KdukRlzJfoxt+xTGLeR8N378M695QBbQHJ1IF630+o9QQb4QlkvQfGLL/viizP2iViUZiVkPlEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552228; c=relaxed/simple;
	bh=9f/6GzI5+XNZLuHt7yzCWIuchge1gsqxIBe3r9QZGfU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mgeU5C7DARs96QsU/NqJVvGHjHbRywcJN/OTD4AqF4CmoRRdnOaMbs+Pg4Nt8Bqcer+wwehQ8S55LBzpn/MF0i0H7AgoubbEnCo+4mCtOQ6vGsM6TmMa/tjm6NTCIqQFlmTHCB9CjfA+akcwF0MU5cSQvS6uR3NeZrc8dXluze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q7GQ5nc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D6BC433C7;
	Wed, 27 Mar 2024 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711552227;
	bh=9f/6GzI5+XNZLuHt7yzCWIuchge1gsqxIBe3r9QZGfU=;
	h=Subject:To:Cc:From:Date:From;
	b=q7GQ5nc+NjVWWL1rmmfqx9q0J/S/hvcHyQ9RwBjn9RWyZ9jotvZmOy3V5/3uXww/R
	 U+qWQB2oASrcOfLIMzxdY7l4tCOYI9+XtOwWjNLHxfyCRYtn5uU3WpD6UrC6YPPiaj
	 Uh3oS7Ciqxo+3ilY7JNS4vH9XVQoFd2ql5ckSicE=
Subject: FAILED: patch "[PATCH] serial: 8250_dw: Do not reclock if already at correct rate" failed to apply to 4.19-stable tree
To: pcc@google.com,andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:10:18 +0100
Message-ID: <2024032718-mockup-swoosh-2069@gregkh>
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
git cherry-pick -x e5d6bd25f93d6ae158bb4cd04956cb497a85b8ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032718-mockup-swoosh-2069@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at correct rate")
74365bc138ab ("serial: 8250_dw: drop bogus uartclk optimisation")
0eb9da9cf201 ("serial: 8250_dw: Fix the trivial typo in the comment")
cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
0be160cf86f9 ("serial: 8250_dw: Pass the same rate to the clk round and set rate methods")
442fdef1b931 ("serial: 8250_dw: Simplify the ref clock rate setting procedure")
a8afc193558a ("serial: 8250_dw: Use devm_clk_get_optional() to get the input clock")
4d5675c3b10b ("serial: 8250_dw: switch to use 8250_dwlib library")
62907e90cc7e ("serial: 8250_dw: use pointer to uart local variable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5d6bd25f93d6ae158bb4cd04956cb497a85b8ef Mon Sep 17 00:00:00 2001
From: Peter Collingbourne <pcc@google.com>
Date: Thu, 22 Feb 2024 11:26:34 -0800
Subject: [PATCH] serial: 8250_dw: Do not reclock if already at correct rate

When userspace opens the console, we call set_termios() passing a
termios with the console's configured baud rate. Currently this causes
dw8250_set_termios() to disable and then re-enable the UART clock at
the same frequency as it was originally. This can cause corruption
of any concurrent console output. Fix it by skipping the reclocking
if we are already at the correct rate.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Fixes: 4e26b134bd17 ("serial: 8250_dw: clock rate handling for all ACPI platforms")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240222192635.1050502-1-pcc@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 2d1f350a4bea..c1d43f040c43 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -357,9 +357,9 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	long rate;
 	int ret;
 
-	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, newrate);
-	if (rate > 0) {
+	if (rate > 0 && p->uartclk != rate) {
+		clk_disable_unprepare(d->clk);
 		/*
 		 * Note that any clock-notifer worker will block in
 		 * serial8250_update_uartclk() until we are done.
@@ -367,8 +367,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 		ret = clk_set_rate(d->clk, newrate);
 		if (!ret)
 			p->uartclk = rate;
+		clk_prepare_enable(d->clk);
 	}
-	clk_prepare_enable(d->clk);
 
 	dw8250_do_set_termios(p, termios, old);
 }


