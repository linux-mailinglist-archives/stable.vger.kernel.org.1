Return-Path: <stable+bounces-111174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBCA21F13
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5C47A1583
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82D14BFA2;
	Wed, 29 Jan 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="FkClZoj1"
X-Original-To: stable@vger.kernel.org
Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6929CE8
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160800; cv=none; b=lAg3ZtYKU02r/UnMcyyx2OKkQXY/LUEvBibU/8yZh3Kmo4PfJfMwSgrs5Fc1kN4/ikmtmhImm/vPRUlo9c4zvccAKIi3HR05G8alVU73Z7nIGfQvquPafM60n46lV4gNSqNBJqInbi8o2KQylkiMJpl9h2thnaGEa97LFYUU2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160800; c=relaxed/simple;
	bh=SopdysW6cp73uCJEg4wIzY9cQC+vxmULmp+dmwRO6Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYvDWSyGITClDDQ6Yt9xkSQqADxu4oHfjVsYY/EUEUfZ4DJDhqH+weqOyUiMP5oz4TQpQKiz8Zpe1jOt+o9N5+beFwls+udxXrwmieedgrfLY7b5FjFV8AD++9lZFyhJW1QxVAT0HyNpwlaEC4Fje3gdZnzbxLtPm16bRGCXt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=FkClZoj1; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward204a.mail.yandex.net (Yandex) with ESMTPS id 3DC2B66029
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 17:26:28 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a28e:0:640:cac8:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id EBF7760EC6;
	Wed, 29 Jan 2025 17:26:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GQf6K7UOmiE0-kPC5Pmvd;
	Wed, 29 Jan 2025 17:26:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738160776; bh=o4XvJ8Z9Ojg1bvNmZf2caHxn5KEX2q7wA3Y7cJ9AjsM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=FkClZoj1ON22M2KNVR8ObdjY+iaaiaknkot7zZz93yfPIdj2WeWBad9f5ojQ3x2E7
	 nIPO7jAZOUsHTcuuctUTAeDI8nElipeaS3ypZQN1a1yJtwf/eWrYtlByCGv4kGwjHP
	 GArZbU3ysg0Xh2KkO8twEOPbC29O0u2VhVpjOrBw=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 5.10] wifi: iwlwifi: add a few rate index validity checks
Date: Wed, 29 Jan 2025 17:25:55 +0300
Message-ID: <20250129142555.2448994-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025012931-flinch-delusion-e443@gregkh>
References: <2025012931-flinch-delusion-e443@gregkh>
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
index 548540dd0c0f..e1ab5b01f1c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2019 - 2020 Intel Corporation
+ * Copyright (C) 2019 - 2020, 2022 - 2023 Intel Corporation
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
index ed7382e7ea17..9ca4f6427f77 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2005 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2018 - 2023 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *
@@ -1120,10 +1120,13 @@ static void rs_get_lower_rate_down_column(struct iwl_lq_sta *lq_sta,
 
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


