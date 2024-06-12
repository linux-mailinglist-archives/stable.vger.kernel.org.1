Return-Path: <stable+bounces-50212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6C904E42
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 10:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD5A1F28A6A
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F8169ACD;
	Wed, 12 Jun 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sskzFJ1s"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF216C875
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181405; cv=none; b=hlDdOEeORuibKmSLx2Y86VyI43115zzWwVdN/2yHkc0+wEIp3frZg2kDZbtVIltPrMHBXjie2poxzcu1pW3BVuU2wQ9K6IGoUuLL51xCOyHkXTXQx1FzBMDOeD7NnXGzfEx3OBsRajsPm/sChfyILJMpMn2Iq2NNtTsVRoNBnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181405; c=relaxed/simple;
	bh=t8vj4Z8K291bSOoqidlQpdF9N7ccu19T5Ou01u6zNgs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qlTFepBrCeZAXljrnKKcYAFSQSvB5R1DyHbqNCAyLbVmVkqtN3ChKDFLiEb1bF5LKOCsSVIWa21DOfWdDg9f5Rm+SOZHYnImO+kHIlS/jHzcprHWQj+TnUsD/oRPZa+Y6zKy9DD/UB9QsGiQcNw+9s7txLd0/lgQj6gylimngUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sskzFJ1s; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfe5863ca2cso892494276.0
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 01:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718181403; x=1718786203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y2uwFL7y38zzuOIY6yZzuRuyB/ucVnnJQUO1JVoJCq4=;
        b=sskzFJ1sZWSEe6Iw3TMAwHTqO4GfBf60xA73ZznmIyEaBHRWfCjMaR6DaASqSaETam
         E4bs3aEYBAPKEOmJ3r+chYmhTsJ3qjBalv4TQBn+4mfNTI9hNpsUB6wo87lkQ4Syot39
         +ldQmp8S7QsK6Ua1/liW/KPNEHXV9K9AASGRCC9PC29DRgJaXAreQxIv4znjZS51b1zO
         pdWlkg69NG80Qb4CI9gFCQSMKu4AFv6CJFwxlig0BJtGdKIrZeGKw5LAF2aicKMRjXqz
         e29cnV+3UFnUOnXHKnRY39U5y7truGnMQuTbkTxUfBcnIQxbAEE24r5xPmU1q3UK7SfY
         zTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718181403; x=1718786203;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2uwFL7y38zzuOIY6yZzuRuyB/ucVnnJQUO1JVoJCq4=;
        b=Qr2yvyK3XgdWgK6sXRpj0TezlNqkU7ufZ17IB7SB+/h2ArukCvd4XSULxDQ2qHZZke
         +IjyKzZb20bAAPdF9H9seHF9/cMurfFv77vmtAX8nZTlBbvRRhSDsJZlKI0RVOj4lKfV
         iNxX8//tVtHCkiFp/3htlylXRGDbcQxyCdlxFaMHg7/Ju34X+lVMQQv+94pWWXP3aRKX
         QYO/gS8lsDnQw8roKK+I+64ibrv6Hfgz0BkeKcqlG1HtTNcVlp007C6rpFDPNXJKqFu7
         Tz+GslqzRtLP8/HT6tcaTda7tnelIYXu9ftbUDNRNWGOKhr7Zgs8l1Q18B0nT+RpacG5
         OLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfqPtgZ1/rZRyNump39hd9dEoxYRhwejIkasLAHZzIe1KIwpUPKsT5A27meYB62ycqhzgH3rkLI3e4FvtmiBEjqM3y8OhA
X-Gm-Message-State: AOJu0YwaP/SKdNzAV1f+CxlTqsmJfmJ/ZxpA/UTD6lnqHzjRwKbdgkYX
	7bJAR/QgL8t9W5WbtuqAN4FKUBltKZPhzo53E7wjjStkn7EejDxZOOIhS4ylXi6wlZUGUF87AX+
	cW2vdXy/4wA==
X-Google-Smtp-Source: AGHT+IFIUVbh5Q1k3pO2RFjm8lrFGgxO8nKpG5vXdnLpOD1v7TpsJ/omxJ/hn/IlNpFIU9wvgTbQ8u8NRFYnbQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:2d03:b0:dfe:6bd5:21f4 with SMTP
 id 3f1490d57ef6-dfe6bd52823mr340249276.0.1718181403279; Wed, 12 Jun 2024
 01:36:43 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:36:35 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612083635.1253039-1-joychakr@google.com>
Subject: [PATCH] rtc: cmos: Fix return value of nvmem callbacks
From: Joy Chakraborty <joychakr@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joy Chakraborty <joychakr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Read/write callbacks registered with nvmem core expect 0 to be returned
on success and a negative value to be returned on failure.

cmos_nvram_read()/cmos_nvram_write() currently return the number of
bytes read or written, fix to return 0 on success and -EIO incase number
of bytes requested was not read or written.

Fixes: 8b5b7958fd1c ("rtc: cmos: use generic nvmem")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/rtc/rtc-cmos.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7d99cd2c37a0..35dca2accbb8 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -643,11 +643,10 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
 			   size_t count)
 {
 	unsigned char *buf = val;
-	int	retval;
 
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		if (off < 128)
 			*buf++ = CMOS_READ(off);
 		else if (can_bank2)
@@ -657,7 +656,7 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 static int cmos_nvram_write(void *priv, unsigned int off, void *val,
@@ -665,7 +664,6 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 {
 	struct cmos_rtc	*cmos = priv;
 	unsigned char	*buf = val;
-	int		retval;
 
 	/* NOTE:  on at least PCs and Ataris, the boot firmware uses a
 	 * checksum on part of the NVRAM data.  That's currently ignored
@@ -674,7 +672,7 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 	 */
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		/* don't trash RTC registers */
 		if (off == cmos->day_alrm
 				|| off == cmos->mon_alrm
@@ -689,7 +687,7 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 /*----------------------------------------------------------------*/
-- 
2.45.2.505.gda0bf45e8d-goog


