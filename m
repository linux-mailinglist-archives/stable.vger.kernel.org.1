Return-Path: <stable+bounces-245302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kORSFZoXAmognwEAu9opvQ
	(envelope-from <stable+bounces-245302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:53:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A1513DD8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC57F307F804
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A743E9C6;
	Mon, 11 May 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTLoJYb6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB663BF675
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519167; cv=none; b=oaoLHDTMvkoLPhkG7iOys7ofXxv42uDTaUpH0tzGxnPQXGFs3kS4BFiz17MQBPzxnkYiAKbCW5L/HvSL0LMnHFXWp9puo1i5a2suMXRAzlwZTIoINLNYbGhlw6lX3qqrn2ytYxUNJTUz1zZzPYrHBoQkb4pE43UHmvfqiDLD3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519167; c=relaxed/simple;
	bh=Rf0Cn4jll7ZOrJfZWaKXuFvQ+6Osk3POFETyOckuRjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlVE0xPqBNmF2C/BHKM+Td0KMDhmvw7Fls1nXX4GWBAdufTGzCQKU6XnUKudmgBnn3GI3VqS0JSd3LFOnGlR9b56hd7uM3ACsYoPB6xoeU9vAcKZrLB5qLcHiQ31wpZWMvc0MVDatSgPKu5kPk27srDZQjIZ7wZ2IYqZ+pffIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTLoJYb6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd124546379so129317366b.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519164; x=1779123964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEyQ0dx4b99eyqrmXV2BKWIdSYpmr4F2ENUgwTR4Qko=;
        b=cTLoJYb6ejHKsXnV1MZkvkq/7hPBEyLPxiBHKrw32e//ED62c5+K/e0x/qtWBkwikh
         lw6/AydfD7VEhDxn2++erk4IzAT3pBwKWKOI0LThdj+a9uyzPYVfNnbkUmJ+FGi5jyAQ
         gO4ENidnHrAjoaDG6sFE7gbVW6lai/fvYEXMeY1SOCOC+OyxB4Dy1pOoMsHX3SwBXlty
         OuPNDxjOLsy3T7IVgel/08cP/OZSpr68bM2WB2+KykXU34y5ak+0LhYIk6icVVcPN3Ia
         cdMN+FqxT+8+o6qSDTExK2emyG85LtzuVkfidlvTB3g0bREaeJwFE/9rB7flD4wBM3hk
         7KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519164; x=1779123964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IEyQ0dx4b99eyqrmXV2BKWIdSYpmr4F2ENUgwTR4Qko=;
        b=aziDFRgMIWOP3uTBuV+V397ukJCeHftcFnf6azvMQmuKtyJH8nn+uarKC3k4GU2MNQ
         klW83BCZ8+2sX6GEmgOpVvFIn7+hZ7Z+36DRuX7r+3OXzkc3QP+w7mLRFoPBsHiAtk+J
         AvHOMWqq8hf5oZIbDEEME/u9WFjcg5s0v9LymF/Aw1RcRruAESZBwNDQi83lsacuW7t1
         bgYkpeNX/56cVy7Tba9a6UCfkOYHDE1sBmyb2plaFphnLfEsoF7qWLqzzCNNt0JQS4G/
         w7df/24O7G/1kxtzNhChamixgJDyjhoBejRvkIa0h5gyPTjSHPXvfxcHBOWojcqTEv1P
         gplQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lAvYKZefHKH2sfPIUldjnusBHd4uQeL7zH4sEdpry6IccopAAKQC0clwR5BVGk8vxBfVM7Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HnwtuO3UkU8uZJVqirOPuzejwQ3pjUmiXCJgG627+Ayq3mnq
	sIaScSGydnPa+Im+btFGxgK55wv5SfxW/v2nKRluV16Ss8wkDFYhmZIx
X-Gm-Gg: Acq92OHkjGZRb/HzUhwRmpA5JFpfgT0uVUNVt5E2otAxj7GlZttv7tWaryGX+j9ewTI
	1Y0YRNR/GTNiONQHt7g3hYajXMX4bTFQdQQcVlnTk03w7dpm5mWeRNzr2tI17w6lQogLeT6Yh8K
	TcRBRmvT3JbBdWFyhz4uMR0UsHHT0c0JnjcPAnM7+3LuyY7HEHSMsuzQ4cfUr91ObDhTJLhIJ3p
	5om8sFY6uNsibgp0E2XgpikQY9kCp5ecAorYPYWLdOhtAp5xnQQwtB9lNrgYNzu3v5UV6TvEvX1
	8q58aJjVgEoGGCI7Loz2sAGLJYE8ZOecF2QsFAoPmuVCEmGczissxtZEkqyiwVhF4LTVTbGuuHM
	OwttiCObbvQs1trFCZnmLX5cs9AQkNLR3QNrYe9n3PqDsb0tLMGpPYygt39K9l2DHLBTssSYxN9
	zPkNxxK5PdJ/rIZLcdfk32LwOeaHyd1lTG/MrZ6rc4ZRtiRR7FhtNWQeWZlPhzBHzK1hbyqRxG2
	vBkBBK5elWC6LoP37yG/5m5qlluiW3vQA3mDvSerq/pSVN0zvFmb82rqbpMBGWOiw==
X-Received: by 2002:a17:907:da16:b0:bc2:e438:da0c with SMTP id a640c23a62f3a-bc56c72d871mr1459282166b.22.1778519163525;
        Mon, 11 May 2026 10:06:03 -0700 (PDT)
Received: from ahossu.localdomain ([2a02:a420:2368:9048:c0cb:8552:96ce:1210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bccffbac588sm325319366b.6.2026.05.11.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:06:02 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: greg@kroah.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 2/3] staging: rtl8723bs: fix OOB reads in IE loops in issue_assocreq() and join_cmd_hdl()
Date: Mon, 11 May 2026 18:57:42 +0200
Message-ID: <20260511165743.1588637-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511165743.1588637-1-hossu.alexandru@gmail.com>
References: <20260511165743.1588637-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E1A1513DD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-245302-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Seven out-of-bounds read paths in the IE parsing loops of
issue_assocreq() and join_cmd_hdl():

1. Vendor-specific OUI comparison reads 4 bytes past a possibly short
   IE payload (issue_assocreq).

   For WLAN_EID_VENDOR_SPECIFIC, the code calls memcmp(pIE->data,
   OUI, 4) on RTW_WPA_OUI, WMM_OUI, and WPS_OUI without first
   verifying that pIE->length is at least 4.  Add pIE->length >= 4
   guard before the comparisons.

2. WPS truncation path passes vs_ie_length = 14 when pIE->length < 14
   (issue_assocreq).

   When wifi_spec is 0 and the IE matches WPS_OUI, the code sets
   vs_ie_length = 14 and passes pIE->data to rtw_set_ie() regardless
   of pIE->length.  If pIE->length is between 4 and 13, rtw_set_ie()
   reads up to (14 - pIE->length) bytes past the IE payload.  Skip the
   IE with break when pIE->length < 14.

3. HT Capability IE memcpy reads sizeof(struct HT_caps_element) bytes
   from an IE that may be shorter (issue_assocreq).

   The WLAN_EID_HT_CAPABILITY handler copies:

     memcpy(&pmlmeinfo->HT_caps, pIE->data, sizeof(struct HT_caps_element));

   If pIE->length < sizeof(struct HT_caps_element), the memcpy reads
   beyond the end of the IE payload.  Add a minimum length check and
   skip the IE if it is too short.

4. rtw_set_ie called with untrusted pIE->length for HT Capability
   (issue_assocreq).

   After the memcpy the code passes pIE->length directly to
   rtw_set_ie() as the IE body length.  If pIE->length exceeds
   sizeof(struct HT_caps_element), rtw_set_ie copies that many bytes
   from pmlmeinfo->HT_caps, reading past the end of the struct.
   Use sizeof(struct HT_caps_element) instead.

5. WMM guard in join_cmd_hdl() insufficient for WMM_param_handler().

   The WLAN_EID_VENDOR_SPECIFIC handler in join_cmd_hdl() calls
   WMM_param_handler() after a pIE->length >= 4 OUI check.
   WMM_param_handler() reads pIE->data + 6 and copies
   sizeof(struct WMM_para_element) = 18 bytes, requiring a minimum of
   24 bytes total.  Strengthen the guard to pIE->length >= WLAN_WMM_LEN.

6. HT Operation IE accessed without minimum length check (join_cmd_hdl).

   The WLAN_EID_HT_OPERATION handler casts pIE->data to
   struct HT_info_element * and reads pht_info->infos[0] (offset 1)
   without verifying pIE->length >= sizeof(struct HT_info_element).
   A zero- or one-byte HT Operation IE causes an out-of-bounds read.
   Add a minimum length check and break if the IE is too short.

7. Loop advancement uses literal 2 instead of sizeof(*pIE) in both
   loops.

   i += (pIE->length + 2) is functionally equivalent to
   i += sizeof(*pIE) + pIE->length today, but the literal 2 is
   inconsistent with the sizeof(*pIE) guards added at the top of each
   loop.  Use sizeof(*pIE) + pIE->length for consistency.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v5:
  - In the WPS truncation path of issue_assocreq(), v4 set
    vs_ie_length = 14 and called rtw_set_ie() with pIE->data even when
    pIE->length < 14, reading (14 - pIE->length) bytes past the IE
    payload.  Fixed by breaking out of the switch when pIE->length < 14
    (sashiko review of v4).
  - The WMM guard in join_cmd_hdl() was pIE->length >= 4, sufficient for
    the OUI check but not for WMM_param_handler(), which reads
    pIE->data + 6 and copies sizeof(struct WMM_para_element) = 18 bytes
    (total 24).  Strengthened to pIE->length >= WLAN_WMM_LEN
    (sashiko review of v4).

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

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 68ce422305ed..0c4a73805d39 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2943,9 +2943,10 @@ void issue_assocreq(struct adapter *padapter)
 
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
@@ -2953,7 +2954,8 @@ void issue_assocreq(struct adapter *padapter)
 					 * would be fail if we append vendor
 					 * extensions information to AP
 					 */
-
+					if (pIE->length < 14)
+						break;
 					vs_ie_length = 14;
 				}
 
@@ -2967,8 +2969,10 @@ void issue_assocreq(struct adapter *padapter)
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
@@ -2981,7 +2985,7 @@ void issue_assocreq(struct adapter *padapter)
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
@@ -5340,7 +5344,8 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:/* Get WMM IE. */
-			if (!memcmp(pIE->data, WMM_OUI, 4))
+			if (pIE->length >= WLAN_WMM_LEN &&
+			    !memcmp(pIE->data, WMM_OUI, 4))
 				WMM_param_handler(padapter, pIE);
 			break;
 
@@ -5353,7 +5358,12 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
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
@@ -5384,7 +5394,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 
 	/* check channel, bandwidth, offset and switch */
--
2.53.0


