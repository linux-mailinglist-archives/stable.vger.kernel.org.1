Return-Path: <stable+bounces-252882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H3lMzz/DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-252882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:36:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C50E596C38
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26FD73139D17
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9033CEA2;
	Wed, 20 May 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzJ8/2uy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96734270545;
	Wed, 20 May 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301838; cv=none; b=PcR0pkXXKIFNTfbH1ARgsEMEY86E9ztadICnw+wLEXmrSGDyNTZ70eG5w0AF1YtpicIrJGdXDDskr9xx8bwqrfb/0YGKjjO5MXifoPxekRPqfc2thGUyl8p38/E8terUahIHFlYmYLgX6C5rZGpqMHVEWf/8CDYwvWGg9t7sjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301838; c=relaxed/simple;
	bh=wA0+ZVJTf+OwXl4inLaFIFMZGrpq8kCE75M6CpGR3m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlHTAutpSTxsmhtYv4imRB9igzPjZouP6doM+o5EMvlo6s72z2wP/cuTWi7iDoO6x90JuLNYRGmEjoZcgEMCCnPvVYmkfd/4vawnrb2b6+Ke0D1Sb7SAPbQeXEa8AfQpOKYI+9AHpnkqqLAiEZqRcRvgqNnlEiTFcwRxYDGfoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzJ8/2uy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095911F00896;
	Wed, 20 May 2026 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301837;
	bh=pZQ166ypI5feczAw6pTq4b9dkUjX0V4yG2AjqE/vpdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzJ8/2uyklJ62IElyizE5c/nCJvRt511ggq548jFkyzfwXoSc85M+l5usJprwFW32
	 lrsM9TSbM7aJIgXfh/0oXK5OLuImmJ/Xz/ZvEUMWns9kfMJU8/7GwjeW8kBiditghS
	 VwvPT8GZ9khEw+XzOjEEYEJ7YbZLUv59d35mTaso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/508] wifi: mt76: mt7921: Reset ampdu_state state in case of failure in mt76_connac2_tx_check_aggr()
Date: Wed, 20 May 2026 18:17:35 +0200
Message-ID: <20260520162059.286632992@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252882-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,mediatek.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,nbd.name:email]
X-Rspamd-Queue-Id: 4C50E596C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 53ffffeb9624ffab6d9a3b1da8635a23f1172b5e ]

Reset ampdu_state if ieee80211_start_tx_ba_session() fails in
mt76_connac2_tx_check_aggr(), otherwise the driver may incorrectly
assume aggregation is active and skip future BA setup attempts.

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20251216005930.9412-1-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 6a637d4f42360..a24b2fd3c7b82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1121,8 +1121,10 @@ void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	wcid = (struct mt76_wcid *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &wcid->ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
+	if (!test_and_set_bit(tid, &wcid->ampdu_state)) {
+		if (ieee80211_start_tx_ba_session(sta, tid, 0))
+			clear_bit(tid, &wcid->ampdu_state);
+	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_tx_check_aggr);
 
-- 
2.53.0




