Return-Path: <stable+bounces-244229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIhxGvQr+mkhKgMAu9opvQ
	(envelope-from <stable+bounces-244229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:42:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5864D239A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D05FD308F810
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA04A3400;
	Tue,  5 May 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imh0GeTP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6A49251A
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002709; cv=none; b=kIjYxKOeVdibAA/cEzNxRhNkd6lTaYjyDXKqNVhBkz0wQ99e8UmhcHXUCKtSyhuo092GQCbk76K6vT5dq/nDJ7BQS8PirMxEHnD0EINT14eejcXIN+fVOTu5K1qHmL/iAn0nkQJi+O1AEFLKVQioGY8tt3OjbW4s4ElvzWqy7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002709; c=relaxed/simple;
	bh=8CBrQmbEsdNgHXYKb6wsIXwlaQPjAq3SREKqrhhl4GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5+1mW50gjpVSb1nnMpJWjTL1yQaVVXuD8aTbDVrymKM7yvQ/6+ovvjYfMU9gQQtuyIuNSwKU6FlEUOdfaf5NJdaZ45duz4kliEZZTrZqYkfB+k4a7qtOgcWZBlRDHDTnDl3xGEmL8nPNIoO/toXGoRei2i9qxlNJQMtXemv7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imh0GeTP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so53529485e9.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002707; x=1778607507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NEFajvV+WD5zm8pAD2atBhqQcX592r+fg8eqdbXZVU=;
        b=imh0GeTPqwgiXldXRicNcUnTeIofIHrGGDSMe+ZXspdqdKhjHCRP0n1pJG9mOzXr5K
         F3SEW0WBzm/rfBMJT94Evi19hZMzoqrZp+WAcKKPpqGX6rdNe0H4wDjE7nXqhyQ6eTLI
         o5HsGQb+zBZyLfE9iHLi30kuSAx0I5sn2C+eCfxRIiSSu5B9qaHmH7pjL8AFFecwj0Hp
         t6JZC8kawpWEcYK5hugawHLVAt/81DnK765afH3sdgYfzrdBf7rWBfHaKJLAqZYdx7yj
         IBEbpK/vOvxx0qhk+7hWj8r9XuaJB1buSNE4dRccDw7GSpnk1CqBY6xhE95aRbtVm4SV
         /NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002707; x=1778607507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NEFajvV+WD5zm8pAD2atBhqQcX592r+fg8eqdbXZVU=;
        b=qCy0DlMoNUbUt4pcbKbpMJII9q+cyPgXJJ6Md27Ty7BTMHiOcinleY0gH5KBqRF1/7
         I4U2lDLUTA8MieXdWm9Kcf/cai2wsm0IaBEsliX3rW1E37DOWf9ZYIdYy5mrS8Qj1hNA
         ejtnGEVg4mKl1JDW6BerFUgxilfaHvfz8UmlDo6031INpworYpxwvwSmNLm5ugrrCJKR
         ZZykPZIdi2kIbkG7qpC67PolhWXycADFR2MsMNC3mGESmUv6sR1l6SZ+HgidZrSb+Rrl
         8JSlNuJTnCslSs+LlO4k9cFDU9XvedGrQ5pcAr90tUkC+vce6EGlwnlroyTyZPoAzHoV
         x6bw==
X-Forwarded-Encrypted: i=1; AFNElJ9DRvViC6ITzm4m+Fg7JCvsuxEbi200+dJacQImlLpc5Bkpg/Eb2jVK9tLL0l99C0z8KKs1C18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Vz727EiQw4JwNur0yY+KnlNJSDpvMQUoE2R4Bg9WnQGhLLmg
	s/mb0H4RAFUd9WwMoLCy6u+RTZmuR317xg7bOczIkPbN+WfvWlskDFfC
X-Gm-Gg: AeBDiesdujf2KDW1ryXS0U5uNzwTYPjIzwwYx8YnKRQ0ioT89dkKevPqzSuj1UsjOpS
	wCBO4ynBZd0/s/5FGT6S9uptBrWJvlM6aeGVf4lcJb9UO/tgWhag9WVja3umUoxAXmLrSpls1N/
	fXWehdHkATwmauJ0CplP/EgMyB2bfEFwPbiUcRr1YF3M9mHrV+qaUbhLWQKA3nd9V+WuzSk3zye
	JIx95UTHp+UyFtqBRSh//Wl9WFIiQn2802wqnh1m62t+TVEHqDvZSyrfWZj2lLrhGgL+57Ku3qo
	fyO3mxLdf9iVYTM8okO6xs2akeSrv7FbnYP3LYbiRW4qW0GFLkuHXQzcHBJSnHKgZ9XOR/s9ED6
	qqlPV5YRN9kOlhzBjMhEQQw9YFpqWOLlDzmdE/XqD3RULqcsuneNU1uM5VuvhBGdzCoofobAs7K
	SAbJ+0WNiYklOC59yRzrB7oRF5M3JYqo5pgS3up1Mle3orlesS/1J3Z3x7Mst5nbpYxim+Vl4PY
	0apUDp2yPTPNi+CnPGcJ6vH16E7GBhah/R0NYxh1xl1Lha+KlHSr6FBgDWxbmHd9+gplDQ=
X-Received: by 2002:a05:600c:34d3:b0:48a:58e1:6d17 with SMTP id 5b1f17b1804b1-48e51f3655emr3935525e9.20.1778002706507;
        Tue, 05 May 2026 10:38:26 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm655473875e9.9.2026.05.05.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:38:26 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] staging: rtl8723bs: fix OOB reads in update_beacon_info() and bwmode_update_check()
Date: Tue,  5 May 2026 19:38:16 +0200
Message-ID: <20260505173818.3674164-2-hossu.alexandru@gmail.com>
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
X-Rspamd-Queue-Id: ED5864D239A
X-Rspamd-Action: no action
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
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244229-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Four out-of-bounds read paths in Beacon IE processing:

1. Unsigned underflow in len computation.

   update_beacon_info() computes:

     len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);

   where len is unsigned int.  If pkt_len is smaller than
   _BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN (36 bytes), the subtraction
   wraps to a very large value, causing the IE loop to iterate over
   memory far beyond the receive buffer.  Add an early return when
   pkt_len is too small.

2. IE header and payload may extend past the packet end.

   The IE loop advances by pIE->length + 2 per iteration but only
   guards on i < len.  When the last IE has only one byte left in
   the frame, the loop reads pIE->length from pframe[len], one byte
   past the receive buffer.  Even when the header bytes are in bounds,
   pIE->length can point the data window past len, silently passing a
   truncated IE to handler functions.  Add two guards: break if fewer
   than sizeof(*pIE) bytes remain, and break if the declared IE payload
   extends past len.

3. WMM OUI comparison reads 6 bytes past a possibly short IE payload.

   For WLAN_EID_VENDOR_SPECIFIC, the code calls
   memcmp(pIE->data, WMM_PARA_OUI, 6) before checking
   pIE->length == WLAN_WMM_LEN.  An IE with pIE->length < 6 causes
   memcmp to read into adjacent frame data.  Swap the condition so the
   length check comes first.

4. bwmode_update_check() missing minimum IE length check.

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

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 6a7c09db4cd9..7ccfaa538ebb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -850,7 +850,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 	if (phtpriv->ht_option == false)
 		return;
 
-	if (pIE->length > sizeof(struct HT_info_element))
+	if (pIE->length != sizeof(struct HT_info_element))
 		return;
 
 	pHT_info = (struct HT_info_element *)pIE->data;
@@ -1286,15 +1286,23 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	unsigned int len;
 	struct ndis_80211_var_ie *pIE;
 
+	if (pkt_len < _BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN)
+		return;
+
 	len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);
 
 	for (i = 0; i < len;) {
+		if (i + sizeof(*pIE) > len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
+		if (i + sizeof(*pIE) + pIE->length > len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
 			/* to update WMM parameter set while receiving beacon */
-			if (!memcmp(pIE->data, WMM_PARA_OUI, 6) && pIE->length == WLAN_WMM_LEN)	/* WMM */
+			if (pIE->length == WLAN_WMM_LEN &&
+			    !memcmp(pIE->data, WMM_PARA_OUI, 6))	/* WMM */
 				if (WMM_param_handler(padapter, pIE))
 					report_wmm_edca_update(padapter);
 
@@ -1314,7 +1322,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 }
 
-- 
2.53.0


