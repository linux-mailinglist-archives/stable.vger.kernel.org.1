Return-Path: <stable+bounces-192277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C707C2DC8B
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 20:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6B01899242
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9D0208961;
	Mon,  3 Nov 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f07CiPsL"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD912F5A5
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196557; cv=none; b=RZINX0j94i/l5shM7tRQvTs+iSjUsHX3evGVlFPtdaDNYPbi4XD8BbmzoQBb+W2wfzRZdYBC+cftMW3XLcAlTJosOHSpd7Cfi0tRdl86oskimnMpPgLY+QPZUYhRxnqnaXNOy9xHSPl4yAE1LKSOEJIdZRhTcpj7+xwUyVPC5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196557; c=relaxed/simple;
	bh=En0VkMeE1rhng04vLBUHmQuBemFFPSrfkQh+Rs4KkmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pH4oWjQYZARl18BKRLf+nxVK144hV+tHz1Fq5jAehZaSXB2UkcHhewm+gWA9P28qbHYY3lt6NgHDMct3oqZNrK/kPb1yV8q87eDJzLfdylnAfo2g1UproC/BHo+rOFVRn60javx8FmghkyHpnPFjBLQln8KwSlu8XJ30x40ryVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f07CiPsL; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55960aa131dso552061e0c.1
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 11:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196554; x=1762801354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fPkWCp8swfwdbGWYqTdbJKnDJR2KGTgvfV0JdTw2mg=;
        b=f07CiPsLlhvw8PugbrnpDPXYtozHUfoPvJ1kEnSrZmtycXwYOYE77pQCLehu7uaKbz
         dtdgI0+LcBkIXMzPerIsWtRWHhZQPT7mIsEBj79TxUiAAjcNsl48WagXKhREV9hymEMH
         9Kjp0zngZYXL2GH+ePv6d/JOq110XxR1H1J4czskRIcqVuKM61LqHfWOuhf+ZrKuQzDI
         UVpMd3Myu6YCfFozHAayyEObs90JfEwCLvqCl57lGYxMeukZf1uuD6UUKgEe7weLFsHy
         +GKMOE/hy9oz0+O40mWohEUdZNphuntamqA2qBq1rYJ2jWfYGIigRQlT2a9DqwSb5AI8
         Hmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196554; x=1762801354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fPkWCp8swfwdbGWYqTdbJKnDJR2KGTgvfV0JdTw2mg=;
        b=MtTFSsIcQP1SXx9glhFTfjh3ppKjyGhZODv6g15lEue7uEQvd6W869D4bUFHXIhLM4
         jnh9ARq2yiCy4uWogbXjCFyaTghbF0GNL+GaRUGnnXZN/1RaaKJa1DV7PjEYN/wb3Hg4
         TZwLCWwzh71iS0W5xyd/Kfc2oxQqIbkbjr+getRWQCGykwWhcop8kbFAxzLIzsct7BV7
         Ptnf9ub53zVy8/Y2ATN4ynMgy8mK961+Od4JHIvy72l63LL1LxQ7MRMTVfyKUjFkGyRW
         RFeT+BsqoPaljI+JC23p+NEVXAB8j/+7scNV6zYKHgSZ4W6SsgDqFS+WzVo/pqGmFcGN
         tAIg==
X-Forwarded-Encrypted: i=1; AJvYcCXr6c3CEBFjrvzQnvpfP3/u8KqCp3V2bBIlO9CU+V10WLHPcS6SrQiKAZG31ce9yAbyDpam+2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlR3VF0EiUlUsTYZV+vuiAbtVetSVonqt97j/EVg4ujBfBwq7
	fd+FzmtMz1CMOvxqrG/rCjTMpUYeHQ40L3pW4AwnrHATzAPUZ78b7qaMMI5x8w==
X-Gm-Gg: ASbGncv5i+WJcYoOBLq42J5nz6wHCQsh/+9fXIwaWvam7mUgCjuNaI5XkAHww54pngd
	F4vSR3yihv0XDdLcTDw8gx1x1Rp+mCn2gBJHEiJIrJeCWjnKoNa73O0KRInD2iBXL8YPEYl2rMQ
	I+H5v12Ukd0OSNCPhwOQGq9iPXneMoaVBEoySk/tkyzkNch8sxTHyzhhZPJ70fN7Gih3hgqFaIe
	kflB/Bu1cETAavrcUJDuFenZvkjrTDftobQzJ5zATkhqkvzJmBvJOM5xCKIWjQ6xb9A5AzdnweB
	dP+Ehqb+u4FdsvsETnLtpEkQyMOKokC8+O2lXEUmy75jNJNtkhUtseXB3qff96SK34Gy69o+b8F
	dJR1Cn5xvoyB1ltbA0F2UC8JaFaXDyewhttbxE9j5oaBHnqRB3APDgTmBt0hyrsPQACuqiM+d4R
	2nRw==
X-Google-Smtp-Source: AGHT+IGv0Ms552SbiF0xYh+qZjLVNlpg4qJjDFX+UdDbb0FzhrWHb1LMmGGXktjG/NSchg1Cn7WvNw==
X-Received: by 2002:a05:6122:3c48:b0:559:6723:628c with SMTP id 71dfb90a1353d-55967236824mr1385199e0c.16.1762196528942;
        Mon, 03 Nov 2025 11:02:08 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:02:08 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 03 Nov 2025 14:01:47 -0500
Subject: [PATCH 4/5] platform/x86: alienware-wmi-wmax: Add support for the
 whole "X" family
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-family-supp-v1-4-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=En0VkMeE1rhng04vLBUHmQuBemFFPSrfkQh+Rs4KkmM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf5TmVPTPaTpoEeaU/NO6Zw/DvPWhpmcb/aSEnNrla
 z9/0bvWUcrCIMbFICumyNKesOjbo6i8t34HQu/DzGFlAhnCwMUpABPRWcTI0KNpq/5E8tnJYoao
 A3vaCnOFo72Xz2y+KMIb9Ss9+h77dUaGrd2HMw/MdS1PZwj6U1aV8eXP3LJVXBtUIgKz9z2pcVb
 lBgA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add support for the whole "Alienware X" laptop family.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 53d09978efbd..c545eca9192f 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -146,26 +146,18 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware x15 R1",
+		.ident = "Alienware x15",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15"),
 		},
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware x15 R2",
+		.ident = "Alienware x17",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R2"),
-		},
-		.driver_data = &generic_quirks,
-	},
-	{
-		.ident = "Alienware x17 R2",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x17 R2"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x17"),
 		},
 		.driver_data = &generic_quirks,
 	},

-- 
2.51.2


