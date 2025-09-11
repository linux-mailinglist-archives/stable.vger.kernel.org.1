Return-Path: <stable+bounces-179230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4FAB526A0
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 04:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FBF480A96
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 02:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BB22153ED;
	Thu, 11 Sep 2025 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R70vLNmj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68A74BE1;
	Thu, 11 Sep 2025 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558572; cv=none; b=YjLj41FdaeT59fqoXFQAzj962VNSRqYWuosw10JRNbNxpwDKTXD5D5nYVLuASm46TwHm9OL8MLmWMpCYacGLrE1gt7gSdtSZQtP2Vj+QhgmLbLlp4lBuJopygDj05DDWbwd8/T8BiJgKd9k0dFcTpjNxKf1R0TfHxtZryX3C99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558572; c=relaxed/simple;
	bh=4IzelWXwLIIiLQ7QUAppKHUk/ucXT8lKxeNiTvMOliU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAI2j/dgwGXX5Abzy9tjs52tgUYn6jkQeZ9I0BwopsZclXNeYf1L1+pRFZLkBeOf3poXCKbi7XWX9P9ggwq8nU3wb+jC0OyjaKS97wzFu+bpFThUFUDFIl3hlHbs/a72UwyjGs/XyVftA1Ba9aB5C7DdihhLj/U8uvOV8Lc97OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R70vLNmj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7722bcb989aso154549b3a.1;
        Wed, 10 Sep 2025 19:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757558570; x=1758163370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTdLtSNrCO8di/hrRDk4RHof2WOK3gGHgKy96JVEeLY=;
        b=R70vLNmjRLKs6MUBPv4IxdD1tGNVX26WBhLcYE8ow9vkcU9cq1/4ZkYhirYhnXxci/
         ssWfDf2RsaT6DmoZHaE6oDgPpnkt4eeuxO3ELnPydXpaCXbBUU3NHaQXqGfyUW80xtIT
         C/rq/0rV3J53NczMzOicYrTuMvd9mOK/+emCa+K7kiWtxwYBD58Apt6B1XeDHVZu+DvG
         d5k1rH8AyRk9pTDy1mMya1OlttxlSsoAT9hjP/udJK02tk/dRzSb7QcRCNQMbJ6CJksn
         G7qPLM/x9SzzfjS2e88S+ZiRFv4h+MCI8GH6FDg1lEZaWvwDhmEFKqlmiSbr0/gXC8Ff
         m4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558570; x=1758163370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTdLtSNrCO8di/hrRDk4RHof2WOK3gGHgKy96JVEeLY=;
        b=V6YsaeLkxmslI4Qvk9A23h6JXujTsi1SHZ4hPI2KVzNTawIIzB3jqxRLTZt0JORPHo
         eowsYLYGkqbGYKHgIqcyA56P8hVZY810wvfblWq5LIA15SGpaSYdc2erF35ZgRsqo22U
         hOjl+n+gCpMbzyI/QE6t74X/6WQy3WdB3CmnGjXp5hkMnnyUga1AeXfrKysUYahSKTVF
         2AQ0V40W2RQdYHxO/dAX2dt/zZ4+umc8PJBg/fpCtPtRrEy54t1s+5729+1gDkD8LjZC
         zCk+qh4F4T/LfyZ6cDT2darFz83fhMPw4rq7tKib2eS9OzxV8KcjgbIdNozVJ7U4gIhI
         BZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUosoEL7UQ8wPWBxWlGq/pKCXVP3xW222BnIccTvI7eiHwoTqCpJmJzcOz7e4yytH5PDrcWi59c@vger.kernel.org, AJvYcCWyZOfvDyxdu0FJyAUnhOsQ6psSuy9CPbDSVysolacYAzc5AKYGtdc6MKnFh5vu1/E+96ytFsXTvtxlfL4=@vger.kernel.org, AJvYcCXTPWBehbZSjncD7+vm8t9SCZeLc7viciL0NDW4a5p0k131R+nw263ZEJXcsFNVq81tXIxjWV4hxGwt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26rP4I/nuhzKNDSXtZAyjyLhnolS+ltrbOyW6j36kZAcGb9hL
	m/mhPjTH0jTcUqThiVOfkh82UyvV4UP6bRrDMxxIQTzvgK6XJffZZc5U
X-Gm-Gg: ASbGnct4FqtuC4bCHW52a9MSjmEcwKVGamk6kPFFEpa71WFWi0D8uin8Yk9B1Rdi4Mg
	vd+6uO6aowzaQNgIZoBu91q5CxcXBRT8QX/alqNDdggEa5p1b7iBFcepxl6ZF32kleq15MS6gPE
	A5o+QKhEhsvLkwGclv3MNB2yItCDv9tJ8q5SarqvaX4t06rlIieUnWUvO40WCKK/+JEsLdmWYdj
	13rRfpRKesnThFAwZ3B/JWayawYISDUBrQ8FribLmuTdaaFXb6xa+X3Dx8x8aWHvrDxYYilCJ8y
	B/jiKI6w4Fh8iqm/sjXUXZZb7r0EKWySPCc7uOSd6+ME7tF387CdhNo/wEUtafxuV2UqULpBDrd
	Mjh35S155VXYFgd/bGBB+KYOjw5BR0jmn2Io81Zi3HRB7FfZpJdIWS1OQr9OGCmF0RuO7BUJKVg
	uEPmks6ZLImaEvmIx2jF7B2hChKb2TaNhTdwEIc2I=
X-Google-Smtp-Source: AGHT+IHlACGIGryGMo2klTca88UIiOwYdyASTSgAXWNl/iX9K5HSASXRhDKLI5yRH5C8WKr28ms/jQ==
X-Received: by 2002:a05:6a00:1a8b:b0:771:fc48:7c1a with SMTP id d2e1a72fcca58-7742de3ee2amr18270677b3a.27.1757558569717;
        Wed, 10 Sep 2025 19:42:49 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b4dcsm318840b3a.13.2025.09.10.19.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 19:42:49 -0700 (PDT)
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
Subject: [PATCH v3 3/3] mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on
Date: Thu, 11 Sep 2025 10:42:42 +0800
Message-ID: <f687912419cdaf198b2430ea8d2c704c9016962f.1757557996.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
References: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
v3: add Acked-by tag.
v2:
 * use sdhci_gl9767_uhs2_phy_reset() instead of
   sdhci_gl9767_uhs2_phy_reset_assert() and sdhci_gl9767_uhs2_phy_reset_deassert()
 * add comments for set/clean PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN and
   PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN_VALUE
 * use usleep_range() instead of mdelay()

v1:
 * https://lore.kernel.org/all/20250901094224.3920-1-benchuanggli@gmail.com/
---
 drivers/mmc/host/sdhci-pci-gli.c | 68 +++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 3a1de477e9af..b0f91cc9e40e 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -283,6 +283,8 @@
 #define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE	  0xb
 #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL	  BIT(6)
 #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE	  0x1
+#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN	BIT(13)
+#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE	BIT(14)
 
 #define GLI_MAX_TUNING_LOOP 40
 
@@ -1179,6 +1181,65 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
 	gl9767_vhs_read(pdev);
 }
 
+static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool assert)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value, set, clr;
+
+	if (assert) {
+		/* Assert reset, set RESETN and clean RESETN_VALUE */
+		set = PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
+		clr = PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
+	} else {
+		/* De-assert reset, clean RESETN and set RESETN_VALUE */
+		set = PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
+		clr = PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
+	}
+
+	gl9767_vhs_write(pdev);
+	pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
+	value |= set;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
+	value &= ~clr;
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
+		usleep_range(5000, 6250);
+
+		/* Assert reset */
+		sdhci_gl9767_uhs2_phy_reset(host, true);
+		pwr |= SDHCI_VDD2_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		usleep_range(5000, 6250);
+	}
+}
+
 static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
@@ -1205,6 +1266,11 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	sdhci_enable_clk(host, clk);
+
+	if (mmc_card_uhs2(host->mmc))
+		/* De-assert reset */
+		sdhci_gl9767_uhs2_phy_reset(host, false);
+
 	gl9767_set_low_power_negotiation(pdev, true);
 }
 
@@ -1476,7 +1542,7 @@ static void sdhci_gl9767_set_power(struct sdhci_host *host, unsigned char mode,
 		gl9767_vhs_read(pdev);
 
 		sdhci_gli_overcurrent_event_enable(host, false);
-		sdhci_uhs2_set_power(host, mode, vdd);
+		__gl9767_uhs2_set_power(host, mode, vdd);
 		sdhci_gli_overcurrent_event_enable(host, true);
 	} else {
 		gl9767_vhs_write(pdev);
-- 
2.51.0


