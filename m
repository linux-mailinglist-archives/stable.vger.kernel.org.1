Return-Path: <stable+bounces-238398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHeKFRCj4Wn9vwAAu9opvQ
	(envelope-from <stable+bounces-238398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E953E4166D0
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C87A3018637
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77FD34F48E;
	Fri, 17 Apr 2026 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl8bgaR1"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE534FF45
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394987; cv=none; b=Q6V+zE4NnhKoXk5UZnrNORIDRZX6NBi7nHY9qzNMEx3xXCGjv2QHV7N/loibpMpUzk3a2+KU2tdFGSHn1hLXjDcnGXFBQlBQSnUYKLSw6AeqGqrCjHBQ2UEFCIfEkIDourfVjKnl7HaCHPjXC0x9rFfyQOCLxSJYbT4uifw0k7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394987; c=relaxed/simple;
	bh=tJMT7+DrVL8F21RA6G4NVXKLEUtt++LIxE74yyak3A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCfSBpuh2Zn3MyP0jHUuJUGG9h1HgTA2QJTsvQffQRJoQTvE8zu5PpsTuCK+hW64FqBDAml4GKkGhs0+7/cZRvu+2NNKrPIoj+cT1XyU83W1FLAFCHiYnThE8NmxYjvXiG34h5fYj7WH2KVeEJLA/fj7ynO1Sfs5/boYSRJn8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl8bgaR1; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso280648e0c.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 20:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776394982; x=1776999782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBxmxbvKHEUkAZ0NAG9KhKLPqXshWJk8Q9pRuQVQFJs=;
        b=gl8bgaR1nPVnFxjOjDaZIWXqdpoDyI9UCs6WYwmQusVQEgQFViA647Hsz6C0HfVJA5
         gxmRwrpHTr7pJu9x4UbWHfLhwoGw5hF4Ut/7Mz2cHWGSvwjQYqhe67ty0QwI2rzKYpl1
         7RByk7Yx6bs4Lavg4SBcubCplWtF5NRv4RhcY8074X6waMDvo4G66Ycrzogg4yVONHVu
         u2+h6WZjSoLwDoesbzaOwmo9f3wgHc5glHTqWbSHoevwrOKd+kdhFmusd82BqvgHmCd/
         X2yvdz2fOAX4JpiY/5R4TOTnUEwjT9HoIU/8M8cWQjxc3Zmhi9swemGj39BjqiHPJBtl
         6k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776394982; x=1776999782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBxmxbvKHEUkAZ0NAG9KhKLPqXshWJk8Q9pRuQVQFJs=;
        b=n0E/mjPSFIaq0r90Q1aoBrzzw7KKfYdq1nX4byT7FCv2Fv3xIGwSsZKwt9hVry4i2d
         n6fg2777iduge2R3KLq3DVUYDSmkA05HUhBPX2yZXVFX3EWIoIR074HNPH0v4M9KIzuc
         ymmXIzfIk+SJZ5o+CxlXruoiyknd/S+dR0t7TkZ2xfFCemUwcLfREyw9to2/7A5CP5SW
         BymGuvsvnw4eVvHStZAnqBfKP57Kv1jR9IGkvvOpeVxE86LRubjSPhlgYZC8R8Si9y+C
         SJgglBFoTx+3hnqTOqiEcUtisK4iQ94hRPrAUN22M5PfVwBjuCfVtN7feIJIc6O+iKxL
         66rg==
X-Forwarded-Encrypted: i=1; AFNElJ8O7Ky4U5S/VcTvNKG53QFd5YZKCB/LTHvrnzPgHne69bVGGDIWsni02Gj7YP1g/S7Mc1JcnEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7P6GRx8fnZd/UFaWBtgowVHZ/fj0STDlhl9quf3qrvAehXaQ
	zrErglPmmY6HWzk1ESnhrIo5ysY7N+6WGuSFNWUX877zkpgXeGs2q6cl
X-Gm-Gg: AeBDievB4g6mTMr3dFfDr2xVH3DI3BICJJypW1z6ITSV5uFLbAjOtyZIlNe+eNS1DIy
	UF0a6kvPhxOhpe2yhE2VQGFauY0vGWEoNRSPf7t8AP2eByGor+j1yRGi23W8WI7FitL+8WZUwKT
	BrKwWUKT28jceVXrvX9xTz0UjngspTmqaELzNqGKevoGiZ9Axv6sfueyFhKrq6iCGSNtYr8MUkA
	xIFploH9ZFqdtnOudEHwNlBau9cVH5Ia1LKSlfFbSAiKdiGuKW7QwLP7GeTxoZ8hH9bG26XFJW+
	lPbix+3pD6XgdiWCVPkRhW8ycgDCppU0F+Y8EaWsebGNlBM7bKQSo+YzLdRVipbKVErhv9iSUy0
	MBuTb8cfQ/UbTwPGvA/+vgtGmlMtqfKOX5rfYmQiGeAdQhyvfAWNWXRh3Tsy8WE1YCyz/wZ3l2A
	QizQg7uPAT9mCdVwdy6VRp02uBE01dX7cyAytqlOQQSevncB/x+P6z
X-Received: by 2002:a05:6122:c95:b0:56d:aa1f:e48a with SMTP id 71dfb90a1353d-56fa5a24eb7mr580372e0c.12.1776394982645;
        Thu, 16 Apr 2026 20:03:02 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93275f4sm131275e0c.13.2026.04.16.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:03:01 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v5 4/5] staging: rtl8723bs: fix out-of-bounds reads in IE parsing functions
Date: Fri, 17 Apr 2026 04:01:09 +0100
Message-ID: <20260417030110.42991-5-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417030110.42991-1-delenetchior1@gmail.com>
References: <20260417030110.42991-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238398-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,get_maintainer.pl:url]
X-Rspamd-Queue-Id: E953E4166D0
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
v5: add an inner bound check before each memcmp() so that the
    OUI read at offset 6 (WAPI) or offset 2 (WPA/WPS) stays
    inside the declared element (Dan Carpenter).
v4: add Fixes: tag and Cc: stable (Dan Carpenter).
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did
    not apply).

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


