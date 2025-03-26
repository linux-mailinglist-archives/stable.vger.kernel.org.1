Return-Path: <stable+bounces-126774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D761A71DD8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285153B978F
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49B23FC48;
	Wed, 26 Mar 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5A+nwzo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB041F95C
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011681; cv=none; b=ldM0dqG/c5/6+RR0HnqktXs2olJ81qRs3n2zDSoYhsAEfD94ELLkrg1plAoWugmvG5WipX0V3iS4zBxhI2fbSL0P9f+DedvMYOYYG7NkVnjlv8zPfRqyT4UiwHUEPSISBePxwh3i9sLkVx1SV5bY9vkEVDTrAeSZmOU4YfnBtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011681; c=relaxed/simple;
	bh=AexSvWlmHb3iq8tWFg/K3hF7D0VegjcqBSF4i9oEUwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2BjaO88LjF4PLrRkJ0FIh45WjxrDJxkiZNou8PGo7o8RC7oJSkrqf6+3kCxhDHXLjQ97VpNxlJtsdIhUF39bstBAo+yiqseb2Lk4GnuG32WWUztTu9w+W4rYrkjE0EWl70qX0P43r/B5wj7YR0Ajy+7hQVE3Xe68lOk0PcaYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5A+nwzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617D2C4CEE2;
	Wed, 26 Mar 2025 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011680;
	bh=AexSvWlmHb3iq8tWFg/K3hF7D0VegjcqBSF4i9oEUwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5A+nwzo3FUDRiKzz5J+ikuLs8x51cPhfwQGNW9nU1SJD8y24xz7GiaRav2zReDXi
	 9mF6qkKXSRq2TgWPvFO6MYQDY3IHoM182jWX/GFM3+l7mqjBAXnEXJjE9VfxWPIV4e
	 WbFtKW5mROgpTfiuHcfmi8Q1iJafWQVKWx7A9RtHSyRpH5lwDfUShdqkA7yymMai8D
	 dOLq4Lr30iyRCbUIOfgaBolDyZ0wtPj8inj5zGNDhLB1br6OMQ7rRjevzGHI3lv3NE
	 lHi9gSE/fZ9qsuiKwH+MK0hjNGYH36/przb/9mkA/UkuGdJp9pVYPwmc4sHDWVDlUJ
	 +ZGnZzUQp0RuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Larry Bassel <larry.bassel@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y V2] virtio-net: Add validation for used length
Date: Wed, 26 Mar 2025 13:54:38 -0400
Message-Id: <20250326131248-41c90acd9dc54284@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326021702.2740484-1-larry.bassel@oracle.com>
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

The upstream commit SHA1 provided is correct: ad993a95c508417acdeb15244109e009e50d8758

WARNING: Author mismatch between patch and upstream commit:
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
1:  ad993a95c5084 ! 1:  0981f7566977b virtio-net: Add validation for used length
    @@ Metadata
      ## Commit message ##
         virtio-net: Add validation for used length
     
    +    [ Upstream commit ad993a95c508417acdeb15244109e009e50d8758 ]
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

