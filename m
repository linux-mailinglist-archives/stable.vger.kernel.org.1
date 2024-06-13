Return-Path: <stable+bounces-51158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07F3906E95
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20ECEB259C0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3414386B;
	Thu, 13 Jun 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5KZGu0e"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CE145A1A
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280478; cv=none; b=o1yYTo4aGeBSnBGctPyTumcyz0+3NfkEnpfiP7zjfFb5ZRnUvtrdsHCJKe0qwOtgUUqgxoeol/DQ+JypCx9UHV+zv9MyNCMZnxHucc7wMKUsa+o4y4GEn7EM3clvNnM5Y0++gtG62oKvROMUxDQu+kUtsnLdkeORYNpAQafzeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280478; c=relaxed/simple;
	bh=ApfIUmMvEtf39ojiOQllZCMOwnzalBblmip9w0Xdo7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VVZ/9bUkLG91zorXGfYzaZakURcfJHE3vIfKjg03SpTFiIzZ3Q+d5yOT+LgR2C9ZL2PdDWjqYanx458MqHrtCwcBSajFVfNonmce70/QUBgnp7Y0jfHw2PXYnFgtLFuID9fq3OfcpMd2jugjdR1VFVBF/ezw7HiXzkmy5JflyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5KZGu0e; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso1367803276.0
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718280476; x=1718885276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGodyiYjLAsD0yJbNMBI7MVLGuadjuXw3TChSJWxUzw=;
        b=Y5KZGu0eWU7udil0ghLJo1dz+yZJZd3vOg/d4XuoALJpL8oih1QPKMH2E0hqh34cPl
         zX2kggXpIOTjfibED34a7YAe5DETTBoU7YWyaVKXmUdloQc8t8EJ7sAs/A+FMey1a0eK
         O/50qErDCVAcUjAeOYUcyMmxlewXrHhJ/Tr8Zw6NRlXCrV+cXA5Yu5L1J2xf23e5D2V6
         AfdAAWnccsCjGD+jslmcgvHw0dVvJ5TawZoIPA2dskdB44ljcDb2TgytmRLAGoywhQ78
         9c0gnNgUYuUICaJkLRIbebXBd9vbu9AWAEUyCpTrgzzEWMbcU6oFWqDCd4lK88A7dbEG
         TD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280476; x=1718885276;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGodyiYjLAsD0yJbNMBI7MVLGuadjuXw3TChSJWxUzw=;
        b=Pt1lZiSQItlkNQwT0yagIVmdwD59aCS3wvjm6lnH9GWan12HnC/jRM/zPeDzlrCSWl
         G8mY3Z0tqZXGLcRfihBQKsf1C7A9oU/dk3lYKFnuLekpX6DLNkHL00IHslZLqPfZ2Ubb
         RjSig6WT7rjQ1YUPTKVIJ8nLxG8e0w6iu4fBLugSBvu1d6DH9RaDEQamlAv9yyF1dYqY
         gUELZHqFeXRMkRHO1qgAmc4f/S8BhPCVirp5ZtrkT6L4WeT6wV5sLWfcEOIW0SAFKz9S
         Hx0Gt1bRXeVdiNzlMtmmuvHZbhTwqxprwl/xeqAP87/5QJDtC1eh8SbyT/3TLZM9cU9z
         FrDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcFED6V9ByI5GljpcA5j90NvIM5UcEDKqf62Tzg3hU/BcvRgFWoF7bJn5eVXzMcDbWgfC0ovkxRfQgDs7OVMFf2tQnQkHp
X-Gm-Message-State: AOJu0YwMVdw9pElsiEiwVVZoxX5bldDlCR2z4wRXlKNaY+mYq1oLG5Xj
	5C/zzlE2igOMMY0L+8p6OQruygXOVjVb1b8GSm4p1IUEu9ke2llFgxhm2SKNqkqnxCxkzGobk/V
	b1fs6+nDRWg==
X-Google-Smtp-Source: AGHT+IHXow2FDhm75pimKLZX48hWrRy1U08wctHSj/K1NF6TSMVXN+j/Fjh1IvFkAupdAwJLYkrs5thABS5WRA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:1001:b0:dfa:dec3:7480 with SMTP
 id 3f1490d57ef6-dfe69005926mr357042276.12.1718280476322; Thu, 13 Jun 2024
 05:07:56 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:07:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613120750.1455209-1-joychakr@google.com>
Subject: [PATCH v2] rtc: abx80x: Fix return value of nvmem callback on read
From: Joy Chakraborty <joychakr@google.com>
To: Sean Anderson <sean.anderson@seco.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joy Chakraborty <joychakr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Read callbacks registered with nvmem core expect 0 to be returned on
success and a negative value to be returned on failure.

abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
returns the number of bytes read on success as per its api description,
this return value is handled as an error and returned to nvmem even on
success.

Fix to handle all possible values that would be returned by
i2c_smbus_read_i2c_block_data().

Fixes: e90ff8ede777 ("rtc: abx80x: Add nvmem support")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/rtc/rtc-abx80x.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index fde2b8054c2e..1298962402ff 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -705,14 +705,18 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
 		if (ret)
 			return ret;
 
-		if (write)
+		if (write) {
 			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
 							     len, val);
-		else
+			if (ret)
+				return ret;
+		} else {
 			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
 							    len, val);
-		if (ret)
-			return ret;
+			if (ret <= 0)
+				return ret ? ret : -EIO;
+			len = ret;
+		}
 
 		offset += len;
 		val += len;
-- 
2.45.2.505.gda0bf45e8d-goog


