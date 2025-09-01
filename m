Return-Path: <stable+bounces-176819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A1B3DEEA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6F93ABAAA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7D30C364;
	Mon,  1 Sep 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfPp6oCE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6A30C340;
	Mon,  1 Sep 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719733; cv=none; b=myawXISIxQZmIqeWE9YOgTJPh8ltdck3gBHA3lY7ql3qgEbo0JvUpQlMocC1bYcO1p4ci+xZLsMbDADDQBTHTc5sInik69R2XABlmh8PgYVfuQSOQMzKCl4EHRi9VJAEdPCAt1D7WJrb/B1HT8Te92pg33mRohtmfNZlSYcDCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719733; c=relaxed/simple;
	bh=ohQLwwvPn0VEsLSuNdmI2iuYYuo3aJYR2idTa/WzA7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnvO7XxgyMoBimUzGzF9iMXGQgzfCK1EHYz4uLdbVYyke9DFncL6iGHAeZ93oK5Gmn/oQcczewLnmG3mFE6j8DaLX+qHhDzXYPKE/i+5eO7N1Aa7uEJMPHYK7mBejL8A0S144XOvO1SMSucildXRUP6TKgqHx5CX+alE4iPqhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfPp6oCE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2487a60d649so51195805ad.2;
        Mon, 01 Sep 2025 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756719731; x=1757324531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNIN9h8cyWuApq0UbnkozeYfxMWI9Ej0AKWovtcXtK8=;
        b=mfPp6oCEmFcm58o9pzNukUvaSxNzNdzmwd1qmz9+bs3fQh7UhwgbZ8+l2JMgsSI9Wr
         V9FcuxlZ1TL+9MrORzouR+SzLzmQ6ojlo4MYTzLG8WFrkWEcHJqkRdHj7hjQICVMzOFf
         HME+K92HsxxdfGWIPzMqLwz86NBGHXfn9DSPwuX+UL4vJlAIOchL3j5LB6/03BBve5LU
         kiPY7MaNgElcdXXSegDnmuCdW6DSqkJdEPNmfvBwtyS/Tg6y+OP33NQb1mgGfWeDU6jx
         rQJq+C39uqsO1D4V8F4y6tEC3aryTZtb3Fv5FfOoZuN+ifR8pNbcuFz2wdATb9TgTMui
         YXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719731; x=1757324531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNIN9h8cyWuApq0UbnkozeYfxMWI9Ej0AKWovtcXtK8=;
        b=fS7ggBXJlrjDpo20C6fdhu4Ak0a4BSNzn1JOLWxnuhiwQzlvSrsu4DD1XT6IoXlX1O
         xXYzTfdxd37qk8ZTjIHOpWZAVCt5dZbNB2jpwj7VUmo25HGvrNuFXHnxX1VUtrB1gLvf
         L7HZ0aHWLAo5FYNCuwLCo1fRTpTYvgnMQX9y0yKZR0k80AwtdI9YPgjGSr6bag9gtoXC
         gqcbAg4To82tTdQxt5eywx8Q2kBcOfmKE1bTFfWEav+Bv0xzdEpVJpYNTACg9qV7p04B
         ewH4ttfX35WMnljSYvkeEZWIQMPHRK4VUCfXyAUuN81UNt5Z6mg2kcysYF6SRjV0d0NL
         yCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2SSMYaFfImV5iSTjL+JImnToz51paJNejkxpxvcbCo0N6wtRXouuDh/SyupeVmzJe/eRr38mpcnvbLf0=@vger.kernel.org, AJvYcCXG+NYtj0Gg2CQCTIOvUL2uVu6aEanKvrP4bxD0bYk6mnqjNiL+zhYV9TP3zlpmZV6+ZCZXdO7u@vger.kernel.org, AJvYcCXfAsobcaEiCDBhVgaIHN5SZzuiu7EYNH64mNyvV1/97ZkAw90+sVH0UDfg05MqTzEnO6D2w2p/csjm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+1F8KC2gNC0stH2JPbFwQ9vAHgg3p/Sp8jSX8YobBMwPQBIX
	mOfsS1RaQYp9AC0/3h+qe5b99zO3ofWAFxnzoCVRkBHrHls9U2WD3WDbazPx9A==
X-Gm-Gg: ASbGnct50HGiQisq1MNTF+iwTtBecCmDyJElHmex4+jNbAGB76DisqjREJVk+mj5Cut
	Yc9cLvdUKxdd5rH8ca0cBS3JknhrZ19yekfPfNSNwk4G+VJZ7Ie2DQf5Wk0zRyW1GGdPiLcXx2u
	Ur+ij21TnBCgsQ8MURGkgcMeR649wt4XGpBg2ceSSvUSKgMdE0N0q+QKiaygaE/74yEcCwIGaCQ
	UHDYVnd9yLAQpXeUZ3Kf7/RYr01p6ZNX/68f374mdn+YwnO7iViQyMcJCk1wEK3Ab+V6rff9K4v
	h6Z9v3B34Bvq2FiWSnDrLqAZAZmiEjiLggMOBwQoACJFE4akZSTVwT5hg1SLyzW2T8/X6mm1VcY
	yQpReHR8IxLt3vIHKs5BO19nEUMBKh14a0FYN4a7F7qSRcqfG9mKMdEY358BgMUGySwmSyvEmBX
	3bdwMM1fKob4Zv8OOIHk+UvpwAEJ/J
X-Google-Smtp-Source: AGHT+IH0gdsbntbjYezrx0g/78WyXO7oaxTBqLhqv4o0IUual83x7S/xcfq+SrSjkhXBZrLWkWpDCA==
X-Received: by 2002:a17:903:2cf:b0:248:9e56:e806 with SMTP id d9443c01a7336-24944870a36mr113727055ad.12.1756719731052;
        Mon, 01 Sep 2025 02:42:11 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490370298dsm100246745ad.4.2025.09.01.02.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:42:10 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	SeanHY.Chen@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	victorshihgli@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function
Date: Mon,  1 Sep 2025 17:40:46 +0800
Message-ID: <20250901094046.3903-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Fix calling incorrect sdhci_set_clock() in __sdhci_uhs2_set_ios() when the
vendor defines its own sdhci_set_clock().

Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 0efeb9d0c376..704fdc946ac3 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -295,7 +295,10 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
 
-	sdhci_set_clock(host, host->clock);
+	if (host->ops->set_clock)
+		host->ops->set_clock(host, host->clock);
+	else
+		sdhci_set_clock(host, host->clock);
 }
 
 static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
2.51.0


