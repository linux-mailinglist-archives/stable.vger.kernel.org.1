Return-Path: <stable+bounces-106083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D585C9FC18E
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 19:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59E61883CEF
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6042135CF;
	Tue, 24 Dec 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b="krXRAqZI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962692135CB
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066568; cv=none; b=slvCGb3s9Sn9N7HLZqXw5UYkNjRZMgrvwi5ZXMvaBs/BTojHm5p8MOWJZxSI6JnBHis+c24TYgAc1CxUagc1snARpsU4cIcKg0OOEw4wmHcfdr+PK8U4SMth05rWHko8wwepsIbCXXGk2LN07wPx+CTy2Q4gE9/eYt/s524ya1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066568; c=relaxed/simple;
	bh=7pinphWaXHVtgoKsyiRxVjkHW3SKo0mhTH74ygL/6Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LVUEXSQkYxupyC6waWRYQKW3PbU0Lbn9u5dOYJ/7dZdYSlR++FCDosl+hK0Af/EpttBiRY+KAeXMSW2bel/DcoXuO/Gx9SqEO9o7Dd2T83h+LCIRsLJVIOqjKwnFbZQYX89OPP+Ds/U/scczoO9oNqzIfesO8QAgTrWvwGPH+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b=krXRAqZI; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6f7d7e128so549905785a.1
        for <stable@vger.kernel.org>; Tue, 24 Dec 2024 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett.net; s=google; t=1735066564; x=1735671364; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXXYUkFRD7E3IpZu6O0CPYxfUbXL6nnPux9jlxQUGk0=;
        b=krXRAqZIko4QjZxD/C6Pd0FI/lm+zrsLjVNgUwf8hz0lB4s4860OCQ1DPwmhWUTEpd
         MBnF9iDAflBvCZivn8+RzYY1VGpu72YaoVKq3xNOLCCcZv/ji2F96mpWjbUTADx13d/t
         +U8RRzXjPAjbt473aA5OzggQB3hp10Dtbc4/YAXJeeywDFKsuk3FZBl6ueUYWk2t8qKS
         bNCVkbI+KYV1ZLnA3ZkTv0Q64Vdc68QqzaURgqp7FpGrq8spKvcRkfIdKYmgs8pp/sKu
         0Ai61iv5adSWkYLy28ncM8yJt02KAZ/StYx7ndo0dawBX52geH8yVmz38pxhE4LZ3Sv5
         dNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735066564; x=1735671364;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXXYUkFRD7E3IpZu6O0CPYxfUbXL6nnPux9jlxQUGk0=;
        b=lq1gh+7QYCW/w8QBmwAGnlIyHn1QMDNUOz4sXdFIc4yh/twk7skmj+L2KO+muW4+9B
         t+R1d2AX9VFl5LtUOKrKHf5hbWVkYeRzigTqaTMIjLKFVnOTBm1JxTF/LgSP8EJ/rs/a
         mJ6tVhXjxVTHoiwE+2eI7Lp0m5otZ8E4bAEEvxKIu3y8H4qc8EoKpkK9Y0F6YxHeZTwX
         VhotKnkXp0xPoGi1tuqXS8EcaGPJrQyeiRfGkO3K6WvMKgafzs35jIopeCuuiz89Nlws
         93SBW1F8v8R2ennoFza6ryeeDFSLgVsYrZAkgRCYRZNNwD85KoUNrMrp9wOsLsjKgIHn
         AERg==
X-Forwarded-Encrypted: i=1; AJvYcCU/hIxCLoRRf/0B3iP03L74366JGsMwE6En9RpmglTIN7a7bmepLSmzLubvfk3gFNUQS3mbdkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKvvXyDl6jBSZVB1vD1a27AR8RBDDIegTQ8v/bHQM/zIxkmcO
	Mb30/MUg4B4+TQelpFSZETCJpu5IGmStKb+FFL9j70ME4uf2wOzIWcewPpdVtQ==
X-Gm-Gg: ASbGncvp7ObvKCqESZ0mNreTwxfkLmCDCHWWb9MSCyoVPiwvG3hFyowwQkExo20Z6E/
	4i5qRiUucb8cOETe/SCVf4P7R+UTFRlWcHYDGmeKVG7qiL+7AAPJCJlLn8dj5o9y8/LSKr69g7n
	DdDo48dHVg4C07by29tynjA2UWYselvSAUHuTG2tCA8Tpz+QG+SIO/3fy94Nt0gxv7E0M4opNsA
	GUkCu//zDqDIwfX1yNFZtdS+8WghJ1YFoGq/Q==
X-Google-Smtp-Source: AGHT+IGfuX/I3DQg+Zsj144vhZlT7ftntU/y3W7406T/MhzcFXH0SL0TzTIxd/KrvAVWcGyDV0j5jg==
X-Received: by 2002:a05:6214:5888:b0:6d8:9bfa:76dc with SMTP id 6a1803df08f44-6dd235ab7f6mr280466036d6.7.1735066564579;
        Tue, 24 Dec 2024 10:56:04 -0800 (PST)
Received: from [127.0.0.1] ([2600:1702:5e30:4f11::6f8])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6dd18136b00sm54642196d6.55.2024.12.24.10.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 10:56:03 -0800 (PST)
From: "Dustin L. Howett" <dustin@howett.net>
Date: Tue, 24 Dec 2024 12:55:58 -0600
Subject: [PATCH] platform/chrome: cros_ec_lpc: fix product identity for
 early Framework Laptops
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-platform-chrome-cros_ec_lpc-fix-product-identity-for-early-framework-laptops-v1-1-0d31d6e1d22c@howett.net>
X-B4-Tracking: v=1; b=H4sIAL0Da2cC/x2OWwrCMBBFt1Ly7YANkYhbESlhOrXBJBMm8UXp3
 h38uwfuazONJFIzl2EzQq/YIheF8TAYXEO5E8RZ2dijdaO1DmoKfWHJgKtwJkDhNhFOqSIs8QN
 VeH5i1xiVHvsX1AwUJKmSkOnN8oAUaufawJ+8886ex4BkdLIKacf/zvW27z8/w4HungAAAA==
X-Change-ID: 20241224-platform-chrome-cros_ec_lpc-fix-product-identity-for-early-framework-laptops-757474281ace
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Alexandru M Stan <ams@frame.work>
Cc: linux@frame.work, stable@vger.kernel.org, 
 chrome-platform@lists.linux.dev, "Dustin L. Howett" <dustin@howett.net>
X-Mailer: b4 0.14.2

The product names for the Framework Laptop (12th and 13th Generation
Intel Core) are incorrect as of 62be134abf42.

Fixes: 62be134abf42 ("platform/chrome: cros_ec_lpc: switch primary DMI data for Framework Laptop")
Cc: stable@vger.kernel.org # 6.12.x
---
Signed-off-by: Dustin L. Howett <dustin@howett.net>
---
 drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 588be75aeca16b6150c12d2811e4c9dfc31b904e..69801ace0496dd9ed31bc3d408c43b96ccb71186 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -707,7 +707,7 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 		/* Framework Laptop (12th Gen Intel Core) */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "12th Gen Intel Core"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Laptop (12th Gen Intel Core)"),
 		},
 		.driver_data = (void *)&framework_laptop_mec_lpc_driver_data,
 	},
@@ -715,7 +715,7 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 		/* Framework Laptop (13th Gen Intel Core) */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "13th Gen Intel Core"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
 		},
 		.driver_data = (void *)&framework_laptop_mec_lpc_driver_data,
 	},

---
base-commit: a15ab7a5cc2a17b6a803f624fcf215f4e68d56b6
change-id: 20241224-platform-chrome-cros_ec_lpc-fix-product-identity-for-early-framework-laptops-757474281ace

Best regards,
-- 
Dustin L. Howett <dustin@howett.net>


