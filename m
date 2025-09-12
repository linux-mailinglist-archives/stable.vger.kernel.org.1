Return-Path: <stable+bounces-179339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B3EB5493E
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A6D1CC35E1
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E62E336F;
	Fri, 12 Sep 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dys+1hov"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3B2E36E9
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672057; cv=none; b=l7x/UTWIe7r3WLGrXTivEiI3DN8AQpb7oO/Bv3DM6370ryYbOPPIkWGsROyOntzbHDvNoR1+6UDIKhX9C2a72cgRHszqkyiy1QTVWILPGiggnexgaU8wWD+TDHyTI8CiV9mcnV3NJPsHI7dtvWiMrIScEXlvHQVUp05jZIZ04jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672057; c=relaxed/simple;
	bh=S0CYNS8Szt1T/6CxlU/rD4KtR5pqM3gNqPSUty5uqQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=octp8XMYpDrlCMaDto8Ekld7pBDj6U8Ajf1b6CwbnJ+wuheIJgfgygGwCDGi+I1N7kqf4XFfK5P/qmT8zXO8xTv1ZqH6dz2EODZyfrAi+Zt0DB8DuRPIIPSU2aPTzghzCmi2AzwmU6lrAXoG9k7XlDKJJTBLgDtO644UX4Sm/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dys+1hov; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb5492350so12899855e9.1
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672053; x=1758276853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ8f3Qn/TyGlr/n0NexKSayuju02h7Q6FXYl3EBTkXU=;
        b=Dys+1hov+bQkgmud6086PXk6vd2zpACrbUoIjZyvkDglQ4GW5iTKlx1HBeWGs6LA6q
         gsW3kVkMX4TdK8CaTI1hHxu27PhT5uK0j+RUfuur0QYnTFstrcbdJperY5wcCA+8PYOO
         R8tuASbdVJD6tSpfDp2TODc4NzFvO83O8sYJrTXmnvuS4eMfLuDYl3pR7Ouvy9gJEJtF
         XMShxbmwQfFmbJutcBdAeLsxMxwWOozYCkomeQ/J8YqCT6QI0tSRh/AWImdBaisSt5ao
         4v86hnfmBdvzRLZLYqqYSeH+dp3ZR29fxeehtLrdDvnJkfLqqEcG3ZqFfjFPi96jSngx
         VU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672053; x=1758276853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ8f3Qn/TyGlr/n0NexKSayuju02h7Q6FXYl3EBTkXU=;
        b=CeV3P1oxdccg0OeIXFsL7Uxq7eBDbILEeH6mf2bzVvkyOL/COqSL1eI3ciNnNUOo9j
         o3/5+Q6v8EA48r8zKQHuhmYav6ynvXYfWYoh/euy5YYnLzDtxOVmNxDjQ3BxBSxCmpnF
         clJU8tFn4KNtFgSAKtYmEhbVaizajBtzBa7aHaoHGoeq+gDbTi9x61QDpKNsoiXD3nYd
         FlKmvriyud9+cyV8FFw15j8ZwOSCfsCeHH89JOBVboEQpqxhOqRpx23uP6Q6FjLPsnpa
         sgmnoDUEGDnHvR4TRO1aLyMwRXP/7HA3ebv5mghf2ic05+jWzdUtSPH+/kt3JjYphTA0
         Ow9w==
X-Forwarded-Encrypted: i=1; AJvYcCWjq3by2ET3EffSLq+OBRyE8B0XNo61oRy7Jpa51pfFiAR+3/Y5q1ufWk31dHgwRWMTmQ3BWmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Wdh5sgQio67PP3PdKhf+ooJ2fnTBwKBsxKOGVTfuXD2ZUm8H
	g0uBpBOhpEW9UBvuJ6dxHnu8SDoD0Dme+kladNbxecfVs0K/Abfkhh7H
X-Gm-Gg: ASbGnctlufPlcR1ZZUy7uEuR7qbBn9oI+4CEn1dG+dkcaIlLi17kvPH6AVx6numNXiT
	YwMjjM6R993IM/4kxDwOZXXelY6O11PF33C9NW/GmXW/Z8I5bDDFEVXbw/xTmf4jsogEYGqQYMk
	gU5RDyzVIIdLPXhBRJ+KIH8/If3ujLPiQrw+L6RN/Yhp1qyBUDHBgIEDDCHtNJ3z48FY2jmvSr8
	VmiIuaVYt6G688yrmgTp1c/9gywby2JJjYSza8CJoj7Qtbf3xOfUGAeLYAl2T42VkiZgTArl9L9
	O4zoA6MOlLyRH5NmpYKyBPmQD3ItUKMKrsuwVUvpXJFNVFon7B4P7AhOmwYg6SHuJI+pYMqz6Ep
	gQ7GIVxUM0zSYbp+llVNgifV1r4pZ/eXkNA==
X-Google-Smtp-Source: AGHT+IFYtoJgSByXetv839cGOJvOKyTq/Qw00RovSeH57gD7S6jTJAoFmT89063appVm2NhMPpwCJg==
X-Received: by 2002:a05:600c:45c4:b0:45b:9912:9f30 with SMTP id 5b1f17b1804b1-45f211ca9a5mr25520265e9.6.1757672053190;
        Fri, 12 Sep 2025 03:14:13 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372b983sm56542395e9.9.2025.09.12.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:14:12 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: gshahrouzi@gmail.com,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] staging: axis-fifo: fix TX handling on copy_from_user() failure
Date: Fri, 12 Sep 2025 13:13:21 +0300
Message-ID: <20250912101322.1282507-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If copy_from_user() fails, write() currently returns -EFAULT, but any
partially written data leaves the TX FIFO in an inconsistent state.
Subsequent write() calls then fail with "transmit length mismatch"
errors.

Once partial data is written to the hardware FIFO, it cannot be removed
without a TX reset. Commit c6e8d85fafa7 ("staging: axis-fifo: Remove
hardware resets for user errors") removed a full FIFO reset for this case,
which fixed a potential RX data loss, but introduced this TX issue.

Fix this by introducing a bounce buffer: copy the full packet from
userspace first, and write to the hardware FIFO only if the copy
was successful.

Fixes: c6e8d85fafa7 ("staging: axis-fifo: Remove hardware resets for user errors")
Cc: stable@vger.kernel.org
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 36 ++++++++-------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index f54614ba1aa8..c47c6a022402 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -43,7 +43,6 @@
 #define DRIVER_NAME "axis_fifo"
 
 #define READ_BUF_SIZE 128U /* read buffer length in words */
-#define WRITE_BUF_SIZE 128U /* write buffer length in words */
 
 #define AXIS_FIFO_DEBUG_REG_NAME_MAX_LEN	4
 
@@ -305,11 +304,8 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 {
 	struct axis_fifo *fifo = (struct axis_fifo *)f->private_data;
 	unsigned int words_to_write;
-	unsigned int copied;
-	unsigned int copy;
-	unsigned int i;
+	u32 *txbuf;
 	int ret;
-	u32 tmp_buf[WRITE_BUF_SIZE];
 
 	if (len % sizeof(u32)) {
 		dev_err(fifo->dt_device,
@@ -374,32 +370,20 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		}
 	}
 
-	/* write data from an intermediate buffer into the fifo IP, refilling
-	 * the buffer with userspace data as needed
-	 */
-	copied = 0;
-	while (words_to_write > 0) {
-		copy = min(words_to_write, WRITE_BUF_SIZE);
-
-		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
-				   copy * sizeof(u32))) {
-			ret = -EFAULT;
-			goto end_unlock;
-		}
-
-		for (i = 0; i < copy; i++)
-			iowrite32(tmp_buf[i], fifo->base_addr +
-				  XLLF_TDFD_OFFSET);
-
-		copied += copy;
-		words_to_write -= copy;
+	txbuf = vmemdup_user(buf, len);
+	if (IS_ERR(txbuf)) {
+		ret = PTR_ERR(txbuf);
+		goto end_unlock;
 	}
 
-	ret = copied * sizeof(u32);
+	for (int i = 0; i < words_to_write; ++i)
+		iowrite32(txbuf[i], fifo->base_addr + XLLF_TDFD_OFFSET);
 
 	/* write packet size to fifo */
-	iowrite32(ret, fifo->base_addr + XLLF_TLR_OFFSET);
+	iowrite32(len, fifo->base_addr + XLLF_TLR_OFFSET);
 
+	ret = len;
+	kvfree(txbuf);
 end_unlock:
 	mutex_unlock(&fifo->write_lock);
 
-- 
2.50.0


