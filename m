Return-Path: <stable+bounces-177787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F9B450B2
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537E21C200E3
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADA301010;
	Fri,  5 Sep 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2rt7PRd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD242FA0C7;
	Fri,  5 Sep 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059223; cv=none; b=hBFo6bYCXU3gmdYvf9wT7mJOnuORBAktaLD3AfyNQn0+WF/TdHqliP4qRYuvWN0YZeG7omxkcVT4CUkmwctDvyF695BF26GoXdx/zk9LEx98gYjG5oU/HTeIGq5gtfnw7WcRWLueYW/u+lQO2yDYcDaYAB+74CILO/pAZNn6/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059223; c=relaxed/simple;
	bh=BgGO73X64tJGGo51lJexYhi9rzRlJA3UE1q+jowr0i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUPpvqDSADz6RqjtlaQ4GMGDquvx5A+6B4xJ/re1qvVNcKVvtDQiSIWgussItBLijL3A5qqhAm9OQ+h9nZdUSK/H8V1jhw7w/gh4pv3T4dN3BxdtjMPY4K2tpTm1zvkvpCv2itz78uac4+FRW1p21HRlL9UqHZ6y+mCHMVVCLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2rt7PRd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24c786130feso17569355ad.2;
        Fri, 05 Sep 2025 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757059221; x=1757664021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5nX2O+LBe1ZYCBA+KxTgnmmzp6rtpw0HpxyhC6Gn3FQ=;
        b=E2rt7PRdrShrPkE8/ufs2FI6zrgrJKm6vGZBYD1PH5G4bcSlbeYZksJ/qmiPfn3df0
         U99qo4APNUtWyfsCL739BeJjm/PSAhq0Hbv2zVoKkNzK3ez9UUiRGD5LHMwZKhWdGXCC
         TcCqRFiJgXYdNMEwXwGRzHYxfz/aA56161+97ssUe+4Aw+ee5m43UJCUC5xa/qKT0dj7
         ZGKiXsqkJ7CvECBzRlXeqLbCowRoVWr+BnhecHhN1/n1ez7e0oPJ6veQKZo5iOlBWCDx
         +jpdAYwwGMq9bl4gchQr2SZmS7EIngGfxZXqAKqFmPfLykCU+eItQjF+HmJTRZqhq+Yp
         1tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059221; x=1757664021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nX2O+LBe1ZYCBA+KxTgnmmzp6rtpw0HpxyhC6Gn3FQ=;
        b=YFC5DJp6WwSmy0NbaAHCDSu+bScg1Hg8v4gN0Zut4D/bv7X1uOlJprVKxUIq7nfQIL
         OFDBo6MjEh4CbvYEXlCn87XWjeA5Zw7hgGM0c2BMa2d1oE4t+1fg3GePHltrVRBqsYBS
         zzaHTAUlW6oZoIeLq2IXMve6E2UtVR3+cgKgbDhw2569z9kF2W5nRmOtVGOzcHUeCIqX
         FCiRzVg3ZHRT3FLWH+CtMDpzxJEKDMkfCUfOBaaKzihVRQRqN0vuohw7HZxK8xOr81X9
         tSZJ3IpLNZahqYko44BcZArfFywmECKmbmpAI/QO6kP5pPYnskG37urUB1Iu2wRBotXT
         m8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0na+HSssU5aw+r+7E1e/5XQW2z5qiAfiQrUcYQHsxVEiPWg009dbiskpR+siWSc7+6jxQKsV7@vger.kernel.org, AJvYcCX54PSQ15+nIDxO1IOpX5/VvEt/KZikNn3sQYD67zlig3i234L+fS732VOIUSqwm7RlCTAOKWbXv5pS+HI=@vger.kernel.org, AJvYcCX58EI2iDPxzdci4Dlfi7Yjcn9FumvUdGMc6cP5UeuTT95UUZK/bOYl3g6KCSsze2j1THIjVY3vctib@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFXwr4+S0RbQCzgErrE6nLpvVexRft/RARv8hnMoV/dF2SBhH
	oPW3MggjAe1KOfPJib2WVX2BhpZCTn+qb216IWlohEpc/yTGzeY/nl6X
X-Gm-Gg: ASbGncu46k4Xy6xwyDH3LzasNuKSktC8zK8iF9ijDyrlbsu3qX19GZ0DjiMGby7ry+f
	/mJ0rxF3FYGaeOOW/NB0t8e/+T4b1vwRidUlYOdSFXvZKYHCmonxTVT5luon+DKAk3iUBLfSq0s
	hM/k6ln1yE/EKz0UBXQ5LiSAEG5HQbLlKgDCtqo0+mJVI8DP0UxtVhYhTb+jo0jiBmkBkpMVZwT
	TO/Zm8fWXc0oaEITAwOiJTyg23vWGhY37IBpnoCBWVN2kXG54Q5n+bZU+fJlyr4M3+SgedAy92q
	SkRBLWNzk4IYuxFM6UOgBeY+DV229bKA3JZCNe70UzRLrtGwmh0o/2u10lOKHoHNt5WHkvR1Uo4
	pU9E9d82gWLEOjnXPXxaFHN+pZQqg+5NlQMg7GpGvvcSyh0H8GTg8j/sTCRmbykq6UuyM8e/S/Y
	OJDLoCb0tsyAefT9FPZgzmRnXPClwGfX+8w7xnjv0=
X-Google-Smtp-Source: AGHT+IFJBfUzp1CW8KqB+tKayTtIZL0JzAPJP9C1Slm69/Nl1Uc/ZHw3mRNpXLHgRgI6VUDUQVjfIg==
X-Received: by 2002:a17:902:e552:b0:24a:f79e:e5eb with SMTP id d9443c01a7336-24af79eeaa3mr203740105ad.49.1757059220673;
        Fri, 05 Sep 2025 01:00:20 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ce9dd9373sm19274425ad.85.2025.09.05.01.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:00:20 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mmc: sdhci: Move the code related to setting the clock from sdhci_set_ios_common() into sdhci_set_ios()
Date: Fri,  5 Sep 2025 15:58:57 +0800
Message-ID: <8772b633bd936791c2adcfbc1e161a37305a8b08.1757056421.git.benchuanggli@gmail.com>
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
the clock from sdhci_set_ios_common() into sdhci_set_ios().

Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
v2: add this patch
v1: None
---
 drivers/mmc/host/sdhci.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

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


