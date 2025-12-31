Return-Path: <stable+bounces-204303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD4CEAF8E
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 01:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF9D301A715
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 00:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6A37A13A;
	Wed, 31 Dec 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kol/M04V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8B19258E
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767141927; cv=none; b=q1MKteQ77eIl0WloSnfoA1ebf85HwBjWkUs0TQnxo5dzD99GL2cTRiQ1FLYnhAVc/nXXa+jlSwf3lTXwvs9NA62G5md9aQqi8x3wBHZ/Oo/N4U8hCS9917+x9t7U3U3GtKA/H+wicEGZs2x8GDjLxiNHnqmmjG4opfrq58uN+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767141927; c=relaxed/simple;
	bh=58nJL78mZb4L/r540FIIGmpaC9+0CK1OZCYFmquRRgI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g3e3oozuxmwVVUttgGLO5IUNl2ByrGBP6dXxA4/v9TYWcskihxU2gH99bhVW0OcSg9HC5+Gs3uXz526WTZ6mp+uc/Q+g5idfX0EMsdL/xRcmO73UM45pj3epmP7xUjP+GzPg58Me4mu5XwbPJHVGmVt/F4XcZXckwViKx8aBkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kol/M04V; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c6e05af3bso22857385a91.3
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767141925; x=1767746725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fjrjqtIG0QKNagwrK1D4QB/QYPJKmvCpq/Rsho6vIE=;
        b=kol/M04V0q5tjuz+SYGIyhLb+6zo03x/oSOdkwxJHdXyj0rx6pLjMesrws//FbuBf9
         +k0MO6rUHvdka4D4bBxIVS5nfbALCGcUZw/OgZ7XHZaTQCkxBZtNubOTyFFcUO/TqpWH
         lv2HgAQCNW4mqxjmwEVqOLVOWkZY6V+ak+SnMYG10L9Xv/ajLFeIBtMkPhoLJhv6Bhof
         u3LDfg/+EXvgNA/+6gXurq14akzzlDGVLxr7iwx6fN/kdWKtuWa2HJSD9hKmrDR3vq4w
         fgBf+nFocXUrL1XUKLpEfen9EUPn1E7uHHDmg212TT+T+gqNKewltgkc8pWvI02//e2/
         zZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767141925; x=1767746725;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fjrjqtIG0QKNagwrK1D4QB/QYPJKmvCpq/Rsho6vIE=;
        b=C6TSMtHzpL+lDlSuiJb+4mo97MDU8C4/LHhtCzrtqPe+CxnSk79SFzIKU7OQwYMmWM
         V4+AoqLpcxXvEh7BRA/hLMwOQAMJOdTSL/+f3FPw0jqGfokqG0uV0opMts+TpeIbnllk
         7G9Bml6NLZt7t/xzk6mlZwTVClsII8+H2St4VibjElf2/eeQ51y68AbV9p8Ndr6Y5VIq
         SqI+lBWdCu1ScgYqOGg7pWIl6a7mYxZ3tiLi/fd9A79wYg/XgFxxxO19Duj3t6s3qBQl
         wUMF/f4wTjbjtW9chKBhBSkamNyhqF4QpqgcvXgxb++LUuzbCaGn70WTx9wrpNHwU2kP
         2Jqg==
X-Gm-Message-State: AOJu0YwzSay67CEauKSXBp1WLxFzP3dIwDayjYXpbHsGcde5ZPk9h9NU
	moYR1FZihghqYdV/iTAz0AIFIeED+XCDlovj8xLtiE6X7AnLjLMHzqG3Su3AAKBVo9zpY3kqcUR
	7NzDnkxvymz5PG/AibRSLiYAuUzuO0HMTfuMoM7emkG+K14ClrXRU9NVt8BPBdxCP9IOrNP7gqa
	6sQhafPEB05GWlsLjHhdhJrrJWW60+zKHhf/W6J42gYg==
X-Google-Smtp-Source: AGHT+IFzEHBCDGH6fIW5fQdRAN3RJwqMBy9/SFw04+KiP5a94waiEzLW46hMtUUrlVdXoksytpVnCtihLWua
X-Received: from dlbpy24.prod.google.com ([2002:a05:7022:e998:b0:120:5c35:c798])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3c06:b0:119:e569:f258
 with SMTP id a92af1059eb24-121721acc08mr29050254c88.1.1767141924735; Tue, 30
 Dec 2025 16:45:24 -0800 (PST)
Date: Tue, 30 Dec 2025 16:45:11 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251231004510.1732543-2-ynaffit@google.com>
Subject: [PATCH 5.10,5.15,6.1,6.6 RESEND] leds: spi-byte: Initialize device
 node before access
From: Tiffany Yang <ynaffit@google.com>
To: stable@vger.kernel.org
Cc: pchelkin@ispras.ru, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 7f9ab862e05c ("leds: spi-byte: Call of_node_put() on error path")
was merged in 6.11 and then backported to stable trees through 5.10. It
relocates the line that initializes the variable 'child' to a later
point in spi_byte_probe().

Versions < 6.9 do not have commit ccc35ff2fd29 ("leds: spi-byte: Use
devm_led_classdev_register_ext()"), which removes a line that reads a
property from 'child' before its new initialization point. Consequently,
spi_byte_probe() reads from an uninitialized device node in stable
kernels 6.6-5.10.

Initialize 'child' before it is first accessed.

Fixes: 7f9ab862e05c ("leds: spi-byte: Call of_node_put() on error path")
Signed-off-by: Tiffany Yang <ynaffit@google.com>

---

As an alternative to moving the initialization of 'child' up,
Fedor Pchelkin proposed [1] backporting the change that removes the
intermediate access.

[1] https://lore.kernel.org/stable/20241029204128.527033-1-pchelkin@ispras.ru/
---
 drivers/leds/leds-spi-byte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-spi-byte.c b/drivers/leds/leds-spi-byte.c
index afe9bff7c7c1..4520df1e2341 100644
--- a/drivers/leds/leds-spi-byte.c
+++ b/drivers/leds/leds-spi-byte.c
@@ -96,6 +96,7 @@ static int spi_byte_probe(struct spi_device *spi)
 	if (!led)
 		return -ENOMEM;
 
+	child = of_get_next_available_child(dev_of_node(dev), NULL);
 	of_property_read_string(child, "label", &name);
 	strscpy(led->name, name, sizeof(led->name));
 	led->spi = spi;
@@ -106,7 +107,6 @@ static int spi_byte_probe(struct spi_device *spi)
 	led->ldev.max_brightness = led->cdef->max_value - led->cdef->off_value;
 	led->ldev.brightness_set_blocking = spi_byte_brightness_set_blocking;
 
-	child = of_get_next_available_child(dev_of_node(dev), NULL);
 	state = of_get_property(child, "default-state", NULL);
 	if (state) {
 		if (!strcmp(state, "on")) {
-- 
2.52.0.351.gbe84eed79e-goog


