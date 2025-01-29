Return-Path: <stable+bounces-111175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EC1A21F3C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1EA18844D8
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37C428FF;
	Wed, 29 Jan 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SUypE/Pm"
X-Original-To: stable@vger.kernel.org
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524AD1D9329
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161173; cv=none; b=b09Dw6bv1q9VV/Aa/rX9vdcJ3Gtji20gsiR/M0CO102AzmF1otpL2VruHm6+rFBFckDwdGnaO7OkoWGWITRJ+pvsbNm7phjnzvTpKwb+UxD9/nEZuapudC7mBg1vkujKsXiJ5CUjhI8sKk8FsH7M9pcro/o1x4LgRNRmwqqzULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161173; c=relaxed/simple;
	bh=U8rlgThjsGFgj7cNfPboHCsiz626NrixCr4oBKGERRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSErnIBZEFrvh+p2ELbHvQnApB8gnSwXZEuyRFBqyAGq7ML3sjeShEtBOX+8O6W1P+o9t7mqtgI3wa2STC0gB0f4oX/Dij1aXe9nDX0pzmYtLC20KzjPkzb7HbalN0aEo0oBZYO/nzA2smeB6x0jEPmUg47q+L1BzrGvU4yoM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SUypE/Pm; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id 798B161EA9
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 17:32:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:86a3:0:640:3a48:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 2D39760911;
	Wed, 29 Jan 2025 17:32:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VWfbJmBOluQ0-K7pOm2Tj;
	Wed, 29 Jan 2025 17:32:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738161153; bh=S1kPFBKGp2DxCx9k82IOIfyMpq9vrmTQ+ecxLQjdU5k=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=SUypE/PmWl79RiLtAALDWBk7RNHP3zQp7s+jHjF8eVS7N6HkuCQRFqb4n/rGBJUJr
	 w/8n3GZjQoq7GErY7LgDWmVgkeLTNoIhNQF42jHlKqoPpsOxb+Nberc8SAwYax2vRX
	 SDvyLzgHtuLO7JGOBpcgobBBPvogFol4UNHyHN6w=
Authentication-Results: mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 6.1] wifi: iwlwifi: add a few rate index validity checks
Date: Wed, 29 Jan 2025 17:32:30 +0300
Message-ID: <20250129143230.2449278-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025012949-unclasp-probation-a0df@gregkh>
References: <2025012949-unclasp-probation-a0df@gregkh>
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
v2: (re)adjust copyright notice
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c |  9 ++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 11 +++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 687c906a9d72..4b1f006c105b 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2019 - 2020, 2022 Intel Corporation
+ * Copyright (C) 2019 - 2020, 2022 - 2023 Intel Corporation
  *****************************************************************************/
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
@@ -125,7 +125,7 @@ static int iwl_hwrate_to_plcp_idx(u32 rate_n_flags)
 				return idx;
 	}
 
-	return -1;
+	return IWL_RATE_INVALID;
 }
 
 static void rs_rate_scale_perform(struct iwl_priv *priv,
@@ -3146,7 +3146,10 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
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
index 2be6801d48ac..ef9ecc4650d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2018 - 2023 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *****************************************************************************/
@@ -1072,10 +1072,13 @@ static void rs_get_lower_rate_down_column(struct iwl_lq_sta *lq_sta,
 
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


