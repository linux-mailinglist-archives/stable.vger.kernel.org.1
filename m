Return-Path: <stable+bounces-151481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF07FACE736
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 01:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F7E1895D30
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063142741CE;
	Wed,  4 Jun 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="aEDCax9c";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="aEDCax9c"
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125F1EDA04;
	Wed,  4 Jun 2025 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749080039; cv=none; b=rhTEBBN41TuhzFHBpqdYOI3KIpKCd8maBd+UeLuVd3omw+4Rg7Ss3J+axmfdxwMDPXKAaj6q9jaG7+Ns6bDAQ0Lwf0lUiZo/IuOtK6fPTvNvM4EGYEjgNTTsQNQkO1Xos9x4289Fkz1U2FzjpVILyulS1e6xSPDFa6DYT+mD8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749080039; c=relaxed/simple;
	bh=6AVP6/waYBCSTk3eM287PleDofD4ie7z+SyLM+INe5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGmb22dLLh7ZQiTPsC4GCwqeyPdhjiXjKwar+mv+Fb67E8WNzObZQX3keAbXNdBWI0PQyXbryyXHALHFqLW3LBaHiz4V0omSrLMmApXRutaoW0S9ebAxWYZf41ac/kGqXlVL4gdmufhGRRgjx0bbHfGZ1mMtAB+qeolL9nm0C4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=aEDCax9c; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=aEDCax9c; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id D18E860750; Thu,  5 Jun 2025 01:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1749080036;
	bh=buGRw0thpo1INGuPHZSd/Mn4rfmS50BZCj2ylYCYOQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEDCax9cxuVki9r3O5mM0cHL+8wNxU1oQlyGzG52sNkgLciE7sB4D6UYYECQ7YYdL
	 xnO3g1iMvFG5+lgX3Jtwas+H8FJHcdw04HCgf7uXwezugXSg7yCoN5qkcBWcAApxwb
	 0YDQspsUKA2IB69or+/V3wE51oA0qN8p8nkCwHe7vOJJnGR4JQblDNHq2DAivF+4Kw
	 iZsI/8gr34GTDK45DSfXkLy/E1MDuE/ALal0cpS3mrL3eJlz6yo03VwMSx+3UJL8iv
	 lTsC3K3xLzUxPCPy5djle39H4STf36EKzCe7cCbnWoUiy36MJpdh37N7itAyicl0Tx
	 CzziN7heJzB+g==
X-Spam-Level: 
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 0E1AC6068D;
	Thu,  5 Jun 2025 01:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1749080036;
	bh=buGRw0thpo1INGuPHZSd/Mn4rfmS50BZCj2ylYCYOQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEDCax9cxuVki9r3O5mM0cHL+8wNxU1oQlyGzG52sNkgLciE7sB4D6UYYECQ7YYdL
	 xnO3g1iMvFG5+lgX3Jtwas+H8FJHcdw04HCgf7uXwezugXSg7yCoN5qkcBWcAApxwb
	 0YDQspsUKA2IB69or+/V3wE51oA0qN8p8nkCwHe7vOJJnGR4JQblDNHq2DAivF+4Kw
	 iZsI/8gr34GTDK45DSfXkLy/E1MDuE/ALal0cpS3mrL3eJlz6yo03VwMSx+3UJL8iv
	 lTsC3K3xLzUxPCPy5djle39H4STf36EKzCe7cCbnWoUiy36MJpdh37N7itAyicl0Tx
	 CzziN7heJzB+g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,5.10 1/1] netfilter: nft_socket: fix sk refcount leaks
Date: Thu,  5 Jun 2025 01:33:50 +0200
Message-Id: <20250604233350.46965-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250604233350.46965-1-pablo@netfilter.org>
References: <20250604233350.46965-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

commit 8b26ff7af8c32cb4148b3e147c52f9e4c695209c upstream.

We must put 'sk' reference before returning.

Fixes: 039b1f4f24ec ("netfilter: nft_socket: fix erroneous socket assignment")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Backport patch posted by Denis Arefev.

 net/netfilter/nft_socket.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 826e5f8c78f3..07e73e50b713 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -88,13 +88,13 @@ static void nft_socket_eval(const struct nft_expr *expr,
 			*dest = sk->sk_mark;
 		} else {
 			regs->verdict.code = NFT_BREAK;
-			return;
+			goto out_put_sk;
 		}
 		break;
 	case NFT_SOCKET_WILDCARD:
 		if (!sk_fullsock(sk)) {
 			regs->verdict.code = NFT_BREAK;
-			return;
+			goto out_put_sk;
 		}
 		nft_socket_wildcard(pkt, regs, sk, dest);
 		break;
@@ -103,6 +103,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		regs->verdict.code = NFT_BREAK;
 	}
 
+out_put_sk:
 	if (sk != skb->sk)
 		sock_gen_put(sk);
 }
-- 
2.30.2


