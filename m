Return-Path: <stable+bounces-132262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9970DA8604C
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D807C8C5992
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED651F30D1;
	Fri, 11 Apr 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPkOJi89"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415E1F583D;
	Fri, 11 Apr 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380933; cv=none; b=Uni/WBJ2Aw04NW8LnZjGNWuBRmBePAv/WSE1STCifvHmMlYptoSghNrXkTkgOAgvRZblAbmxV3Ssb4N77m+uL8RagmMclkOCdlOjmZ1JfpSCQhZcy2h5fXVVkUhZMV6/MHT/C7EVYD7G1R+Mn+2bh8U29aybuo5xx3n1bGpw+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380933; c=relaxed/simple;
	bh=+8KKOK8fVUwGAniuMVVD/fdpHhsHSCt+8cQoJI1kdtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xaw58kLwzNp/sXrQpMKPrhxppJnELXwKpumZRRnymp5SxunDUWR9MQh26VTKtshI9+HCG+3iyB6I6R2xZMpxVLulbviF2Hi8xLtKukkQWFFoJ8RAvXCPR2YnDvEmKbvjgp+RI6/LwcXSqJ/SZWt0lgWK+Qg0T9Ml3SQsn8z8Gp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPkOJi89; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b0c68092so1722210b3a.0;
        Fri, 11 Apr 2025 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744380931; x=1744985731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHiXij0eh/2NFG9Dq6eilkTFl4RymHF8n48m06ZJO/o=;
        b=lPkOJi89tvX2dRllrd+GoyOgelHhpq44O98jSeZ99N1w3DLedKwbavC+T6Zc/YjGqc
         oPMKE+hLXh6hDc8eilvPfEGMMJMel2p5yeyL0fK32R8kPrOJORMy5k+JlH9qhcdmEpxk
         7pGRFvMXhSHqisNMSYf86UbLkAZt7uDrKH4tUlRqg6IBz+IAzb2+PWox5871xIBk5o/E
         k27QIdQfM/kjbcXIU9dln4sMdHmoUT3OMkGcyc7aAGaeJ4PSB24wIfDf/yTkynL+KbvF
         k91SBLa9oNjXNAMbojTFTqrKzj/C0OizE4J/3CKdujQK5BuaWwcY2NUDKLJzoYdmE3nl
         mQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380931; x=1744985731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHiXij0eh/2NFG9Dq6eilkTFl4RymHF8n48m06ZJO/o=;
        b=DeaSxYJimPnzA96L1LioklUoykQp1NYXUU1sQeW+TULahfYZy9Plq28z+7J7bwPY6/
         BIdAP47WOoOKStQZVPRLjpFm+yXFW/NWUtJIjiVGxyctJKfsYW1vI7FbKeqXGg5IzgDH
         fAX28Bfgr/MIkwvoBpjR/GgSdBiQXOIec1BnV5kcwAOlGx0qusYLYg/X/iB5Ix7hBSMU
         ZX6o1yza52W52KKVxj4TB/pyQIijs90BCTwdKdh6TsyXMWA1cXNFKgE183BQd3AmimRb
         am2EOGZkwEVHDTznA0Rk5B0CEtD45IqmuSlUZy0KrlnEPN6k0mKtckV+JNeIRl9IWLl2
         lqgA==
X-Forwarded-Encrypted: i=1; AJvYcCWqjIKs0qDtBgpxRcMJ4lxo028BdAT2D7MhPu1d/xZXY7LhmrV6YKhs2o6kAfG59Rcsk0hun0bXzqc/0Jg=@vger.kernel.org, AJvYcCXP/kPDBCDhfibt08vs4p/ZIFXztOFgw3au7HbLq+QHUguTFV5sDqdo44etfMCkcAmDkNwjIdxu@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/8aLiiPplYoOhYa2joIeYNCQcMBn0oz8BBCLnQcYfb25MDmF
	HnYCbKoy7vu7/XJe4V/2OBusWefznwm9NmRo/HX29FKkUQ+dbR27
X-Gm-Gg: ASbGncvOpugmNiwnoWYg3Sy14lNhENIsYyY2ucphhaDEOW4FfiEhncCS/vTsfDvDv0n
	67t4Ewq1vROaAyDqd5nUraNmxNoYMe73ZssbqSNvkeuzXAEaelUTIXTDFw9d+07UMCgS7SzlMCb
	NG77U750BCZtzGkjdRYvv2bIqT7qFPBlKaCE6rsZ7lsV6j5ZF00oofpWOeppFqO+vu++pB5pAa+
	Bw2K1XU9ckvT36RL7fLB0GUCkOIg9fx9GjbXb9Ubuweq9OBrfa9pv7Dc3TShkHQ4wgxhGtkKfpg
	gUm+I0EvDmIB3fiTuEnQXeij0RVRelfrALGZ+ITG
X-Google-Smtp-Source: AGHT+IG+n9QiAq+iVCXlC4qsU3izLHrStiJfpL9Btp0ysodNA1x4lqOcn6Ckz0bR4n9doZRzGQOOww==
X-Received: by 2002:a05:6a00:2d8a:b0:736:3c6a:be02 with SMTP id d2e1a72fcca58-73bd1205c36mr3879212b3a.11.1744380931353;
        Fri, 11 Apr 2025 07:15:31 -0700 (PDT)
Received: from [192.168.1.26] ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c4e69sm1575899b3a.53.2025.04.11.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:15:31 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 11 Apr 2025 11:14:35 -0300
Subject: [PATCH 1/2] platform/x86: alienware-wmi-wmax: Add G-Mode support
 to Alienware m16 R1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-awcc-support-v1-1-09a130ec4560@gmail.com>
References: <20250411-awcc-support-v1-0-09a130ec4560@gmail.com>
In-Reply-To: <20250411-awcc-support-v1-0-09a130ec4560@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Some users report the Alienware m16 R1 models, support G-Mode. This was
manually verified by inspecting their ACPI tables.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 3d3014b5adf046c94c1ebf39a0e28a92622b40d6..5b6a0c866be220aacef795491d4f64d575740e20 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -67,7 +67,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1 AMD"),
 		},
-		.driver_data = &generic_quirks,
+		.driver_data = &g_series_quirks,
 	},
 	{
 		.ident = "Alienware m17 R5",

-- 
2.49.0


