Return-Path: <stable+bounces-110952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF7A20834
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 11:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98750162375
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131661991CA;
	Tue, 28 Jan 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lob9ycLn"
X-Original-To: stable@vger.kernel.org
Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9390198A37
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058804; cv=none; b=cbJhS+BqSD+9QUlydSVkZWywKdDQZcGlSblObwwrxW2YxSU/iKZxaQ7ANs2BPx4ORTx1YjnyH+LjkvgON9VWg1dUs78Qd3WWiRPPxrOSNqZN//zz460H26d14rsK5YkZeumsjpxUn6NiA+ef/TXJOZqOh3U/aMY9N6d14g+/7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058804; c=relaxed/simple;
	bh=MkkISYJbW2pEzmd1RXSKydEfRKeEu/k9KphfyVhBPM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blJ6/eJHIRR2RfJMNncbvoB4rkqGJj3MwRsq7gF8ibOEms25Zx9+Fu1hIg1S4P7rWF6MaPBFLltPO7NYmTzgEbyWue7f6HhmDLgxIwWROgqH9rg0Wae3yPESNIDUh+n5T8IinVuP4GwWymsuD0nlteaLFjVlqOU2HhxCqiLV/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=lob9ycLn; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward204a.mail.yandex.net (Yandex) with ESMTPS id D47C068F29
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 12:59:26 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:bc0:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 841564723A;
	Tue, 28 Jan 2025 12:59:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HxZKvMwOdSw0-hLSXDptl;
	Tue, 28 Jan 2025 12:59:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738058359; bh=wGJwVxZgqWXAoCgPVMX8n+yXcqsrvrBBGrUcyuuDWLM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=lob9ycLnmHqUO9hajm95q4Z75yf7tx80g2KA6NydTZeMRuVIFLeeKbHojAz5HRmm+
	 ZZoYFfYjAIvD17yMrTLjaCYjUHMhLuC3oM4oNy8GyrEsiS2MuZX8eEnOAaY4ac/jnz
	 K+TcoBcKbLxPeij46diO/Hf81wU5bcPk7GS7/5Pw=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 5.10] wifi: iwlwifi: add a few rate index validity checks
Date: Tue, 28 Jan 2025 12:58:02 +0300
Message-ID: <20250128095802.1410328-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

commit efbe8f81952fe469d38655744627d860879dcde8 upstream.

Validate index before access iwl_rate_mcs to keep rate->index
inside the valid boundaries. Use MCS_0_INDEX if index is less
than MCS_0_INDEX and MCS_9_INDEX if index is greater than
MCS_9_INDEX.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230614123447.79f16b3aef32.If1137f894775d6d07b78cbf3a6163ffce6399507@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c |  9 ++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 12 ++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 548540dd0c0f..a2b477bc574a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2019 - 2020 Intel Corporation
+ * Copyright (C) 2019 - 2020, 2023 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -130,7 +130,7 @@ static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
 				return idx;
 	}
 
-	return -1;
+	return IWL_RATE_INVALID;
 }
 
 static void rs_rate_scale_perform(struct iwl_priv *priv,
@@ -3151,7 +3151,10 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 	for (i = 0; i < LINK_QUAL_MAX_RETRY_NUM; i++) {
 		index = iwl_hwrate_to_plcp_idx(
 			le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags));
-		if (is_legacy(tbl->lq_type)) {
+		if (index == IWL_RATE_INVALID) {
+			desc += sprintf(buff + desc, " rate[%d] 0x%X invalid rate\n",
+				i, le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags));
+		} else if (is_legacy(tbl->lq_type)) {
 			desc += sprintf(buff+desc, " rate[%d] 0x%X %smbps\n",
 				i, le32_to_cpu(lq_sta->lq.rs_table[i].rate_n_flags),
 				iwl_rate_mcs[index].mbps);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index ed7382e7ea17..0a9634d9006c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2018 - 2020, 2023 Intel Corporation.
+ * All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *
@@ -1120,10 +1121,13 @@ static void rs_get_lower_rate_down_column(struct iwl_lq_sta *lq_sta,
 
 		rate->bw = RATE_MCS_CHAN_WIDTH_20;
 
-		WARN_ON_ONCE(rate->index < IWL_RATE_MCS_0_INDEX ||
-			     rate->index > IWL_RATE_MCS_9_INDEX);
+		if (WARN_ON_ONCE(rate->index < IWL_RATE_MCS_0_INDEX))
+			rate->index = rs_ht_to_legacy[IWL_RATE_MCS_0_INDEX];
+		else if (WARN_ON_ONCE(rate->index > IWL_RATE_MCS_9_INDEX))
+			rate->index = rs_ht_to_legacy[IWL_RATE_MCS_9_INDEX];
+		else
+			rate->index = rs_ht_to_legacy[rate->index];
 
-		rate->index = rs_ht_to_legacy[rate->index];
 		rate->ldpc = false;
 	} else {
 		/* Downgrade to SISO with same MCS if in MIMO  */
-- 
2.48.1


