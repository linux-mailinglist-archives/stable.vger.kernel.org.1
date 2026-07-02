Return-Path: <stable+bounces-270917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vchnOr2hRmp2agsAu9opvQ
	(envelope-from <stable+bounces-270917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:37:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F128A6FB7D8
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:37:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=GG3gTmUJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270917-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270917-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FEB33176217
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90A381EA9;
	Thu,  2 Jul 2026 16:36:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA5381E96;
	Thu,  2 Jul 2026 16:36:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010189; cv=none; b=Zrv5u4IlUxVEns5PxbmjrbIemI7PuSX9pJrSfNYOPOQIYHiIGHzT6iGh6fCXfu22dG8R9uYKyzzqV1JeJPXKox1fKC9K+FTSt6LwAu8IsgYSxIC+WFgxQRcOEjK061tmqIObvYYNtmw3LO4i8Nj8Nk4JtZ2CsD9sjl6WAW2hsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010189; c=relaxed/simple;
	bh=ytqUiSsTNhYLAILCVnoHDgsO8TcX+x+ZllYCsK5jaV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTQsdEkdad28SUArUhJaBXftrBb00XUH2s91EHXJN/HL2YYzykMrp8bLGOOPRpClkAdrV7yP0w1Y0/iJwGIUdWdhLis5KH+a13MH5CqeTjSYzsOVDASrrrviiL45ImONuGsRXmPmhTQQUuq68BsRL4SzHCHn9RF+Nw2stxSePVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GG3gTmUJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38DC1F000E9;
	Thu,  2 Jul 2026 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010188;
	bh=3voZ4Y/24NFSgewxkivPoYoZWcJbKd/iYhA+zxogsqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GG3gTmUJsZx0pzIBqveUkIKHTAoE4pj8Amr+86uIGop3/xKZTbA7T72DGRX9AW9PL
	 aUcF2SiYIsLyJSdqV4J3NO5zbkB5zeuTDjS2nL+CkRNwAV0YBJUsSHG+GIIlL0GRcG
	 Y673ImT1jqb0ZUCEz0zrkYnmZnnB2x3I7GTI24nQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quan Zhou <quan.zhou@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	David Ruth <druth@chromium.org>,
	Felix Fietkau <nbd@nbd.name>,
	Ajrat Makhmutov <rauty@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 002/204] wifi: mt76: mt7921: fix a potential scan no APs
Date: Thu,  2 Jul 2026 18:17:39 +0200
Message-ID: <20260702155118.720145294@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270917-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:quan.zhou@mediatek.com,m:sean.wang@mediatek.com,m:druth@chromium.org,m:nbd@nbd.name,m:rauty@altlinux.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,altlinux.org:email,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F128A6FB7D8

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quan Zhou <quan.zhou@mediatek.com>

commit 5ed54896b6bd444223092cab361b0785932119ab upstream.

In multi-channel scenarios, the granted channel must be aborted before
station remove. Otherwise, the firmware will be put into a wrong state,
resulting in have chance to make subsequence scan no APs.
With this patch, the granted channel will be always aborted before
station remove.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: David Ruth <druth@chromium.org>
Reviewed-by: David Ruth <druth@chromium.org>
Link: https://patch.msgid.link/1ac1ae779db86d4012199a24ea2ca74050ed4af6.1721300411.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index a93ae4e44f16a4..f2fffca868b519 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -368,9 +368,9 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		ieee80211_iterate_active_interfaces(mt76_hw(dev),
-						    IEEE80211_IFACE_ITER_RESUME_ALL,
-						    mt7921_roc_iter, (void *)phy);
+		ieee80211_iterate_interfaces(mt76_hw(dev),
+					     IEEE80211_IFACE_ITER_RESUME_ALL,
+					     mt7921_roc_iter, (void *)phy);
 }
 EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
 
@@ -881,6 +881,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
+	mt7921_roc_abort_sync(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-- 
2.53.0




