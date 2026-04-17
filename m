Return-Path: <stable+bounces-238420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJeUEuzQ4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:19:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E25D417581
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3622F3112A1F
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD34936E497;
	Fri, 17 Apr 2026 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTZcv+lw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155336E48D
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406351; cv=none; b=cNUUn5MjOZN7j/PJo6awZxuPZiNi3ErogV1l12Uq4544kbdLnuoYtmDpKY35IKen56nF7Lobe29g67Dy+KdwlvC1alIuwRizH5oH5JahsE8vpMuR4BCYB3cySQsApyOYzHIiAb7Z2ZXWCKf2iks0fnxCn6mpY3CnlDqBqHnu4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406351; c=relaxed/simple;
	bh=383DPhuBRF2QD41DluR/ZrbwJ45uuKmVigIRiLoVWL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Odlr8b1AgFbFp/U60Vayy1SnE6Qt3xFzYdxvqlovk76Pv7hR2kdhhdKgH35i0qBC13DT/zPJL/ZJpT1nWbpCX/MNqW/E+66E7pS7gS1Echd7ZlRglzAwDhTUauaV7/N2rJsETBi2JNL3A21gu7BSPa8Acvi/uTrjDPjXjSl6ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTZcv+lw; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94dd01deb53so44704241.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776406349; x=1777011149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SwebIuwdOWzOTm6KMf4wXBgHNPaHunXqUFUotpGec4=;
        b=DTZcv+lwfi0a6pViIFroMHD6x3u2VAbsDPsxeUW4Dda2pOtCdh2WO95LkC3m+/cYA/
         /QqbxXcxUml3CztMm5gMtsQOt694NfDCq2ByhckeXvt2bjHmr7hDwjVR9dlnrCjnlElp
         1uO+6kaqh3LO+GluztVu+nzOiDut6sTX9AWaeOxMRXECVBhEy0o/EGa0BACTUkM+qXP2
         0Umqv/LLV1pg5BIrx/XFPzvCZ7GX8wtBLFjhZYFDED2AGHqhEQ0zcvaRi+vSWkODrPXi
         IL7mrhfwH/g1UHcRDW1tIslumaN5ZuZ+7Fotjc0PbwYU03Ez3h0cyFFz0LGnIiMdeHLv
         mgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406349; x=1777011149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SwebIuwdOWzOTm6KMf4wXBgHNPaHunXqUFUotpGec4=;
        b=DFJFK8qkRPhlJuUmjriYDYGdN0MFN/sVdE3Kl9WDRV8mS/AqZTDwLHSepb81nX/zmE
         s5LT7EvEAPjWTd7MGlCZlYEW4Pua4HlwfF50zZnNtSMxeQQzxQrswkYEj96oB+iVlW0B
         4D3O1jsVmFY1u9DPUi37KzTDlNeSlf2YmpE+hLQKunx8wDVKqlf25SpdmwwkFr/lMiZm
         qyk2JnF+lYpoWvp9dptKIXWKTEhNXhtsf1AbRIeUnGKa5A9eSMoe2gSlUI2lz+1WdZjA
         aU6Ob4TEyqxSB9laRSEJvG77WNJB7yrxVbf8UjjayQImvO8HinsSJxhFe5ZOD7tzaLhE
         z7yA==
X-Forwarded-Encrypted: i=1; AFNElJ8yJmKOEAT8k9sfsDSTzFrGZM1rgcTmOyuTRDrOqBQJx7+x7LJxHuUVaM2CGcWPFK7MKmey3xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjNZ0KAM0LJ1ZDIR6LFH8HcgqTNulq+fFYzYZipkv3eo/13vK
	KY+/lcqszcQjeP/ewrdSmYlUCF/SeagcsgoVhfUoAcLmcuVcgEc8q+J/
X-Gm-Gg: AeBDievl1koOc+tihmP/kVwlttpBBBvbe4gA9zA4ELLXsn+JS14I0HAWwq8ke/GcOgy
	X2SXetiWKuN4SnN5CT18n0WkmQgjjWo0AWURe5Z4y+zBAD37oaH3wUUBrNxmAh8t4yyywAXP+yi
	Pcyu+QHbrYEGNzKUxtYMz0UzrUNe2DkyQWnG5Wp3tH+QHl2Rr+d/Ng8DjxcolYLwRm0yM+RnD7b
	Gku0lO2Rv3899EUd8BCH/oiiLBRdkUjAAlVAPoKnE38OWBQ3bO6tUg6yONsg3chswS+6LvN+hZm
	fgAviDXcTw6Fsp9bRZpke+pspwVqcbbLSxosuP9J5bZoZ9iJOmS6S9KLEkDMXLiUntNvgCyQnaW
	mQ5Sf28aUNsP7ryHZ0xChZDWf5On7866VCWQsYEpHLmGtDqmhB+ODYDd+sSwDFZpasiw4Tbc08p
	y+90iprToue5fLG5lgh/1y5vZA0tqqceChEfnJWNp3iqlRPQLhueJN+e6tNT+E2Q4=
X-Received: by 2002:a05:6102:2ad3:b0:605:b96a:a0d4 with SMTP id ada2fe7eead31-616f8fdbdbdmr504002137.27.1776406349142;
        Thu, 16 Apr 2026 23:12:29 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589093a8bbsm297947241.3.2026.04.16.23.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:12:28 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v6 4/5] staging: rtl8723bs: fix out-of-bounds reads in IE parsing functions
Date: Fri, 17 Apr 2026 07:10:47 +0100
Message-ID: <20260417061048.62484-5-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417061048.62484-1-delenetchior1@gmail.com>
References: <20260417061048.62484-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238420-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,get_maintainer.pl:url]
X-Rspamd-Queue-Id: 9E25D417581
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtw_get_wapi_ie(), rtw_get_sec_ie() and rtw_get_wps_ie() walk a
buffer of Information Elements using the TLV length field without
first verifying that the length byte itself is inside the buffer,
and without verifying that the specific bytes dereferenced by the
subsequent memcmp() calls fit inside the declared element.

An attacker within WiFi radio range can exploit this by sending
crafted beacon or probe-response frames carrying truncated or
oversized IEs. No authentication is required.

Ensure the length byte is inside the buffer (cnt + 1 < in_len),
break out of the loop if the declared element length would read
past in_len, and before each memcmp() verify that the offsets it
touches are inside the buffer: cnt + 10 for the WAPI OUI compared
at offset 6, and cnt + 6 for the WPA/WPS OUIs compared at offset 2.

Found by reviewing bounds checks in IE walkers.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v6: unchanged.
v5: add an inner bound check before each memcmp() so that
    the OUI read at offset 6 (WAPI) or offset 2 (WPA/WPS)
    stays inside the declared element (Dan Carpenter).
v4: add Fixes: tag and Cc: stable (Dan Carpenter).
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and
    did not apply).

 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 70 +++++++++++++------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 72b7f731dd471..1b61879acb48e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -582,18 +582,25 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		authmode = in_ie[cnt];
 
-		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
-		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
-		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
-			if (wapi_ie)
-				memcpy(wapi_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
+		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY) {
+			if (cnt + 10 > in_len)
+				break;
 
-			if (wapi_len)
-				*wapi_len = in_ie[cnt + 1] + 2;
+			if (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
+			    !memcmp(&in_ie[cnt + 6], wapi_oui2, 4)) {
+				if (wapi_ie)
+					memcpy(wapi_ie, &in_ie[cnt],
+					       in_ie[cnt + 1] + 2);
 
+				if (wapi_len)
+					*wapi_len = in_ie[cnt + 1] + 2;
+			}
 		}
 
 		cnt += in_ie[cnt + 1] + 2;   /* get next */
@@ -615,15 +622,23 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		authmode = in_ie[cnt];
 
-		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) &&
-		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
-			if (wpa_ie)
-				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
+		if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
+			if (cnt + 6 > in_len)
+				break;
+
+			if (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4)) {
+				if (wpa_ie)
+					memcpy(wpa_ie, &in_ie[cnt],
+					       in_ie[cnt + 1] + 2);
 
-			*wpa_len = in_ie[cnt + 1] + 2;
+				*wpa_len = in_ie[cnt + 1] + 2;
+			}
 		} else if (authmode == WLAN_EID_RSN) {
 			if (rsn_ie)
 				memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
@@ -658,21 +673,30 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 
 	cnt = 0;
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		eid = in_ie[cnt];
 
-		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
-			wpsie_ptr = &in_ie[cnt];
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
 
-			if (wps_ie)
-				memcpy(wps_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
+		if (eid == WLAN_EID_VENDOR_SPECIFIC) {
+			if (cnt + 6 > in_len)
+				break;
 
-			if (wps_ielen)
-				*wps_ielen = in_ie[cnt + 1] + 2;
+			if (!memcmp(&in_ie[cnt + 2], wps_oui, 4)) {
+				wpsie_ptr = &in_ie[cnt];
 
-			cnt += in_ie[cnt + 1] + 2;
+				if (wps_ie)
+					memcpy(wps_ie, &in_ie[cnt],
+					       in_ie[cnt + 1] + 2);
 
-			break;
+				if (wps_ielen)
+					*wps_ielen = in_ie[cnt + 1] + 2;
+
+				cnt += in_ie[cnt + 1] + 2;
+
+				break;
+			}
 		}
 		cnt += in_ie[cnt + 1] + 2; /* goto next */
 	}
-- 
2.43.0


