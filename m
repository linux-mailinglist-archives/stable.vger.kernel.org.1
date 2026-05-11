Return-Path: <stable+bounces-245299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLHLLZUWAmoVnwEAu9opvQ
	(envelope-from <stable+bounces-245299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:49:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21951513C41
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 022973166465
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D543CEDF;
	Mon, 11 May 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9u/3l8S"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B643DA59
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518701; cv=none; b=V8XsFTsGyxigqRg3wZ71EBqLQkmD2vmeeTyaqyO+EPs0Kbe1xSwSVe2fm8Sbvd46NR1tQOEnY9bBWRDxDNu7v+uyjILHKwgW0n67cjojgLwtyorXuHpy8CcJe/y17mgUdLBS+oyV91I5LhlgemnD7BxCI4Bdc8DMgoqsRAMIHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518701; c=relaxed/simple;
	bh=3tSls8Cx41wcmloqp7VxXz2tkYeZitn2b5K53r33Nt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icVPb/NxF0B2eXo5zOwuUDtQrD6lbssPTK2vmH0u8VRX6r4zx/hqdNu0hKszFxQDgk2mTSpH1Txz5rE2z6DKgPSEVolkcGieSsc44WNRaQVJ9KsCLRsadd16gqqt/uTNLsUaWFTxHt7CC+EpEZ9gyhEjGJjBkJ9sRP/CaTZed3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9u/3l8S; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67c3cb1433cso8020851a12.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518698; x=1779123498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siPIRgKJr8laGYIu25dKGO52Hs80aRg2z3cm/KySn6w=;
        b=g9u/3l8S6PANtnPlAR8zPclT/6K06M46Y4GaklZseszqV3vCfbDGu3gVsO8EoUI/cV
         wFIyjr/rMnZOqqhqaHjeOGTBL8XHEf6ADhaH2h3lAv4vHkytVbDsJNED3wVY3B8YjGHG
         vJ4UpDoYjZwN/a1LMymYV5nqtIicug6YaU/2wBFC8NI7Aegbbq6o549rIGQfH0CE8K3L
         154v8e4U45tCzfWv6ZEpwzKqyIAjKICrNZT78Qj5IvSBlwLyGdObP7DraUBXDg7INnGw
         7xGMyMzNECHo80wjW0JbcDjAQNFJCNeJgWaHrXP0A7qH9KGx1hR+jJu5g3+/E/QRidJO
         g5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518698; x=1779123498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siPIRgKJr8laGYIu25dKGO52Hs80aRg2z3cm/KySn6w=;
        b=Now+uUkcGmhLr2yEAzrmT7AO+X7ZeKC1M/uT3Gh5zlXJmgEtCJHgIIsAuaJFdpfUMk
         WYJnAvefTE2Qx05IvVdkEWT93AVg2sYSR1T5SXCm8VDl8WwQeLIJmunK91jBeMRSljby
         c38ekW9PMZVQZ/TfDlEM7Tz2PzR2SRujpaEeJsXzvKTsYKEx0z61Y5b/mMj6B2Er0huh
         wsTjpAdOpueQuHf8K728sYu/NFCZ+E0exorzPZyIjkKrPvmgCMYmJNE7L31bJsvGNwWT
         cNwvoCaMQZPfrnQha7j2TFPbKzYDanPCs2SEwONsdWYFxs0uh9tWVcXA+PrMGteG0P8a
         mpyw==
X-Forwarded-Encrypted: i=1; AFNElJ/z4rNktlryQ3EJWtsN3BXlV0G8fBl/lTfqstdGc3O4bQ0U9L340vCk0zRxx8BYR6eC4fuNgKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMy+nIfp0KSQQ7AYd9QeCPpm8SueQCMJF0TGMq915dD2UBJdF2
	Bf42MX+sD/uLZZy5sMliCDm+KojUeMEwd8/+Mg4z4OuDlrbDQ0BOo2Cf
X-Gm-Gg: Acq92OE53IW7hBhpsF5HzFdkzLAaAkrLkQn8WJQBSybItG01XW+VKYICzYnmelCeOIg
	kNnT7rcUH06uaAxZIe6PSsHwZzMEHy6M1mLVu7p1XF4KcyNZPaQkkulBPibE5JdiERZCSlY7h3w
	YtZi+/Xm1fBgSAwowdGradWqCEn5ga5dyQedx9Jnh4na0rtjlfEIv1IGvCwCciUg1zrZN7Dd1dR
	YESjzz1+DPA+H9t6rgm02O6W1AiabvxdmWTZMLewBmrbM5OYG4x/SVvLzVwWaqc275GUi2o/FmA
	W3oVZU9JNTJAbVjKXiUiIwSQFLFyQoOuEI5T/m+geOTK6dj3N0d7WTzfKjq9nopMgKD3qj2+b+q
	S+ihaEDMXvg7hWgqCtHozsrWfB+1OPaiv8SktvycaTW5cqvgAzqDzJhbz/9+ZjQEjBAqqrJbRgv
	2P1vsl9mp1408h/R/s/mBGEjnScc/l8yX/JMZKoTNawpvTH4eQlU/Lqd6kiEYI39ryqg5ajdwM9
	CbXPuML1bNOI2a0BPSIpQ+EzLs+13dWWu946Jk8AqpAsgebFIrrqCf2vhOTMJ40NA==
X-Received: by 2002:a17:907:c18:b0:bb8:b536:55dd with SMTP id a640c23a62f3a-bc56d713f3bmr1549976866b.41.1778518697764;
        Mon, 11 May 2026 09:58:17 -0700 (PDT)
Received: from ahossu.localdomain ([2a02:a420:2368:9048:c0cb:8552:96ce:1210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bccffbac588sm325319366b.6.2026.05.11.09.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:58:17 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: greg@kroah.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 1/3] staging: rtl8723bs: fix OOB reads in update_beacon_info() and bwmode_update_check()
Date: Mon, 11 May 2026 18:57:41 +0200
Message-ID: <20260511165743.1588637-2-hossu.alexandru@gmail.com>
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
X-Rspamd-Queue-Id: 21951513C41
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-245299-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

Three out-of-bounds read paths in Beacon IE processing:

1. Unsigned underflow in len computation.

   update_beacon_info() computes:

     len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);

   where len is unsigned int.  If pkt_len is smaller than
   _BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN (36 bytes), the subtraction
   wraps to a very large value, causing the IE loop to iterate over
   memory far beyond the receive buffer.  Add an early return when
   pkt_len is too small.

2. WMM OUI comparison reads 6 bytes past a possibly short IE payload.

   For WLAN_EID_VENDOR_SPECIFIC, the code calls
   memcmp(pIE->data, WMM_PARA_OUI, 6) before checking
   pIE->length == WLAN_WMM_LEN.  An IE with pIE->length < 6 causes
   memcmp to read into adjacent frame data.  Swap the condition so the
   length check comes first.

3. bwmode_update_check() missing minimum IE length check.

   bwmode_update_check() rejects IEs longer than
   sizeof(struct HT_info_element) but accepts any shorter length,
   including zero.  After the check it casts pIE->data to
   struct HT_info_element * and reads infos[0] (offset 1), which is
   out of bounds when pIE->length is 0 or 1.  Change the guard from
   > to != to require the IE to be exactly the expected size.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v5:
  - No code changes from v4.

Changes in v4:
  - Add pkt_len < _BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN guard before the
    len subtraction to prevent unsigned underflow (sashiko review of v3).
  - Swap WLAN_EID_VENDOR_SPECIFIC condition: check pIE->length ==
    WLAN_WMM_LEN before memcmp to avoid reading 6 bytes from a short IE
    payload (sashiko review of v3).
  - Fix bwmode_update_check(): change > sizeof(struct HT_info_element) to
    != sizeof(struct HT_info_element) to also reject IEs shorter than the
    expected size, preventing the read of infos[0] on a zero-length IE
    (sashiko review of v3).

Changes in v3:
  - No code changes from v2.

Changes in v2:
  - Add IE loop header and payload bounds checks in update_beacon_info().
  - Use sizeof(*pIE) + pIE->length instead of pIE->length + 2 for
    consistency with the sizeof(*pIE) guards (Dan Carpenter).

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index dd34f229df12..6ea0d646b961 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -850,7 +850,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 	if (phtpriv->ht_option == false)
 		return;
 
-	if (pIE->length > sizeof(struct HT_info_element))
+	if (pIE->length != sizeof(struct HT_info_element))
 		return;
 
 	pHT_info = (struct HT_info_element *)pIE->data;
@@ -1287,6 +1287,9 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	unsigned int len;
 	struct ndis_80211_var_ie *pIE;
 
+	if (pkt_len < _BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN)
+		return;
+
 	len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);
 
 	for (i = 0; i < len;) {
@@ -1299,7 +1302,8 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
 			/* to update WMM parameter set while receiving beacon */
-			if (!memcmp(pIE->data, WMM_PARA_OUI, 6) && pIE->length == WLAN_WMM_LEN)	/* WMM */
+			if (pIE->length == WLAN_WMM_LEN &&
+			    !memcmp(pIE->data, WMM_PARA_OUI, 6))	/* WMM */
 				if (WMM_param_handler(padapter, pIE))
 					report_wmm_edca_update(padapter);
 
--
2.53.0


