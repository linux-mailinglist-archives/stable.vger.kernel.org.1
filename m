Return-Path: <stable+bounces-253659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ga7NaKnD2rCOQYAu9opvQ
	(envelope-from <stable+bounces-253659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:47:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F55AD8C1
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 455A0304B8BC
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1656265606;
	Fri, 22 May 2026 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAVaMJwW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D9298CAB
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410779; cv=none; b=axuJuccnmdrSNzdvhTfNGMV9LFT1ydmIIcQ590s+m4+fReSFPsGaRPxJKnrl4cTyMJSzYyLs8F03uNnKmbc5GBm85OXcQi4weZBkLyEl8Tm2ViEfL2v4aoEb3eVMsMAHKlmAx2qHJDsER09pCWiym0K6ukESXhL/GSQdXUjbkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410779; c=relaxed/simple;
	bh=yUxFQRX3bCKLw0bbag7Nni+E3AhTdqJzZfswOngAcC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS9Y30xMCAJxIhxneYBLIf7D6/j+HPSvH3HFylVerIzTepcFu9DaNIEqb6vhb5/0kjGbtxkUC/sZNzIVD97UhLBeeg9MlVKZVMRikZ+jv3lOFhgcBKwr5tiwjx08Cdw3pX4yEB4+anOWAVFaPQV0QfEKHl8ZS2oZUy/e7PxhDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAVaMJwW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so11379440a12.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410776; x=1780015576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB1lAvDGjs+DHw89Q6x35AxewQHrMJlNyOlZUD/w82c=;
        b=SAVaMJwWIS8c3oAkYVxzI2s1pqIWQ1YN+i5zE8qwfoENQm6wVx7hXmKU4NBHtKnG3I
         pFeaYs2Lf2oK/GyImwo1pTsn+lF9SOYUMugu+NfZF0wuUSG1m2LxwEYbAXaPLfdMDL+z
         moSQ3RXTRExIB1/GiuOyKm7qmL7L64+Q2iYyrBT9q+LXXdAFcSOJqnTP/6MlSwRiLThr
         l//PfUoraWOQJw4kK7a+jfCm3/78fW8gTBhZfdpCxXii6VfMfSVYGqBzu6XRciVv09dT
         FFNLecoKsaOD6IHtvZVN/pAtF5Q5LNyC9KKKAvtvKYnWdn5zyS95W55BoeFJdFQ7mryA
         YFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410776; x=1780015576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GB1lAvDGjs+DHw89Q6x35AxewQHrMJlNyOlZUD/w82c=;
        b=fzliA80BkIo1pzWDJV2wWeniEUQaEpAEji6qo+GUT5+oHCu4pbPumxxWA9T7AuM0Q0
         jjYuvQLn3f+scng/L47Hib2icx84+pJYD4eBt1O/Uwear/AI/lB8j1g7S/WvYhbPGJdz
         EZuTthAIUx+GlT2rij0rQ7jW8tyAy08vqXME+EikRq7KHHZ64rGbKkcRa9oHkuV+n2Tb
         nZzkTQbhjtJXrFEa1YBE/dVclUlZXyw8JyeFtPJ3zpT10KG6t2nhcEZYI1JzhZjsmx5D
         xTK0m7qDjBBq8ABZfzlo2CzfgH1Vk3Qa2PGcVa26zWYP7cFd8B7sgkMrTKEaYrdSc5i4
         bCiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8vWAhKM5m5Nm4+dwlX0YdNJoPRxTJtYayt1HkApxzm59JnDml2P4fuL4gBe8TaIIskEGCIY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHa6nCdGM/UjUTvw/a8VpEr4Qik5zkjt4fbWDJWSWgN2YWAKos
	Ex4EQhMNlH361b1aUJ22tCIAKEUNwcEBNu/xx4ufB0U8rVngcDAexo3q
X-Gm-Gg: Acq92OG/sO+DVPifbvMuronEC1CKgy1y8349c0obt56Wuthe9kteTjo8+KzgUEsxCNr
	3mW9lKbtkyCiie5/Xwk5n9YG9cxVDWHwC+w5g+0BGnw3zhfFC2lyX8uFTiUCmgDuCSU8gBm8/SH
	A8awas4Cm/0tE3siuqYWDGvdYAsvD0xM42ap1a0BOm18niX9TeX5aRES+WZ5zh35MSEVvT8HM18
	GBGtQT7LRh1tJjUElCasGxdLD8IRmcBWQCW2RIglUySJS54i7eqpx7X2t5Xh5M9mEaWaPamsBTz
	wOP5rXMFFpSWqhpYz5mI6yzrptt9ANdZ2jfNPe2MapECONL6x2oJmpBazXLH1pzfhG92styYbza
	6V6WoYpQ6ywyqbp1PjRnbjJbxJTRg9Cne58omGGdFxKLkTB59QnXN+T7Wth8d+7ckxoJGZdEbh9
	I39ku/wFquuzqsBdBQQwyLPbQ2oe7KDniMiX61Xr90DWxovNmRyoJlx0PMxY7pKFT+9a81mnrnO
	+bazyNUQI8irg1JKfz9OpAZZm6czOwgq3ciZm+nW27NPyW6maHLLJc+Ez6abJ13v3S95CTKxf3J
	WGbIs38Mju/OcEDGvTGWOEYuqHeG
X-Received: by 2002:a50:ee08:0:b0:671:9dec:ba3 with SMTP id 4fb4d7f45d1cf-6882efedec4mr1462732a12.13.1779410775672;
        Thu, 21 May 2026 17:46:15 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b72cbbf3sm3535a12.0.2026.05.21.17.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:46:13 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 3/7] staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()
Date: Fri, 22 May 2026 02:45:27 +0200
Message-ID: <20260522004531.1038924-4-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522004531.1038924-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
 <20260522004531.1038924-1-hossu.alexandru@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253659-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 6B5F55AD8C1
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


