Return-Path: <stable+bounces-192275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0F5C2DC91
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 20:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F31D4EF505
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA69280017;
	Mon,  3 Nov 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBTPfkvx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F581B87C0
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196536; cv=none; b=EyamBTTgw97WR9N55Qv3vwSPvlwofV46eJWNBe4hOco/AuUmI4aIfUETUsEM5e6trn5yYxR/Ok2NC/BUvjWCMMHnKtMMBo/THDoL93z7kri7/RpMdLKoB5XB14Yr4Rwx0//FJQcRiiYRzpdYPlNGi5dMk+hNip1Dv865fYyPM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196536; c=relaxed/simple;
	bh=hvfee8sXKcTq7gEJakAvwck8wU8l+Scz9c49QRFo9dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQG33GFKXsxSL2ei+1oCO+Oe1v7T2DCBCiNF6Pxy7nU4bc6fd8Bm4WgnajjUq747jdfRuHOMLHWEABh5bRpoyv7YrHwMH5koTxFoYf/BYJEW9a1kaNSzu+sBul9W6d1Rqcrox8WSJ3t5Tyiv/4oq9bAh61v7AMpuB2X6Qm5Pbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBTPfkvx; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9351ed45fb8so877564241.0
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196534; x=1762801334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9r2ANkDfOB5YfNM8kC4pPiqKBxC9W1qN8SMBk8lGv4Y=;
        b=IBTPfkvx6Wu89e0bm0eH6XbPtsvf8vkPgs0b9apwurQFG24CrX+eSXxx9wfnPpwIWA
         xw3yOk14Ot5xkMdyX/lvypu3X+n/2D4AAJo5cYBnxlhMvboJto+aY+P8cy9/PLsUsWB1
         Wk7ScvPQCvJI3DyoVF0Nm+SQ9NRx98cqKK/COYZXUL6meZx6RwN8GmSU6EdJztu/A4Qv
         xhU7ikEn0hGdq9+QgKYPsZsXa4zEtDk48R6/9qoQ1tOsqiDL6TE/MSzMF126lN97mF2w
         xCJPb2Mc4IMCIJ+rBX599ZRvhQxGU+FyA7NQrM+1qW7gLIxBUChxkqwgSyoGzkqFx+y/
         ZCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196534; x=1762801334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r2ANkDfOB5YfNM8kC4pPiqKBxC9W1qN8SMBk8lGv4Y=;
        b=lEKr/YLE5StlSW+OKuyC8leGbowA0fEvC7Dy83m7775fjq6zs2Ji6SpehhDgVelIeX
         UY+ORaQmUJrusThDuBl8gb7kL0JmWMSWqy0pZOKCzzKMl/7N++aI2lbdSFKWPsDs9hHI
         6AxMpfl0s6YL1JPQeMGqdkaplTn5HGPnAlb8KQmHupSsdiz+ZMoV+K/+dfaYPFnxEpWC
         83SZWgwfDKCrtqofoIMG3ac9PCQ4eOYTciJ9AV7jr51zdfzzxMKqIAFym+8o8BF85N7m
         6yObdW4V6LIvN/06sXlpR4BWXey+CtMkerl19qLgs1rCAFNf6YP+JkBbGGm3Zmp5yGHf
         pjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEUQkJno7hZEv2kWnEezAUkjYIMsyEf/ecPqfvrWXzXJk+qCEOOEALEWQGBwoQzaWDm+I2SfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbClbQo5OFTErcNjfpBeuLtyf6OyrxmPkNaQhODph6hB+RqLB0
	rLxGswIROIk+vyk8+wNFaTitHDcXz8JPwwliDYPn5DbiuMgLtpDpikRk
X-Gm-Gg: ASbGncsA5cux3/izSTKtyHXnFh1gxdmHHMnpAzT2W9D8p8iV1csl1PuwGbBQgeMopVR
	JcOF1oipRgwUSmoIh4X/RWfqU3EPjYsBEe+2Dl5S8KPLex0MoRyHer7FMSb8o4at1BUA1Xcc412
	qCGn8sV+BJK21jys0BgkL2rYPw2rfcL+XrPDMzdU9gWXmzn+HVBepX/NZKhyPV4OzPbRVvrgwdN
	73J6E1N0bLw9sdGT9bfDHdVYxZqfU9Cw1VAmm3iGomhpORmbXHg/+TrUDUgs9a2mxhOT6qckuCt
	wxbYR/gYb/a8CFq2dTeTKlmycWTSMws4FLUsisY+tGdGH+67tHN99qlUCUusTELDU4QJ50Gfk6g
	AEZSDrNoHcGBmJmiKG13Axo0Kqp6LUFdohAooQUHtPwicEAzn2Ef9jRfO2wDpMAdukIC8m2Xl9q
	+CqLYGZUU1I32/
X-Google-Smtp-Source: AGHT+IHAvEL5uV6W5jmM4MLDCbHgG/IiWv4lbBhQ9ARySZHyuHwi5rGV6GQRfyyi1F8kgt5bof8sBA==
X-Received: by 2002:a05:6122:551:b0:559:61bb:18f1 with SMTP id 71dfb90a1353d-559769b87e8mr327879e0c.7.1762196524587;
        Mon, 03 Nov 2025 11:02:04 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:02:04 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 03 Nov 2025 14:01:44 -0500
Subject: [PATCH 1/5] platform/x86: alienware-wmi-wmax: Fix "Alienware m16
 R1 AMD" quirk order
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-family-supp-v1-1-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Cihan Ozakca <cozakca@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=hvfee8sXKcTq7gEJakAvwck8wU8l+Scz9c49QRFo9dw=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf5S28Il3hv/TP5TadvN5SPeVn877Np2Za/zzem5R2
 12fFImwjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIvmcMf4Ufu3fP1WvxPRA8
 QTu7e/5XHtU7ef9jC5ulhRdIPxP6/JLhn3pQnfI77szojls/WjY+/8Dk8ehcYYru1Z4Tupae/5Z
 UMwAA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Quirks are matched using dmi_first_match(), therefore move the
"Alienware m16 R1 AMD" entry above other m16 entries.

Reported-by: Cihan Ozakca <cozakca@outlook.com>
Fixes: e2468dc70074 ("Revert "platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1"")
Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index f417dcc9af35..53f476604269 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -121,14 +121,6 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
-	{
-		.ident = "Alienware m16 R1",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1"),
-		},
-		.driver_data = &g_series_quirks,
-	},
 	{
 		.ident = "Alienware m16 R1 AMD",
 		.matches = {
@@ -137,6 +129,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
+	{
+		.ident = "Alienware m16 R1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Alienware m16 R2",
 		.matches = {

-- 
2.51.2


