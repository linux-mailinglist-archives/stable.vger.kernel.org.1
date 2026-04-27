Return-Path: <stable+bounces-241262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCOlDC4c72lk6wAAu9opvQ
	(envelope-from <stable+bounces-241262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:19:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7B046EF17
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1E7302C0FE
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0B37C91A;
	Mon, 27 Apr 2026 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaCBC7mt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC137BE7D
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277905; cv=none; b=IXYKV+9k2V8IbfUuhErjKJ3qRosyjl5B5yw5bGQAX/1QWO9VDjORHPvwjENll87GMQvl1DRoMr9kDfcLkyvDC3oupSwR066RczPsT6LGard4p5STc3kQtXpUVU3UbiszswEKN4ObbzoiC2Ilp26TIi4SmmELzQAFi/ukSrs9ZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277905; c=relaxed/simple;
	bh=X54KA9PavQZQEzucsCa1+36HcRdsBWVlMFDudcoevyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgvfP5Ko9zGlhZzws7ThPGJtFYvYbKzkP+kAxZju+oNySDc3NXj4TqF97j2raINA/+CbG+Mlt3+g8GBCqfklA4KHWZq74QLg5NKPDXffDaO7RoxUjzSOAp4uzX/HxutjactjOrtAlLNHrEgjkzJ4kAnPgUTGE7LUFALcmqG4FHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaCBC7mt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso106027445e9.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777277903; x=1777882703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VGLXQGdtwW4M4dZrF/iMa6PrGQcTVy/0M0hUiD6E5M=;
        b=iaCBC7mtUL8wNQ2E2UfXAk41pu2EJAoDfvWVLTC4DpfYUxC3wN8vQQLBoH2sH+f583
         VDU3O9Kzkw0k+0vjq1bx33yrS10x2t3Lr/Lw864rxe/C0bNuSxQmEXf5IssVT5JB1jV8
         9+nAyggvj/iEVE15EZsFpctK+5rnDgGtw392RAn4OYRFfMYysLXKtF4z74brlH0ZSo9U
         NhEeDd4e5xFnogNw2crxzcQakM0+TQWW1es+sAuq44iyZm+Q4ToCay9EphbG/92WMVxQ
         gpRs8TGKnDDbz/DcAKrX8mqgPxSQ2WwFRz7LMA29BuH5GCNFQam9iH6bC54VMdhtJA+F
         wXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277903; x=1777882703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4VGLXQGdtwW4M4dZrF/iMa6PrGQcTVy/0M0hUiD6E5M=;
        b=W7U4C26sqnkNlANGxcndcV84e0EPwDWYdU5ofb/uEjyEEgi8BZ/yrU4DgM9kGENMOQ
         WbOERHK4LUPAuyKveTnu9y+ZuVWrTnlc27Lhx1fOs5dRED11XH2RxhsY3cLsJnmpKKkV
         1Jian96lS/qmv801HoF50H9r3VwspTBz6JwOnvSjMZZ4p/PfXN+d5NtwcEROq+cIpoIg
         lMsdm5eaYMUQ3tCCBg9dpujPmkYQGMF0wOZVJ4/BEMtGjFhKkbH1THETq6fneAtBvLMc
         yNhUdVJYCBOQAqtCcSIyXIrz6mHGJbtdyaHUG2SS0Asg5U1H/Yc+arLi1YtN1P56u1rs
         UDQA==
X-Forwarded-Encrypted: i=1; AFNElJ8zvl5ntcm/ckZd4Rf73CAU3Pi/PGWloyNUPpEQ6shnN6bOow83QJoetW/q/UIRMLQevaYSA7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8VOOnTHdBBGdIym1tIAi6VU0qmyxrGi2S52kBLP3AvkMTjdw
	0R5lKw2ffcbtWQZC+EAmpfqOiGotGWYaQBtL2ph+CzZNkzfLWFNQsz0a
X-Gm-Gg: AeBDievm1fcwbI3osKVUn1yUF9JY7gNWMqjYeHZebGLayFaLPjCyL0xhsHhS26EE6bA
	F6aeWankvLGBp7ME8vkwGyxqh321TfaIibkxh9gv03Sn6p7d4DLlhc+ZksqQWJ3ZQ/YQydIzKKG
	zmD25tCjL28WZaa3S3YUQxrc2vYbcorHqmaPR2TEtDIBTeMFHrw4W4mv+1qjsiIBSjSUDGKdUmb
	F1iQFkZoUEDslw871DCs9ba8Qeht8pEn3zXElR9E9HhR2itTGJ8KRbvSUG74JMzqNApVL54V7Pn
	wBQN6KRQ0ZPCjK5IlciipMJpX0FGNrVRIb/21fcWaYR9ncKx/fX7+pIJXuKrfgxUpcDyEx1Ge9r
	hd0Nc0yh2GhKSF35PKJSlC9lo4G4zihNduA084pk3nWM4I1+ywxIK3a/gQQhGGMT6qSRKWZhMHu
	fd+zE2bT0u8NixDIU6rgxHZIrJxLtMmJVeSbRRItPM3eIW3iGJSjz35uFCZyzjU6ggkph2f2TYa
	eqpNBVXxqZ6IDhwZvbdY3vwdQV25cvmvLNTxzF/rdJT4vXqL/ZO3SaUqHs3xJJ7kK3XXHk=
X-Received: by 2002:a05:600c:c106:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-4891ba85d07mr326445715e9.29.1777277902712;
        Mon, 27 Apr 2026 01:18:22 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14a61asm712652115e9.15.2026.04.27.01.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 01:18:22 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] staging: rtl8723bs: fix OOB read in update_beacon_info() IE loop
Date: Mon, 27 Apr 2026 10:16:24 +0200
Message-ID: <20260427081626.3393697-2-hossu.alexandru@gmail.com>
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
X-Rspamd-Queue-Id: 7F7B046EF17
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
	TAGGED_FROM(0.00)[bounces-241262-lists,stable=lfdr.de];
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

The IE parsing loop in update_beacon_info() advances by
(pIE->length + 2) each iteration but only guards on i < len.
When a malicious AP sends a Beacon whose last IE has only one byte
remaining in the frame (the element_id byte lands at len-1), the loop
reads pIE->length from one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond len, passing a truncated IE
to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past len.

Also replace i += (pIE->length + 2) with i += sizeof(*pIE) + pIE->length
for consistency with the sizeof(*pIE) guards added above.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 6a7c09db4cd9..e0d73c267786 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1289,7 +1289,11 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);
 
 	for (i = 0; i < len;) {
+		if (i + sizeof(*pIE) > len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
+		if (i + sizeof(*pIE) + pIE->length > len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
@@ -1314,7 +1318,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 			break;
 		}
 
-		i += (pIE->length + 2);
+		i += sizeof(*pIE) + pIE->length;
 	}
 }
 
-- 
2.53.0


