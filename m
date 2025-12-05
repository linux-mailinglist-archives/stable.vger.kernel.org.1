Return-Path: <stable+bounces-200211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C1CA996E
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 00:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BBA2301BC47
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 23:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134B2F692C;
	Fri,  5 Dec 2025 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By68nouB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9D2DF128
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976401; cv=none; b=NGVdrwdlX4ONeWTdduiVftFiyykp+DlQt4MG4ZpoumsiZhf9LWumwz0P5JtRtxXDia1Cm2kQUr9oHzQKK+Zduwvh2LnaQOx4+kjQA32fHJqFHu35PdjbOCYE8qdmBu7J19Uh+CY0/yBBCJqEPpkPcZESfcodmEhPN48E9Xm8nmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976401; c=relaxed/simple;
	bh=Z2TnggYnSPNTQQA0qeFMaIKiMc/QIExFwLuHda2smVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBc1t3vzi8VKWk/d4jNBTu4EvLDYYu/NJ/XAaihyZ8aVYn1pwtzhjohaB2XLlbw8FS2zcB22kF2VgmBLD1q5kkGz68XiiWeI7FqN6lY+LYadVEXXlkbD/n44MNZt2PSzwnoZgNG3m61Is+Hrm1w6p4gdBHBGnhWW53OBnTU3W1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By68nouB; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5957c929a5eso3473586e87.1
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 15:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764976398; x=1765581198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ok3XVC2kEB7d6LX2W7MFJKuf7Db93yAzAqWhVXvqPiI=;
        b=By68nouBGABZzZpDHHPfiQKoWSJIfkh9HRFeKVufKIhFcf/6Nfi7+gl50e75zXgh9J
         up9YTfO5T6MeQSqtFwTgm+PjOUVIj8AuX/tuMgoSjBBPY89tDxsFFGJgC6sDFlGSISXl
         teZQYe5X1vaFL52WoTZqrDs2tHmLS8btykVC8U0Scz7LAGA/kXFXshUt7b4XPk2G8ybs
         /tdb6xEuF09fB7POS9v+IWuWb/puLOVWKU/1zffiTdNnaqK+wq/waqirFHn4A8F7rIx6
         1qIXQpN4E8X2iE1uVy3KFgWKxVhMfOYxE0qXuXFOgnuyOXJF620Jlda5Q5eMCZAfLrIf
         0ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764976398; x=1765581198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok3XVC2kEB7d6LX2W7MFJKuf7Db93yAzAqWhVXvqPiI=;
        b=N+LNMgrM3so3CTc/sdWH2tzlOlJdncmAtk6UEfdRxGH9bNPx3qCsVvCbIawLkuQIcB
         OdJqRJ1ZrEssdSaMtr/Et4SCLgX3WmpcJYe0UC/jMxtZdBhXI2UBZx7EWd1LDL1o61o2
         r1qvSfLaGfD/9zA+vCA+9CwRUH0hJ31v9z8E288eK7uV4I3Lzv1YPIeQehUul/rvZQV0
         h3PytaV065+n9RmQZZhg6ph45DRblPZH7ORbcnudI+oXQ4d69TF2BT+g1el4XWpengfS
         FnOAUthS7LI2j/ZIejEAXjDfh/KR63t44nYvBpMP9mgfeMdrk64dibk3zV7pPxbqkypR
         7BsA==
X-Forwarded-Encrypted: i=1; AJvYcCUoFHs4kF5fR+zUZTPcAqblawRLhuwnOqrhcL54qmT7WhaX6Dp+a/+7Z1TzhJ6j0XfSQiJPK28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoxhnJOdQaLeHb+M4ivdvaQt5idSUvZFfAvq/VjKO9lQ2aLXnx
	PbCIVE1DSf9uFJ4e1xaDsy3wIaoPBZJfFWp6p9Y/fKxVA8ejn2SvAHOE
X-Gm-Gg: ASbGncuTaEzvTQ8y8hk69bsJAY+0wg3+C+9O2HgCakZOFD9sYaor8hdpGWD4XSFztT3
	mvR9dDwqci4MQuARvIHZ7I++wCWSicsnfNlJAerbUUJCvsH70FePlflKqysSb6FsoKn41dg64GT
	I4V12WUeNFUEG86Bsxtbagpe9mC3MQC4qbSDl+dg3jCW2jp+HEjMkuV6CsU3Zr2zdOEPGmns5wo
	d4r2d8HPeoeeYDKJRf3rcLlNRF/hMJSBNYEQRVyrQLyYVAjKXfG1lvevnHw3JnsrTviMWfRIsiT
	1I+a3+QQ5BvXsFCvctu/+oFwEQklWwEP4r3TMZ1mkzb09zr3TK3IaLPTS+91CU34Phwvx/VGvTS
	/TtVc3u8PAw4wRA0S3KS8HD7wGZ9wjRSNQLdstbsvudjPF2c8/WN3uRvRZkzYnnhxtGYzIcL7PT
	fgOTD379MXD/mVHCKNQ2Y=
X-Google-Smtp-Source: AGHT+IHw+siol0Y/HCUauT594fFSjA/LYfEXRKCDELP7T7smqU9LZ6s7uqmUidrRDZEZmBY4flxMEA==
X-Received: by 2002:a05:6512:2353:b0:595:8200:9f7e with SMTP id 2adb3069b0e04-5987e8af414mr145380e87.20.1764976397518;
        Fri, 05 Dec 2025 15:13:17 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-597d7c1e2efsm1918614e87.56.2025.12.05.15.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 15:13:17 -0800 (PST)
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
	Askar Safin <safinaskar@zohomail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Add quirk for Dell Precision 7780
Date: Fri,  5 Dec 2025 22:32:42 +0000
Message-ID: <20251205230724.2374682-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
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
Reported-by: Askar Safin <safinaskar@zohomail.com>
Link: https://lore.kernel.org/linux-i2c/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/
Cc: <stable@vger.kernel.org>
Tested-by: Askar Safin <safinaskar@gmail.com>
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
 
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449 (v6.18)
-- 
2.47.3


