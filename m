Return-Path: <stable+bounces-132261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD3BA86049
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A543B474E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14CE1F4E3B;
	Fri, 11 Apr 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j86PcWch"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289691F4CBC;
	Fri, 11 Apr 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380931; cv=none; b=BtYY0kQwxt/8l6TjpKwPnXB3Mv5aY8kUsJrA8K5Hi/plcqMPJBWaULKsx0JXyRb729802hinu79Oq28tgPggvjdiUNzn0Q7PTrBq1Eg9LOpwSzGwsFGpTAA0btwQGSbRdrqFNHtFI8myzeVpBP+AXYMxCyrSPbfL1H4agAJAHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380931; c=relaxed/simple;
	bh=bw+p5SNhnX6pOkgl0Ry3vJZPsdlpYeSd8CNTNZIG8aI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O2+f07V5JItnSFkGRI8GFz//ONS12z2KwvHcqShjMIWL77XWd8L6HkY3CHT/yAUcRLo7CdUIWhYD4p497ff9cPkwL9Qatl8vhMxsYkrYyTMRH6ZSELbzQ6ZwJ7wzh1Tft2sAoEQk57pRBzIP1uDj4J8T89Xtl3KpaFJpzm96V3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j86PcWch; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2243803b776so28962845ad.0;
        Fri, 11 Apr 2025 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744380929; x=1744985729; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSq0iC5oDVYO2Sr114HUoyiQ9ytidsd6EJphTwPnpOY=;
        b=j86PcWch6eh738IOzvfs1sf7EzwfCNo82viN8Qsq+0WoTCVQXLgiQbjLs1ZuaOeRZm
         izhh9qSVe3B8FXM633bA84xKS5ih4SIXPy/73EwhhdVefpLzzFTm7HYQUPsf72jnQMRN
         1QM3H+aUTgJ2sCsHmJOwMjRjCO+Cxvvy32AUakTC8trs1WxZfvKmU4FpQFsd6G8OCWwr
         B00F6+TBC5BUlSmlYkz/RtohCWV3fZhfCpx0PeQASxV3Sgrd3/DC45QHyxMstOIqNcC2
         ZyVNoFBa968TNI0k20+y15ZCGAlpQuOG0loHjb6a4NEUTumMr3WPX6MsHChK5xVhZADV
         4v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380929; x=1744985729;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSq0iC5oDVYO2Sr114HUoyiQ9ytidsd6EJphTwPnpOY=;
        b=S6SbR1mGyxaFjlRHQi4BGmnkvSyDfxus3/0R7UNgAVysIlFItHlWlcAgLGc696zR5K
         oqND49VrgRWClerme87g8NzG4IFCcZ+KbolvRjCVVFUX/mBJkTUBzSuKHqPdCpWSkBNJ
         tklLyAzlxx36619q8JS+z1RUhzncwvxYxdA+eqTyRW3Q2OBTGuLDHlaPEIS9tZRTndwR
         s1PTFJz44ej/wCWU2c1NuHtr0F4tN/BVp9m5lAL2+kHL7o4Mz3h+jOrvNwYjYiSu44/R
         farxvXFnhq+Jfhgg/aMva4ZgrYUMCKgpkLBkcCioRhy/9fwh8aubXZ8TfndtuFpb7pqb
         blog==
X-Forwarded-Encrypted: i=1; AJvYcCVM3HMm9T8W0hYfg0lu/3pci0S242baEiPlU9z40l3Dg8nO+K2neesO+0vW4GxpcBlazDr4bTC6@vger.kernel.org, AJvYcCVWo+wenMqiUh7nGrjjZOzLvGSLd8U3i38LxJTVEXfkwxGdWRBtEXvPfEmajs+f3TTUoauPWOJ6C7OE4VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsjWIg4i+tiurOnnkA1r8YxWCQlcM6wcD/S0tXen8pW7bc/02
	69cbtCNhhp+nnMI5OUhG/yqx9rtJc3vC37HeaTq1B/y+0u0AZ3sx
X-Gm-Gg: ASbGncuoQEIwTP+ILx8RQFynaw+Pt5DX/Oeh/ofYNIP9l9s84DtCS0YvMVlTVDFcNVd
	xmviWKRwKyrQ/AZKuwBmcfH95ekeYF79z85Awfi5bDhU1gXmThqBayS/iVrdaXtJC/5fMXVA3iC
	6iOc7vddm970LbzBVgTRjtTkUvMZOA50qCEs//wJ7I/TeKhvwPmOsFzMn7bQpE8JlUo/kg1Zi+4
	HsQy6YBJtO58kjy/ie0D4jH1ZcN4BU2lFdmeL5HEIWfTyqRTXr9zHxMqQ+dvcNH23Iat8zMCOnv
	THhK3ncnV1JQrlf47js4qEVr2V1LMGTO5hcuVe5w
X-Google-Smtp-Source: AGHT+IH/Xc9tf94+92Rkwg8MozsvgNOe2K98JTK8HgIrcsGLWh8rs77bvMZ/KPW7UA+oma8PtOE6zQ==
X-Received: by 2002:a17:903:1450:b0:223:6180:1bea with SMTP id d9443c01a7336-22bea4ef0b3mr43856725ad.37.1744380929022;
        Fri, 11 Apr 2025 07:15:29 -0700 (PDT)
Received: from [192.168.1.26] ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c4e69sm1575899b3a.53.2025.04.11.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:15:28 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/2] platform/x86: alienware-wmi-wmax: Extend support to
 more laptops
Date: Fri, 11 Apr 2025 11:14:34 -0300
Message-Id: <20250411-awcc-support-v1-0-09a130ec4560@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMoj+WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0ND3cTy5GTd4tKCgvyiEt0040QLQ4tUQ3MzIyMloJaCotS0zAqwcdG
 xtbUAbkaUTF4AAAA=
X-Change-ID: 20250411-awcc-support-f3a818e17622
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Hi all,

This two patches are based on the pdx86/fixes branch.

To: Hans de Goede <hdegoede@redhat.com>
To: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org
Cc: Dell.Client.Kernel@dell.com
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (2):
      platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1
      platform/x86: alienware-wmi-wmax: Extend support to more laptops

 drivers/platform/x86/dell/alienware-wmi-wmax.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
---
base-commit: d8455a63f731b4f585acc4d49fd7ad78db63b3d0
change-id: 20250411-awcc-support-f3a818e17622

Best regards,
-- 
 ~ Kurt


