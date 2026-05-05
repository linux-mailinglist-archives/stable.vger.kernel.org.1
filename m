Return-Path: <stable+bounces-244231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHY9OCss+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:43:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437954D23EF
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E5F30ED8D7
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A6F3C1981;
	Tue,  5 May 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7cPScKU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A444A33FA
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002714; cv=none; b=MXxdZ5FwAJhR9kuCPrxnZBfMRB3hJhSUS6d1Ne0de5Tj4MNgtuS7xCHbBxfzACNV8nZAlBCHRXtkYh0PU6RUgrWqjcLzsaIVnSc0JCgBEzkmxsyUKYaplL27xlz/d+4LoFNgm1PrwrQMaCvAoQazCgBDFjm+LLsaJaeh/DIzfwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002714; c=relaxed/simple;
	bh=RdfwN/LYtP4aF0CJvFVTs0hMjHmoDcKmx6pMoxp/CbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBuHKIxQzw/DHC6vBQBbwHb+yLXXhn6TS4O2pJGbZpuuaHm23ZMXnVdnhmbVzoc+0D7PJVBUGRkqOfrjhPb1r0M0IjXVERXgMF9Lm18ld40Ux4xMfNyzkEWmLMVc6646FKDlCoQe05CdqA55kdeaALmCH9lkOT2FuzVmvWNLs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7cPScKU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48909558b3aso60446185e9.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002709; x=1778607509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NpaDj1OSOuFZ6NR+/4KPE7w1qddaBejMbo1xZezZe4=;
        b=e7cPScKUBkIjLsM/wnRIfvWYqs44pZOOxqUuvbRA65u9KFl+rGl1w8meZd26yLs7yu
         Di63XnZ/qzQOAnFk+zydP4NHTk+sB5vuXPjm6yk71E0qX5wJvnuIAg4ZBZIfQN9UnUI/
         e+JDIOF47qUpPxWTEcOc5jURbcS8ZD+3JqjrReRWSivswH4nfoTmEb4jt2pQFmibfPq6
         c6DLgapoFsGv1PB/oBEueW9GkUKHJH+35DCiaoFYklkSUVMyye3Zo+qGD3iVvYButeOO
         pqpB2bwPzvObH/mV2oYk5hrp3kgDdoaAlmZIDNqb5HnlR+WbXePP8EyWyTTdNYTOpSyO
         6EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002709; x=1778607509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NpaDj1OSOuFZ6NR+/4KPE7w1qddaBejMbo1xZezZe4=;
        b=ogEoGWqVDISNo2NP7dZlR6JfsMP3HLFmCKLepgTcL4Bu7ttVRxSRuNr4ZFBL5GsKXH
         98g/yHDua89MlGB7meRIHMYII3SmrD8PRuAr0eXyqpHezBTXpK7DiX85j0Z5dVoYMMuI
         yL2fpuYXcTkpUiO+seRJ7h9b++mc87vq/MfXXusUc/Vzqj9Krmx6iKGOQ+iqoCjA40t0
         FRI4QIpaAhB+X9vvNsuThpkPoZ+gGYLQeHrFH4t2pGQ7OBj5kMDZ5deP8tmuM5xz8bix
         9rR+hjUbYAzLJJ1gbtnbJVZJmqwpL1juK2lkK4ltg6Gk97co5gdaG+CyVumjgRqgC9/9
         9o4w==
X-Forwarded-Encrypted: i=1; AFNElJ+R5XbrrwtP+lMWBQPXisX+Bu/cHBOos2auLnLfMNpN2tfE7vgwdnaamBOBrFoqGp0EQ7WVE6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEI3qjP/JfV2W9q0gYJVxsXV0IiILmKzqTkJUzQ/GsvtStCLzX
	3gjb9Q8sN22lDFyBTVay3F5XiS1gWPAm/6qqg8nfCw56OB37enLB2Ivl
X-Gm-Gg: AeBDietSyC+9x1xvCY531RLBiwiAHnnj34qIGM2IZfVkpAdAC5sPcGpPMr0ENMe3azj
	60ST3Wims1pPlhwx3pFwMbkDpe/0YXEYALPBuN8gAypbS4bfNsbwJOx8v9UJrCyi+y9OWtN6jYO
	IcO1jckL9Vl/R6qbGP+R7BX73FXT6bydKS66l5/CbG/C0LXmQZdVCyTagE9SpkDbO8bgWPEwxC4
	xWNiwggq+UfaSTz70wRvJ6lT9quyzC5/lhU41k0RYH+dfDmaWJb5mYVb5t/NWXg0TGCbhD3mjxP
	iLKsRkbI2tQbKmXDpZwSNATOhe7uB9e+eXvq0rf7fSwv+uTZrKO3i0JYA4STsavWUFi+iCkL5Fs
	LnQ513H632DBA0CbRB5OIYA4gcVo3Hx86tcqyToC8eBnShf90FUwsvjbLXQZ7IbBlznJ7Xskc7T
	YPNMyXfF6tOQHP46D7zhEiGXDqpQnCVnMShwDW1DhTIs0i4xm52DT22850P7pFap2lDIM/C0iFv
	MmvuacdUyfWDU9WsXG+rtNHadQS8eLFJG0+RmhPtpYk/eSIT6L2PnLuX9KauG/8QOP+rIbkEQoJ
	e0xlfQ==
X-Received: by 2002:a05:600c:8585:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-48e51e0b5c1mr3428345e9.6.1778002708617;
        Tue, 05 May 2026 10:38:28 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm655473875e9.9.2026.05.05.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:38:28 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie() and rtw_cfg80211_set_wpa_ie()
Date: Tue,  5 May 2026 19:38:18 +0200
Message-ID: <20260505173818.3674164-4-hossu.alexandru@gmail.com>
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
X-Rspamd-Queue-Id: 437954D23EF
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
	TAGGED_FROM(0.00)[bounces-244231-lists,stable=lfdr.de];
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

Three out-of-bounds read or write paths:

1. rtw_get_wps_ie() reads the IE length byte without a header bounds
   check.

   The loop only guards on cnt < in_len, so when the buffer ends with
   a single element_id byte and no length byte, in_ie[cnt + 1] is read
   one byte past the end of the buffer.  Add a check that at least
   two header bytes remain (cnt + 2 <= in_len) before reading
   in_ie[cnt + 1].

2. rtw_get_wps_ie() does not verify the declared IE payload fits within
   in_len.

   After reading the length byte, the loop does not verify that
   in_ie[cnt + 1] + 2 bytes are available starting at cnt.  A crafted
   length value can cause the subsequent memcmp and memcpy to read past
   the end of the buffer.  Add a check that the full IE (header plus
   payload) fits within in_len.

3. rtw_get_wps_ie() reads 4 bytes from the IE payload via memcmp
   without checking that pIE->length >= 4.

   For WLAN_EID_VENDOR_SPECIFIC, the code calls
   memcmp(&in_ie[cnt + 2], wps_oui, 4) without first verifying that
   the IE payload is at least 4 bytes long.  Add an in_ie[cnt + 1] >= 4
   guard before the comparison.

4. rtw_cfg80211_set_wpa_ie() can overflow the 256-byte supplicant_ie
   buffer.

   supplicant_ie is a 256-byte array in struct security_priv.  The WPA
   and WPA2 IE copy paths use memcpy(..., wpa_ielen + 2) where
   wpa_ielen is the raw IE length field (u8, 0-255).  When a local
   user supplies a connect request via nl80211 with a crafted WPA IE
   of length 255, wpa_ielen + 2 equals 257, overflowing the 256-byte
   buffer.  Add explicit bounds checks for both paths before memcpy.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v4:
  - Add two IE bounds checks in rtw_get_wps_ie(): break if fewer than two
    header bytes remain, and break if the declared payload extends past
    in_len; add in_ie[cnt + 1] >= 4 guard before the 4-byte WPS OUI memcmp
    (sashiko review of v3).

Changes in v3:
  - No code changes from v2.

Changes in v2:
  - Add explicit size checks in rtw_cfg80211_set_wpa_ie() before memcpy
    to prevent the 256-byte supplicant_ie buffer overflow.

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c    | 9 ++++++++-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 72b7f731dd47..d6d5f3a8db4c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -661,7 +661,14 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 	while (cnt < in_len) {
 		eid = in_ie[cnt];
 
-		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
+		if (cnt + 2 > in_len)
+			break;
+
+		if (in_ie[cnt + 1] + 2 > in_len - cnt)
+			break;
+
+		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (in_ie[cnt + 1] >= 4) &&
+		    (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
 			if (wps_ie)
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index fd3bae31b0ed..e7ba5ccfa03c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1445,6 +1445,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
 	if (pwpa && wpa_ielen > 0) {
+		if (wpa_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa_ie(pwpa, wpa_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
@@ -1454,6 +1458,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa2 = rtw_get_wpa2_ie(buf, &wpa2_ielen, ielen);
 	if (pwpa2 && wpa2_ielen > 0) {
+		if (wpa2_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
-- 
2.53.0


