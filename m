Return-Path: <stable+bounces-274897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vgnvNw9sV2rnNgEAu9opvQ
	(envelope-from <stable+bounces-274897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:16:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C9475D777
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:16:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q3KqDziY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274897-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274897-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C65CE300681D
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B73C9ED5;
	Wed, 15 Jul 2026 11:16:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057723B42F4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114189; cv=none; b=P2m6DKXSwi356GevFbnMFyXwvebVuz2pWb3Fy6BwU253aJGm59Y9wXYj7VXPM4cju5+BgJmk96KLxGeYmIUAnb8v4jZw/JMWMVzaov07qoPzJ06MilGZ/+iEHv3Q8bY/MgK+ZoMfy3BPYsAcKWAaEu07NTerqHzb29CZ3dbtt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114189; c=relaxed/simple;
	bh=UZF/MiinyWpt7tROcJmbXq9LZBV4sxYzi/QPZdWaSHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiN4fKi8TUDu4u53ZcE1EYYYRX6qf3aOjxYHDTdYkCMItnA2WQ3uCIGXAq9aYq7eemPxwq99jC1Tbw/Tpm43mz4xXh+Ss4li2c5xNGsLyuZEQ4B0xjELwSxzKJu6Fk7C+877+LPIgvh6pwBR36PLfllyj9TcTW77J6Y2cp2NLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3KqDziY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5A11F000E9;
	Wed, 15 Jul 2026 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114187;
	bh=XKP4FOKvbfwRQC3iQ8utpDguc4GhPOXc2D3Xa46TB/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q3KqDziYxC5wnPYy5dzHB8vRYGuu0g4obNjzpKK3s66olGOIpo7vEPI7unLYkeF04
	 YjlJyEddsZnCEaxKOp2IlN5H07dcH7Zub8WqRTNcj5W6gXQEybKVibXKaT6tIxTxbR
	 VEdnRPMyE6S4YC0DBe6KJ8t9O4CQG4oVkICqGYJmsEz9Td3srqpJm4/biTWjcvL0by
	 YE59ta6WbG4wgDeeSOwfiG8wudyXjYNDeLbnDardwqH0rKElMEk8Q1f6XyzYVeEbyz
	 E27pjYQ9Xt20K+/o6P+nrSDaxxuFDkOf/H8AMGcxZOnp/nkUcWK4NGSPCVxL9XZq0X
	 aFQ4D9uV8bJWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 01/10] staging: rtl8723bs: remove 5Ghz code blocks
Date: Wed, 15 Jul 2026 07:16:16 -0400
Message-ID: <20260715111625.647536-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071300-length-drainable-3f8e@gregkh>
References: <2026071300-length-drainable-3f8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:fabioaiuto83@gmail.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78C9475D777

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit ddd7c8b0033ba01a0ee605697f12a33fd31e6fca ]

remove 5 Ghz code blocks, related to networks
working over channel numbers above 14.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/c64443b92ce1a60f568db153842a62e3244a8c3a.1626874164.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  7 ++-----
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 20 +++----------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1144749b4f585d..af3b14b1de7a9d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4133,7 +4133,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 			p = rtw_get_ie(pbss_network->IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->IELength - _FIXED_IE_LENGTH_);
 			if ((p == NULL) || (len == 0)) {/* non-HT */
 
-				if ((pbss_network->Configuration.DSConfig <= 0) || (pbss_network->Configuration.DSConfig > 14))
+				if (pbss_network->Configuration.DSConfig <= 0)
 					continue;
 
 				ICS[0][pbss_network->Configuration.DSConfig] = 1;
@@ -6194,10 +6194,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			{
 				struct HT_info_element *pht_info = (struct HT_info_element *)(pIE->data);
 
-				if (pnetwork->Configuration.DSConfig > 14) {
-					if ((pregpriv->bw_mode >> 4) > CHANNEL_WIDTH_20)
-						cbw40_enable = 1;
-				} else {
+				if (pnetwork->Configuration.DSConfig <= 14) {
 					if ((pregpriv->bw_mode & 0x0f) > CHANNEL_WIDTH_20)
 						cbw40_enable = 1;
 				}
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 083ff72976cf04..21489f67bcce35 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -135,14 +135,7 @@ static char *translate_scan(struct adapter *padapter,
 		else
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
 	} else {
-		if (pnetwork->network.Configuration.DSConfig > 14) {
-			if (vht_cap)
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11AC");
-			else if (ht_cap)
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11an");
-			else
-				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11a");
-		} else {
+		if (pnetwork->network.Configuration.DSConfig <= 14) {
 			if (ht_cap)
 				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
 			else
@@ -762,7 +755,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	u32 ht_ielen = 0;
 	char *p;
-	u8 ht_cap = false, vht_cap = false;
+	u8 ht_cap = false;
 	struct	mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX* prates = NULL;
@@ -788,14 +781,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
 		} else {
-			if (pcur_bss->Configuration.DSConfig > 14) {
-				if (vht_cap)
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11AC");
-				else if (ht_cap)
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11an");
-				else
-					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11a");
-			} else {
+			if (pcur_bss->Configuration.DSConfig <= 14) {
 				if (ht_cap)
 					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
 				else
-- 
2.53.0


