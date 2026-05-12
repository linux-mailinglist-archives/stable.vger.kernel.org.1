Return-Path: <stable+bounces-246673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHJfCK2UA2q37gEAu9opvQ
	(envelope-from <stable+bounces-246673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:59:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126A529C0E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8633A305192A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5853C9EED;
	Tue, 12 May 2026 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4WGyJBq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219F3C457D
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619086; cv=none; b=a4e1CE9Z0wrUyCKJ1IK7CmnHAIBi8p16ZAkZ5/QD+CgYyq5z493e8V/xKiqlzrzmBMP3pqQlr8TgeEMvEcNB3BC8XZ/LNU1x++ILjRN+fEmJBdNhYcKEMbdPgnyT0HaY13mG1rC0W6WSuEAlXkXOn3tWw2Di0X4T8/P2zf+B+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619086; c=relaxed/simple;
	bh=SrGWi/6wHIXpn0Jzv1Nk8znKQrM+sdOspj2f3aHSYS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiElAuDJeTZk5txKWMby3dc2yvGMyFW7VvR7JdaN1HKpX5nXvYBPUOVOri/2BY3wE0fu23bx6GStl8nj200lOL29/KjAr8m1od8ax7ftnYxpKRx0Y/CUgxS2YvLDt67zLdG25bq3a1jTWnW/Ly+dDVLaO51VLZ6Co4yqhbiP4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4WGyJBq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8f15e900586so310819585a.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778619081; x=1779223881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gga6YQiahEkWcYcvgOogf9AGzn6VBTkh6VyNbP8w6hs=;
        b=L4WGyJBqW98rGzfUq48UkQf+sLoqqFqTRI8lsOY9ffyHrujzBc46X+w82lmEugol6+
         6CiCMw5AaJAXJs5x7AJiCKQczN/xlvzsFlEZjKHUMQ3smEUIVzrnvgaWzTAdQHA9rv/i
         UkQ/neWqYsrRVUtMWtK4qIsix3oaH4DCdYEMlcD9g8Bqt7i8MN+iK26pwgWncfW0i5Cb
         RWWQQHdyYfU/da8eXynlyL1UFFjUqO5ezHQ83AN3RGnBlKXMC/r0IU9wWzE0fT5KzeN6
         Ny06CFroIcEVNJhWVDcqv+QyQ13sSY1EOAApL4mXVfFcS45wNTi7cYVVrlcaOJyzpPoc
         n3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619081; x=1779223881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gga6YQiahEkWcYcvgOogf9AGzn6VBTkh6VyNbP8w6hs=;
        b=mcIX5iu7tpE4oxJf4sGCfQkPmhvMOvjBUhco4w6nidqq6453RZCL4trgAEhg1sCdSS
         FAvKiG95VzhDaAbL/LdTM0OjLO+dLoON9hzG36lmxqsHStmiP14HQXo1AiYUpJISdnGT
         vT90XVft2NaFpcZ28mNGpLM2vJ4GBySo4P5TyUDll3pn3AjZc8QttyvsWFUMygNQo91m
         2n6ocLKJRr+PLVbM36gz4Cj4Bgy3uVUc/tyFJHHMZo0SpkOlWy3D8UJhcUCTjOffzE/n
         miOx9XBZkqX5gMyFC0mUryxOt9c9w4b0/Y2pAWyVAK45FKC8OvGP5roKfQltjMfVFxth
         ex2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/vvvANsQKpEzRmkOwvIbiofXdPATkwIsvnArO8uHaBtM846Ulb6TLnL/K42/gVrIFkGOm1Dx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhEeNF83phmAs9BxNZriA/hc5E1V8OVAynRuXOOQNp5ltSWMP5
	WfZJA8Z67I/LeX2H8dITRVxXwd26nne4s3Sd1glJ5cr5BM2pXbeeaaD5
X-Gm-Gg: Acq92OERFoKXZsv4ru+y/DcobFwVdkYTD7ug34tQolbbOu962yzqaYV2sbzYBXOjRjp
	akXek5001gcSX2K11Wt+mMIciUeGrMvQM0GhwFw2W/258hnrYVx00sZiF5zFM9QEeHpw18eMCfY
	HuyiAn4ooti8f+GdhnrgapmfKMNi8YVcDhMvhWZhe3eeqjCpNUmeZQB7/jdWX2/RyeOTPI+1x98
	yAIxS+3SxUmOCKeBH+c8MGcI6/x4le3g0omPq62xFsqpndwfWom+KzyDenPd4i7CCTXNh+nYOFe
	1iLzijwLzMbFkFDt63076pP6UHro+/8ReVR7oExWfCK4zsXyQ/nyItlc73aI20KmTSjL0QdHHC6
	TVVcpWqvG4j24UtT1OPvtkK7n/OEQUV9MvWx0M1lR2L2tAkoWLlgozzJ5zUl5maiSpeEYiL1iDN
	n/22XLgROFQB26K1D211y2bpTSlsBSPECcFitxS8ebnqA2idEO4uuI1utaTID+R99KiLBP9DJ7K
	hcMAtpe2E780NC+xBIbV2z9tyhZBFcLkTED1K+F/iU2gbNnV213iw==
X-Received: by 2002:a05:620a:d8e:b0:90b:263:f6b with SMTP id af79cd13be357-90fabcf968amr11126885a.21.1778619080781;
        Tue, 12 May 2026 13:51:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9eed0sm1490734285a.19.2026.05.12.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:51:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Maciej Zenczykowski <maze@google.com>,
	Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] ipv4: raw: reject IP_HDRINCL packets with ihl < 5
Date: Tue, 12 May 2026 16:51:14 -0400
Message-ID: <77ec2b5e8111961c2c39883c92e8aa2709039c17.1778614451.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778614451.git.michael.bommarito@gmail.com>
References: <cover.1778614451.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1126A529C0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246673-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apana.org.au:email]
X-Rspamd-Action: no action

raw_send_hdrinc() validates that the caller-supplied IPv4 header
fits within the message length:

    iphlen = iph->ihl * 4;
    err = -EINVAL;
    if (iphlen > length)
        goto error_free;

    if (iphlen >= sizeof(*iph)) {
        /* fix up saddr, tot_len, id, csum, transport_header */
    }

It does not, however, reject ihl < 5.  For such a packet the
"if (iphlen >= sizeof(*iph))" branch is skipped, leaving the
crafted iphdr untouched, but the packet is still handed to
__ip_local_out() and onward.  Downstream consumers that read
iph->ihl assume a sane value: net/ipv4/ah4.c:ah_output() in
particular subtracts sizeof(struct iphdr) from top_iph->ihl * 4
and passes the (signed-int-negative, then cast to size_t)
result to memcpy(), producing an OOB access of length close to
SIZE_MAX and a host kernel panic.

An IPv4 header with ihl < 5 is malformed by definition (RFC 791:
"Internet Header Length is the length of the internet header in
32 bit words ... Note that the minimum value for a correct header
is 5.").  The kernel should not be willing to inject such a
packet into its own output path.

Reject "iphlen < sizeof(*iph)" alongside the existing
"iphlen > length" check.  This matches the principle that locally
constructed packets that re-enter the IP stack must pass the same
basic sanity tests that a foreign packet would be subjected to.

Once this lands, the "if (iphlen >= sizeof(*iph))" wrapper around
the fixup branch becomes redundant; left in place to keep the
patch minimal and backport-friendly.  A follow-up can unwrap it.

Note that commit 86f4c90a1c5c ("ipv4, ipv6: ensure raw socket
message is big enough to hold an IP header") ensures the message
buffer is large enough to hold an iphdr, but does not constrain
the self-reported iph->ihl.

Reachability: the malformed packet source is any caller with
CAP_NET_RAW, including an unprivileged process in a user+net
namespace on a kernel with CONFIG_USER_NS=y.  The reproduced AH
crash also requires a matching xfrm AH policy on the outgoing
route; a container granted CAP_NET_ADMIN can install that state
and policy in its netns.  Loopback bypasses xfrm_output, so the
trigger uses a real netdev.

Reproduced on UML + KASAN: kernel-mode fault at addr 0x0 with
memcpy_orig at the crash site.  Same shape reproduces inside a
rootless Docker container with --cap-add NET_ADMIN on a stock
distro kernel.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ipv4/raw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 5aaf9c62c8e1..68e88cb3e55c 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -391,7 +391,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	 * in, reject the frame as invalid
 	 */
 	err = -EINVAL;
-	if (iphlen > length)
+	if (iphlen > length || iphlen < sizeof(*iph))
 		goto error_free;
 
 	if (iphlen >= sizeof(*iph)) {
-- 
2.53.0


