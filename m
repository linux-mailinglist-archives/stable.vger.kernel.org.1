Return-Path: <stable+bounces-78421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810098B98E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE76B281266
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C719D08C;
	Tue,  1 Oct 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OJjnh7lN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9533209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778314; cv=none; b=QGDWHlujMAzKNA46SmlTd/g8G/+SUukXqg7KA65w2N5cMAEOfJH2ikZ3mmWm/sseU2MS5cjAANmKab7Bvteba4gHIh7GNObtbB9eO03jV6uUnGGeHgPxAUjkEAY9hzVODIGGa2ZNSqpNj8B3JWMfRfwTQYVECqJCAVGf71TA27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778314; c=relaxed/simple;
	bh=GLkSqYXLsOirEJwcIBNQFoSnrO9AaNeEeI2OsApmJxc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bjlted7D3wb3k6n+og1zuo63uojTfFgfVEztnVWJiZEZj6dyeFc+XYKEVPFf4aCR1vbbOZLI5k7cvccKQk4d+5Em3rx98MTmpzk1awOt1lrw8XwE2pGieBOv3ujlA39NdpinJh7gT6diZJ559YQTu7T+clBs5Kuh3f8pQhyzRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OJjnh7lN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C0EC4CEC6;
	Tue,  1 Oct 2024 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778314;
	bh=GLkSqYXLsOirEJwcIBNQFoSnrO9AaNeEeI2OsApmJxc=;
	h=Subject:To:Cc:From:Date:From;
	b=OJjnh7lNscAnTHGS4x9i8ye4a/1wIVrP2eXSwZY7PPOH7l274oGSm+LuBmTqMk+N1
	 22u1i/O17nbcsFVHASkYcLwC0EVXO9XBB04TWh3jLJjSONQhYn3O41GPTZZCHICW1v
	 siY1213nOINNv+QbovgTcAYvY/+XLD+9zRh/Qyfw=
Subject: FAILED: patch "[PATCH] serial: don't use uninitialized value in uart_poll_init()" failed to apply to 6.6-stable tree
To: jirislaby@kernel.org,dianders@chromium.org,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:25:08 +0200
Message-ID: <2024100108-attention-muppet-0778@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d0009a32c9e4e083358092f3c97e3c6e803a8930
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100108-attention-muppet-0778@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d0009a32c9e4 ("serial: don't use uninitialized value in uart_poll_init()")
788aeef392d2 ("tty: serial: kgdboc: Fix 8250_* kgdb over serial")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0009a32c9e4e083358092f3c97e3c6e803a8930 Mon Sep 17 00:00:00 2001
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Date: Mon, 5 Aug 2024 12:20:36 +0200
Subject: [PATCH] serial: don't use uninitialized value in uart_poll_init()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Coverity reports (as CID 1536978) that uart_poll_init() passes
uninitialized pm_state to uart_change_pm(). It is in case the first 'if'
takes the true branch (does "goto out;").

Fix this and simplify the function by simple guard(mutex). The code
needs no labels after this at all. And it is pretty clear that the code
has not fiddled with pm_state at that point.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
Cc: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20240805102046.307511-4-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 83c5bccc5086..e0aac155dca2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2690,14 +2690,13 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 	int ret = 0;
 
 	tport = &state->port;
-	mutex_lock(&tport->mutex);
+
+	guard(mutex)(&tport->mutex);
 
 	port = uart_port_check(state);
 	if (!port || port->type == PORT_UNKNOWN ||
-	    !(port->ops->poll_get_char && port->ops->poll_put_char)) {
-		ret = -1;
-		goto out;
-	}
+	    !(port->ops->poll_get_char && port->ops->poll_put_char))
+		return -1;
 
 	pm_state = state->pm_state;
 	uart_change_pm(state, UART_PM_STATE_ON);
@@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 		ret = uart_set_options(port, NULL, baud, parity, bits, flow);
 		console_list_unlock();
 	}
-out:
+
 	if (ret)
 		uart_change_pm(state, pm_state);
-	mutex_unlock(&tport->mutex);
+
 	return ret;
 }
 


