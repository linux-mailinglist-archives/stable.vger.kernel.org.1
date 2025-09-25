Return-Path: <stable+bounces-181668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD75B9D534
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 05:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CD319C5C02
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 03:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA662E610F;
	Thu, 25 Sep 2025 03:40:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C392C9D
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771619; cv=none; b=aNcDqIhlwrHkoLRx29L0kaTct7Wljh1VnnR8FgIQubN4o6hf4HgthJblYU172L5og+WZrzjgBti6xKzZqz4qgw1cW4tN8g19EtEHSi0lxCjQEfByU5Z/w+ueb6b7MoNzKR7sP05e58/fkEzapEoj7I2XczJTougT5t7t/z4xcWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771619; c=relaxed/simple;
	bh=bmPJ0+VRgVJPS8VBru/tBQQdNc3lAi10Hkwzd7aKHPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOvOGDulY5L3faX4BobVHuY2ianqmEbt4MtZ4UBElzVAvmEWGn7K6uWo7J+pjxTumRhcCc23eOHWUbv7AvY4A+qEeGhYSgEKaEjCk8BjCWwVVb2obNJJ7LxS1MbXF9OAmD6QuOJjipYRCzMpGf8I7uKTeboL96VjRy+RHTVIEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trix.is-a.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trix.is-a.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b551b040930so340676a12.2
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 20:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758771617; x=1759376417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u9OrtCloJY7NJyMif7w6nU0t5/g1w1ibY80MoE4gP8=;
        b=bL4foHGGwvepDXgHqbO/lif7qOpJWH6Hp6ehCVH9TM1ZB9LN4h79QnRr+4rtElsmS0
         pYHuXr7ae7b0BFIkUIZ+RRNnqnWA/A9fYQRBJsa7O3CbprapChmpjh7YJWyTWCCmxWZE
         Ma4vc8o6ng+hCcPY3/dAsXJlHDEILdl++4hzReEJqVNpuVDjeGdF+y6YMIf5q2Cj5VpH
         YeS6VSkmHfvotzqvIKiUC8FbRskORysw3Pv5pjLuktdbkqeZ6zJOgzXPYLYIGSRCiux1
         mvxD5rNvm4WFSiiIW+K3HUiyw19khhENr8Bn9J0Pank7YtX9GzAiwGWss1QEWo37Kbxw
         OYkA==
X-Forwarded-Encrypted: i=1; AJvYcCXIrvSdmdeBCMDCcAZWQVR9g1eY8fxbafr6xPqlALgDvOKTBifD9BSHX6Uqfh/Bc6VVGllYceo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FIbbKOYBmOnbRyIzbyCEbIELZenW5oaKWSV7VgHULFUEZeGQ
	t64X/wGD3h1sJCIjZW6MHP7RR48kqHAXfcUwD3fViCyYMak2Ph+V7nJv
X-Gm-Gg: ASbGncvvylGFeMhCxWqkPOHY5Zncuczrim8VvTzpvg2W9ar+0xgDbNAFzEMeyLXf7hI
	tevchjK8UpXr/MHaC87SS7yJzpqU8x5jHbmRB/e6+27WRDkDCDcrL/SS9HEPBqGq8UGiUhZ6xhO
	EIec3uJUhM4Eeuioeq9ocHhooUDnol8cHtv6q8ZAQVpqCJAP1Y1ZjGF4u3WuKVtXXLW6I54BkpV
	zxD3SPy4DYwjCfl5SB0nG4rheDRi7U16C0D5ZAOJKCFrAUPyo8ktmjvj4mrXbqnlUYvZjkg/jaU
	mC5FaDlp6nEMnoYc0UynfJyN6BGIN0a5bAaLN3Ty2Hsqv6tOr4X0W1hM76uT2vYeB3R3aObzsiR
	Ls4eioSU5V0D7bnUkbHY+M00=
X-Google-Smtp-Source: AGHT+IF88A7rwkV3P9jdms2ijhexCc0OkBmd1/k9fgklR9TyBXPssMEOtsJr0XggJFtz8XN7KZeAmQ==
X-Received: by 2002:a17:903:234f:b0:276:76e1:2e87 with SMTP id d9443c01a7336-27ed4a4979amr18671325ad.44.1758771617403;
        Wed, 24 Sep 2025 20:40:17 -0700 (PDT)
Received: from archlinux ([2405:201:6804:217e:39f7:e9ae:d6fb:a075])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm8133595ad.112.2025.09.24.20.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:40:17 -0700 (PDT)
From: tr1x_em <admin@trix.is-a.dev>
To: platform-driver-x86@vger.kernel.org
Cc: Dell.Client.Kernel@dell.com,
	kuurtb@gmail.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tr1x_em <admin@trix.is-a.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3] platform/x86: alienware-wmi-wmax: Add AWCC support to Dell G15 5530
Date: Thu, 25 Sep 2025 09:10:03 +0530
Message-ID: <20250925034010.31414-1-admin@trix.is-a.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Makes alienware-wmi load on G15 5530 by default

Cc: stable@vger.kernel.org
Signed-off-by: Saumya <admin@trix.is-a.dev>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 31f9643a6..3b25a8283 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -209,6 +209,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Dell Inc. G15 5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5530"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Dell Inc. G16 7630",
 		.matches = {
--
2.51.0


