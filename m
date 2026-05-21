Return-Path: <stable+bounces-253542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH+yBW8OD2p7EgYAu9opvQ
	(envelope-from <stable+bounces-253542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:53:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7435A66D7
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E8C63076082
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BBE3CB8E6;
	Thu, 21 May 2026 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCkcxvd4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E53C76AF
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368640; cv=none; b=buOQrPdC5QRVoFIexjBzP4WAeVp3VrHlcaGl1vcOfbGfQVxI7OJ/DOOxbC8NNLL0YJiKS4v4Yyfw59mYfhVLciHbiggawu2w5k867QEwur57fq2wxW1hcJmmSFhYINYyTCnFu/Y8wMQ5+xeEmUOwUJ+0A+SbanzBDAW9d6MPBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368640; c=relaxed/simple;
	bh=6LgPQvpg4uWi2+g0oRu5FfUq5FLkAdJRzagqIsJygBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFoahvFBv0M9JtwO/sb5HQd2iiWjKCIYbkkFBlvVIyf5UtvQrEeUPmjcEpFeZTPUIBo7K8Zg/z72vDpFUXFGcXL83OqpkG61sfym//YHcuGQaz/2Icx8O23bDNS+y0xBMkAX4MTfJSJlGcjn4pffKWCmqTHAOl/iRvcElBziKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCkcxvd4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bcd0111ea98so902996166b.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368637; x=1779973437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCJ+miUX9szQ9qxrJpRnPrac8eYUQHkd+CfCVdwfbkQ=;
        b=nCkcxvd4eqTR5ZDVYn+AJTSZwNLyONflM+RR+gqWH/LtOHFjHq43c0CVA0aiMzh/bE
         cIG84VzqSfOvEdvxNtc9j9gXq5G8RtiLsTiZTm07eMP44GlG3h6d6niWcCEC/uvtWzyj
         B8zfJwI52X2828STaG3zPDrOK75HQOy6XRsAi6Bxk6BduvrkQ6F6+a56zCeU9viMmx1L
         vM5v6+VpjJVGdk2Q0mRiDZcR7k0I5IvLyRmJeOiE1ua/F9Q9SGD6gwTm4btjUXPMdTj8
         tZrdK7L3gHnc/yrJ4+Q/c0/PiGwqugjENAn59G1OxbyXVCCfvcCZLq0DrgKAPF+iKo1l
         lEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368637; x=1779973437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCJ+miUX9szQ9qxrJpRnPrac8eYUQHkd+CfCVdwfbkQ=;
        b=DWJZJK2kF1uwPhLHTW07RIJ8iK2Rz5gVj0AXKYd3uz+8eKYpOKs40CKYDaT0v94VMi
         MsZK1bzGsYt8BVO2DSTiTmN134jSmlz3okVJIj5xh57P+i2O4EIFCRrluMqJDalPskwZ
         GcxpCoDPeSeACRVqE9vObkxtscWB9K7dsIPCPFrvy/FPPh/uoH6puAjSF2+UXUXBVKnJ
         grBpfIhmfTUC+bQBx60veBU4wkmyrhNcsFgQnvAbLLF6WHckHYWOi7GmXp0PJjFwP0FE
         uOw+/aZ7TjT6qNanHkwblXX3zluJvzIkPpm51fKcdgTVvQVravImpf4ZkH3B0wcYi0E8
         TGDA==
X-Forwarded-Encrypted: i=1; AFNElJ/2iWyw3jXzZsWNSWz/pVXmfERsIVS271Mnq4DNSeHTftoZAePmk4kmKnYGzB1fGKduE7SrN2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRq+JYwwxtVniAYxUTb5kijhvw5uegv13V2zxwqNIIVjKs8XIZ
	yk5N3DuzN3VYE1qZi+1gW4QdyF1uEs3jo1DmA5Aan/DZR53CjvWTKlR0
X-Gm-Gg: Acq92OGUg8oX6Dkvb8o9FQEdmPDC1FCsngRXOU+klOU+yVlFj0cmkOorAiEgkR0icWz
	jRJeu8SsEFW/zG0pst7xpyVebtgnpuhZNrNx64JFBEDgQ/kXV1cWzHox2vj27rS6bqvv6fL/pdK
	X1HD3YSQwH+C1n6bNGIvM27o24mn01P1SRiZM1HkdVU8wtA9z7q5F/iRanaHNSu6BEu6vIs91Iq
	0yMnQtQik5fDkSmzxBa0Kl92T6gD1M9MNHR38xRNremkehMua7aoMwUonaqrsgt6gTLpyEkvLu5
	ljmkIzUnkWCRxvoKVh1WHJ1YHwvRqT/1r5pQCjrje1qRW/mOIyUBvtmxuq2+qQoI0b6jik4bfp/
	XYlzCkjm2f9MpJI0IODU1Kbl0gJi1AZKpGmc//5zyLcoyTRBPet2rbGsgNNWBke7KzEgZxAfvu7
	CTMtiSK+cI6YuEaBpZaqfSWxz/E/FO9FTnxoTIV/UCir5b/7tlcSUGhklANp2pxAJ1gRHuCCZIy
	YVed30xLWe+nU6/YdT8m0NcEp3l9gT8KmjEVtMjxLJTyibMVkPl0iTRV+WCypVIV0lMEnoTnb3F
	cWtVooSoMD1jl5KkCSDuqC0sS6wm
X-Received: by 2002:a17:907:d01:b0:bd8:26e5:d79b with SMTP id a640c23a62f3a-bdc188f291amr147500566b.43.1779368635329;
        Thu, 21 May 2026 06:03:55 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8aa05cffsm42042766b.50.2026.05.21.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:03:54 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v9] staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()
Date: Thu, 21 May 2026 15:03:24 +0200
Message-ID: <20260521130324.754100-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253542-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6F7435A66D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OnAuth() has two bugs in the shared-key authentication path.

When the Privacy bit is set, rtw_wep_decrypt() is called without
verifying that the frame is long enough to contain a valid WEP IV and
ICV.  Inside rtw_wep_decrypt(), length is computed as:

    length = len - WLAN_HDR_A3_LEN - iv_len

and then passed as (length - 4) to crc32_le().  If len is less than
WLAN_HDR_A3_LEN + iv_len + icv_len (32 bytes), length - 4 is negative
and, after the implicit cast to size_t, causes crc32_le() to read far
beyond the frame buffer.  Add a minimum length check before accessing
the IV field and calling the decryption path.

When processing a seq=3 response, rtw_get_ie() stores the Challenge
Text IE length in ie_len, but the subsequent memcmp() always reads 128
bytes regardless of ie_len.  IEEE 802.11 mandates a challenge text of
exactly 128 bytes; reject any IE whose length field differs, matching
the check already applied to OnAuthClient().

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
v9: add WLAN_HDR_A3_LEN guard and WEP minimum length check before
    iv[3] access and rtw_wep_decrypt(); tighten ie_len check from
    <= 0 to != 128 to reject under-size challenge IEs

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 68ce422305ed..8575b7bd6d84 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -687,6 +687,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
+	if (len < WLAN_HDR_A3_LEN)
+		return _FAIL;
+
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
@@ -698,6 +701,9 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 		prxattrib->hdrlen = WLAN_HDR_A3_LEN;
 		prxattrib->encrypt = _WEP40_;
 
+		if (len < WLAN_HDR_A3_LEN + 8)
+			return _FAIL;
+
 		iv = pframe+prxattrib->hdrlen;
 		prxattrib->key_index = ((iv[3]>>6)&0x3);
 
@@ -802,7 +808,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
-			if (!p || ie_len <= 0) {
+			if (!p || ie_len != 128) {
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
-- 
2.54.0


