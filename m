Return-Path: <stable+bounces-238131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGmYMc2U32leWQAAu9opvQ
	(envelope-from <stable+bounces-238131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:38:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C81404E95
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8479D3017275
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570FA39447C;
	Wed, 15 Apr 2026 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JWiYl9aT"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8E2222D0
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260297; cv=none; b=YYAccssMfI5odm2nvTC/ipCEq1oA4rdTX3iEuxpTfQNOWkDTA/GocsU6NbtUcl30LF5/fPVA+ZWqrisMuumb7fwtCFkoaFtCMwLMTMK1tLZWpfgNY1TA2A8XeZfL7row3zOVbdpPJhsnpEzlCXpRQuz6k0IVHtmW7W2thR1bLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260297; c=relaxed/simple;
	bh=WEVtMcvC6IMJGSHfPZLUGBV6n4E310dWGl8ARXDze+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSsXEHDFm2TmtnQqS9O/9+Ev2uwUlNETGPRkKYbfASKcXMGSHQ4aF7OXcgTfyrBBssqflyzFZKMYAHcOA0O1LWYALtZ3n3y4F+AYKKtk4QGSBd0GFFgRGotRd14qTDs902FRIAA+Q8nUqxs6uEnjkUM7WzPDnjux0ktRuTNJ6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JWiYl9aT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776260283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eOUJV3MAzB9ycsfyKVzXZRlRnEqGqLZSyN20vIP92bY=;
	b=JWiYl9aTfBfIAvPgUlpd7ZLVQVfPjLZIWfPM+v23a4e/pQKvlkJsKofL9WgYCA7EVOfScf
	xB6Nkrh6COlyvQVSP04Paze/xSv9a8n96uMH0tMe8a4XPE6VnJAjR/O0kZQZ6vGo5D9ODk
	gP4GeM2iwvS7eS6HkOEBEw5+ob0Ougw=
From: luka.gejak@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luka Gejak <luka.gejak@linux.dev>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] staging: rtl8723bs: fix remote heap info disclosure and OOB reads
Date: Wed, 15 Apr 2026 15:37:26 +0200
Message-ID: <20260415133726.23515-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238131-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66C81404E95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fix these issues by adding explicit length checks and returning a
failure if the length is insufficient. For HT_CAPABILITY, also clamp
the length passed to rtw_set_ie() to the struct size.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
Changes in v3:
- Switched to fail-fast handling for malformed IEs in issue_assocreq().
- Fixed HT capability path to use structure-sized output length in rtw_set_ie().
- Updated commit message to reflect all oob read cases.

Changes in v2:
- Refactored rtw_set_ie() alignment to follow "open parenthesis" style.
- Allowed the line length to exceed 100 characters for better readability as requested by Greg KH.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..3d44bc36532d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2929,6 +2929,9 @@ void issue_assocreq(struct adapter *padapter)
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (pIE->length < 4)
+				goto exit;
+
 			if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
 					(!memcmp(pIE->data, WMM_OUI, 4)) ||
 					(!memcmp(pIE->data, WPS_OUI, 4))) {
@@ -2940,6 +2943,9 @@ void issue_assocreq(struct adapter *padapter)
 					 * extensions information to AP
 					 */
 
+					if (pIE->length < 14)
+						goto exit;
+
 					vs_ie_length = 14;
 				}
 
@@ -2953,8 +2959,14 @@ void issue_assocreq(struct adapter *padapter)
 		case WLAN_EID_HT_CAPABILITY:
 			if (padapter->mlmepriv.htpriv.ht_option) {
 				if (!(is_ap_in_tkip(padapter))) {
+					if (pIE->length < sizeof(struct HT_caps_element))
+						goto exit;
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
-- 
2.53.0


