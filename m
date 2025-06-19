Return-Path: <stable+bounces-154768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F96AE0157
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A057A3A2C3C
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E95A278767;
	Thu, 19 Jun 2025 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="wGQ3pnI0"
X-Original-To: stable@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DE254AF4;
	Thu, 19 Jun 2025 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323833; cv=none; b=XPPI+B60E5tb0ZhHZT0peLnRDw1smQPO+FvrVo9LogNI31UyVIuVS6dZGOT3N1effglgvKZgHOsnGDvz1j7A4SOwhjz5BYrv6krQfEjT/rcUSaun/MQReDi3V7hPXh56X91HR1wQOM8HYV8cevJRqEdonnynmTiOTNj4IMLlJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323833; c=relaxed/simple;
	bh=ljv1KsUnyeQzVxscAIRHlXidTQPVrFUTcatrlOFG8BI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwaAyotin7/Ata0vBQsF7kzJrNthrqblTXRnMYft2XsOu5HHZyykLz8XhvXinZE7M1gQdmF/jvhj0YD4AKGIhrRAVQuo1DsqevSqytqeVXmT3fMEqsXXBddaI1fv1UzbFW8xaSFokVnGwytlDPI4GwEdf6VOQaGtYV02yxdtQL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=wGQ3pnI0; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1750323831; x=1781859831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljv1KsUnyeQzVxscAIRHlXidTQPVrFUTcatrlOFG8BI=;
  b=wGQ3pnI0VaksbsQbI0Sp4Dh2PCMtgZjoKbpqbVduHvKnWcRqmx7zEvZ1
   QX9M6MiSm79b4uMGiGiEaj2GPtpTd23Ikt9GTuDdiWcYswu9BZVZq2Vta
   T1IgTourudmd3z5ZSlKa8l3+DT4WTH9H2Cnq20jglICHAseLW1tTQ+yk7
   egb45vlPUfHnWvLA8+Q0pNZXeer+hVpydLXuv2bZM9TTePLz+krymhjuB
   IsZ5Lu74FPpepcc63On2rYVmqLIHUT2KKJgOQQ8Ky2mvQxYUUkCwHcRjX
   WC/2eJJaau/Ia6JX7lczR0uU5P0HEKoPvIoZYXbCgqOIFLYh7NWwGOfJz
   g==;
X-CSE-ConnectionGUID: 2hbdttp2RX2k6Yrd4hci5g==
X-CSE-MsgGUID: 9AEAlIdhSqyxtJvx8Zz94Q==
X-IronPort-AV: E=Sophos;i="6.16,248,1744041600"; 
   d="scan'208";a="90895133"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2025 17:03:44 +0800
IronPort-SDR: 6853c3fa_k6lIxIwuvjWF4AQ5u+Bj8g1WOCbNtUL2uZeNqythOToqsYc
 rLdgxmjrULV23DhH8akp9nSYjlxiVpDepYQ8Nmg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 01:02:02 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 02:03:42 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Sarthak Garg <quic_sartgarg@quicinc.com>,
	Abraham Bachrach <abe@skydio.com>,
	Prathamesh Shete <pshete@nvidia.com>,
	Bibek Basu <bbasu@nvidia.com>,
	Sagiv Aharonoff <saharonoff@nvidia.com>,
	Avri Altman <avri.altman@sandisk.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mmc: core sd: Simplify current limit logic for 200mA default
Date: Thu, 19 Jun 2025 11:56:19 +0300
Message-Id: <20250619085620.144181-2-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250619085620.144181-1-avri.altman@sandisk.com>
References: <20250619085620.144181-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SD current limit logic is updated to avoid explicitly setting the
current limit when the maximum power is 200mA (0.72W) or less, as this
is already the default value. The code now only issues a current limit
switch if a higher limit is required, and the unused
SD_SET_CURRENT_NO_CHANGE constant is removed. This reduces unnecessary
commands and simplifies the logic.

Fixes: 0aa6770000ba ("mmc: sdhci: only set 200mA support for 1.8v if 200mA is available")
Signed-off-by: Avri Altman <avri.altman@sandisk.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/core/sd.c    | 7 ++-----
 include/linux/mmc/card.h | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ec02067f03c5..cf92c5b2059a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -554,7 +554,7 @@ static u32 sd_get_host_max_current(struct mmc_host *host)
 
 static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 {
-	int current_limit = SD_SET_CURRENT_NO_CHANGE;
+	int current_limit = SD_SET_CURRENT_LIMIT_200;
 	int err;
 	u32 max_current;
 
@@ -598,11 +598,8 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	else if (max_current >= 400 &&
 		 card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_400)
 		current_limit = SD_SET_CURRENT_LIMIT_400;
-	else if (max_current >= 200 &&
-		 card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_200)
-		current_limit = SD_SET_CURRENT_LIMIT_200;
 
-	if (current_limit != SD_SET_CURRENT_NO_CHANGE) {
+	if (current_limit != SD_SET_CURRENT_LIMIT_200) {
 		err = mmc_sd_switch(card, SD_SWITCH_SET, 3,
 				current_limit, status);
 		if (err)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index ddcdf23d731c..e9e964c20e53 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -182,7 +182,6 @@ struct sd_switch_caps {
 #define SD_SET_CURRENT_LIMIT_400	1
 #define SD_SET_CURRENT_LIMIT_600	2
 #define SD_SET_CURRENT_LIMIT_800	3
-#define SD_SET_CURRENT_NO_CHANGE	(-1)
 
 #define SD_MAX_CURRENT_200	(1 << SD_SET_CURRENT_LIMIT_200)
 #define SD_MAX_CURRENT_400	(1 << SD_SET_CURRENT_LIMIT_400)
-- 
2.25.1


