Return-Path: <stable+bounces-189903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5BFC0B92E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 02:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 844474E55AB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A7237A4F;
	Mon, 27 Oct 2025 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OhXaW/x7"
X-Original-To: stable@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94623645D;
	Mon, 27 Oct 2025 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761527517; cv=none; b=fhrm4+gXB2LgEL/miqI/JD5mdyLVUzgzTZBhC0HK6aiBRva7AZfHpdvZ8n8JjsSPNcBNa0mr99/vGb1lU7l5x76T4kLnc/SL9EQOJLR5QOiRpDgaNWQ/iJgFJYV6sA58PacbRTnS98iYeJ2lvdMf5wARodK5SIOkCXuP/FGLxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761527517; c=relaxed/simple;
	bh=f0FbD/KBEVC/wmzpqn+qUp2CmfbQCTx+VZi6wwEc2Qg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=fDmKVCl0RIfnqJa0A5PxXZBOvXqEnTwNGG9A0ehOqdDBS93lOmxhCijfDkh5LMSTa9tHHCpN/THLZL+LaKFPUECUI2RWhvqUZsNwhzEfoyWAwxZMNbrFju7X8oWNsRK+DB4rYVP2CWDzEeZsvEwWFqc9Y70FYtx080tTylt9b8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OhXaW/x7; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761527505; h=Message-ID:Subject:Date:From:To;
	bh=sjBcHr5ZOwGk5Nuy3x8242YaFWFprMrxE6xIBZsgAP4=;
	b=OhXaW/x7UKJDHdqr+xCF9Eh/EnFParWCLS71xAHhBe9g8rS5bRoG7qj6/xfrzzMUY6ePOAEhX55nQqsF1zHOjr7kXjTuMobNeVcUDkGNNqMztJ8aFWrSkKuV0Ln/ZJVS3M+b8JCNwU306O/fXiObKojJJ/pcB3gN96HbheE7Baw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wr-QfaA_1761527504 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 09:11:45 +0800
Message-ID: <1761527437.6478114-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big packets
Date: Mon, 27 Oct 2025 09:10:37 +0800
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
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
In-Reply-To: <20251024150649.22906-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Fri, 24 Oct 2025 22:06:49 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
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
> ---
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
> index a757cbcab87f..2c3f544add5e 100644
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
> +	/* Make sure that len does not exceed the allocated size in
> +	 * add_recvbuf_big.
> +	 */
> +	if (unlikely(len > vi->big_packets_num_skbfrags * PAGE_SIZE)) {


I think should be:

	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {

Thanks


> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
> +			 dev->name, len,
> +			 vi->big_packets_num_skbfrags * PAGE_SIZE);
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

