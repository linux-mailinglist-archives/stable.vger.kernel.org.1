Return-Path: <stable+bounces-32986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDF88E89D
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4064E1F27412
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA51C12D774;
	Wed, 27 Mar 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7TpMDg9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB728E2E
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552224; cv=none; b=g1QkuKOdvHbaE53md4nFtIJeFgO+VK3I65roEiVG+ZDNwLb/vig6/tsJReVTFwUx5NS1+r8sH6QuB2eTWbK3Kvxa6j7nLhyfp52pe+gz3ylAULwfk4U5eB63ZM5rCHlUuv8kBr9V/Gbf3/S8X5U0r+wgp4/f/hblDmv7k/faDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552224; c=relaxed/simple;
	bh=0mZQm4BwVTXhJINwnkN/x7zQ+sncevlJVPUx/OzGjr4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=paapB6BRVFx0DlqVznjkrO4GQQUovS6KrZYWmg+Acrj9oo4bfsAOmUJ8xNdN1SUAt+F7C4tF+qIXgcUNAzILbMrRXDaFVAFAVQafFCw2w57MPnS1UNk5D6rzgtSYLRfXZKvrC35RrcVOnSk1WP0E1A+uSAPvykDoA/WhFPzqBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7TpMDg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA380C43390;
	Wed, 27 Mar 2024 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711552224;
	bh=0mZQm4BwVTXhJINwnkN/x7zQ+sncevlJVPUx/OzGjr4=;
	h=Subject:To:Cc:From:Date:From;
	b=W7TpMDg9u/Oz9EM7xTGYZ8Uyl/oQ4v8pRwtGDhT9WQ3emk2FSFaj7gJXHiSGO5Kyg
	 U5UeiyMebpypRMtTVrev//MxJGNIv3QqrSaaUhwzpCuY7cdoGmdthP89zhuavOizii
	 eUiwdN9lgP2PvSsRf6VlkmS6PiEEDeai3C17ZZHM=
Subject: FAILED: patch "[PATCH] serial: 8250_dw: Do not reclock if already at correct rate" failed to apply to 5.4-stable tree
To: pcc@google.com,andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:10:17 +0100
Message-ID: <2024032717-vehicular-nutlike-6de9@gregkh>
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
git cherry-pick -x e5d6bd25f93d6ae158bb4cd04956cb497a85b8ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032717-vehicular-nutlike-6de9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at correct rate")
74365bc138ab ("serial: 8250_dw: drop bogus uartclk optimisation")
0eb9da9cf201 ("serial: 8250_dw: Fix the trivial typo in the comment")
cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
0be160cf86f9 ("serial: 8250_dw: Pass the same rate to the clk round and set rate methods")
442fdef1b931 ("serial: 8250_dw: Simplify the ref clock rate setting procedure")
a8afc193558a ("serial: 8250_dw: Use devm_clk_get_optional() to get the input clock")

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


