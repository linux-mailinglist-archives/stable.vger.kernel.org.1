Return-Path: <stable+bounces-119890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D2CA490B0
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A3B1892921
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 05:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB3C1ADFE0;
	Fri, 28 Feb 2025 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j54DANKz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029A25757
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718810; cv=none; b=ceNLmoXBBwQ7XXZE1rV/Lmm06ck7xvXlI33oj4iVx5GAK0mM5tWZ8jNFYYaW2SIkSFTGwli+tgutomXVegMk4AgJ8uxgs9/IUj/CFihgxg/KhRRTZQQiRqOQsVPtuVWi4M7pBxKiSc0iSWtXx/m0CKYiGy1bqNw9l+MsKPaKUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718810; c=relaxed/simple;
	bh=Dg1RsnO6HzERA1pt4EeSU3/xx//zIUwaARP8Y9tbZX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Umb9n7XsAfg0Oik31T0XOK/28frwshCehDtUDVkKwUeZNnBsX27tqd6uAAA6k3QYRjEo7rDb7BAepsjgEQzttCE1q5hiQdrsjVnsrHDUFeLvkwa5p1BKSWWaF9jcVT8v1nFJEr1Wi1Fw3O4+PPdaFTvrRaXeGEX7d3biYRVcT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j54DANKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A07C4CED6;
	Fri, 28 Feb 2025 05:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740718809;
	bh=Dg1RsnO6HzERA1pt4EeSU3/xx//zIUwaARP8Y9tbZX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j54DANKzu6dgLCNO9OnR/DGr2aqSEztUqKk/PmV4ylzerkrPdGcsxvo/w77ZMN1n8
	 X45LrYFCU/kenmBO/blBENZeORl+XYLRXyyuUVrkWQE/W5oE2GKKFQqzzkyCGP7NCw
	 NnB6aYhPONdBwlHo0IJmQLWjD/ym9vNhFQPsv3Lfk0qaYYQo4/+XRYQeWE6usReTlp
	 Px1njFQX43t7LMZ8FngauvcLa6d4EbIpQx8GoXpY34Sb+P30tM3JCXCHC1GyhRzMRm
	 OtZB3AzeiZkiLeAS1q4FTKudk2+JhmYaoVXHt2hvj+1Y2uHqVJ7Xj9B0rcKr9XGc/h
	 EW5r3oBbOqphQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 v3 3/3] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
Date: Thu, 27 Feb 2025 23:56:24 -0500
Message-Id: <20250227152512-f77c023b24e0437e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-3-360efec441ba@igalia.com>
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

The upstream commit SHA1 provided is correct: 9da49aa80d686582bc3a027112a30484c9be6b6e

WARNING: Author mismatch between patch and upstream commit:
Backport author: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?=<rcn@igalia.com>
Commit author: Jeongjun Park<aha310510@gmail.com>

Note: The patch differs from the upstream commit:
---
1:  9da49aa80d686 ! 1:  c6d34f018cdee tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
    @@ Metadata
      ## Commit message ##
         tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
     
    +    [ Upstream commit 9da49aa80d686582bc3a027112a30484c9be6b6e ]
    +
         There are cases where do_xdp_generic returns bpf_net_context without
         clearing it. This causes various memory corruptions, so the missing
         bpf_net_ctx_clear must be added.
    @@ Commit message
         Reported-by: syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com
         Reported-by: syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    [rcn: trivial backport edit to adapt the patch context.]
    +    Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
     
      ## net/core/dev.c ##
    -@@ net/core/dev.c: int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
    +@@ net/core/dev.c: int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
      			bpf_net_ctx_clear(bpf_net_ctx);
      			return XDP_DROP;
      		}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

