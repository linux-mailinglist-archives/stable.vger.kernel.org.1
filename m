Return-Path: <stable+bounces-249421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GIFAIO0C2q2LAUAu9opvQ
	(envelope-from <stable+bounces-249421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:53:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E80575CBA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5764D3047BD9
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68D2BE7BA;
	Tue, 19 May 2026 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="VWxg1iaI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AED22B8AB
	for <stable@vger.kernel.org>; Tue, 19 May 2026 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151955; cv=none; b=QK2K4uW+k+9R5sTSV/l0O2PPk1ifam81PoS35Hil1cUTE4ETrP6wfWP37FRgkdxVjit7LfEv6p8LdIVd/LEwHppqAp5SmnYJBsz1WoTXwy/h6JZlgQxPg+iyddAYfLsfi43eL2MtqbxwIbs3Um0DdGuaV987dpkT/63icrQ9q9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151955; c=relaxed/simple;
	bh=rSPUXzgLQKI1wwnUPptEwKPDreTpZONWfB9dTDbQyy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkotMsfmd6s4I5wc1lhDJrQz5bImCjR9g25sGbYNwyOKkIqTQjtHqgHkLlg5XF3GaCyQfgmzPZHHULfsO+m1FmzSOQvB6h9yMHM/CNYKsXFWqce9wsUrb+RjrFZ0sYd/X+1JmIuZgrkI9XVYfQiKnSzriP0lOGhVzBK6eHbRrL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=VWxg1iaI; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c88e5f4aeso1342177c88.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779151952; x=1779756752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkSDV/hGDItXdWtxgXI29OZTMaQsdY9kIYFJD3n6x/c=;
        b=VWxg1iaIkmllm7/M3RQVrTAAgreJ7Od1e5XdYmpfcPojzc+9pf78AIX9wNB4viH3pB
         i7ntaBmNGjQq3nPBLvpIay2n6NbEwwEhp0SW2/DOxhPkQBN24ZfA9Uw/aQrrZzo3XDwt
         kBkcmEdy8U+Hat7WkZCZzAvDIkuFAWz9HKuq1zoX3T1yd0Ffz+s4iaaWKY0X2myde96m
         oNLnBhpCQkBWiB+MyFUP4Pcqaqits7QW3AH1G7ZowoBL09622c1aXMkgVggot7gZqN0O
         4u7LfLr2PZtwh6Y9JHaOoNHCiRs39/JlvJOTqNM78OAdgqOaR/zMPd/gEonJNEswD7TL
         iGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151952; x=1779756752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkSDV/hGDItXdWtxgXI29OZTMaQsdY9kIYFJD3n6x/c=;
        b=g+okwtxekDddQZbmwlLy9oQWeIpaOel88l2p5UFn5oujOg5sP8uz8zh4EjPmVdJ+ln
         Bs/WaGenlW1t4V/vcGREvvrUZ3ggy2ZYxOBwGfCU/lzz3HsMDHdw3Tm2BMUijuEI6FIk
         2Yl5R0xt3pdoHaPA69IvkeCstJ74Enj4gUUBUBo+ZVisNPPj3Ol3nNQ5m5psyAA9mxb5
         bM76H1lwgwLY2AW9BG5Q5aj2IsDQ2elJSisGZL+DehEFZuIQQ03ENM9uTYYEBzRnnYCx
         pmCF9bpzeL4t6tzwbXZVmoM3xesev0Pod60ZaF4IXpWJtIw5/hPLlv9KV/A1bVFfyyTf
         F+5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/AqrXfg67KCD5+o3YZ+zUm9KYyiMZc+tHIlH7asF+Ehy83swrp4loTW/7iDowG5q7LpN8dLdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Z6PXuVVKpWW0RYin+hSLNd8e3YksibV9GzPcflv5QURDEQIL
	+SOvAX5BYjr9Jf2yqm+fCRUkbk6gqdHoD0Pk95GLtuvG/0oJMWBkj3VXJL70PYSeNpMVglIGgLR
	h76RGp5Q=
X-Gm-Gg: Acq92OHKXs8oKW51n3JQb4xluvDFIY1jTbK+VWwZ+oZawMkUbMVYabIc16STZl5alXA
	tkkRMFE7oHy7qruqMPB0rkKlhNbtxAXM21f2w4VgGPLF/p3W/ky3hjRnVPILYTrnW8nAFaopu9K
	5KI4nXXFgegU6AlcEa9bG/bSlUnYdXKCebyXk3eivSsinpcM3w9eVQ+EIFisTBqMIQmtINqWrwN
	5XzwrclzySoy3tzrWSKPUvUE6X/PcU1im91fb+SwmgNDG0opaDNJKQLRskadu7D4R2W4rGbcOm6
	8Czcy8PJTUPbqRL0KJRzhnjFrqIAIxHJeZXjR3Z49nEmS3h5BsKuLt1/cyLLWynNT61ccrZMPpS
	bmloXFpAXP52XhZlWe6ZdPCX6ydTRhN+73Pu5GpZZrhZufkBEfMm7XpmTVcf+pxfooEMBeEqSoF
	BdxOpZ/xx9v+C/4H2hsi6GeN99Qw==
X-Received: by 2002:a05:7022:250b:b0:12c:6dd8:623b with SMTP id a92af1059eb24-134ff500f38mr6567069c88.0.1779151952355;
        Mon, 18 May 2026 17:52:32 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm22546633c88.3.2026.05.18.17.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:52:31 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 17:52:27 -0700
Subject: [PATCH v3 3/8] hwmon: (pmbus/adm1266) reject short block-read
 responses in the GPIO accessors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-adm1266-gpio-fixes-v3-3-e425e4f88139@nexthop.ai>
References: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
In-Reply-To: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779151949; l=2394;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=rSPUXzgLQKI1wwnUPptEwKPDreTpZONWfB9dTDbQyy8=;
 b=K+8bHGXkf6oBwMcxqjzXElyXNeXhFer71lr5CRjozh8Jex49aLDFwWIl2SefX8JKqfza6NZJ8
 n502WXx0f+KDep2/9UWQR4xrP0ALQwNNexLE2viY6t1it/tkxDIBXGA
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-249421-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68E80575CBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


