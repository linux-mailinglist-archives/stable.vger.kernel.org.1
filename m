Return-Path: <stable+bounces-165624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EAFB16C4A
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 08:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEBD17F51B
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B2628E575;
	Thu, 31 Jul 2025 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKmBv6K1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66A28D8DB;
	Thu, 31 Jul 2025 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945092; cv=none; b=SCmHDlrN5YUmIbU0pQqVB3lWMUHIRo/AJtxJpe7sEpN4uA0KdjDB3EHqPTXR75kodOz5bKynBJiHmKaLlsF18eb6gWQA7By82lnTBy+a02dIOc0mYnmhYrL6PlaEAF9YEJ67kc3qCzPXsX/RFMMk6qwpWGLjO6W1Qs89x8qaQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945092; c=relaxed/simple;
	bh=/YObmg5o0fnmt+G7NwILAkIrttqDYVkOdM2arVfN/L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR6gdLkxk5a7f5wajaDCmUAJFVp/sf2Mm5MBkI3N+apq76G5NONjCE5jnG1QIjQJqip4sSSXor22T5Kc45mJu5g6odKWxdm5cxqtrAW2eE7GRkYogps52zf/DuKSs/lQsLkXTWEo3QIjukuG5v7MSajwqkC6VytvaDe7OzK4blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKmBv6K1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so517660a12.3;
        Wed, 30 Jul 2025 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753945090; x=1754549890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty71zZwrxKdG9735rE5ivsHSFJ0hlXvH1Bl1HDkBCEc=;
        b=TKmBv6K1kjRrHBZg22QSuHSyVw3EwseishL1N4jyCALykGW85t2WRA7p/8/7brhXf5
         +9Fin8GVtt24auOABTjrPZBwUqFuoJP0/A14MD463drNOX48YvGBqp92to1uccGB7Gu9
         ydckk0vNpUV7IPdICt3Ts3LE7sWiRmIsPl0LQiBMWj3OtpjOgi5jSsOUe8NMkAfQq01p
         mPxT3qiAoDihWaDR5uolxtDrPGjSAm1O3g7qFcA+CZjuutvT+jnZXPjuMProeS4UBZST
         vb8uxNs2011ZH2T/rIx2gmX9ea6si6ICKWRdSFRVh5u/fPXn9mF9oMjR25FVGKoKK+3+
         dzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753945090; x=1754549890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty71zZwrxKdG9735rE5ivsHSFJ0hlXvH1Bl1HDkBCEc=;
        b=rQoj5mbVDxm44ODk3KOuHEBDo87UYm+CypDwwzLb7QVntUGC/OWcMIMED99gNlOo7/
         Xbb8dBrdZM6SNePyFHXT30ylLjaIm8QQDWybwd8ycGptfLXB0UZs2XOSbD7I7jnTFXmw
         F7jVl+jHygbfLBJFa0CUt1NY2DYd7xKjA5m7M7zPdKekhu2vY9gI/tkiTOzfozADH6Dq
         dcw7Bm4cdobDTMmuidhLSCkHwME/oZzgTEAER4qRxdtXymXWRi+nRqNcB8oybrRQBOML
         eohSrp/njDwXjHeC14jC0tPsn6YmsuknfY4QinZEhLLb1m781aGTnrAd31JmnWeIJQMN
         tggg==
X-Forwarded-Encrypted: i=1; AJvYcCUvXYs0muVVSg8rzlfqh4R80XsXAFly2/ZAJU6k5zwlIWIgZDomSp+xEtSqSRJx/TD4aqOmRGOd@vger.kernel.org, AJvYcCWmnkzDl4cczHDjoViKLzvECjouype7oP9BLKd0eX0Qa8g9Nyi/OMphfiLvscC7WxKe1czdaqGhidZTOzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydN8GwktoJYdux/biM/1ARCb3M/IJ/Avdw3yS1ZeGBcc7sbMGx
	XZBBVPUXyhzTraguxFGbpPOsB2qSI71QYyft3Dm3N5wXvFAhIx8YnWha
X-Gm-Gg: ASbGncuNJp7V5pF3Ykvgzq2HAS368bYXe3j4u5MHDY1WBsFA1qX4NkdkEnf3jV+s0dN
	5k4M9Q1puE7Ho/l601NJBzoy7ofxpajFNkgW1K1P/i+WqC6rY82tfhkA69SAz5UJbKbI1ou1ZE8
	jdd7brtqk6DpMUlG5+iUJnIO6VTLLuzFWZ6SJ7xiGTlcNKo9LFox4rWFxz78w3WC2u5bLgRWGsZ
	2yx4ETn0oaD9dP6uUJGMrEyGjss3zoR6YKeaWkmr1ifSAajZnrWcu97oyY76TJcOvtSCyB7HMSU
	Vf8RJh3Hl9D+2F0zjo/qvltYEEtxbT69aBUefghpGXzglnvzJaBrrWK2ZAyU0RvrrlnESlbDWHo
	OJSJTQV0ZJD+x1w9JnpIAumjJH5EYnA==
X-Google-Smtp-Source: AGHT+IHLSH9Mg+m9acz2wJMrpJS7sSDiYOdOnmS+3Y0U5hJg/1mghFnOvuAa1vtywnWpXkfik/JzKg==
X-Received: by 2002:a17:90b:4e88:b0:31e:ff94:3fba with SMTP id 98e67ed59e1d1-31f5de73be3mr9345349a91.24.1753945090158;
        Wed, 30 Jul 2025 23:58:10 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:3aa4:3d44:3e04:a6c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6fdfsm1056736a91.20.2025.07.30.23.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 23:58:09 -0700 (PDT)
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
Subject: [PATCH V4 3/3] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
Date: Thu, 31 Jul 2025 14:57:52 +0800
Message-ID: <20250731065752.450231-4-victorshihgli@gmail.com>
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

Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 436f0460222f..3a1de477e9af 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1782,6 +1782,9 @@ static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	sdhci_gli_mask_replay_timer_timeout(pdev);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.43.0


