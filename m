Return-Path: <stable+bounces-126659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD622A70EED
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8BE17952A
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B09137750;
	Wed, 26 Mar 2025 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL4N2xtE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753797F9
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955815; cv=none; b=ouT7XHlAZPlu7KEMc3HguM4xh6dJR1wNv0265jyqlUXTX5HZsc3wFxfaCtqeAOeocPqPvlr26x8fv0pxSO6rgDEbR5KoSeGQYkZ4S13+9r3mG91jzVUzwlmWgD8mnSIxoDzbMBC+IvSREsv3Q7bu36VZBaaz08s7C2o1kxW815w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955815; c=relaxed/simple;
	bh=/l8OEmEOa9+PjEoyltf5JRrzMmllHFT8UwApTdfLVZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+Xab6EDSlikcWRQDoK50Qr1Qh6iLhOOWTJazaSSQkQ0k3eUN2M13yIsIzfod/JWI7I9t+xe1iBhoAYPXjQ+4szOKgTl2m89hU+DiLlU7Wca6LtfcEV3ElfdOdFVrnSConEM268o2wwuT9q2fqkVjB+lkFNI+UQ0hWQXnUaRJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL4N2xtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5EDC4CEE4;
	Wed, 26 Mar 2025 02:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742955814;
	bh=/l8OEmEOa9+PjEoyltf5JRrzMmllHFT8UwApTdfLVZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pL4N2xtErFFX4j2h1V1n2zJU9JXBePUBtPh52bGJ6KPPZeCmCux/8ysx6zY0RN53i
	 yQ5M8lQhzMPJ+Rlxt16yRCG+UUJIpWaV68nUZEmPCPPaurDoXkBJy76ZIBSX93i52v
	 6ygDumYFaw5IEjehIz50KcHeWy3gB76LxcOi1PWaB597JpyX/OZmCef1IpnW6I9esw
	 fGDF5CXzsHny2ap3RkuQlmSW1zV9v6xGJitLL4tBiVv95kW+91Mil2Kit1EW5NhI0p
	 tZwRWU3x7PECCVBHIszYebet6jPDsP9Dht0LC86CYVZBYKXD+VEOJ+uzhtbvsRJTuw
	 3iSTOcxcOqYgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	larry.bassel@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] virtio-net: Add validation for used length
Date: Tue, 25 Mar 2025 22:23:31 -0400
Message-Id: <20250325215012-b1dbc44d1f2f743c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325234402.2735260-1-larry.bassel@oracle.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: ad993a95c508417acdeb15244109e009e50d8758

WARNING: Author mismatch between patch and found commit:
Backport author: Larry Bassel<larry.bassel@oracle.com>
Commit author: Xie Yongji<xieyongji@bytedance.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (different SHA1: c92298d228f6)

Note: The patch differs from the upstream commit:
---
1:  ad993a95c5084 ! 1:  34cd3a563c1ba virtio-net: Add validation for used length
    @@ Metadata
      ## Commit message ##
         virtio-net: Add validation for used length
     
    +    commit ad993a95c508 ("virtio-net: Add validation for used length")
    +
         This adds validation for used length (might come
         from an untrusted device) to avoid data corruption
         or loss.
    @@ Commit message
         Acked-by: Jason Wang <jasowang@redhat.com>
         Link: https://lore.kernel.org/r/20210531135852.113-1-xieyongji@bytedance.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit ad993a95c508417acdeb15244109e009e50d8758)
    +    [Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 9ce6146ec7b50
    +    virtio_net: Add XDP frame size in two code paths]
    +    Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
     
      ## drivers/net/virtio_net.c ##
     @@ drivers/net/virtio_net.c: static struct sk_buff *receive_small(struct net_device *dev,
    @@ drivers/net/virtio_net.c: static struct sk_buff *receive_mergeable(struct net_de
      	head_skb = NULL;
      	stats->bytes += len - vi->hdr_len;
      
    ++	truesize = mergeable_ctx_to_truesize(ctx);
     +	if (unlikely(len > truesize)) {
     +		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
     +			 dev->name, len, (unsigned long)ctx);
    @@ drivers/net/virtio_net.c: static struct sk_buff *receive_mergeable(struct net_de
      	}
      	rcu_read_unlock();
      
    +-	truesize = mergeable_ctx_to_truesize(ctx);
     -	if (unlikely(len > truesize)) {
     -		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
     -			 dev->name, len, (unsigned long)ctx);
    @@ drivers/net/virtio_net.c: static struct sk_buff *receive_mergeable(struct net_de
     -	}
     -
      	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, !xdp_prog,
    - 			       metasize, !!headroom);
    + 			       metasize);
      	curr_skb = head_skb;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

