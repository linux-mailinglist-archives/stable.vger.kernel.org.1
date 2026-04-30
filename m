Return-Path: <stable+bounces-242005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAXiAlH18mnNvwEAu9opvQ
	(envelope-from <stable+bounces-242005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:23:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A92449E096
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71ECD303C401
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2183833CE92;
	Thu, 30 Apr 2026 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmBHV95e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96349376BD7
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530039; cv=none; b=pzH+oCTiV/MJnkFSHIiXfqUw8cwp9xykml1i0YWPA52iF7k15aJXaTIMi9tiTmCn2W8f8XImWBE4hiKjdOopOVlPPq92F/oTcseGrmCO1OGL58fHrD3DKa5ZWDfeIxmIoAZ9D/odbWjoZQSjs6mV8cTDDb349/74b4RdF0AYjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530039; c=relaxed/simple;
	bh=WoVUCUrfo2gwpqQRWaT4c9mJLRFmqHWrpaoGhQn80Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKnVaN1kuRRxugnRjhqrf0bK/yyAliiPxyqVJFFFuCXueeO8MwGEARSaZCpSem931plgs1mFWGRs4yAMqkWi4ntUGyuXZj1YsioB/eWLHPuvEFPt0xAH3XmI3U4DQO+wbgwvMM2cKbRIOtln+bSq5YG8+nINAWBhEWEIV/nAP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmBHV95e; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4486b5fcf3cso463277f8f.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777530037; x=1778134837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sV2UBVZcC8+xJMcWfLN7GQdGIuXPa9HMH6HdwJRVHxY=;
        b=HmBHV95ecCWCsvBZTkzngwPftEEvTs3QGvRVnwaDoTXDr3TJqbJ51mVZR/2HpKaN/u
         LGiGIPQQod5JIwTkW2WaXVMfCyjoBxIF6Bwi3YiSJknp8YyIBPTWyThJYLE5NPp859EF
         7aivl48KiyPS0sxwHbfbHOdOgtz6SWC5zOyW8I1XhPsYvxnfkL+VhPecmhkaIEZE7Wzm
         TwJMCTiJxlKX/OrhXE2qo39WAaZ5KAwp+S7o8E8KZvsWvBj3SlP1P8rddDuifLZNpO/O
         LK048H7sybWEOvjxJpUUx58mOgDHAsZgjkjajrTwegZEQnLpdXpec/u7Gl5cy9plM82x
         ljWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777530037; x=1778134837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV2UBVZcC8+xJMcWfLN7GQdGIuXPa9HMH6HdwJRVHxY=;
        b=LAQbANZfTxpfbnqWx/WqCOD0idA+bvbd8dft6rdIn8cvkTb13cwdyRhN/UGlpc6t6r
         l4JdtBpSsj1oA+hG9ABVK2476Vx76ipud011jeG7WKiDZlPWkejbQJzvwO8EAttbXgOh
         DBorWVwsPBA0xQAD/VyD1Cx9siGSCTMNCa+t3s+FzNlFEPSV4Os++WaCi0vW7icvtxk+
         Q/QQnGjQv0LL2cvhMokRHoPqZaEKnkhRpgJxWJ5DgXM0tqPg7AH38jgtcQ8lyoBTsXYq
         aACdmB5vYeHpKNFPOTkeNYp/bK1qZhBDvM3sKaGy4OeDFSq9nfLKg8dHAzDeoRHzbL4K
         /6zw==
X-Forwarded-Encrypted: i=1; AFNElJ9QsLMT7cboygA3HIoqZhzo3iTIN9UbzatWVC2cLa6kbnWJDDPZ9ZZDF7T7qqYeDCIKZTwyWXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Q6TZq+Bd7UWmUgQ+BYBDBhCXgRKoOVe9DuoIKEXJ+0sKViBY
	C59XpXKJTGIdpdLh+aMMmpnvmGYiLWOIFNZO2FbJ7V0VvU26R1JuF2H7
X-Gm-Gg: AeBDieuccLxhNJhAFQfsNBt43Q6EFo63ATrVlXA9nguwW60WoL27h+7tIu9bT8Ae21E
	8k8wtusuwgmeu8z5OL7yBJe1AUqpDfv3SEdLCZwpol81C2HHAgvjNNZnXqPHq8nOYA0LDJiT601
	X1tybOATHpZdlJgj6yRbbLmkWCldMYOk/tWv6pOifaL1H+T00moeS/A7zIcDHVVreTsgaOWwA/o
	FJ2Ch5bizrW2vyRFUApjmrRb2sQQ0NpSYBunqNID6Kfup8vsOowUKB8shOo9eLQdZRUWMt3buvP
	/LrCjbo3ncoWXcb66JDf8QwsKNo/jb99cGxtapkTUscu0AcDl8qPiX7v2Z1WNTjlS7D8aYrWB62
	8J3h7ff48cTNzoBmIM+AzY5ebkSTgOVNBp9dJmPFbuPqkfSUfsN+YPfVPFccqAzkFBywc8SI1tl
	n+wBPYkl6DN9WKywUqPUc78Z40WkmO7zTPFuQ7RSUXhW5aF/u3P0hElFEOMK+2HOM3zJaW5rR9m
	c5zuZjhvxqJMAaosTR4RgBjKYSv6WV+
X-Received: by 2002:a05:6000:288d:b0:43c:fde7:f1 with SMTP id ffacd0b85a97d-4493e0c3deemr2155856f8f.18.1777530036849;
        Wed, 29 Apr 2026 23:20:36 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481fdsm11373101f8f.8.2026.04.29.23.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 23:20:36 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: daniel.zahka@gmail.com,
	kuba@kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	raeds@nvidia.com,
	kees@kernel.org,
	cratiu@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] psp: reject packets carrying unsupported PSP optional fields
Date: Thu, 30 Apr 2026 07:20:33 +0100
Message-ID: <20260430062033.20428-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A92449E096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242005-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

psp_dev_rcv() documents that it does not support optional PSP fields
but never enforces it. The helper unconditionally strips a fixed
PSP_ENCAP_HLEN, so a frame whose PSP header carries options is
silently mis-decapsulated: option bytes spill into the inner packet
head and parsing fails downstream on a corrupted skb instead of being
rejected early.

Validate hdrlen, crypt_offset and PSPHDR_VERFL_VIRT, and hoist the
psph read above skb_ext_add() so rejected packets do not pick up an
SKB_EXT_PSP extension only to drop it. Both in-tree callers gate on
hardware-validated, opt-less PSP, so this is hardening rather than a
reachable corruption path.

Fixes: 0eddb8023cee ("psp: provide decapsulation and receive helper for drivers")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/psp/psp_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 524978dfb8fd..53d7e14c054a 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -321,12 +321,20 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
 		return -EINVAL;
 
+	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
+				 sizeof(struct udphdr));
+
+	/* Fixed-length decap; reject optional fields rather than mis-decapsulate. */
+
+	if (unlikely(psph->hdrlen != PSP_HDRLEN_NOOPT ||
+		     psph->crypt_offset ||
+		     (psph->verfl & PSPHDR_VERFL_VIRT)))
+		return -EINVAL;
+
 	pse = skb_ext_add(skb, SKB_EXT_PSP);
 	if (!pse)
 		return -EINVAL;
 
-	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
-				 sizeof(struct udphdr));
 	pse->spi = psph->spi;
 	pse->dev_id = dev_id;
 	pse->generation = generation;
-- 
2.53.0


