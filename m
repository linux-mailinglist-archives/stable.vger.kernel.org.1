Return-Path: <stable+bounces-241518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHPWFh198GkaUAEAu9opvQ
	(envelope-from <stable+bounces-241518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:25:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7685481581
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D7734B444F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA537EFE8;
	Tue, 28 Apr 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjMWd/Vb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F837EFF0
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367904; cv=none; b=PcCzAoNhwMm6Q8+27FSqidcyGEAV+LURHPQD272XtqRaz0PJ0GbzX+8votYNtddLTtuxcUoET96iAeMKV/KF4qfj2DGccptVYNU3RnQhlbX/lIME76547RVhP+9SFOMhGi4bR9QHQ0sEyC4fu9jD06jfBF+4YMj6Vv6szSrKlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367904; c=relaxed/simple;
	bh=+YeUIV1+wtcPKuOvB4oPRVaxMCPwWFWxjyfdg1SSC4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOAHCoUzeUkBTAgSd53gxzY0c6VegZJjGDsDU+UhTWttK6UAs5+aq5pfRwribCb9+V7PyCB5HycRyQbRGrmJXG8W/SjS9M7PRK7W0PtMIifyos0WsMYR7oUFUWC6Ci9e6MVlS+oChVeSdoKXUSI5WaEcncahxRhyfEnXuwRptTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjMWd/Vb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48374014a77so144490975e9.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777367901; x=1777972701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMczc9e1ajSbK4Mrr/Qq92dYlg6aGcU3H3gAe4DnWL8=;
        b=HjMWd/VbVqCxlFtri/E7sdo/vK0wLB4gUg7O69/VGAxvmtgjttxYWCaSzZ4DfxyrQi
         +78pdelNftrv3wP2L1XJWu045RsCmyFrZUZVK8eJ9dvpWaJD5zQ2zPrwgP3lgZVvI7x1
         eeN6F2TfPcYUWIJCMIp5f+JPL+L22XlPwZZY30wbjXb/AcxGgYDPSH7ft2Qxc5Z1RXRz
         w70im6oES46NnB0vtkBuDm+RNjY6pAZIg9Xvvv/fPzWOIkFloB96/P5Ge7jiS0/jSgl1
         KTVXnYMYpByov7mEt4nA6/ciDlzaSw9lG2iz0K6e3tyygHLgyhvTOh4A3AL6/IxkCuUN
         FhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367901; x=1777972701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMczc9e1ajSbK4Mrr/Qq92dYlg6aGcU3H3gAe4DnWL8=;
        b=kcJOlOaoWKzqIqSBPPUbab/1bDUfSt8B/0jK1srVXMcsJI+xZdAufy8rcA8SLeGXPN
         hmc31OMcJVYjBIdS3ETh1fRVXFP9nAt+8Z31Q+/hCaW5epFxP32lBJpBKykRFnH7aSm4
         AvktMGNlhCtOnHqtGqCr9RUTdVBqIB2w53kLN6ukr9x2BkRDDYippW0TnsshmbheUcAA
         hYawNkFFLo25bVrUNYaCgEMDp3VKiorBL32kz0M+HsI/Tcd5cj7dEasQUvJeuOK2pjB/
         3riV6uXiCE3guVpS146Eb9nHMCi39nUKgobOXOcE9EOtzsJplHa6E4+VhaFdIV0Q9hfI
         il4A==
X-Forwarded-Encrypted: i=1; AFNElJ/qDaBeUMpgMsa9Ee4rqoDKgWmheXDyzYjYctG5oa8ggJbop1g/cCq3wZeSiZ5pxlXSqFjo7oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntHCw0P7RiiklHmG0D19321tNnEQr/lfWRK8SshhK2gDD3zbm
	Ra0meaMdSHs0dlDG/TYxgMPhijzgZcuaT2plIa1pAlVkUIhyfufcqFIA
X-Gm-Gg: AeBDies1NcbzYDxjda8vTU6fICyJlZq7i9R69eWG2Q0vwoJfww+7sebYhvrYZPryVUF
	Cc16ue6bnxAUGh0nIsF3a2xwGPr5+huH+X8xqYLS/1fLVBQt3T9Z1JtY+591gESPr85wtcvakea
	EOt549IwaLRj0DUlw1II1lZ4XwiVKokfREKMxuIVlUlBASPsNlfFXzXkoT4VhWk9hMTM/PsAtuY
	BFdDYoY7djUfTOCNpa6j/6qtoc/DyTn2vIPR0NYv80guerYfDf3e/+BmVX6S57MY3Vqbf5o8BB+
	gs3ZOTmVm5HCGUktXmEekmNqLexYHFovmGytrE9h53s7lalmHBIvPr+C2Y67n9W+gsfNfGWrbFL
	je1TTUy+o/ybW454IybCZg+pGxrcClnrsZZm7V/j3uZ8IR0pmPfqAdOHl9+f/I7HTh0MTLnP04I
	Kgq3R9lGgnp2mukSYh8drc/Dcorx4BN8QBwHEd2ANF69XtqDSqN62E1Ud8GEAd3vzu60x4qXXIS
	tTAFG4pBscX5HIOWSuEE5mRTlb9XSJpLEV6G/23nSE5hbmZUpbWuUwGrUQfcVM5x2hNW+U=
X-Received: by 2002:a05:6000:40cb:b0:43c:f28b:8863 with SMTP id ffacd0b85a97d-44648963530mr4196668f8f.13.1777367901404;
        Tue, 28 Apr 2026 02:18:21 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f6a1sm4902502f8f.13.2026.04.28.02.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:18:21 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hossu.alexandru@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
Date: Tue, 28 Apr 2026 11:16:21 +0200
Message-ID: <20260428091621.739680-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428091621.739680-1-hossu.alexandru@gmail.com>
References: <20260428091621.739680-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7685481581
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
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241518-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The IE parsing loop in OnAssocRsp() advances by (pIE->length + 2) each
iteration but only guards on i < pkt_len. When a malicious AP sends an
AssocResponse whose last IE has only one byte remaining in the frame
(the element_id byte lands at pkt_len-1), the loop reads pIE->length
from pframe[pkt_len], which is one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond pkt_len, silently passing a
truncated IE to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past pkt_len.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c646dc2a1741..68ce422305ed 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1406,7 +1406,11 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	/* to handle HT, WMM, rate adaptive, update MAC reg */
 	/* for not to handle the synchronous IO in the tasklet */
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
+		if (i + sizeof(*pIE) > pkt_len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
+		if (i + sizeof(*pIE) + pIE->length > pkt_len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
-- 
2.53.0


