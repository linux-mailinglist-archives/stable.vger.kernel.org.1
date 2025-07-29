Return-Path: <stable+bounces-165035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F2B148C8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 08:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9F93BA8FC
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81626056E;
	Tue, 29 Jul 2025 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0QLpOry"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53A224AF2;
	Tue, 29 Jul 2025 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772301; cv=none; b=Zt9tmB4u5tU507IWm9+c5NM0yHUglSAdy7SwjfKehaI7KPpCAZE00uyU6bVJPpU5LnVs7nf63gb1EzA62fKJlZK107aWcFN4rCKk5bLfxn6tJX4iwmbjO5EYGAhcANMpa1Ro5kWk6vU+1zzYvPGZS7S1zyFE2d9ZfA5L07ENwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772301; c=relaxed/simple;
	bh=5A0ehqndtbDV9JkYvCIzul4+ZZaBCAP5ZmXhb9eZbhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uC9q8bgnL4ftId+V2BJalOlCfww3VpQnTzUBCkyLTF8DyQ13wRERAUfxywsCmzIph2FY2zfiQCMujlTJpyvXWb2gU8wjPp2HUVu+i96jgG41fzsao0rxGGBYbkj6q8AMLuF+9h9nLLzIcbSJvTAQePHCiEXApzHftgvdureInQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0QLpOry; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748feca4a61so3196957b3a.3;
        Mon, 28 Jul 2025 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772297; x=1754377097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTpaMQ3GYEDB7KaND6Qr41gzU+ghNBxuI7qX3ulgbt4=;
        b=b0QLpOry9Ns23rQ9tsfI8adkgLs7hNY+HfSuC30M+m7WpLxb6WtjnkpM5MB3NrFJzE
         nxb+rcaRJCARwf0NaAJwnPUvcm9ES6GoDVxR3kO1Na9++0WUiy9I4SLkkTmrZJ4Xab/E
         G2Mojw5gA27rrjK2BKfwhGqkWwhBfx/AoZwS3uRdlhiWyDCf6t+hGSt9FgYLYipzJucb
         N+EhqVHg6wHcxlNWmv1bHXlwzGMoX7y2z7CKe/0aJq8cF2Td7RNS/ZQJ+P0/PWI/AxY0
         /mpgH56UIqxHhUN+8KtBLTy+w1sPDUftoAcWdws9mrMOvEY3ovLI47cPZZRcobnahCuW
         D64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772297; x=1754377097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTpaMQ3GYEDB7KaND6Qr41gzU+ghNBxuI7qX3ulgbt4=;
        b=CfxntrOR7yE2NRglo5KqlCMigrhUMOW84oLSq0bODddS4Q21Wm0vSLzZPyPy4mN8bE
         c1B7uTJqert7xOJfiwpJK1EcEzU8AlWxItFHD6tx/Kgo/oHPCIo83vh/z/bvDv/CH5ct
         aeaZuki9bp4MXM19bUWRCMOuJ17Ne/5OljAp1zuYUYlvpUDCUyvIcqX7RxE6h2q0zzy6
         qTnYUuRiPYrrDkdYPbjKt+R1ksCx3FxWfzZG0foneorsn2XDl2LbuWGWrjQtxhpgjGj/
         U00SfHAAOjVSIBIxzMCd6oMJ71h2x+hmdVbFJ7DFTj1YX6FpQexqu5vieFf+bPclYKbF
         xJWw==
X-Forwarded-Encrypted: i=1; AJvYcCVPAZXITRMx0HrtgHg8vGz8oqB6oGOwzTOzInBxMi7nuZCAlwfYwZIln55MdWaX1Jn/HqWtTcvHgSRjDwI=@vger.kernel.org, AJvYcCXXXAYqz5PfT8bdOuWQFUIDC4aT4gv0MWOCEigrNVJZuEiecLel/+9AbHNRue+u8ZtRw+px76Gr@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBdDsHhQnMp49SSkTJCKsaIdam9+sOIBgvZFClPaPCXUR9QPK
	uvxI+vrhBxWj2nWZNAC6atdgtQvD5VkrdRfVw4/x/55mIAONYxnIEe1c
X-Gm-Gg: ASbGncuxBLh3yFMcX3TsUSJRXc+suCiGJP9s9quDLtcVyYE3buktRY4fQ+TEtXRx5BN
	QNslwiVLblK3iASrp9W9Bfoo8DVY5CgOjos4+AtPWX7WjSLYb5N0HUSsrePH7ovFfF/omni+a3P
	22zN5+DUAo/xMtft+IuSepDj6fPVYWF2v4VVlm2+9NXC7Fi65lMVgk354ZggppUEpVFs+zi89sy
	rZc4x41jhP0x5rM+hvBeszYunMtBOBFYPMmpzXuQaEpjG/1K7jjju/7I8tcwc6Bne0okGvmdzh2
	+/SQkgbHT/Gg7KU4d/xmUQWVEEUEh5+w41Joa5ofgMFfS/HTdx2sOZhWixYCD3Jl+8katDv8NvO
	e0Vj/wNRgVNIYMtreP4i2PtlqP0VuuQ==
X-Google-Smtp-Source: AGHT+IEkxAa/Iu6JFTMSAYGHPO/q3/2tTnNzvmgZO/BTcWa+a3eQ41dyOqUl7hw+IdPTGadCT2FIsw==
X-Received: by 2002:a05:6300:601:20b0:23d:7a38:d119 with SMTP id adf61e73a8af0-23d7a38d15cmr13213517637.21.1753772297140;
        Mon, 28 Jul 2025 23:58:17 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:c998:3a8e:c481:6cd7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b420df76dd8sm758066a12.19.2025.07.28.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:58:16 -0700 (PDT)
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
Subject: [PATCH V3 1/3] mmc: sdhci-pci-gli: Add a new function to simplify the code
Date: Tue, 29 Jul 2025 14:58:04 +0800
Message-ID: <20250729065806.423902-2-victorshihgli@gmail.com>
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

In preparation to fix replay timer timeout, add
sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code, allowing it to be re-used.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
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


