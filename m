Return-Path: <stable+bounces-253548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEQBM6oFD2pzEQYAu9opvQ
	(envelope-from <stable+bounces-253548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:16:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B11975A585F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AD5D3078519
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F33CC7DC;
	Thu, 21 May 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrg9S2iT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071713D45F8
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368648; cv=none; b=ZQ3RP5VC5JsIj+rXi4bNWw6t4Fpk/3fI71AiJs7aXLEIK73v6rDjcr82ysEdTjdqeCa9P5MCPfkc2hxB6M96btHq2urIAhIJjrt8JSdzgND/lLdoc4cK2hGo9xUIJvWnoo8RMtfAi3XTDsWrA3k4/aMKKAygQbWfHVyHbQo35tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368648; c=relaxed/simple;
	bh=9A4jVnzDv/usUlFeq3EuOnxuhB9rRPwyxJzmHvtAJ74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgGE++SEsClsRmehaJR7WAIBzC3FsTdN372kETc4VpqjbGmi/srbrD+WmrVRAAkzZMJALW17AmG004/cKy5mJQ4AGlPBumlcuDDTLxwkSz64z5dBp+5TornF74cazVuyw3UR3w/Be+fPKVf91AH2kgo2FUUWRtKwC87GrSzY2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrg9S2iT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd8f9889a8cso665481066b.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368645; x=1779973445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4lmM74WsQVb7gsWrSGGOh3OWSwYycbJASwr5KvwFMI=;
        b=mrg9S2iTlu5n/X/w1ITzN+GLqaRG9Q+p5tCrOoDZX0lpu299M4Y7iyC2HiwPYt/fDi
         75y9GU++hAZfoMYqBhBZ98OJZKIsbRVMkRE0KACvWYqNebt+1ieZwi2yvasXlHYLsg2X
         nNMcynMuDoFVqdfUCPjU+yDCwNbPhU/gyocgyH9RWMXz1g2LS+Wq0Wjiz4Nd5GUvyMEl
         h8fLZBeyvLKNdHTHNjQug+IDDq+DBRHWD/YA2yIWYm2o0HRhawZxzwvSxbyyb3uTQN1+
         rMe+M+g0flPy0NwFibmOZ4R6dxeo2bfCLggjFDrlWjnkUHjB5GG6PR3lUJ48AV6L2AnF
         y7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368645; x=1779973445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4lmM74WsQVb7gsWrSGGOh3OWSwYycbJASwr5KvwFMI=;
        b=N43sC3zcFtoyHv9huRsIh3qN7p6geYJDpQt7azAVLp4KlK65F0RUlz5rcc4bWn7YRc
         rj4UMqvOkFsLA48HLb49pUXqH8ei0hMWg7OZcU5l+n9BAA5TchyZi5oQbfXUncmv29zF
         3mBMoTHgqBhWRldwvb7/rqZ4okEaOseY5y9jI6PYbg3FqUOOVLEBEi1LDIOS0akyicDA
         uWrG2ZXI7EXzvn46c+v+90nI+e+Js6tjX6CxGDGHMRujzUQSTdQDjw5vOv2RCAzSGu2K
         rF+3mfrzmCX/8oDxBuig5qcqU/UlRP4i892dhvxoJHTBhxIiCqDW7CJmyvCD1pDM0e71
         2A0A==
X-Forwarded-Encrypted: i=1; AFNElJ/JosemeCDUsiuWz4dUl+W22hflG0Bx9Y4U4aZTQQxUSZbQO8ws75R1hp6AiZsEC4L3NXTTrLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXxEVpZoYl17niStzPLDyPnXXousaiK8ArjiMhJigQwhR+ANI
	aplGUbdTp0acLGGQX/LOtReihK8jRWE5i9QAGSKfkVH4kpG+/VnF7D37
X-Gm-Gg: Acq92OG95WomWVJJ66X/Nz2rKRdHk55dyHuZLwnC1l2hKaHnIK8N50aiSzBQQkGKddQ
	KxQSblAwlOEsyqq1iAF6b6p5liDRutIcs/+Xf5FCMkDGKSfY2WWrGiEeEJa2t9t2HSziQGXNBIf
	Ezo407O8mLAlzPCQaiNiwGYGcIW4Qc63wlOxo4RmY2f/gT9fK/l511bMRLUn3Vx089ICBtV9ch9
	nIyaPaTh37Gv2Hshn0mEoEP1qEv83ie8HJvbs6lZBScovhjzPs1fxLNOCMY0JYSje4Ho5YAJWd1
	Z5QC2dKUfO1JLo40te5tty+RnOlSVC1SEswcHMkXsCtwMwagIwpQwwyNS9aH9VTy1D0hTEyYPqj
	9eWskIjse4lEN5wJxoUJeI54d8Oi12J+i/AR4kGEmNdxsqgsEDQ6ND2Fn/lcGN8vqQiVsu6IB6I
	xnve+MylcT8orin7CGA+q5P8bjuVX4+VAkUIifZYq7ZHxzoEinBJwRITcUcWmw4/u4wa3NGA2+G
	Un6MbrU0Iei8swhdvLg5tK3hkB2uVuiQHKJqZH5Aq5CypeEEbhKRXu+VDkfiEoeuvVmfOsX9uVR
	V9BbMo4QolGtvgG1SrGXsC22ZL7n
X-Received: by 2002:a17:907:7ba5:b0:bce:4be4:cb9e with SMTP id a640c23a62f3a-bdc13e7e9c4mr162388266b.24.1779368645114;
        Thu, 21 May 2026 06:04:05 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm43766266b.37.2026.05.21.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:04:04 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v6 5/7] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
Date: Thu, 21 May 2026 15:03:28 +0200
Message-ID: <20260521130330.754181-6-hossu.alexandru@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253548-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B11975A585F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.54.0


