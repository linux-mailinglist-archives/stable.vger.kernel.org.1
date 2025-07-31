Return-Path: <stable+bounces-165622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C1B16C45
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 08:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEEF7B613C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1328DB47;
	Thu, 31 Jul 2025 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQjIhU4q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB628D8DF;
	Thu, 31 Jul 2025 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945086; cv=none; b=hUVtyJbXP2xOhtCf5kmpfa65df/yvnmi0TZ0xu67NJNJgFMmjoBGe8TNF4Fjkh6QiXcffciyRT4uHju3Ag+G4Lz5OiIi37Emo9EAZEu5Aut07gpCqnGVTxcixQoD6ZYcxH4TWDXzeRN+oXisgoRT87LoGHVveFL5NmMe/znwrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945086; c=relaxed/simple;
	bh=QljHv+p4rKSsMKburIbuxWqh0Pux/EFMS7aPCKeQWhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9U9bmNlRZo4czdjdLa+qJMj1K87mXBjOmEA7Eoad5M+bPQh6iIGPSx/112lojlvVqTCpJ+9y1RR0nmcqdaBZzXLcEaXKeb6KtM+09XitreTRPTKCiNqCCNfrSUPc2R4/UeMT4b0P47pSpjr2nPuMILZeAaHhKQ+tfR1NhfOL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQjIhU4q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31f255eb191so584975a91.0;
        Wed, 30 Jul 2025 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753945083; x=1754549883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz10JIap2Hh1+jtjD77iTt7u/6v/cpy5eHzi6IMW11k=;
        b=bQjIhU4qOkHvFkiHoGiYQVnvQl9APKZ65bgM0/k5O35I1WbRfW3pesavawlh0sy/Jb
         /T5xuz8XQ3m/bU9xIp2PXZXkLmhNo32y1So4bqVXEZq7rbu30bVzmYaTmZHzdcgrIVn5
         F8j4X/Lu1xURGh5t2EHYIpsO1I0hDNl5HtLXm3zV7rUh7eXQeIA4LuGD1HoIA4yBZZU9
         9jLYV60VqP7+ddV9zAyGgu/gnKnKfyLo40fENYOcH44mDZ3vLd0+Ga6oQH6LitV4x+/d
         GayoMMIUJqz9tDxRG0lNaDcXLJyBKyBjPiV7Gnaz7JDs6K3iBK6m0AR5UOu+f/KbOk4o
         HXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753945083; x=1754549883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pz10JIap2Hh1+jtjD77iTt7u/6v/cpy5eHzi6IMW11k=;
        b=q5sM6hqCtnCZSYrUbc/Oi2W7QdnKxGQDWmJ2v/L4mKHK5ARLDwsB6BoHieNAqAqtjA
         W65wen+7pYttrBUKJERwh9Dst5fO9E/kBUKPPStd4tFaO/BM+R8ymVaFg/Ze1h0lfNHr
         J6ZjGUZRHEpjdqKz2T//WUKJ09p1u6dCrDoLYFmNpWTNPkjz/DGmT99ZfFz1yS8B/a4S
         RZXGZLJaebpDdMQuvt29YM0AOlqPqMhp16nCEG99Sc/GeLrVTzP5NnoUOHJjAH9FtHlA
         bxX/ejJWNcn3uF6T/03m1CK0EAFV+F0tPNPz1Guj3xwZsa9qJdQriQpVptgbiofcamkT
         SleA==
X-Forwarded-Encrypted: i=1; AJvYcCUs9lP1D/yEDsg6GKP4XrglF0x8M0v6eF9RHg5Uttyhr67+1I/F9fH5iGnJIt01DSaCfiwwENQqnoipxSI=@vger.kernel.org, AJvYcCVeZtgJA0MBaIpVxjBKqEdpfJd7NTxPjktLAyi5+WeHz333hgPqILlx0DGeLUdBfJIUeH2aj89q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FGN2iSKAyJxUCS6hzTD9d1CBDT0KPp0PAQRpiZW4BQOZXBRh
	kssjtwTugfhIg+IDgHbjKA3x06FXpvXUXOj+WrKT3i7Q16DSlnWnqWju
X-Gm-Gg: ASbGncti1Wj65zwrb2y9R37nIpCQkCnzD7rY/+3lIuETRI5Goe3Xa6Fc7rfZUUujUCM
	atieyifC4uJ84KdYkv1s6RnHwy6DtvdgQfTCx1oYvh/odwVSmZMsDUv/BeOxMyBsa7JZ9CM3MQ5
	Ls5TFJNRrybZ2inH2Hd+TXOOmGjCbEU0VYzgDn0J3GnsmYZMhv9ZPyv77IQVDjgQSA45by0ttrD
	CzUFSB4ZHCLuHGqBr3gaScbZRgvRKSzRXKIeD/uyMNclvzQX8oEUxzyQkMml8F/lDtYm2aCF4ct
	RDjeVfRyjtWRDvDe/hXoaQhvUeAjJn4yrYCQJTN+/1f9rpcf4xhw8CUM1oHVrWUB6HtXQSPXRF0
	UciTUCCDQsymItt1lI36Qd/u3fwjSSg==
X-Google-Smtp-Source: AGHT+IECS5bLXS51UwBXGlYtgyyHPWiVfuybg8QR4ZujUph6FVUs8a1qpPCaEkTP/4oHPqvmkS20Uw==
X-Received: by 2002:a17:90b:17cb:b0:30e:5c7f:5d26 with SMTP id 98e67ed59e1d1-31f5de6b82dmr8316172a91.24.1753945083447;
        Wed, 30 Jul 2025 23:58:03 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:3aa4:3d44:3e04:a6c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6fdfsm1056736a91.20.2025.07.30.23.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 23:58:03 -0700 (PDT)
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
Subject: [PATCH V4 1/3] mmc: sdhci-pci-gli: Add a new function to simplify the code
Date: Thu, 31 Jul 2025 14:57:50 +0800
Message-ID: <20250731065752.450231-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731065752.450231-1-victorshihgli@gmail.com>
References: <20250731065752.450231-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

In preparation to fix replay timer timeout, add
sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code, allowing it to be re-used.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4c2ae71770f7..f678c91f8d3e 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -287,6 +287,20 @@
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
+static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *pdev)
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


