Return-Path: <stable+bounces-237975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEeRBb603ml3HgAAu9opvQ
	(envelope-from <stable+bounces-237975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:42:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B09FD3FEA7C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA99C302C1EB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9C37266D;
	Tue, 14 Apr 2026 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONcfNr9p"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E35386C0F
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202893; cv=none; b=q9zlqlHbaJ87+2qzAQAN0AK63DpgGxYXu7m5wplGV1d2HZxNqNLi/vdw/LfhK1FAJR70/TEeI98S4NwgGD7fb3vIQChPZhDT60tuIrSBzoW757npeuSPogmgMtOxmo1Do5Lgp4ZlffV0r8QwcMPsjcchGl+erjsUP/WJre/+wcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202893; c=relaxed/simple;
	bh=PQj68ATGmmTdxtmG9+aHnMnIKYy/fIeSYUSwhMMyx/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HqDu7V201fPIsA1HRlRXf67peMddfWEx3Qk+ta6rakhWAtIqPwR5rn+vknNHiOb9WySke6QGJTTHR2MtBrGkPtOeJF2LUJLSY5j/s1a2Jr4KgGqvZ4Sovajq4pw0g9lO0kgeu5rlmlFFNV/4YONIRxRqdvOpvCKYzZu2zJCQlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONcfNr9p; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9358bc9c50so792972366b.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776202889; x=1776807689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YMw9Ei5H0E6MeFSvivUi1ZBwVNAjcMlXG9C4x//F7M=;
        b=ONcfNr9p/UZoKIad0320S9svZNIsO4ExW4vbD+QSLb6nPZKPoxl3GvUIB6Z2hXHrKk
         WjetQUhUz3/1ZuFXmJb9Jax+8SRzWIMlaKid4BuI9JhsxXxRWNVLpm+WhfQc3CzOWmQt
         XVDyjIub+MdbqlO9F6gvs4qvxe8FsJUehz7hrE6ZBEhS49hjrinkvr1Gu6mT+il3fDst
         Z5FWCQH66eayrechK1OdfZSHSmgLzFCk/rkixO1fw8XKki6epjNuqpvByNjCsXVqtBp5
         ms7e9AS8aJqIHj6LQwELfd/5EgqFr0r1ZZV4h3iwfL1fL/c75y927ZQ4xpMWTIgsAi+C
         6Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202889; x=1776807689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YMw9Ei5H0E6MeFSvivUi1ZBwVNAjcMlXG9C4x//F7M=;
        b=V5fbq0yR4jfdROLsIHhby0rGnzxgIQq4MYiwOS/og85T16x13YxvC2zqjI3V/EWjcG
         MWix/gadsJAghPCWAav98w+yuK0+PZC4jhyRBiwGEqly118baMJkAaiH3kzJBIiJqApc
         9X1a6Wkr9BolDec+NrMfgu5RR3rYFH3ZWvQz2jzWgWjybn+v7vxKXhwkLqzg6EJsf5I8
         iCw2t6sk9gA4Q6BYL997hsWxi82VyFVOry45wT/O6GtQ+FMC4oqBqWFoLWoFuUvVaA5S
         lMbdHwxu2S8ISw2MM2yZj6gCqaELxnKj62qnHX3All40G54nT8ETnOEPfAVTINTuQXYl
         VFLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lPToQDzUa+eRf0P13X2aRZirhxh3AKxX4Y60fjfHP6BN623LLKqlr1RXZixWzeP6Knk6BNh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJfJZO8/ZSqEpVv4IKgvPUtGiArLi8Jg8mrjhWuZm1zNoLv5k
	QKVQrjQAZHP6tN9rRKo7S7yiMGiqrjxv3lUVJij1UHm328Dh+Xq88AbS
X-Gm-Gg: AeBDieuwiNX8XbVG8wVXaaIiBEKWlOIHYnIqL86LXD2OGsYjT2WAQftzKsYBuW3dl41
	n8ovvIrzsqgErUvvqpJBRqU2M/yZ0Q9+JP6TXw7eH/2vNzNt90S04bNKs0gGbyNJli7uu/v9pkn
	8X+YGEsD0smxTpmHJ8xD5vr26d2povr2G613/TDvORmgcEHo6IYxgc9I8BfgetznGKYlLZPYgZE
	owZix1Fhe/vK/iby+qL4pRa9e5fJu356HnaLiYfGbq2abQ/XHGq9E+Fsvi0+nHO8X2z6XNOkR0c
	1VpS2EviuwjVVDvYzLxUJrbqvsWZwaIpiMz7aaXOylGyg/d8HcledHtRj3zrus+H7bcdIEuZ4wb
	7zXQ3hMO3lkWgdlm3PEhhh2N5oeLHL2JvTQHWboCdiEc/4bNdCT3r1cg/jOqNDaQfotWS/0qFOv
	RPSpaNIZonwc/90/E/grPVskp42GmKJobQ/The6R/sueu4Owxr12j6MCCjLUTV/iMd8vbLoZa/N
	EwCbtWH0RWcuCta/Fbj+8qClIdbkLcYa03qynMU/4sieIB7d/pMj6XC4JH83EvV+BC5fq8qIpZj
	lJC7npJdrbws4h6Y
X-Received: by 2002:a17:907:8d8f:b0:b9c:b3b:841c with SMTP id a640c23a62f3a-b9d7279bb5fmr1162103466b.47.1776202889061;
        Tue, 14 Apr 2026 14:41:29 -0700 (PDT)
Received: from ahossu.residents.sin.openfiber.nl ([88.202.160.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6dfd77f6sm445243766b.21.2026.04.14.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:41:28 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	stable@vger.kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: fix missing frame length checks in OnAuthClient
Date: Tue, 14 Apr 2026 23:39:59 +0200
Message-ID: <20260414213959.1028301-1-hossu.alexandru@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237975-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B09FD3FEA7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OnAuthClient() accesses pframe without first verifying that pkt_len is
large enough to contain a valid 802.11 management frame header:

- get_da(pframe) reads bytes 4-9, requiring pkt_len >= 10
- GetPrivacy(pframe) reads the FC field at bytes 0-1

Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
unsigned subtraction passed to rtw_get_ie() wraps around, causing it
to scan well past the end of the buffer.

Add an early check against WLAN_HDR_A3_LEN before any pframe access,
and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
offset to guard the seq/status reads and the rtw_get_ie() call.

Suggested-by: Dan Carpenter <error27@gmail.com>
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v2:
- Replace incorrect Reported-by tag with Suggested-by: Dan spotted the
  missing length check during code review of the heap overflow fix; he
  did not file a separate bug report
- Add missing version changelog (the initial submission was incorrectly
  labeled v2; no v1 was ever sent to the list)

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 90f27665667a..884cd39ec756 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -860,6 +860,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint pkt_len = precv_frame->u.hdr.len;
 
+	if (pkt_len < WLAN_HDR_A3_LEN)
+		goto authclnt_fail;
+
 	/* check A1 matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -869,6 +872,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 
 	offset = (GetPrivacy(pframe)) ? 4 : 0;
 
+	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
+		goto authclnt_fail;
+
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
-- 
2.53.0


