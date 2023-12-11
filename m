Return-Path: <stable+bounces-5513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E480D362
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8642D1F216CE
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAED24D12D;
	Mon, 11 Dec 2023 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Ca5GYD9G"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD20BD;
	Mon, 11 Dec 2023 09:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=KQJGMCi+9vgzmcgkV00ZLgFOlfqhKFVUpyjrvhiM+CI=; b=Ca5GYD9GRgTNy7UiE9F73MCJjP
	mAEhiHSrDq9m0i4zEXMBP1l38WcG4dRKE0mk1Nl5bFphQM9qLZE58kJ3LKhFCWwNWEW2fq2MUPokU
	MwAufwxxOu7GBU0ZwL/AvkZlYOgcDA7uALJxMSotD/lfrxizqoiH6focpJh70OWRRm3Q=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56730 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rCjr1-0003yC-SU; Mon, 11 Dec 2023 12:14:05 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	jringle@gridpoint.com,
	tomasz.mon@camlingroup.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	stable@vger.kernel.org
Date: Mon, 11 Dec 2023 12:13:51 -0500
Message-Id: <20231211171353.2901416-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211171353.2901416-1-hugo@hugovil.com>
References: <20231211171353.2901416-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: [PATCH v2 4/6] serial: sc16is7xx: change EFR lock to operate on each channels
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Now that the driver has been converted to use one regmap per port, change
efr locking to operate on a channel basis instead of on the whole IC.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 49 ++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 0a7a9aa5c9fa..0bda9b74d096 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -323,6 +323,7 @@ struct sc16is7xx_one_config {
 struct sc16is7xx_one {
 	struct uart_port		port;
 	struct regmap			*regmap;
+	struct mutex			efr_lock; /* EFR registers access */
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
 	struct kthread_delayed_work	ms_work;
@@ -342,7 +343,6 @@ struct sc16is7xx_port {
 	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
-	struct mutex			efr_lock;
 	struct sc16is7xx_one		p[];
 };
 
@@ -494,7 +494,6 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	u8 lcr;
 	u8 prescaler = 0;
@@ -518,7 +517,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	 * because the bulk of the interrupt processing is run as a workqueue
 	 * job in thread context.
 	 */
-	mutex_lock(&s->efr_lock);
+	mutex_lock(&one->efr_lock);
 
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
 
@@ -537,7 +536,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	mutex_unlock(&s->efr_lock);
+	mutex_unlock(&one->efr_lock);
 
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
@@ -705,11 +704,10 @@ static unsigned int sc16is7xx_get_hwmctrl(struct uart_port *port)
 static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 {
 	struct uart_port *port = &one->port;
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned long flags;
 	unsigned int status, changed;
 
-	lockdep_assert_held_once(&s->efr_lock);
+	lockdep_assert_held_once(&one->efr_lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
 	changed = status ^ one->old_mctrl;
@@ -735,15 +733,20 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
+	bool rc = true;
 	struct uart_port *port = &s->p[portno].port;
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	mutex_lock(&one->efr_lock);
 
 	do {
 		unsigned int iir, rxlen;
-		struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
 		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
-		if (iir & SC16IS7XX_IIR_NO_INT_BIT)
-			return false;
+		if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
+			rc = false;
+			goto out_port_irq;
+		}
 
 		iir &= SC16IS7XX_IIR_ID_MASK;
 
@@ -783,15 +786,17 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 			break;
 		}
 	} while (0);
-	return true;
+
+out_port_irq:
+	mutex_unlock(&one->efr_lock);
+
+	return rc;
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 {
 	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
 
-	mutex_lock(&s->efr_lock);
-
 	while (1) {
 		bool keep_polling = false;
 		int i;
@@ -802,24 +807,22 @@ static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 			break;
 	}
 
-	mutex_unlock(&s->efr_lock);
-
 	return IRQ_HANDLED;
 }
 
 static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 	struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	unsigned long flags;
 
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
-	mutex_lock(&s->efr_lock);
+	mutex_lock(&one->efr_lock);
 	sc16is7xx_handle_tx(port);
-	mutex_unlock(&s->efr_lock);
+	mutex_unlock(&one->efr_lock);
 
 	uart_port_lock_irqsave(port, &flags);
 	sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
@@ -926,9 +929,9 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
 
 	if (one->port.state) {
-		mutex_lock(&s->efr_lock);
+		mutex_lock(&one->efr_lock);
 		sc16is7xx_update_mlines(one);
-		mutex_unlock(&s->efr_lock);
+		mutex_unlock(&one->efr_lock);
 
 		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
 	}
@@ -1012,7 +1015,6 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 				  struct ktermios *termios,
 				  const struct ktermios *old)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	unsigned int lcr, flow = 0;
 	int baud;
@@ -1071,7 +1073,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 		port->ignore_status_mask |= SC16IS7XX_LSR_BRK_ERROR_MASK;
 
 	/* As above, claim the mutex while accessing the EFR. */
-	mutex_lock(&s->efr_lock);
+	mutex_lock(&one->efr_lock);
 
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
 			     SC16IS7XX_LCR_CONF_MODE_B);
@@ -1101,7 +1103,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	/* Update LCR register */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	mutex_unlock(&s->efr_lock);
+	mutex_unlock(&one->efr_lock);
 
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
@@ -1535,7 +1537,6 @@ static int sc16is7xx_probe(struct device *dev,
 
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
-	mutex_init(&s->efr_lock);
 
 	kthread_init_worker(&s->kworker);
 	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
@@ -1578,6 +1579,8 @@ static int sc16is7xx_probe(struct device *dev,
 			goto out_ports;
 		}
 
+		mutex_init(&s->p[i].efr_lock);
+
 		ret = uart_get_rs485_mode(&s->p[i].port);
 		if (ret)
 			goto out_ports;
-- 
2.39.2


