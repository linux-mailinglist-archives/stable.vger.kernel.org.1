Return-Path: <stable+bounces-220546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJYcNVpNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB21C8275
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D221835FFAAE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE923D47CD;
	Sat, 28 Feb 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxXOKymA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2243D47C2;
	Sat, 28 Feb 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300429; cv=none; b=KeML/XgymD32Q0vPKxmJ4j4mt2jS4te5t6Us4en2gmvLB92DIUmOYn6Nv0UFwC6Xt4wzcRZvaoPrsd14USRuPydsPfWGu3lhHbA9yIBO2gsAlHAZXd5+BIr//HBQia2uR10Zf7wEhYB7yoFNKQOJAxkSO1oTEhIc09DFut6bgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300429; c=relaxed/simple;
	bh=Z3JggKkIQWZ7ZM1BGBwbAxjDIQXOhJSkTCR4Gf/52sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9Fr21+PHDDt+W2Lmt11tA0WO6QAHlh6FK4lajK+DGQOb7oLRkfaNvTrBdAaZN7OLSSrljOQHfwsbfBqM3TyLT6cbVS6KPYhsdkZTEoeshnRNiGfWGkNKTusVxM+ACjiR3BfCH3BMCgQpfyvEDhbWBpmq6MhpQcaQEz22kD2zVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxXOKymA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4616BC19424;
	Sat, 28 Feb 2026 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300428;
	bh=Z3JggKkIQWZ7ZM1BGBwbAxjDIQXOhJSkTCR4Gf/52sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxXOKymA7+/KR8QYSsn0r09zgv8J83MwFktxEE73f2LSZED5tPD/7uuJjTNZ0HB8f
	 dGbRd3vFnGjN2Hlkw/13e4A58aoJzzPVqvY5CdnKEZp47Ic56xTY3JK/W+vORm1ZgZ
	 SXky4RJ+F3dWr2LBA5gTItyXv9HdrhV01eHPfOlJbw/U52QEcZlW85Oi4GKkkz0V4A
	 eVvgSPsKEkEPmXPChoQjEVks9upF3sal6rzLFAm0jk7JMnyaViflBTACq0fS0FFRz0
	 diAdatYunIvPahea/E3DVm0/C7QWjwlEEBQtpVFZV7hvsOIw9gAWeD2gWbpfgcieor
	 F2PFrM5vyIvAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Jouni Malinen <j@w1.fi>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 467/844] wifi: cfg80211: wext: fix IGTK key ID off-by-one
Date: Sat, 28 Feb 2026 12:26:20 -0500
Message-ID: <20260228173244.1509663-468-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220546-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,w1.fi:email]
X-Rspamd-Queue-Id: 2FDB21C8275
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit c8d7f21ead727485ebf965e2b4d42d4a4f0840f6 ]

The IGTK key ID must be 4 or 5, but the code checks against
key ID + 1, so must check against 5/6 rather than 4/5. Fix
that.

Reported-by: Jouni Malinen <j@w1.fi>
Fixes: 08645126dd24 ("cfg80211: implement wext key handling")
Link: https://patch.msgid.link/20260209181220.362205-2-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/wext-compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 1241fda78a68c..680500fa57cfd 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -684,7 +684,7 @@ static int cfg80211_wext_siwencodeext(struct net_device *dev,
 
 	idx = erq->flags & IW_ENCODE_INDEX;
 	if (cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
-		if (idx < 4 || idx > 5) {
+		if (idx < 5 || idx > 6) {
 			idx = wdev->wext.default_mgmt_key;
 			if (idx < 0)
 				return -EINVAL;
-- 
2.51.0


