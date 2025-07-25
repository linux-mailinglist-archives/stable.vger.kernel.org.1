Return-Path: <stable+bounces-164728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D6B11CE4
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961891C838F7
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92BF2E6103;
	Fri, 25 Jul 2025 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb2l/6Y4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A32E5B05;
	Fri, 25 Jul 2025 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440793; cv=none; b=b7dsG4yqllC54Ehva4m9Ws0JP/mR9rlTpyx0g5bNURLBLkP3IKRQZmXZs2pwGDz/9+TdjLfC+OOu9aa78flLF6Rbo7dV3HjBwQS5TPNz/aFXM7IrkfKesBeIWNRzkGuTh25w8fimLN37k9rIpytE1KgVhLjGRJt5pdpffobA8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440793; c=relaxed/simple;
	bh=AkDPjTWw4oftIKLynwqKlLifD+pOI1GyGP+idxfShEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gj8AoGtyQlR6Fj6+5SEZav5U49UzyQvFE2kD7wNx/XHwU1k16v04bUl1geMU7u1fEnHMwghHOC8skjGCqICTDZN0BrgJ0e2OggRRa/1YTCdK+DZ/l9JciJOWRaydCBLCcaF2glpidbr80wB5sYS2yai4mnR41UUHCw+MweT2uXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb2l/6Y4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so1664168a91.3;
        Fri, 25 Jul 2025 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753440791; x=1754045591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7QYIPDtolCU+nVsXELbdk8ThwQMAKoMpVAkJRXKgso=;
        b=jb2l/6Y456f8OmIKr/s3kIXP2J68K8vVbJ6Zut2VG0takVHiTOIPST+hLw7ka7GKBN
         P9wcbIeJE9dM+NuAsYH8WbBKLZXOS3C5FPp2ZXlmWriIh43vOS19/nkDWMyGvAwa+g7O
         bXVijq43gKRdPe8UWKg8ZJpFvzUmw/tCYnYEkn5ewoQ70fyl40E/2DfEQ6pvHAIcdUx2
         TtqiBnr85K8fAHLzgsGZubIJFgjgYHKYLYx/OHxOMN21JjpLuT6YyYrLBg/Zl0r5e1ou
         37M2yFcdQjmYzePsrtEmwPSK0z5xnnz1H9YTkl2uS2OqdXI1fpSobvK9i10QatWIIKWB
         1uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753440791; x=1754045591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7QYIPDtolCU+nVsXELbdk8ThwQMAKoMpVAkJRXKgso=;
        b=rDXt8GJqaRtEnOjBDqhUQDeFaWEnf+DG8wNHeiWCbwOniUcjkxhwXcGspZjNHvK1mt
         bmtYNPWCxEt+vIPMDmZo9V1fetcR5a/hVnpJiYIzt/gVfMfkhu/FFdAi5YQbkuJNvNzq
         2LS/Zd7NSAOZtu7huwADsyUeLfA0iQT4q/iSxPBkx72eZ1b9fxBQWE9ht6sbCmHZaLvi
         4vurmTnmUO8l/3lNrGzdNWrZFrFGn8pp+e6st1dR+AHRJSQEDvx1B6wcjgjU4oGE97bS
         IVOAdwoFtt9jKRZzTlY1LGfkJJFaMcXY5msYSk2yE8jgBjf3AE8KgjzFu/3s0Rk4dYZu
         frnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzt6tRq2HUBP0riWt5QJOwSWtV+F7EQeu8G588ygn7AZMnOSJ+jHfJMFbnDQ974dry8t+WmDXd@vger.kernel.org, AJvYcCXMCpQOCb23Fv0gGHMtxgu6doj4Xc4DkohYJS/WmoiC9NrwCe+X+BIfIKsunZaPNpFBaNMGoyZv81I2IT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLWPX0ejTyAcQ26Lmi+95+G9rVY4Vjs4Zudw4OF4lb/ruMkiS
	Rel8bZ9HwEAIXF61v7scxppNFY2jvDBzYQQ8MxZeWGTxxkAY0mUsVGIe
X-Gm-Gg: ASbGnctMOHoYIxEWj+bR9bmU15rcFFhJEW+16kPIwned3+9BCkW+z3ajcf2yXPUct8F
	oVPcmv4W8yvnCFocqiFhq/5GGVHQZtUCFzBqAz2gD17P6xz1+YInPF4dUWnsi2j0UMtftNPI0RZ
	sQYxqbAztOwvrqMZeRYM0cjdK/92qwKmZ1w6xznYNnXFmfS832ispOccBkdYnxyPS3qnzabmd9d
	miL5zzDDwkgxWjYEpioXomDBuGxTWoNuXaIKUQuycz7aoLHHuibx6muPcg7NaVMxzNb3Bmvsk87
	nTyHaaVGf8g676fe5jSG1FyLe7CjTx2I1TUka8aQ73ItIxWGi9CuBLJgAIoR/Fv88tffMTguhML
	LmHaT94JLdycUTAISYIJSgncqZodpAQ==
X-Google-Smtp-Source: AGHT+IEpHL1qE0xk/xatskc3co+V67EgykF7KXA0D3//QTbOZNlpUu0miMMgonp92WgGBSk8F5MEyA==
X-Received: by 2002:a17:90b:5804:b0:311:f99e:7f4e with SMTP id 98e67ed59e1d1-31e779fa061mr2070051a91.16.1753440791087;
        Fri, 25 Jul 2025 03:53:11 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:ea7a:c5ba:93df:8ba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6628c603sm3307314a91.14.2025.07.25.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:53:10 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	stable@vger.kernel.org
Subject: [PATCH V2 2/2] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
Date: Fri, 25 Jul 2025 18:52:56 +0800
Message-ID: <20250725105257.59145-3-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725105257.59145-1-victorshihgli@gmail.com>
References: <20250725105257.59145-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Also rename the gli_set_gl9763e() to gl9763e_hw_setting() for consistency.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-gli.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 98ee3191b02f..7165dde9b6b8 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1753,7 +1753,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	return ret;
 }
 
-static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
+static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
 	u32 value;
@@ -1782,6 +1782,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	sdhci_gli_mask_replay_timer_timeout(pdev);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
@@ -1925,7 +1928,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
-	gli_set_gl9763e(slot);
+	gl9763e_hw_setting(slot);
 	sdhci_enable_v4_mode(host);
 
 	return 0;
-- 
2.43.0


