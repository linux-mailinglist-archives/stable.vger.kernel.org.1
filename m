Return-Path: <stable+bounces-233282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJU4LR3+0GkIDQcAu9opvQ
	(envelope-from <stable+bounces-233282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 14:03:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA8539AFF8
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E0630131DC
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E102D661C;
	Sat,  4 Apr 2026 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh8TYdTp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227C78F2F
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775304196; cv=none; b=ZmvzUXX8iNcwGo+FoyMEpPoLWsfvwDFnjQ0UIms0FDgJZx1ecBpFN0DQZ4ry8pzQTpO30QvK8FA2X63mqZb94MFwnay/3jzIErQWEnc0yV4O8Yw/Y3Owb/JJ+6WCIuPCx/weYylJu5HJsg5gu9mNL/J0ZxD+3ec0I3MGlkLsHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775304196; c=relaxed/simple;
	bh=eedoNAwJwYaHwcpnoaYa8ahQY44WwzEPaEBlIDppj6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kO/ceLV75McW8rHdqdnPDye4mjZn9Y/fFXm62eTvxQIh+N10RnzT1QIB//JWcHwh7NwWLUx+wYGTct8RIoxM3qQdF3aPhwHLu+8OfMFsRiwfnFSlvOiVEfMrsCVhO/43W0V37eEBlDVeImcfXmejEXFVua8uKPooA16Q419QmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh8TYdTp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486b96760easo30534675e9.2
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775304194; x=1775908994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Adrct6pMYPSwu3pxZgxpJsWW0ral4Y4beVwmsP0F2Ys=;
        b=Yh8TYdTprDvOS179Qp9q21Q5ORrt61z98HFoJomj9UWmfbjCs4KNsZ3fV4WItfLW8f
         N/cthdFdvnIxe8HxRJJL1NpssnImckYglGXcA+m1KsCNVgI2tNAuuGdt8OGvwGW9FL0u
         QJd1MbGe9F8J7cKnHrzq4BnskGxOaaXdvHBFeKfGg9RlBWGKr3EMZZknhgvDPRIQbPNd
         kEr2TS7/Jqz+3uqQnZxBDcw61OMAaUT9klB2VYo9lm5aA4CIgFp63YznfYw6wZULC6+W
         cikQJzTwIKGNTa121+dfqI8yWKdeNAFv4ITXhWcEKOK5LtZ2DSZViTs4Q7OqkOM2s2T0
         ZPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775304194; x=1775908994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adrct6pMYPSwu3pxZgxpJsWW0ral4Y4beVwmsP0F2Ys=;
        b=msvrbCV3y7f8D4f4sgPCugz+AykTcjdiic/n9MROwDmShdmFCZTyogM6bLF1y0u0UT
         XKrQSRWoxOdE/pjgkbfdRxgRbEf+rO+jiJG+1W2GORVm185nyFRAhy2TTJs48hau7e42
         kwyJknOFoUpgSlpG963ZOaE9Kml9mFZfOiICKKcLTMJUS+uxONTxVSP6ir3JjkV5Orjt
         Ks8KIe64vGIWB1AnlQmQQjx7S34zi4a44R0pyFjHIVWv8EjiACiFG10TSpAoNFCPmk68
         rsI/lDGLOmOrBGG9bVCerZ3xYN3paBfLy4Rqy3bVfp+MnGtE43lRX5LxOS5zy3J2q2aK
         ltGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV25FRaeLrYL6kP/t1caSGfDb8qGW/aqajJZ0d16MPtR7C1ZHG18bX5//PYVX4mjDiYNEH3VMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKEQi9muZNqnaoRPayZaBUL3Hr7A2jOK2ktG/6t1CSAC8uoIU
	wWAkyp8jbr4xmN1KmmtDE9vNDC8hb6SKqmB7cL+eoPKnwG1ZW0Un48+F
X-Gm-Gg: AeBDietcXQoRu8/VQRxS9oAScmWrcl+/g9RVzFdY3uNILenQ5n85+OagriC/nxKmSjM
	v05rIle14UH8ITCVJWs85l3Ukec+c4S6QiXPWha9NHaMbuv57ujM8iSAiRM/FE+0w0DqrwIGP5E
	DAAkmIH+d1E+ufw0vj06DeILYeet78CusLSqxBlyxvFjbbwl4ec2murIj/Rh0lBmh5jrgKwaZyB
	8dWfhmgxtX2/AubMw/ugkTtjqYQp85gaMgOoXnMRQFHpMO/dHZFxzmmJcP9Oqmq+8ElFU5/I9+E
	gP5Cq422S8jSgkisxF+fAg02Q7qTEKdaCgTxPXnbmYMFYdlmZo7a7XSo887Nfn1FqyGdv0aUmPc
	vBJNeum5ZScrLa9bUTe6JVUwIL62ZQhRE1qnnzMlPv5Hx/TpThsE2F1prqptCy6uEcgU3oyKPkt
	qG9Zbu1I5mGY4zuuCjqDXOWrOngeVA63KnWUfhyDYvyoNE1Fn+gOoPh3iU49v8Wk/xro+dUJsor
	hFkY+FY/7SS
X-Received: by 2002:a05:600c:c166:b0:487:338:b4df with SMTP id 5b1f17b1804b1-4889978006amr106725845e9.15.1775304193447;
        Sat, 04 Apr 2026 05:03:13 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d58e5sm25654623f8f.23.2026.04.04.05.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:03:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2 1/2] net/sched: act_nat: fix inner IP header checksum in ICMP error packets
Date: Sat,  4 Apr 2026 13:03:09 +0100
Message-ID: <20260404120310.88218-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233282-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0CA8539AFF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the inner IP header checksum when rewriting addresses
inside ICMP error payloads, matching netfilter's nf_nat_ipv4_manip_pkt()
behavior.

Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/sched/act_nat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index abb332dee836..cd1d299da57c 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -242,7 +242,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 		new_addr &= mask;
 		new_addr |= addr & ~mask;
 
-		/* XXX Fix up the inner checksums. */
+		/* Update inner IP header checksum after address rewrite */
+		csum_replace4(&iph->check, addr, new_addr);
+
 		if (egress)
 			iph->daddr = new_addr;
 		else
-- 
2.53.0


