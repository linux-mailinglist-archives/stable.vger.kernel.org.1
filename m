Return-Path: <stable+bounces-132263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFBDA86044
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE77AFAF8
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FEB1FBEA6;
	Fri, 11 Apr 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhBgBel2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A11F8BBD;
	Fri, 11 Apr 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380935; cv=none; b=ArrcMlcjw6vU5Twcs74lY3tAVXNUwiBEnWZZ8sOsiySwr/xg7cBzvaCsK2tx3F/YUmGuy3hxILpn0owpA+vN7+N4s8V9RpHkxzGUUFbzY658wpozciKYmRePKnCflfwqc0mDk4nftshLK9rRLfgjft+YJ17SugUgSjdJNDnUWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380935; c=relaxed/simple;
	bh=Oh6U9/8vWzalKUh9y0isy++XZ4EmqSNgNeYBlVBTepY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMoXMx7/7PxvDwxwefHPiZrsU2VU5enx0dcz8Xi3SVjrfUJeQKgWR68OFjKicmZFK3638DGWXw+NlfvBolv2DcMysSIdQMXDpUP18kgo+2CEKPFWL5nTmu4nQz0aXWBDXyqq78L/PajYIJTdPukBoHUMUqPTbXSD3066nFEfUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhBgBel2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7399838db7fso2048126b3a.0;
        Fri, 11 Apr 2025 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744380934; x=1744985734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8ZWpaaoL0rpCV5zM+76p6yH0fnIHdpxWJLBhCTwKfU=;
        b=dhBgBel2X6Yc+pSDXJnFpXUO+wZ0xi3AzZkw+BuSJG2Y9ng/G6vjkB8I5ya77/3pVN
         D0HO+Be3Ui0cRHH7RFQ9P8FMsh6vC5KiohtVlK16dDKXSbp8o0o5WZ7nSpzo1dKhNVdY
         gDKa72xPthYEOWTWvABym86IrURgkLSJhGZBgVuWY5kBsyFdPkTTn4/VBlvJ9Flvb2wm
         zCZTfFis9Q/W+/FlOFlO31N2gCVbo9/9S7doN2RCnNeliVaow7ZwZ3ydb1PdaSEmqpWQ
         urw/KU0f9NHXRUmh7cZAVW+LXANv2nYWoL6EzBE7fDLh7iCLeit+b7uTvFRpOthh1QHd
         Zqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380934; x=1744985734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8ZWpaaoL0rpCV5zM+76p6yH0fnIHdpxWJLBhCTwKfU=;
        b=fDz56byd/KvRPUIDgvnscvQfVNUtMaREi8E5/Mk4HXkuTwOlZCSs//y0p7sx/JthP8
         qER2fBKqH5doJXD7/IAt0UjCT6Gl2qInnY3kuiJ3Sm3N0+eCkWGqfdt7fYT/J9Vqq5eh
         pksB0JL67M7Eb7qbV/Aglge4Fd7w8pDunehinlG7zneQ2trq1Yh4y/zbVhd3e2KYdFc7
         2XLukbj3GadXLZ7Tqy8SJlA+X29EizQ03aHa5ZiPB/PbEgIsyqhCMG1aetJShDR+cAQ7
         Okxi1GemooVHzbjIQy7YlDkOwOGEtGxLLkPkCv5DIDtYRW+vtrWfPhGL816dGnHcg62H
         S1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKY6ktp5wASupL3rCLcgFaQk1i7sbLgTJUtx4jLWgaiCkNSh/M3xHHX1GtSkpPVEDkBOaVNVgU@vger.kernel.org, AJvYcCV7IuBCJaRf+9n446Oy/HrhbwCMd5dqlJ2NRiMbiMG/2U8BsRGJnklRVjSEhcNrb9bXt+/bP54nUEzEPpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSKjycc35GL52X0+2Ef9j7jxEHoJpFwA+FDen4H3eTHPddB8d
	3uJVhVohKCez9qdJYHP+DpAL3RKRodfx1pdiioCpKncEZWGLPziu
X-Gm-Gg: ASbGnctPG3RusgcmCKET5TmC9sZKeOfqxzk1ta5Y8m/b1pLuURP2sSgTk0H77xJKe/H
	f5nkKYnWl6uHlHibXIebYiVB34kULGsyYHM5DhPDvpCBawjrSxcnSaeDVR+euIa4h8VWvzUPhuz
	rUl8KA2kGjXlAGYhVscaMJd6B4R9LGyFfQIdbGIrGsMudq8NjlFFFpNASLF729MYercnvCZJq2u
	PeLff0JJKHUBonCj3HzPL5CUNgbSQnKlNTQkqRzMAL9etGN48a9CWICHFAIGJ8fd14g1sW01Wtl
	h74Zej5BehnAkZGeaTsKf3uEPAIMwurUreILkIy5
X-Google-Smtp-Source: AGHT+IGqjI7b4qJLsnr8D5Igjr103VAfd9kQUdc1ZbI+EdPXcUbGHC8HtKN8lgIpPjOO86kH+w/aag==
X-Received: by 2002:a05:6a00:240c:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-73bd0c23fa5mr4368004b3a.5.1744380933679;
        Fri, 11 Apr 2025 07:15:33 -0700 (PDT)
Received: from [192.168.1.26] ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c4e69sm1575899b3a.53.2025.04.11.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:15:33 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 11 Apr 2025 11:14:36 -0300
Subject: [PATCH 2/2] platform/x86: alienware-wmi-wmax: Extend support to
 more laptops
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-awcc-support-v1-2-09a130ec4560@gmail.com>
References: <20250411-awcc-support-v1-0-09a130ec4560@gmail.com>
In-Reply-To: <20250411-awcc-support-v1-0-09a130ec4560@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Extend thermal control support to:

 - Alienware Area-51m R2
 - Alienware m16 R1
 - Alienware m16 R2
 - Dell G16 7630
 - Dell G5 5505 SE

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 5b6a0c866be220aacef795491d4f64d575740e20..0c3be03385f899b1b1f678a9d111eb610cedda0a 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -61,6 +61,22 @@ static struct awcc_quirks generic_quirks = {
 static struct awcc_quirks empty_quirks;
 
 static const struct dmi_system_id awcc_dmi_table[] __initconst = {
+	{
+		.ident = "Alienware Area-51m R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware Area-51m R2"),
+		},
+		.driver_data = &generic_quirks,
+	},
+	{
+		.ident = "Alienware m16 R1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Alienware m16 R1 AMD",
 		.matches = {
@@ -69,6 +85,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Alienware m16 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R2"),
+		},
+		.driver_data = &generic_quirks,
+	},
 	{
 		.ident = "Alienware m17 R5",
 		.matches = {
@@ -93,6 +117,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
+	{
+		.ident = "Alienware x15 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R2"),
+		},
+		.driver_data = &generic_quirks,
+	},
 	{
 		.ident = "Alienware x17 R2",
 		.matches = {
@@ -125,6 +157,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Dell Inc. G16 7630",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G16 7630"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Dell Inc. G3 3500",
 		.matches = {
@@ -149,6 +189,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Dell Inc. G5 5505",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G5 5505"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 };
 
 enum WMAX_THERMAL_INFORMATION_OPERATIONS {

-- 
2.49.0


