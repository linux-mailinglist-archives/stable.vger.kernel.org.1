Return-Path: <stable+bounces-253664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB4lEBioD2rCOQYAu9opvQ
	(envelope-from <stable+bounces-253664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:49:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEF25AD91A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F965307072E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94269285058;
	Fri, 22 May 2026 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2Gy4ed9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240C242D70
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410802; cv=none; b=d5hnDeS69XAGuQQYnLpVXeU1FkY04YdimGJBNfeT23iG26FZCNMmckNsy/hfbAAkVBxIlyItQ3Zclnjy7pL9kpUm/u2tpRTtb9iFhFJierjXIfE411Ftgg2Gzoeh9clzMoabBSN+hZrYlaCBMC2euLSR6ruCRQ6vGMgP91YWyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410802; c=relaxed/simple;
	bh=hF1f/XhdiP2YvKEyxu0ITp6VH91xQhL3/cp96Q6vKMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDbqEECGP+tQrP9Azmd+oFIT8OHgcXm2WqT/LwseYD8GuOLX2qXzKWEISo452a7w4FVJnbm3s4V2on8YBZt4C0uEo3GsMbW0ojArF/LHv4rnzC1UtyHmdDHATSt8rUAux9DT7dyFdJ7pIoMIIWsmhLqIpW/RlQQ1XcNvcZaFlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2Gy4ed9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso8630600a12.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410799; x=1780015599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iqsl5WA4SGGND602OHgH3TwkzAtPkOunkBnoxgSNAEA=;
        b=p2Gy4ed9gkKapMGai/c/8/WvLvDBHe11KCgucuOox4bfH1g1dYl6UcWuY89xm/UsyS
         6XujcE9kh0vJgPxIEkqlhdP9FxhNdPl7gnxUYd4FRnRxSff3mEuSS3axQXwAeenboAXN
         szwmPcao6ht/GGVL7LhhdMqL18uE7ZXOuEgmejWY/n9P9I9PfE4wLn+ajyLLwztbSVGk
         fBlWz4bBcB4bZoys4fjLwbJnH/QLjmChbCCiUhA8BOzzhsNeYB0YqyUrc8EunSXLhatN
         le6INO+kum1Pd3V/UijEpTIKOApfFxWd4jk6qSr3itWC1OZ3lH+g61LZ0zgI/n930UM0
         ypng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410799; x=1780015599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iqsl5WA4SGGND602OHgH3TwkzAtPkOunkBnoxgSNAEA=;
        b=eti6GrDHhwPQJD7ECAG1SLE3AiAho1j4TkoexywA18676myTSLQcniC2tgaNDq0VXm
         ymAmpHBMHoCCewNCmBFRL4x6VJ/Q7T1CwqpExZUgOp9Rv5PyoZezYrlYCc3BuVcVCF6N
         C8EFwbGsw6eRIHFmWJ+0VcMEzsEjDD45FHTkj+5/lzu6MQWzqJGnqeqfNfqqXhKxaXHg
         cECCV0/wH7OzPppr3e6CjHXKEXQOxo7ccrlZdr4DGsYSb7CVc1l/kgSKaXw+qblN6EUG
         LvcG44UU4jjGG9UYLT6fHvFqNJ74jmDLu84xUJURnXgh5Iqmv9noAy/H5Xnq8QHqFCH4
         lCiw==
X-Forwarded-Encrypted: i=1; AFNElJ9cG//STYwVAhZFMWs287a1lTdv+zOGWcnJgWuVCYqH2kks09igGzVrpT+VC9rxm9mL9hrvTmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RdLlLu9w/AhroZKDlNHt9DzJowF1erMCofaMY6AV7dQHhH2f
	f3+DJ5VbmcuGEx5mbgMjh7nzxF84r2C5qRLQfJqhRQQi+KwY/zsca2xP
X-Gm-Gg: Acq92OEAMNxixEdZ/m3DZNvNHTflTNAxRzZQW9Cr0s1do4nZnmAwkYM58NWqGkMvVYw
	0Ca1msaOnphbQi+3m9qnQlyUOb/PR/Ri3DKlMOd+jm/2xnlTMHZCBRhvysDF3Tcp+kFPj6isZdP
	Y453mlOcXKpXruWae+t/9i4OgRUW0K/ONgwSk1nevMRj5x5RXrbOS5QP64cDbg7FDr12G2DeZel
	IrPqAafLEoihwcRKvC/qjb+Kmlm5e0JYCvDma8Sni1EqBx4yPNDi2h4Ma9qvBS/m6waHXmAFs/a
	UesTa1wXVpA7Ru14l6AKwgb5uekzfpt4cedI5KppqD1poRe7sepXh/EYkGwXpjL2LXQmWjoDiA5
	qN8apWfdtg9mpqwEW1+QGLGNA63RpuU6BoCQsu3XSIPiR1TIpJ309Ipw4lb6NSTtyr8/4QC3O8v
	l3XbvVLoHkButUriMr5jRE7a14vjZAgt22mBJLB04HFDxlF4muLJ+juZypXwvgD6nJsEe7ny64h
	xuVCEvAq+Vvf7aOLbcTxZG+06wfrCcPQ9LNLzfaAJaA+lKu20YxkTT+x1YaHZC5lSdXMZKEaWK2
	Y1EP37nQIushCJdq4j+197ALGH6VmoDguZVPqTY=
X-Received: by 2002:a17:906:dc8b:b0:bd4:b787:f1d6 with SMTP id a640c23a62f3a-bdd2542d83fmr82049366b.6.1779410799134;
        Thu, 21 May 2026 17:46:39 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdd75f9cf85sm19122966b.53.2026.05.21.17.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:46:37 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v10] staging: rtl8723bs: fix WEP length underflow and OOB read in OnAuth()
Date: Fri, 22 May 2026 02:46:05 +0200
Message-ID: <20260522004605.1039209-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130324.754100-1-hossu.alexandru@gmail.com>
References: <20260521130324.754100-1-hossu.alexandru@gmail.com>
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
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253664-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ABEF25AD91A
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
v10: no code changes; add full version history below --- (omitted from v9)
v9: add WLAN_HDR_A3_LEN guard and WEP minimum length check before
    iv[3] access and rtw_wep_decrypt(); tighten ie_len check from
    <= 0 to != 128 to reject under-size challenge IEs
v8: standalone patch; change WLAN_HDR_A3_LEN early exit to return _FAIL
    (sa not yet initialised at that point, goto auth_fail would copy
    garbage into the rejection frame's destination address); add guard
    for iv[3] read inside GetPrivacy() branch (len < WLAN_HDR_A3_LEN +
    4); set status = WLAN_STATUS_UNSPECIFIED_FAILURE before goto auth_fail
v7: initial OnAuth fix (sent as [PATCH v7 0/2] 2/2); add frame length
    guards before GetAddr2Ptr() and before algorithm/seq reads; correct
    commit message (rtw_get_ie() uses signed int limit and returns NULL
    when limit < 2, so the unsigned underflow OOB scan claimed in earlier
    versions cannot occur)

v9: https://lore.kernel.org/r/20260521130324.754100-1-hossu.alexandru@gmail.com
v8: https://lore.kernel.org/r/20260511185314.1625375-1-hossu.alexandru@gmail.com
v7: https://lore.kernel.org/r/20260505211316.3837020-1-hossu.alexandru@gmail.com

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


