Return-Path: <stable+bounces-267017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CDOABXWZM2ooEAYAu9opvQ
	(envelope-from <stable+bounces-267017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:08:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1B69DFA5
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:08:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DpfW2MfF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267017-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267017-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BFCA300BE80
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7A3BFAF0;
	Thu, 18 Jun 2026 07:08:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686273C0A15
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:08:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766506; cv=none; b=Dnfa4a1MkUUm9J9lwf5mGZimGcs2WU2Aec3qthnhWYAq6WSMYEts8FplXqquxx17Nv2HbC/qwBp+QL/SYcePKZpDzQwdqhCwgAKX4zYDc+cF58kGqEMw5r6+Cz4EsgUMQXVyJBldrxu6he588jjWGNEyML7yFtxzANXwlmMNeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766506; c=relaxed/simple;
	bh=58uM3rtyTYGrJdql0JMPbfvW8pN6bRpzfwVAFqj/23A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYKkEfTexaZ5CEPanlr6pZMhwKMXt6thYEbN2ME8rz04USkVZEjAy3y6JI9x4jUrcJ0LKEmLQ1l1COUJeJFhALRRBWmNA08JV2b7+Uum/5wh3Kjnd7nwazFk68dFVgEoIgRbvgbB7z1+kBjsc2gdVCefSTnwrVHhQBtAl8xzn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpfW2MfF; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84537777d45so486505b3a.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781766503; x=1782371303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=py7sFiyEu3cLvtrXZwVU5OC7C9L/ey2Xp/3aJ9X4rBI=;
        b=DpfW2MfFsoKFQNj79hnZd/J2SbGupBFK/98C5qsLA7G9L+tpVqgDO/kVflyRVQAWEt
         2nq8CqXArnAC7Olk/t01L7PFEkT2VdLGeUlns9TUsTpTBDeLcFdIJH3Et8qdSDECKo9k
         VEpD75r1ZhsM0IRndNfas08hBDTVK+T3iRYh637JAfR4z/gNseyX30pLeFxQfcqeMtxf
         ZtJ6Aa/HYLUAdfImbfKVjeuWHOLWfajuGFI2E98XF/pBjC1qGAmqYMO5XZu+pLFC5Dat
         1dWDJ78OCv2Md80wR+T3IWCKYqNFuTaYLALbE/h4sgNLyccCcED8jwb9pmL3WfzB9se4
         Z02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781766503; x=1782371303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py7sFiyEu3cLvtrXZwVU5OC7C9L/ey2Xp/3aJ9X4rBI=;
        b=ig0PRsrnbyQdCn5Whfed4gYqTf1ESc8+0CQzgZamBvwJunderNGCb7zjM/cH/QGR0A
         9jUzdlOAje0cGDsp/4VubhhVZUE3uYU8JyA/vWyi7vOrwoBIjC1TgKHW1DadqTnGBUTL
         GJtkLmLd07Isc4wO2mXwcwkBxDX69T6TxjDAYwEOQ2mYaw860vPjAO4iUm+5FDAneAQ9
         IUBErunvSPJt4vItwQSe4NpoNQXTAnpKIHCE//Ws3uKYHFoc7AneG2fzmUnblgfLKYcj
         A6s3ejyIlzgpTLOWJufmhBBHxc3rGCWwOZ5Wia7/uPLSczvpjizUcQgwiChlKrr+Vy15
         mpYg==
X-Forwarded-Encrypted: i=1; AFNElJ9vKFhaQ65dJqFX0T2aKJNrdV6wJBZOKT23fqKUfoRlWiNASnOdHkgb4J6aVZv3Ggw/HeLkTZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY59A2LSUjBo4WQRzHLMZB1VxO+h0kDr9fumzT07gLP3U9Mt1H
	/KMbKNu108/sfAkg+fb2236EB7YHCzdYxwrxKzgKZsl5HkYDvOJJ7VdD
X-Gm-Gg: Acq92OFbhifatkCBs7KTmg4GZFApJLLZcymlDjoaIL44d7R9Py9miSKNoYLIaJEensK
	irkDm4fSQHLwFU81if1NXRSUHCf9LADx8YBw+JYSxQVyQHXGj9rWS3yVO+frG7v7OJP4qMCvSYD
	bQPs3MPq5dUS4CKgmH3qKLOTF1/JRxOTHc9M5ZA/ZpFKUKB6vvAJvmnvdoCdV7cIV86kYbljRr6
	1rJLhdkswb9IZqrDO5f7zrgnRyrBQX1b4mXl2aTe5DibL4GTaosyg2ls2FqV/qQ4wjx6pcgNzJr
	fNwl6yH9x27DO9VjXy7Dad93Yudt3PMpOJ34oeAbob0qVx8D/MA2Cj7nYDt2TUautLqyzjEqAra
	pUfUVFJvxkRoqyTqrILZp2rmSe5h8XFnvLqnOVmzDU41s7CtrVf5j4IpawdClBjaq9xe3U6lNiO
	o0H1ANaLd3558K9VVp36YbX+Uiaox4yJah9oL8jQ==
X-Received: by 2002:a05:6a00:298d:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-8452457b4acmr7920016b3a.38.1781766503669;
        Thu, 18 Jun 2026 00:08:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84531dbbe7fsm3132263b3a.14.2026.06.18.00.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:08:22 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: sit: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 18 Jun 2026 15:08:17 +0800
Message-Id: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267017-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:nicolas.dichtel@6wind.com,m:kees@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,6wind.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29D1B69DFA5

ipip6_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ipip6_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed. sit was the one tunnel type not covered
by the recent series that added this check to the other changelink()
handlers.

Fixes: 5e6700b3bf98 ("sit: add support of x-netns")
Link: https://lore.kernel.org/netdev/20260612085941.3158249-1-maoyixie.tju@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/sit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 64f0d1b..a38b24f 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1613,6 +1613,9 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == sitn->fb_tunnel_dev)
 		return -EINVAL;
 
--
2.43.0

