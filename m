Return-Path: <stable+bounces-134721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51856A9443B
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 17:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02574189DD14
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB513B58B;
	Sat, 19 Apr 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwBVz1tY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23333EACE;
	Sat, 19 Apr 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745077541; cv=none; b=cBeWvqXmnpz1xmahZQp46Gb7mF20LaPj7NOgS41RkvhyyUHdWOI8XP0X+aqvomwOQ4ru8iTT+OGm+cPQc7WQ1xLXSUz6NQmUHWJrBeFmyxmOFcFmBHv9J5SwQuT41pibhzIGAEVyhl1vvO0Dn02WhP/0Z9uKlg3jNqXCspLlsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745077541; c=relaxed/simple;
	bh=p4g6OQ7r1ZEv3fDDupqkq/9/Gtf5y2BLkX7cFlXr1rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E2ORKpmMziDJYi6rvD37noFRmaMQZH6CSubdXTsrjUu0cTZD7/fb5AoVI0qvlAiT//tE4bu+aS8N6bVbeK1Fwcyf5XnZccITid44EfsycyNN+pTzqDD+FBEGzySgAK/2qVBhFGF1U9ls/tpJkJVSEo/T5rrWBnk5RuM0vC5v8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwBVz1tY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so1834849a12.3;
        Sat, 19 Apr 2025 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745077539; x=1745682339; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thLDpOKToi4TFh2IfpxB3qZ+YESrtDY0C44gYg2NAPc=;
        b=mwBVz1tYwxYipV9o80PTYyMZUFTzrf9//GC6u47Tw7ueDc6uVhALxZG0WLHFa5AR1g
         /7zccZoOlzl+pWNEhFNxDGYTUpNXU3VvCcgP+L6egJYslYnO4WCs+FArnYiKhj7PJydK
         Aav86tev/ZZlDpvfrM+5I3SdCsByy5Mm42+VwD2aU0Pcq72xOtQgTkRGZ8bpz0Ym5KQ/
         acE8pOQsXvXtUz8S15JLFh5W0kGEfRY1VXH643uHxg5uqTEAzb6gWNVf4JRjIRQde5Up
         m+Lamh99dfoHvq14QMqGwCFhneWmkTCNVf6qktuwHL0lg+JvnY6YKK/W7zKGg4N1aPoD
         FQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745077539; x=1745682339;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thLDpOKToi4TFh2IfpxB3qZ+YESrtDY0C44gYg2NAPc=;
        b=sJxq5gGkMsDEdXxqv9SDbi/iiQ9kcbbsVTC1i7wdGxGuUqnQb5bDwddK0HnVG2J6tw
         86G3pcPfG/xMl/WjfZSvUZyeLLL8DgzGnnUf4Zpg1m1pAnggIdo0IEFAp8/CLNuV1P6w
         5qrKs1CAMyLopywB+fgtReaLiqklwOLED9sNoAGDZCnQ7DrUb8e5S5b18o5c2hpJKiSi
         Som7hnAb2SFz3ZvwZs3tZ/4uFSIi60opwcal9wcQaQVxGrNk/MEWeVVpe7ExqWKxJS/2
         lRPVAnKtUBUjxugVbBAV5gu1reV/1BpNqacwR4Ei5lCRtJ0a4sqtoSInAlF1HMX+nCe1
         t6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRdrct45LGU7h/c4JdlPJkdl7HNwxPfAzLjNXcRsmMFV4E4P0sjDubV5j0sAoe3rhG5AdBgg2U/QQP77A=@vger.kernel.org, AJvYcCWWte8J3rEQlJo6xNbD94FeE/RAgtyIyzVgfqxgvvgCwtD7FuxEyi5NxFodWWVALaSe2n//u9+J@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9aD0OkE4D3HPeeKkfGLxKcqmh2o2i3YybMMrqKItHX/tYo1J
	krIvy55B0oRvBZ9+ECQtymyC1xHaeMYTV7r69lsg0dFq7uamM+/ldjOcrA==
X-Gm-Gg: ASbGnctLak7jPkexcN+h+tenb0FTrk2uvYyfmBDALjq9/UL7QEzK314Qwaw/e0vU7sO
	zMUfWxIZnTQJrLY52F/mnqZR5KYjXsaddgosyqxy2Owjr4FhBOygLS5poffc3pl9ODiPBjDbZHg
	dpKygr715uNpDd77Hh6zPm8NQIVVrqEZwKm2cFurCUn4CtaxUCSuBplY5UaSR7Q1MdV4cf6QQAd
	YVRyc9MZ6/MUrttNHJD+s8oEsEer7m4Wd3sdlSHJo0FLjjX/7yx2sw82zAWP9Rx0QR3B/JluCMQ
	zW5OEE8gbX1LASlCkWR11XX5Gm5AtAobrC8PuwjV
X-Google-Smtp-Source: AGHT+IGLLhGvL7K1dc2pynaHr7ypdLJ4zwH5sP8adXJEdhhC1bemDxhqTCeZvkSdihWS04yYywjNXA==
X-Received: by 2002:a17:902:f70b:b0:21f:136a:a374 with SMTP id d9443c01a7336-22c53625f2bmr96668925ad.43.1745077539161;
        Sat, 19 Apr 2025 08:45:39 -0700 (PDT)
Received: from [192.168.1.26] ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdac20sm35277475ad.2.2025.04.19.08.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:45:38 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 19 Apr 2025 12:45:29 -0300
Subject: [PATCH] platform/x86: alienware-wmi-wmax: Add support for
 Alienware m15 R7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250419-m15-r7-v1-1-18c6eaa27e25@gmail.com>
X-B4-Tracking: v=1; b=H4sIABjFA2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0ML3VxDU90ic10zw5Q0g0RjC4vk1FQloOKCotS0zAqwQdGxtbUA3rE
 N+1gAAAA=
X-Change-ID: 20250418-m15-r7-61df0a388cee
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Romain THERY <romain.thery@ik.me>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Extend thermal control support to Alienware m15 R7.

Cc: stable@vger.kernel.org
Tested-by: Romain THERY <romain.thery@ik.me>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 3f9e1e986ecf0a906ca16b85fd60e675f1885171..08b82c151e07103885dbe3354542f18776fe0b2e 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -69,6 +69,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
+	{
+		.ident = "Alienware m15 R7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R7"),
+		},
+		.driver_data = &generic_quirks,
+	},
 	{
 		.ident = "Alienware m16 R1",
 		.matches = {

---
base-commit: 4a8e04e2bdcb98d513e97b039899bda03b07bcf2
change-id: 20250418-m15-r7-61df0a388cee

Best regards,
-- 
 ~ Kurt


