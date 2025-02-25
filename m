Return-Path: <stable+bounces-119534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AB1A445A4
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8121216F110
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8897B18C930;
	Tue, 25 Feb 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSgrrcio"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE121ABAB
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500029; cv=none; b=VjbglPEblAzS22ay0xJmuxYWabur4brJ4/rERlFxbcoM9CXKk7qzRLCsKQFJ/zV6P8QC/B4abNObiAb+bO8wpwn7V59Euh+ttmMMJXLMfov1UFdWkWDjDUWuFix5uheMUkvPBkgQ6ZavQFoghjQzWv2ATrg7ZaUKlBY9N4BESkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500029; c=relaxed/simple;
	bh=TbsG2aVirU+JwSKkwSAs/u+TnEJBzT5QcOA7iuOIAPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOTPqkJPRx4vvXfW5YNueW9+PXQMBFNb2aTf8UqCvDcbHHc5X65GscCggOFS4pp4QvE+zPnsUmfu2+EXqqhnCaACHimtWNLjnECTvG1+k61v+A9F5I2I7IQrA85D6ZTpdnv6jfghcj3NVbeKrfeiiYyb4n9cBzsuF63DZLAm3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSgrrcio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A72C4CEE9;
	Tue, 25 Feb 2025 16:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500028;
	bh=TbsG2aVirU+JwSKkwSAs/u+TnEJBzT5QcOA7iuOIAPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSgrrcio7yIK3JpioZC0gOhH8xOZNBkvxtVpY8oXPsfJ1B3UQG4HuKDi1ca7hLPhz
	 mKOJqa2fNhalYLCde5wJ0a6w7d5ot+RXVzrogwD39CPNYnOOfO+t9YX0jR/xceKzWf
	 7g6eXYFbIfDJT2d2NEzItdwLvg7Y8rLahynPzzbtfRMg/i9SRKwIboA2acKA1UJKBD
	 0PQRMuuc4FnYKo7kvMB8ZNhrgrHHx6uUQFch72mM1f6UYz/b2FgVEoIKu3mPl00R+z
	 DmN2mt+XvmiksPBjJVbhZVlcurXgAYO3RiT+1yfZP4nHE0vfxa7dn82dfX/nL58cpy
	 8TLUbkxNITiWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rcn@igalia.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 v2 2/2] tun: Assign missing bpf_net_context.
Date: Tue, 25 Feb 2025 11:13:47 -0500
Message-Id: <20250225110429-9120aedc655f1a8f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250225-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v2-2-bc31173653b4@igalia.com>
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
ℹ️ This is part 2/2 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: fecef4cd42c689a200bdd39e6fffa71475904bc1

WARNING: Author mismatch between patch and upstream commit:
Backport author: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?=<rcn@igalia.com>
Commit author: Sebastian Andrzej Siewior<bigeasy@linutronix.de>

Found fixes commits:
9da49aa80d68 tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()

Note: The patch differs from the upstream commit:
---
1:  fecef4cd42c68 ! 1:  b00a96844be4f tun: Assign missing bpf_net_context.
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

