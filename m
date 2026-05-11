Return-Path: <stable+bounces-245303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKyIF/IMAmoSngEAu9opvQ
	(envelope-from <stable+bounces-245303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:08:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0164C5130FC
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 585F03018D5F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF243E9CB;
	Mon, 11 May 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwFnSdSh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352D449ED6
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519172; cv=none; b=GM6RkCSWwEZH9Y+YSH5IULB+UE6hzx769smLzP8hra+pef59z2pmCgsJHHTjUBBi+AM3joIpuxWh0vaWR7Noq9vC/Z665/IhquQ0/F2L5JtDBvfam2clQ48saTCTLPNIqnZV1TLhmCrtZ7n/W1TRhJdS0Ya/omGhAP2xcyIupOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519172; c=relaxed/simple;
	bh=fvBHmQK/Aon06zpbGAi0GixFIKSfHZv5VmbC296WFB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRAeGyPGB5taEDTipWDTcIlptVgLba3saX7DjxpuUrlLwEEsJMxMrAb88Ho8pZkaWy/cD3bcZLsNrfdh7nkGUiSjkHmppkd5XRsMM3lMVsRGJ59yThZodReKlOxVyLsT7m6FCgQC7kpG9csiLA22T85DLOqQhyiGWi24AD+ajAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwFnSdSh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd1caeba6beso109816866b.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519169; x=1779123969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekBwyg4HrSCpTTMTvNYpg3hZClkHuRIw3pfp/Je02wk=;
        b=SwFnSdShS1QT/npAP3mMLdK1EAxInT9GX+m+801l/On64Ioch3EFoPCQbsWlHFKa06
         +juw4ud2KOGkr7HKMu5AeLvtPoELjpVnQ8BKGdVSP4of0cXbus9GQiNgqWRXacVDzj3e
         XJDINqhbyQU6rt91QVwyfW7kE19F+YzhR6DOs4xx7ILMRU4C434t0BwJvJCpis+8KDys
         G6ODFqa7USIsuXzLRHIAxz9UxRYlIwyK20zlulJDtKB4/ALdMQwjJQZ2PdWCb1csuZ3e
         rKyN+GQa9s2x50LimdwWkjlGGgpExf81fsGwq4JwkRqprM8VRCx9UB8BFmllG1Fw8izD
         OEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519169; x=1779123969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekBwyg4HrSCpTTMTvNYpg3hZClkHuRIw3pfp/Je02wk=;
        b=IE/rhwx1dNrfHDkW/1hb8YL4HEdhNcxXrPC68j9aWIipPx9aMOhsq1GFJ/MtiESSmA
         TLdCKbTKWVblo9Lfxf7Xcy3+UHNgat5cVQn6RnqkhpH2QZwUGz2keSGd8RhF1LvHcbuX
         JBEhsf+KIsANNC2o0z4avlVXnXTfBhQjg1xdh21gtvmxpULbQT2Ua6DaGTOfE894kkux
         5f1VsRep10u9mWsj/CUaW/76QeNz+nVfDlqca3NCI+UwJ9ysRoglH6HjVeOAsoUkop68
         g4/lU8jp/YbqJvbFcN3/wLBZNKc+Kfy8k+5a/9ParA5JAoqvCyugWT2iE59PgavESRI5
         kWqw==
X-Forwarded-Encrypted: i=1; AFNElJ/MGc8WdgVB45hGSLfOH+X1h0VkGw2JTqr7UzITdj4wQABHkjCB2iEH678CZCEvceTxFg73BaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYb+z4kaJXYmBflTxGn233ljXZ6mynAzgVa/AEAqxDRTUAcum
	xIgqALvyBAOtGyQrulY0TaNaqQNlUe3s4Huwsc/gddy3eg9XQ/O7qtO/
X-Gm-Gg: Acq92OH9Ec66fIHToHsxqCM4JCdBulRQV53Tcu1CwL0J2z5brdBcEZ46wpPD4SXTX0o
	7lHoRL3tBO43l2qzrKBs59ON/fckpcL4puLAsRa6GGn8QtX509b4CBF0mwaKqrME50+nH7L0Ptf
	/56UsIr1GZEb7k8Cs3K8AoJL8Z9oDtTkw62lVKJ68JrCrHIUx2bw4ZcYAPS8USA35vurOhdHVNC
	YIp9LX0/R4mvgTLxffNSzIiV7ZiY+QzoJvOjlydnraLoI96ooPVWKC7PJRsJKUiNa7x0JWnv+fF
	nxGfxSQrzh6AvSKGOf86eeDV1LeAqvobUMry4icFmNiDCMHMpSrF3wbVOecYUnB9dw+6nKkAqkb
	8n0XEeh+I4oERXjE2UBXd15QRSqZrZrAEWGSQYzRr+g3lV3y5GCeXTQ4NtSDEri/au5gl73MR/m
	0YIbCGNTme+X5UumFgkq1xgmPySYTRIH+JfIvKXPelp9HtQHYKxVfrjmPKhW2dvZCK+nqpAtS0+
	VJ4T2WI+ElIqxImhrzXNtx5FvAPtbTDZjdLJfiFI3kJ5CAQB3sqqz15/X9o3ItB9e2APba3ljNL
X-Received: by 2002:a17:907:988:b0:bbe:37ee:8a2b with SMTP id a640c23a62f3a-bcaac454c4dmr862165166b.33.1778519168856;
        Mon, 11 May 2026 10:06:08 -0700 (PDT)
Received: from ahossu.localdomain ([2a02:a420:2368:9048:c0cb:8552:96ce:1210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bccffbac588sm325319366b.6.2026.05.11.10.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:06:08 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: greg@kroah.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 3/3] staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()
Date: Mon, 11 May 2026 18:57:43 +0200
Message-ID: <20260511165743.1588637-4-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511165743.1588637-1-hossu.alexandru@gmail.com>
References: <20260511165743.1588637-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0164C5130FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-245303-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Three out-of-bounds read paths in rtw_get_wps_ie():

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

   The code calls memcmp(&in_ie[cnt + 2], wps_oui, 4) without first
   verifying that the IE payload is at least 4 bytes long.  Add an
   in_ie[cnt + 1] >= 4 guard before the comparison.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v5:
  - No code changes from v4.

Changes in v4:
  - Add two IE bounds checks in rtw_get_wps_ie(): break if fewer than two
    header bytes remain, and break if the declared payload extends past
    in_len; add in_ie[cnt + 1] >= 4 guard before the 4-byte WPS OUI memcmp
    (sashiko review of v3).

Changes in v3:
  - No code changes from v2.

Changes in v2:
  - Add explicit size checks in rtw_cfg80211_set_wpa_ie() before memcpy
    to prevent the 256-byte supplicant_ie buffer overflow (now in tree
    as 92f3954ca9e9).

 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

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
--
2.53.0


