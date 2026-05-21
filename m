Return-Path: <stable+bounces-253546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHyEMKQFD2qDEQYAu9opvQ
	(envelope-from <stable+bounces-253546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:16:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6375A5850
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A30830781A9
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C0D3CBE75;
	Thu, 21 May 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TysuVCp1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF63CF967
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368647; cv=none; b=fbQCIRU876Ih2w7nN++Xl9rNi8iO6asgUEQMBL548x7YjLyaQtycQrGV6S7PXcPUvDsgTNXGfMB/HxWC+di/2HvsYirEDC0DwtE9ZBxieTL12yHcWbxr8WDTRolDmWwxtd2obsJhzrUfRuE8jFEuwNXYRt8g7m5zK92Js4g36CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368647; c=relaxed/simple;
	bh=yUxFQRX3bCKLw0bbag7Nni+E3AhTdqJzZfswOngAcC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTC0Rfq+/IuxARM8rGk0VLGycLYtnZBc1qLjBXPRzykUxnrO3auYX0shpIeZNDDBtUo5mOJz+ikrVHBxWYuyad0z/CVVU+/Dvj2IMPZtE6djz25kIlO8/rKA4m2hYhiNsagTTPlQ2i6J93C13GmXDXNv7kPdDr36KOb7Oxl7cSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TysuVCp1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bcd0111ea98so903017366b.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368644; x=1779973444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB1lAvDGjs+DHw89Q6x35AxewQHrMJlNyOlZUD/w82c=;
        b=TysuVCp1i6orJQj7gdpzj03NygH+MHr2tf8BoYL3/UNIGXT5XLXDEW433xor3bML08
         OMvgGPwO9itm/WYDES2CYmVRH7O9slo2tFwiMmTuAyb80zjk8offT4NR3yhMTgX5nRcx
         AZy8JmShRt9hTXM7skwYSsRlGY8M6e++E0VWBJbpgGDBT8NqV02vfnr09+0cBpFIVzSO
         A5m05yClae75qA5xta+NI/mHE8OOqeNW2mDqnquZFYTPKMXedUm8PrFxPmCPXyRAjVAA
         yy47AC/7Hs9DwdnPqBGNXAqKyrx5d9oOuv1M8JmOUy+wY+xfpk51oJVaMP8IkGkH3sd1
         fwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368644; x=1779973444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GB1lAvDGjs+DHw89Q6x35AxewQHrMJlNyOlZUD/w82c=;
        b=ZDLWGyx0Wyrmj2zVe2VvL77fSGDgo6QGvVA9Jqu1KFdSHsLU1Vf03BbHXLqjgzdCjM
         r4r8+1moT6bWLeb2eBnFy01wRk9+RQrQkOV8DCjxF+X9NZehvSJxg01i5x2HtUw8fOMo
         T8Z5B9Wk7LLbWHjBWiW8GpSxPhJ134iK3GbkAxzB3dnjem4CK2NtKoE9ihOipmkTjked
         wyQxmGuRmgBcDtwq81kv8vRJNbsjV1dpU9OsR3KTqJh1rXQv8wO3WZucXPXgf8R6h6A8
         AiTjYVEThgnzRr1NrG+8ZUaZyb3ofl5tVEl6HQ3OAxmojKvynWJ9jd3u0ygEutNTYxqh
         /mGg==
X-Forwarded-Encrypted: i=1; AFNElJ8sWA0rr8YQQWW2+4hbzwDCyqBdsCmhyg+fgfnXnDMhEcwQFnoGjilTGxPg1tAJsSZQkMeiT5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZWx8ZO0NKsG7C1dqPnf+L3BXIHJCxsg1mx/jwnKBVjSjUUD6
	mxdW0WlDV5SQwDdsM2kqmXJlL9Jz5goi+RaMBV1mmi0XAR/xOQJpB1BT
X-Gm-Gg: Acq92OFJyGLcAi8qKKztv7ryca0vg7gcbRlZRkjdz7LM7f1YjgplB3zwUETdetlWDOb
	NL7G+Cex6HoDcggnGJ8KbeWZEcGqDXI3339UqxnDn8/2Y7yS1aPwE8A2C2VQhoN+wDtaNIJKdeg
	u2hS/2RFzLwcdtXp68BTTgSYkL7Hv6226UXcLPhJdXLpbXYnP25oCGDYmVFgOfaL+6yyeVM//oI
	tBQw5dgoAJX1SbPtPzbKdThnQ5WM0z2HS6FlrSHxKCx5sbTaMu87z8SAzcknACKphs+CiKVqCdz
	O7M9JGp2/co0/98bYimaIbzUtuJur9Z33xi1OdVLEePAFwVN/V6vdrIG7rik/szCqYWERqwTMEz
	wLP9264cLv6jpwYZDdynLwBUFhct5L9YF6nODSUkT1xWH8nh8BJa8NNqO70R27u9zqZ8Xmmljof
	aC+LIA4kUT/VBVIjH3Llim3kFejlKYQzRn05gj0fr74Cc12MKYiRJncfRBnu4aGLCEtVXkOMXCk
	56XE29sgT6v5CytUCdjyvKWjNiiMcl03kYmo3gTLiJGXc1xrASGMdxftNwQAEcOCy9BLBb3oA6F
	Eh/qkt5Zx9GXQ+iV+6sLKanyahtWSvnlpY6CrDM=
X-Received: by 2002:a17:907:972a:b0:bda:2929:6f07 with SMTP id a640c23a62f3a-bdc188f45damr166539366b.45.1779368643600;
        Thu, 21 May 2026 06:04:03 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm43766266b.37.2026.05.21.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:04:03 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH v6 3/7] staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()
Date: Thu, 21 May 2026 15:03:26 +0200
Message-ID: <20260521130330.754181-4-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130330.754181-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253546-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 6C6375A5850
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.54.0


