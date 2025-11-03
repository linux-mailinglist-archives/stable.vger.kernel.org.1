Return-Path: <stable+bounces-192147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A3C2A1DE
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 06:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC14188F056
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 05:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4D28D83E;
	Mon,  3 Nov 2025 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s/88iQW+"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D828C871;
	Mon,  3 Nov 2025 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149415; cv=none; b=q86Q2oldahZxPkwT2M6bRqFrLDnOG1TUtC6qFzXNgWxl8mg5AvID+u79nI4y2IuMMIC5r6mGvr9pZIhMMkXt1cJVk/6ot916qmxvKA3TLqJIejSiJhtahh+X8topf82ml8D4zC7c7Vg4VqZLR+NWf3/y+FIkszsZn06w9StU+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149415; c=relaxed/simple;
	bh=UMPaZUWzV3Sm6RTTcZV+IfJzOzax8Ccpxq+TavsawBQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=VB6Ux3zdPivD9dZoMd6KuPl/JEBgyPnPC3j3Sh1aDvvNCKJ+g/eueUFyD292e68NNtK5LcuYPEl+SJ9jyY0se3IKVavnyrK7YSHeLSrASybHk/RyXNdtES0rxDk/+Wpe7wwxy9GcOCWPDOiuwkeTghcsELBG3w9HMEWxfjQfnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s/88iQW+; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762149409; h=Message-ID:Subject:Date:From:To;
	bh=Wf5UamBtc1C2iB7hfBSedWXwlFsIRhKJbTDCZQ1GFNQ=;
	b=s/88iQW+/Ol68Cbcq5mxlTeIt+MudLEXEbUbZp1PfzBL1nk92NpRGz5c1prUOpM2fY62NiPnr1+OWk+nffUKimxL6JaqSb8j5xsP2BZGdsqtrGax+5Mkg9rUq/hDWw2v+5bKqOLPjFZY4Q1iX9rY8+JoDP8a7Fqoq+Wyh4IX0Ic=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrXoEDB_1762149408 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Nov 2025 13:56:48 +0800
Message-ID: <1762149401.6256416-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
Date: Mon, 3 Nov 2025 13:56:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>,
 Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 stable@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
In-Reply-To: <20251030144438.7582-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Thu, 30 Oct 2025 21:44:38 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), when guest gso is off, the allocated size for big
> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
> negotiated MTU. The number of allocated frags for big packets is stored
> in vi->big_packets_num_skbfrags.
>
> Because the host announced buffer length can be malicious (e.g. the host
> vhost_net driver's get_rx_bufs is modified to announce incorrect
> length), we need a check in virtio_net receive path. Currently, the
> check is not adapted to the new change which can lead to NULL page
> pointer dereference in the below while loop when receiving length that
> is larger than the allocated one.
>
> This commit fixes the received length check corresponding to the new
> change.
>
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> Changes in v7:
> - Fix typos
> - Link to v6: https://lore.kernel.org/netdev/20251028143116.4532-1-minhquangbui99@gmail.com/
> Changes in v6:
> - Fix the length check
> - Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
> Changes in v5:
> - Move the length check to receive_big
> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
> Changes in v4:
> - Remove unrelated changes, add more comments
> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
> Changes in v3:
> - Convert BUG_ON to WARN_ON_ONCE
> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
> Changes in v2:
> - Remove incorrect give_pages call
> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
> ---
>  drivers/net/virtio_net.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a757cbcab87f..421b9aa190a0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		goto ok;
>  	}
>
> -	/*
> -	 * Verify that we can indeed put this data into a skb.
> -	 * This is here to handle cases when the device erroneously
> -	 * tries to receive more than is possible. This is usually
> -	 * the case of a broken device.
> -	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> -		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
> -		dev_kfree_skb(skb);
> -		return NULL;
> -	}
>  	BUG_ON(offset >= PAGE_SIZE);
>  	while (len) {
>  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
> @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> -	struct sk_buff *skb =
> -		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> +	struct sk_buff *skb;
> +
> +	/* Make sure that len does not exceed the size allocated in
> +	 * add_recvbuf_big.
> +	 */
> +	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> +			 dev->name, len,
> +			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +		goto err;
> +	}
>
> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>  	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>  	if (unlikely(!skb))
>  		goto err;
> --
> 2.43.0
>

