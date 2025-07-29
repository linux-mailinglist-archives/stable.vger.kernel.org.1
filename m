Return-Path: <stable+bounces-165036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB505B148CA
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 08:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789907A717D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 06:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB45262FEB;
	Tue, 29 Jul 2025 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDR4PlBz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2E261393;
	Tue, 29 Jul 2025 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772302; cv=none; b=b3eiZY2wGUSDjP42vNVI9N+z7Cg8L0Te2zjpEC2uS5/L+PcMk1YumM/fBgj8EtLxe44C4YrQITfAM6Vbd0NRGv41XbKADZBm7wWA27m5S6UbKh3uhL5/8NukLYC6MTI0EicbYZyeXHpzCBci4tPYHv0F3yBQkE2EsyfsOOR4wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772302; c=relaxed/simple;
	bh=jP8hvqTeTb/fPdBa/PE2DvaHhxKzYtGOY0fdmlgxFQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzfXZ2uzUmE/cdCdGAMb2EkndLYLww+67tIPMXBPzqOReXwJyRz7be11ADJbjzZRzLrOM0IaOuQQVgfHEDSYzfodRuQ+ckillL9AdOccbspkk2ySuMjoR+A+w9njrArWoMLTv/KDA3XA5Ssv2l1BWVfZ047u/FMCxzuE+V47yG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDR4PlBz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so6566626a12.3;
        Mon, 28 Jul 2025 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772300; x=1754377100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2odShv87rFFu9rb1gXnpVlzCYlZj1jPAyxnymjfP0Yg=;
        b=ZDR4PlBzWpMakbIztWyMKyacV7wpLl7ff9GHTMC+LOeGxk8vDLWYwZ7EROKokExXEB
         0kNF1NmG+SnaaSW4CTYpzwKKRPKee+RHBFuMgyiZM2A6PFWiwJU+6186SyAwDpf7L16T
         uIsid1X9eZAcYey2zssgKf1/c4mci7HKI7eWa7rGg0EK6/1hpLon57p6UFh4T5TRk9CH
         Lid+e6DQBftBQDIopfMtm4PFgAsk5pRVQqu3bqYeMvs//+a0HuoRKHoqDfLtyBgxoMHJ
         /gAfJo0l8oaTuWk91PZQ4QYFBl/WOhIXWDCcgLvKyd4OLU01IH/ezZVS6Ft3HYzmuK4y
         nBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772301; x=1754377101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2odShv87rFFu9rb1gXnpVlzCYlZj1jPAyxnymjfP0Yg=;
        b=QbgVSMS3crdtXC6UozWU0oZpN6zJgDMZlXuvNaSqRvOa6pf6E3vgqKPz7yrs+Lg8Qx
         hrBshla+WehxCzSw6xBRzAN+oVw4ptcSpsgLD8vB8RTuyuzn7arWQKmrgVZOu8ImTEva
         4t2g0cujqYQQj1pWxqFpk9qERxPlQUDLUJ+xZfJSNyreZtYmDi1/1Ff8UUHcZIJHJeN5
         9UtvKy7rTO5+9Ikka0c0diZBUZ7xnvftD4qm8AxWSc1fe5VfloY5Dcw/PzZBFA5AWH7E
         wnZ4AcTBd0tMVO4iGyFMa5Yex7XJvwR9n0g+b6F2cUiKD2ql6/FTvVJhrq3vyVREeMNk
         QM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6mb8d/JZtSR8w+22rgMK3Z71g/wrXdk82sLyyKNSdIWD9qDJYejINAdSn3nyMXv+rBn4UC8rcItEFHQ0=@vger.kernel.org, AJvYcCX0FD5997MUURDDwkaLYIBppGDdvRisEtZxu7tZ/HWl1KwIQr9P8VrwviE3Eom1PGlRSrq10tNe@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrWXRfqG4+Eckhx3N5wsHn8r5XXuxoRfdUryMrT9PvyK6wDGB
	xK+meWiKS+ocgTdIMntINMiOrMrrw9+jVu/naZ5ns8i5vhVKcsSyXiAQ
X-Gm-Gg: ASbGncs4VsQ/+eAWk2kSW3rHxPSO+L0GfVj8KCD7kQVpn/lg3YEOmNNOTM1w6+5p+wO
	GF/3+Mc47SBMsGcabcidfCbDrfVQcf35lCZf9KSYHnDJ9OZHB0FGyMVwD4OG1QV8eyQMfe5J2vi
	bQPOQVvtROy2OhjMx3tN4MyrE71zPysINmdqB54Y1/+xFW0yHBPxXV2/jkOm6p5uLFBB8Hz5RxO
	WP3ddIUpzX+VsIrh2GTvan6mJOr4AHNrSp+u/wqgjE3RXO3bmkiGop3zPlpeen/oUlGx9He6ROh
	dM5h7Jrmp6fjv4L4VeM656On7pG9U98gfvhlGyY4M3TL5B5mGJ9Mz2mJCouNV7qzmG7tWIXaTTc
	UDtkq+sqAxsxZSJ2P+xkPs/qz06WTtg==
X-Google-Smtp-Source: AGHT+IGOZuN+HC6XYXyzNNyyOxPnR7THnHPYDdwwhXfY8x8XgHMsZNRYEtXs3OdubvfPL/HPlMyVKQ==
X-Received: by 2002:a17:90b:28c4:b0:31f:32cd:97f0 with SMTP id 98e67ed59e1d1-31f32cd9907mr1294435a91.1.1753772300583;
        Mon, 28 Jul 2025 23:58:20 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:c998:3a8e:c481:6cd7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b420df76dd8sm758066a12.19.2025.07.28.23.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:58:19 -0700 (PDT)
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
Subject: [PATCH V3 2/3] mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consistency
Date: Tue, 29 Jul 2025 14:58:05 +0800
Message-ID: <20250729065806.423902-3-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729065806.423902-1-victorshihgli@gmail.com>
References: <20250729065806.423902-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Rename the gli_set_gl9763e() to gl9763e_hw_setting() for consistency.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index f678c91f8d3e..436f0460222f 100644
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
@@ -1925,7 +1925,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
-	gli_set_gl9763e(slot);
+	gl9763e_hw_setting(slot);
 	sdhci_enable_v4_mode(host);
 
 	return 0;
-- 
2.43.0


