Return-Path: <stable+bounces-220379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM2zHsA0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAE51C5EC9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE4593104A83
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9533A59EC;
	Sat, 28 Feb 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT8/897L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA633A59E3;
	Sat, 28 Feb 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300273; cv=none; b=CXxS/nqeNKmZBH5Fv4f0mvgN3xmaS3vejo/gkI9YmpNByo4oGPyoIF7mdK166i+lbYmpuk2GaJRe47Jfuv2zQYbQJ1bNY24JgIaa/qoFFhxJEUXin1Zz+mRGUknofT8Vu68T7q3tMq2eytZhkoJPIUYcTwKl0exxGHl7AA9RLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300273; c=relaxed/simple;
	bh=gJvoOS1G0SEBpK4bqZ8aDz5SyzG1f22OCR2LHiixi40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+Cymq/AJm21vLKrLjgC8uB7eDofqlTdRM294oIp6eUpwwCf6pzc9ek8ymfcmdg6aXwp6hEzS5aN7rBanBLU3ZV2rufOSEUK47O0HMgeYLHZQXHtee5xjWDDyEqmHWucOUXdbAunQkFsDaLFJnD8wGsvvNeONUdtW0DIRgGObms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT8/897L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBF5C2BCAF;
	Sat, 28 Feb 2026 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300273;
	bh=gJvoOS1G0SEBpK4bqZ8aDz5SyzG1f22OCR2LHiixi40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qT8/897LhbaKSNP9pdDB3E3Sh4KaFMpJ/BYeBI5avwBPsZyT6piOyeNUtpD2yj5qk
	 8iUMYU/oUnFL6dYWnQZffq2HCGOdHwu/+FhuegP6khdCuU7TNlqhqbVXIr73eMFaaI
	 N+vQvNxNUkOWeZv6IU1uk4bh4KJW3fPCJLicnrOU8iaF/S/QlE4gffhxDAg/FgPNRg
	 SobXwY94dhWHhVgkqrKM5Lv8qyA7jx1N5iLf+oybrPrcUzP3FDkxZfmVc64aFA6dB7
	 jsPozlAsk2gt638MX3Wm7kQVviqW9LYM5G1moET8tuc7tKlteHltiLmRQtz1UZCOu3
	 ok6ymL3bMQLmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nidhish A N <nidhish.a.n@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 300/844] wifi: iwlwifi: mld: Fix primary link selection logic
Date: Sat, 28 Feb 2026 12:23:33 -0500
Message-ID: <20260228173244.1509663-301-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220379-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 5AAE51C5EC9
X-Rspamd-Action: no action

From: Nidhish A N <nidhish.a.n@intel.com>

[ Upstream commit 7a749db26cab2334d5b356ac31e6f1147c7682da ]

When assigning emlsr.primary with emlsr.selected_primary
we are checking if BIT(mld_vif->emlsr.selected_links) are
a part of vif->active_links. This is incorrect as
emlsr.selected_links is a bitmap of possibly two selected links.
Therefore, performing the BIT() operation on it does not
yield any meaningful result and almost always leads to
incorrect primary link selection.

Additionally, we cannot rely on vif->active_links at this
stage of the link switch flow because it contains both the
removed links and also the newly added links.
For example, if we had selected links in the past (0x11)
and we now select links because of TTLM/debugfs (0x100),
vif->active_links will now be (0x111) and primary link
will be 0, while 0 is not even an active link. Thus,
we create our own bitmap of final active links.

Signed-off-by: Nidhish A N <nidhish.a.n@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260111193638.38b2e14e3a20.Ie81a88dfff0c5d2becedabab8398702808f6b1bf@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index cd0dce8de8569..3a1b5bfb9ed66 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -984,7 +984,9 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
-	unsigned int n_active = iwl_mld_count_active_links(mld, vif);
+	struct iwl_mld_link *temp_mld_link;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	u16 final_active_links = 0;
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
@@ -992,10 +994,7 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 	if (WARN_ON(!mld_link))
 		return -EINVAL;
 
-	/* if the assigned one was not counted yet, count it now */
 	if (!rcu_access_pointer(mld_link->chan_ctx)) {
-		n_active++;
-
 		/* Track addition of non-BSS link */
 		if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION) {
 			ret = iwl_mld_emlsr_check_non_bss_block(mld, 1);
@@ -1016,17 +1015,25 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(mld_link->chan_ctx, ctx);
 
-	if (n_active > 1) {
-		struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	/* We cannot rely on vif->active_links at this stage as it contains
+	 * both the removed links and the newly added links.
+	 * Therefore, we create our own bitmap of the final active links,
+	 * which does not include the removed links.
+	 */
+	for_each_mld_vif_valid_link(mld_vif, temp_mld_link) {
+		if (rcu_access_pointer(temp_mld_link->chan_ctx))
+			final_active_links |= BIT(link_id);
+	}
 
+	if (hweight16(final_active_links) > 1) {
 		/* Indicate to mac80211 that EML is enabled */
 		vif->driver_flags |= IEEE80211_VIF_EML_ACTIVE;
 		mld_vif->emlsr.last_entry_ts = jiffies;
 
-		if (vif->active_links & BIT(mld_vif->emlsr.selected_links))
+		if (final_active_links == mld_vif->emlsr.selected_links)
 			mld_vif->emlsr.primary = mld_vif->emlsr.selected_primary;
 		else
-			mld_vif->emlsr.primary = __ffs(vif->active_links);
+			mld_vif->emlsr.primary = __ffs(final_active_links);
 
 		iwl_dbg_tlv_time_point(&mld->fwrt, IWL_FW_INI_TIME_ESR_LINK_UP,
 				       NULL);
-- 
2.51.0


