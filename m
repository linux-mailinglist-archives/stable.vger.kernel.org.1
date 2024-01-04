Return-Path: <stable+bounces-9629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD7823BA7
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 06:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEA81C23972
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 05:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF8818AF1;
	Thu,  4 Jan 2024 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fM6Iz2rW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9E12E65
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e05abcaeso735185ad.1
        for <stable@vger.kernel.org>; Wed, 03 Jan 2024 21:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704344780; x=1704949580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H33gCbmiCN5gguVTQt+3mux0fwghJWfcdcsWeLLveeo=;
        b=fM6Iz2rWnlkCnJ2AAGjTgFN77xMNaEFKhTPkisoahrqnVBg6205GZP2A2i8Nv8B27b
         8RL3MPCDZGBwHzXdpGABKQp+EdZa59l9/b8y/YnElU+xRc9MLjCnuz0iMx+gxYog9zGP
         gvwKPvyOdxW4OjdBta2bknVLIv+MtQVVu7iVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704344780; x=1704949580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H33gCbmiCN5gguVTQt+3mux0fwghJWfcdcsWeLLveeo=;
        b=c5QYlyjKJmxF1qFpBHxEBP+v6b919+yH6q60IP9NMJgEadHYIDO2+oj1a7XO6FO9WK
         YLj2GkvIJHYHmqgKs0Lu023DfyZzbjU9nYvrIW0S/VorqLXyqgKVyRdvu1DXE+9Qj5mX
         W9QbsZPmrPDkMC7GkKUn/A4lBD7VMevlfE/XeZ5RbRKCozDxggHh+fJwCUoLE+qTHjv9
         bnuKFv2NEI6XS/ax2cYrSULU98LmR4EVEpV+dfdCavvYrmipat9PkDvdXQzczsUwMNno
         z5uHjoJyP9hDDnRaygBr5KnCOk8V8c9d771JKUgSq2ly6jYI+Tu8NNrdqdgE8fVju1UB
         mRxg==
X-Gm-Message-State: AOJu0Yyw0POABcy2x3KztiIe/u66bQ9Qhem3tmmiJC/uosxDuLy1Flv5
	INES7Fiv0S50XSXoEIn6BXT9Fn+MU98z
X-Google-Smtp-Source: AGHT+IHdQ3rBdCb3bg8w5TC+VxhXor7lM+9/LrhJpYUxzr9md3RdUBzLpNMys63LFfx/6KH3Cw146Q==
X-Received: by 2002:a17:903:1210:b0:1d4:4ae9:a23d with SMTP id l16-20020a170903121000b001d44ae9a23dmr55700plh.57.1704344779784;
        Wed, 03 Jan 2024 21:06:19 -0800 (PST)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001d3561680aasm24505803plb.82.2024.01.03.21.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 21:06:19 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Raul Rangel <rrangel@chromium.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] input/vmmouse: Fix device name copies
Date: Thu,  4 Jan 2024 00:06:05 -0500
Message-Id: <20240104050605.1773158-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127204206.3593559-1-zack@kde.org>
References: <20231127204206.3593559-1-zack@kde.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure vmmouse_data::phys can hold serio::phys (which is 32 bytes)
plus an extra string, extend it to 64.

Fixes gcc13 warnings:
drivers/input/mouse/vmmouse.c: In function ‘vmmouse_init’:
drivers/input/mouse/vmmouse.c:455:53: warning: ‘/input1’ directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
  455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
      |                                                     ^~~~~~~
drivers/input/mouse/vmmouse.c:455:9: note: ‘snprintf’ output between 8 and 39 bytes into a destination of size 32
  455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  456 |                  psmouse->ps2dev.serio->phys);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

v2: Use the exact size for the vmmouse_data::phys

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 8b8be51b4fd3 ("Input: add vmmouse driver")
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Raul Rangel <rrangel@chromium.org>
Cc: linux-input@vger.kernel.org
Cc: <stable@vger.kernel.org> # v4.1+
---
 drivers/input/mouse/vmmouse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index ea9eff7c8099..74131673e2f3 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -63,6 +63,8 @@
 #define VMMOUSE_VENDOR "VMware"
 #define VMMOUSE_NAME   "VMMouse"
 
+#define VMMOUSE_PHYS_NAME_POSTFIX_STR "/input1"
+
 /**
  * struct vmmouse_data - private data structure for the vmmouse driver
  *
@@ -72,7 +74,8 @@
  */
 struct vmmouse_data {
 	struct input_dev *abs_dev;
-	char phys[32];
+	char phys[sizeof_field(struct serio, phys) +
+		  strlen(VMMOUSE_PHYS_NAME_POSTFIX_STR)];
 	char dev_name[128];
 };
 
@@ -452,7 +455,8 @@ int vmmouse_init(struct psmouse *psmouse)
 	psmouse->private = priv;
 
 	/* Set up and register absolute device */
-	snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
+	snprintf(priv->phys, sizeof(priv->phys),
+		 "%s" VMMOUSE_PHYS_NAME_POSTFIX_STR,
 		 psmouse->ps2dev.serio->phys);
 
 	/* Mimic name setup for relative device in psmouse-base.c */
-- 
2.40.1


