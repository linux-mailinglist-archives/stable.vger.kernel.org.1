Return-Path: <stable+bounces-200257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118CCAAC41
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49FEC300F5A0
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7A42ED17C;
	Sat,  6 Dec 2025 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/Hn6TT8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A22F12C8
	for <stable@vger.kernel.org>; Sat,  6 Dec 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765046109; cv=none; b=YpqW016Pmmfj0vIyjRipVT3rRDmb51m8WeNUizOkveWU/dtNXTiVNuToqFDfMrPBap3FwUN0tWpWTBGgm4ORn/CnJa0PaAWa6X5+EVQUon+OK/pCBlJmiceN40cGRVxaCZbOdxEzSNGKRla9VoMm7Gv8kn3wadOWUfputxIFvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765046109; c=relaxed/simple;
	bh=2Xj9BvX5DJCNWMWbbzPbSZXRdRtJu6wOg59n92iAbNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqTxxWGH0Tw9ddIyyp2lm9LOfTrlD9SEnNDKlq46hIi6dy0vJARJOA+cFX6UfkaACVD4+PEIH2BHt3K0LV0AeLWQ70x9P6JqM3GoQ6bQUfl+jCD6la/mzmsWNsR5gEN3IHqPIGb2RvmPUGYJSXWXFopdGrJT5WVS3DKuzg42JzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/Hn6TT8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594270ec7f9so3598029e87.3
        for <stable@vger.kernel.org>; Sat, 06 Dec 2025 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765046105; x=1765650905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBbB448ht3hgqVqiqj9wAU25sZQEfiyetfXCLvEq3so=;
        b=I/Hn6TT8iLH4JVy9MgQdBbonERZmmt6dv3kMvFnvwEmcPegq4M3EyZuAM93KgRYKeg
         Au2WWmCwvJ5sLJI2dVdRocT+9MYZIqUjOaqL870wu350DpWHKujPJJxd5FhiCHZkU9Uy
         ueCStBtDHPhN85XWZ8SPCEkqbMF/U8Y9rrtGANJ/tUH9/5+P6zMaIWJsZQThKRTy4UKh
         krzI8iPj6xYcEo7gnNawrr46QdPR6cJet4d7kvCxySUof6nC2QLIG1c8TQpErBsx70xF
         sDk1m1xBNMbyawGYD2+rMFsbeMCUgHAwbFcYn+Zz6HZHjHXhGAXHSgKwxm9UKJnHaO6U
         f1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765046105; x=1765650905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBbB448ht3hgqVqiqj9wAU25sZQEfiyetfXCLvEq3so=;
        b=ZHz7i9ekr5C1qYqMnIs8TJOcLMu1+w8VSQfIZdU0kV1m0rekhl/kaE+KKDX9WtZ6r/
         JySVwts3nCKertlqfJw+u1FlLsMQ2utZjrIIp3qdczNVe07xQgu20Ox7qAsPaZdNHqZK
         VRxKNDJ5abuqqFQizMeelBD6BNAL8jfDSNVDyrng/GpCZ/ODUIR3vDLeRV5gtQ7GnG6h
         9qZGHfy0kI7I1jtt1qUvmezVlKlRoKUcoQJQl88HjYoK6SEihZQ3Qxfx4yWpcQyTdlSw
         2KA7JRWaJZ+3RxGrnWj+9Tp4jxR9v3L0ebkC89A6UgK/sfXNDyIcvh05OzdsW90QHN+w
         jM5A==
X-Forwarded-Encrypted: i=1; AJvYcCWxf1L7j9NsAY8RRPoyb0OsAe3K4pr1cgbelYjVodKHEIsJZ4FzI95Zk8Cj9g0ktDkjRAuy49k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVe7RoPzRIHSCUScX/eTIT8QYQXOi6TIuYiqtWuMnDdaSGnu/x
	1nGLNjb10tt56Hy0qd0JLYo6ED3WwUlxVf1m++0kyn/PPT1GjwDlX6wq
X-Gm-Gg: ASbGncu/zhdI1xTEP46U1WXtnfMTYa45fE+/2Vw0QxMR0TSWwmwOF+QYc/RLCTY9D8q
	KnuGSv5MQ0d1FMYplH0tQnGXiDWDuAE4aJK9y5H5hRRydD+Js7C8raeaptZk1SUxpzQZapIDxcQ
	FbTyGRckMI4XHnp9k23RKYoMsp2ekHTCzF2DKDmdE1A+nbde4vfgiPk9I13orsQX9ELdX4Te1oN
	aA9P1yhpurg6fvS7t4X0ynuJ0BmNrrpJdbqtw7cJgw+7Nnj722D30mG2yUgqKaN8bY5TSRrshxQ
	0cflOvfJX/nEQ0FM9IcTPAdU0iELoQpXIFpp+LmROewiV2wsBHzcyoU4wWpdbl6FFsEN6aIDnPF
	a6Oy3d5BljLQ8L8h/k2VsOxnuh+IV5EgoxFclmg832is9+Da77ITjpAfKntmsSX6hD34GgTovLJ
	SBHP2HneQK
X-Google-Smtp-Source: AGHT+IHnxnTE4IQRpHLhybpHqVatvtv9+syN2SM1jyy7DP6ZE+rzLXHDgj4+p7nmI+TmaroB84yRhg==
X-Received: by 2002:a05:6512:1113:b0:595:81ba:fb4 with SMTP id 2adb3069b0e04-598853c54e7mr893651e87.47.1765046104377;
        Sat, 06 Dec 2025 10:35:04 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-597d7c31520sm2588902e87.101.2025.12.06.10.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 10:35:03 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev,
	Dell.Client.Kernel@dell.com,
	Mario Limonciello <superm1@kernel.org>,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] gpiolib: acpi: Add quirk for Dell Precision 7780
Date: Sat,  6 Dec 2025 18:04:13 +0000
Message-ID: <20251206180414.3183334-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251206180414.3183334-1-safinaskar@gmail.com>
References: <20251206180414.3183334-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dell Precision 7780 often wakes up on its own from suspend. Sometimes
wake up happens immediately (i. e. within 7 seconds), sometimes it happens
after, say, 30 minutes.

Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
Link: https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
Cc: <stable@vger.kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 7b95d1b03361..a0116f004975 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -370,6 +370,28 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "ASCP1A00:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups, likely from touchpad controller
+		 * Dell Precision 7780
+		 * Found in BIOS 1.24.1
+		 *
+		 * Found in touchpad firmware, installed by Dell Touchpad Firmware Update Utility version 1160.4196.9, A01
+		 * ( Dell-Touchpad-Firmware-Update-Utility_VYGNN_WIN64_1160.4196.9_A00.EXE ),
+		 * released on 11 Jul 2024
+		 *
+		 * https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Precision"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7780"),
+			DMI_MATCH(DMI_BOARD_NAME, "0C6JVW"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "VEN_0488:00@355",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.47.3


