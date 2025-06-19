Return-Path: <stable+bounces-154770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C3AE0158
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A904D5A4450
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC027A477;
	Thu, 19 Jun 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="VhaLjpiU"
X-Original-To: stable@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F9254AF4;
	Thu, 19 Jun 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323852; cv=none; b=H3kF3xSwqhrwEertr7YTW3CD6bQ9QCwfjLESMRdJqfFDOJGlPyo1VOVPcd42ZtKnzU7D3bwZxaJ3NmQJBCMxCfVXehij5gK29Byfvi2hEktj0vnAZiXyI3zkuTaGv/TjUnlnKO10e9H9ccbDwALCsWzV2C0HUxWdXgg33dcpBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323852; c=relaxed/simple;
	bh=q5K7TIFpoWeMziPMXwIlVcLSp1opEFkBYV5nc7sHwRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCcLca+5Mwo2t1gQEL8RXZZFJk5sC1y74ci6fsNNgjrUbOjSinELme+Lv+IUhmSSI/CF8Y8qFGWDEpTuNx44H8Y0RP1O3W6IPmdkrqyxB0bPONhJQApU50u/94RhMv3oXlLuJqnoS1xdLTDvVn4oYhSg9Yw6EgpEa2TrxJQRZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=VhaLjpiU; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1750323850; x=1781859850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q5K7TIFpoWeMziPMXwIlVcLSp1opEFkBYV5nc7sHwRA=;
  b=VhaLjpiUaKDBmJCmYS891EM2Jrs91wbQ4zXLdq5fY9z2ceYy9fJ7z3wS
   fBp6HOL+gbujaAHeZwa2GJXWpefuk9m4kTQ9FYyRD9cdimpPkS/G9rutH
   MqY3gbSv58eoa+KYBnumQTw2q3Q3l9tFvW6lzVgIZjqoTSak1432Bwk6Z
   eJitWwbJtjcyRLZo0voXQRmK09H70G0FtZEx4HFN6YYRPBqDOCc6gzL/m
   DzcRCx9EboiWsOJtoil6ZrJvb+w1XKXarkef/VhqZj18RIvj+thLo/+5A
   /bq1CM7zDuMi6lQqgy3kFBuMwe+jaXe5uoW+VloOVwemV+uDq14M8y+dj
   Q==;
X-CSE-ConnectionGUID: M71oeuARRiWAoGjzhZDiOw==
X-CSE-MsgGUID: veFQadc6Q1a6AKNHFXNoNw==
X-IronPort-AV: E=Sophos;i="6.16,248,1744041600"; 
   d="scan'208";a="89784295"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2025 17:04:04 +0800
IronPort-SDR: 6853c40e_nrQjU3UbyJ3AxW1uQpWjb/0jvTunCbSqNNq0fWehp3YKDyz
 VCRteOGx7LbiKFhJ9Vsxb/UwRia0I1X8YKo3Tkw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 01:02:22 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 02:04:03 -0700
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
Subject: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current limit handling
Date: Thu, 19 Jun 2025 11:56:20 +0300
Message-Id: <20250619085620.144181-3-avri.altman@sandisk.com>
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

The SD spec says: "In UHS-I mode, after selecting one of SDR50, SDR104,
or DDR50 mode by Function Group 1, host needs to change the Power Limit
to enable the card to operate in higher performance".

The driver previously determined SD card current limits incorrectly by
checking capability bits before bus speed was established, and by using
support bits in function group 4 (bytes 6 & 7) rather than the actual
current requirement (bytes 0 & 1). This is wrong because the card
responds for a given bus speed.

This patch queries the card's current requirement after setting the bus
speed, and uses the reported value to select the appropriate current
limit.

while at it, remove some unused constants and the misleading comment in
the code.

Fixes: d9812780a020 ("mmc: sd: limit SD card power limit according to cards capabilities")
Signed-off-by: Avri Altman <avri.altman@sandisk.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/core/sd.c    | 36 +++++++++++++-----------------------
 include/linux/mmc/card.h |  6 ------
 2 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cf92c5b2059a..357edfb910df 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -365,7 +365,6 @@ static int mmc_read_switch(struct mmc_card *card)
 		card->sw_caps.sd3_bus_mode = status[13];
 		/* Driver Strengths supported by the card */
 		card->sw_caps.sd3_drv_type = status[9];
-		card->sw_caps.sd3_curr_limit = status[7] | status[6] << 8;
 	}
 
 out:
@@ -556,7 +555,7 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 {
 	int current_limit = SD_SET_CURRENT_LIMIT_200;
 	int err;
-	u32 max_current;
+	u32 max_current, card_needs;
 
 	/*
 	 * Current limit switch is only defined for SDR50, SDR104, and DDR50
@@ -575,33 +574,24 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	max_current = sd_get_host_max_current(card->host);
 
 	/*
-	 * We only check host's capability here, if we set a limit that is
-	 * higher than the card's maximum current, the card will be using its
-	 * maximum current, e.g. if the card's maximum current is 300ma, and
-	 * when we set current limit to 200ma, the card will draw 200ma, and
-	 * when we set current limit to 400/600/800ma, the card will draw its
-	 * maximum 300ma from the host.
-	 *
-	 * The above is incorrect: if we try to set a current limit that is
-	 * not supported by the card, the card can rightfully error out the
-	 * attempt, and remain at the default current limit.  This results
-	 * in a 300mA card being limited to 200mA even though the host
-	 * supports 800mA. Failures seen with SanDisk 8GB UHS cards with
-	 * an iMX6 host. --rmk
+	 * query the card of its maximun current/power consumption given the
+	 * bus speed mode
 	 */
-	if (max_current >= 800 &&
-	    card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_800)
+	err = mmc_sd_switch(card, 0, 0, card->sd_bus_speed, status);
+	if (err)
+		return err;
+
+	card_needs = status[1] | status[0] << 8;
+
+	if (max_current >= 800 && card_needs > 600)
 		current_limit = SD_SET_CURRENT_LIMIT_800;
-	else if (max_current >= 600 &&
-		 card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_600)
+	else if (max_current >= 600 && card_needs > 400)
 		current_limit = SD_SET_CURRENT_LIMIT_600;
-	else if (max_current >= 400 &&
-		 card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_400)
+	else if (max_current >= 400 && card_needs > 200)
 		current_limit = SD_SET_CURRENT_LIMIT_400;
 
 	if (current_limit != SD_SET_CURRENT_LIMIT_200) {
-		err = mmc_sd_switch(card, SD_SWITCH_SET, 3,
-				current_limit, status);
+		err = mmc_sd_switch(card, SD_SWITCH_SET, 3, current_limit, status);
 		if (err)
 			return err;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index e9e964c20e53..67c1386ca574 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -177,17 +177,11 @@ struct sd_switch_caps {
 #define SD_DRIVER_TYPE_A	0x02
 #define SD_DRIVER_TYPE_C	0x04
 #define SD_DRIVER_TYPE_D	0x08
-	unsigned int		sd3_curr_limit;
 #define SD_SET_CURRENT_LIMIT_200	0
 #define SD_SET_CURRENT_LIMIT_400	1
 #define SD_SET_CURRENT_LIMIT_600	2
 #define SD_SET_CURRENT_LIMIT_800	3
 
-#define SD_MAX_CURRENT_200	(1 << SD_SET_CURRENT_LIMIT_200)
-#define SD_MAX_CURRENT_400	(1 << SD_SET_CURRENT_LIMIT_400)
-#define SD_MAX_CURRENT_600	(1 << SD_SET_CURRENT_LIMIT_600)
-#define SD_MAX_CURRENT_800	(1 << SD_SET_CURRENT_LIMIT_800)
-
 #define SD4_SET_POWER_LIMIT_0_72W	0
 #define SD4_SET_POWER_LIMIT_1_44W	1
 #define SD4_SET_POWER_LIMIT_2_16W	2
-- 
2.25.1


