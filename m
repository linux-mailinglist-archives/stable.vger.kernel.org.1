Return-Path: <stable+bounces-35906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59B898435
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 11:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F172828CC
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9C76025;
	Thu,  4 Apr 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1jUiGQsi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943327F7F2
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223219; cv=none; b=IFUP5HMvBkF651h6Hf/sNfi9ZJJSIHfR1FuemEmihkh6+1WXz4RIV2BLLNpumPmKbnH+FiyyWs0D7QtjCc2Q7gbUMymQz3N/wzqelRbvccjiGW92m9IqFnarpu6YabjoybZDixQilcJ6bkywrZRZN/P7vThMzV220+s4aEWrSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223219; c=relaxed/simple;
	bh=4JZgCjJUm3vYm3YzQEvW4qxgetUWkPZYeaBKSxKI9SM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCbjqrg6CJAjf+aAnYR5nhC0g08MFPFyaOjRyjpx9nm2q+nWIGw5KIjo9sYQ3Hzr+m/uy8krye566qurc/72BJBE/I55Jpxp2OovbE85W4Iz/xtNOuCkhzV1VYerKDuDrUt57DUPjMVsxv6lGTIu9cH1h7ixGrzTSxlMBj//SEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1jUiGQsi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343620589easo337994f8f.3
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712223216; x=1712828016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCosdLqhfQl3fw66HOWtcsInpfXJnB5cNYDVDMw2WSI=;
        b=1jUiGQsi+WWK+1+qAiUAoUpvA1zYUELalUXm33hqzTGxHHB1vtemRxaPWq0Vbtb+T2
         Oixd2UB70tbG9KoM+yXI5yr8p/UdswUnq1nH+BpzwSR2WnImV5my+woLLfEijx1MZtk+
         rc4EZgOtyIMsybjCHpO4BFP22Ath8ARdkQqe1JGRlGna8ztlHxmbtT5wNT5KkNtmUENQ
         J9xQeS1u9Be3y2SX02NokVwD+3m+K+A18uUMrTDP+QvI1pfg3Qf75VEVnFoVt1+ch2HS
         QEl2paJCG339pbpwJKDX0jBNt4eUWGmhV14TYiTMAe226xhpuxRfH0HZicb22pqEojA6
         tQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223216; x=1712828016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCosdLqhfQl3fw66HOWtcsInpfXJnB5cNYDVDMw2WSI=;
        b=NPQ3PMxSD20xt18eBeHAXAw99U6fENHIh9/PAonKDFje57Imf4LlbdZotm4RRR4TUL
         YZMUMiy92SWqoAfhE8aqVPN5jDdchE1lCRrCE+wF5iaLy3qtL+W7l6Kv6P7Dg/e8g1Ri
         lPHa/QOo4hBVki8ilufKsUcqIoPJdFGR8DXF3A6jL/7krW0TXto/SP7gNMwCn0s+RJQE
         P2QA4s3l8zuH4DUPNYLiITBFa4ImwX91UhWSke6WIHP1ZBTvoa216oIDOp0lON6eKN/c
         h2brVvuCVninv4YVaIX202TkwEHxrZb7WN64gMLf1smxuduinuPs2wEK0hMXv5IqJHiW
         Bdqw==
X-Forwarded-Encrypted: i=1; AJvYcCVTBbXdUvyFulH68IwNBenuBMf9g03kk8JgUK9cOq0LIqZicea8XZYdc0h2l+YORcs8+g9kbBsIPIUKO2b8mPVQdxeGWtvg
X-Gm-Message-State: AOJu0Yz4epz2E8JI3nyoS7K/0zvoaorosk6yIowRumkrdJ6xNvbq5Fvm
	9Q07v2fGD8VFFg+RzcbEb2PXHFtdKwRqVW2ODA4S1vVSv+GubXQBa6mBKmX1dEU=
X-Google-Smtp-Source: AGHT+IG/TIAUQlpBfX246W5n8aJB90Wlo9DLZd33LwoDVmI9J0u0/E/wz4hT0vsMAcQf6ic4xbbomA==
X-Received: by 2002:a5d:5242:0:b0:343:aeab:2cd9 with SMTP id k2-20020a5d5242000000b00343aeab2cd9mr1250422wrc.11.1712223215865;
        Thu, 04 Apr 2024 02:33:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:220a:565e:2927:8cf0])
        by smtp.gmail.com with ESMTPSA id dj13-20020a0560000b0d00b0033e9fca1e49sm19436385wrb.60.2024.04.04.02.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:33:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v2 1/2] gpio: cdev: check for NULL labels when sanitizing them for irqs
Date: Thu,  4 Apr 2024 11:33:27 +0200
Message-Id: <20240404093328.21604-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404093328.21604-1-brgl@bgdev.pl>
References: <20240404093328.21604-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We need to take into account that a line's consumer label may be NULL
and not try to kstrdup() it in that case but rather pass the NULL
pointer up the stack to the interrupt request function.

To that end: let make_irq_label() return NULL as a valid return value
and use ERR_PTR() instead to signal an allocation failure to callers.

Cc: stable@vger.kernel.org
Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting the interrupt")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/lkml/20240402093534.212283-1-naresh.kamboju@linaro.org/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index fa9635610251..1426cc1c4a28 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1085,7 +1085,16 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static inline char *make_irq_label(const char *orig)
 {
-	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
+	char *new;
+
+	if (!orig)
+		return NULL;
+
+	new = kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	return new;
 }
 
 static inline void free_irq_label(const char *label)
@@ -1158,8 +1167,8 @@ static int edge_detector_setup(struct line *line,
 	irqflags |= IRQF_ONESHOT;
 
 	label = make_irq_label(line->req->label);
-	if (!label)
-		return -ENOMEM;
+	if (IS_ERR(label))
+		return PTR_ERR(label);
 
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
@@ -2217,8 +2226,8 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 		goto out_free_le;
 
 	label = make_irq_label(le->label);
-	if (!label) {
-		ret = -ENOMEM;
+	if (IS_ERR(label)) {
+		ret = PTR_ERR(label);
 		goto out_free_le;
 	}
 
-- 
2.40.1


