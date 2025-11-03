Return-Path: <stable+bounces-192274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06709C2DC88
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 20:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD013BF8A4
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 19:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51529A307;
	Mon,  3 Nov 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqlN6c2c"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC720C001
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196531; cv=none; b=gpwJJ6L4w30y9Na+ZFmcyLxBLjhR20NuYsykzE4VRkHECbYTnZOOP8X23FiPPHibDU4NAWcFlUB5Egs7mIfXLbyLdqrINvq9cs2AUvST7gqi+YqPvHaqjdNYITDIsGdcqG8ITXhH5uS+zfV6ywMDvp4PbnCQAmgwUG0sMSVvtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196531; c=relaxed/simple;
	bh=TbqkSgZCXlTrGYhXzkeDQaBOdkWS495hC6rftFSCSLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5x6lnG77x2FVPB5RANCvcnG2RcoyIHngQ1y8DLqZsgx9D6xoFlJohXBizDrkMoyZb85CRN0oF2zWn+ykXEivEZGC4thUTya8ewFLote1UKa3zRxFnQCkXFQrJqLjO+wOZmN/5uHrJAmgWJahapepRUJ/Pqjtua8/rT/aA/2+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqlN6c2c; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-557a56aa93fso422309e0c.3
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196527; x=1762801327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+wfLlHdlrvYcCklMhkk2SxyIiTOFDFm9ntS4AcDqkw=;
        b=bqlN6c2c2z8F5g1pELtv8SzMTppUd515HsQQyRgOFVBkoub7ESSv6xWwasL4c7Wt2C
         1Zyrpmkqvfp+rKIJLwRhcmfyTRLeZKLHc0ZHthY6aGLP5pCt7fwsdzTzU4VT1+CkHI6S
         546HCAkWJldIKtdLdU5tAqdpqvqPvNYr+hFn51PvNlY162t5IAjVaiojN5E984a4RVBn
         0hgiE+0rrBAPT4PVdPskYNgU2OpMFxchQH1tsaz1gOPxAqajmduItWEwm5ekyVZwc1ZG
         CNafAJVNcxbEavJ49Mih1MDs9ixpQCHfZHHCNaOYkVEBSjuDI2z+kgUeJzlddBNZ/Lnh
         o1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196527; x=1762801327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+wfLlHdlrvYcCklMhkk2SxyIiTOFDFm9ntS4AcDqkw=;
        b=ShJbFT3u3qlgWlVLLMmVg6jdMpxwy3jBjYd1xCd6U/B2BFUv0/1XIloobRf8l6GsSc
         8ieZMCOhchA0iROhH/SzT/uO4pe4ZqGek0BCVPRB1a5Au25FvZRxdlplQLUGyp1uYl2v
         eTEisgP+GJhB6q4gJ+YOFe9gKzT0F/H7gRgslSOMRxGWwdGHcehX/SX59QFXh0DDGXZU
         9P/wfTCEMXmW05gd/MWGdw9xc/rYAcCwQyPATHSQOZ/GTfCs6BQ3GaGSUjYHCA0pHIV8
         /kzAnLqLH7lPBz8pZ//Vj9IjIFiCOqrhzob9QA84/Ww3QBx7Nt0RbuYVoBtmYp5pyRfp
         Prfw==
X-Forwarded-Encrypted: i=1; AJvYcCWLNwXOONMm0gC3eAoQhtBM+wwqavFI5ibrFCEhMBC6Cb1Oc91zrimYxK45UX0pJi7VXxouUSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/CzGCRZqjFdcBmfVrXEBjVDkuE7zrjl2jQuB27WS6fF37q5u
	lCbNlai7vEcLCYYS3zJ1Cm3belsEQ5iBm+stKSIU1pZ7nXZyc8or5ttG
X-Gm-Gg: ASbGncvvAbqc63v16TK5Iu2ypYJ2alkkUcxaSGyCLivJV5kN5zsupCdA83iQtS6S821
	iyfYeQkAFGymZ7VABeLQ5uqqq6+voVbF7fmj5l3/vUEjt/dNgY0XZVZYroaHUMcjLyib7oul3zs
	q8oFaqXQBZT19iNeg8ttSZ4qsw97VAW2sEuIRJVD2/9K9I2JwyhPhmpidiG77plrzjNKmRngGOg
	bLNujrW2BLBKrLvSJnX0WTYe7qY01O86Qzje3Zf8oPmzN7RXOlstiAU/33OHOKPXlpmJyCO3VUv
	Jl8NKdwTfeifofRDIo/O3AFE5jRJ5qm7Q4lSUuJuQi3LPOcHuHV0pvnUjkJ/4snwYSE5fkcBgFo
	hAvQkzb7GGXRzkRoidfWJlfeZG2z2QRMaaJ6+HdrkAx8f6u6Djxw120K0FgFteYdIdsg/mo/CyV
	UbMiE3Wd370eUK
X-Google-Smtp-Source: AGHT+IHQJiuKepqGQcmrBoRO1kAtF4hiBGj9Yir2z/yiL5vsrXcf+T2JYfiECUzR5VFEEv230gcPKw==
X-Received: by 2002:ac5:ccd9:0:b0:559:6e78:a43a with SMTP id 71dfb90a1353d-5596e78acf4mr721689e0c.9.1762196527510;
        Mon, 03 Nov 2025 11:02:07 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:02:06 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 03 Nov 2025 14:01:46 -0500
Subject: [PATCH 3/5] platform/x86: alienware-wmi-wmax: Add support for the
 whole "M" family
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-family-supp-v1-3-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1860; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=TbqkSgZCXlTrGYhXzkeDQaBOdkWS495hC6rftFSCSLw=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf5RmXYi5emtn9Y050fdrtpivjDUVyzimbZbIVV0ZJ
 rLwk0h7RykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEzk8B6GP5zv0i1rK9JOLLo5
 JyNj3pa1U1iPbFJurBS4nGI+/XqclDMjw8MUvvc7nEXNVzw5aKxxt6huvnphxGepqZOmXu2znr7
 gHBsA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add support for the whole "Alienware M" laptop family.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index b911921575ad..53d09978efbd 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -98,18 +98,10 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware m15 R5",
+		.ident = "Alienware m15",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R5"),
-		},
-		.driver_data = &generic_quirks,
-	},
-	{
-		.ident = "Alienware m15 R7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R7"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15"),
 		},
 		.driver_data = &generic_quirks,
 	},
@@ -138,18 +130,18 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware m17 R5",
+		.ident = "Alienware m17",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m17 R5 AMD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m17"),
 		},
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware m18 R2",
+		.ident = "Alienware m18",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m18 R2"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m18"),
 		},
 		.driver_data = &generic_quirks,
 	},

-- 
2.51.2


