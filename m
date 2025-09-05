Return-Path: <stable+bounces-177789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981FB450C5
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B6B17B851
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20102FCC13;
	Fri,  5 Sep 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKXKd6au"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A302DF71;
	Fri,  5 Sep 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059288; cv=none; b=VP74puYoiv3gUGGk6RoD3PSKsyB0QLNAGFfn9/SeZosmQ8JQSR/J1LFY7arrCezD4wV3BTHgr3j6mMOXJZwKuk8/4YUoxRAND+b7Z+YJlaFa6qDalY81bHWrthPisSBYxd+ZAl/UIaT7rk5URJdgsP7Vfb8W3nUryP2XFqlRhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059288; c=relaxed/simple;
	bh=TRM2/DP7jYqlzKJ8dCu8aCpPnHP3eTcBnTwJgVeemX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9teTrJYF1y/YuzGv5/9we43scJ6190mOJ46S6r210p/a+3abYF8gWLck+TTLWEWi0r5O1Wps102dJyY6TWTewRkMhXGjGiv6FczcAxeT4bg/WxYzLZPb7RWFcaO8S2f/N8JmPH9L04ZOhGxAwJgLGuixQo97MaIhwDo/HWAEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKXKd6au; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77238a3101fso1302319b3a.0;
        Fri, 05 Sep 2025 01:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757059286; x=1757664086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KcirD6c38pKnpnjFRQ1YE59Dfe+Ohwn2rFz7/iVbXU=;
        b=eKXKd6au1KUaqo5xvt8V8sS7xDVcIUQjQjWAYuvV1VmtJOMog2SnM3cljV2Cs3aBku
         x1KYWXzVpxj9zm001iIE/4p5Lh7C3C1i7aSghvlV+u+GUikRbizML01E3SPhEHthy0pr
         2PlA3EOxRJN/MMVUvenuUCLoNkw7CgLnC4jI+yTJoEKlPGLRV0kXPV3eO1VT+2zH4kTc
         u47ltbmoTtgmCU7hD9CsqmZiJoJJFbeeF0kJPMT3/k+6Knmqcn4E6wSVXh4llCfcRfU3
         NYadAXKbv4BFx/0oqp6XpAMZJ6iSybR4mxJgyaXJrSIQoX1LjbEake/cdWEc1VuGUxLe
         jGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059286; x=1757664086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KcirD6c38pKnpnjFRQ1YE59Dfe+Ohwn2rFz7/iVbXU=;
        b=okylHIopKd9ksfwGI3vllWZL7zHurYJSvRI3AWUNOJm5yRKsT7NJAgZM3Q/x1LYQc0
         /YrTPQjJiKaqg8EEliW4yXMEj8WUTVZDyLyNpGWLDcwVNavGOiXNwdfRmwWCr96Gspzz
         1q1HM0cod6e0thKQEGlw8TTvH7SXvEgAiTLIUCZmEwPoYgetB/mHCr41Ynni7Ik8Cfzt
         gAPHuyl7779BJwb6wPFKfNvt/dTBCHDO59D13vaM0r1igK21JsREuj3eGwtgGlKlU+Wr
         Kphbe71+gNvaZSU0tqAyT5JvJo9lBbHNYybeCSCCSCK7V3yXlajq/9hYEjIleYbnAf9Z
         zN5g==
X-Forwarded-Encrypted: i=1; AJvYcCVyYrMjgaNdRfyvEXEMa/zOXaEU3sylMJMreWemT+2ebBg5/hdq2/6fsGZOGNI1UTXYeCHj+m9zVFR9@vger.kernel.org, AJvYcCWC6NdTyqJgEy3fp4tUVdA5XL6Q0Z5tEbDsWw8A0ThW6VKx4bnsrXmG81rTMQve4maCgqBp8AukUZVyEjY=@vger.kernel.org, AJvYcCWGdoJDkY9HFJeZxYwPesXpDiaLez5o/RLBMWMi30T+aah60f+6WmFZdGtPFc/PvdV/mhbwqF5e@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq81mWpxvJFO6qQ8WCpBbxUJpfBJQBArQu+rqn/ZQ7vVCi8gPT
	KtrzRWDfAD00GIYO70LbxbwmN2Bnm1PaKk2VO9mh1AnV/1w26BubGSSICXV64g==
X-Gm-Gg: ASbGncsST1vtgXTGXs9wA5a4/W3LlofaNCZI7HyYvOPXxgOMi/qIsodHdSNP7FCU2Re
	krr8lg+A0g3rezPkd+kq3DFQNLDGqCAD6NhrjXQJs9A2pM3X2YdizDRXMhmO/SuNyHT08/dlRxL
	zTPjB2fuLdtg+OW2rtlQgKz36T4T3dDSR5fjnJ1bQpRbgrMMFgsWeWxYbcWwxwetsIZkxPf1q33
	sN1eHSKyFvCVtULZR+fExIJ7zWnwQ50MFORRhHtLHyIdho33mFCYnYog8l73kE4zqsY2lfI1pQf
	/J/dVkEPu3SjBFjZC2p3N6fAujZRQmYXXC0B+UpYQ/wUs+BYUTn1C3i7S22ijg8m/MM63pQWPpL
	R+xSSQ5/Gfn8I7gUYS0MwwVyvmDid2xI7a9Ff5eZabiIGpE8PQw5F8dUxljctk36V2sNp1JVVlF
	JeGJI=
X-Google-Smtp-Source: AGHT+IHIO+hgMBlGeKjNyk5BQw4pQUCHTBeKAGQsTmksm3ezEmgQu+mMDCir7+NMiCL6llrEOie1wA==
X-Received: by 2002:a05:6a20:a11c:b0:246:682:83f1 with SMTP id adf61e73a8af0-24606828644mr15757289637.43.1757059286115;
        Fri, 05 Sep 2025 01:01:26 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b520d33cbd8sm993707a12.41.2025.09.05.01.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:01:25 -0700 (PDT)
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
Subject: [PATCH v2 3/3] mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on
Date: Fri,  5 Sep 2025 16:00:56 +0800
Message-ID: <eb3ac2d225b169f72a0ad33fd1754cabf254335a.1757056421.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <8772b633bd936791c2adcfbc1e161a37305a8b08.1757056421.git.benchuanggli@gmail.com>
References: <8772b633bd936791c2adcfbc1e161a37305a8b08.1757056421.git.benchuanggli@gmail.com>
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


