Return-Path: <stable+bounces-110953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA439A2083D
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 11:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DD73A89A3
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB519CC0C;
	Tue, 28 Jan 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KgvhKTga"
X-Original-To: stable@vger.kernel.org
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCF199FC1
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058822; cv=none; b=RP74mE/nXxktMHdA9HYIRzpG+CNSv9wHxUTA3oVvJg4WVbfTz4FHl/VeoFzH//lQOSGD+jBPBNr+mGAG1JwpDAiIH3hbFBZJRhFUP7LGaqTLdcj/nRm9CPIOSXIoVSVvv/KAXkHXaIPLgexbjYzCwzspVdguPhiVP2M1hN8kbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058822; c=relaxed/simple;
	bh=0uqN4eyspynM4MhrIDloshQDTKZ2NownYu44OKHFuCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8I5TPHYYlHSs2aqRygokUh+1qs352eAS6f0QAbNl3Q5xCWy1U3eM5wBQhkgdsDlcIzkdr+8/3uN8nJ5yosMoXDflemeqRPoFtllsNihGhcph727OAt5hs9aZ+I6CEdNyVhMt56vrwPYORxTARzd0QLO2tuWew+TIJEOcPOUiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=KgvhKTga; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id 89639690F8
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 13:00:01 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:bc0:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 0DE7260D91;
	Tue, 28 Jan 2025 12:59:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rxZaDNwOp0U0-tBGQ9o8j;
	Tue, 28 Jan 2025 12:59:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738058393; bh=V7JBNa6ahKZxtAV4tOxMIloYoNivAWoyF+CMWCtbNgU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=KgvhKTgaKYwTqgCvPphxiMa0m7wUhNRtAD97jp1/zghPp4YuX7swZRGPMJXU+uoFo
	 pSfCkT8X2OYmtciIoN5ILfYoYW9I+3KqOXq7hz76UyfYCWhGJbSt3zDRTlnh9Gr2oY
	 LUKKmrQ0Je/TKcGbDziJqLfw2ZMSGGQ8jsKu80I0=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6.1] wifi: iwlwifi: add a few rate index validity checks
Date: Tue, 28 Jan 2025 12:59:35 +0300
Message-ID: <20250128095935.1413363-1-dmantipov@yandex.ru>
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
index 2be6801d48ac..e42387a4663a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2018 - 2021, 2023 Intel Corporation.
+ * All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *****************************************************************************/
@@ -1072,10 +1073,13 @@ static void rs_get_lower_rate_down_column(struct iwl_lq_sta *lq_sta,
 
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


