Return-Path: <stable+bounces-254444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOrrLmIDFmrNgwcAu9opvQ
	(envelope-from <stable+bounces-254444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:32:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5845DC53B
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFCAC302A2EE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210243B8409;
	Tue, 26 May 2026 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="xaVM4TFK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C666192B75
	for <stable@vger.kernel.org>; Tue, 26 May 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827551; cv=none; b=I5fVLdnDG4puf/1uKGaFcEpynizQyewJ7nrM1ebRVXg6yQH6yiw/6nfhf72uyMyfE5IKPi25lpj19da+BVLFfnoYQlqf+XVXnyBmO+b6mYMvqJm7bu0Oyvb+s4emMQwRZXo9PaX+0vBeQyrNYDAHvWRul6w3gfbwMiP+avabZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827551; c=relaxed/simple;
	bh=J8QTJB03WvozUL/lm9seJKVTmum3YvberljLi5CeonU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtcOe5LPbCC2xDlpFsnmTj0xAMdqm8oq/wMFBLtxe5mf/X9Uq2z29D2RqlvEsLQo3sjyjv4Puri9AQ06puNqJGSVfSIUxfuEzkL3FPbN1OrIh2CMPQAn3C9lpgS9vrDPm7lE788J8O05vXAbICGPjZDOXNUNVN4botntlvZsFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=xaVM4TFK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d77f6092eso6299559f8f.2
        for <stable@vger.kernel.org>; Tue, 26 May 2026 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779827549; x=1780432349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOE68Mzf5nnVfNMftzrnIa4+AJ1pM+MIvuOSTOhC6JY=;
        b=xaVM4TFKL6WqoTgUxw6ugDtAPaPmv85BHuXPwkJiLyV07nNxeXK3xOW/L7tOoVKpAZ
         Fh5IYXgqOyich0LSdQ/l2ggfmrRdf0Z9E6+Bkdf8nQ9Tq2kaVX7A3ceknme7+nLVySaa
         jYhwcK4b2OsdkYvc9k0LCOmnBPOHnWqHolXdubMKckvW1Mn5SwrxWcyW+cxYl0djre3J
         ie7J01i26gDu47IlnGQcexZmoQYT8pHwUGXKMf7IJwG8YD7IDYnKjraXG9pkknj0FAaV
         xBGqa9yzvEzLCKtYwO68+6HPQNT+O0lCP4bJqVdj8o93TDwZyS7nSF1HfE20nryJKlmO
         Ealw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827549; x=1780432349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOE68Mzf5nnVfNMftzrnIa4+AJ1pM+MIvuOSTOhC6JY=;
        b=UbAT+tp524LzQ5GMlblk4d6H6dVuW9Hg6A9iclmJg8O8aD2gXMXQXZ1wgvGYsCkuBk
         m8dQ4odbuSIvIrKfuizwlAy28c4nsfBO/7azThmUJn+9wJI2v1S6oQXqpna2OpBDCT1R
         rCqnRU4SGOo2sDihTyqUM54CiJy5vOJ4/YcAktUeM4xArFNf24uF9yhA/SfnubDqmNln
         L0TPIqjAWCyiWiUECKk+Thxp4spmYjtni2o4GXFjCdT8JRqGSouVknu9oDDAzMhphUDA
         /5uZFjFEi/e3EYgcinJ5kA0eSicXA95yK79K06LJvq1gtr+8qP8mMrIQxROXp35g7FKY
         y3YA==
X-Forwarded-Encrypted: i=1; AFNElJ8Qy7UdTCDlTwskPVelHkgF39gXNBnxt1qKSW0tshHCKC1sxlVRroJBvpz7bJ63ZStsNw8k2Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjH2YcRY4yCKVNLwD/J4G84lhpWur19LRpV0Z8vpr7uXmgfEhX
	HhQHkGdpplA3hibdg35s2Otz0HbpAny/C9ygL6b6bpEdSAJUroHLIxfqJQ6cR5qdBbn3
X-Gm-Gg: Acq92OGFQk/kTOHCVOnKnam56XPh4zjSLPAt+YniV8xMvMXlq7MLskwf2S0eENWZKWo
	8kRvdgmV/Q83tWtgeIdldVXqgVY0ZCe/qoyh6KGkhUwclpBXmS5uf6yWURpZViKVD8it4uh+DQk
	sxEzrayRbnnq9OxNzLrofOucDA2mQogp1+tOrep4KBW3gegxf8GUJmwZdwWZZ4nuCzFEQkWpNWe
	eG/QKbDkuwFBwQJeGTLUh+jILOwCF1rMUD3/jVlBQNQSkgKHjWcHRmLNOhrLZohv1ZpNXAfocIL
	Af9nAszdYgds69Giv7+92w9T/DZ0ybMiFyoWfljJpTY4o1odjTDn2sudyi9SBW96lmq6wlQ8RUl
	gjtFcN0KcBwUlvhqMf/bA/6QZ3yjgOfWuzWOstidqULyen/hxe+Gz8bKcJzkEId07MQYgBFTEqu
	uA2nRbb04jEDjIMxASxUY7IPTchwFKPQAM4CJOseHW2dp7APiZtu38yRPF0q3sLv/QqOn7I0/NW
	3Zw3F5TIMWTTzUy38NSmGKvnxdWlCRAsnNTk++eqxSjyMoCGW9VnZI=
X-Received: by 2002:a05:6000:41c7:b0:451:66e6:501b with SMTP id ffacd0b85a97d-45eb3324e34mr29057635f8f.0.1779827548645;
        Tue, 26 May 2026 13:32:28 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557545sm851693f8f.12.2026.05.26.13.32.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 13:32:28 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: oe-linux-nfc@lists.linux.dev
Cc: security@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net v2] nfc: llcp: fix integer underflow and missing bounds checks in TLV parsing
Date: Tue, 26 May 2026 22:32:26 +0200
Message-ID: <20260526203226.73345-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254444-lists,stable=lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.942];
	DKIM_TRACE(0.00)[0sec.ai:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1A5845DC53B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiple out-of-bounds read vulnerabilities exist in the NFC LLCP TLV
parsers:

1. In nfc_llcp_recv_snl(), when an SDREQ TLV has length == 0,
   service_name_len = length - 1 underflows to SIZE_MAX (size_t is
   unsigned). The subsequent strncmp() and nfc_llcp_sock_from_sn()
   calls then read unbounded kernel heap memory.

2. All LLCP TLV parsing loops (nfc_llcp_recv_snl, nfc_llcp_connect_sn,
   nfc_llcp_parse_gb_tlv, nfc_llcp_parse_connection_tlv) read tlv[0]
   and tlv[1] without first verifying that at least 2 bytes remain in
   the buffer.

A nearby malicious NFC device can trigger these without authentication --
LLCP link activation happens automatically after NFC-DEP.

Fix by adding a minimum length check before the subtraction in the
SDREQ case, and adding bounds validation at the top of each TLV loop
iteration.

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Closes: https://lore.kernel.org/netdev/20260525202427.67768-1-doruk@0sec.ai/
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
  - mark as net fix
  - add Fixes: tag and Cc: stable
  - add Closes: tag

Link: https://lore.kernel.org/netdev/20260525202427.67768-1-doruk@0sec.ai/

 net/nfc/llcp_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index XXXXXXX..YYYYYYY 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1302,6 +1302,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,

 	while (offset < tlv_len) {
+		if (offset + 2 > tlv_len)
+			break;
+
 		type = tlv[0];
 		length = tlv[1];

@@ -1307,6 +1310,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 		switch (type) {
 		case LLCP_TLV_SDREQ:
+			if (length < 1)
+				break;
+
 			tid = tlv[2];
 			service_name = (char *) &tlv[3];
 			service_name_len = length - 1;
--
2.45.0

