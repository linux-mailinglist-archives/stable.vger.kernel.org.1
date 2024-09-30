Return-Path: <stable+bounces-78240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD9F989F2F
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F421F23248
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD7189520;
	Mon, 30 Sep 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PucRrjIH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB826AEC;
	Mon, 30 Sep 2024 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691258; cv=none; b=jjyZQQwaVHLolYxyO+wfD+pr6o4z31F5diaRIcvRCJGCGjDCmvA4i77w7FcDctSbGjQ3EFP46xjmAFUBxiM3oiMh23R2D1G0y7mI5v3zKzSApDAkh33s4GCGHxIfnrrVtT8EJuDsgGKsKdRVQ5rz6ER+lgVFo0sxt0Ce85aXYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691258; c=relaxed/simple;
	bh=dWeU6pnFmFv117vXa519B54aTfsRh0l6v0ZkfL5Lwtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L1h4peXwvpx8abLlMTb/jDaUDrFs45pgK3lul32U+S3OnN/jOsfv8aMMVSYjuLeu3DHW5v9gQbTwWNuzDBEgOpwLjhedqcaItMEYXlyXv2dFjupR0v2BY2jiNp4ZALydphw+fKWVo1/legF6SG2qmJSxT8ZKAVsp4GJsGyOT6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PucRrjIH; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71970655611so3919527b3a.0;
        Mon, 30 Sep 2024 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727691256; x=1728296056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeqWJOPzZaRbF9gG0yA3SFCc22f9/UbzzT3ylYy44K0=;
        b=PucRrjIH8rWNAqo10cs6zb0OuTUunqC3yajn62fE3IylO0nQpcr8YXCmkjbO+afZX8
         lX2cyRan9JGJ2PtzOOjV7dWHHhOhv9Lz1nFytoF6ySWAM6V2GQnpd0Gf68nWjivmxhiR
         yEYo1HRl1QUshHyV25mBVgvkXGIdlN7fp2/TFzvN9ST4WFe3/kHHl5jvVVbgICfg1mja
         6n3w3pnkZa+CUapkAyEha+VhJ2FnfLNHYyJ1mKgiXXlqJvKVIPwCvjz25xy3vYNXy6Lv
         xVYGw5S0AS1RVTaGgzJRz3VOM4MWZPXg7HHVVa+dwXIUg5Qud9KXQcRQ0zoSqVXQJrML
         O4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691256; x=1728296056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeqWJOPzZaRbF9gG0yA3SFCc22f9/UbzzT3ylYy44K0=;
        b=dafTjHwwGB2d4HB1OHYkvpPqUZ2kFxh9bIhS0jGNB+lUlKJaUAqN80ERZBo7PtHTjX
         cs8vICBaHvDIrZ4++yOOPqFrL7AClsM2i5cg5JbMF00JlO5f0dHR6iIuHNnK0ENKm/57
         f7QlVIzQSjjolPLSQo+cNelAFuxZ5yShewXQtzxWhZOTXOklNdE6At1+DS7ZS9fsT5fH
         57GIWrAYzXSewCZ5CdFoM/HVGosCw84BSme6j/lSGYyioJ/SWFh6KiFq3rflbaIlRrAv
         KQw9g94PECvu6Yxcm0j3yAMx7qYVrgSHWIYC3ujTg6YUprvXOcXtv8ZIF9n85lKVhhFB
         ETOg==
X-Forwarded-Encrypted: i=1; AJvYcCWwFTiJDrDve08+Sg0q0BDphrTHs4yK3cgO7QMb2eNZmavec0UN7cAlStFDqpthpc63NRYWydheOq91i1o=@vger.kernel.org, AJvYcCXJVzmQxtr1tJ5OJWLbnTcLHPgVqC/L5QvTP8tDS4UH9Dpf4lj+fy7scBpSzr1kALo3Tn6cPmaC@vger.kernel.org
X-Gm-Message-State: AOJu0YweIZSbtGKM3A0vuO5M/QdrJCqREDk5Qbj1mBcKfOPmFbCp3RdX
	JONKlLDaeOZspLhWa/wIMPSIRL1AFtY+nQcBZV4OAp55J5a8RYHR
X-Google-Smtp-Source: AGHT+IGKdx6IwYAgMFCo2EOm2aLHGc/L3S3ogRZ0t2c/hlLVQF5CXlJlAybcrG4oW/fHQrb/dtI+YA==
X-Received: by 2002:a05:6a00:1813:b0:718:d9fb:63e1 with SMTP id d2e1a72fcca58-71b25f3999cmr21202444b3a.10.1727691255909;
        Mon, 30 Sep 2024 03:14:15 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536fd0sm5872043b3a.206.2024.09.30.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:14:15 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: dtwlin@gmail.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: Fix atomicity violation in get_serial_info()
Date: Mon, 30 Sep 2024 18:14:03 +0800
Message-Id: <20240930101403.24131-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomicity violation occurs during consecutive reads of the members of 
gb_tty. Consider a scenario where, because the consecutive reads of gb_tty
members are not protected by a lock, the value of gb_tty may still be 
changing during the read process. 

gb_tty->port.close_delay and gb_tty->port.closing_wait are updated
together, such as in the set_serial_info() function. If during the
read process, gb_tty->port.close_delay and gb_tty->port.closing_wait
are still being updated, it is possible that gb_tty->port.close_delay
is updated while gb_tty->port.closing_wait is not. In this case,
the code first reads gb_tty->port.close_delay and then
gb_tty->port.closing_wait. A new gb_tty->port.close_delay and an
old gb_tty->port.closing_wait could be read. Such values, whether
before or after the update, should not coexist as they represent an
intermediate state.

This could result in a mismatch of the values read for gb_tty->minor, 
gb_tty->port.close_delay, and gb_tty->port.closing_wait, which in turn 
could cause ss->close_delay and ss->closing_wait to be mismatched.

To address this issue, we have enclosed all sequential read operations of 
the gb_tty variable within a lock. This ensures that the value of gb_tty 
remains unchanged throughout the process, guaranteeing its validity.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: b71e571adaa5 ("staging: greybus: uart: fix TIOCSSERIAL jiffies conversions")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/staging/greybus/uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index cdf4ebb93b10..8cc18590d97b 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -595,12 +595,14 @@ static int get_serial_info(struct tty_struct *tty,
 {
 	struct gb_tty *gb_tty = tty->driver_data;
 
+	mutex_lock(&gb_tty->port.mutex);
 	ss->line = gb_tty->minor;
 	ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
 	ss->closing_wait =
 		gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 		ASYNC_CLOSING_WAIT_NONE :
 		jiffies_to_msecs(gb_tty->port.closing_wait) / 10;
+	mutex_unlock(&gb_tty->port.mutex);
 
 	return 0;
 }
-- 
2.34.1


