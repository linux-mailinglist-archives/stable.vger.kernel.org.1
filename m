Return-Path: <stable+bounces-249435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKgLCWK8C2q3LgUAu9opvQ
	(envelope-from <stable+bounces-249435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:26:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7935760CE
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4308308D182
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4A2D8DC2;
	Tue, 19 May 2026 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9ckhRst"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42482BEC45
	for <stable@vger.kernel.org>; Tue, 19 May 2026 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153789; cv=none; b=Vk3OOESafVzKK7P/ypWEExX/kqNygarZkvJt2JWj4xTR7TsVkEubrkb5krZK2Y7wTMs6UM/xWiXJwKDh2t+vAeubqk0uJ47auvq7snX1q1HHK/p8z9ffW6FVQZq/CvcwpY3hqqdDT+sWcjGLjRDRUSsevAk5r4QtBKZcKspvFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153789; c=relaxed/simple;
	bh=4vi/+e3xOXjw7xLTlUAikVPvzws2OAFyV8H8dZm6ePs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHXW4rDCltIO2gc916rrzFjsu1KgL69+J89ULlaqRzr7DwNyvvO3C1cy3xtFFIBolg1nAVRRaGVOHPhf73CpU2U5NFVM+dDItnYYU2p18Uq/TUP9/l7qiiStOtpUnUCeAF/3oNrmVMJif/i+zAS1Y/KsoouV8XPisf2IXK6NtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9ckhRst; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so34967025e9.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153786; x=1779758586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T0H92Yt0pUbOJ2kFSqG2xMZBSz8hScaz9YpU8JwLL0=;
        b=p9ckhRst6+1XMFm9y23i0fqGCcPZa2CBPI+F3LOwSj3X39O4YF9hfCOVpYuc6toS9R
         HzrPtQBiVc6siUEPv+mPIJkCLO1vtMfjHvqjTW3OlO1X8k+uDfgpnq6doXqMn9zOdjQw
         hpxY+mSQT4q9T5Jc2/Fm7A+TwVBH3h2gavynDLcCbOCjMdnUt+SOR5H5o9mlPrzqR5bn
         efYvrothcrHbHhs8FdzuAs8wLka/4VaeLr5iMUPLP1eRiG2DbdvX7ii63y8HA/dJseRY
         I1IFIIQf7g9roaOD5z17tUhhQz5TnZcAtFxXLuO7ptm9bZt+OARyqbiDncqlbPmLgTNm
         Xgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153786; x=1779758586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+T0H92Yt0pUbOJ2kFSqG2xMZBSz8hScaz9YpU8JwLL0=;
        b=sPF0H7/xqrJ80zpZ66KJchdZ+izbCTmYPzCnO4EmczuJAh+W5azKAr6Z6tj+yFqSo5
         oZMt4O908/65PQIOdDNuojzXzaoE9aa1xux64GhQWqc/8ccCKsmLLUt9DiQlftrNlMYg
         b7YtYVle0FuG1egljpRYEmkdBumTM5Y6ialEB2AO4LMIYK7oNgzJc2SshaoTaWAc94Zh
         IJBkpKt1J2RYJp1YvjeT4SHmC8XQFW1qdT5C1ouHMn/B7nWaMujo9LRbDPUiqCpcftJm
         bHWsvi+4iMaFaiwO4UJHxGXhPMR9QmPLUudpV+NVESNdPZIShhBb0yULyW42KbMDKLyW
         Qttw==
X-Forwarded-Encrypted: i=1; AFNElJ95EHdRRHGs6b1YvzmWWRUF8Xyw2wmRC9kJFbHj9Xz/gwZ8+b8ThJukUtk+dc/251mI94DRmKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9k9cEvmkr7TMCG+j/69g2PQLsPo9TFUBHM/abkSoa5HSbaz7
	ZaZVxg3XXqHGsp4s0oL9U5IMEHOl2Ok857gJS+ipU2iZaiwhIJo3JV0XXMhkRAI/5TU=
X-Gm-Gg: Acq92OFjnAFJyv/T/OLSAXuUbS6JizjPXZ51RtcM3jCQLUiOVt6NHFo0ixrJFborzbm
	KewAWzDZRliOtMa39n9+tGXZNxvarqBSsKrPdvnp4aw5VKa29myhYe6S4MjenR4mNGMOmwAkTQ/
	H+R3TMGVnAXRaYgOD2lyKk8TnRTkB/rWgrvHYb5h+0IWnuCC3+ZpngLgsWybRlnwJdel8kNgRMX
	d6xRX6G2GRHeqgCBpqvMqjTBU6O1TkT2G3HhEEXcN3JpXwN2aHReZH/8ZpIeIlMLnETmRdPUKi/
	7CQpueu4C5K3qbNJO1ssE9WiktWEZjJTZzgz+619biD4Im/VlcjWjpoXTcuEuZXfcaXftbUDEV9
	8RFezPUFQXAATnneb7IQ7FrwPgTeEGSi8S6ssC/Ox0kUIPy/Rr+cd7C1U15lz7mwnJVYsYxhed2
	Z5+G/QRhMo2wKLwcvye8u2+B8RnMIN0x8KB4q/7v5hvJ4Nqmq6bZtyvS9/ZczKYCNHqtrw7b3Oh
	g==
X-Received: by 2002:a05:600d:10:b0:48f:e230:2a1b with SMTP id 5b1f17b1804b1-48fe6630137mr219596215e9.30.1779153785784;
        Mon, 18 May 2026 18:23:05 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm44255416f8f.10.2026.05.18.18.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:23:05 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	david+nfc@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net 2/2] nfc: llcp: add missing bounds checks in nfc_llcp_recv_snl()
Date: Mon, 18 May 2026 21:19:37 -0400
Message-ID: <20260519011937.12903-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519011937.12903-1-meatuni001@gmail.com>
References: <20260519011937.12903-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,ixit.cz,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249435-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,nfc];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F7935760CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_llcp_recv_snl() processes remotely supplied SNL frames without
validating TLV buffer boundaries before accessing header and value
bytes, leading to three issues:

1. No bounds check before reading tlv[0] (type) and tlv[1] (length).
   When tlv_len - offset == 1, reading tlv[1] accesses one byte past
   the end of the skb data.

2. For LLCP_TLV_SDREQ entries, tlv[2] (tid) and tlv[3+]
   (service_name) are read without checking offset+2+length <= tlv_len,
   allowing out-of-bounds reads beyond the skb data boundary.

3. service_name_len = length - 1 with length as u8 and service_name_len
   as size_t. When length == 0, the subtraction yields SIZE_MAX on
   64-bit kernels due to integer promotion. The computed SIZE_MAX value
   is propagated into nfc_llcp_sock_from_sn() as sn_len, bypassing the
   sn_len == 0 guard and reaching subsequent comparison logic with an
   excessively large length argument.

Fix all three issues by:
  - Adding a header bounds check before reading tlv[0]/tlv[1].
  - Adding a value bounds check after reading length.
  - Rejecting SDREQ TLVs with length < 1 to prevent the SIZE_MAX
    underflow, while preserving length == 1 as a valid case.
  - Rejecting SDRES TLVs with length < 2 since both tlv[2] and
    tlv[3] are required.

Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/llcp_core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index db5bc6a87..da7c6377d 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1300,12 +1300,28 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 	sdres_tlvs_len = 0;
 
 	while (offset < tlv_len) {
-		type = tlv[0];
+		if (offset + 2 > tlv_len) {
+			pr_err("Truncated TLV header at offset %u\n", offset);
+			goto exit;
+		}
+
+		type   = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_len) {
+			pr_err("TLV length %u overflows buffer at offset %u\n",
+			       length, offset);
+			goto exit;
+		}
+
 		switch (type) {
 		case LLCP_TLV_SDREQ:
-			tid = tlv[2];
+			if (length < 1) {
+				pr_err("SDREQ TLV length %u too short\n", length);
+				goto exit;
+			}
+
+			tid          = tlv[2];
 			service_name = (char *) &tlv[3];
 			service_name_len = length - 1;
 
@@ -1369,6 +1385,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			break;
 
 		case LLCP_TLV_SDRES:
+			if (length < 2)
+				break;
+
 			mutex_lock(&local->sdreq_lock);
 
 			pr_debug("LLCP_TLV_SDRES: searching tid %d\n", tlv[2]);
-- 
2.54.0


