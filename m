Return-Path: <stable+bounces-233173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEYMA1mez2kTyAYAu9opvQ
	(envelope-from <stable+bounces-233173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:02:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96687393785
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05151302623E
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E823242BC;
	Fri,  3 Apr 2026 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA7zDbdd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA62DB7A9
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214164; cv=none; b=nZAsxcERaDhvNQLYSjBfVHGbtyxe71sK/JD/R++RIZls/s2eURgeznf+KY0wHUcLLMHS7xcqYZ78RudlN15BvPLHyAai7Ot8A13UcDfVizbZerPTNr9/ZkvLJeq4VjS+mVRjMtRu06H+lZiHS3AHD3eSPDWlxBSjyXcdAZLbdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214164; c=relaxed/simple;
	bh=eedoNAwJwYaHwcpnoaYa8ahQY44WwzEPaEBlIDppj6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXPsihVvw7NevhlFR6hJAtuGX6M9vOcYS7dkIFCNl+7plSpmQ2737a0rmhaTne/jsJD/OmXjL04OqKCUp5DqGAT7LsjAuFV0FCFoo/cfohFUbLn5inEgF4+o6xXgnM2TRhWuEtld84bc03BFS0/MEd1XdQEA61tdVTlQD2Bx+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA7zDbdd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so3115975e9.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775214161; x=1775818961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Adrct6pMYPSwu3pxZgxpJsWW0ral4Y4beVwmsP0F2Ys=;
        b=kA7zDbdd/WVQ4Xx/q55U/dn1i9eFgYKUiJ511MB7LYzhsrkw/nZk5aDMbW33rP59Lk
         EVmBdMyA05nLQSe86QRJcLwMrHkBtoB7k5mnNic2toVIA/5uGSFZgP5tvkW65J2Q6Q7G
         OPyRx4bL+xDFcpII5yvbJ9XQNXiMVFbHB5EJB3acnlKSygiMhudrkv8LhbYLnwt12LwK
         tKNPanZEXE477mtVoXzCmkLVNkprcaIblo8uEEOrkNgAK78bHKCXkCwUAjFVFIkQC0Pa
         ed2r2ofVdWTtgvn8h/easI5qusjQBsuo4ieTgaCJMz2Qlb4VnpwPhLD4j5b16LGw/KnF
         HOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775214161; x=1775818961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adrct6pMYPSwu3pxZgxpJsWW0ral4Y4beVwmsP0F2Ys=;
        b=H5/OU+QmCFf0V94bzmsyCQUu0q4RuiyxXaP/ftwcpOVnm7u/JzSahyW+3qNfbaM6fz
         oPrBhTuKFgeEIsvsrBkbyUkLRk5wkiRIh703rFURYlmjsqzi+3Zr/TtAk5loe+0c49gt
         Q8H6hX5liAQWTava1AxrNz2fLjonrInqmUPr5kaR+rGS+YjiATXH0JAz6M63EBU30VRq
         vqH/U0U+a3ek9/g9ULsMiE1xWP/cfhtopuju2RydoxtC3PDXBiDxJ4lcsmgl7/VeORih
         gi1LB2kB6MDlLoD0w2IUUPxLgqud1TXJ9KLL7gnZY+OVSjZtk33nwl5Iez5y9JN3BQu+
         CWoA==
X-Forwarded-Encrypted: i=1; AJvYcCVYNXkqzePsT0YsQz0EIPeLkBEP69+4CIcOCmrvRqlrCWe3kA107rho3KwsNuv1Iu0esDhPASs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIQ1o4QAhib8l43aEOByI+zvzdQSJyrK5PoO8XNj29Qn34x/8
	tZgKbuUsT5aoIM+jSnbm4uK50/qZzPg+qf0CvAjnBCKa/8woeNV6M8JP
X-Gm-Gg: ATEYQzyI9R2FVkNVgf1K75GnF7OID0Wna5yZ/ay8EYoScE05WxNuYl1p0Xj8EAlio71
	nP6OglNNgYq7cVjd/IQS2T943TyrFILmsnj1jWzNO//oGfGDpuEkhVruslysfd25sc0myE24l10
	/9nx0TVeQxH7ZbNJwQVcvGI0Y6FYjDbGSkenJ0xQ0gYfgkKBabu77as8RjcBqaHXhxAi1+0yVL2
	5tRGJvlIiPifYloHH5bK7ccpKtmRJx6yG2a5/2DYCRcjL2Td0t+q74C1TV53j5cDe36fwRSSzXd
	ChbbNzwc+WV+KUQOZZDt2+TXrtETI9qAdKkmdzUfnV8qhrJACp1dnQi4jCqdoe7k0dfBEsjVLoB
	ye6+NuhR+tW0HBJC5Wserk+bQ2jL9PINJ+fvx7yaUS7yEL+y3DYAa3Rzn9JuQsgGhD7nEql8o4B
	D76fsKJE3KzIdXPQg/5jq6kbKVfyVndh/oBtodIfORAI92rJo4tCYmLN699DCBaA6e6b4miQnpz
	qg20V9rVeUyE8WHME5gOyo=
X-Received: by 2002:a05:600c:8b33:b0:485:3fa9:358c with SMTP id 5b1f17b1804b1-488997b2291mr46130995e9.17.1775214161385;
        Fri, 03 Apr 2026 04:02:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm18108325e9.12.2026.04.03.04.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 04:02:40 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: "'David S . Miller'" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/sched: act_nat: fix inner IP header checksum in ICMP error packets
Date: Fri,  3 Apr 2026 12:02:38 +0100
Message-ID: <20260403110238.16596-1-devnexen@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233173-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96687393785
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


