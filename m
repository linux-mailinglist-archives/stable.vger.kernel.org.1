Return-Path: <stable+bounces-271053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FjEwDnyiRmrCagsAu9opvQ
	(envelope-from <stable+bounces-271053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:40:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B5D6FB883
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:40:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="ftC5+/Oo";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271053-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271053-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5946B32B7DD7
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C41353A8D;
	Thu,  2 Jul 2026 16:42:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507A346A10;
	Thu,  2 Jul 2026 16:42:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010546; cv=none; b=L/LeokkZAZiABmXQBm13JLNEQvL3LE34zYj38kBB0kpyd+4e30PyfzHapQmtMr4d3GY022GaLRvtdx8s6/WfKnU+8ecdrvuO39/ImG9TiXeTyI6BY/BtBB1cOd9vEVYUZ2eec28LP1saAqUGi1JP9uoEdQ+nVpLxxatHSRkJa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010546; c=relaxed/simple;
	bh=zvfUTT2jEEpmahln9sQJjdWAg4wfAM6+sGr94oC88go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcD7IUiCJGc8z2HX1OtjtZeDcP1er+motvx5dlbbGVLpN4GigbWEFloVfBH8SuzzzjwlgM2dAEQ4b0X8dFeETLFeVskYfJui4y0YMR0DCFa1ASyzLGGCQm3yfz9/GqZoSEiDUiEjAcmSFwJIWCYT4SPKbwJZPbHMegN11FuD3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftC5+/Oo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25B01F000E9;
	Thu,  2 Jul 2026 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010545;
	bh=CW3W7crF83XcMbH8WPAVYazbKiUDMJX/ZqhBe9Rw1uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ftC5+/Oo4nMDr6LJxiV5kVn/FBKby18MP3ZbeMr/qlQzhoYk+bq9gORxQOwZ9VtTJ
	 vqW+Eucom66pfoTyiwXNyL58psPT/MBLr/c0SXkQp4l4OEJX8hVQURlu/kOE4GVIyU
	 1xzFwmQTgv6xH6FJnSIitpBOpXVT8sR5VgavA1Gg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ElXreno <elxreno@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.12 148/204] wifi: mt76: mt7925: dont disable AP BSS when removing TDLS peer
Date: Thu,  2 Jul 2026 18:20:05 +0200
Message-ID: <20260702155121.761380665@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271053-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:elxreno@gmail.com,m:nbd@nbd.name,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nbd.name];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83B5D6FB883

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ElXreno <elxreno@gmail.com>

commit 37d65384aa6f9cbe45f4052b13b378af1aab3e95 upstream.

On a STATION vif, removing a TDLS peer takes the mt7925_mac_sta_remove
-> mt7925_mac_sta_remove_links path. The first loop in that function
calls mt7925_mcu_add_bss_info(..., enable=false) for every link of the
station being removed. For a non-MLO STATION vif there is exactly one
link, link 0, whose bss_conf is the AP's. TDLS peers do not have their
own bss_conf - they share the AP's BSS.

The result is that every TDLS peer teardown sends a BSS_INFO_UPDATE
with enable=0 for the AP's BSS to the firmware, which wipes the AP-side
rate-control context. The connection stays associated and TX from the
host still works at the negotiated rate, but the AP's downlink to us
collapses to the lowest mandatory OFDM rate (HE-MCS 0 / 6 Mbit/s OFDM)
and only slowly recovers as rate adaptation re-learns under sustained
traffic. With brief or bursty traffic the link can stay at 6-72 Mbit/s
indefinitely, requiring a manual reconnect.

mt7925_mac_link_sta_remove() already guards its own
mt7925_mcu_add_bss_info(..., false) call with
"vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls".
Add the equivalent guard at the top of the cleanup loop in
mt7925_mac_sta_remove_links(), above the link_sta / link_conf /
mlink / mconf lookups, so TDLS peer teardown skips the loop body
entirely without doing the per-link work that would just be thrown
away.

Verified on mt7925e by triggering Samsung-S938B auto-TDLS via iperf3
and watching iw rx bitrate after teardown:

  Before: rx bitrate collapses to 6.0-72.0 Mbit/s, oscillates 17/72/
          137/288/432 Mbit/s for 30+ seconds, no full recovery without
          a manual reassoc.
  After:  rx bitrate stays at 1200.9 Mbit/s HE-MCS 11 NSS 2 80 MHz
          across the entire TDLS lifecycle.

bpftrace confirms a single mt7925_mcu_add_bss_info(enable=0) call per
teardown before the fix; zero such calls after.

Fixes: 3878b4333602 ("wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO")
Cc: stable@vger.kernel.org
Signed-off-by: ElXreno <elxreno@gmail.com>
Assisted-by: Claude:claude-opus-4-7 bpftrace
Link: https://patch.msgid.link/20260506-mt7925-tdls-fixes-v2-2-46aa826ba8bb@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1190,6 +1190,9 @@ mt7925_mac_sta_remove_links(struct mt792
 		if (vif->type == NL80211_IFTYPE_AP)
 			break;
 
+		if (vif->type == NL80211_IFTYPE_STATION && sta->tdls)
+			continue;
+
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 		if (!link_sta)
 			continue;



