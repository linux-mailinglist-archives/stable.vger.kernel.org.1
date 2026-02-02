Return-Path: <stable+bounces-213085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJc6JljVgGmFBwMAu9opvQ
	(envelope-from <stable+bounces-213085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:48:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB952CF22B
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DECB53004401
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2637FF76;
	Mon,  2 Feb 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfjIvm86"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C732F763
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050893; cv=none; b=IvmuhMSKbo3Xuqx2VX1/UmcbkhP6wfnW7V/YsqTcDqbkv+6B3DoggBqPdK4znQBluX0lN8jvWfnAC6TgjHyhES/oLiCh9Sgl5EH9XTh3uCtTF36GDKElNVrGiawtncS7DvIGlgDsH4+An7fxlfQ/b9LNWKR0kNHkLDYwhHwM2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050893; c=relaxed/simple;
	bh=G43UHDq9M9vlCKWvhbq7QwcmMhxb+KXh+SKRfIfby8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gtH6+TfLk6btIeqqKnXfTwW8bfM8iOJsIzPDXO545/iMUgF5CRBz8nNsMQ9UNNfnltmS69WFl95wOGyqi852lN7LqedvJaxOPBWmQ6u1smBArjwtdmT3hqkW8shKSHXl791Pjkknu6pcKfc+2diLHHL6Hpm6v9ml33jwrVTP8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfjIvm86; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso5672291e87.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050889; x=1770655689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/lgbVfZ0ZXuhGZYHqBtenLKtCbzR+uHZHCZ0g0Qzccg=;
        b=cfjIvm86d6s8nT1c9obKAIEanD3owbx2IFko9w01Zy/qdgwmn7xPaE/uTHZDUTe4kE
         VY7RLD+sJqNz+d3PllBui/iOVDxOIs7me6QjK1T7hxEwSttLRZc5xqcJX8TpMqsiUfXB
         uq8AnhO36x+TJtxPh7PDjH8Q6CzS5tOQqy3Xfs77+tROY1RySsd7aZXcsrd2HTpB1qrj
         FAdvAi/GSA2tbdCiLMqZa3djkL8RLeSkjdCXKVnQilNXMvBYc1B9ma47CWP1WuPYJ+XR
         cOmlZBu5FnpKBILtWJtS0/7ygfU83fmGG4FHcGy8dS3caslDy+q5N4VHbop4Snppcpx4
         gUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050889; x=1770655689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lgbVfZ0ZXuhGZYHqBtenLKtCbzR+uHZHCZ0g0Qzccg=;
        b=U2YuOfSFrIvEM2U0hkuAgz3s8wajyIYYKiJDKN9KaY8ypr4Z4MngyBnByjNHNqUucE
         Q0+dz3FkexwZWl+Ggxk+XvYhk7DJRCWlt5/QawccpdpIYvsLhYaLHvFi+wP5DyGOvI7Z
         AyA2yzzJ2B29x61uAYXs5QeFkGGec5yaZ5ebF0AO8fTixzYP/8shwaLd3bfkIxWMJyoB
         uE8kIy4zmpSUnJ1BpiEXtA3PL44MvfF9U78Oy9nxESnG3Mk8HjQpGKvUezuY1xfndObf
         9gG5+wJ5Ysjnn3+Jn870IwpDIoohPqb2WtS6HD8hpd3hSQNvWqrUURqeQEAo0E8rbz//
         +l0A==
X-Gm-Message-State: AOJu0Yxqx5y+bHwIxeT24gLwIzyykoyAPwFCpAyxj05Rj4OQ4rC0GdBe
	eavpEsdt2nRZ4iZ5FQZsnq4/ebKHX2LVO4JEXBGqFuSkbdSUB0TQuiOVt0Tz4gQJ
X-Gm-Gg: AZuq6aLaPqHGTXy8FL223DcnXzfz1KK2U3YOe60tQchGy8xnHTznhlDTDqbBtsV8okl
	EJCsl/z/7gZwDKewffa7PMZ8Z1EhECY/qzSYEdkY8BVosnb1pTLxsxEfulloBTbjn41ersnBvsv
	LWpXtJlgdE6Ymdu4862bELyLpQPrV5Vobkolq/AKwXR3lRamGs+XvH4tHNV8LlJ6k0LoVAK6lSq
	jpo453udgr2qXnTqHsmoEAdus4RqfcYmkiJkHh0CMhF2haZZ7Gs1Gcmwxr/cZ3yP4xFnhFL0Zcd
	cucA8257w3im5FVouJO+M01KqQB8hoUxgQ23mJh2dDSj4m86PNusEXlfI78g1izSSt6oTbTnwFV
	DJ2V4DglW2n8aoJVL5/IIY4fg+fxJME8MgNKmKValNz0raVDE9SvPyEEYa0va42l4BdLEnhk+0G
	jIn/sOECRPcMeT2Lo+upJws2bRs2dgkpUdheXonnYwTjIYQcUEavmJhvG6SRasyMosE8WV0l+l7
	56gGLEUsg==
X-Received: by 2002:a05:6512:1251:b0:59d:f66b:9451 with SMTP id 2adb3069b0e04-59e16409f73mr4138717e87.20.1770050888698;
        Mon, 02 Feb 2026 08:48:08 -0800 (PST)
Received: from uuba.fritz.box (2001-14ba-6e-3100-2ef5-59d5-c9b3-566.rev.dnainternet.fi. [2001:14ba:6e:3100:2ef5:59d5:c9b3:566])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074819c0sm3569814e87.7.2026.02.02.08.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:48:08 -0800 (PST)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 6.6.y] wifi: mac80211: move TDLS work to wiphy work
Date: Mon,  2 Feb 2026 18:47:45 +0200
Message-ID: <20260202164745.215560-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.2.g2258446484
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(1.00)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213085-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hannelotta@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB952CF22B
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 777b26002b73127e81643d9286fadf3d41e0e477 ]

Again, to have the wiphy locked for it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
(cherry picked from commit 777b26002b73127e81643d9286fadf3d41e0e477)
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/mlme.c        |  7 ++++---
 net/mac80211/tdls.c        | 11 ++++++-----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 44aad3394084..639268d70f96 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -530,7 +530,7 @@ struct ieee80211_if_managed {
 
 	/* TDLS support */
 	u8 tdls_peer[ETH_ALEN] __aligned(2);
-	struct delayed_work tdls_peer_del_work;
+	struct wiphy_delayed_work tdls_peer_del_work;
 	struct sk_buff *orig_teardown_skb; /* The original teardown skb */
 	struct sk_buff *teardown_skb; /* A copy to send through the AP */
 	spinlock_t teardown_lock; /* To lock changing teardown_skb */
@@ -2599,7 +2599,7 @@ int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *extra_ies, size_t extra_ies_len);
 int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 			const u8 *peer, enum nl80211_tdls_operation oper);
-void ieee80211_tdls_peer_del_work(struct work_struct *wk);
+void ieee80211_tdls_peer_del_work(struct wiphy *wiphy, struct wiphy_work *wk);
 int ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				  const u8 *addr, u8 oper_class,
 				  struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index aa7cee830b00..78b9206f99f4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6866,8 +6866,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 			ieee80211_beacon_connection_loss_work);
 	wiphy_work_init(&ifmgd->csa_connection_drop_work,
 			ieee80211_csa_connection_drop_work);
-	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
-			  ieee80211_tdls_peer_del_work);
+	wiphy_delayed_work_init(&ifmgd->tdls_peer_del_work,
+				ieee80211_tdls_peer_del_work);
 	wiphy_delayed_work_init(&ifmgd->ml_reconf_work,
 				ieee80211_ml_reconf_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
@@ -7881,7 +7881,8 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 			  &ifmgd->beacon_connection_loss_work);
 	wiphy_work_cancel(sdata->local->hw.wiphy,
 			  &ifmgd->csa_connection_drop_work);
-	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
+	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+				  &ifmgd->tdls_peer_del_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->ml_reconf_work);
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f3cdbd2133f6..0fd353fec9fc 100644
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
@@ -1224,9 +1224,9 @@ ieee80211_tdls_mgmt_setup(struct wiphy *wiphy, struct net_device *dev,
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
@@ -1526,7 +1526,8 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (ret == 0 && ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
-		cancel_delayed_work(&sdata->u.mgd.tdls_peer_del_work);
+		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+					  &sdata->u.mgd.tdls_peer_del_work);
 		eth_zero_addr(sdata->u.mgd.tdls_peer);
 	}
 
-- 
2.53.0.rc2.2.g2258446484


