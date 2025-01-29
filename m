Return-Path: <stable+bounces-111177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F752A21F40
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA188188578D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2721BD9E6;
	Wed, 29 Jan 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gITaoJVu"
X-Original-To: stable@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672661AE01B
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161243; cv=none; b=lv7UaTdljij4Vf9F0Hfd/npwPk3jMSsqet1krSxFFlDZ2VZgS6BNgEKkToxB3Ja92AOLAvK7tEE2ncS6iSNSJHg3DZlQYIM7hhFSuKAmlNVxBQqDHdJNSo4llGTuhHVgMPiMsN7+PiDQpq3myZ81nWoK1whQBRMRfpvOmEeYtoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161243; c=relaxed/simple;
	bh=OAbSngCjsVRryUWICk1n/syeoh02raPh4r3D1y1qVtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Blu/bTgOGibBYnuymJHLuMJQWJYANj46XWPSXXgAA4BIFjZiTnG65KhQAEfTXRpYlNA6I7pwcJB+kAoMiC3GXUDKn0UEptANr1rl4vmR04uElHz86lbVyn4h6MTtNjvBBhl6/mY3YyHaUZcotXJ/zJMEqgF90ODfJXK5ZYjbZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=gITaoJVu; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:86a3:0:640:3a48:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id BEC9160903;
	Wed, 29 Jan 2025 17:33:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pXfKqmBOra60-kqWPLICz;
	Wed, 29 Jan 2025 17:33:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738161232; bh=V8c9VXVJn9yjtHGrqT6qzQq+hqk1HI2XrjxMPiNIyJA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=gITaoJVu6A469WGpAGgXo1ufSCctmEy2BIt8MMUiAENeY+i7do+C+lPizVwcECgT4
	 9vhUHNDL0MLDqZ/J7cJ636uNRniyFxj7lM00lC0MZgBhceFdKALdw/va2WIAvygl30
	 hH9if2rkH3Gfy2n7kP0HIVPUIWCb0am/mzzv7rU4=
Authentication-Results: mail-nwsmtp-smtp-production-main-13.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.15] wifi: iwlwifi: add a few rate index validity checks
Date: Wed, 29 Jan 2025 17:33:43 +0300
Message-ID: <20250129143343.2449440-1-dmantipov@yandex.ru>
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
index b97708cb869d..2078768b6824 100644
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
  *
@@ -1119,10 +1119,13 @@ static void rs_get_lower_rate_down_column(struct iwl_lq_sta *lq_sta,
 
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


