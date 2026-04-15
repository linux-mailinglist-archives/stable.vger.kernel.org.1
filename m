Return-Path: <stable+bounces-238081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH6MDKte32n+SAAAu9opvQ
	(envelope-from <stable+bounces-238081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:47:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BB402CF1
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD8A5313E3A4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B756533F8B4;
	Wed, 15 Apr 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIIx9PBU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAA433B6DB
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245993; cv=none; b=IR9zpNaEjmQbCBCOitxJxpJtCQ3djfJ++z69DZ9uHvCmfG+ae2Gc7Il3+Uyw8l6P+S65pi7xNFqval5/+BkhwFDr7P8jpi1jd73iv90NPt4rKrTia8lcPpo0kgrnI/gRpmcFUF8s2tDWXbwmEIBH9LtdSnyS6JsRTwc7svJ6oCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245993; c=relaxed/simple;
	bh=8wEJzSrLXxs/034FOnYHmEz9U9WF+Tj2QdyA72fy5CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7ZpSyU5yGGF9YRstZVT0EzT4/mDYRUVBGS+/HwWTddM8UhPA8pZjQEhL6i9BUgBNZhdEdkxLXz15D9qtFlExCACDTPUT01PnjTBRC02h7jXiAMtWPBnDRiX64Mv//OCZJxKc+v8+RUTesibBloreZrKC+rM4i8aSQqzUgErmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIIx9PBU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-671ae79e617so3653923a12.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776245989; x=1776850789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMt1KMCrs6g/yh5vW62yefiOqceYfNw77kBLrZ0YXf0=;
        b=CIIx9PBU8dAtCmF9WYXtcp389ALKdpC38bIcl6rmOjvhJSCGv02L83Bs1Rnsii2Rdq
         tAwBRuiMKZ/NIfM1l7r4Q7lRzaBQdYizARy6QvAk/ZY/0JgtIkYeiJBKgqgaAaAULG5w
         +7FwQVBuFLALur3pnU8NPBmHir6ncEZnCh9u6zP7YmND7tQEdnkAANPlX9+btW2HuD8Q
         3VGlA0jGjRxGSyi3vKQ2cIqg1l4/kF2IAvV3EMTqAQ8r4GS+KQxrqb5l3zLq7DjGtT6V
         g7bfjF8oq1iRb+pIKFKdd+VOL0xzhK+lK4eokc8enY66LUzU+/bNIaRjf5dEW5hLoXic
         WFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245989; x=1776850789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMt1KMCrs6g/yh5vW62yefiOqceYfNw77kBLrZ0YXf0=;
        b=hg+sfxPwJKiNNFuVf7fa0esLtqxBKxwpmqS26onOV1VgjTsx0QkXUjgRqdbMwH+05X
         jjYPY7HigpaUSBDDE3GrWqgZivPfgIcMoOfXYsoF3dsxrnyGjagXg04n909dfepxqabh
         x1sjAm3mqNDtw5YCqRj/cvHwhw4bNVoSAr/oS5MvF/lrp1vRcNPbJdbu5Fv+HFTmHU+F
         xSNHOUBSQemOsZyK1QidKxjgsvlw1qCSG74wRhuoFN84H8fAbqKTdxvV/zJeH767Pb3t
         HjKJksHXGk0dMSOSW9jTSwomnEToWQyp6CF+79IQYa8LUGR9PX/Mqql5R3zECdxBm6ok
         yWQw==
X-Forwarded-Encrypted: i=1; AFNElJ/JWtMC59dfy9FnJhHGKpwUWG2fA6CCwJZvTTHCHbOr2+JyWnRlwjoTfDfcl7iw8x9SLrLRWPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EjyDb/WTTgkXlSgIIhY5inora7pfbBioR5lNrnBuNrYt0BUG
	uyQH3QLF8xXVjjnDd6z2/his0yyK/Xdugz5mWEetvecltJm+J0OLgreJ
X-Gm-Gg: AeBDieugrPnXdHLifuzkO3jOfoC77XCM7C8XnwSHBKbhNFNC190ZXutNH7cAWJEk8L1
	axR4zn4COAtQhFbqakc0y1EHI3nu/c0cGLy1R9KTsiEKnsb45n9nIb9qou2pf/VVzbYHlRqxnjE
	PNyWVGeqYGXbAxFvfYpa68gnsS9yadIqrkBr5hnVeAcTjmVi3KcPW0IJqxS0uJnHjaHY+V+htdG
	E792IO8W6gkucxX3jLBhHT2W8wdZVkLfkW5TuHJCqjjPEf3tVmN5hIh1rXrqzU9QaatjPu2p+ib
	SNjSrc9LMP7SJAaMTRV21aBZks9qP4OELws93TOwiYmqCJzvf/MgChk0chwQJ7CnDiv4qqZCV1o
	jYQ7j/gWDSOzo17PFaV9aQLdHKrY6GtbC7dFi5aNsdLS/6zWl/L2x0w9fSkDCwlbq5LHUVbtiju
	m06l7JS4z0FVLRFBZ9WSJkRTDUEomrvRajTZvfBVYdFE5RjR04sdsCLTLsF5PR+nCejx88upZui
	uw1r7fyvFLbIfClaHCIUc3JvIi+EsdtJdvPRMbEe6BJMbTJsKiN4ddch6DqFNcxVLgKdecl9is0
	Ss5j0Ew7WJu4+ErC
X-Received: by 2002:a05:6402:1d51:b0:670:3b53:9bc with SMTP id 4fb4d7f45d1cf-67077652932mr8597223a12.4.1776245988696;
        Wed, 15 Apr 2026 02:39:48 -0700 (PDT)
Received: from ahossu.residents.sin.openfiber.nl ([88.202.160.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237d8cd5esm252223a12.11.2026.04.15.02.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:39:48 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	stable@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v5 1/2] staging: rtl8723bs: fix heap overflow in OnAuthClient shared key path
Date: Wed, 15 Apr 2026 11:38:18 +0200
Message-ID: <20260415093819.1112313-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238081-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8D6BB402CF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtw_get_ie() returns the raw IE length from the received frame, which
can be up to 255. This length is used directly in memcpy() into
chg_txt[128] with no bounds check, allowing a heap overflow of up to
127 bytes when a rogue AP sends an Auth seq=2 frame with a Challenge
Text IE longer than 128 bytes.

IEEE 802.11 mandates the Challenge Text element carries exactly 128
bytes of challenge data. Reject any element whose length field does not
match sizeof(pmlmeinfo->chg_txt) (128).

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v5:
- Resend as 1/2 in a two-patch series at maintainer request;
  patch content unchanged from initial submission

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..90f27665667a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -891,7 +891,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (!p)
+			if (!p || len != sizeof(pmlmeinfo->chg_txt))
 				goto authclnt_fail;
 
 			memcpy(pmlmeinfo->chg_txt, p + 2, len);
-- 
2.53.0


