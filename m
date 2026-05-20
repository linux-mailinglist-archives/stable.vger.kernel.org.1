Return-Path: <stable+bounces-251279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMNpJEzzDWry4wUAu9opvQ
	(envelope-from <stable+bounces-251279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 741915947FA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BBDF3019575
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED336F421;
	Wed, 20 May 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MOyoCtof"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C690369999;
	Wed, 20 May 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297570; cv=none; b=UGbCzJRd3kdB8tUEstC/Sj/DP89yY5UCmwLEAfx3R1IHELsNvN2+RWGzL8Shn0kc1O4d9ZlcvfpYNtqlzI0RvmVQo4UJhXkBgofAGs0fmOa5MA+kzbvfWvUDQJ/UEKKJfZtVW1iIte4ZYnYSQozfgT5UnlN/+SqkjpXk+jfAT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297570; c=relaxed/simple;
	bh=MW3y+LLSdEJAntZsFNfDHcb/gpPhHv/joqDy20IIlb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLXFQkKhPa/WIMfF+iorRbnXwEMPeTaV9KIDsk4Y0QROFJS3ocxjXVlkjagI26gJVDnFb9HzstiP9N47xQlT5ICYwK0BypssNMvKGSl9MKs+h+l3jywazaVquH5KjDnfpVe8jj3YMrcazbqf3qNMLkBu3HZeWngYLVqKP3DexW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MOyoCtof; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30861F000E9;
	Wed, 20 May 2026 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297569;
	bh=YZVvpcNm+qOba6sh45FRu4MprCcxHM9ivJGgtRLtfPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MOyoCtofoIawcxsyzBgdPJwlpZHXKG4Xz/tJabQZFwXLhDcBpmPk0fmawVCzGONYT
	 NMSRvkUBQ6f4auqHIn/IZuFBtffFyIXi0nLdYdYlZQkC0J7FmhlAXsO8rWaxnjM58/
	 MK01ZJtTNe+73mmFHyo/QpUvMeBL1qsmCDycHhSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 079/957] wifi: mt76: mt7996: Reset ampdu_state state in case of failure in mt7996_tx_check_aggr()
Date: Wed, 20 May 2026 18:09:22 +0200
Message-ID: <20260520162136.275247230@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251279-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,nbd.name:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 741915947FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit c0747db7c10c2dfbdcff0e8e97021e3df1f1e362 ]

Reset the ampdu_state configured state if ieee80211_start_tx_ba_session
routine fails in mt7996_tx_check_aggr()

Fixes: 98686cd21624c ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20251214-mt7996-aggr-check-fix-v1-1-33a8b62ec0fc@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 24b404f35409b..15d796702a589 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1243,8 +1243,9 @@ mt7996_tx_check_aggr(struct ieee80211_link_sta *link_sta,
 	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
 		return;
 
-	if (!test_and_set_bit(tid, &wcid->ampdu_state))
-		ieee80211_start_tx_ba_session(link_sta->sta, tid, 0);
+	if (!test_and_set_bit(tid, &wcid->ampdu_state) &&
+	    ieee80211_start_tx_ba_session(link_sta->sta, tid, 0))
+		clear_bit(tid, &wcid->ampdu_state);
 }
 
 static void
-- 
2.53.0




