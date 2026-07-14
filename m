Return-Path: <stable+bounces-274584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z/hYH5+yVmpEAQEAu9opvQ
	(envelope-from <stable+bounces-274584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0757759209
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="fmAw+B/B";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274584-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274584-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E64F3069EF1
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A7D3EE1FE;
	Tue, 14 Jul 2026 22:04:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AA37E5E3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066669; cv=none; b=q27N75t1xRADE1MZIJAlYyK8XbSAbVqaHPlwrQ4kWb0P9D+va7JpmtwrKBGOB329ZB1BvwyVULrONmmN/DLKEhVxnNJNN6BrSBhRz/sI2bobjpC82Y5r3AvT1lhwdKSlwmJ3w13B/CHkCEDDFkKYaUFqFvDJK7fdUB8pishPIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066669; c=relaxed/simple;
	bh=2BWY5JzF1bJ3x2ERLoLhO8/iydvhUqz19DWr5HodIow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3gD0quMK7H9PEQJ4715GCjISNIS6mIwnScyy+Zr1E1S/zIcNc7JQU8hRGEgTBD7wSpGy8V/DTGVd/4+BNOZvPD67y6X0CBioBNLG9NU+Gmbc1ZIToLKXks0jqy6Re2zxFH2IUQZOM9bMNGxatMuvpAhRZAIZtu77jPJb+vZgGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmAw+B/B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388851F00A3E;
	Tue, 14 Jul 2026 22:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066668;
	bh=DYGTL9vyCJxbykjQqTC/EFv1lJ83w2KLh3buMqs8PJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fmAw+B/Bhl6uwDC2bZck/rmma0nSevHLqwo6OXepSpr/Jq65X15uOKll7wnJhZF2D
	 Z+JUwLqzPz0OngAABK0VymDkwGVNrkjdiNmn21ZGEneOwZi953+9Fb83+rDW9yWETw
	 10AHLnlemlbHM+Gcz9UXHcXTriqFaGrJzDB/C+qllfhdMcgjl+RqVwqcHe3/PZOOs2
	 3v0rfyppOuRnnXXeXoIEhHq6iY1TPXEMrFBUc/QKCxVfrxOGpAjRLz8AGbTQjeDnXK
	 vLiDTHgRks8wbsYc0/rIl/h3F1yjab1BwLOgibpz3sZKNz7SsyMuC1TwoloCTJFdfJ
	 zQXj2R0bROtIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Franziska Naepelt <franziska.naepelt@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] staging: rtl8723bs: Fix indentation issues
Date: Tue, 14 Jul 2026 18:04:24 -0400
Message-ID: <20260714220426.3334125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071335-spindle-refutable-39c3@gregkh>
References: <2026071335-spindle-refutable-39c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274584-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:franziska.naepelt@googlemail.com,m:franziska.naepelt@gmail.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:franziskanaepelt@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[googlemail.com,gmail.com,linuxfoundation.org,kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0757759209

From: Franziska Naepelt <franziska.naepelt@googlemail.com>

[ Upstream commit b59cba2309b16fa364df03e3693b8d45c3fadbd6 ]

Fix the following checkpatch indentation issues:
- WARNING: suspect code indent for conditional statements (32, 48)
- WARNING: suspect code indent for conditional statements (24, 24)
- ERROR: code indent should use tabs where possible

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
Link: https://lore.kernel.org/r/20230619180351.18925-1-franziska.naepelt@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 5a752a616e75 ("staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 6ac79b430acc97..bc340c6fdaf99d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -582,7 +582,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 				if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
@@ -1305,7 +1305,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	} else if (request->n_channels <= 4) {
 		for (j = request->n_channels - 1; j >= 0; j--)
 			for (i = 0; i < survey_times; i++)
-			memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
+				memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, ch, survey_times * request->n_channels);
 	} else {
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, NULL, 0);
@@ -2805,7 +2805,7 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 	wdev->netdev = pnetdev;
 
 	wdev->iftype = NL80211_IFTYPE_STATION; /*  will be init in rtw_hal_init() */
-	                                       /*  Must sync with _rtw_init_mlme_priv() */
+					   /*  Must sync with _rtw_init_mlme_priv() */
 					   /*  pmlmepriv->fw_state = WIFI_STATION_STATE */
 	padapter->rtw_wdev = wdev;
 	pnetdev->ieee80211_ptr = wdev;
-- 
2.53.0


