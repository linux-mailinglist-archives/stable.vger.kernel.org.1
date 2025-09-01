Return-Path: <stable+bounces-176820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52BAB3DEE6
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EC017C7F1
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371F30AD00;
	Mon,  1 Sep 2025 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVXid+xa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9CF2FF177;
	Mon,  1 Sep 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719753; cv=none; b=t9w4RD20b31RF5+hlvohEgTbNHyODD4Dnr0++EPMYEoh1sj+QPThPIZG5XuXMlwfmbJXikFnEEWU6KE7WZzWttPiRnZ76dwJyXTjgoPH579CuXkFKBm1KZ9aTHOQTee4wyL+k0S03dGovk4MRkfyag7kvZJ3JHKlV2cfxnrcq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719753; c=relaxed/simple;
	bh=lsoKYNM2xF0HriYfAwewTAnvq7esfzmQsb3OCO+ah50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hE9p5MnWwnk9n1idKWBPyzlvHKPnenmR6enCrLhHxrxHYfeKnQI5Tuxcd2SQGj4m86hnYE8JNke5+jffYOEAmNq/8Jin9/uFWIUvLsrDuMFMJ9RpdD3erbvSP+suub06VtY1N0kp4omuDvFfKNO0hjXPtxle9TFc5BhuhQMiZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVXid+xa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24af8cd99ddso301735ad.0;
        Mon, 01 Sep 2025 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756719751; x=1757324551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtg4qaO/BmnHmzHk7mKlhmzZnJ0fkfnXO8RMdoHHo9g=;
        b=YVXid+xaQRbSSSMwZ0xR6PvQ1X9XlIVOSsK2Tn7WijFbUv1wk1JwWYIPRb0SAqaXjb
         Q6vXGWBGkeDWVNwWMLkOSoEx/RP6nWI15QLu5sX9BNdvrzg5g1JLVnM5Xhbrm6jN1Dh9
         z7jUn2G5oEwcVe9IWUBZMEttCl0gWGMXRqUNLNq3s5Dra1qtn8l9rDDrEYiO6Xj3oYmm
         6TpUViSYSb5LsTS6g4NyNxJuRAXcQKue56hJ+XlUYoaJur/th17gUqHSEg0MhkC3skG9
         Enrn43/5IWiUQa6DaQSPA2ezvw5spl8nZt4m/V1KwaREz4L7T6aDquyGzo/kAyvggCAb
         WTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719751; x=1757324551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wtg4qaO/BmnHmzHk7mKlhmzZnJ0fkfnXO8RMdoHHo9g=;
        b=qeI2TBdNmaY7BvzET+phYxdxZWxpYSI44/HJ8GH/JnEIeqS6NOYK+dlAtkbPhtlr9y
         /MX74NK59s0VPiPi0fPkQjVN/lWDp+sX0SbABbUPJre4QMjHIsyR4wgWHHteXBLuzagd
         Z3ptY1QVR5/UijO4vyle2QS5qZZa3ofA+73mritzyKbsoirL+9F/Z6riHVUXZpy7/G5w
         w1TeSBAytOLQoaiNWMvGSfUBdsl9v0TOXw9y/2RWOLgqrZOoMAdbLNl2KEwgFqChKDGm
         eY2wsN8gnapLaklWtH7jj4930oNaz3DCLP3M3x08uFrUcyYszDqeCUccSrjidfzXHFUU
         x9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB01eG7mr7/aBL6RKi/R2p7qZFPQnAalGgdgbxiOoBLtC+1UuPAjg9fwbD6pM+6BNU/k+M2RWpur6//NE=@vger.kernel.org, AJvYcCV5hTKXKPRKVY/KUmWbzHUXGH5AyDCqXLAIgp3hw5baLO3vfFrgPiD3UlydCKGTpQpN7DAhC3px@vger.kernel.org, AJvYcCVc6HreUMGVwgDAou5oFodez+7tT0gMpF/TB4pG3839xKuW3UTAlHkLyuOf0nX6U5nXkSifkkGc9GN4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+znpQHQM4bgjIsfBDRLuOxjgXWWyERBpT4+0tBWuPCOkbFHUK
	J3JRvo393T7VsVLRC+phOQh+rSxiO6/aUTno6fDEnSi4hcfEzjnF4bg9YvnPYg==
X-Gm-Gg: ASbGncsNDn9B+nlTHNDAjiTMvdPls3ssnMgZKqYsaQzxJRKhOP4Hf2VfBDYViQhfjrU
	ljfLP+2gCrDHbh/CTGNfsUvDLwvHayY4/BlFIPxO3fmJWCdjBGXB6iBRCL4dZ+1xF0UelpGpkIX
	ToU/O0ILf+hotJz8gqHWJDKJRgHgR17f+Mo+zGSfvqzDQmZBeBWtX2eol2kdC2RyrCnxNjNbYNR
	k4Hfld2ntrJJvOfx9WlebFlSqU14XRLIAee6NJ0MSTPrn/nf22Cxlapu8qI88ZFd9rLXQNVdJSY
	7zFjWjd828t+J9bnHzpCv0Ex/p8+fJsh0CTxV5EssjtniM5PPc9lzelDb79+Tr5rG0shsZkip6f
	wBzARLeg5Q3Gqug/f2Elamw2FD5ONShT0pjoug2JPmrLoYUHNqaatvIZ+KTJplvi8gsd29Nfxax
	5RRI5w9SYUkeIHxmr/RQijzcmpsAopimkwYB8Yay7sXFSe
X-Google-Smtp-Source: AGHT+IHtv9IgPi4S7Ihi7tMx/Z7qerqy3Pkqp5B+sT5W2YlOTUjDwgxlUSspv5YUQ2avOlmQ4+8WfA==
X-Received: by 2002:a17:903:28c:b0:246:e230:a99c with SMTP id d9443c01a7336-24944a5658bmr109671165ad.20.1756719750797;
        Mon, 01 Sep 2025 02:42:30 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (220-128-190-163.hinet-ip.hinet.net. [220.128.190.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490639682fsm99522445ad.106.2025.09.01.02.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:42:29 -0700 (PDT)
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
Subject: [PATCH 2/2] mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on
Date: Mon,  1 Sep 2025 17:42:24 +0800
Message-ID: <20250901094224.3920-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

According to the power structure of IC hardware design for UHS-II
interface, reset control and timing must be added to the initialization
process of powering on the UHS-II interface.

Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 71 +++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 3a1de477e9af..85d0d7e6169c 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -283,6 +283,8 @@
 #define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE	  0xb
 #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL	  BIT(6)
 #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE	  0x1
+#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN	BIT(13)
+#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE	BIT(14)
 
 #define GLI_MAX_TUNING_LOOP 40
 
@@ -1179,6 +1181,69 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
 	gl9767_vhs_read(pdev);
 }
 
+static void sdhci_gl9767_uhs2_phy_reset_assert(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	gl9767_vhs_write(pdev);
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
+	value |= PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
+	value &= ~PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
+	gl9767_vhs_read(pdev);
+}
+
+static void sdhci_gl9767_uhs2_phy_reset_deassert(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	gl9767_vhs_write(pdev);
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
+	value |= PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
+	value &= ~PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
+	gl9767_vhs_read(pdev);
+}
+
+static void __gl9767_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
+{
+	u8 pwr = 0;
+
+	if (mode != MMC_POWER_OFF) {
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr)
+			WARN(1, "%s: Invalid vdd %#x\n",
+			     mmc_hostname(host->mmc), vdd);
+		pwr |= SDHCI_VDD2_POWER_180;
+	}
+
+	if (host->pwr == pwr)
+		return;
+
+	host->pwr = pwr;
+
+	if (pwr == 0) {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+	} else {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		pwr |= SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		sdhci_gl9767_uhs2_phy_reset_assert(host);
+		pwr |= SDHCI_VDD2_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
+	}
+}
+
 static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
@@ -1205,6 +1270,10 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	sdhci_enable_clk(host, clk);
+
+	if (mmc_card_uhs2(host->mmc))
+		sdhci_gl9767_uhs2_phy_reset_deassert(host);
+
 	gl9767_set_low_power_negotiation(pdev, true);
 }
 
@@ -1476,7 +1545,7 @@ static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned char mode,
 		gl9767_vhs_read(pdev);
 
 		sdhci_gli_overcurrent_event_enable(host, false);
-		sdhci_uhs2_set_power(host, mode, vdd);
+		__gl9767_uhs2_set_power(host, mode, vdd);
 		sdhci_gli_overcurrent_event_enable(host, true);
 	} else {
 		gl9767_vhs_write(pdev);
-- 
2.51.0


