Return-Path: <stable+bounces-85172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B099E5F5
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869A71F217BF
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0841D90DC;
	Tue, 15 Oct 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k9pJm2zh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48D15099D;
	Tue, 15 Oct 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992217; cv=none; b=uWO6Qk1S2lE8NUBDpRcPC+jbxGT8R+Csp6Gmrp40RYYnTyJm9xqGAM35jGMBv6XopBCc38H/82RruiSYMoPKtXBRb7fiE13ubzCigAE37SmJOPOH9qejwwcff7g0niQE2ohUmuCKTsl0uB0e6TZ+Hh8+BhAwLsr/lR3a4LouNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992217; c=relaxed/simple;
	bh=K9Zbzz69cavpPM38NjMlsQPFAimrq+XmAqztNxdjk4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsH6jXWdYBR0WJujFnMdGXOd6E+azkRZS7uy8m34UGKPx+FDDnpnwswlB5DwUSp4nGOcIbiLOkGFS1Uvic+UV7d2pfImvBWNk/0c6k3rAAU4sP//KuXaQgicdqTQOg12Ak/ExV7KxrImo8pxYToksZMoGIhMg92qfKuFrqrZQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k9pJm2zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7F5C4CEC6;
	Tue, 15 Oct 2024 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992216;
	bh=K9Zbzz69cavpPM38NjMlsQPFAimrq+XmAqztNxdjk4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9pJm2zhjnHk77L7pLVRzeA2DfJ+186Noo8so+f62ttqGQFWb2w9xcvpNx621/c3P
	 7yxx0MTlirm1OsjDS9ypn2RKUS0A8Ur8E+4RZf1G6Fu2KXv9XUC3SsTEI3rskgwkya
	 tzSYhxt2N4fYRyPEepdjO/fnXbz8VLZGLgya9QiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 053/691] netfilter: nft_socket: fix sk refcount leaks
Date: Tue, 15 Oct 2024 13:20:01 +0200
Message-ID: <20241015112442.451313605@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 8b26ff7af8c32cb4148b3e147c52f9e4c695209c ]

We must put 'sk' reference before returning.

Fixes: 039b1f4f24ec ("netfilter: nft_socket: fix erroneous socket assignment")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_socket.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 3c444fcb20ec..3cbfb6ba32c7 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -108,13 +108,13 @@ static void nft_socket_eval(const struct nft_expr *expr,
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
@@ -122,7 +122,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 	case NFT_SOCKET_CGROUPV2:
 		if (!nft_sock_get_eval_cgroupv2(dest, sk, pkt, priv->level)) {
 			regs->verdict.code = NFT_BREAK;
-			return;
+			goto out_put_sk;
 		}
 		break;
 #endif
@@ -131,6 +131,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		regs->verdict.code = NFT_BREAK;
 	}
 
+out_put_sk:
 	if (sk != skb->sk)
 		sock_gen_put(sk);
 }
-- 
2.43.0




