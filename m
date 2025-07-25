Return-Path: <stable+bounces-164727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEFFB11CE1
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 12:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C307AB660
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F62E54B4;
	Fri, 25 Jul 2025 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwlHJMns"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA822E5419;
	Fri, 25 Jul 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440790; cv=none; b=LAyHxeExYUniLVHp9UKBtHYzGDNbM5ipgX99V7ZNc2PxkE4YUaABSsvF6GFItms0VpS4FO8DXAYiUSI+I5L51htajYVTm6iQAY5s2HjEQYbVeKznsYHMem15yt/7Ua0WdEJzaP0OlvxaTQnvHZWEWK40HwAV4fs2Ug+j/imf59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440790; c=relaxed/simple;
	bh=xkevpCQJxEilUkI9clyEbKo/Sm/eWm1V1vjHWrcoPdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxj/1s2irFW1yCIZzD/FVi9u8LDZEtd9Ri/tlbWDDNSqORTooF+h+CoD0CxhRETo1S9nVFJyjeJdc8oOdkZ3eWTtl8sL55TK8rKs0gfakDhJw5nlF6gI/oV0OpmkVm4CHlgZubAj9yx0a9+/5q14+X0T8dbj4geqyDnCP35gqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwlHJMns; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23694cec0feso18841335ad.2;
        Fri, 25 Jul 2025 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753440788; x=1754045588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIldpUpOzn6qByUx91ZbXkrzIhHP7VmFSx8Hu42BlZg=;
        b=RwlHJMnsJ6j+QwqVEd/1ogOuZwXLCh867pbZ2l02oUR3VQ1cwIIWhuC/m4Hgl8yu7H
         p7XNjjQh9GlJ2CfcSfS7peVSoIK5UUjwaso8Yk4UEcwfxxsnJpwm100zsqJ/8TbM6/D+
         bgoOL2BAYwBlTu7ufxeeBx7RNNIksPNhH3Q5Y0/gPd1opYSQ9e5oBUL80ck+n94AAlMW
         KJgYCNtGu+dYPWjk8+EwZG+xMudgIAPFhe9JJ0+So5J5RZls6vPavLPL80kA9xSi84/k
         oeKWdP1CH/WnHc46zLbcKyIZkI/PRwflZOmlDl5Saf0TrQCQ9rgdPoUPlmPp7DVwiYna
         Dneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753440788; x=1754045588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIldpUpOzn6qByUx91ZbXkrzIhHP7VmFSx8Hu42BlZg=;
        b=gNLZ8dLFGV7s47tPhUW9+7KF7PLmCAulpYzGGWhJzbCHIXYrbsmkZAvdWFx1On2UPN
         XFvEH+dsktWJD9SFhpkiDwmr+S2hJ+9ba1R2C4HsnKqb5EyAk1iKnVZMIAu1sTcF5fvS
         EUzZjigSylTwdKvSHZtkhhUw3c+9bpOQTU68XlKhCbvUIMzqrqo266sz0eul1TiYzULG
         ajdqg62n4esDletKR2rTJPC+EuvGp+KGA1At/LudNsK3ddqBltQwZi+dU6vXZMBZmGLy
         bMLz66vY3J5cqTdwCe+6Bc85OQDM1l5l7MOgqW5BKqQZY6K9p4Zo9hOehtKMoCKaZFws
         zQbw==
X-Forwarded-Encrypted: i=1; AJvYcCU/UOue2gid2veu/B6vNUgrMYbAziIvVwOeydTHYEa9IrZUw9Vpqe+ywWZLFz/njNgJ3tSMDebRr8IILpQ=@vger.kernel.org, AJvYcCXhEJTlGEa/6IO0pB0RDCjuBvBPf1j/RmSWdLylWbzlZnVu1VWXDmg4p3hdCPzzxB0esPFhtbXP@vger.kernel.org
X-Gm-Message-State: AOJu0YzoWNRZrQBq7ym/4Mi5E0G+BjOqXF/ZcLJXt0cslPo7B+0eXC1x
	2frCSEjULWiJF+M0HBBqPKKpu6etuOfoK2i7/K4s3T3uSRUvKOxup5BNegxgPLuS
X-Gm-Gg: ASbGncuBI5at+gqBMJHMjd2IQOQXb2Av44NC4c9nAE4vTFUad14ck4RkRUNmTxPXg86
	yErXWYH5AXaeTdrCUyuamyCwTBnT1b40EcV01dCPjNbgpEu08+gy4Pb9AZ8bN50oG+O8NIS/QTc
	y7TdvRUFLRAQRJCjkuTcanvDHW5sPT3ylwfJym9N6nqldDYZSbiIbJNAUXlqeuHqqZ5MQenNVym
	J9dza6stvO7LQMMlW/kWWPuXNAE1McSNGa8Wry8WyUFJNxCMMeD+Hzb5ECia/zQ0DMuyVntE81O
	kx5mOEC1AD0TA4l/J30c4iGDBYG5KRnAo9f+qlJG4qdhkbSiPmO44UhdWD/yJKOqvDX4sgcijau
	est8mT+k8B5Sq1saee8ENyUmQBrABSg==
X-Google-Smtp-Source: AGHT+IEkBvhOd4l5wgSJdjDOeumLuFHFzyGe78cVHzA4eXStQF0flBdPsmIAhhfPrjp0/r1dFM0obw==
X-Received: by 2002:a17:902:cec9:b0:23f:6fc0:59b2 with SMTP id d9443c01a7336-23fb2fefdfbmr19391025ad.6.1753440787588;
        Fri, 25 Jul 2025 03:53:07 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:ea7a:c5ba:93df:8ba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6628c603sm3307314a91.14.2025.07.25.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:53:07 -0700 (PDT)
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
Subject: [PATCH V2 1/2] mmc: sdhci-pci-gli: Add a new function to simplify the code
Date: Fri, 25 Jul 2025 18:52:55 +0800
Message-ID: <20250725105257.59145-2-victorshihgli@gmail.com>
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

Add a sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code, allowing it to be re-used.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-gli.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4c2ae71770f7..98ee3191b02f 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -287,6 +287,20 @@
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
+static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *dev)
+{
+	int aer;
+	u32 value;
+
+	/* mask the replay timer timeout of AER */
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
+}
+
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
 	u32 wt_value;
@@ -607,7 +621,6 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev;
-	int aer;
 	u32 value;
 
 	pdev = slot->chip->pdev;
@@ -626,12 +639,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	pci_set_power_state(pdev, PCI_D0);
 
 	/* mask the replay timer timeout of AER */
-	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (aer) {
-		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
-		value |= PCI_ERR_COR_REP_TIMER;
-		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
-	}
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9750_wt_off(host);
 }
@@ -806,7 +814,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
-	int aer;
 	u32 value;
 
 	gl9755_wt_on(pdev);
@@ -841,12 +848,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_set_power_state(pdev, PCI_D0);
 
 	/* mask the replay timer timeout of AER */
-	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (aer) {
-		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
-		value |= PCI_ERR_COR_REP_TIMER;
-		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
-	}
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9755_wt_off(pdev);
 }
-- 
2.43.0


