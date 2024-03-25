Return-Path: <stable+bounces-32151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8115388A2EB
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0E42E1025
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 13:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDE161907;
	Mon, 25 Mar 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bUZNBQWa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319516D31E
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357368; cv=none; b=SE0kd35oCQTl2tTYbxcdJHNoHVL8Kp8F4Y1ymQjUdmSaB44ptOa/9qAQ1Geu6Xzw22bsCcKHaRv7hOogXamQCZ17EaEgsMCpYiQ7X6VHZ9iGx4dIcW8PpZXVn6CFyf3oOouMSYlgXg9a48adaUz6suoc1rXs0+JHyIegnSaJej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357368; c=relaxed/simple;
	bh=4reNKSpGjyBIo1QKCNeXq82qEbRTN2WkDpD7rdLXG1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsXi7EQji5qMUrTgHXw1lHZwyBp3S/WbzXPBqg4e4SnpjtlXe1OfjNfXNsWxwA3wp2jB7pnRiZOKJYqWv+qzMVbsGxB2zwrAd5g1gDssaaOy0h0ivrITznpAc1vKRE6Emvm64WZcqltQyLLb+Y1HRaAYYJaAJarIw9yniELnHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bUZNBQWa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34005b5927eso2898802f8f.1
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711357365; x=1711962165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIHhZHaPF09JSvWfnC/4E/kXpaEgooxUhhCxFC4Dwcg=;
        b=bUZNBQWaXpD3R7eXgaMy7tHsuOF+YVhh799NnUv9B95kkV+zIlw4dT+0u2FyTtILcR
         WgKPZpra3rGvPGpVWV54ZM29qX20S/P7swv2irYIz5WVwqkrKAcBhZC09HW7+msjPRPj
         1MqTqWhs8OEGyvfEZLjo1KIEw7tHrOluV3caav/4znavDfWMzAOlTNqnzW0MZ2pKvgRL
         kFdbCMtmEKU68yPPVWclUkDPS0BdYk70W5OOhA87LdG94U1sA16ygOs3eEbkMEyqSMh1
         Z1ZmQLQIx54Xg1puJyZ6lc5OJ3dpAu6pMFp/yCkxyWkCuqQuNZlkwMWOAdwa/uTB957K
         0Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711357365; x=1711962165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIHhZHaPF09JSvWfnC/4E/kXpaEgooxUhhCxFC4Dwcg=;
        b=I+ew5Lbq4NfYeUpQKMitveNK+nYz6G/+8qXQwetUDp6Awsq/Nb2uv/6Oox63QFD3vk
         Ic6GK25M0LbzGF2nyAgO4vVI1eW3rqQcDfj5lhc2wFkjv0nAPECxf1N0D5QAGvgKsGaM
         McIMuXzyR+O3Vj/ezSS7V6Q2K32c7sbAE1l24x5ySB6L0TB5eWpHO041mZhNJxfLj5/t
         09C6bjGCBa40ZbW29d+FvjyllE4uUUjwCO+j4WVMPYIJTIIP0UgZ5xXKbPGFVuLJ34H3
         /DMlGBEBVkDqoKTeUwCI20L1cVgxUcLGyylit++7i0Go6CwGuE/zdvbldhbPz0b342Cg
         kJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCX1xV/ogoHxY9xW5HaQaVcCRPH8JhVkqm5FhdFxw/zN1NrH2aJgZNSRWrhI2NRMo+b6+q2/xqG+92X9dIP2NNSXyPe0g1XI
X-Gm-Message-State: AOJu0Yxv0S5fv106JDp0gdqpRCZA5wGa3NFNX+Ub0q3TmSp3qjzRCNyW
	SKhIEq+D7sMDbvJfaDUCvCaKCa5cl83AnU6X1m/0ygIw/uZuvkenWiz0yUcNs0w=
X-Google-Smtp-Source: AGHT+IHDlz4isXhhoQy3pXxXewf4UkN2hExgZfZbPLaUh2ZrJEcYOgtowcRZAMbhNO/2LSamS/cA2g==
X-Received: by 2002:adf:f58a:0:b0:33e:7ae7:29fa with SMTP id f10-20020adff58a000000b0033e7ae729famr4109722wro.1.1711357365035;
        Mon, 25 Mar 2024 02:02:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b00341d2604a35sm458458wrb.98.2024.03.25.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 02:02:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3] gpio: cdev: sanitize the label before requesting the interrupt
Date: Mon, 25 Mar 2024 10:02:42 +0100
Message-Id: <20240325090242.14281-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

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
---
v2 -> v3:
- fix a memory leak in error path

v1 -> v2:
- use ':' as the delimiter instead of '-'
- return -ENOMEM if creating the label fails

 drivers/gpio/gpiolib-cdev.c | 38 +++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

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
 
-- 
2.40.1


