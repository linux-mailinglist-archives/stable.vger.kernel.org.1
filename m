Return-Path: <stable+bounces-274699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ECduLXr0VmoHDgEAu9opvQ
	(envelope-from <stable+bounces-274699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:46:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724C75A1EA
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:46:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Jqr4AwiV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274699-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274699-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F8DB301949F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066D3921DD;
	Wed, 15 Jul 2026 02:46:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7723A9611
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083576; cv=none; b=j/aCCWsH/o0mjR/kC0dOVkZ2i+UfRKKiR725dpKnutpR70ES08kxTm9XEgGE+5DEeR/p35e97D3Ruu8bXccG3LbuPZ/8vbXfuj6JkhecitQGtBCVlKvShFELvvjjf6s497C9G8sPotKkbDDDEVLoBB0M7asd0vx8HEHSOZdwo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083576; c=relaxed/simple;
	bh=nQUTKUhX8xQz7AoevswVd+XEQoibfPE/W/chklriQTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy50RQJiXb2esN7nVRKjLv9frUtg0EOb3bcrTPFZEC7thvImrY8cnz2ycZF/qLc/rH3rBJvqNAYFHUfit+PinzfW9nUwhL6/VCsYxlUDpeiVVkdKJ0/pCs4NHo0+Eb2IZHQiXuKyTNKY8l/l195LHrI6E4sgxb8peNuKIj/fg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqr4AwiV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF011F00A3E;
	Wed, 15 Jul 2026 02:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083575;
	bh=6QCuArr+QipSeK9+zIUIMGEv5BU2d0+80PYDZCe+ZYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jqr4AwiVEeeYNdQJzN0ZDNe2yyDhtkkJ1YuszkNvaFZAtiTQeaPbMuKeldd45xmef
	 2TW+iR2xGz+v2z6j8TMy1QsvvTUHPM132FU/FmZ6llYR7DDUo/nMJJ+zZE5PP52cqm
	 yVjXlgsDg3d7oVQepC8ck0KNMMJR5DOtvnujqMhpKFEt9PmtskyYoF3acS168VKWfT
	 VNCNOae5RqdFaB7PpaGCmpuXNVAtH3nTjEWiGf7ZNdJg6JC+/T5e4eKfTBsruwZ7i5
	 glCkMEEbHjdpGYA3VkWTwtiaDtnu1kKNEQ8cWue4Q+avhr3RL+0dTw1t5QEw3AGRXs
	 oa0fHM/yVEGLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 09/10] staging: rtl8723bs: fix camel case in IE structures
Date: Tue, 14 Jul 2026 22:46:05 -0400
Message-ID: <20260715024606.107096-9-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024606.107096-1-sashal@kernel.org>
References: <2026071347-leotard-finlike-cc76@gregkh>
 <20260715024606.107096-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274699-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9724C75A1EA

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 61ba4fae0a5d81d826810a32c0b30df319d1a925 ]

fix camel case in IE structures all over the driver.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/c1b36466fb5e17aa0dbbcdf6dfef3a82f9739c00.1626874164.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 3bf39f711ff2 ("staging: rtl8723bs: fix OOB reads in is_ap_in_tkip() IE loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 20 ++++++-------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 28 +++++++++----------
 .../staging/rtl8723bs/include/wlan_bssdef.h   | 10 +++----
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index f412a9e4e2d59f..7e845e90850775 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1631,7 +1631,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case _VENDOR_SPECIFIC_IE_:
 			if (!memcmp(pIE->data, WMM_PARA_OUI, 6))	/* WMM */
 				WMM_param_handler(padapter, pIE);
@@ -1652,7 +1652,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 
 	pmlmeinfo->state &= (~WIFI_FW_ASSOC_STATE);
@@ -3222,12 +3222,12 @@ void issue_assocreq(struct adapter *padapter)
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.IELength;) {
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.IEs + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case _VENDOR_SPECIFIC_IE_:
 			if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
 					(!memcmp(pIE->data, WMM_OUI, 4)) ||
 					(!memcmp(pIE->data, WPS_OUI, 4))) {
-				vs_ie_length = pIE->Length;
+				vs_ie_length = pIE->length;
 				if ((!padapter->registrypriv.wifi_spec) && (!memcmp(pIE->data, WPS_OUI, 4))) {
 					/* Commented by Kurt 20110629
 					 * In some older APs, WPS handshake
@@ -3243,26 +3243,26 @@ void issue_assocreq(struct adapter *padapter)
 			break;
 
 		case EID_WPA2:
-			pframe = rtw_set_ie(pframe, EID_WPA2, pIE->Length, pIE->data, &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, EID_WPA2, pIE->length, pIE->data, &(pattrib->pktlen));
 			break;
 		case EID_HTCapability:
 			if (padapter->mlmepriv.htpriv.ht_option) {
 				if (!(is_ap_in_tkip(padapter))) {
 					memcpy(&(pmlmeinfo->HT_caps), pIE->data, sizeof(struct HT_caps_element));
-					pframe = rtw_set_ie(pframe, EID_HTCapability, pIE->Length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
+					pframe = rtw_set_ie(pframe, EID_HTCapability, pIE->length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
 				}
 			}
 			break;
 
 		case EID_EXTCapability:
 			if (padapter->mlmepriv.htpriv.ht_option)
-				pframe = rtw_set_ie(pframe, EID_EXTCapability, pIE->Length, pIE->data, &(pattrib->pktlen));
+				pframe = rtw_set_ie(pframe, EID_EXTCapability, pIE->length, pIE->data, &(pattrib->pktlen));
 			break;
 		default:
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
@@ -5887,7 +5887,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	for (i = _FIXED_IE_LENGTH_; i < pnetwork->IELength;) {
 		pIE = (struct ndis_80211_var_ie *)(pnetwork->IEs + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case _VENDOR_SPECIFIC_IE_:/* Get WMM IE. */
 			if (!memcmp(pIE->data, WMM_OUI, 4))
 				WMM_param_handler(padapter, pIE);
@@ -5936,7 +5936,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 
 	/* check channel, bandwidth, offset and switch */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index b359a409eec4ea..aa02881f4efe59 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -913,7 +913,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 	if (phtpriv->ht_option == false)
 		return;
 
-	if (pIE->Length > sizeof(struct HT_info_element))
+	if (pIE->length > sizeof(struct HT_info_element))
 		return;
 
 	pHT_info = (struct HT_info_element *)pIE->data;
@@ -1003,7 +1003,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->Length); i++) {
+	for (i = 0; i < (pIE->length); i++) {
 		if (i != 2) {
 			/* 	Commented by Albert 2010/07/12 */
 			/* 	Got the endian issue here. */
@@ -1081,11 +1081,11 @@ void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	if (phtpriv->ht_option == false)
 		return;
 
-	if (pIE->Length > sizeof(struct HT_info_element))
+	if (pIE->length > sizeof(struct HT_info_element))
 		return;
 
 	pmlmeinfo->HT_info_enable = 1;
-	memcpy(&(pmlmeinfo->HT_info), pIE->data, pIE->Length);
+	memcpy(&(pmlmeinfo->HT_info), pIE->data, pIE->length);
 }
 
 void HTOnAssocRsp(struct adapter *padapter)
@@ -1125,11 +1125,11 @@ void ERP_IE_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if (pIE->Length > 1)
+	if (pIE->length > 1)
 		return;
 
 	pmlmeinfo->ERP_enable = 1;
-	memcpy(&(pmlmeinfo->ERP_IE), pIE->data, pIE->Length);
+	memcpy(&(pmlmeinfo->ERP_IE), pIE->data, pIE->length);
 }
 
 void VCS_update(struct adapter *padapter, struct sta_info *psta)
@@ -1391,10 +1391,10 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	for (i = 0; i < len;) {
 		pIE = (struct ndis_80211_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case _VENDOR_SPECIFIC_IE_:
 			/* to update WMM parameter set while receiving beacon */
-			if (!memcmp(pIE->data, WMM_PARA_OUI, 6) && pIE->Length == WLAN_WMM_LEN)	/* WMM */
+			if (!memcmp(pIE->data, WMM_PARA_OUI, 6) && pIE->length == WLAN_WMM_LEN)	/* WMM */
 				if (WMM_param_handler(padapter, pIE))
 					report_wmm_edca_update(padapter);
 
@@ -1414,7 +1414,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 }
 
@@ -1430,7 +1430,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.IELength;) {
 			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.IEs + i);
 
-			switch (pIE->ElementID) {
+			switch (pIE->element_id) {
 			case _VENDOR_SPECIFIC_IE_:
 				if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
 					return true;
@@ -1445,7 +1445,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 				break;
 			}
 
-			i += (pIE->Length + 2);
+			i += (pIE->length + 2);
 		}
 
 		return false;
@@ -1500,7 +1500,7 @@ static u32 get_realtek_assoc_AP_vender(struct ndis_80211_var_ie *pIE)
 {
 	u32 Vender = HT_IOT_PEER_REALTEK;
 
-	if (pIE->Length >= 5) {
+	if (pIE->length >= 5) {
 		if (pIE->data[4] == 1)
 			/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
 			/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
@@ -1531,7 +1531,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < len;) {
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
 
-		switch (pIE->ElementID) {
+		switch (pIE->element_id) {
 		case _VENDOR_SPECIFIC_IE_:
 			if ((!memcmp(pIE->data, ARTHEROS_OUI1, 3)) || (!memcmp(pIE->data, ARTHEROS_OUI2, 3))) {
 				return HT_IOT_PEER_ATHEROS;
@@ -1556,7 +1556,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 			break;
 		}
 
-		i += (pIE->Length + 2);
+		i += (pIE->length + 2);
 	}
 
 	return HT_IOT_PEER_UNKNOWN;
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index ea370b2bb8db35..4ac3e2d28ca0a9 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -60,14 +60,14 @@ enum NDIS_802_11_NETWORK_INFRASTRUCTURE {
 };
 
 struct ndis_802_11_fix_ie {
-	u8  Timestamp[8];
-	u16  BeaconInterval;
-	u16  Capabilities;
+	u8  time_stamp[8];
+	u16  beacon_interval;
+	u16  capabilities;
 };
 
 struct ndis_80211_var_ie {
-	u8  ElementID;
-	u8  Length;
+	u8  element_id;
+	u8  length;
 	u8  data[1];
 };
 
-- 
2.53.0


