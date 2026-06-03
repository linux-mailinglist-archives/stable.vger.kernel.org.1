Return-Path: <stable+bounces-260093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QB6ANF04IGr4ygAAu9opvQ
	(envelope-from <stable+bounces-260093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 16:21:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486563880B
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 16:21:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=qmHCz89Q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260093-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260093-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E90A307F946
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 14:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A0843DA2D;
	Wed,  3 Jun 2026 14:14:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A403AA1B5
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 14:13:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496040; cv=none; b=hACqTf+AHEFQRGIl5bzgRONHdVWhhSWm5xJ/yN64glmFjGUmTDyW3w2HeeKm4R5rfDOYcR7kx+56FT1WVZ8ZO8ZpNrlvp6RtPyoLfY16pvGKH2Ga6i39RQnRpL7eqiaF9UM8ChV2CAdMovtarjC8UgaZDM3tw2PWSdZ7P3ZIQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496040; c=relaxed/simple;
	bh=rltsMnPstES5O95K26OEKN7CoVBeKZdZbNkscQutuP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yzwu2Vyojo7rE3jqpbk2ZzgGL1qQrK0Q17hpzl2ICWGCwRKBQkwGHo5VqCkEGCmITE+g2ASocnjor74ZaPE6Y3x6vP6kvGRUiErmn2Qi27AVDhiuQofr7LUWzJPvaq8ZCMOPeZo4l3t+SvoTYgkYEOXLIohZNBze99rrUdUqFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=qmHCz89Q; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b613a17bso10324785e9.3
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1780496038; x=1781100838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjsRnZLZQ7estap9LmjUBhs1AGh/vTFeIsSLLUn4dTk=;
        b=qmHCz89Q+g/pg+3oeXfCXYnh9bdh5d186DzHO7wwxjQ8vDhT2wc9k72Xt3s5PXgDwy
         rzqrkTCJRVJyFY7bWcOHk909tFA3zAtIvQdOKwzILVrK8tRFbGYMo6thx0NUL4waolBi
         igzCtQbHuYWS88dxccZFYAvfJIdS5BHBsTWZItckPkA6z03lEWTHyUrOgdnaD4FTXGx0
         /cmV3RFGY2DC1Ed32py3H+IEB0UPqSfUzuOlzqwWG8KOlviKrkCJK0ZML4CSlajt7IN6
         K3m8eSfXHttSYbz6g8rQrNmhodoJqD7k/nkcsPERUDTGIu9CTOa7+DwXEsLnauGju5ps
         Ux1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496038; x=1781100838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjsRnZLZQ7estap9LmjUBhs1AGh/vTFeIsSLLUn4dTk=;
        b=lRBgzcLAHMUqbGIEN4bhCuvO7vPdbglWt+gyNTpEexCkH7i1ja0RnJjRQKoMmeML6m
         B0pReUIDEcNtddbxhJV83k/AXZiuV8y6vZ27xvBFzAPRQik7o3MVwIAlQM6vKCKuStPo
         k0HvefHI7gBjlngk0TPZqdNWLnsRQCBHX+YbBtWaXuFwieN21GHYzTUothipVeijsdI6
         PeJZwZS+pqHxq0nm8BnfE2ZyVw4lEfcxMwRaH6rip2voxK7IhoAc+sfNn0+YOy8dfb8g
         aqOy78SeYnQUzvDal1YR1DqB+XLxHsxrZMAj5u73VtjJd4tsrwwSR6F9/Q+ohQbyOttm
         ATcw==
X-Forwarded-Encrypted: i=1; AFNElJ+xkVzHlWfCiqczB4qxGWTFw+2K0+LuWGuAnxyzFhTHV9EjImzzuESV9iODiVaQOuLnaoUnmNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqD2pP8MOSYRjEh77p1jeUpVC1Vc8mUhnc7gEIVL7NSVHgaDza
	3LxRaIF2rY0JGfG0ybpeicP9wcnifxq2INAY3bGXYEFXWymRjAZTUPHdc1kyJ8uNCRMZ
X-Gm-Gg: Acq92OHTE68w3QZ9OTNyX+fFQtaE7XxMaUAkwKVe/r9gQVh75jmTpomLz/7DkGRlwVs
	/Bc7h4ZZJ0IIa8Q1Jf+s4qVrs1AzDjHkrnUibgvvYWzRGWmAGOn9ZGIQ0svLpGjwAjndKwjZ+b7
	AYxVGobMHhcB1D4MWqKvVy8qgvxGEpkqu17iRPGJT+NV9y0SiiOCA9PHfHevlIYJda5NmpfrF8E
	jqquhJN2DScqqYlZBzMsXmo7kjjuoFrbkKf4rfLJOdu9mriXsYG9CQeRW45pPGhdvclcYZ8vlnl
	tJzfJOc/cWmfr+PNz7XWR0f459LrH8Pw8Ydg/LC8i6J68lgJr0M2fGJzw3hFdTtFeeQ8M2Sl7zp
	fD0LLcdrrF7rzWsaKcFSl5qo1AyGIPuXG6yVQywXEUgqyXSW8lQyD8a9Wf7uscYiv3CJuQ+KFkk
	nLcG146SHcIbAzaPx1LjijKN1q7twIvG5Z7Ws9ZpZgNXpcaHSreKHNXbnPDRAOZ2K9SkH9c6/nI
	UjLyC9siicuzov6RdJmiMWYD/uLtPMTHzWZEc1kky8BZCokHM+Y7KEo3lDyYgUC2g==
X-Received: by 2002:a05:600c:1392:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490b5eaad68mr59903695e9.15.1780496037716;
        Wed, 03 Jun 2026 07:13:57 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b6d16f0csm65358165e9.15.2026.06.03.07.13.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 07:13:57 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev
Cc: Aleksander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: digital: clamp SENSF_RES length to the destination buffer
Date: Wed,  3 Jun 2026 16:13:55 +0200
Message-ID: <20260603141355.68156-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-260093-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:aleksander.lobakin@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,0sec.ai:dkim,0sec.ai:mid,0sec.ai:email,0sec.ai:from_mime,0sec.ai:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7486563880B

digital_in_recv_sensf_res() memcpy()s resp->len bytes from a remote
NFC-F device response into the NFC_SENSF_RES_MAXSIZE-byte target.sensf_res
field without an upper-bound check. A nearby malicious NFC-F device can
send an oversized SENSF_RES response to overflow the stack-local struct
nfc_target.

Clamp resp->len to NFC_SENSF_RES_MAXSIZE before the copy.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 8c0695e4998d ("NFC Digital: Add NFC-F technology support")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
 - Clamp resp->len with min_t() before the copy (Alexander Lobakin).
 - Add Fixes: tag and Cc: stable (Alexander Lobakin).
 - Frame as a stack buffer overflow (saved-return overwrite not demonstrated).
 net/nfc/digital_technology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index ae63c5eb0..ae6487c10 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -778,6 +778,8 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
 
+	resp->len = min_t(unsigned int, resp->len, NFC_SENSF_RES_MAXSIZE);
+
 	memcpy(target.sensf_res, sensf_res, resp->len);
 	target.sensf_res_len = resp->len;
 
-- 
2.53.0


