Return-Path: <stable+bounces-119538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89CA445AE
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86B5188C27B
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511018DB2C;
	Tue, 25 Feb 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRbOqjPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA818DB18
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500035; cv=none; b=HvX/EtVzTwcChmPC/0kzRIXT0nYaQhr4701ZsDoes8bNSiR2BsaESIAyajDNDpBiiNPKTNri4dCnoteSLIrGX8uIPTsSD/2UlXMwn+lZGOI07GfUlGZ0WjcL81/VUKws5ySztJdziDyQw8czyqOtRn3Midf1HWymt/Y7matHFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500035; c=relaxed/simple;
	bh=/pZ9zK6d6ZWmp/GlE+cKBE3wcUSr8bscVhK9BEA8zHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=od1QzStTRNIX9x78M/V1Z5Pp8efnkYTPvWziBypbQz7J10vE8rzzl6IhntdEdC9+Jq+I6jfqwTBrLygLyOP3+4xwKFPjmyTARAvpOOeXGZZ2hDYUnJXNp8tqIGL77YYIDpujokjRdFSl40WRe1YX+nTlJagsf1yrpAKrUvtmyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRbOqjPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E15C4CEE8;
	Tue, 25 Feb 2025 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500034;
	bh=/pZ9zK6d6ZWmp/GlE+cKBE3wcUSr8bscVhK9BEA8zHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRbOqjPjg/k5IgW8HWpPtJBRWJdqLKus3y7z4gGUKlLXSLDjwKvEqR1J2t8QR0HDZ
	 NVc5iR+DRJILH+9wtOutLlmH4bLZFO/VWlQEQ0NGsnneflziE5vdidYGgZzbWN53iw
	 nYpHiCRXF00u3PfwNvG0eUsda5xhVzHZ2o4aOq2BAz5TB5Hb2xC9GqEBHBdVPNInlU
	 iaXf/uof2NafjBcduqswz6U3bwKTwCBS4fOljJkjsVyWf+Xvo+DWCixjiZMfXhpckA
	 +ngJ3eB4dF0ZN8BjZ3NJjatQv+FwAgju66H9g+Qb1SAg6ZaIvk9VRzx6H68EsluzjS
	 lkmyQx/zvskUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	rcn@igalia.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/2] tun: Assign missing bpf_net_context.
Date: Tue, 25 Feb 2025 11:13:53 -0500
Message-Id: <20250225102057-3a1bd7b02915f4fd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-2-de5d47556d96@igalia.com>
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
1:  fecef4cd42c68 ! 1:  9762804adc3c4 tun: Assign missing bpf_net_context.
    @@ Metadata
      ## Commit message ##
         tun: Assign missing bpf_net_context.
     
    +    [ Upstream commit fecef4cd42c689a200bdd39e6fffa71475904bc1 ]
    +
         During the introduction of struct bpf_net_context handling for
         XDP-redirect, the tun driver has been missed.
         Jakub also pointed out that there is another call chain to
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

