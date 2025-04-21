Return-Path: <stable+bounces-134872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2810AA95500
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 19:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9183A93E3
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D51AF0AF;
	Mon, 21 Apr 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnZrPBKr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059319CD1D
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255099; cv=none; b=lEtgFjGSJQMUEvir9N60B96hBNxbNdn21iMzaBwWSQeXyOR+8a33bBflVdUdJ10miVbxZgBgcdSsyvbBxI0OTfiHvzmO5RbdbhuTixahYPsyFhx8piwqEqtYLenQxE4g2Ktu3rQ7of+lCAkWjeWKe38udBhkvC6X+2bhsalh9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255099; c=relaxed/simple;
	bh=+ULltj2zf0P14hT/oatVOGKfCLYG2jp5HY3f+tGsMaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDoY31wfhIVK64QXME8sbGrwLs+oMiLUehxbbRDCdnPIUw0MerhaVznb+CqLVcdsr9CGj04RbqSIlIgjGGlb4v+1bW6vDK8uzDZl1+tk39bbb/CgJdsSKtXw5jyYw8JJ6jQU25p1mw2SK3PqfoU2Jiv2OE15nJHhaxb8Q3FCD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnZrPBKr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b061a06f127so2823149a12.2
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745255097; x=1745859897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fU6FOk+4KCo68XSwRf4cPky0rDznBpm70sRimt703Q0=;
        b=GnZrPBKrzZLYASQCnaNc4h6tRFuOf2qmVakNuITEwLwqbUwN2tjVj5nTWL3lRNxSoF
         k0oczmDY+9Ti65j3m0TFA3JKUfblyWmOeG5LYuTkmNYiUzVahfWmh8m+fMR1L54RiHzq
         X2Qprc5c2DqmOsE6MW4eI6+sZllouoeJ3150k0S/VGhkLYLa3DKs9bLCzxpvCEx16rSU
         dna22FIqvocQL73uGzwvzv5pjwz7HKihBrMtHrRAPh3tOoHAKXqB4vBq9qsph6UlJ7z3
         OzFw/0xtHzdl6VCQhgHTUz4cz95iuTtsLafTyrbnMMxRK7/fHbbP6X5Bua0geP7WF7lj
         iR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745255097; x=1745859897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU6FOk+4KCo68XSwRf4cPky0rDznBpm70sRimt703Q0=;
        b=qHlEWDv/PVaa6AjkrnWnJKb41Jd6+SKOGWlFcvrMEc0Rpgzg7nVEe5Co8Y1RR0kjQm
         mjRTa+U5uiWOP6EhsABq20D/9T+Oqy7hQaJfFSVi3WtUaBg7E+BR7Tbg+fzLpdLBiZrn
         mlldt9AahvudcPzfSWHDvwQZYSiStAnqU0g9zd7zKWJKzzuLN1El6NakIA0hB3cczZxK
         aUkZbMlDONq+5b7zhYe3sZE0ZLHNJ4XOVXhyNPdTo1Z+MF2W609Fg8uZ0zpcjsl9zdQd
         3aP3gXB6v9RzDBhXOR2BB/F8tknfOCiMFlXZurIB54fjqq4kzIlx9p59WjyMP/oxmiff
         +x8w==
X-Gm-Message-State: AOJu0Yz4RwUp7x/A/QQoUbLfoQGDiqJ8L/XBF4fCQNTW6vO8AOvpRBL9
	Q+MSRC8noKwgY9sNV5RQI1CyvFR5nRcQz7HNfmKfjKCyt/x1cB8N0TcZWA==
X-Gm-Gg: ASbGncv69yGiv1zICDt1YPswqMUg0uf4z1wqZQCjLLBz/Q31AqESlHvdPYNSMcRf+CY
	6V0dVlWATc71z0843PgNDRjtPblzxDmPNR4pqsA7zIhhZ+IQ9dT+FpK5fsVyklrfNY02kXcdcFJ
	0Q+z16wwDlheSIYrWe9oR+D78PkOURKAEHUoZqK1go+/S5UiCyE5A+e1mi6WDG8M/xI6zaI5fDe
	VeywMU9N2vQsTG2s0KQBMk+pVvr1NeAvng1xO0FxqVcmLuIFA5RteDTnZi+Q/xOUm+Bok/RQrzt
	rzQRydBGD1jC6mo9R9cz2KR4TVtHOcBs/DLDPPzP9GbTzXBlDA==
X-Google-Smtp-Source: AGHT+IHr4LSyx9PEITIE3gH1F4CcgAwBk9KO2XN6g3G8qV0xVso2GeuBwgZiUY/Mh6xKZ1aPNu0aNA==
X-Received: by 2002:a17:90b:2704:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-3087bb2f4damr16665781a91.3.1745255096689;
        Mon, 21 Apr 2025 10:04:56 -0700 (PDT)
Received: from localhost.localdomain ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df4e12asm6858479a91.37.2025.04.21.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 10:04:56 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.14.y] platform/x86: alienware-wmi-wmax: Extend support to more laptops
Date: Mon, 21 Apr 2025 14:04:51 -0300
Message-ID: <20250421170451.11279-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042124-pumice-kebab-9d24@gregkh>
References: <2025042124-pumice-kebab-9d24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend thermal control support to:

 - Alienware Area-51m R2
 - Alienware m16 R1
 - Alienware m16 R2
 - Dell G16 7630
 - Dell G5 5505 SE

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250411-awcc-support-v1-2-09a130ec4560@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
(cherry picked from commit 202a861205905629c5f10ce0a8358623485e1ae9)
---
 drivers/platform/x86/dell/alienware-wmi.c | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index e252e0cf47ef..0c876f23053a 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -214,6 +214,15 @@ static int __init dmi_matched(const struct dmi_system_id *dmi)
 }
 
 static const struct dmi_system_id alienware_quirks[] __initconst = {
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware Area-51m R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware Area-51m R2"),
+		},
+		.driver_data = &quirk_x_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware ASM100",
@@ -241,6 +250,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_asm201,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware m16 R1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1"),
+		},
+		.driver_data = &quirk_g_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware m16 R1 AMD",
@@ -250,6 +268,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_x_series,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware m16 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R2"),
+		},
+		.driver_data = &quirk_x_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware m17 R5",
@@ -277,6 +304,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_x_series,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware x15 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R2"),
+		},
+		.driver_data = &quirk_x_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware x17 R2",
@@ -340,6 +376,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_g_series,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. G16 7630",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G16 7630"),
+		},
+		.driver_data = &quirk_g_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Dell Inc. G3 3500",
@@ -367,6 +412,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_g_series,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. G5 5505",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G5 5505"),
+		},
+		.driver_data = &quirk_g_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Dell Inc. Inspiron 5675",
-- 
2.49.0


