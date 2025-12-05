Return-Path: <stable+bounces-200190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90ACA8F58
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 19:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43C6D303886F
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F036479E;
	Fri,  5 Dec 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUyhvI59"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80054364771
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960650; cv=none; b=RMpmuWN+4afFhgVbP4yl28wMEskwa5hl8xuZoQhcYbNwDRm4x+fe1JdxxPgJpVazaxuJGt04wm/UgzVMEaYGTIWTiu+cGt6zxbLjfUdGu5ERKRpusrwLEN74scxbavLgDqFSkXm2nDUncODQ2xft7oAJfnz/IWxseqnXfa53M5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960650; c=relaxed/simple;
	bh=imTl+fYR7wmHW3q5go+m1SIRr7DeAZJpMv0X/PMlExY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAtlkBnZYxACc2j0SPQ6CZMh3wx0rSZgGdcym8ODXVL04mUY12A3FpX1DVZNYRfFTqFHvg8g2W0FzEzL3KW2qH2+vh34tSLpUiqXTNWz2VVPdDOKmIevLyv/l9xQ5vC99Qgx4zgNKDydTU+vYsnwOGi1HK+GpgXzzq3jyZEy9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUyhvI59; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63f996d4e1aso2785602d50.0
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764960647; x=1765565447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQfjZT7hVjg/85ZYWWQWD1RSKOBJZiM/njkF1tgTNp4=;
        b=BUyhvI59yh+yIUi9TOFZPy2Rf4NpuMGncapqCxLGOkPRGem4w5iU9H1O+eBRVCE+jR
         KRFQ7AVDpj3bpSiThszFSwTHUlAOMIQCCj1O37mygo4MG/4W3EQ9DYg1N7TTFqL+ujda
         s7euPCJLZdVNwORc1iADK75Sc99lPAB8xC+HvANTccOBdyNpaJaQpBVEEGR9LrErshAs
         9nz8d1vCKa5+Z9au+zJufHgFq9RneiWA+6vO869+MKnuZSEdfnAW1GJXpaJY+eUPS6t/
         f/P9yUpxqcQPdVexai9mWxCIgv9/iUV+Bs9Dt60AE8zC5ebQEepweEnwyvYQJx+kZL8X
         4o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764960647; x=1765565447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NQfjZT7hVjg/85ZYWWQWD1RSKOBJZiM/njkF1tgTNp4=;
        b=uBPraKr2fIMMNKUPejX+3a5YZrZ86XMg6E890z5lgIP/rWACY+9ySQElP5yYhwboZM
         mGVBoVfjWKeNKhCeuui1Rleh8O25GGIAQ97MV330+TZA8ZkojkIyZ4wmUK/9ZaqYC1Hb
         oN2zEi1M02wYuyKXEScxrdsiRXOX+58NZLGnQpzbasUNk0XOU2mgX3z9DGUDxplvIKYf
         7LAllZl33ofW1HZMpNaTP+sBzBqW3I4+Srpz8Zr0z77HKeHPpVECyWEvZM64tM7a5RrI
         Xr1tkpdbUf/Oo4+ndrYL23riCtEyga9nit0/Y6bpNmLZRxz7uNFqm56XBzxV1e5dCk9D
         MG/g==
X-Forwarded-Encrypted: i=1; AJvYcCULJfgFtKPjSiz3gneRoyGO07/6j4uwmcDmrkBLG2OoWetIADGnn43ESKglVBOdYZeQebEJeDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqD0eKgmFZg4TnOQAeo5kXa8LUsGFjUTTOLcrlt5lX3sJtsnRM
	venkBYpKF0pEk6t3lU4gNm5rbfxeUMDFVTXwgCl6uMK0LQ8cdrvqBErQ
X-Gm-Gg: ASbGncv0vagTOwzs1UrveFDTIjz7evY7o5ieS3QaDytOcRUSB2kG4LqGwQirx+mXrSk
	PFLSvl617iEuLj0UZY1wAIGEZRKp5dibQxCoOrP7kZXUlV/mrI46JsEQ9l0lJn84GFy3D3GpLeU
	RTxPHGen/H3g+CqyEW8tiroVLughX6xyOWhQ8tN+MHCvs9IoAgnr5ctxGb1FFiogdJkqajcUMbI
	TavMnLMBy7xyWpDelWaCQPF0eVkPBvHIEhpW53hKah3G+bQaGV+pzN3p4bhsB8uumgcmrnAKChL
	bHQgU1lQ97Jl/yXT0ml4n45QV8BHVxmyn7w8NnNoLPQxs/98/gO7BtpMhegJ0R3uO8fFFMWAr0R
	iixJG0IIzN2OYu8D1/tACtKy6rFqnNGxcsgvxp//2+aeT3QBDOImZOh4C9L4xAT4DZMEmK2nV7x
	lAmlmj619/s+lM
X-Google-Smtp-Source: AGHT+IEPliYwiX/DRTmJXV2njV5vxO4ybaXR9NFasvDgVyAUKKQQy4c7fR+5+GIz4Oj0Zb+ZHq3iUA==
X-Received: by 2002:a05:690e:1904:b0:640:dd53:71aa with SMTP id 956f58d0204a3-644370403ddmr8803178d50.46.1764960646879;
        Fri, 05 Dec 2025 10:50:46 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c2f0aaf83sm4586407b3.32.2025.12.05.10.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:50:46 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 05 Dec 2025 13:50:12 -0500
Subject: [PATCH 3/3] platform/x86: alienware-wmi-wmax: Add support for
 Alienware 16X Aurora
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-area-51-v1-3-d2cb13530851@gmail.com>
References: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
In-Reply-To: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=imTl+fYR7wmHW3q5go+m1SIRr7DeAZJpMv0X/PMlExY=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnGmo2qJu3sgnv3z6jzDjnyVP2jWoVnXmLenfkztwguW
 979ycWyo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACby9BrDHx7eC5tPz02PXLnx
 4Y0Dtgq5rNpSryo58w8GSfJu79g17S/D/4qW5mrzrXVLC05dCb3Bu6BW5L7VlLiANXssWoP+Mv3
 IZgYA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add AWCC support for Alienware 16X Aurora laptops.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index baea397e0530..01af6dde9057 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -97,6 +97,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Alienware 16X Aurora",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware 16X Aurora"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Alienware 18 Area-51",
 		.matches = {

-- 
2.52.0


