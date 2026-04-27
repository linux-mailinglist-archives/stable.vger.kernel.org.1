Return-Path: <stable+bounces-241429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMCdB5q272mFEAEAu9opvQ
	(envelope-from <stable+bounces-241429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:18:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B078A479305
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7B330DD2E3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5E3EF0A1;
	Mon, 27 Apr 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=cipherat.com header.i=@cipherat.com header.b="BfvGQhLq"
X-Original-To: stable@vger.kernel.org
Received: from mail.cipherat.com (mail.cipherat.com [91.98.42.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C83EF0AD;
	Mon, 27 Apr 2026 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.98.42.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316761; cv=none; b=nbtRn/maOTgEbiCHZSby//Ie+HeW88nLKtBVQrz7w6p2spkEmgVvzHPzZM7RbWnhmOXSPB+yGuO4xXoUo65cPVDVpQkluKHPPIqB+0yRDwiPgpj2D8T+qLjyWUxmCveDiCFLFjayAVEElyaaq+QZmEl+TjyrKnBvoVT+Ho1HezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316761; c=relaxed/simple;
	bh=rZHYkXggah79PkVFN+6E/RKD6b6tAyfkViysUFDb8oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYag6/0goGvzzIwu57y9XVOKtjcANI694f8moH6Q7cRCllCWoFiPuvUa778j6jOhJD0cW96d6oO7xo+NzmSMf3kgpXHMvD3+jKQN7BZYRJCsurAMRoTCNX+jzXpSKt6joFqFEgksf2mRwfZLdqho6VXvbV7pFlTaZqJ2d7axbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cipherat.com; spf=pass smtp.mailfrom=cipherat.com; dkim=pass (4096-bit key) header.d=cipherat.com header.i=@cipherat.com header.b=BfvGQhLq; arc=none smtp.client-ip=91.98.42.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cipherat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cipherat.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 784BD84F34;
	Mon, 27 Apr 2026 22:05:57 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cipherat.com;
	s=dkim; t=1777316757; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9UgJASqxAWAeh3eiXQ4y7gcX7HLK+OapSPbuxmiLW5Y=;
	b=BfvGQhLqSSHesh1CHXphVUo3P2eNXVUO/xG8+65Dz0V44UpyTpm3twFvf+WwEOtzuteYn/
	dpVsJDIy1FVYaasD8K7UI652oEPgaty0/QMOGT9CszxnXFjSsvteE6QgTkyiU57LAjlPwP
	BQNhpUFl2aPIgjdl8risVjLYUpCBQ634nf9/xmYgwtQkngdHVCXQubSixNsx3FhOCgd+Dr
	azBuiE46kN2kNU83Go1azuiPuxMWkifacllGw2//cNcZxROfeJKoDpsYo+aojUJxcbAbv2
	Ccz4E9Ai0maP1OVhVn7W/jst7HC1RGM6FWUh2q2fDgrjXNtEt/eqmdbWYZbNHVVDVUcDjH
	FboxUE7qzSc/Q1NUIPRoccmtGSn6N8xZDI9kjZkSJBEH91s9iMfolJI8d6P4lJWUfrmS1p
	eHWVDZud1FlCiFIV3uIawXD5J2N2e/Q5n1kOg+tdlDn8gVYN7AnHyiaZRIDfzIvPJ4nJz2
	qJZ+DoO61yF4KEDdRnnALZ8Df01y1lbUCSQLuca7GIv+TZ1rPpadUmBZW3YlxYeENPx9q9
	zFVrCfsE3tfE0TV0J+3hWM9M0E9o19sRlhQXHj1GMVzoXFEkYeq4i/AdAXt9NHG7proXvc
	fqerwx1Y4mZtPx5rCGGewzcdtFBldj92gu/PfDul32zYdz05kNW0w=
From: Salman Alghamdi <me@cipherat.com>
To: gregkh@linuxfoundation.org
Cc: luka.gejak@linux.dev,
	straube.linux@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 1/7] staging: rtl8723bs: fix buffer over-read in rtw_update_protection
Date: Mon, 27 Apr 2026 22:05:29 +0300
Message-ID: <20260427190548.156499-2-me@cipherat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427190548.156499-1-me@cipherat.com>
References: <20260427190548.156499-1-me@cipherat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: B078A479305
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [10.34 / 15.00];
	URIBL_BLACK(7.50)[cipherat.com:email,cipherat.com:dkim,cipherat.com:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_ALLOW(0.00)[cipherat.com:s=dkim];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[cipherat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-241429-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[me@cipherat.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,lists.linux.dev,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.460];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[cipherat.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,cipherat.com:email,cipherat.com:dkim,cipherat.com:mid]
X-Spam: Yes

rtw_update_protection() is called with a pointer offset into the
ies buffer but the full ie_length is passed, causing a potential
buffer over-read.

Fixes: e945c43df60b ("Staging: rtl8723bs: Delete dead code from update_current_network()")
Fixes: d3fcee1b78a5 ("staging: rtl8723bs: fix camel case in struct wlan_bssid_ex")
Reported-by: Luka Gejak <luka.gejak@linux.dev>
Closes: https://lore.kernel.org/linux-staging/DI2H39EAAFBZ.3KI5NWN02AQ2S@linux.dev
Cc: stable@vger.kernel.org
Signed-off-by: Salman Alghamdi <me@cipherat.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ddfc56f0253d..268f294528e6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -464,8 +464,11 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED) && (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
 		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
+		if (pmlmepriv->cur_network.network.ie_length < sizeof(struct ndis_802_11_fix_ie))
+			return;
+
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
-								pmlmepriv->cur_network.network.ie_length);
+								pmlmepriv->cur_network.network.ie_length - sizeof(struct ndis_802_11_fix_ie));
 	}
 }
 
@@ -1072,8 +1075,11 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 			break;
 	}
 
+	if (cur_network->network.ie_length < sizeof(struct ndis_802_11_fix_ie))
+		return;
+
 	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
-									(cur_network->network.ie_length));
+									(cur_network->network.ie_length - sizeof(struct ndis_802_11_fix_ie)));
 
 	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
 }
-- 
2.54.0


