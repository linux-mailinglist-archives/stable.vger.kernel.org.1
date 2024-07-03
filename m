Return-Path: <stable+bounces-57084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A8925A97
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E281F2170D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA8817A5B6;
	Wed,  3 Jul 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kgc1A2JJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34517A5B0;
	Wed,  3 Jul 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003795; cv=none; b=UvS/PFlaJwJSp6svZkHfRDJVSl9kh+I2M++OHXb653BWQ6rBXnEVUhUtG2511hHcRhuBkF5fLDFhIH2zfkfSUiMFhZoe+7qX+qzWVXxLsHBrg+acAZX2BcnV2I+E+SvsYPRDnyaPhob7u7InraUFgj/Eraa2x83K1ZvCWeCzIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003795; c=relaxed/simple;
	bh=YSNd/sdLxDpvb5a1I7/VosOHaz2S4Lm8o5hKT05zqFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQGd+0bAJACV2QkLkTMxI2SPWgFU0aCS+UEbT5onfkklCfjs4J+lOD/OhxDXrhWatgnUWp3THoeysRVSX+ZypVgZwnWC2DAzdiplZ0b3BjaK+5IVSthDpb4VMcCwMo8t2pAYkSXWK7V2O8ON6UegtM9QJOutHg8En6Ak73AAAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kgc1A2JJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EA8C2BD10;
	Wed,  3 Jul 2024 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003795;
	bh=YSNd/sdLxDpvb5a1I7/VosOHaz2S4Lm8o5hKT05zqFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kgc1A2JJ3m7YYjauB6bDfDTVT6/4KkakKA7B3v3L/tginNuPCB7uaiFtDkiQf53AW
	 X/tvNP8JvJMCRJSXHC5As0wEjJ2BVc1a+xLfvrFJBKic4oxwhBKXrGXylMS8S2t+xD
	 SkvLqHGIzyIz1PcSVJzC3zjc+5fr8uaVhPi1NtyM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 006/189] wifi: iwlwifi: mvm: dont read past the mfuart notifcation
Date: Wed,  3 Jul 2024 12:37:47 +0200
Message-ID: <20240703102841.741634788@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 4bb95f4535489ed830cf9b34b0a891e384d1aee4 ]

In case the firmware sends a notification that claims it has more data
than it has, we will read past that was allocated for the notification.
Remove the print of the buffer, we won't see it by default. If needed,
we can see the content with tracing.

This was reported by KFENCE.

Fixes: bdccdb854f2f ("iwlwifi: mvm: support MFUART dump in case of MFUART assert")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240513132416.ba82a01a559e.Ia91dd20f5e1ca1ad380b95e68aebf2794f553d9b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index c5b08a68f6fa1..27bd9ed48bec4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -197,20 +197,10 @@ void iwl_mvm_mfu_assert_dump_notif(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mfu_assert_dump_notif *mfu_dump_notif = (void *)pkt->data;
-	__le32 *dump_data = mfu_dump_notif->data;
-	int n_words = le32_to_cpu(mfu_dump_notif->data_size) / sizeof(__le32);
-	int i;
 
 	if (mfu_dump_notif->index_num == 0)
 		IWL_INFO(mvm, "MFUART assert id 0x%x occurred\n",
 			 le32_to_cpu(mfu_dump_notif->assert_id));
-
-	for (i = 0; i < n_words; i++)
-		IWL_DEBUG_INFO(mvm,
-			       "MFUART assert dump, dword %u: 0x%08x\n",
-			       le16_to_cpu(mfu_dump_notif->index_num) *
-			       n_words + i,
-			       le32_to_cpu(dump_data[i]));
 }
 
 static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
-- 
2.43.0




