Return-Path: <stable+bounces-160337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65FAFABD0
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 08:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF3C3A58AD
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD5272811;
	Mon,  7 Jul 2025 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awVtSv8z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075B136358;
	Mon,  7 Jul 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869473; cv=none; b=uz6yjdKTDG6mwvsmOzwdzHu5Z+kWqFTTUBvbbpmwTQrQ6MlGQQ2Dk6ORtl5NoBxE1UxwyIK/tX9uHzPmLYOnRRJF0s3i4bC32rFrYb1t8jQLmf8T7Pqzq4uXeiFrXjRdiMYpuGlao7ln0Zy4YZjW5C8OXnZ6+GD4ls44ubLGjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869473; c=relaxed/simple;
	bh=KneRpDaBu/OIUx1+siTGnBxOUS5aNTA+t1jCilAF5ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l0En9mxZTts0WKIhILGUmH2rboC1JdR06noERp2F4dofCoDLb8hNoU1aRrkEBwlesSFXE8yrwxiG0BFsJelAfwrehODRbc3Oe6qdYRr9ntUnuqCvaolMNT72dQ4wu9yTkNcar4Ai0Y6yWuJyRP39Czu2yRQMSp8b8t3gF7JIbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awVtSv8z; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so2196476a12.3;
        Sun, 06 Jul 2025 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751869471; x=1752474271; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBuB4dH/hzHeCKyp/uVPhDU5cvA1wkgSSiyP38ooQns=;
        b=awVtSv8z8E5am4JhsCVAZa+4ePlOiO/JqEdb8Xcz6SY78OQgxDb3/QROjzfbsJh2CA
         w5B5TtAgV+e2/kdhSBFNTIQ9xn2MTjmXmjHIm8CGte5u32Mjf81OhmAosQo6cdhpVyNk
         ZxB7dqutzboG0JEp4ZaHoQBu19RJOqTwgddNwGJ9e9T/Drg3+jGVHDLqtTGSk4irz9IP
         Hfmy41h30P06ZnbDzH5IMw0QShtqDL2FSYUktE2lAxhacaGblzDgbby0b3AwwdvLhhlV
         z872NCi5Twdtde0O94IZ/IVUZv9uTQUuEiYrf+fuBJGvP6Xc0qYsbxvFt6+GvklGxzKQ
         SUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751869471; x=1752474271;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBuB4dH/hzHeCKyp/uVPhDU5cvA1wkgSSiyP38ooQns=;
        b=TfNiC0CjYJEE6ik4U1IadSBvxouATESgyjIXi5w7VI6Ncftjuklt+oEH31QZ4dDiQ5
         dBg4hhX3eWfgNExz78y4XCqsHVe0UGpz3HKH0qdc9EcjFLKGEGYkG8gXLxKPyq/BUQov
         Myxg3sosmxLhrJ/bkCzOlT4mScZkLTGuIZrpYhA5RJl6iitGXtWus0JNW8i+BtRpfxX7
         /C+dV2IJLdREW8pSe6VUkda8XrHTfJWzuSh0sihtFsC+G4SfS/LUiBApMKGsUgJco7U7
         Gl7wT3AbnFDHkINpEj5v/9CvEZIzCi6W2b7k+ySDWsZKaO6Nx+Onm4qeuOE4zNEpRhb3
         XnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEx4L/3NvKGLpYzNH3HWzDDc6fwKL3Uq09Ww4DRmkgQ13apOHFnVnSeeOudGkV7HNYmUsL6mGc@vger.kernel.org, AJvYcCXoQr8dzroP+iLygSMg1M02tj6IluzxQ/KySBhXBieveq7ELiF2znSfVxl06MNXYQIoDMY4uJ4osU0ba+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSaERnaOYWyg+XGgt6V7fm2bfF5WVlh469EBKDmfrWFnpAWxZQ
	AN/gW5lOhT+6vRLz31bS5fZYIiI8zhUiHqltv4o+wmaP+Khjr63pI/P8
X-Gm-Gg: ASbGncti5vsBQUBgF0QVU51gRyCQNb+MRGxtYIn3Jo7mdTTtitPVO3t7takR9oW8ye/
	qQPRMBgUD0HV4g4irsKMeEVtPzAKB/ORdLW9t4U3O5T5qqEjOXyGATGBRO+5waw6o0b2iKrFc20
	UGm96ysSCx0/qRMCK9FJuekFFHe/YfttIV9sHs8divQjYswkfpRCT+mAligh758aepJdrcjFIRJ
	E1gEG+3RDUPggMR0O1oZRzuFDB3nK489xNe2BFu3/PF2LyeJmSOjBydhXqKb6CFgjWOj7dM1SbX
	PIauaGPcV4MGPdSk1J9oXRBL7gNTWTOB+mmk3aNczODJwfstUGFY17EtTOYy6A==
X-Google-Smtp-Source: AGHT+IFQhKvL2bKpZOWkiz6C0RYKXn7gvQkKPp8twCufFbRHNK21PovhQgY+6eIbkoIUgVGPCuZHFg==
X-Received: by 2002:a05:6a21:6f09:b0:216:6108:788f with SMTP id adf61e73a8af0-2260ba7221emr17717207637.35.1751869471199;
        Sun, 06 Jul 2025 23:24:31 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62dd6asm7956099a12.64.2025.07.06.23.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 23:24:30 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 07 Jul 2025 03:24:05 -0300
Subject: [PATCH] platform/x86: alienware-wmi-wmax: Fix `dmi_system_id`
 array
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-dmi-fix-v1-1-6730835d824d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAARoa2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNT3ZTcTN20zArdlDRD8zQLM0NLS1MzJaDqgqJUoDDYpOjY2loAoUl
 vzlkAAAA=
X-Change-ID: 20250705-dmi-fix-df17f8619956
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>, Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=KneRpDaBu/OIUx1+siTGnBxOUS5aNTA+t1jCilAF5ZU=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBnZGZxXHnC1rJS/95H9Lfcf+y8zXipvVtGtVsq10phiJ
 /rWnNmzo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACYSmsDI8LDY1OZu88W47AU3
 Oh5of91voW50vfjumv82jM8EF6ySns7wT1/pyPNj2qyrHj+Zt3n/h4q7f6U+rFv9Iyh1++zn4Ws
 N1jEAAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add missing empty member to `awcc_dmi_table`.

Cc: stable@vger.kernel.org
Fixes: 6d7f1b1a5db6 ("platform/x86: alienware-wmi: Split DMI table")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 20ec122a9fe0571a1ecd2ccf630615564ab30481..1c21be25dba54699b9ba21f53e3845df166396e1 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -233,6 +233,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{}
 };
 
 enum AWCC_GET_FAN_SENSORS_OPERATIONS {

---
base-commit: 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a
change-id: 20250705-dmi-fix-df17f8619956
-- 
 ~ Kurt


