Return-Path: <stable+bounces-247153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKEKNIOQBWrfYgIAu9opvQ
	(envelope-from <stable+bounces-247153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:06:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D553F939
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B455301FA43
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3AC3DDDA0;
	Thu, 14 May 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HwoOa57P"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8483DFC6E
	for <stable@vger.kernel.org>; Thu, 14 May 2026 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749568; cv=none; b=Hc40shKYrGDdK2WGSfKY3dhkjPpygHtCyBFnPm82kt1rPCEZ7bdRKgyWhBF6GlgmoHNMgxcSZiohuiHrSXQ4R/xZvMTbTi9TU3PEOKz0dvQ1a4bnpyPZ+v0LAIeRvVHX9ssDlWJQuojExZLlK3XKr2vZVRZewcERIrc0hGfV9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749568; c=relaxed/simple;
	bh=KeSs1IZyaM5XXAriQLFAQWjNHnLfy6KHENc5JdOH3sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCHjUVFFViwqs+1F+tvHSGgt9p7xnOin+ZASuSKpThdxuavzPq/FIpqLsupoxr4NU0guzQfU0MFXscMqOyJ+vvbBiyN6qO9bFdUSlWOyXU9BtdA3tHIpVxrWwmo4iWcQxt2KuXAYyeMHmPhDxA24tpfRYyX3Apo1tSclrsxG7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HwoOa57P; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778749553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iZJL4wKnNFo+5di5y00KUEPbBrFyfQZabLTGGCpuu58=;
	b=HwoOa57PkDCW4fg7k5LM7Byxle86aOdbZk/xYT6BInK3ij956ZEEESE/Ec04BubT0SPH08
	7A0/gisn+ewIXhM4QESC8LSHoYMU63Tlxw14OZaAZ3GjZWXX9Q+Zdw41iqxCjVRDzFEnsu
	zyJZ01orNJIfRBKhbfdlTUAPSUuM2Rw=
From: luka.gejak@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v6] staging: rtl8723bs: fix remote heap info disclosure and OOB reads
Date: Thu, 14 May 2026 11:05:25 +0200
Message-ID: <20260514090525.6161-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 352D553F939
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Luka Gejak <luka.gejak@linux.dev>

When building an association request frame, the driver iterates over
the ies received from the ap. In three places, the driver trusts the
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

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
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

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 32 ++++++++++++++++++-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  6 ++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index cfd3eb253350..e448a814eb1c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2862,6 +2862,9 @@ void issue_assocreq(struct adapter *padapter)
 		if (pmlmeinfo->network.supported_rates[i] == 0)
 			break;
 
+		if (index >= NumRates)
+			break;
+
 		/*  Check if the AP's supported rates are also supported by STA. */
 		for (j = 0; j < sta_bssrate_len; j++) {
 			 /*  Avoid the proprietary data rate (22Mbps) of Handlink WSG-4000 AP */
@@ -2891,10 +2894,25 @@ void issue_assocreq(struct adapter *padapter)
 
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
+			if (pIE->length < 4)
+				goto exit;
+
 			if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
 					(!memcmp(pIE->data, WMM_OUI, 4)) ||
 					(!memcmp(pIE->data, WPS_OUI, 4))) {
@@ -2906,6 +2924,9 @@ void issue_assocreq(struct adapter *padapter)
 					 * extensions information to AP
 					 */
 
+					if (pIE->length < 14)
+						goto exit;
+
 					vs_ie_length = 14;
 				}
 
@@ -2919,8 +2940,17 @@ void issue_assocreq(struct adapter *padapter)
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
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index cc1a7497764c..dc4abef3a7b8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1327,8 +1327,14 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 
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
 				if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
-- 
2.54.0


