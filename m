Return-Path: <stable+bounces-263861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z9NRH9JpMWoFiwUAu9opvQ
	(envelope-from <stable+bounces-263861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D15690F17
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=RrdfjwnZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263861-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263861-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD3E31A89F0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6043D4E9;
	Tue, 16 Jun 2026 15:14:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D8438C437;
	Tue, 16 Jun 2026 15:14:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622858; cv=none; b=jgSKMlpq59ZJUbI5uGIwe2fugxYf+2Jw5lIPSr7WKZeVD7lJ+NePxU8rQubgxAfw8J5KwpalECA+ORsCWEfnVo1kZyn0pgytiZHnTD5fpwFVLJqeAVhD7X2SHe5BBvHXslA04Zg/WJBLP3iCYhL3mcd8vDsK27OVez4C6oXt87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622858; c=relaxed/simple;
	bh=nuIsfejA+IUDJTQluutFwWVqlforFS2qjTHy4u1czMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr4jehJ5oi7MuROucqIETsfbkuPxbDU+272f218qzEkQOtl1nXpaNqFZGIMNyocFVhEvgVzCURCph6v5BQFRcL1tB+0io4vMqWs770bhNVThfyCQ7SQ7FZNKjX6BIXMOR7G31b+PRHFaN6NhPh2ISrFyHdT7J9OUVOSgBwC9tIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrdfjwnZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BDE1F000E9;
	Tue, 16 Jun 2026 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622857;
	bh=8rkZHbdl6yPIxxTPbiRgc6cIMS3123y6GilUk+d+gbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RrdfjwnZYewcMDaGL4aJBwJpYkXqGWyP3I5mXReNfuJlF5EmYtbGVY4My0/ZfEqwc
	 cZCKSw9BNzKxjkyLM02Wv2/g1kJP/xWakfRpt1GT8lmQokX4EUlgLGMlct0AmzRezS
	 67gJNQTRCiuQU3ruUccs/znlwejeWY95hA7tn/os=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 043/378] wifi: cfg80211: enforce HE/EHT cap/oper consistency
Date: Tue, 16 Jun 2026 20:24:34 +0530
Message-ID: <20260616145112.175519570@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263861-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:xmei5@asu.edu,m:johannes.berg@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6D15690F17

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit cb9959ab5f99611d27a06586add84811fe8102dc ]

Xiang Mei reports that mac80211 could crash if eht_cap is set
but eht_oper isn't. Rather than fixing that for the individual
user(s), enforce that both HE/EHT have consistent elements.

Reported-by: Xiang Mei <xmei5@asu.edu>
Fixes: 22c64f37e1d4 ("wifi: mac80211: Update MCS15 support in link_conf")
Link: https://patch.msgid.link/20260603091812.101894-2-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 84fcfb1e53a156..fe0c0c198b2526 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6499,6 +6499,12 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 			return -EINVAL;
 	}
 
+	if (!!params->he_cap != !!params->he_oper)
+		return -EINVAL;
+
+	if (!!params->eht_cap != !!params->eht_oper)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.53.0




