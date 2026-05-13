Return-Path: <stable+bounces-246817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EDtCyZlBGq6HgIAu9opvQ
	(envelope-from <stable+bounces-246817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:48:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C5E532835
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5756F301904A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07773E9C37;
	Wed, 13 May 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr8PHN3N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738841427A
	for <stable@vger.kernel.org>; Wed, 13 May 2026 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672931; cv=none; b=eGGNdIThpnICTCbD5z0cA2PYPUpx/pEOT8w9BvZyHWIO8t0WbEDq4MLMld+WiE3bkYotgrVUx02JLNXsQ3gIh2B2rAwK+BDvuZxYwwJo1AIKFU4qEJS17iHfPSNcSfNsTvhzbV40TYgBh61jfrDke7N+IvLloxabxQxjlhm7VXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672931; c=relaxed/simple;
	bh=BHKTETEQu3Taj+tpAANs9wrsMAn8zzxIXvNZpIG/heI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAL3lmJTREvl9T1k0Uamb1wzCcb/VisMU/4iNoew2i7hzc0N4fz0gFayBAVnBa5Gz95hd2VkSjKzL5tubN1KgnY26KvgYU8hnWCHNCrs3OcCDh/TOy+J2fHI6ryg6gpUarNAHAZt12ypI1KfEX15Kw5jWyqRr8RDJ5/BXrBMuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr8PHN3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3B4C2BCB7;
	Wed, 13 May 2026 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778672931;
	bh=BHKTETEQu3Taj+tpAANs9wrsMAn8zzxIXvNZpIG/heI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rr8PHN3NBKaU5Xpq0ZjXLLMB3i9c64dcx/oYil9qLSZpy001UM2xoLSMQvPLYXtHh
	 ldsj4UbKDrYAcaV8Xx2Z4do/9FklHHmu+QZR/0pyPutbmr8YP8vEKxNUnMoCL9MFAS
	 wCZrEGEFYEzAcldSG8Ab6lDHh4S1M2HnIkrr+cZ3uiWoTN5E3em8ukf5ODjWBe6Pmu
	 Hu8xPQlFNvA8STl4WS2ppdGrZ9UBYYBTFQ135/6p2TIauWkX6hEHIoXVgEEBCjxiB3
	 +EJyIAYPUHfBnl+WgFRYzEswqib6midvdger/qcje661A0gS/PiBb15b4MJGlOVIjb
	 mIjCGd2t/zFBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mac80211: remove station if connection prep fails
Date: Wed, 13 May 2026 07:48:48 -0400
Message-ID: <20260513114848.3692309-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051217-dodge-brutishly-7223@gregkh>
References: <2026051217-dodge-brutishly-7223@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91C5E532835
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246817-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 283fc9e44ff5b5ac967439b4951b80bd4299f4e4 ]

If connection preparation fails for MLO connections, then the
interface is completely reset to non-MLD. In this case, we must
not keep the station since it's related to the link of the vif
being removed. Delete an existing station. Any "new_sta" is
already being removed, so that doesn't need changes.

This fixes a use-after-free/double-free in debugfs if that's
enabled, because a vif going from MLD (and to MLD, but that's
not relevant here) recreates its entire debugfs.

Cc: stable@vger.kernel.org
Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260505151533.c4e52deb06ad.Iafe56cec7de8512626169496b134bce3a6c17010@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ used sta_info_destroy_addr() instead of __sta_info_destroy() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 30db27df6b793..aa9aaa9cb42b6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6586,7 +6586,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct sta_info *new_sta = NULL;
 	struct ieee80211_link_data *link;
-	bool have_sta = false;
+	struct sta_info *have_sta = NULL;
 	bool mlo;
 	int err;
 
@@ -6751,6 +6751,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 
 out_err:
 	ieee80211_link_release_channel(&sdata->deflink);
+	if (mlo && have_sta)
+		WARN_ON(sta_info_destroy_addr(sdata, ap_mld_addr));
 	ieee80211_vif_set_links(sdata, 0);
 	return err;
 }
-- 
2.53.0


