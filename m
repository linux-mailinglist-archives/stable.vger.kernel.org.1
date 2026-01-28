Return-Path: <stable+bounces-212278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAw5K8Iwemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:52:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658D7A49C2
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F329312F8ED
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43630DD3A;
	Wed, 28 Jan 2026 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVr4fg9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FFA30C37A;
	Wed, 28 Jan 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614983; cv=none; b=fLFvRYiZNTu3nE3TBo6lxkMuc0Rg3aC06kIfyRAMHxG75mZxdDZCaZBe6ZOZW4QYPnHu468SRxJrLZ9UZrV2m7SlL0z/2OtLKzmnSkyZ9rTF5huPXKjhUWV0bxRf+gEe7WDfkmML68ulPNxJXgOOmqX70+9/6iEGdvn4xPkKBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614983; c=relaxed/simple;
	bh=J7Oqo6X/uQ2S9zbHDmt+CLwB4c8p195xigBG00He75g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBBv4b7ti2/5URnlTp5xAGSwlvWbLZBASmKXUP8ibqU9lFQ/NHKUSlcncLZUkHi8txJPBwqkZGx+f84umEq1uXhifOSnO/5A/Tc9iV3k9UuaqQqaNIA/0/0X/0BYGSXY6DZ20pVSFXBtMeFlFVe9nFW/HNfMwkxwXpqyaPL6a8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVr4fg9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C79C4CEF1;
	Wed, 28 Jan 2026 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614982;
	bh=J7Oqo6X/uQ2S9zbHDmt+CLwB4c8p195xigBG00He75g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVr4fg9djNDySdFmFAF93gZG22p0o1Gr/UlB2ks9IDAzLlVfGil86VXT8e0wchMi3
	 xvPWjVGIB9wizzxZXEHMzBQOTdqoMgwUlroIo+9yh/42CiS2P0+4iP8UZcDSSYy3PY
	 U2rkyirn2wUZj1XXN5cXo3HVxi2VKAwy5K4GCMsc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 042/169] wifi: mac80211: dont perform DA check on S1G beacon
Date: Wed, 28 Jan 2026 16:22:05 +0100
Message-ID: <20260128145335.534080190@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212278-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,morsemicro.com:email]
X-Rspamd-Queue-Id: 658D7A49C2
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lachlan Hodges <lachlan.hodges@morsemicro.com>

[ Upstream commit 5dc6975566f5d142ec53eb7e97af688c45dd314d ]

S1G beacons don't contain the DA field as per IEEE80211-2024 9.3.4.3,
so the DA broadcast check reads the SA address of the S1G beacon which
will subsequently lead to the beacon being dropped. As a result, passive
scanning is not possible. Fix this by only performing the check on
non-S1G beacons to allow S1G long beacons to be processed during a
passive scan.

Fixes: ddf82e752f8a ("wifi: mac80211: Allow beacons to update BSS table regardless of scan")
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Link: https://patch.msgid.link/20260120031122.309942-1-lachlan.hodges@morsemicro.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index ce6d5857214eb..8675d2e99c564 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -327,8 +327,13 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 						 mgmt->da))
 			return;
 	} else {
-		/* Beacons are expected only with broadcast address */
-		if (!is_broadcast_ether_addr(mgmt->da))
+		/*
+		 * Non-S1G beacons are expected only with broadcast address.
+		 * S1G beacons only carry the SA so no DA check is required
+		 * nor possible.
+		 */
+		if (!ieee80211_is_s1g_beacon(mgmt->frame_control) &&
+		    !is_broadcast_ether_addr(mgmt->da))
 			return;
 	}
 
-- 
2.51.0




