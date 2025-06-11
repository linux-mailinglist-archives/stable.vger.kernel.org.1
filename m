Return-Path: <stable+bounces-152479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52725AD6153
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A24174104
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE38228CA9;
	Wed, 11 Jun 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSnsuMcf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A40186A;
	Wed, 11 Jun 2025 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677450; cv=none; b=piDl+3pPCaundN3RAZu7dCm0IKrEDERgImtS+AYklNwqHdWwC3GEESGW359usixjQxkhwsQ0lO1EbNWdf5jAW7k5khU6ZLmakhf0tGZN7VSi/IJvk3aoGJ/X8qhSFmHoHYiuzaV9MlBiEczd0NSu8kx/+scgX2mkoLlTFadTupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677450; c=relaxed/simple;
	bh=QY/+VOMB3hjC1vh3UgKqUkYoH3CgOEIg2LM7M9goxTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h4cOC+1KuL5lcbkyOj3BtZdg2X8LvPqXeDtqDNCRt8odi3KcNlLpjRVo/UtVJQzjl/TfM1Rg51fHNFHvLMz+It2ibQ2fRL5XY9xWl+TGdq6pXIpdJDUvA7mhmYSFRqi263K7aRuAD5+3sxToB1c/UcufNgi4iclnzgb8TwYV7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSnsuMcf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747c2cc3419so323721b3a.2;
        Wed, 11 Jun 2025 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749677448; x=1750282248; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsnCCnxN20sfpCU7Ra0k0nlSofD440pIeWpk86OcN64=;
        b=jSnsuMcfCrS1RZWIHcV4p7EmIeCMS/S+cm43D+ubcDRbKxk5attFBcbxodjpLsAEqx
         BTAujqbri/GyonButz2oESPIAul9UOuyO6uhRFMwc342ZjkMGzN12I8KBujO/RG673GP
         I1pms3zBPxrTYdoMgAqjmJMmTVF7Lpn6uBCNRF/fdKR5CyNGSRZD9uivJ5opTZ9aSSZF
         c0tlRhY6bWiO+V4sxxH1K7J6k8qciHv+yZ0MNBc9/+jXSx0VrXvt6nMUnFJR2r2Chrgd
         DklO/fDMDfEdminI3yrGi1OykrIdkGG7gQyrswxQ+hHv3phzjOVlx49s11TQ9Dp9axTW
         nRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749677448; x=1750282248;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsnCCnxN20sfpCU7Ra0k0nlSofD440pIeWpk86OcN64=;
        b=NOP9nV4aaF1adTRJBN5xDDyPyKpEuDVZSscb2qLUpEEy5isxjtWucF8CRvlaW5eqpZ
         dr2c+rWz7FLWWtxZEdYgoeyweG48Ko7tGo5CWuuEW2JwkGb9CpBLIbvDDjVTefAW5Ljd
         v6Iqgr8fT1Df4N7iURsRfo5blhrUT657QLQw+f7km4Cvjmy2zh5rc/2w4Pd1a/Zw/Jwg
         s8bC/AMtJT9uoABRNZRRb0zWxGFxs2+flhbP/rHdibYk3I1L/k+c9IJI+Go5haBdIv5y
         BwbwZYOSrqLbWNLJZGYv/Jk5e2CHRE5RBsTwqLGaO+sgocO8U6AuxuG++YwouXxdKoL3
         qAEw==
X-Forwarded-Encrypted: i=1; AJvYcCU/JJhr6KxN5ORIghqggEDqjQ3x/VqTghBqjeipVe1YATSfJCQX7KWrUIOcDaNdJPgzmDZWaJSf@vger.kernel.org, AJvYcCWxrw9bPawVB8PepYgaOBEmge3X0/pPHPt+zrdOMX/mVhr7FhUNgQv65KCEVMKawIO+aUJUnyvEOFWn+NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHEtVkyPU1speeEt4hX0fGAL1TeUebSWB3Jl85m/Mhqt9OzkIh
	msnUPCRMoI1o4sysHDJ0a9hSEFmb1CnmdQmNFzYVnAWkWHGMtKpGttnw/eKrtTSh
X-Gm-Gg: ASbGncsa0GuiK3OWOaKLLOd0fThfY2u6LIapVfvFkngj9j5dXZq6CGzQAuvaWKcyyDb
	k9squ8xMYPwlW6BOFmwYjff1nE3KoDjq/ZilBNlgYqIJjtF9Yq6c7f9m5D7CbMDorjZu9ur6d5w
	Z2rt3eJQMUyrEbzSs3sDId+tQ2OiyyKAG7GRGLVGoUVHVOCzVdqM9nKMMHy6IFVq1F2B8CWNIYj
	wC4G+qT8h486p0MEx4o74OIG1hF62fhYAuZwFO1G8ocEzixDwrUhstTG8h4mvL7HWrQeSLELmy1
	V2gsBfe0GCxHmvyVStyM6/iLQ+jFPveSWN0x1xEpwcyV7eBrqk52h8OKQQdgog==
X-Google-Smtp-Source: AGHT+IGATYByORSgsAFit5O8cnNwbGYaHuvhIPD9to+nw2gFdfr7AgTwiNvnef3L06hk91VNfWadog==
X-Received: by 2002:a05:6a00:b45:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-7487bfe8e07mr1557216b3a.3.1749677447847;
        Wed, 11 Jun 2025 14:30:47 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74880896402sm31992b3a.49.2025.06.11.14.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:30:47 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 11 Jun 2025 18:30:40 -0300
Subject: [PATCH] Revert "platform/x86: alienware-wmi-wmax: Add G-Mode
 support to Alienware m16 R1"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-m16-rev-v1-1-72d13bad03c9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAID1SWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0ND3VxDM12gQl0LQwPLJAujlNRUYwMloOqCotS0zAqwSdGxtbUAMKP
 V4lkAAAA=
X-Change-ID: 20250611-m16-rev-8109b82dee30
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Cihan Ozakca <cozakca@outlook.com>, 
 stable@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=QY/+VOMB3hjC1vh3UgKqUkYoH3CgOEIg2LM7M9goxTg=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBmeX1tS5TbMX3dMcD7b0h3le21rSh/NPvSglsuovU+3f
 O3sn7/WdZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEbnox/BVPf/2oZcWrbdMu
 vuJ6NUHt6Ul/tyJuW4OzueILDs/S1ddh+B+7MMTkfmzab49lxVsNk9S4/Py+L2jcMek1Z7P0z5p
 7GzgB
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

This reverts commit 5ff79cabb23a2f14d2ed29e9596aec908905a0e6.

Although the Alienware m16 R1 AMD model supports G-Mode, it actually has
a lower power ceiling than plain "performance" profile, which results in
lower performance.

Reported-by: Cihan Ozakca <cozakca@outlook.com>
Cc: stable@vger.kernel.org # 6.15.x
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Hi all,

Contrary to (my) intuition, imitating Windows behavior actually results
in LOWER performance.

I was having second thoughts about this revert because users will notice
that "performance" not longer turns on the G-Mode key found in this
laptop. Some users may think this is actually a regression, but IMO
lower performance is worse.
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index c42f9228b0b255fe962b735ac96486824e83945f..20ec122a9fe0571a1ecd2ccf630615564ab30481 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -119,7 +119,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1 AMD"),
 		},
-		.driver_data = &g_series_quirks,
+		.driver_data = &generic_quirks,
 	},
 	{
 		.ident = "Alienware m16 R2",

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250611-m16-rev-8109b82dee30
-- 
 ~ Kurt


