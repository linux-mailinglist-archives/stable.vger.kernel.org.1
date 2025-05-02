Return-Path: <stable+bounces-139453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDEAAA6B5C
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 09:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658721BA6F76
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 07:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26D926772A;
	Fri,  2 May 2025 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSpky7ah"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6602221FB8;
	Fri,  2 May 2025 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169795; cv=none; b=Fit9ZUeo7sN27qAHfvLx6Dcce/NKLe5BNJZvCiTmqOfKVBZ/N8nLa4+KJDnBIvB6FbktZ26aWtyga7hzh7VB2e6HqXc9u5CUTFMw+CxB+4RC3oWlOTv5s/p8CtcRAh6LC8e7hVHWmHzY6xZNFKyN0J9TnBe7UuoKkcpcH/csTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169795; c=relaxed/simple;
	bh=FNP3f8vTF+eq4+o2gW9MFt1Ri5yXjJT6HdncG9sVSy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2zEWCkUKOslVg7GcToIZB1EbxPEErB4nKP41E7FlfedZEtu2yUIGU4CG63OEvxfUMpWnIf102QSizjtsVw5fr9bFu5ejXx+lr6fX5h5JqciD3h2W6Saj+3dz/AdBI2N7xmDEFU6KH2GpgRfAVdE7kqLv71dM8KFzm8WLhGHJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSpky7ah; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so2265644a12.3;
        Fri, 02 May 2025 00:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746169791; x=1746774591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d10r9kauN9gqIusKigQu41oSQY9xgEgrDUOGrp8WcZM=;
        b=bSpky7ahc2lFqoTK2IS0ur9Km9MpGJoeSG4LMQYZeeDqcDFpEx6O2P2pElJGg+Ct+U
         WCmSuvolBII6YfMw/O0knGOwzXzDCxI9JUaD5dWdz+fA3Mj5/unlEYRQQ/ZbZeQuAa/V
         3uGjTbtyGIts6ntpohAfgIBQPBLSVb2Qnrt0ph9VKHy4XTOu9+jD83TvThoZ7slaHSPf
         ZQI6xrCtuLVQutFYeTDLyuaBGIo0YQYVj0S0oN0JN+HcehsMfA/YFdwSzTEJvdfoOWtN
         R2/Ibg76kzANlfTPVy6ZxVfP5W/KbXDTPhpAsMmdoOGYQi1DrRfFWPwYrsm28xDN8X7S
         EwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746169791; x=1746774591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d10r9kauN9gqIusKigQu41oSQY9xgEgrDUOGrp8WcZM=;
        b=t4cFrrH2rn04b1XTnlyUcQ2SHbJsqpgbZxz+V4PZE/LrETlwJ+eFeb4V1hHFEVRSde
         XJg6e697M8a//BgINajIRwmm3yxAZHt1XLYCb1oZjCobYP8PrTFbS8TtOQ0HkziqKN5Z
         kD5QQrOfNBjHOLfcQaG8edyvQzbcCY69OcW0rlTgCP0zcJ75ypTM8NIuJnhAPsZWhXbL
         tHxLkCAMTtN95/vhwn+b9u9i+tmlXKRyBnZJwFAoNVmzLB5wmXudphGYEVMJRm1QYrT8
         Hh8AU1iMIMrg2+/0nS+0lR7GBBs+yGHA1RiUmBg8VLa+leSj2GVdZDyuCZmdr9o3MUTA
         qt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2/41lAy7NfS3fdfThkJi6UdQuWoPQVg1ETfGDNNIeBJ1KXadEgaJpoX98q3jDmi544SPU9KfK@vger.kernel.org, AJvYcCU2wZofVIekSJqK1KRBfmjP5mh1NxaNO76q8PMkgiytWRugW4COx/uWybcUY2XhkzDaRMTR0BpJ/1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNLdn+mgo2gldnkQlmO4CX5JB6iJTdjqbp5vQIg1FAEcivjou
	zOeo5ouX8ei1am2gE4FQDVhM51zH89Bqc6scEqtYlA7I/ZMjcx27
X-Gm-Gg: ASbGncuUMjgvMx7vcSTJ4vqXAfO3E5P2u+GVoCdplR+F/AfuD5wd76ueRRkU2RU0M7z
	ilCdZ57rpgcYz9WDSLyWFmsguq7F9FeOrMjGLbT1kCLIZ9i1fdcGyWFGkWdVWKJrVrJoitydO/r
	dpO/A2luANm3dQwcJl8tL7la3LAcc4Yj/KiOVl7+tvBkmJyKnnfx9LL9Gh21X0pylgQYxsjGJMl
	D1Cog/Y/StFnz2Gfyk02FHR+oC5TXGpJ1Owtv4hqyFJpFn5RQUNahzwo93P47FKTDl3PLP1DvxN
	bh4AIYr1w/9Tlv3kalAGOnbmFVAL/nC3HkIEo681N9woFOwlyONwnJVBhFxmmA==
X-Google-Smtp-Source: AGHT+IEG5Oc4OzRT/asqmi8pWTft3MdCGbkEVBzoRc9nvk+wHU/VK8Fq+93Anl6/WhrA0Otg9lGZ5w==
X-Received: by 2002:a05:6402:3506:b0:5f8:eaa7:793e with SMTP id 4fb4d7f45d1cf-5fa788e4634mr1404597a12.25.1746169791104;
        Fri, 02 May 2025 00:09:51 -0700 (PDT)
Received: from localhost.localdomain ([178.25.124.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77bf3ec0sm753513a12.79.2025.05.02.00.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:09:49 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 2/3 V3] usb: usbtmc: Fix erroneous wait_srq ioctl return
Date: Fri,  2 May 2025 09:09:40 +0200
Message-ID: <20250502070941.31819-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502070941.31819-1-dpenkler@gmail.com>
References: <20250502070941.31819-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_event_interruptible_timeout returns a long
The return was being assigned to an int causing an integer overflow when
the remaining jiffies > INT_MAX resulting in random error returns.

Use a long return value,  converting to the int ioctl return only on
error.

Fixes: 739240a9f6ac ("usb: usbtmc: Add ioctl USBTMC488_IOCTL_WAIT_SRQ")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
Change V1 -> V2
  Add cc to stable line

 drivers/usb/class/usbtmc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index e24277fef54a..b3ca89b0dab7 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -606,9 +606,9 @@ static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
 {
 	struct usbtmc_device_data *data = file_data->data;
 	struct device *dev = &data->intf->dev;
-	int rv;
 	u32 timeout;
 	unsigned long expire;
+	long wait_rv;
 
 	if (!data->iin_ep_present) {
 		dev_dbg(dev, "no interrupt endpoint present\n");
@@ -622,25 +622,24 @@ static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
 
 	mutex_unlock(&data->io_mutex);
 
-	rv = wait_event_interruptible_timeout(
-			data->waitq,
-			atomic_read(&file_data->srq_asserted) != 0 ||
-			atomic_read(&file_data->closing),
-			expire);
+	wait_rv = wait_event_interruptible_timeout(
+		data->waitq,
+		atomic_read(&file_data->srq_asserted) != 0 ||
+		atomic_read(&file_data->closing),
+		expire);
 
 	mutex_lock(&data->io_mutex);
 
 	/* Note! disconnect or close could be called in the meantime */
 	if (atomic_read(&file_data->closing) || data->zombie)
-		rv = -ENODEV;
+		return -ENODEV;
 
-	if (rv < 0) {
-		/* dev can be invalid now! */
-		pr_debug("%s - wait interrupted %d\n", __func__, rv);
-		return rv;
+	if (wait_rv < 0) {
+		dev_dbg(dev, "%s - wait interrupted %ld\n", __func__, wait_rv);
+		return wait_rv;
 	}
 
-	if (rv == 0) {
+	if (wait_rv == 0) {
 		dev_dbg(dev, "%s - wait timed out\n", __func__);
 		return -ETIMEDOUT;
 	}
-- 
2.49.0


