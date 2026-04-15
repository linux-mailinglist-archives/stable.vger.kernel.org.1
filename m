Return-Path: <stable+bounces-238195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODrwEHzg32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:01:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE86407409
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2868431561DA
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2034DCE3;
	Wed, 15 Apr 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWgkmywJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4033264C0
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279356; cv=none; b=Sqh0yt0gBJS15Ij3TnpXVIhCaO4Bi1U3lP+luN26Pzhjep33Mi0uBqQ9/eiq8CE9loQ8+7+kOv+SoUyRebJZXgNnENXSG16JgOvH2fZJmpSIOPTqcoCCuSyfvLtP14eEw/FiXN5WwLMfgK5m78vhfqTvY0jNUs3+icEboGxZaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279356; c=relaxed/simple;
	bh=4reUDLZlj/PYeJKnXw0RmQ0kJhkc5fPrtbvWTnUv6GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6PuVkdN2w5qs60wNTIaTsqYeWnlXg17agL04mHjy6xPGaoT/9lGjMIwS9ImDnbQVJESzFxDq6C9NUGY8JGWd1EpMHtf0rId6wmYm/KmshXK1BoEDGjlRinCdPU1/+OK9b3QnteK/7BdlLpYenKXKM5pjv4zae5wQjZig89+ybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWgkmywJ; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a857578a8so2823114e0c.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279353; x=1776884153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2swcOybNQxoOTEXoSldGalBD6IDZJiaiZhIwmr4O4s=;
        b=qWgkmywJmqGG+LnJwWRfu5+muqT0KleNzTmhKphKXxA5yXx0ROuoi2WAkBVG5GSHbI
         L1gR+UpdwBE7l6zYWle3umxs9AynvmUe6ab41TDH2mE6W9n/vdkTTuMlI92QowP++xTj
         MXiVpLYNvr1vwNIUabHfsMInpUypS0QM47MUmPBqHa+OqWxrXrOFgXnhSx70GA1yU5Hb
         cO3h0dJFE7ad+z+WJC4qla0ofdkOnPpgwr9sy2oQHwgCXFY0575jwty3yxw1OxV//lF4
         9I8KMXX0C4RFczQbSXtDYAQIAWS94ar/wAcwQ75EV5XjblxFbB8K1XxCcBYvvJcFdbV1
         PFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279353; x=1776884153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V2swcOybNQxoOTEXoSldGalBD6IDZJiaiZhIwmr4O4s=;
        b=sLAhc3wdrs8ieYoAZJOMqIRN/O7zx0R5NRbZ3eEuu+unpQTomiLwb5/QzViueDvxKP
         dgTZHb/WwrYWb2teRI5PKkT1bcZoh6tDuJesDeMnAbsIjq774jFg3vebMoM79tLSWG7E
         kDLrLA7h+Y+3iFcZ7KJJgc3/a8L5fZOX8wttrspgx2x667aD0i3tBTnNaf9QQpHLvLt9
         RmykEuhhLnSbMLaC59L46z7mLrKB0tCJtqAMo9CQWgQ3AuQGe/c9iHiPb4hNRSiKcuaV
         FHbV8gXNJN6STFG5VqSiD6z4BEjGBs6J3lrBGfQTHSXj9QltjHap4Kdiwi3Z2UqdY07G
         MglA==
X-Forwarded-Encrypted: i=1; AFNElJ8/C35QYALqMQ8V7yOy5kztVi4ISv8qjMr0tNlc4jihxI/vd/swY3RQepr+nrSDIeea3c8YgT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7moq8HOauvOhVi+wwKm1pLL+EkHR/8DQcTjCJ2WBFv0mS6zZa
	F0Zv7f5zbVI6TqOLFOy2p6WOW5+Cq3XhaEKLVdZjnKh1c6X9X9LrK0DXIqljY+eQEhlKCQ==
X-Gm-Gg: AeBDies9psw9EZ8UJqEplS5BS9R5ku5arp8kJ/whajtwKJsjQikdb03KxPX/u2thR2j
	hLSutjyIEvV8gpAfIfz3AAOnAGERExuugcbHK69j6+qH5i2uZ0SOWShVxKN7pf0XfjGw0tqe3Sx
	fO6WVKD/RtTcx+Y4fObUZaX7MKoPMKWaljSMTVChH1cudfAY6KS8G67nZlcTTULBsc8OxiaXubr
	DnPCqysR5YWhP77OCl052o6lO7QeDlng5cD9+lOYNBlhzi6P64fBAtdv7z4nDcsudtnMwPIGqPZ
	E3DhqHbYv85vFieJ9Y/54YXMzEfxSlN6DA2eUKoXCDynbyW42oc4yrD5Y4IsTs3I94rMHWbAz45
	GqxglRFGijbYjjSRlb2sMG/lnjY9NbzCVc9lBPmjT2Y65Ie5LMq+tS5D9ZsnNcdQUfoNMXLJqx4
	JEaiuHe812pIdWU3F0YUHWY9rONotXWS87xyjLByK0ROFOSULBaiyy
X-Received: by 2002:a05:6122:1d4c:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-56f3bb66d4cmr10771333e0c.4.1776279353283;
        Wed, 15 Apr 2026 11:55:53 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89feb56esm1647484e0c.15.2026.04.15.11.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:55:52 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v4 4/5] staging: rtl8723bs: fix out-of-bounds reads in IE parsing functions
Date: Wed, 15 Apr 2026 19:55:00 +0100
Message-ID: <20260415185501.440492-5-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415185501.440492-1-delenetchior1@gmail.com>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238195-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,get_maintainer.pl:url,linux.dev:email]
X-Rspamd-Queue-Id: ACE86407409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtw_get_wapi_ie(), rtw_get_sec_ie() and rtw_get_wps_ie() walk a
buffer of Information Elements using the TLV length field without
first verifying that the length byte itself is inside the buffer,
and without verifying that the element's declared length fits
inside the remaining buffer. Both conditions can be reached with
crafted input, causing reads past the end of the buffer.

An attacker within WiFi radio range can exploit this by sending
crafted beacon or probe-response frames carrying truncated or
oversized IEs. No authentication is required.

Ensure the length byte is inside the buffer (cnt + 1 < in_len)
and break out of the loop if the declared element length would
read past in_len.

Found by reviewing bounds checks in IE walkers.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry Luka Gejak's
    Reviewed-by.
v3: rebased on staging-next; sent as numbered series with proper
    Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
    apply).

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 72b7f731dd471..e0fed3f42de0c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -582,9 +582,12 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		authmode = in_ie[cnt];
 
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY &&
 		    (!memcmp(&in_ie[cnt + 6], wapi_oui1, 4) ||
 		     !memcmp(&in_ie[cnt + 6], wapi_oui2, 4))) {
@@ -615,9 +618,12 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		authmode = in_ie[cnt];
 
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) &&
 		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 			if (wpa_ie)
@@ -658,9 +664,12 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 
 	cnt = 0;
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		eid = in_ie[cnt];
 
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
-- 
2.43.0


