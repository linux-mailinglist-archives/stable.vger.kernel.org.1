Return-Path: <stable+bounces-119794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCDBA47509
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFA53AD915
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712ED1E5216;
	Thu, 27 Feb 2025 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+fQDpJc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF61E8355
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632903; cv=none; b=qAYfJtiH95QFfaZKu2U0795iAGJJiZzyr4iAYyCfrMlNJiOSA5/Anv/JEz7XfqjI8r/rxSoRdW+cKMf+mAY5pQJiNPgD2NdHIfvk3oDrZ3+07zJvZ5tINDh79rY2+6NB2gisITYXBxh6ZYgjlh8RxBXY+nw8nRg9gOcRSFoHQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632903; c=relaxed/simple;
	bh=Q0WcUwsbgFyCPGraCumCb8obRBF4xSwo9og7fyZ4l8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3Uwe2HbtfjD/WVEujunA99bGNs45GwmBgCkT+AQQpr10MpIYGziJUvN53AkJ5z+fxOnKNpUA6xG7384UU8wWjDh0pvMyFdyM2OYRkoxIyUl5xfpMnF8r55uo5P6+lumMsfIxlbM4+C6fBUKT8SyAyuGzhHxhmRj12HKszwMa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+fQDpJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5648FC4CEDD;
	Thu, 27 Feb 2025 05:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740632902;
	bh=Q0WcUwsbgFyCPGraCumCb8obRBF4xSwo9og7fyZ4l8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+fQDpJcmAB7ePCZlxtjmkMQTgx2TTYzcl4lGlALS59LcjujRNGwNld67oPdHgw5l
	 MA7J19EybfcT+f5bCRUE5KtQIkzJeUUwpi0arTeCjC9WBNpR2DQHG18d+ifV2qUtxq
	 pSeLknxEiSPkUyD1HxHWLNV5aPaok55MMSgGmZtp96dBN9ZKdHN1TWzspAJN+t1Lf8
	 9UxzMqWlbsO+DmhwwaLyDlNuwZD5Z3aKqq+O46L1hywfeu6pEeVKJCfoXhUzK3ePHk
	 g1OCQtv1GdRsYeSQ4+18yQxJmGSBcbhgQ8HavsxEeYCWAh2uhalVZDDFaCYBa+4Wfo
	 Nb2bj4tRlgxRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rcn@igalia.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 v3 2/3] tun: Assign missing bpf_net_context.
Date: Thu, 27 Feb 2025 00:08:21 -0500
Message-Id: <20250226153714-51148a08a89df8bc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-2-360efec441ba@igalia.com>
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

Summary of potential issues:
ℹ️ This is part 2/3 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: fecef4cd42c689a200bdd39e6fffa71475904bc1

WARNING: Author mismatch between patch and upstream commit:
Backport author: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?=<rcn@igalia.com>
Commit author: Sebastian Andrzej Siewior<bigeasy@linutronix.de>

Found fixes commits:
9da49aa80d68 tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()

Note: The patch differs from the upstream commit:
---
1:  fecef4cd42c68 ! 1:  d614f795c4a67 tun: Assign missing bpf_net_context.
    @@ Metadata
      ## Commit message ##
         tun: Assign missing bpf_net_context.
     
    +    [ Upstream commit fecef4cd42c689a200bdd39e6fffa71475904bc1 ]
    +
         During the introduction of struct bpf_net_context handling for
         XDP-redirect, the tun driver has been missed.
         Jakub also pointed out that there is another call chain to
    @@ Commit message
         Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
         Link: https://patch.msgid.link/20240704144815.j8xQda5r@linutronix.de
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [rcn: Backport the patch to address minor differences in the context lines.
    +    These differences are introduced by upstream commits
    +    4d2bb0bfe874 ("xdp: rely on skb pointer reference in do_xdp_generic and
    +    netif_receive_generic_xdp") and 7cd1107f48e2a ("bpf, xdp: constify some
    +    bpf_prog * function arguments"), which change the parameters in
    +    do_xdp_generic() and in calls to netif_receive_generic_xdp(),
    +    kfree_skb_reason() and generic_xdp_tx(). These changes aren't
    +    significant to the purpose of the patch.]
    +    Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
     
      ## drivers/net/tun.c ##
     @@ drivers/net/tun.c: static struct sk_buff *tun_build_skb(struct tun_struct *tun,
    @@ drivers/net/tun.c: static int tun_sendmsg(struct socket *sock, struct msghdr *m,
      ## net/core/dev.c ##
     @@ net/core/dev.c: static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
      
    - int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
    + int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
      {
     +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
     +
    @@ net/core/dev.c: static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
      		int err;
      
     +		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
    - 		act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
    + 		act = netif_receive_generic_xdp(skb, &xdp, xdp_prog);
      		if (act != XDP_PASS) {
      			switch (act) {
    -@@ net/core/dev.c: int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
    - 				generic_xdp_tx(*pskb, xdp_prog);
    +@@ net/core/dev.c: int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
    + 				generic_xdp_tx(skb, xdp_prog);
      				break;
      			}
     +			bpf_net_ctx_clear(bpf_net_ctx);
    @@ net/core/dev.c: int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **p
      	return XDP_PASS;
      out_redir:
     +	bpf_net_ctx_clear(bpf_net_ctx);
    - 	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
    + 	kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
      	return XDP_DROP;
      }
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

