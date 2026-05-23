Return-Path: <stable+bounces-253942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LjqNB6oEWqDogYAu9opvQ
	(envelope-from <stable+bounces-253942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 15:14:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BB75BF009
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 15:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC2BF301230B
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8C38A72C;
	Sat, 23 May 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NusQgIzs"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E6383338
	for <stable@vger.kernel.org>; Sat, 23 May 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779542043; cv=none; b=Slv1UMlokvJ6PiRDZGVCmh9XpJNKh5baFZK6rDpKxhYk41fAAp1cv1HVvgVvIRBlTq8bMmEzDLTvljU+e82MeEFmFMtjhUrGegAmCr3igAAuh212b/3cy6b0B3rpTG2NB+yPZTghMQvd6xoN2GdTa/fVdoYAVlfmCGSG+5P2mPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779542043; c=relaxed/simple;
	bh=KQAeVvVN0MheHWZp4Nj2HGnVlhnPG1/yZY58CICJc+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nb4rBDYT6vDAj0pIClmWppburweib3C2kp7X16FSSIswk7VZn0UNtENjb++CQwjpM5JulhVi+CPMtE39ZRrg3X9QIHCmS1Zski1KQWt5FghhYqqUQTlimfM4rJIeqFjttOXcsmy6krCBooyz/7Xgi4WvwLM1mZR83YZ1NvLvsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NusQgIzs; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779542030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SCzHz2JG+vObaosw9ZhXVRq7YLHhvSiS0NpLk9UTNjs=;
	b=NusQgIzszq3IPCDS2cjn0RLKGX3nwnmJQlkCH/qJB1Jrh2pBLPnC76HnBvXzoJROL+7Sz9
	5jLBPoFju+s6GFg6+q8gosotRbqTo5KXWZHOOilT6jmnjPOhIDuVRnyDJk74BW8FdWYo/0
	vgJYnKBcH5iqF+ZB/Ln4wTEEiq1ogDY=
From: luka.gejak@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v7] staging: rtl8723bs: fix remote heap info disclosure and OOB reads
Date: Sat, 23 May 2026 15:13:31 +0200
Message-ID: <20260523131331.69768-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253942-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 53BB75BF009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

When building an association request frame, the driver iterates over
the ies received from the ap. In several places, the driver trusts the
attacker-controlled pIE->length without validating that it meets the
minimum expected size for the respective ie.

For WLAN_EID_HT_CAPABILITY, this causes an oob read of adjacent heap
memory which is then transmitted over the air (remote heap information
disclosure). For WLAN_EID_VENDOR_SPECIFIC, it causes two separate oob
reads: one when checking the 4-byte oui, and another when copying the
14-byte wps ie.

Fix these issues by adding upper-bound checks at the start of the loop
to ensure the ie fits within the buffer, and explicit lower-bound
checks to return a failure if the length is insufficient. For
HT_CAPABILITY, also clamp the length passed to rtw_set_ie() to the
struct size.

Also fix three additional issues discovered during review:
- Missing free of pmgntframe and its xmitbuf before jumping to exit
  in the WLAN_EID_VENDOR_SPECIFIC lower-bound checks.
- In is_ap_in_tkip(), add missing lower-bound checks for the RSN and
  vendor-specific IE data accesses (pre-existing bug).
- Move rtw_buf_update() before dump_mgntframe() to avoid a potential
  use-after-free of pwlanhdr, which points into the mgmt frame buffer
  (pre-existing bug).

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
Changes in v7:
 - Address new sashiko comments.

Changes in v6:
 - Restore full changes history.

Changes in v5:
 - Address sashiko comments.

Changes in v4:
 - Added upper-bound checks at the start of the loop to ensure the ie
  fits within the received buffer, as pointed out by Dan.
 - Updated commit message to reflect the addition of upper-bound checks.

Changes in v3:
 - Switched to fail-fast handling for malformed IEs in issue_assocreq().
 - Fixed HT capability path to use structure-sized output length in 
  rtw_set_ie().
 - Updated commit message to reflect all oob read cases.

Changes in v2:
 - Refactored rtw_set_ie() alignment to follow "open parenthesis" style.
 - Allowed the line length to exceed 100 characters for better
  readability as requested by Greg KH.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 43 +++++++++++++++++--
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 13 +++++-
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a86d6f97cf02..43112d14f619 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2826,6 +2826,9 @@ void issue_assocreq(struct adapter *padapter)
 		if (pmlmeinfo->network.supported_rates[i] == 0)
 			break;
 
+		if (index >= NumRates)
+			break;
+
 		/*  Check if the AP's supported rates are also supported by STA. */
 		for (j = 0; j < sta_bssrate_len; j++) {
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
@@ -2855,10 +2858,28 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* vendor specific IE, such as WPA, WMM, WPS */
 	for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+		if (i + 2 > pmlmeinfo->network.ie_length) {
+			rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
+			rtw_free_xmitframe(pxmitpriv, pmgntframe);
+			goto exit;
+		}
+
 		pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
+		if (pIE->length > pmlmeinfo->network.ie_length - i - 2) {
+			rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
+			rtw_free_xmitframe(pxmitpriv, pmgntframe);
+			goto exit;
+		}
+
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (pIE->length < 4) {
+				rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
+				rtw_free_xmitframe(pxmitpriv, pmgntframe);
+				goto exit;
+			}
+
 			if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
 					(!memcmp(pIE->data, WMM_OUI, 4)) ||
 					(!memcmp(pIE->data, WPS_OUI, 4))) {
@@ -2870,6 +2891,12 @@ void issue_assocreq(struct adapter *padapter)
 					 * extensions information to AP
 					 */
 
+					if (pIE->length < 14) {
+						rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
+						rtw_free_xmitframe(pxmitpriv, pmgntframe);
+						goto exit;
+					}
+
 					vs_ie_length = 14;
 				}
 
@@ -2883,8 +2910,17 @@ void issue_assocreq(struct adapter *padapter)
 		case WLAN_EID_HT_CAPABILITY:
 			if (padapter->mlmepriv.htpriv.ht_option) {
 				if (!(is_ap_in_tkip(padapter))) {
+					if (pIE->length < sizeof(struct HT_caps_element)) {
+						rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
+						rtw_free_xmitframe(pxmitpriv, pmgntframe);
+						goto exit;
+					}
+
 					memcpy(&(pmlmeinfo->HT_caps), pIE->data, sizeof(struct HT_caps_element));
-					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, pIE->length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
+					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY,
+							    sizeof(struct HT_caps_element),
+							    (u8 *)&pmlmeinfo->HT_caps,
+							    &pattrib->pktlen);
 				}
 			}
 			break;
@@ -2903,15 +2939,14 @@ void issue_assocreq(struct adapter *padapter)
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
 		pframe = rtw_set_ie(pframe, WLAN_EID_VENDOR_SPECIFIC, 6, REALTEK_96B_IE, &(pattrib->pktlen));
 
+	rtw_buf_update(&pmlmepriv->assoc_req, &pmlmepriv->assoc_req_len, (u8 *)pwlanhdr, pattrib->pktlen);
 	pattrib->last_txcmdsz = pattrib->pktlen;
 	dump_mgntframe(padapter, pmgntframe);
 
 	ret = _SUCCESS;
 
 exit:
-	if (ret == _SUCCESS)
-		rtw_buf_update(&pmlmepriv->assoc_req, &pmlmepriv->assoc_req_len, (u8 *)pwlanhdr, pattrib->pktlen);
-	else
+	if (ret != _SUCCESS)
 		rtw_buf_free(&pmlmepriv->assoc_req, &pmlmepriv->assoc_req_len);
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 1d37c2d5b10d..b8e88aaad897 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1301,17 +1301,26 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 
 	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
 		for (i = sizeof(struct ndis_802_11_fix_ie); i < pmlmeinfo->network.ie_length;) {
+			if (i + 2 > pmlmeinfo->network.ie_length)
+				return false;
+
 			pIE = (struct ndis_80211_var_ie *)(pmlmeinfo->network.ies + i);
 
+			if (pIE->length > pmlmeinfo->network.ie_length - i - 2)
+				return false;
+
 			switch (pIE->element_id) {
 			case WLAN_EID_VENDOR_SPECIFIC:
-				if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
+				if (pIE->length >= 16 &&
+				    (!memcmp(pIE->data, RTW_WPA_OUI, 4)) &&
+				    (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
 					return true;
 
 				break;
 
 			case WLAN_EID_RSN:
-				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
+				if (pIE->length >= 12 &&
+				    !memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
 					return true;
 				break;
 
-- 
2.54.0


