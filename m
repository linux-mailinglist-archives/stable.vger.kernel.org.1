Return-Path: <stable+bounces-171335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26BDB2A927
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48686E3F64
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0232276D;
	Mon, 18 Aug 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wRqX1KrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0F320380;
	Mon, 18 Aug 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525576; cv=none; b=rncd8G5FnLhwSqe7+XNP5HbDQIG722VahadWf6p0KoSZT8ak5ZMbFHtzRSWtOkT6knNUHJNijyGymkdCjQarKnF2CdU4ws7KEclta0sOQ0n0hMnOZfFD79vJyAc+Kntqud9hoHFAiiAs3FK6nfk/EZQ61GQD4vUPdJ0au2UBUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525576; c=relaxed/simple;
	bh=vDnhjm7GZSNwxqqFYYNSN1yjFAXN8Yb5mR0Q84kR9lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQwYqHBQ18qxG2x9rtnXf++J8C0AMuP8Fz9TvhndN0IEh2vzsRBtlUdu1qujzinnfmpjBPjdQ9Np0cVXaXo3Sn13x89Opu04X4hr9silSq8EPI0LrE6uWTCUc+qF6L0JrFqc4nnnAaQHS8VNauUHU7H0rutl3aDfrzwZe5fL/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wRqX1KrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92612C4CEEB;
	Mon, 18 Aug 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525576;
	bh=vDnhjm7GZSNwxqqFYYNSN1yjFAXN8Yb5mR0Q84kR9lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wRqX1KrTWZeihb38NYET/4RVZEvAkcyIQnb2Q51/hf8h7ptTu6OBdB/5yMU2vWA+i
	 5VSB7ZdHfRjhyn1ywcISNyBlG286FU1FioX7nHOj7pPEGzWzf2Sy2NAyJPfSXYEHoG
	 jF+hqMT/P7CSlBoWxXGX9OgmQikEumDlm9fWZXWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 303/570] wifi: iwlwifi: mld: dont exit EMLSR when we shouldnt
Date: Mon, 18 Aug 2025 14:44:50 +0200
Message-ID: <20250818124517.534176762@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 0cdb8ff6ebbac55f38933f4621215784887b400e ]

There is a requirement to exit EMLSR if there wasn't enough throughput
in the secondary link.
This is checked in check_tpt_wk, which runs every 5 seconds in a high
throughput scenario (when the throughput blocker isn't set)

It can happen that this worker is running immediately after we entered
EMLSR, and in that case the secondary link didn't have a chance to have
throughput. In that case we will exit EMLSR for no good reason.

Fix this by tracking the time we entered EMLSR, and in the worker make
sure that 5 seconds passed from when we entered EMLSR. If not, don't
check the secondary link throughput.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250612144708.c680f8d7dc37.I8a02d1e8d99df3789da8d5714f19b31a865a61ff@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.h    | 3 +++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 1 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c      | 8 +++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 49e2ce65557d..f64d0dcbb178 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -87,6 +87,8 @@ enum iwl_mld_emlsr_exit {
  * @last_exit_reason: Reason for the last EMLSR exit
  * @last_exit_ts: Time of the last EMLSR exit (if @last_exit_reason is non-zero)
  * @exit_repeat_count: Number of times EMLSR was exited for the same reason
+ * @last_entry_ts: the time of the last EMLSR entry (if iwl_mld_emlsr_active()
+ *	is true)
  * @unblock_tpt_wk: Unblock EMLSR because the throughput limit was reached
  * @check_tpt_wk: a worker to check if IWL_MLD_EMLSR_BLOCKED_TPT should be
  *	added, for example if there is no longer enough traffic.
@@ -105,6 +107,7 @@ struct iwl_mld_emlsr {
 		enum iwl_mld_emlsr_exit last_exit_reason;
 		unsigned long last_exit_ts;
 		u8 exit_repeat_count;
+		unsigned long last_entry_ts;
 	);
 
 	struct wiphy_work unblock_tpt_wk;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 4ba050397632..c1e56c4010da 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1002,6 +1002,7 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 		/* Indicate to mac80211 that EML is enabled */
 		vif->driver_flags |= IEEE80211_VIF_EML_ACTIVE;
+		mld_vif->emlsr.last_entry_ts = jiffies;
 
 		if (vif->active_links & BIT(mld_vif->emlsr.selected_links))
 			mld_vif->emlsr.primary = mld_vif->emlsr.selected_primary;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index dba5379ed009..d71259ce1db1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -530,10 +530,12 @@ void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 	/*
 	 * TPT is unblocked, need to check if the TPT criteria is still met.
 	 *
-	 * If EMLSR is active, then we also need to check the secondar link
-	 * requirements.
+	 * If EMLSR is active for at least 5 seconds, then we also
+	 * need to check the secondary link requirements.
 	 */
-	if (iwl_mld_emlsr_active(vif)) {
+	if (iwl_mld_emlsr_active(vif) &&
+	    time_is_before_jiffies(mld_vif->emlsr.last_entry_ts +
+				   IWL_MLD_TPT_COUNT_WINDOW)) {
 		sec_link_id = iwl_mld_get_other_link(vif, iwl_mld_get_primary_link(vif));
 		sec_link = iwl_mld_link_dereference_check(mld_vif, sec_link_id);
 		if (WARN_ON_ONCE(!sec_link))
-- 
2.39.5




