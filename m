Return-Path: <stable+bounces-249013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJtEG0ybCGoGxwMAu9opvQ
	(envelope-from <stable+bounces-249013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:29:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96E55C99D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C51301158D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4F3E8349;
	Sat, 16 May 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXrDPRPi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F43E7BA7
	for <stable@vger.kernel.org>; Sat, 16 May 2026 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778948928; cv=none; b=kGHOSTjiiSH/nq5AX0YvryodDGMTCM91/3skfKnytRAdBt4bEvYx6C2hOQw0S8gfEmyXOHv+DXkqnTtO+bZ/pNnxv4ycwbsfYRObfPiXxu99CqAK6tgwcwIBjOv5XD5hZJHxhXcBzNzovBCKiBce50BqnJjdRq2YVSJpadrYFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778948928; c=relaxed/simple;
	bh=pXzVi05Nvzq7KtcKABClEwFyw7Z7ai29Ibsb5P/+O1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkpBFAihjzRL8tEonhZePTpf+foN5DW1l2P6+xhnLi9qhpVVPxkTVoUDFc766KuPsmgQecdxzgSi4ZMLhWTbIHeTNMYHCoXqhdmydvjF176H04BFmpDj+SymJl+EagTxJCUVpreuMIK8MQNDBD4IfVMrWYFW6tPCbWCn4Tmq1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXrDPRPi; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ba0714574fso4829435ad.2
        for <stable@vger.kernel.org>; Sat, 16 May 2026 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778948920; x=1779553720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1X2IDixBF08B3l+TKvtHORswI92gaIf4/K71809VYGg=;
        b=PXrDPRPirL8aYGbfWgBcZnINvbz84FhY06rrYL24ksUh7yoV4dnNb0cueIm/Jf4vQr
         C7xlgiKDQNSvGJnRwuXgUewoiQapWwK6O6zFyP+3NCiU0WLt12twSpz9t4rIoK2j6MA8
         T4X0Z0YjPNuHtAnpOitb01DWQlWFkeSj+IeayJsKsd6f5IlJthos+IjcL0c0wt5AjLqw
         pOy6oumLUcuhf2gsAHHNG60D0D6wZv8QYwroiiQBq6lkdxe1/scOT49Zv/FhbP8LQPYA
         Q4tD/2PsckJLgN7rqmTmYlNcpS6Akc8GuNtKk7NmHMmwoavcaUCttHfhtyO0X1COU3SJ
         H1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778948920; x=1779553720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X2IDixBF08B3l+TKvtHORswI92gaIf4/K71809VYGg=;
        b=QpLLPZ9uR/zWLDvtOIAbQRAnabcB384WedtRsJbTLN88I3QxKtunuLwZQM3gUa/tqz
         ilQOKsAMPnyb/gC8GnIKWdVfWMLzo41kpVpph+HSII4jmQKT4+HAkb7k19fJrE/aaQQu
         8SUcok4gp5TKZAMQlt1r9kDZXFI2XRIyexDxsl5TXOqaFgNXBAt8kovDrPJDfl7ZeQ7M
         fsAAG+qC549RdviqIylbodzqOkI5F/DOuTv7TLoWx7oMLI64tU3CChnF+nOO55UYkV+I
         bToq0X1hflMH78SUe12W+Sj4NBoCSphEcLSgBnHDpf2Vmzg8ENqbbiUAY3awpIsRYDVN
         inQA==
X-Forwarded-Encrypted: i=1; AFNElJ9fkCJUsDKqwJYv6YfuINAu+pB0qBp03gNb/YRjjLscku9zQMtEpM5ZzFoFgI87aL5MOi3kSB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxydDuq3e12rRbh1AyMKcwZP30iqsbK1qSK1n25pNGoKAQrkau
	N50p6fkUYE1igJrngKsguqkqUwTkH2I2CG80+dUZeKbKCd0AGpf13dLG
X-Gm-Gg: Acq92OHz25Qc7Kn8DebYpRjfV3FqTWXlyC+pivOIvRXOImGAwIPOdR2nz9OY5hD3hd7
	sygPghG0Lqj7ub8UNZh87MelU79K4XHTVWtAHyOccx/e6cFi00dEjkM4BcvSfFhsk0JqSuTrKb7
	OX+TstP+ww1XKk+s7aO/2Wihx8z3bi6exaNu6NKDx5kqn5YslXa2issNZwPzEo4LFhSgCryEWMj
	Y9F+MSogcA0XYG8whvPZTZ64+zJPvLbek31/horJVlMgKlIZbL9485z3OQA1iNduguRbhqLWaPN
	8V831tWMKxyLoMgz3ZLTCAVeySHwp8Szvg0wA1UW3FnhQFNJyaTRuoFC6IHJvaLIYFu8crrdqL3
	jjr4K2h80UY4HfusfZJmQoCKJU+Gcdash1jZKceNfG3t8AowQksDg19QZ0bAxegKSbZhK/uCNG3
	V/XIgFgODQqHsZ7Mijw1xut29AMcnUPbc=
X-Received: by 2002:a17:903:248:b0:2ba:bfc:76a8 with SMTP id d9443c01a7336-2bd7e8a5f58mr91920005ad.16.1778948920198;
        Sat, 16 May 2026 09:28:40 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5ef27sm122916815ad.8.2026.05.16.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 09:28:39 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/sched: act_pedit: extend the writable skb range per key
Date: Sun, 17 May 2026 00:28:25 +0800
Message-Id: <20260516162825.1480113-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE96E55C99D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249013-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tcf_pedit_act() builds a rough writable prefix from tcfp_off_max_hint
before the action mutates any packet bytes.

Since 6c02568fd1ae, TCP and UDP keys recompute their L4 base from the
current L3 header inside the key loop. An earlier key can therefore
change a later header-relative base and make the final store land
outside the initially ensured prefix, where it can fall back to
skb_store_bits() on skb frags.

Keep the initial estimate as a fast path, but grow the ensured writable
range from each key's final computed write offset before loading or
storing the edited word.

Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offset")
Cc: stable@vger.kernel.org
Co-developed-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
While researching recent page cache bugs, we discovered this bug. We confirmed it allows overwriting the page cache of read-only files via splice(). We haven't attempted to write an exploit, but the corruption primitive is verified. PoC available upon request. Recommend fixing ASAP.
---
 net/sched/act_pedit.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a27890..58a8eae6d43e7 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -398,11 +398,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 
 	parms = rcu_dereference_bh(p->parms);
 
-	max_offset = (skb_transport_header_was_set(skb) ?
-		      skb_transport_offset(skb) :
-		      skb_network_offset(skb)) +
-		     parms->tcfp_off_max_hint;
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
+	max_offset = min_t(u32, skb->len,
+			   (skb_transport_header_was_set(skb) ?
+			    skb_transport_offset(skb) :
+			    skb_network_offset(skb)) +
+			   parms->tcfp_off_max_hint);
+	if (skb_ensure_writable(skb, max_offset))
 		goto done;
 
 	tcf_lastuse_update(&p->tcf_tm);
@@ -414,8 +415,9 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
 		int offset = tkey->off;
 		int hoffset = 0;
+		int write_offset;
 		u32 *ptr, hdata;
-		u32 val;
+		u32 val, write_end;
 		int rc;
 
 		if (tkey_ex) {
@@ -451,12 +453,26 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 			}
 		}
 
-		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
+		write_offset = hoffset + offset;
+		if (!offset_valid(skb, write_offset)) {
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
+					    write_offset);
 			goto bad;
 		}
 
-		ptr = skb_header_pointer(skb, hoffset + offset,
+		/* Earlier edits can change later header-relative offsets, so
+		 * grow the writable window from the final per-key store.
+		 */
+		if (write_offset >= 0) {
+			write_end = (u32)write_offset + sizeof(hdata);
+			if (write_end > max_offset) {
+				max_offset = min_t(u32, skb->len, write_end);
+				if (skb_ensure_writable(skb, max_offset))
+					goto bad;
+			}
+		}
+
+		ptr = skb_header_pointer(skb, write_offset,
 					 sizeof(hdata), &hdata);
 		if (!ptr)
 			goto bad;
@@ -475,7 +491,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 
 		*ptr = ((*ptr & tkey->mask) ^ val);
 		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
+			skb_store_bits(skb, write_offset, ptr, sizeof(hdata));
 	}
 
 	goto done;
-- 
2.43.0


