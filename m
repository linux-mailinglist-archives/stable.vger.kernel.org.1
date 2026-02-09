Return-Path: <stable+bounces-215074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJo0I+LxiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:40:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FAA110A95
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9252930557F3
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0D36828A;
	Mon,  9 Feb 2026 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t0h3x5bm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD348125B2;
	Mon,  9 Feb 2026 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647586; cv=none; b=ubPKkpJlp6xGAptJ5RqfZXrgem0VITpL4Ua6qhX3uEwEa9mW8VCILnotZAwua6r6NGCuTtYgfQjQkSf4naezahArRJX6J2EyFEB2hkpbwQ7qSrghDNm/UY4TCGIJXtqXLotC+l421swobVv799GHbg2667+Vx3Qt58AmIBBfeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647586; c=relaxed/simple;
	bh=c5FE1Fxix2YQPtyl75qTCdpdryD+w8RQMlP7BqmuaQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrSaK3MPGFqBvy2F3D3Xdy4CXQMhKyVs/S5S28XNiZl3Mtz5G0558q7vR8mi50MLfJd2KqowviLAOQOxcqKE/IEpYVTBKl1zS7XL8g6F4wYx+IAIZeSW72t71LdlzdF7mXcM7dCHIoaRLBo+dae41JSpXkcCPvZ1PwRwzx6iajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t0h3x5bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A2CC116C6;
	Mon,  9 Feb 2026 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647586;
	bh=c5FE1Fxix2YQPtyl75qTCdpdryD+w8RQMlP7BqmuaQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0h3x5bm3JeF8A6jXigy6qAXMyeoTmXrs5kGlz9wOBq4Pv8zjD+f8cZYqaJLcgFpo
	 CqVf1wR35vgAP/Z50TDSbm2BmLsgodr7f01BFLHOaVxS52sEwMr9Kkr7rk07Z0t7+C
	 t0Bp7PfOz2oHlBcINWMO6Eg7rQ6f07tSWSoGbq4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 144/175] wifi: iwlwifi: mld: cancel mlo_scan_start_wk
Date: Mon,  9 Feb 2026 15:23:37 +0100
Message-ID: <20260209142325.686189110@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215074-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: F1FAA110A95
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 5ff641011ab7fb63ea101251087745d9826e8ef5 ]

mlo_scan_start_wk is not canceled on disconnection. In fact, it is not
canceled anywhere except in the restart cleanup, where we don't really
have to.

This can cause an init-after-queue issue: if, for example, the work was
queued and then drv_change_interface got executed.

This can also cause use-after-free: if the work is executed after the
vif is freed.

Fixes: 9748ad82a9d9 ("wifi: iwlwifi: defer MLO scan after link activation")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260129212650.a36482a60719.I5bf64a108ca39dacb5ca0dcd8b7258a3ce8db74c@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c    | 2 --
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index ed379825a9236..240ce19996b34 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -55,8 +55,6 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 
 	ieee80211_iter_keys(mld->hw, vif, iwl_mld_cleanup_keys_iter, NULL);
 
-	wiphy_delayed_work_cancel(mld->wiphy, &mld_vif->mlo_scan_start_wk);
-
 	CLEANUP_STRUCT(mld_vif);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 5725104a53bf0..2a7e7417d7d84 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1755,6 +1755,8 @@ static int iwl_mld_move_sta_state_down(struct iwl_mld *mld,
 			wiphy_work_cancel(mld->wiphy, &mld_vif->emlsr.unblock_tpt_wk);
 			wiphy_delayed_work_cancel(mld->wiphy,
 						  &mld_vif->emlsr.check_tpt_wk);
+			wiphy_delayed_work_cancel(mld->wiphy,
+						  &mld_vif->mlo_scan_start_wk);
 
 			iwl_mld_reset_cca_40mhz_workaround(mld, vif);
 			iwl_mld_smps_workaround(mld, vif, true);
-- 
2.51.0




