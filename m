Return-Path: <stable+bounces-153161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E142ADD2F3
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898C81884B92
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A052F2372;
	Tue, 17 Jun 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gU23LdFS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684B2F236D;
	Tue, 17 Jun 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175075; cv=none; b=r0f5ph9guxoVJhcgSq3txsFk7oTBZyookpwtGN0ImRhV8C0wJr0i1f2TvlSZCpnTAMOZUNA0mcBqhmHWjPfzngpFC23mTweukjRL/2Q8KFzvreoUy7wT2f4lK4nCo/dDlp5Swbc7UyX6sVhDIh+ynbX13u3w/oHjVdMdVTp/3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175075; c=relaxed/simple;
	bh=PiK9sN0lSxlpSIpcmN94pgIawLDXoVAxdbW/RfzrFpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiK4E1pWM7zzjHZ75II0y4mV0Vu9RDyWgHnZg3V/guNr0IMHoT86GoqD/Uysx3FhyODpwqtQRBfv9HL3cVC+RcDtoy6KHEz4ppWGJixMzoCdlrqWfano1ghZJH0e6mWublSh7ZGzqpGXxCYdQ3S5K8krI17lRjwo7AUcsqKXlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gU23LdFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73D2C4CEE3;
	Tue, 17 Jun 2025 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175075;
	bh=PiK9sN0lSxlpSIpcmN94pgIawLDXoVAxdbW/RfzrFpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gU23LdFSYYdM/XuwIwstLLCO/LRygdQfhrGqd2//cbafh6UivNKOOkKdw/T9BGyeG
	 2AGK/Ed93FGyXuKnr9j0JDyeR8kIynNH7KHuQqW9l1TJCmR5tkapl/Z3zmPBMWmmC4
	 E9d46fPcbtFKnPPRI5jfezHjfzCuiA8FjjritEj8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 141/356] netfilter: nft_tunnel: fix geneve_opt dump
Date: Tue, 17 Jun 2025 17:24:16 +0200
Message-ID: <20250617152343.917874844@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit 22a9613de4c29d7d0770bfb8a5a9d73eb8df7dad ]

When dumping a nft_tunnel with more than one geneve_opt configured the
netlink attribute hierarchy should be as follow:

 NFTA_TUNNEL_KEY_OPTS
 |
 |--NFTA_TUNNEL_KEY_OPTS_GENEVE
 |  |
 |  |--NFTA_TUNNEL_KEY_GENEVE_CLASS
 |  |--NFTA_TUNNEL_KEY_GENEVE_TYPE
 |  |--NFTA_TUNNEL_KEY_GENEVE_DATA
 |
 |--NFTA_TUNNEL_KEY_OPTS_GENEVE
 |  |
 |  |--NFTA_TUNNEL_KEY_GENEVE_CLASS
 |  |--NFTA_TUNNEL_KEY_GENEVE_TYPE
 |  |--NFTA_TUNNEL_KEY_GENEVE_DATA
 |
 |--NFTA_TUNNEL_KEY_OPTS_GENEVE
 ...

Otherwise, userspace tools won't be able to fetch the geneve options
configured correctly.

Fixes: 925d844696d9 ("netfilter: nft_tunnel: add support for geneve opts")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_tunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index d499eb3f4f297..3e3ae29dde335 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -617,10 +617,10 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
 		struct geneve_opt *opt;
 		int offset = 0;
 
-		inner = nla_nest_start_noflag(skb, NFTA_TUNNEL_KEY_OPTS_GENEVE);
-		if (!inner)
-			goto failure;
 		while (opts->len > offset) {
+			inner = nla_nest_start_noflag(skb, NFTA_TUNNEL_KEY_OPTS_GENEVE);
+			if (!inner)
+				goto failure;
 			opt = (struct geneve_opt *)(opts->u.data + offset);
 			if (nla_put_be16(skb, NFTA_TUNNEL_KEY_GENEVE_CLASS,
 					 opt->opt_class) ||
@@ -630,8 +630,8 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
 				    opt->length * 4, opt->opt_data))
 				goto inner_failure;
 			offset += sizeof(*opt) + opt->length * 4;
+			nla_nest_end(skb, inner);
 		}
-		nla_nest_end(skb, inner);
 	}
 	nla_nest_end(skb, nest);
 	return 0;
-- 
2.39.5




