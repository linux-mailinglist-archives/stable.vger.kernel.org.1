Return-Path: <stable+bounces-151588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0750ACFD4F
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 09:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666F817310D
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8481E8854;
	Fri,  6 Jun 2025 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRwEvzJE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D3149C7B;
	Fri,  6 Jun 2025 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194218; cv=none; b=Gcv5Z0yy6bxS/lljXpfmr/OHdp6KEEeOfJMz5DJskXOjrI8Vstki/7T/vfk+lqZ9VXw8jdqL0YIWPnu2X3roQCVN8yzrI/kcxXMPRXukos91qUd+k/8XOV8LZQoSq4nMh7NNjChd/7u0nOZdlQntaYFvh4bsUHe6y23r/NXgttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194218; c=relaxed/simple;
	bh=UlP3CPYKKYt3AdibsoMkCj0+1S83KV8eyOy9q/HeNvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oBQz6NxH20qO0XFpMO9ylEy680TToJ0Z0PcgvusxpjqUXFu8xst/oPxn34FaEW9lKh9b8vcpXEPCgudjvZHZByqL892KlcONZCNLwK0K7+FQu1GgVjsvxIiDXYgZ+x1OADj1asKBhTaeggBwngnNG1lpcSZUE9aDyHenmaFQzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRwEvzJE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso2141984b3a.2;
        Fri, 06 Jun 2025 00:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749194216; x=1749799016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Op+Qtpfm2MCMUy1ujuvIkaXazDWxwmwSZEgD+0eih2w=;
        b=eRwEvzJElk8F94fYZAKbIhmve1YRoe5+NL4fDlntj+Xu10huSWZpoFGxbh8bXSYMBl
         mMN6qk6e5pTUc4DWrp/rKhaFpDVx1vsh152z1o07Z73a+ICDSXMtaTU2652paG+pV3U8
         ML0K7zSyN3PIzhWga8MyCGPH+QuJWV1U2jJkGSrCr6l9CJqU8jXNbDIZx8j+sKfJZOI0
         87Tkv58T8z8I0/LrFkpFgYcAJmts/5af6TZfgiE0r2wjlXr9nOPXakh0FysAus7/JsuU
         4tBmDbLj8FFHzPQVn0Pd/5r0FQUsiIrxCUPz7v8AnoxI7fqC2qU/a3++Znj/MUddW7T8
         BM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749194216; x=1749799016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op+Qtpfm2MCMUy1ujuvIkaXazDWxwmwSZEgD+0eih2w=;
        b=OCEGDDbLBg15I5Xb9qpy3kbgsOLimI0le4/KHs1mMggAQfHPKXjJAeSL7pizg45ZU/
         d88NduCDhzok85fW6WFbTCCNwDuE3ag40lADRHWN10nc7RgVxmHPVpKocEGkcOwtJ2rg
         GNiWu2jEmMU9sbExyCfatJY/BYnLPRHHgEPGTyactD+bOKyVO6Lqd8/MFYla1KE1sana
         R/As/a7mHAwe7Jul7tIyvC/gIEXnxSlXOEGF380tpxaRdao2wc8FwtKXWimYojeWXrRU
         67r2yOAASDNy7FOv3x0z+4cLXGWkKKAGvanb11zuvAL1k0nQCTJw3jQlishH6A1mzEj9
         BQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXV02xSs5hbLAjWB2RKZLTplPVLb66AE2ZXo7RlMkzRIrD4KUhtZP9pPk5dx0Eg+5heoTGrFn5V@vger.kernel.org, AJvYcCXaSC8Z3qAwV69zy0OuOmErfW7ymlQTbN0sHMLNC9HLY80mP82XcudxCn2xLFmp0DceHQQED69dOOgPufU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/s6QPKTSHIWvSI8SqeY8ZYcsr2k7rjZXJghn/B2iylq+eXER
	WZf3tQBNARpkF4+8M10Pl7xc0rWbT4pFBEhDKJx1sk8ZtqX0hagoYZi6UH+Vw09tMrQ=
X-Gm-Gg: ASbGncsoyHqmuCyQygpRg50vu1mYZj684JojmiGE23UppnakmdgMZ6dox4+O5YRyTxD
	DHGy0yKVq6zCLcdM6EcugWHpTF1cw7Zulfg3Nlv+m6BxRzCCQR11Br0IOdp97AAwVlzw0cQTNNb
	XzIJDuiE28dc+mb2BSPF90ljKOSUTmpls+K69i51zHliOZvTFRRivqTl3p3aYh+FvOu6y7PrbDT
	TnxZ7FmajRxb51ShmehULbTILTgkWF0A8JrE47D6CbcQ67L1IBL9fkbSkFhEmZhwv+L/r0/Yt6R
	Eubm+bq71WijVtctGwXQjhdX4xdgeummW7fvz5di8Q1hZxCd25KozUcS6f0K7LEwruM=
X-Google-Smtp-Source: AGHT+IGhUpAbWq+54xvZKi30Ot5Ktc9ysFyqQgxtqXZzYUo9SybvjX4C13xxRSAukBjjZ+ozZxcpdg==
X-Received: by 2002:a05:6a20:d80d:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-21ee684e093mr3491091637.7.1749194215803;
        Fri, 06 Jun 2025 00:16:55 -0700 (PDT)
Received: from localhost.localdomain ([124.127.236.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7ab09sm718469b3a.58.2025.06.06.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 00:16:55 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (ftsteutates) Fix TOCTOU race in fts_read()
Date: Fri,  6 Jun 2025 07:16:40 +0000
Message-Id: <20250606071640.501262-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the fts_read() function, when handling hwmon_pwm_auto_channels_temp,
the code accesses the shared variable data->fan_source[channel] twice
without holding any locks. It is first checked against
FTS_FAN_SOURCE_INVALID, and if the check passes, it is read again
when used as an argument to the BIT() macro.

This creates a Time-of-Check to Time-of-Use (TOCTOU) race condition.
Another thread executing fts_update_device() can modify the value of
data->fan_source[channel] between the check and its use. If the value
is changed to FTS_FAN_SOURCE_INVALID (0xff) during this window, the
BIT() macro will be called with a large shift value (BIT(255)).
A bit shift by a value greater than or equal to the type width is
undefined behavior and can lead to a crash or incorrect values being
returned to userspace.

Fix this by reading data->fan_source[channel] into a local variable
once, eliminating the race condition. Additionally, add a bounds check
to ensure the value is less than BITS_PER_LONG before passing it to
the BIT() macro, making the code more robust against undefined behavior.

This possible bug was found by an experimental static analysis tool
developed by our team.

Fixes: 1c5759d8ce05 ("hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 drivers/hwmon/ftsteutates.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index a3a07662e491..8aeec16a7a90 100644
--- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -423,13 +423,16 @@ static int fts_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		break;
 	case hwmon_pwm:
 		switch (attr) {
-		case hwmon_pwm_auto_channels_temp:
-			if (data->fan_source[channel] == FTS_FAN_SOURCE_INVALID)
+		case hwmon_pwm_auto_channels_temp: {
+			u8 fan_source = data->fan_source[channel];
+
+			if (fan_source == FTS_FAN_SOURCE_INVALID || fan_source >= BITS_PER_LONG)
 				*val = 0;
 			else
-				*val = BIT(data->fan_source[channel]);
+				*val = BIT(fan_source);
 
 			return 0;
+		}
 		default:
 			break;
 		}
-- 
2.25.1


