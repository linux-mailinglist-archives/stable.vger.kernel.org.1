Return-Path: <stable+bounces-150598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D48ACB958
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53F63AD72A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45034224240;
	Mon,  2 Jun 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcaVFxX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043DB223DED
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880872; cv=none; b=mlW8+NP+7JWlBeP7+P1UiNNVkpb9SRnqd7+XdbQ1khl22+WQHG1dTI/kDpOSff15yAxgzDxfUutK4HRlAxgDmu2hpw6HheePrnOJZMgt+kekGSaqsTirEnXfG/GMVLpvRnj1klP3PhPdsJUnsj5bHsuAaeptjtlKXKZToruI1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880872; c=relaxed/simple;
	bh=O8stFtvuZHAYMRqZoZPzmmmNavIppFXJmjX6fCSTJwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2mO7dXBw3Cg4YrQNv5s5GsivrVWbqfY0kv3mMiT9oeXAPzgP9GkX8y5x/53aaPLPa2BVICtURODzdYQMRE2X1vCxhKNSfFDGJYO0dhpLL9StVN2lJIZ/s5lP433wgLjB3syp8Nycw8fwtGrw1+/Vu4ScT/X4Y7jevR5Z7r3+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcaVFxX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1688AC4CEEB;
	Mon,  2 Jun 2025 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748880871;
	bh=O8stFtvuZHAYMRqZoZPzmmmNavIppFXJmjX6fCSTJwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HcaVFxX1Qy2xAJEoJXnJGeB25U0Crt9o9Np0n6h3zAuuTcN0dB8dwi1c9KFFcEsQv
	 XgQktAPoHdLnh7hH21rHNFS7dWy74Jz8RUyG9GPBjdbPpu7qsPKEV+BCF30t9CUoA+
	 ccOvXOOnyKoSykoQi5AMFCwzZaMy26C3fOpuEnS2Ub0/oxtvEywhXg/hfXLsT8LNIC
	 87NAE6E/DkFJhGKZ9PxHA20AkR3Rg2gcgeKd9QULf4cKAcVQqc06Px56Qinvk9t/7f
	 MBqPSFCoZquNFTdN1HarewBcf2xQ9xe/Ig9pXMkscmab+7oNsGDMeT0v2QRy/CGZNa
	 KPcsyC3w8gCEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Denis Arefev <arefev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] netfilter: nft_socket: fix sk refcount leaks
Date: Mon,  2 Jun 2025 12:14:29 -0400
Message-Id: <20250602092354-c959a829b6d0673f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250602123948.40610-1-arefev@swemel.ru>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 8b26ff7af8c32cb4148b3e147c52f9e4c695209c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Denis Arefev<arefev@swemel.ru>
Commit author: Florian Westphal<fw@strlen.de>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 83e6fb59040e)
6.1.y | Present (different SHA1: 33c2258bf8cb)
5.15.y | Present (different SHA1: ddc7c423c4a5)

Note: The patch differs from the upstream commit:
---
1:  8b26ff7af8c32 ! 1:  a2677efdc7b71 netfilter: nft_socket: fix sk refcount leaks
    @@ Metadata
      ## Commit message ##
         netfilter: nft_socket: fix sk refcount leaks
     
    +    commit 8b26ff7af8c32cb4148b3e147c52f9e4c695209c upstream.
    +
         We must put 'sk' reference before returning.
     
         Fixes: 039b1f4f24ec ("netfilter: nft_socket: fix erroneous socket assignment")
         Signed-off-by: Florian Westphal <fw@strlen.de>
         Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
    +    [Denis: minor fix to resolve merge conflict.]
    +    Signed-off-by: Denis Arefev <arefev@swemel.ru>
     
      ## net/netfilter/nft_socket.c ##
     @@ net/netfilter/nft_socket.c: static void nft_socket_eval(const struct nft_expr *expr,
    - 			*dest = READ_ONCE(sk->sk_mark);
    + 			*dest = sk->sk_mark;
      		} else {
      			regs->verdict.code = NFT_BREAK;
     -			return;
    @@ net/netfilter/nft_socket.c: static void nft_socket_eval(const struct nft_expr *e
      		}
      		nft_socket_wildcard(pkt, regs, sk, dest);
      		break;
    -@@ net/netfilter/nft_socket.c: static void nft_socket_eval(const struct nft_expr *expr,
    - 	case NFT_SOCKET_CGROUPV2:
    - 		if (!nft_sock_get_eval_cgroupv2(dest, sk, pkt, priv->level)) {
    - 			regs->verdict.code = NFT_BREAK;
    --			return;
    -+			goto out_put_sk;
    - 		}
    - 		break;
    - #endif
     @@ net/netfilter/nft_socket.c: static void nft_socket_eval(const struct nft_expr *expr,
      		regs->verdict.code = NFT_BREAK;
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

