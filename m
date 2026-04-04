Return-Path: <stable+bounces-233301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1Q9fOWyR0Wl7LQcAu9opvQ
	(envelope-from <stable+bounces-233301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 00:32:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E639CC25
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 00:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148EC300BCB6
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B23A1B4223;
	Sat,  4 Apr 2026 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAQs4R7q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8863212566
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775341928; cv=none; b=bIKr1IEcLJnFLi6qHIupWDrOEVYTgg2MVflptt459v/LXIUGXzVTzsDUdmqzerTdaWgoyYwfUTCeDt3zd3a+im8mwbMNv2VRngQcl0bibNmvN1FEPXBPjGcIw5kBOWotJJtmV65x2y3nenl3pKVKUYL4z60oMRcCiaJIE62uPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775341928; c=relaxed/simple;
	bh=ZFOY+U8fUTrYq9I+LJFqUKM/5/KC4WNw5rgtdpRO39E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgi8/oE+pbQp6XGUM8B5dpKL0MjiOLUMw7gqCcp9aKohNd9E2sVi6Vd9HfX4MUVSGXf6eWRzmC6c1H5ms9fjc8ardZKCPUHH0zd3louvdAd18WuIJoupcOEPWsnPgIIcAmvlXuupsPmjuUyfW5vNC8cuoIU8fYuGDeiQvQoAZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAQs4R7q; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-953a8eed138so1745117241.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775341925; x=1775946725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7M/wb5ZE+bi0m58cYsS3oHIi0wg7WyajZ80sRcwVHU=;
        b=qAQs4R7quS0wgfiJokbTC0jMq8Dwq199m6U0eFuTlmcyi2tQTXvPmX3Tq0XsA5yrrS
         buwQY02/dC97Nm5RkP1RAsvOVxRLaX/otbkNvjGQVh3aQLQmpE/q6K5gagZX15RU6+t0
         iAmuO/lxKf31EXtN/tBovD9qLtdQ1WxnozRBuhU7vXBwkGLwLvdMGMHHJ6oCVsERa20y
         uhT9QXkeXlyCfBBVWTkOJywcO/CmFBhNT9lJrANOPDzjKqPQn0VEvQQVJH86TiK3029i
         Y82ZXotqJmfRqEHso8yuXpYWzsVzW3O/C7Kllb6UFDgnitt3Tqn+jcIlhZOKd/TB3yOJ
         lN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775341925; x=1775946725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7M/wb5ZE+bi0m58cYsS3oHIi0wg7WyajZ80sRcwVHU=;
        b=q+SPQKFQ72BAMlJ/9z+RrprGkAdUF1kRn1Mm1hEMWCowl6hTnWRSZuiDn4VEMuAoGn
         ollHvC6JMIOd9OBqodyAJkp5bcVnaHrLOn/3fxChXmH1c9yy8ede6AIny+NQ4ECbsy8W
         WcE2/CZKKMOyE/E1YLQnspJjTvIFZaItWgeoRmudSwQQRqa/a545cYVbiUqiYQ2HpaSB
         IVvYm2KvxexCDKLuHLnhbxxxrY4HC6sS0RJCecYonxifyfSCk7iAehuysw9lWNK0L8A2
         vmZQ5q+iDpH3FccXiLzuAhZm3jU7hetgy+JYwDAG9d+uSg75Ma7svUn8D8eF6lXDzNs4
         Gqzg==
X-Forwarded-Encrypted: i=1; AJvYcCXnvNaCAfH2I3dHZ1rVJBQW9HrAN0sIS6We3tp5flkLNQoT0NwjR0xO7v+CxJA3Xcm5Ae9G/GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvBgko6+itC+tHr9P84Edj3oLidCOnipwugWOboT+zKzBgFUj
	kjKo/69Tb7zJFmhCPBKXXlbHL0RDn0tZnBiUV/3d5wHkWQBWgdbnDcN2
X-Gm-Gg: AeBDietGn4fVZcmawHwf9V+UwQitDyV0W94s3+gcG8vwp213DBtol7sCVS21fsO7vT7
	k+Sz+a4VOXsuYoKki/QtZ9EQIFQSWdS7Dd+n9TwPyQmoGa5IWn/uNDNyHczKdU2CBgL9cLLm09/
	bSyKVu4XUUnBWXeJYvLXBa2BE41jDX+g9VnzFNMbQEuJg3HRfz3sAxIl58EfQE8ercv8HHjfA79
	ObCWn8lriQ3d1REVuxRbt5prrTc6l1OdrAnbZ2+TCmmttYNl8p/NOW5AfUZraFEhnz0AnIoafL9
	wvmfppNVaiLJnoRRTJV4LJXAPVjckXIVsp/d7vuhqU2Xj4xe+9FonyurGY0Y+2WtzIm7T4fmpia
	/ka1QBbQPxkuiv02ku0S9JizvqcPGrNqjTcpHADv6IftE1dO8zCO+sCBL2SsYqWRIZvnaPP0Pn8
	7784WLXuSd+y1V4VC9aaprZN1SPyx3WT+X06cfPur6
X-Received: by 2002:a05:6102:801a:b0:600:106f:5fa8 with SMTP id ada2fe7eead31-605a4e0b2f6mr2965878137.15.1775341925479;
        Sat, 04 Apr 2026 15:32:05 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1d1edsm11631603137.1.2026.04.04.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 15:32:05 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix out-of-bounds reads in IE parsing functions
Date: Sat,  4 Apr 2026 23:31:44 +0100
Message-ID: <20260404223144.59168-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233301-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 318E639CC25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IE parsing loops in rtw_get_wapi_ie(), rtw_get_sec_ie(), and
rtw_get_wps_ie() check only that the element ID byte is within bounds
(cnt < in_len), but then immediately access the length byte at
in_ie[cnt+1] and data bytes at in_ie[cnt+2] and beyond without
verifying that these offsets are within the buffer.

A malicious access point can send beacon or probe response frames with
truncated Information Elements, triggering out-of-bounds reads on
kernel heap memory. No authentication is required.

Add two bounds checks to each function:
 - Ensure at least 2 bytes remain for the IE header (cnt + 1 < in_len)
 - Validate the full IE fits in the buffer before accessing its data
   (cnt + 2 + ie_len <= in_len)

Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 3e2b5e6b0..0c1138b90 100644
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
 		/* if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY) */
 		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY && (!memcmp(&in_ie[cnt+6], wapi_oui1, 4) ||
 					!memcmp(&in_ie[cnt+6], wapi_oui2, 4))) {
@@ -616,9 +619,12 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		authmode = in_ie[cnt];
 
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		if ((authmode == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt+2], &wpa_oui[0], 4))) {
 			if (wpa_ie)
 				memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt+1]+2);
@@ -662,9 +668,12 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 
 	cnt = 0;
 
-	while (cnt < in_len) {
+	while (cnt + 1 < in_len) {
 		eid = in_ie[cnt];
 
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt+2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
-- 
2.43.0


