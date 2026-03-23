Return-Path: <stable+bounces-228318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO+wJ3tLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:17:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 657082F419B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C895A307D9B0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6383B19CA;
	Mon, 23 Mar 2026 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mUFmPn6h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FC3AE1A6;
	Mon, 23 Mar 2026 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274792; cv=none; b=jOvgCWmv0I8B4fD/RJpwW6myj4jmX+Q3gK3hArHKm6FCdE/neQoAOfXSiRo/cWqYmsah1y/i064Bmbzdycm/E+X8mrDqUYp97xGVkf55RVDNPsJ/c/7+XOizD3dtC4+HJAta0ADWQ6exR/KuKtF+9/6wJqfhky/+Svsbp6q/JpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274792; c=relaxed/simple;
	bh=nELRHhvL43eu5wbVfLGsPp7jMk27eMUL1eB54DTktwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRSZEn+gG1rh0ZldsDNJB/YpAlXm94Ct3glMGAr7PXLhifUdYA4qoJ74Hdee7agH5hjgy7WdgNbLX0nQHIsBeAdrzityX4o26gpzVtqMNEcUq7LqOYoBdwwiZ4BdA8U8j96Mg7ElSuCkGnqYXaiGzWvZGF24qbLmg/f+HNHXhyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mUFmPn6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CAEC4CEF7;
	Mon, 23 Mar 2026 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274792;
	bh=nELRHhvL43eu5wbVfLGsPp7jMk27eMUL1eB54DTktwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUFmPn6hSfrysaE1rHtmGydepVQSFqvkWIwavCfEn738nWY4+c3bJGAPty8G7Iia8
	 xrYLg/oK8dr9n35l6ECpfRy42FMEi6L+5Up8UH5E93abjJmXI2mqF6qsuODGcqij7Z
	 NXDhX+Vvse5siM+C//WA3Dj8etlWvB6Norr5Zvjw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 109/212] wifi: mac80211: use jiffies_delta_to_msecs() for sta_info inactive times
Date: Mon, 23 Mar 2026 14:45:30 +0100
Message-ID: <20260323134507.227950388@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228318-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 657082F419B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

[ Upstream commit ac6f24cc9c0a9aefa55ec9696dcafa971d4d760b ]

Inactive times of around 0xffffffff milliseconds have been observed on
an ath9k device on ARM.  This is likely due to a memory ordering race in
the jiffies_to_msecs(jiffies - last_active()) calculation causing an
overflow when the observed jiffies is below ieee80211_sta_last_active().

Use jiffies_delta_to_msecs() instead to avoid this problem.

Fixes: 7bbdd2d98797 ("mac80211: implement station stats retrieval")
Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Link: https://patch.msgid.link/20260303161701.31808-1-nicolas.cavallari@green-communications.fr
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 1a995bc301b19..b0d9bb830f293 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2759,7 +2759,9 @@ static void sta_set_link_sinfo(struct sta_info *sta,
 	}
 
 	link_sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, link_id));
+		jiffies_delta_to_msecs(jiffies -
+				       ieee80211_sta_last_active(sta,
+								 link_id));
 
 	if (!(link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 				    BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
@@ -2992,7 +2994,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
 	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
-		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta, -1));
+		jiffies_delta_to_msecs(jiffies -
+				       ieee80211_sta_last_active(sta, -1));
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
-- 
2.51.0




