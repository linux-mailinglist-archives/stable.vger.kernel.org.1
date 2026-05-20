Return-Path: <stable+bounces-250121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B8PJBrkDWpk4gUAu9opvQ
	(envelope-from <stable+bounces-250121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:40:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 620335923CF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 554313004608
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC8C37D101;
	Wed, 20 May 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZDg/4pfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3E3630AD;
	Wed, 20 May 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294599; cv=none; b=BaIiljEXvMgEvLLoZz7dkxCQQS/9vFyeCxw2v/scRyz/dAwfLwRIUA+Y5TpWx0xnyEVCS+GmWTSZufryVzZ5OCy/5ftNSN7FbvXh8XO/lSRKvkJq2u03v53zsWpAzYGw94DKnEJ4duI/GuT48I0uX5PFMtb/upvQ2gZG8t0mVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294599; c=relaxed/simple;
	bh=oHVpOzCk1bKHb3KWq6CBFDEfS48opqLKkNQYiTI6YKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPYC7QWsn5o9wZl1kL/vSPq+PfzpV1PDZoSaLLRAX5wQmpck1Hvwf9vUEVqVgDwkycGQ+99ex4ojYr4eYvqWdwnmRSKi5GxHayviXDK9rAy063HFBmH90E4fwQN23PKQukdMLGwom6JuuNXpQSUJOTexU3USvPhUliMM/b+HRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZDg/4pfM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6AB1F000E9;
	Wed, 20 May 2026 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294597;
	bh=BdQjyEPD4QlMf1T8TId6oBDJgWMAQknRrzfPp86UMLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDg/4pfMtdDU21CpwART1W6vFcN4On0y2F7+tJtWPScADeA5nEFmDCds7fgrwGlL0
	 lHWBPPTN06tZy5sAbkgKEiOKU4sty2ppPtt9o2dzbOFJDqnJQzKF1jiTQoGNZTzsnI
	 /2lvimFVKCtJMOIBJy1b+XJ88i67DJYm4RdkKgTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0100/1146] wifi: mt76: mt7921: Reset ampdu_state state in case of failure in mt76_connac2_tx_check_aggr()
Date: Wed, 20 May 2026 18:05:50 +0200
Message-ID: <20260520162150.608774566@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250121-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,nbd.name:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 620335923CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index b41ca1410da92..aab4630570093 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1153,8 +1153,10 @@ void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
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




