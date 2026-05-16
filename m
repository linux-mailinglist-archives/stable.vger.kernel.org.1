Return-Path: <stable+bounces-249052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIbDL5j7CGpgDgQAu9opvQ
	(envelope-from <stable+bounces-249052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:19:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C555E3FC
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA30130293C4
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E33A4513;
	Sat, 16 May 2026 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="TKiimgkS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B139DBFF
	for <stable@vger.kernel.org>; Sat, 16 May 2026 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778973540; cv=none; b=Nede/2cI9Al0iQUq8SyM/dKgX9r6Es+wiRdmMh1/1pXMJNX7NwrqSXMZVCCMPlcGL+P2cqYYAsQ9wjnS2KXvzGjW2hQF+S2dAvSqK3C+LKDnfYzAPZe+bz8GhJ5os/dWDd2y2ZTzDBqpzFXyhOP/TDUTwZdzzdh+8HO9V3vmrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778973540; c=relaxed/simple;
	bh=N23J27IfJVGe7SPQQt1S3jRHCJD8YogYhTzhMnkG0uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYFharCr8rpUU8zuFnnUEzYQatmCuiXnQ41+NJWBhzW3/K8XNQJdmw6QAswkPkpUSuvYdIl6WXU/TNT4csXjojf+sPC5fqw9xMGgT0aly3+PQ4Qi9sEIRr8fM8bFW+mtS6OF25WXvkewTErABvqYFRfcZBtGF/zjm83ro1yFakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=TKiimgkS; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-132c338a537so1397084c88.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778973538; x=1779578338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dA2Xn0JnUjF9oxy4I1Ocf3rxy01MmF3T7GcfHEypX4c=;
        b=TKiimgkSAL9g5bijz9kfouf72dVsWGjjga+8jKXZTK7hJuSTq7h8j7fLR65+G3qvhv
         QVwCvVMVE4RYBXDYnaNOGiLOCwU/orzmrnwXgcZqpYBjMF6V95ESjEZJKsufgFv5IHTH
         bWfEjMU/nYdwDcju3NYgugt6yRkjdum6KVnBhlFGygXxtHPa8x6eQBvmchL1Dn5g/xE2
         b5L677/E9r3MAc6IGCnsAFhf7s+iMft/MTxr57/BRQ2XirBJj5kQjQ0DQ52COHRvB6Zc
         f1kRTNOseNX5G9jLXsaqQultJqYh8o1Jjz1aXqRpgSvbtp/yrtki8Db6JsRAs2deqBvi
         UZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778973538; x=1779578338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dA2Xn0JnUjF9oxy4I1Ocf3rxy01MmF3T7GcfHEypX4c=;
        b=lVg822vhA3rXNGL8roIJ72Fd515D9nLcp2zHTVJ7GaWfQ2uy5ylCOwKnSqdUCW1+3d
         Vjc79iJRQ8df0ogKLkemvs++IFeuOxAQW8N4hLI+/4IiaWoI+vdBlFOBeAOCnU1qmRWk
         Q7swXhRoAH1L+RsBPqWwcORrUNJEivRU5J01cf6/H2QPaoI5nWXgLdAm7Z2wBs4xn55k
         db64DqjcS9pohPuBfitdYCwu4Ri7oKk8byrIyvq/J1zz7Rnq1jExFecL6AKjTFVlzV2f
         +QoPpc+0Iua8iR0AIUx85D5362A/VJuWjZjZJ5EbZF4FontG0MlNVa8CfpsLxj/qdu6b
         Gdqw==
X-Forwarded-Encrypted: i=1; AFNElJ9Y3tKp+wEd9sj0Ie4YME8aJtTWBIsAMnQFEMeqlar43mAlBvBLf9W6j9WkZulKG1QsviyN7Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ScRDAml/gHvwbIqZ38MbU8tNEXd5DtF7xNIOCukvRRLdrsO9
	9nC0fSIsBSFw4S/FSDlH3JdcxiQtjaz6aafuG6qeC6nkywbX58RLBFcMjVnSqvR2RD8=
X-Gm-Gg: Acq92OEATpC1kmNmkZQupFnjoY7isODhzD9kaK/9SFdE6BbAMUHESkn+OvnSKD9pjuj
	KQPyWeDDaA/d9WrGdxjjy7l3w3CLgAf1mRR9FOYQFD+hJDPMO4NfUXnb65gMSWOEiCO7mbhAjpj
	lSjrK1K1t1Xq7N2S8UTopPSJHKhUJngSNxwmOKuMiJtu7r869hAo7+5rR1MqUnDCm7T6k12590I
	sGb9ubUjChiVYJsS9dWHmBA5Kz7FnnIJaoS3FzNITXFreugQW7X9Sd0Bs5x39WdHTwHIAZHoSNP
	H2SQsiXjnd6kXMbYpdM8oJjJkzd6hxBQMWyt+S5+kbqnJKq580hM7CrsYA7I+K+MVAiFXRnJmyq
	WuXFXUxANqn4b+WyC5GVHUN6TknPrguOOInTEN0QiKb26yTOYOXX/bHVOkV2UBoP/MXeb7MPvu4
	d013C36X+01XPVoswYv1tdiKZOcXRPQvrej1KW
X-Received: by 2002:a05:7022:f96:b0:12c:9037:5115 with SMTP id a92af1059eb24-134ffe9529bmr3676098c88.13.1778973537611;
        Sat, 16 May 2026 16:18:57 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm14722254c88.2.2026.05.16.16.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 16:18:57 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Sat, 16 May 2026 16:18:49 -0700
Subject: [PATCH v2 3/5] hwmon: (pmbus/adm1266) reject short block-read
 responses in the GPIO accessors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-adm1266-gpio-fixes-v2-3-801f13debcb2@nexthop.ai>
References: <20260516-adm1266-gpio-fixes-v2-0-801f13debcb2@nexthop.ai>
In-Reply-To: <20260516-adm1266-gpio-fixes-v2-0-801f13debcb2@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778973534; l=2321;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=N23J27IfJVGe7SPQQt1S3jRHCJD8YogYhTzhMnkG0uE=;
 b=XrOwSRfWwG+q0SuALxjvhTMWsm+OP1kNQlIn0Z46oqN7219YpmYw7z+gUT4oTOENMEBlSyuQv
 Syirv9rW4wWBz9/Z9npoptY/vyCDDNp1+tsx75VEVuEyHPX4hV0gOhx
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 499C555E3FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249052-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim]
X-Rspamd-Action: no action

adm1266_gpio_get() and adm1266_gpio_get_multiple() both compose the
pin-status word as

	pins_status = read_buf[0] + (read_buf[1] << 8);

right after i2c_smbus_read_block_data(), guarding only against an
error return.  A well-behaved device returns 2 bytes for
GPIO_STATUS/PDIO_STATUS, but the helper happily reports a 0- or
1-byte response too.  If the device returns 0 bytes, both read_buf
slots are uninitialized stack memory; if it returns 1 byte, read_buf[1]
is.

The composed value then flows through set_bit() into the caller's
*bits in adm1266_gpio_get_multiple(), or into the return value of
adm1266_gpio_get(), and ends up in userspace via gpiolib (sysfs and
the char-dev ioctls).  That leaks a few bits of kernel stack per
request on any device whose firmware glitch, bus error, or hostile
slave produces a short block-read response.

Add the missing length check to both call sites and surface a short
response as -EIO.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 4dd67c02b412..57cb7d302cdd 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -175,6 +175,8 @@ static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	pins_status = read_buf[0] + (read_buf[1] << 8);
 	if (offset < ADM1266_GPIO_NR)
@@ -195,6 +197,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	status = read_buf[0] + (read_buf[1] << 8);
 
@@ -207,6 +211,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
+	if (ret < 2)
+		return -EIO;
 
 	status = read_buf[0] + (read_buf[1] << 8);
 

-- 
2.53.0


