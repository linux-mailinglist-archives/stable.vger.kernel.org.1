Return-Path: <stable+bounces-241264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGRgDWcc72lk6wAAu9opvQ
	(envelope-from <stable+bounces-241264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183446EF74
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62E29303E2D4
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD37399031;
	Mon, 27 Apr 2026 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiWf0YJi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561F39A07E
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277920; cv=none; b=Jyq9RsYDyg6uZj7n7s4y3b8y5bpAC5LwuJn4Y+aReNPfqf3rijTzFjYnWFnOZReI7KGjAnaXaxWfKYbT654qB0Z1qtrHmwdYQRhtPzMZsMoTUWAe5ZWrnBOSJc3tMOposK0m4jPPMVledhAAtw/zj96oNCVMz0gIvvY0AdJEdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277920; c=relaxed/simple;
	bh=QsWgV/TRc8h5FUj2uOm4q4TApmuKuKTXIme2FfHuqZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms4uZDDVEiYkg1M0t9TQ840HKaFue8UgivbkAXiYpfMTmoM2TplZkVZNXfVfXP9EDrLxbnALE3m6podJB9gQk+7Ty4kQgoTeV11UOEj7iRYndq2MwZt8ysIPnxqLhjsGL/rp/iII5621DEJowuHXDQusKCGirYE3xrmj+OwmZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiWf0YJi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so58595595e9.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777277917; x=1777882717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVlRFyF005cdj3KbEszpkmE7tTQiTu1k1/BY4S0J3Oo=;
        b=BiWf0YJiQhOBp3HBblmFm5xmdTKRLB2cWo4h/5ehzjk4YWCdanQsNeUtfGOW0aHEBL
         FkqFO7B9UqTCoBi4oNTpwo6s3how0BoVno6StGolSEAMz2qxh17ui0+xRt6gJxfjDEie
         QfbtFZrqjSCziMkeAsMIrMAUX6H3a2/uUfh/toowOH6wQX7zAUTg2p/prRiyInde6aH3
         FUfW8Inzx+BJxqPOcr5XdCiVkm+Hib57i+fSWVWCjwqno/SAYzLsrANlPv3yrzFxIuLL
         Z2kS/8bUk+NrEqULF0HplNp6vEgQacqkTDWCDVEmimMROsX2gItrkWLB/Y5YhsMK3U/M
         kYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277917; x=1777882717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVlRFyF005cdj3KbEszpkmE7tTQiTu1k1/BY4S0J3Oo=;
        b=m5FT6lokzEklo/H+sfjYDPkcewWLXVr2FKtnozwYro7MOu6S+NdrEInuQ/1zFlSP4a
         E0DnAIZVPjPXjV8taZxvD2t1wFMgby19z3BfU0xgbaU3V1s/ntMT+rBvHiMuCw3d72GU
         fFohJXuJVcJTvMTEKIMJQkXbl98oMHvxTDx7Jg9CfIkavOr2MNxcooBvVTTB8/2TeRvg
         oBoRmCsOUOAWBgLxPuULHD5IPpCjSMB6DpSXCeNTnyZtWMOueJUWHN++vmkf0Y3NTrS8
         YF7Rv5z9Enis5v9dcYQD382hUIeYaby5Tlt1UsNvj1QSqSgvajG18NvqxXSo/n9kZ9kI
         S1VQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WdlEQKfWDh4yJT1s54Hu95VSOyXilA/CxzgtAX8ZlbRWwjIIrVFDYwJIDMKDNfWNnAXvnl04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5BcjMkVGFO0zo8Pa6W4Mo8mNT7NDaRZ4j9mY/KI3cQZHZPpa
	UqQQjA0/zszlyt3mA6ShvM7I8M1W4GC20Wakhr+qtjdsatVHGzuBVtRP
X-Gm-Gg: AeBDieu6EU1NCmNimA3YmqYzx+vLav30JPOGwFiLptlpjdz4fUygYzFZFhSaaNmcf6X
	zW9NhvrSqQ5I3BkVvGJ+v9Fld3up6lYWRh8OZdBJFunCWfzzlaysjzOiHt+vq48Ecom4xQCayZg
	3fN0XeMa16mKK10yu8vMOP0EHhXN599J0ajMdT2wgvf78fRVZzIBbaI/ObPyvgs31y1olnAgFgo
	BR5zu0+y6pAqYlNI5iwAv7IKc/JuFgUmjF0TjHAnbgxcLETR2o2mZiwWJbcgrhFMNQ46YIEYlbb
	7+RvrdL58Mp9j11+T52ckCSyK3zox80s4TyHcrzGF0M/XEJFhRrP3ZfXOThvPEoelLR1S7THTr1
	cZSxkcKS60eAenvk3/xbkbzZFqRYDjeb2aNwCzb8vi/FYEBPKQuTNx5c75tIHjGpWNZGXMMxAzS
	M2BxndUIdYvIHsUzI4+2FlD7A3wR2DSfBLnyksc1gn2sMy/4GhjVRIQ4WbVV7sGDYtBVbxsfScd
	IEG9UPNUlRB3hiUKgamjn5pS3CObIMAfm4bV0jFxPfVJEH3bygCx3iNu3c3Xq3uL+7vFfs=
X-Received: by 2002:a05:600c:548a:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48a75b9b0c5mr734945e9.29.1777277917225;
        Mon, 27 Apr 2026 01:18:37 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14a61asm712652115e9.15.2026.04.27.01.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 01:18:36 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()
Date: Mon, 27 Apr 2026 10:16:26 +0200
Message-ID: <20260427081626.3393697-4-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427081626.3393697-1-hossu.alexandru@gmail.com>
References: <20260427081626.3393697-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8183446EF74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241264-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]

supplicant_ie is a 256-byte array in struct security_priv. The WPA and
WPA2 IE copy paths use:

    memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen + 2);

where wpa_ielen is the raw IE length field (u8, 0-255). When a local user
supplies a connect request via nl80211 with a crafted WPA IE of length 255,
wpa_ielen + 2 equals 257, overflowing the 256-byte buffer by one byte into
the adjacent last_mic_err_time field.

rtw_parse_wpa_ie() does not prevent this: its length consistency check
compares *(wpa_ie+1) against (u8)(wpa_ie_len-2), which is (u8)(255) == 255
when wpa_ie_len = 257, so the check passes silently.

Add explicit bounds checks for both the WPA and WPA2 paths before the
memcpy, rejecting any IE whose total size (wpa_ielen + 2) exceeds the
supplicant_ie buffer.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 098456e97c96..3d930d9af184 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1443,6 +1443,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
 	if (pwpa && wpa_ielen > 0) {
+		if (wpa_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa_ie(pwpa, wpa_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
@@ -1452,6 +1456,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
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


