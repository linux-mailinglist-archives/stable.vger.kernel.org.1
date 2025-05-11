Return-Path: <stable+bounces-143088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24AAB276C
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A641F3AC138
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262931A5B85;
	Sun, 11 May 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcAA8xUC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7118DF86;
	Sun, 11 May 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746954412; cv=none; b=ThSeo/uAVJ3XFKmrsrh214DUcWLBX5/C+bg+bH5R858enD5QklLjCm8MkWbWj0hNexzOOsZhhECVuWs3e8dlaE1m/NSwpEJIZNMCJoYjUIEhaoyoi/OXiEFXX4pMgCTEclOdxDKKWvC/Yn2/dczuz7Va2yRxOgskE0jUSx1AhTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746954412; c=relaxed/simple;
	bh=ExMotRCy4nVraExxzurjrmt7fEMjU12YNaqJHoOLUa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkSesLoCU++PW58s4/1GvBwYkvkzmrLwJxKX6NY/RqfwtcNf00OAvfqRURnUZDZ1ONSF8FL92LuHnCrvu1xaAiAS1i5/bgEzCPJLRx8g3M19T5S+KFYYrLSSG1etoBvekzLiK+D/ltqQ9tfeqKn8xuVo88JFE+umDvUvX+r6C8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcAA8xUC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso23747755e9.0;
        Sun, 11 May 2025 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746954409; x=1747559209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbaH4y/1rTcRlURo/BeZ1x9PF6y8qt1yTcz5WxSietc=;
        b=UcAA8xUCeKHCeZtYYM/mloYq0r5ei1Oofm8w1TSXaEwFD87gvK8A0MFXLnnkhG9/8X
         Sr09NIm818U5zkY4yE9kegQSF8CxtT1tXypL6DquUssZHpCQwtclK51iEsttjoJ9frRM
         A75WKMMSA9aUGH9sZurHfHsC9N7zFdYF87a5sPUso1lzUrJxGIp8d3tPuAmGAjhewf9K
         Na3Xpu/7WESMGaVs7B8MQdXk3MY9JgChKGyCRVUjAwl/3bNRt1qpdT9N5nEOoPxko68f
         WFj6LdKT05EQbot9VLhK6Lh8Oy0bkdeUtaDLhmN6bnadH6ZwXkOHZ22OVgACCg6uFD7b
         jCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746954409; x=1747559209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbaH4y/1rTcRlURo/BeZ1x9PF6y8qt1yTcz5WxSietc=;
        b=r71YMo5hc1BCt390Lhc0G/CrLZFKLyohQwvDRAliMJjUYMxGXUdwzw2IhvRr+VgSGi
         S8od0U9Tsc/Y6KK3eINwDD7CXNV5j1FZ4I375h5yrvpKYeLP+AkPsY+UySbkbHcQfeci
         LuKORJSWzvqWOfOk8/NMUVSCTdjG6XkVvFGGjWnG4EH10nMNtQ+6/+AuXxfoVvPgEszT
         nDZMcc13z5pX39YGbtgbA/M5oRdtsZaI4kdlRMUHl0/OSfmpLwx9PbPoO4o7TMoi4uu/
         oaiRLp0Io6G4Z1qfLbN8MDzmWfxOmi05zx7VCM/4w5O0VNQ1hZdaW9D7DLn9umXBVtph
         FvNA==
X-Forwarded-Encrypted: i=1; AJvYcCUKTRwgTR4EJwNrvJs13jMY3gqFwB2y7RWBdRH2aSNfOfrEHtnKHR/9bjyyTbeRZdeO7yJqhu7JiiSUqL4=@vger.kernel.org, AJvYcCWEoIO1IUzB/WhdScKJU50fB2zkR8mX4jSWWJn/HFnLM2n7/97lGXUhmKVa8/ccAVUoXiBvtMWi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dqysqGOID+qF5C46WpzfIe6uQBcw1MxjR06mCRuSalISmVa7
	59xD80oO8b5G10hWTr2CyCtybEFiSxrojZxKeVeESdPnVkh5Duhj
X-Gm-Gg: ASbGncsj9EnXgnGBZt/Scesg/yGg7ZiWpBXOVLVxbxOkPhpNvJGLVWJOSWCJ6hYuzi0
	eiXXgM1nNLbFu7RZ9T+Hstt3C0YzzWNuiytdzGNsVuN2X7x6WFHLhVS4503Sk1bnNDGv1qOpvKu
	IhJrBYdTPcjan14GcAOHzckYRxQBZTR49eWrKOsWlU4nmranPcVnI5qj2fKDVAvOfvrHSMlOrjt
	h8gRAw7oA42Uj6S+oDjx6BXfndlz+ZK2MMi/mXPBIZM19DK2EORUUm0WOa9vyFVQZ+T3B9tpG/F
	rUZ+Dy32cnFywfPf4+kaNRgAkj0J4yhWsgkcO4sDcr/aYwX8nKZZgCxgUM0UTGI5MYT6F3ndgis
	0Hfh+9lPgulytcxWicHJM
X-Google-Smtp-Source: AGHT+IFElRoaAmVj+C4yHdrJOpH4ai6Mw0b7qh+nhLaqXHyIAZ4Ia9CP33KyyUP3gLKsWjLKzLyWIg==
X-Received: by 2002:a05:600c:8708:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-442d6ddeb99mr92730575e9.31.1746954409190;
        Sun, 11 May 2025 02:06:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442cd32f2a8sm127794645e9.14.2025.05.11.02.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 02:06:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [net PATCH] net: phy: aquantia: fix wrong GENMASK define for LED_PROV_ACT_STRETCH
Date: Sun, 11 May 2025 11:06:17 +0200
Message-ID: <20250511090619.3453606-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In defining VEND1_GLOBAL_LED_PROV_ACT_STRETCH there was a typo where the
GENMASK definition was swapped.

Fix it to prevent any kind of misconfiguration if ever this define will
be used in the future.

Cc: <stable@vger.kernel.org>
Fixes: 61578f679378 ("net: phy: aquantia: add support for PHY LEDs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/aquantia/aquantia.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 0c78bfabace5..e2bb66a21589 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -76,7 +76,7 @@
 #define VEND1_GLOBAL_LED_PROV_LINK100		BIT(5)
 #define VEND1_GLOBAL_LED_PROV_RX_ACT		BIT(3)
 #define VEND1_GLOBAL_LED_PROV_TX_ACT		BIT(2)
-#define VEND1_GLOBAL_LED_PROV_ACT_STRETCH	GENMASK(0, 1)
+#define VEND1_GLOBAL_LED_PROV_ACT_STRETCH	GENMASK(1, 0)
 
 #define VEND1_GLOBAL_LED_PROV_LINK_MASK		(VEND1_GLOBAL_LED_PROV_LINK100 | \
 						 VEND1_GLOBAL_LED_PROV_LINK1000 | \
-- 
2.48.1


