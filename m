Return-Path: <stable+bounces-213090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LmtEXDXgGnMBwMAu9opvQ
	(envelope-from <stable+bounces-213090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:57:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB371CF3EE
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 913CF309257D
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA43815C2;
	Mon,  2 Feb 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngpCQtK2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B293815D2
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051083; cv=none; b=Mo51mMrsXmiQDcQHjlaxjUMdeCaJXFg48UyqQyOd+ImnMAKKFsbdn5pSVtcABCciGtMkT5Te9c9T0y6F8o8Xno6PNGFD/ykX8dgpglRQRkGvdmXVeJ5OI/2lemD/4ju+SfNKW/49do/dCLxP8yJpcVnHHmgUEeKGUWYv30QCeuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051083; c=relaxed/simple;
	bh=+GZw2Ccyjs1GXRaOEe4tVxx0eiLCzS5WfrugO8sPmYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcAvQzQvxYjWB7NCgARsIWBiWUh8Mj6ZoxpvVCOdxLO3GRAHiqdHO4TrkpBH7FKZLvFqv1Gs+QsvKKeVXXMP/7tt1EE/YC0QN1+eFMzIM7I2DQxhbB2z+qyoaHf7UzINxRiLmwvHl6CLLPGAgYKLsix3+P15jZeTYzU2Lr/w8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngpCQtK2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-382fea4a160so40161571fa.2
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770051080; x=1770655880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCxKVpaSPMMkHK5YK3mSbB1f6oAthOa/gt2SpSMaGpQ=;
        b=ngpCQtK24yeuqk853Lz+/lC99Yk7GXQ0d7lFQ6olKJjCorE4nGvT44IhxU6O2o88H+
         BalnmIm7SUuvPbiBUxyTMj/sfCERwHcuR7M/BDyAvl5gIyZ3rO7l4ar5GPU5xrbqt0vr
         9TDOcyuwUhbH7gSB+3JKGcm6dMhvIJt9rBktBOq+ya5iBw6pRDv0SFJbgwH5cNe9ONyN
         IMNPOd9M86jdwKpjctJUcQjvVWIx/se74+GMEwSttlMgpjj3fAW//RjdLvcodIT4qEbd
         87bJbiwu3LYSvVsM3cqJjX+qHWRTyBEwGe1imWiugoou33llfJUvvq/ps+3PkYzZOui/
         HBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051080; x=1770655880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCxKVpaSPMMkHK5YK3mSbB1f6oAthOa/gt2SpSMaGpQ=;
        b=dHtzLqxk9fZlKWN2AcfPMApIPVt54Fci8UVCjXdlRvxO9qFPQ2dvZg1B1qH27Rc/hD
         WiaKOMelcb+yfps1HBKdTsZdSsb+YKIl2reV/4x9Y8J29AYz6BGU8f/zJQPf4BVfOxPQ
         G35/5slaQbOw1H9k/YD/fuHQZ09PIbJekQ+vTi7WiFG/m04GG1j7WFrxUK2Y+QXzt5db
         2VUDD5GcdfrVJu9duN7SP14YyDTOEK8G+xREp+1kEPGSzq4VKIZSMkZj/gYt9J6/GPFC
         ge8dPRb5VBhfmNAfoi9/cmAE4BNnSqvaM3FpOsD5x9HPIGz/yACnjHyogimcLPiORaMf
         P+ag==
X-Gm-Message-State: AOJu0Yz5tmkKTKXINPR20ofjzraF+zB+aEZ8G57xL72j4YFVzEPcIGWz
	08RSzOlOVUcOHMy2+SSKzTjANXChN3x8isTMRdgP8LdsdBQLbt/bdOf6t6ECo5ie
X-Gm-Gg: AZuq6aLQ3GlypYoAmgadO9d0taQIHGOJMdMzfx+p+E6+3FU4Fv/tovVsehzrxUgOvoK
	cEIu7Q50GZH8mZaqk64DAUt2WkR9bF/Oyx9/JnNRpaz3olSzjvxDGTJ5NRsLMplfBtU35xA/cfb
	hfF0Ss2ij9+WyeZXY3frKyPjZdaOJgcFL4Zt2ajRaSbxjloPBb06l8E0ziwo4Lg/46snfUaYrlG
	rqr4iG6SvkmXHxAkgLLR+dGPJ/WgBmurTz7+NU0EhsUJkuJKG1KSvYi9x+/4Jm2RKROgFNg7xA9
	+c0YTkPOy6pZEE9LQiKprvwBnIEmKw+K9Y2xAbe+j25SRYK/iJfs9o3h2Z+XZADNYimwK1gG3Y1
	EZECNVtpGLaDPhICo9h2JhjddUbj7kwL7mKa8ESXSA2XMNibCluQzzkdSVI3xT/sPegqSQ0HThR
	TDSdAqYTHNfXu9v+3ZtTL8x5AsqTONhxDTeNm837Pil/ULBc4H/M6Lolo9nSY8lGy/l/ApCToCv
	M08aPjnMI5fTbt0nJYW
X-Received: by 2002:a2e:b8cd:0:b0:383:210a:7b2c with SMTP id 38308e7fff4ca-386466fb2famr41766161fa.44.1770051079638;
        Mon, 02 Feb 2026 08:51:19 -0800 (PST)
Received: from uuba.fritz.box (2001-14ba-6e-3100-2ef5-59d5-c9b3-566.rev.dnainternet.fi. [2001:14ba:6e:3100:2ef5:59d5:c9b3:566])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625ad8ae0sm31718571fa.0.2026.02.02.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:51:19 -0800 (PST)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 5.15.y 3/3] wifi: mac80211: move TDLS work to wiphy work
Date: Mon,  2 Feb 2026 18:50:38 +0200
Message-ID: <20260202165038.215693-3-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.2.g2258446484
In-Reply-To: <20260202165038.215693-1-hannelotta@gmail.com>
References: <20260202165038.215693-1-hannelotta@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.28 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.88)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213090-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hannelotta@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: CB371CF3EE
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 777b26002b73127e81643d9286fadf3d41e0e477 ]

Again, to have the wiphy locked for it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ Summary of conflict resolutions:
  - In mlme.c, move only tdls_peer_del_work
    to wiphy work, and none the other works ]
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/mlme.c        |  7 ++++---
 net/mac80211/tdls.c        | 11 ++++++-----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8d6616f646e7..306359d43571 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -542,7 +542,7 @@ struct ieee80211_if_managed {
 
 	/* TDLS support */
 	u8 tdls_peer[ETH_ALEN] __aligned(2);
-	struct delayed_work tdls_peer_del_work;
+	struct wiphy_delayed_work tdls_peer_del_work;
 	struct sk_buff *orig_teardown_skb; /* The original teardown skb */
 	struct sk_buff *teardown_skb; /* A copy to send through the AP */
 	spinlock_t teardown_lock; /* To lock changing teardown_skb */
@@ -2494,7 +2494,7 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 			size_t extra_ies_len);
 int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *peer, enum nl80211_tdls_operation oper);
-void ieee80211_tdls_peer_del_work(struct work_struct *wk);
+void ieee80211_tdls_peer_del_work(struct wiphy *wiphy, struct wiphy_work *wk);
 int ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				  const u8 *addr, u8 oper_class,
 				  struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d147760e8389..25468d5e874a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4890,8 +4890,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	INIT_WORK(&ifmgd->csa_connection_drop_work,
 		  ieee80211_csa_connection_drop_work);
 	INIT_WORK(&ifmgd->request_smps_work, ieee80211_request_smps_mgd_work);
-	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
-			  ieee80211_tdls_peer_del_work);
+	wiphy_delayed_work_init(&ifmgd->tdls_peer_del_work,
+				ieee80211_tdls_peer_del_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
 	timer_setup(&ifmgd->bcn_mon_timer, ieee80211_sta_bcn_mon_timer, 0);
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
@@ -6010,7 +6010,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	cancel_work_sync(&ifmgd->request_smps_work);
 	cancel_work_sync(&ifmgd->csa_connection_drop_work);
 	cancel_work_sync(&ifmgd->chswitch_work);
-	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &ifmgd->tdls_peer_del_work);
 
 	sdata_lock(sdata);
 	if (ifmgd->assoc_data) {
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 137be9ec94af..c2d7479c119a 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -21,7 +21,7 @@
 /* give usermode some time for retries in setting up the TDLS session */
 #define TDLS_PEER_SETUP_TIMEOUT	(15 * HZ)
 
-void ieee80211_tdls_peer_del_work(struct work_struct *wk)
+void ieee80211_tdls_peer_del_work(struct wiphy *wiphy, struct wiphy_work *wk)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_local *local;
@@ -1126,9 +1126,9 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
 		return ret;
 	}
 
-	ieee80211_queue_delayed_work(&sdata->local->hw,
-				     &sdata->u.mgd.tdls_peer_del_work,
-				     TDLS_PEER_SETUP_TIMEOUT);
+	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+				 &sdata->u.mgd.tdls_peer_del_work,
+				 TDLS_PEER_SETUP_TIMEOUT);
 	return 0;
 
 out_unlock:
@@ -1425,7 +1425,8 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (ret == 0 && ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
-		cancel_delayed_work(&sdata->u.mgd.tdls_peer_del_work);
+		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+					  &sdata->u.mgd.tdls_peer_del_work);
 		eth_zero_addr(sdata->u.mgd.tdls_peer);
 	}
 
-- 
2.53.0.rc2.2.g2258446484


