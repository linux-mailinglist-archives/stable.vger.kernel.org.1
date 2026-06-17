Return-Path: <stable+bounces-266747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id clGXOsiZMmqA2gUAu9opvQ
	(envelope-from <stable+bounces-266747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:57:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B2699E65
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:57:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266747-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266747-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72A8F3009012
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391773FFAD0;
	Wed, 17 Jun 2026 12:57:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836883FFF8E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:57:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701058; cv=none; b=oKZIBU2Gw0ebDeEI4uMFtst3oX/ksWFdLQDffWGJCUHowtJ28Jpb3wApZAY5N4s+8ffk+b20Ei9yH/QGLTFQc8RgSFqDqVSVEOoU8/H/OXykdstwyxnC5AQtWyR+Ce4EkEsum6iXhwJWWJ/bjVW6z2CTREJeFKIay2esjhq+12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701058; c=relaxed/simple;
	bh=zBkIDkwpeiX1YuZUk4Qh4XG2Dxbiy/StczdxkWlmQnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gV0hRRzBwIXIKAl2SrjWdncgrAC1HnZbJnV4ciK8FgKsQNt7DUlo0mhFOyH7La8yTOWUDM3yTIeU6kHy+FhM6pn4LOMc6dd+Bbz9Y/jVjxvG+qnIOsmsgcXZ2nuEh+WSdF1UrUcANlvpuk6w9O3lyxeZXmBugViy6jIpQKqVsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id BA751233A9;
	Wed, 17 Jun 2026 15:57:28 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: 'Sasha Levin ' <sashal@kernel.org>,
	Leon Yen <leon.yen@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	David Ruth <druth@chromium.org>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 1/3] wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain
Date: Wed, 17 Jun 2026 15:57:12 +0300
Message-ID: <20260617125714.1663242-1-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260610080943.17734-1-rauty@altlinux.org>
References: <20260610080943.17734-1-rauty@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[altlinux.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:leon.yen@mediatek.com,m:mingyen.hsieh@mediatek.com,m:druth@chromium.org,m:nbd@nbd.name,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-266747-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rauty@altlinux.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rauty@altlinux.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,chromium.org:email,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A2B2699E65

From: Leon Yen <leon.yen@mediatek.com>

commit 2425dc7beaadc39c2636f97f8bdc22dc3cf88149 upstream.

Some countries have strict RF restrictions where changing the regulatory
domain dynamically based on the connected AP is not acceptable.
This patch disables Beacon country IE hinting when a valid country code
is set from usersland (e.g., by system using iw or CRDA).

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: David Ruth <druth@chromium.org>
Link: https://patch.msgid.link/20240412085357.13756-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
(cherry picked from commit 2425dc7beaadc39c2636f97f8bdc22dc3cf88149)
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 4bd533c4ba9a1..276dfb9c26e0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -137,6 +137,13 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	dev->mt76.region = request->dfs_region;
 	dev->country_ie_env = request->country_ie_env;
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER) {
+		if (dev->mt76.alpha2[0] == '0' && dev->mt76.alpha2[1] == '0')
+			wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
+		else
+			wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	}
+
 	if (pm->suspended)
 		return;
 
-- 
2.50.1


