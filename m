Return-Path: <stable+bounces-220377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PV0KbM0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF21C5EB4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22981306583B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8E3A4CFA;
	Sat, 28 Feb 2026 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg6QI1Qt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF63A4CE5;
	Sat, 28 Feb 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300272; cv=none; b=H60Avz757yVhGNLIZhHkL2q20+HiVCvpgO/W4NFDO9sKe0Ua2i06WyWN7EG/Nilf2u4/9JXOxFZNWxxa6AJH65sWAhfZF92Zw3uCChOnAo2hBVvGt2S4TTHdc4awx/4dKj1ccuTsBNFLrjwUzwSLHqahsAIaQzqiz2e7ikkCZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300272; c=relaxed/simple;
	bh=RzstUXFG7JLCuxr8fK6201BQ2AMv30CU3hWOpQjt/BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oH6ThO1eBcC4Bqkj54XvekdLrlgtC68ERvhF+QRtXXn+zg1hgIK18sR9Upb92lDsShcARMNURp3mLC2N/rBkq8YGLu7xhVIh9yW5G6709SJTY19kCjBjvuDeqiS3UQBWUzr3sdpMLLsUMLBmF03yXGZI39mX1SMGsY6L7j63rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg6QI1Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E793C116D0;
	Sat, 28 Feb 2026 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300271;
	bh=RzstUXFG7JLCuxr8fK6201BQ2AMv30CU3hWOpQjt/BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eg6QI1QtDWVEEd/ot9k+7zzHmd0Kbc8HMQqwyqDbqznJhBGKSg5PNq6zjiF6AcyrA
	 z0gmwteFKucUPrgG8ejeGV8/VZTROJo69Rml9Bpy7vJt1YIGvA1ZCKFcCy3VesTUJa
	 oseOyYofb8VYmuJtRoJF6TvSkYLKpOmmn1ETGVZCcGzPh/5s8rdRAB2uLSrcXIyIVs
	 I8v/GV+h1O8w95PgmCzuDcfcXW8jW0cGSSK2WxCMDBHeSXV6/CRa0OQLzXvfM1VPdm
	 VSFwzQrNvBxfa3uLoiqLaT1mAr5MUvlOPYFoL4GDncVDDKYHM1kc4GAozgoUf2YELb
	 CkwZXPeffBtFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 298/844] wifi: iwlwifi: fix 22000 series SMEM parsing
Date: Sat, 28 Feb 2026 12:23:31 -0500
Message-ID: <20260228173244.1509663-299-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220377-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6AAF21C5EB4
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 58192b9ce09b0f0f86e2036683bd542130b91a98 ]

If the firmware were to report three LMACs (which doesn't
exist in hardware) then using "fwrt->smem_cfg.lmac[2]" is
an overrun of the array. Reject such and use IWL_FW_CHECK
instead of WARN_ON in this function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251110150012.16e8c2d70c26.Iadfcc1aedf43c5175b3f0757bea5aa232454f1ac@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/smem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/smem.c b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
index 90fd69b4860c1..344ddde85b189 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/smem.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
@@ -6,6 +6,7 @@
  */
 #include "iwl-drv.h"
 #include "runtime.h"
+#include "dbg.h"
 #include "fw/api/commands.h"
 
 static void iwl_parse_shared_mem_22000(struct iwl_fw_runtime *fwrt,
@@ -17,7 +18,9 @@ static void iwl_parse_shared_mem_22000(struct iwl_fw_runtime *fwrt,
 	u8 api_ver = iwl_fw_lookup_notif_ver(fwrt->fw, SYSTEM_GROUP,
 					     SHARED_MEM_CFG_CMD, 0);
 
-	if (WARN_ON(lmac_num > ARRAY_SIZE(mem_cfg->lmac_smem)))
+	/* Note: notification has 3 entries, but we only expect 2 */
+	if (IWL_FW_CHECK(fwrt, lmac_num > ARRAY_SIZE(fwrt->smem_cfg.lmac),
+			 "FW advertises %d LMACs\n", lmac_num))
 		return;
 
 	fwrt->smem_cfg.num_lmacs = lmac_num;
@@ -26,7 +29,8 @@ static void iwl_parse_shared_mem_22000(struct iwl_fw_runtime *fwrt,
 	fwrt->smem_cfg.rxfifo2_size = le32_to_cpu(mem_cfg->rxfifo2_size);
 
 	if (api_ver >= 4 &&
-	    !WARN_ON_ONCE(iwl_rx_packet_payload_len(pkt) < sizeof(*mem_cfg))) {
+	    !IWL_FW_CHECK(fwrt, iwl_rx_packet_payload_len(pkt) < sizeof(*mem_cfg),
+			  "bad shared mem notification size\n")) {
 		fwrt->smem_cfg.rxfifo2_control_size =
 			le32_to_cpu(mem_cfg->rxfifo2_control_size);
 	}
-- 
2.51.0


