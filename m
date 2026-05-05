Return-Path: <stable+bounces-244230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHXfNRMs+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:42:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA34D23BE
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 795433093C26
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9314A33EF;
	Tue,  5 May 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfmIFCfm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440844A2E3D
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002712; cv=none; b=McWvEUxePhrG5bmb2KX+tT6rnWZ6zq/yS9BtOF+9vZQSUQqc+8n1o5UFE41hVLbqHcesNAEngjjj4BEvf+a9IdxpbNj8EJ+5HqEk7y/dtCERoNATKaKfQEXoXt1Umt4IJSouOQZdJd1plkbow+PkhTjk+Whngl/OjP/sl7rO4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002712; c=relaxed/simple;
	bh=2eHvbI1mk/aj/Zi5PxQSpJypU7yoSMe2lKX08aSATJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9BKrZyHHF8idyruiVe4QLStnT3nmxE5yg91tkY/XbFzKGkba3uHDuQIXlQTSTurWNR1zbGQoGiHKzfVl4WkgPd244ctICiH7jw7khZ9TmfbZWsi+jTXRZGOAur5uvlYwqA3pNxwneH8io3Q5vyYo5o0R8jjbDOdv47tIcQyAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfmIFCfm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso953775e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002708; x=1778607508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HzUgHbapU2iUW6a55uMohE0Ic8YmFRsZ+OhWqMaW50=;
        b=pfmIFCfmzM72O7XCdpnqQgo3xl6HU9m3N2NsszC6vAzYzvX6hKIbsfVZj6Kc0tvQ71
         0u3bjyCyUOu65yh0+1sOi+/UNXLtpItEuTU/DxoeA262rW5x6uIW7xibCJDMXEJtE7xo
         4dHwLcH0KvT1v4oSCptG6FemJ4gkuDQRoKV4MrX60NY/OKTiS1rv+qKf1Qfc2liqc/di
         M+LBMl9ZexnFMxh1niGJVgt/qF1RWANB7Ct/JPcDTwo+RPSAsvlOHYgUQSf/G0dc7CT5
         B0KFlkB/NPDDQVsjaeaI19aGl94lx8NUQsfLPcE8yvXPTu/1L84gHYGWxlhfIE/xYsCC
         0dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002708; x=1778607508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3HzUgHbapU2iUW6a55uMohE0Ic8YmFRsZ+OhWqMaW50=;
        b=lSfduKp8gyUZ1x4IR4Sml5NpvNIfZZu8M6vPqMMHwlL40Fpr3AZhMxa8QbzKI10La3
         pqlzo/loClgLs6z9ufpDkY1jQdbYFz//bbaVL0DZNCdtUThI70fAQQpkkZkcfIyM3UqG
         t+3YzCfZcEWIKEJPqkYSzdKUwWLK3wN0t/XCX8Supy1b/5t+vRC8qiijudNd/Y6Q0k+y
         htUUld3ptaa5kk6nvsQav6vCLxcEJTuxteqoMxn072P19N5um4NL82qTIbuueQHymMx/
         ++EHk34LV7ngnrman7NlBvq0lyTpgaooON9NeQc/nevvKFUh9Oj9VTCYk7AAPx7Ltbw0
         95OQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FUUbeJdlBHKwIoA9DfKQTij67xcN8Us6fQsWkS706FOdgW8mno4FvkhXiN9ZPCTL35SzZT28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7qt49NC6A7N+rCeer887ERqqVXxh2oIFuL94bPMneg87iFaV
	uv04OVhQCmDPPY+snbCHwt2FM/Wrm6CGJakBAXEpX7zpZuHvTHKi4LuD
X-Gm-Gg: AeBDiev1zwmpnaISzaE7Jwv7X90je4xDT458GnIwnjdtwBMQgzmxpbmoLe2QnEKo8Sf
	cEeIdb4SyBTMbTe7GGxWCqHEpamlXjQnfiov+BCju/jYRDPullhsQ9BnbayAPUth2E4Vd7Oiyj9
	fBvqZA6eTZwDsyeHM2bSKfhAFjBlWsk4R/cqyCMir+PRxEJz/JWh0kivmQjILeTl+fnEZmxtRrS
	W35/INmc6Q3KmqkcUhSurOMTAp3zzEzRtcIejju8pgUqL/MU/u6gx9mXrm2Ooc0fHyrBdswZg6D
	7HxS75TdXexUIeR9u3SxkAiiNGIWsspxZFVwPTh3/R6if4h2DYpjc8iVXuBls4TUGIovjXw3a4C
	r+jmXm71DJMNEh6AMjDONY5OJ/3M2012rElFfT4pqBWkhDerQC2VlpqgBAaI7BhmT25cwAYHvOw
	t6LNAfc4AXmI/lBZBe3KGOmhjs4yjfT6ecyDbw0W7+DVEH5SLsZccesy3izYgo9hgMICB6yFSaK
	bHQ5XJwLpAucJrlT52xWPyN6tmsdbaOoVwdbhrgnX5cs4n1exDpn/l+nrl7Jv5XGLxopFA=
X-Received: by 2002:a05:600c:3152:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-48d1422bafamr75630445e9.3.1778002707536;
        Tue, 05 May 2026 10:38:27 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm655473875e9.9.2026.05.05.10.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:38:27 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
Date: Tue,  5 May 2026 19:38:17 +0200
Message-ID: <20260505173818.3674164-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505173818.3674164-1-hossu.alexandru@gmail.com>
References: <2026050436-italics-clumsy-e83c@gregkh>
 <20260505173818.3674164-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4FCA34D23BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244230-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Five out-of-bounds read paths in the IE parsing loops of
issue_assocreq() and join_cmd_hdl():

1. Missing IE header bounds checks (both functions).

   Both loops advance by pIE->length + 2 per iteration but only guard
   on i < ie_length.  When the buffer ends with a single element_id
   byte and no length byte, the loop reads pIE->length from one byte
   past the end of the buffer.  Even when both header bytes are in
   bounds, pIE->length can extend the data window past ie_length,
   silently passing a truncated IE to handler functions.  Add two
   guards at the top of each loop: break if fewer than sizeof(*pIE)
   bytes remain, and break if the declared IE payload extends past
   ie_length.

2. Vendor-specific OUI comparison reads 4 bytes past a possibly short
   IE payload (both functions).

   For WLAN_EID_VENDOR_SPECIFIC, the code calls memcmp(pIE->data,
   OUI, 4) on RTW_WPA_OUI, WMM_OUI, and WPS_OUI without first
   verifying that pIE->length is at least 4.  A short IE at the end
   of the frame causes the memcmp to read into adjacent frame data.
   Add pIE->length >= 4 guard before the comparisons.

3. HT Capability IE memcpy reads sizeof(struct HT_caps_element) bytes
   from an IE that may be shorter (issue_assocreq only).

   The WLAN_EID_HT_CAPABILITY handler copies:

     memcpy(&pmlmeinfo->HT_caps, pIE->data, sizeof(struct HT_caps_element));

   If pIE->length < sizeof(struct HT_caps_element), the memcpy reads
   beyond the end of the IE payload into adjacent frame data.  Add a
   minimum length check and skip the IE if it is too short.

4. rtw_set_ie called with untrusted pIE->length for HT Capability
   (issue_assocreq only).

   After the memcpy the code passes pIE->length directly to
   rtw_set_ie() as the IE body length.  If pIE->length exceeds
   sizeof(struct HT_caps_element), rtw_set_ie copies that many bytes
   from pmlmeinfo->HT_caps, reading past the end of the struct into
   adjacent fields.  Use sizeof(struct HT_caps_element) instead.

5. HT Operation IE accessed without minimum length check (join_cmd_hdl
   only).

   The WLAN_EID_HT_OPERATION handler casts pIE->data to
   struct HT_info_element * and reads pht_info->infos[0] (offset 1)
   without verifying pIE->length >= sizeof(struct HT_info_element).
   A zero- or one-byte HT Operation IE causes an out-of-bounds read.
   Add a minimum length check and break if the IE is too short.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v4:
  - Add pIE->length >= 4 guard before the 4-byte OUI memcmps in the
    WLAN_EID_VENDOR_SPECIFIC cases of both functions (sashiko review of v3).
  - In issue_assocreq() WLAN_EID_HT_CAPABILITY: add minimum length check
    (pIE->length < sizeof(struct HT_caps_element)) and use
    sizeof(struct HT_caps_element) instead of pIE->length in rtw_set_ie()
    to prevent OOB reads past the HT_caps struct (sashiko review of v3).
  - In join_cmd_hdl() WLAN_EID_HT_OPERATION: add minimum length check
    (pIE->length < sizeof(struct HT_info_element)) before casting pIE->data
    to struct HT_info_element * and reading infos[0] (sashiko review of v3).

Changes in v3:
  - No code changes from v2.

Changes in v2:
  - Add IE loop header and payload bounds checks for issue_assocreq()
    and join_cmd_hdl().

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..0c130d0f9a48 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2925,13 +2925,18 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+		if (i + sizeof(*pIE) > pmlmeinfo->network.ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pmlmeinfo->network.ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
-			if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
+			if (pIE->length >= 4 &&
+			    ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
 					(!memcmp(pIE->data, WMM_OUI, 4)) ||
-					(!memcmp(pIE->data, WPS_OUI, 4))) {
+					(!memcmp(pIE->data, WPS_OUI, 4)))) {
 				vs_ie_length = pIE->length;
 				if ((!padapter->registrypriv.wifi_spec) && (!memcmp(pIE->data, WPS_OUI, 4))) {
 					/* Commented by Kurt 20110629
@@ -2953,8 +2958,10 @@ void issue_assocreq(struct adapter *padapter)
 		case WLAN_EID_HT_CAPABILITY:
 			if (padapter->mlmepriv.htpriv.ht_option) {
 				if (!(is_ap_in_tkip(padapter))) {
+					if (pIE->length < sizeof(struct HT_caps_element))
+						break;
 					memcpy(&(pmlmeinfo->HT_caps), pIE->data, sizeof(struct HT_caps_element));
-					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, pIE->length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
+					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, sizeof(struct HT_caps_element), (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
 				}
 			}
 			break;
@@ -2967,7 +2974,7 @@ void issue_assocreq(struct adapter *padapter)
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
@@ -5318,11 +5325,15 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* sizeof(struct ndis_802_11_fix_ie) */
 	for (i = _FIXED_IE_LENGTH_; i < pnetwork->ie_length;) {
+		if (i + sizeof(*pIE) > pnetwork->ie_length)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pnetwork->ies + i);
+		if (i + sizeof(*pIE) + pIE->length > pnetwork->ie_length)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:/* Get WMM IE. */
-			if (!memcmp(pIE->data, WMM_OUI, 4))
+			if (pIE->length >= 4 && !memcmp(pIE->data, WMM_OUI, 4))
 				WMM_param_handler(padapter, pIE);
 			break;
 
@@ -5335,7 +5346,12 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 			/* spec case only for cisco's ap because cisco's ap issue assoc rsp using mcs rate @40MHz or @20MHz */
 			{
-				struct HT_info_element *pht_info = (struct HT_info_element *)(pIE->data);
+				struct HT_info_element *pht_info;
+
+				if (pIE->length < sizeof(struct HT_info_element))
+					break;
+
+				pht_info = (struct HT_info_element *)(pIE->data);
 
 				if (pnetwork->configuration.ds_config <= 14) {
 					if ((pregpriv->bw_mode & 0x0f) > CHANNEL_WIDTH_20)
@@ -5366,7 +5382,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 
 	/* check channel, bandwidth, offset and switch */
-- 
2.53.0


