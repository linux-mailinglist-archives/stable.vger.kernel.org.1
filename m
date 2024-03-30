Return-Path: <stable+bounces-33821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A7892A23
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15E21F21FA0
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730B6200D6;
	Sat, 30 Mar 2024 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bciPulYP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25C1EB2B
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792645; cv=none; b=ovHGb89DyUSXeHfEqWnN6ps1gg05hk3lfbjMiC7kj2wwMJZU2d+MaIaAyOxe1rvwalJFLCnN9bbnzIgu1gqYHutvqwsi6vrWm8EBjb55Rj1z0d3bPhpZFH9CczkHj3eJustWXkebxt/cHQ4hBFCIwzUJwTPCJ/zUQzxCB/eNgME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792645; c=relaxed/simple;
	bh=ncldGYUGYUqK7LIRcR/oH/aiXGkSPjrIT50WPIXsLTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eTA+G42H81rMHzS7qOIkX7XbzJtEmjKMRlzm8v3DzQHfF0Qp+PtbtxHwXxwOXtmpD2+E+8JoxHY5s0DzAPttlQwzBPm/goiZJLMCgML8prEunR7rEeFjj30MU5/xqBhupMPJSaJXq85Q63He0a0fcW576TnJf9t17bpITOsCzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bciPulYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67E8C433C7;
	Sat, 30 Mar 2024 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711792645;
	bh=ncldGYUGYUqK7LIRcR/oH/aiXGkSPjrIT50WPIXsLTc=;
	h=Subject:To:Cc:From:Date:From;
	b=bciPulYP42fn1lwgllwsQfJ3H1v7kz3lHhC35+uONFR74T7tsVhcITemjJCcjcWc+
	 muPPEvozYyqX3ECS8CjPOMD5aUm5lVVq7m+ZnYcs9sa4zAmPwEmJpVWnVuBAb+FljP
	 Q0fWwo54k7mbuYH+u4bYlkpFWGIPqz1fEDRg8jBE=
Subject: FAILED: patch "[PATCH] gpio: cdev: sanitize the label before requesting the" failed to apply to 6.1-stable tree
To: bartosz.golaszewski@linaro.org,wahrenst@gmx.net,warthog618@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 10:55:15 +0100
Message-ID: <2024033015-showy-immodest-66bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b34490879baa847d16fc529c8ea6e6d34f004b38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033015-showy-immodest-66bb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b34490879baa847d16fc529c8ea6e6d34f004b38 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 25 Mar 2024 10:02:42 +0100
Subject: [PATCH] gpio: cdev: sanitize the label before requesting the
 interrupt

When an interrupt is requested, a procfs directory is created under
"/proc/irq/<irqnum>/<label>" where <label> is the string passed to one of
the request_irq() variants.

What follows is that the string must not contain the "/" character or
the procfs mkdir operation will fail. We don't have such constraints for
GPIO consumer labels which are used verbatim as interrupt labels for
GPIO irqs. We must therefore sanitize the consumer string before
requesting the interrupt.

Let's replace all "/" with ":".

Cc: stable@vger.kernel.org
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Closes: https://lore.kernel.org/linux-gpio/39fe95cb-aa83-4b8b-8cab-63947a726754@gmx.net/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Kent Gibson <warthog618@gmail.com>

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f384fa278764..fa9635610251 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1083,10 +1083,20 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 	return 0;
 }
 
+static inline char *make_irq_label(const char *orig)
+{
+	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
+}
+
+static inline void free_irq_label(const char *label)
+{
+	kfree(label);
+}
+
 static void edge_detector_stop(struct line *line)
 {
 	if (line->irq) {
-		free_irq(line->irq, line);
+		free_irq_label(free_irq(line->irq, line));
 		line->irq = 0;
 	}
 
@@ -1110,6 +1120,7 @@ static int edge_detector_setup(struct line *line,
 	unsigned long irqflags = 0;
 	u64 eflags;
 	int irq, ret;
+	char *label;
 
 	eflags = edflags & GPIO_V2_LINE_EDGE_FLAGS;
 	if (eflags && !kfifo_initialized(&line->req->events)) {
@@ -1146,11 +1157,17 @@ static int edge_detector_setup(struct line *line,
 			IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
 	irqflags |= IRQF_ONESHOT;
 
+	label = make_irq_label(line->req->label);
+	if (!label)
+		return -ENOMEM;
+
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
-				   irqflags, line->req->label, line);
-	if (ret)
+				   irqflags, label, line);
+	if (ret) {
+		free_irq_label(label);
 		return ret;
+	}
 
 	line->irq = irq;
 	return 0;
@@ -1973,7 +1990,7 @@ static void lineevent_free(struct lineevent_state *le)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
 	if (le->irq)
-		free_irq(le->irq, le);
+		free_irq_label(free_irq(le->irq, le));
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2114,6 +2131,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	int fd;
 	int ret;
 	int irq, irqflags = 0;
+	char *label;
 
 	if (copy_from_user(&eventreq, ip, sizeof(eventreq)))
 		return -EFAULT;
@@ -2198,15 +2216,23 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	if (ret)
 		goto out_free_le;
 
+	label = make_irq_label(le->label);
+	if (!label) {
+		ret = -ENOMEM;
+		goto out_free_le;
+	}
+
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(irq,
 				   lineevent_irq_handler,
 				   lineevent_irq_thread,
 				   irqflags,
-				   le->label,
+				   label,
 				   le);
-	if (ret)
+	if (ret) {
+		free_irq_label(label);
 		goto out_free_le;
+	}
 
 	le->irq = irq;
 


