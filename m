Return-Path: <stable+bounces-89711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B69BB8C4
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E6FB22372
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65D1B6D14;
	Mon,  4 Nov 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9CS/vh5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAEC1531EA
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733530; cv=none; b=WTV4aIUbuH+kyZxkVQmMfXgw5VTV2gJERnuQflnqc3MvkjVssfDHIf2DEd5IUCatyxLlHRiexzq72s97/gtmSIR0aKkp0GgEVXF5yhFJn0zISNcVl87JT/IwACp6V0I0v8obv9Dcy6N/GMbUivowDRes2MDWWQyxZ3LZmlA7gE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733530; c=relaxed/simple;
	bh=+CLj4REK/2pJFb9NB+GnwBNAZKVlmJS3ssjuEfZNmCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ms0L/CJE1or8Z9bB6jwJSxrSnjuVDreC1y5NZwAmNUHY98tGqDe8qwZYDzboHjvdA7XETzQMljWHFTE+uiBQV9nzPXfelfQHqCGALLyLvTR4XuA9p8IMpRe2PcGB8vNmNc37OT+89gQV+UcZ04owO1yaPPonoWlTObpPx0JAv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9CS/vh5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20caccadbeeso46126595ad.2
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730733528; x=1731338328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnn2wZ3PqqpfYJKrOXZXpVSNhpxKk7sQk2hEfSzjQQU=;
        b=N9CS/vh5c8lHd4+q6CBN3Or3VY/bOmBXlzWNIK/WrFdEqcK82FYJV/0+ACq9MnWOiA
         7cjIrbbQR42E01JnO9sm20Qv0AlG0HIDM403OQuEW6sfi2d+HamucYW6C3UyeBilOG+0
         LhBoMIwQ1mQXrRprptUvzOUfwxryL58Cpzwm0qsZYMnPVghM9kYO++LOvag0pbNAJprT
         3c5rMdCbO6xckXSQdYTkw53AUL5ZP8hbG3rGhjr/2GGmLvs9vEhX/sStXKHzdXM3+Vze
         3/AoD+PhMD0sQdUOotKnuII/OW8V2h8dDmLVkFn+/pqAIwcSRgPwjfKI7nzge1Cm0aXO
         jdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733528; x=1731338328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnn2wZ3PqqpfYJKrOXZXpVSNhpxKk7sQk2hEfSzjQQU=;
        b=md18DIKu5lySC3A6UMQf03VKrL/15r/Aq8K2WT4Jlwp/3D8+xq/BwrxA7nb+rrAO74
         IP1gEoxuJI9MOb9+kG5Q+74Yruo4+XdRXrw3zq+UG0fIeDZtI02kdfCIhqs4P7j3TeSZ
         +pzXsogk4d7H1uSIZFu+j7IEf6iswRs87XiNaTlp0RIjRrDHEwj+7sweop6Swofyb6By
         oVfIAuzNai43EuAI3CWqU9C0toMyQLIXA00hbUlD1Z97Di6SG93vJPAOQjW+GtDr/TXY
         Y7u0oa0Z5K1q7muprBVHffEZDC9jOi3UfCIO8bB6VaYgis6vTwVY738yck1XStCvZFG9
         g75A==
X-Gm-Message-State: AOJu0Yyn8CAKfODWJjVUzY4Rrc1vwkZaRhv63IbZFBqW9xHG/bZLeckA
	zQV6eDcgmnuixXlB6m8K8G7QlQfCBNfgcWdaSFcONlBcyd92GA9luZDCTK+X
X-Google-Smtp-Source: AGHT+IFiKDEj0aCJGkAPSXXfowCbRXg4vxnwopd5LAFr18b5cfEpdVf/lcP/I5dCQ6I7/OcnlPAx3w==
X-Received: by 2002:a17:903:1d1:b0:20b:54cc:b34e with SMTP id d9443c01a7336-21103ca4715mr236363225ad.51.1730733528490;
        Mon, 04 Nov 2024 07:18:48 -0800 (PST)
Received: from optiplex-5070.. ([182.66.67.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21131c64226sm38605205ad.150.2024.11.04.07.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:18:48 -0800 (PST)
From: Sai Kumar Cholleti <skmr537@gmail.com>
To: mmcclain@noprivs.com,
	skmr537@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2] gpio: exar: set value when external pull-up or pull-down is present
Date: Mon,  4 Nov 2024 20:48:42 +0530
Message-Id: <20241104151842.2303376-1-skmr537@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting GPIO direction = high, sometimes results in GPIO value = 0.

If a GPIO is pulled high, the following construction results in the
value being 0 when the desired value is 1:

$ echo "high" > /sys/class/gpio/gpio336/direction
$ cat /sys/class/gpio/gpio336/value
0

Before the GPIO direction is changed from an input to an output,
exar_set_value() is called with value = 1, but since the GPIO is an
input when exar_set_value() is called, _regmap_update_bits() reads a 1
due to an external pull-up.  regmap_set_bits() sets force_write =
false, so the value (1) is not written.  When the direction is then
changed, the GPIO becomes an output with the value of 0 (the hardware
default).

regmap_write_bits() sets force_write = true, so the value is always
written by exar_set_value() and an external pull-up doesn't affect the
outcome of setting direction = high.


The same can happen when a GPIO is pulled low, but the scenario is a
little more complicated.

$ echo high > /sys/class/gpio/gpio351/direction 
$ cat /sys/class/gpio/gpio351/value
1

$ echo in > /sys/class/gpio/gpio351/direction 
$ cat /sys/class/gpio/gpio351/value
0

$ echo low > /sys/class/gpio/gpio351/direction 
$ cat /sys/class/gpio/gpio351/value
1

Fixes: 36fb7218e878 ("gpio: exar: switch to using regmap") 
Signed-off-by: Sai Kumar Cholleti <skmr537@gmail.com>
Signed-off-by: Matthew McClain <mmcclain@noprivs.com>
Cc: <stable@vger.kernel.org>
---
 drivers/gpio/gpio-exar.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 5170fe7599cd..dfc7a9ca3e62 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -99,11 +99,13 @@ static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
 	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
 	unsigned int addr = exar_offset_to_lvl_addr(exar_gpio, offset);
 	unsigned int bit = exar_offset_to_bit(exar_gpio, offset);
+	unsigned int bit_value = value ? BIT(bit) : 0;
 
-	if (value)
-		regmap_set_bits(exar_gpio->regmap, addr, BIT(bit));
-	else
-		regmap_clear_bits(exar_gpio->regmap, addr, BIT(bit));
+	/*
+	 * regmap_write_bits forces value to be written when an external
+	 * pull up/down might otherwise indicate value was already set
+	 */
+	regmap_write_bits(exar_gpio->regmap, addr, BIT(bit), bit_value);
 }
 
 static int exar_direction_output(struct gpio_chip *chip, unsigned int offset,
-- 
2.34.1


