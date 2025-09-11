Return-Path: <stable+bounces-179228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653BDB52698
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 04:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8CD5834B7
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EF72153ED;
	Thu, 11 Sep 2025 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVSDEBVH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593F212572;
	Thu, 11 Sep 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558427; cv=none; b=G/B5ANWJg6iJZHNaS5rTNNYtyyASSGolqG5lx5cBhMeEHcPOyroeqW724hb9Ov/tlGJqAxamxGE4yZI2nTNr+OnEDwKzTD4EBVCpfjh9TSVyLZwtFREfEw6MbXPx34kIIroIt2QlHE4kh0sQICfHhooJoyoPgfElFO4AXZkc+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558427; c=relaxed/simple;
	bh=5l9LHAHSyRkUGmbXCCNVTHKCBYmPKVtc1vKXVvdCG1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bh1lNEs5puHnNd6mixOwCbQDewDk8oRon7BbBaE/LruN3TmDznDCC6drACURVNnR8pWElCQ5+QQIzPtZCB08UWB8aO5CYi+7obH/M0xu6orWusLv00f9d2QnqE9YXH+E2PdGn2o7SNNrfYQfhl6I5ue6mMO9rwB3TRPBkm46KIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVSDEBVH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77269d19280so201036b3a.3;
        Wed, 10 Sep 2025 19:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757558425; x=1758163225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmOmBYKVbhFW6ADasxKXnYiX53sH1YgXFpBNbR7AfbI=;
        b=nVSDEBVHEwKsATSHG+1Mp5FjrbGHc8Y9WjLpGfbE/bc6bf1eqQI1LH3tWkssCeGK1d
         UfwmCdiGZuH4M37i6ZKU86tGVlbSyZV75oMEWf/umkZT0+RrTGGwzo5SOStv9uYMwQq4
         ZUC0eNKCvn44fOH9cO4QpXRdL6rgK+OowgqPx2+0Pns7uOBgzYktd2xZHOJjfqJw2LLB
         6IQ22SR34Zn2KyHMcosHNfRS9nZrZ3bWrsq8ZZUOUxXCQada3MnDMseTF2YClQcvqB4c
         L2YmLmAYNeKP2f5G2t0qvOWvwkZniDDBLkGmS85RWgdYVUk+H0qt8v3asPXbUV68IDJW
         NESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558425; x=1758163225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmOmBYKVbhFW6ADasxKXnYiX53sH1YgXFpBNbR7AfbI=;
        b=MZJMXNdjoXL0fuel2aJlmhC/j4/WQdTugoD5ik9i+ER/mehDnjSYthdoWUzg908eRZ
         ALO0NA/dxf0NrID0FkiZsvH1/TJhWthLmlSLNoD+wqtQs4+YcnPGQLMX4GAqrDBykd0y
         FxV06vrakwTvmq3EzlgU/sCbazykNnEGSlbVVZkeS2oFfWq+xTMwCeiPPt5j/+4oYv9a
         m6ujFIoiwjuEskN2ntdFhhqzWgp2GPxDg9qZrQJ1xYF3fRF5mPP0iHtDKPp8JxvaZeKj
         7OWpnHqoMGTxVrFRU4VkuXN7guXlVBAIi3jFBsR7PtFf8QxLqx3BLbOiJ0KEHW7/knwZ
         89ew==
X-Forwarded-Encrypted: i=1; AJvYcCWwvTj7nS5d7ZRtgX3g2dW6HK7dfR3Wl8lDKJxql388zBRMeYjKBtphpfVexcMcyPD/DQbVX1LpOaGeMRI=@vger.kernel.org, AJvYcCWzzZ5kAQ85Vqa/qqvVXpnWywcdwhwftmUwhZuSyRAe2KrLO9gf5DkbcJwrTMACelqL3pQABwRv@vger.kernel.org, AJvYcCXmO/8VurVlS00WfLpsABMdwpTYMB8JUBdaZQmPtTM4wet2ZNImgKI2mUbvwUwmMF0iueZVOQQq34fN@vger.kernel.org
X-Gm-Message-State: AOJu0YzfamjBjGfaqtFc11JdFApWlddm9G21DFGV5mjGht2io5jJJpyZ
	dA6YC583rG+9clhKOsJ/iDcg60m//u4LVCqfZqUp2qy6OP3R8yaEKHkssfC18Q==
X-Gm-Gg: ASbGnctv062uX1UKd26fNIX/SfNMsoPZJCnMSArlfvf5oBXfLMjqmhDU0lzNZwFXrwN
	mKSMICmb3vp9C+fZ6d9iyrsf44QC4dFrFLDL/wc6gd6lUbvla4rJkm7Qrc2vgqagKDJJiTEh74R
	MMTUL7L7Jfr9lsJcmo79OI2skjsF1YcD2ChKDCUV8T2+xoXB8x4d3VySvD9p1h/WEvPqlokgnym
	eCMw2kCIRl8U/XDlRQoiICFPWqznhiezcwiVZpg2/pBiEDeUS4B/bbOFHPYm6KhWhlfuYLd4CaG
	3XnwRkpjsorO3ZEaDdnF/mTRzi9DioICq3gQksMh4OMEAJKBtl2EzhL7QLJlvFl5Iiaoougi5Sw
	R1mUlotLg8X/9mBau/ieCiDU7hyjmN22ZmXKQNG3i//2guhPQnopaTJV3A4HBsaJIlu47g04NpN
	8UrOVgvpBEqF9w6hH8LIIuuyCdOJq4+vukvgc7WDc=
X-Google-Smtp-Source: AGHT+IEjm/+6n2HVtQ2eFF49Gibz7/0FyT+HPnW4Henki7lVdC5U5joF51JBLt/z+ppnZMI7x3zK+w==
X-Received: by 2002:a05:6300:210e:b0:250:720a:2928 with SMTP id adf61e73a8af0-253448ecce9mr22719797637.37.1757558424963;
        Wed, 10 Sep 2025 19:40:24 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b33b83sm295930b3a.69.2025.09.10.19.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 19:40:24 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mmc: sdhci: Move the code related to setting the clock from sdhci_set_ios_common() into sdhci_set_ios()
Date: Thu, 11 Sep 2025 10:40:20 +0800
Message-ID: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The sdhci_set_clock() is called in sdhci_set_ios_common() and
__sdhci_uhs2_set_ios(). According to Section 3.13.2 "Card Interface
Detection Sequence" of the SD Host Controller Standard Specification
Version 7.00, the SD clock is supplied after power is supplied, so we only
need one in __sdhci_uhs2_set_ios(). Let's move the code related to setting
the clock from sdhci_set_ios_common() into sdhci_set_ios() and modify
the parameters passed to sdhci_set_clock() in __sdhci_uhs2_set_ios().

Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
v3:
 * use ios->clock instead of host->clock as the parameter of
    sdhci_set_clcok() in __sdhci_uhs2_set_ios().
 * set ios->clock to host->clock after calling sdhci_set_clock() in
   __sdhci_uhs2_set_ios().

v2: add this patch
v1: None
---
 drivers/mmc/host/sdhci-uhs2.c |  3 ++-
 drivers/mmc/host/sdhci.c      | 34 +++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 0efeb9d0c376..18fb6ee5b96a 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -295,7 +295,8 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
 
-	sdhci_set_clock(host, host->clock);
+	sdhci_set_clock(host, ios->clock);
+	host->clock = ios->clock;
 }
 
 static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3a17821efa5c..ac7e11f37af7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2367,23 +2367,6 @@ void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
 		(ios->power_mode == MMC_POWER_UP) &&
 		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
 		sdhci_enable_preset_value(host, false);
-
-	if (!ios->clock || ios->clock != host->clock) {
-		host->ops->set_clock(host, ios->clock);
-		host->clock = ios->clock;
-
-		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
-		    host->clock) {
-			host->timeout_clk = mmc->actual_clock ?
-						mmc->actual_clock / 1000 :
-						host->clock / 1000;
-			mmc->max_busy_timeout =
-				host->ops->get_max_timeout_count ?
-				host->ops->get_max_timeout_count(host) :
-				1 << 27;
-			mmc->max_busy_timeout /= host->timeout_clk;
-		}
-	}
 }
 EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
 
@@ -2410,6 +2393,23 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	sdhci_set_ios_common(mmc, ios);
 
+	if (!ios->clock || ios->clock != host->clock) {
+		host->ops->set_clock(host, ios->clock);
+		host->clock = ios->clock;
+
+		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
+		    host->clock) {
+			host->timeout_clk = mmc->actual_clock ?
+						mmc->actual_clock / 1000 :
+						host->clock / 1000;
+			mmc->max_busy_timeout =
+				host->ops->get_max_timeout_count ?
+				host->ops->get_max_timeout_count(host) :
+				1 << 27;
+			mmc->max_busy_timeout /= host->timeout_clk;
+		}
+	}
+
 	if (host->ops->set_power)
 		host->ops->set_power(host, ios->power_mode, ios->vdd);
 	else
-- 
2.51.0


