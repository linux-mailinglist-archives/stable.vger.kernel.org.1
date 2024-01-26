Return-Path: <stable+bounces-16022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25ED83E737
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE031F29697
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3144121A02;
	Fri, 26 Jan 2024 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3wAjkqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801820320
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312871; cv=none; b=tEPg67pd/1KvYiYPdGIFH6S3rjOgt1N9CaApmsmavR52Dqx1pICDeDMZA/ZZX04MWhVlvJpmnqPlVPc8cKhtKnIiPQeQi0fyzM9UEve0MVzV0f0/QUD8nJJbuCkyOIRmOHKU3ylSgbIQadeQxFfg0kkQUc6qkxPvVziWUoeiqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312871; c=relaxed/simple;
	bh=UU4sjZmhJVuXenkTgxay7uecRYQCsjNpUPFTNAoN+Rs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bFwC7DeBkgd+aFvVGKdDIkfnk3MFjqf678skOZ9P698D08B7axHjUXH9Nq2Jh0Qocp7lDdNBjt6xhSCXVLS5mBVATi+aP7xfE62OZ4lXQNNZJYMhZ7WWhp9kwN2tVkLKS9ZpqyAbCRpplnSsmnCto9JmjzlJsP8HufA+dJ/+OHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3wAjkqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707ECC433C7;
	Fri, 26 Jan 2024 23:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312870;
	bh=UU4sjZmhJVuXenkTgxay7uecRYQCsjNpUPFTNAoN+Rs=;
	h=Subject:To:Cc:From:Date:From;
	b=t3wAjkqzUj8ZnS/SyooP/CACZvs2Xq9MQtOebfpKy8iTqOlwN4BWEUIlmTctQqzXR
	 SNaYDRCUhrCpdDIG1N9Vgv6PgWghUFLV3qYAVyUQyziU4GU6N+PaJaW2brLghvyzR5
	 NRW3hTW9XNb0M01O/BU+lP46wNmEv+K27i5GFKc4=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in" failed to apply to 5.15-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org,yury.norov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:47:49 -0800
Message-ID: <2024012649-autistic-cusp-6331@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8a1060ce974919f2a79807527ad82ac39336eda2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012649-autistic-cusp-6331@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error")
4409df5866b7 ("serial: sc16is7xx: change EFR lock to operate on each channels")
41a308cbedb2 ("serial: sc16is7xx: remove unused line structure member")
3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
b4a778303ea0 ("serial: sc16is7xx: add missing support for rs485 devicetree properties")
049994292834 ("serial: sc16is7xx: fix regression with GPIO configuration")
dabc54a45711 ("serial: sc16is7xx: remove obsolete out_thread label")
c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later in probe")
267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
21144bab4f11 ("sc16is7xx: Handle modem status lines")
cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
d4ab5487cc77 ("Merge 5.17-rc6 into tty-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a1060ce974919f2a79807527ad82ac39336eda2 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:08 -0500
Subject: [PATCH] serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in
 case of probe error

If an error occurs during probing, the sc16is7xx_lines bitfield may be left
in a state that doesn't represent the correct state of lines allocation.

For example, in a system with two SC16 devices, if an error occurs only
during probing of channel (port) B of the second device, sc16is7xx_lines
final state will be 00001011b instead of the expected 00000011b.

This is caused in part because of the "i--" in the for/loop located in
the out_ports: error path.

Fix this by checking the return value of uart_add_one_port() and set line
allocation bit only if this was successful. This allows the refactor of
the obfuscated for(i--...) loop in the error path, and properly call
uart_remove_one_port() only when needed, and properly unset line allocation
bits.

Also use same mechanism in remove() when calling uart_remove_one_port().

Fixes: c64349722d14 ("sc16is7xx: support multiple devices")
Cc:  <stable@vger.kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231221231823.2327894-2-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e40e4a99277e..17b90f971f96 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -407,19 +407,6 @@ static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
 	regmap_update_bits(one->regmap, reg, mask, val);
 }
 
-static int sc16is7xx_alloc_line(void)
-{
-	int i;
-
-	BUILD_BUG_ON(SC16IS7XX_MAX_DEVS > BITS_PER_LONG);
-
-	for (i = 0; i < SC16IS7XX_MAX_DEVS; i++)
-		if (!test_and_set_bit(i, &sc16is7xx_lines))
-			break;
-
-	return i;
-}
-
 static void sc16is7xx_power(struct uart_port *port, int on)
 {
 	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
@@ -1550,6 +1537,13 @@ static int sc16is7xx_probe(struct device *dev,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
+		s->p[i].port.line = find_first_zero_bit(&sc16is7xx_lines,
+							SC16IS7XX_MAX_DEVS);
+		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
+			ret = -ERANGE;
+			goto out_ports;
+		}
+
 		/* Initialize port data */
 		s->p[i].port.dev	= dev;
 		s->p[i].port.irq	= irq;
@@ -1569,14 +1563,8 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.rs485_supported = sc16is7xx_rs485_supported;
 		s->p[i].port.ops	= &sc16is7xx_ops;
 		s->p[i].old_mctrl	= 0;
-		s->p[i].port.line	= sc16is7xx_alloc_line();
 		s->p[i].regmap		= regmaps[i];
 
-		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
-			ret = -ENOMEM;
-			goto out_ports;
-		}
-
 		mutex_init(&s->p[i].efr_lock);
 
 		ret = uart_get_rs485_mode(&s->p[i].port);
@@ -1594,8 +1582,13 @@ static int sc16is7xx_probe(struct device *dev,
 		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
 		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
 		kthread_init_delayed_work(&s->p[i].ms_work, sc16is7xx_ms_proc);
+
 		/* Register port */
-		uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
+		ret = uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
+		if (ret)
+			goto out_ports;
+
+		set_bit(s->p[i].port.line, &sc16is7xx_lines);
 
 		/* Enable EFR */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
@@ -1653,10 +1646,9 @@ static int sc16is7xx_probe(struct device *dev,
 #endif
 
 out_ports:
-	for (i--; i >= 0; i--) {
-		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
-		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
-	}
+	for (i = 0; i < devtype->nr_uart; i++)
+		if (test_and_clear_bit(s->p[i].port.line, &sc16is7xx_lines))
+			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 
 	kthread_stop(s->kworker_task);
 
@@ -1678,8 +1670,8 @@ static void sc16is7xx_remove(struct device *dev)
 
 	for (i = 0; i < s->devtype->nr_uart; i++) {
 		kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
-		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
-		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
+		if (test_and_clear_bit(s->p[i].port.line, &sc16is7xx_lines))
+			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
 


