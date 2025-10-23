Return-Path: <stable+bounces-189076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79BBFFCDC
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072E53AA61E
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650152EB863;
	Thu, 23 Oct 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MYgfIPNv"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FB2EB849;
	Thu, 23 Oct 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207000; cv=none; b=jvFxrlmFLofFtAhALr3fnvzWAXkIhHiK9jg1VRdb9mt8Tiw6eUlb7U2beAwDVWZapmYmTABx1fcBywqDnN+tu4RBZBo2niTa8quQN66MCKO/Xqp8oOmEjQ0ubW1hxnvzSZ3ZapraZlJUyYOU7AP4NfxsAhWCjWFA52TBCterEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207000; c=relaxed/simple;
	bh=UMHvqXKAXLDewNQALGomwABCwZxZfH+IN/9gnJya+fI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=ij/48k6s2I9fFVxIHUzbUKjvzhesU85f87w7CxguelYGICqkYGuJxFbmgrIjy8aWaUFWVNyX9sk32/S9/IrxS9jutRDvAjbEpwqgokMzjaIBNzk5fgNbCnTt/qoKG684LZzsJ1OkgfJSWRis0vozPRnbND0k1CPK1x4bnP3EJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MYgfIPNv; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761206988; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=0pwkfXQbGk5Oqq1wZCavhvUj7jR9C8by8Jut+zAJHnU=;
	b=MYgfIPNvY1PihNggVFqC/poHpU3u8DaNEYW/1EoPFj1syMck3FRPHhlvTEdRWbOcVIqgNzauHSJzAQRf8KZ/dnZELxyWXoCNGN+KSQrW6clNxTu0VNy+zjTMS0+a4hGFDSjdxIKngnBlbnOUAyw3Eov8NC3XGvszBVqKyoVdAhk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqqL4XV_1761206987 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 16:09:47 +0800
Message-ID: <1761206734.6182284-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v4] virtio-net: fix received length check in big packets
Date: Thu, 23 Oct 2025 16:05:34 +0800
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
References: <20251022160623.51191-1-minhquangbui99@gmail.com>
In-Reply-To: <20251022160623.51191-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Wed, 22 Oct 2025 23:06:23 +0700, Bui Quang Minh <minhquangbui99@gmail.co=
m> wrote:
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
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big p=
ackets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v4:
> - Remove unrelated changes, add more comments
> Changes in v3:
> - Convert BUG_ON to WARN_ON_ONCE
> Changes in v2:
> - Remove incorrect give_pages call
> ---
>  drivers/net/virtio_net.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a757cbcab87f..0ffe78b3fd8d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>  {
>  	struct sk_buff *skb;
>  	struct virtio_net_common_hdr *hdr;
> -	unsigned int copy, hdr_len, hdr_padded_len;
> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>  	struct page *page_to_free =3D NULL;
>  	int tailroom, shinfo_size;
>  	char *p, *hdr_p, *buf;
> @@ -915,13 +915,23 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
>  	 * This is here to handle cases when the device erroneously
>  	 * tries to receive more than is possible. This is usually
>  	 * the case of a broken device.
> +	 *
> +	 * The number of allocated pages for big packet is
> +	 * vi->big_packets_num_skbfrags + 1, the start of first page is
> +	 * for virtio header, the remaining is for data. We need to ensure
> +	 * the remaining len does not go out of the allocated pages.
> +	 * Please refer to add_recvbuf_big for more details on big packet
> +	 * buffer allocation.
>  	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> +	BUG_ON(offset >=3D PAGE_SIZE);
> +	max_remaining_len =3D (unsigned int)PAGE_SIZE - offset;
> +	max_remaining_len +=3D vi->big_packets_num_skbfrags * PAGE_SIZE;


Could we perform this check inside `receive_big` to avoid computing
`max_remaining_len` altogether? Instead, we could directly compare `len` ag=
ainst
`(vi->big_packets_num_skbfrags + 1) * PAGE_SIZE`.

And I=E2=80=99d like to know if this check is necessary for other modes as =
well.

Thanks.



> +	if (unlikely(len > max_remaining_len)) {
>  		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
>  		dev_kfree_skb(skb);
>  		return NULL;
>  	}
> -	BUG_ON(offset >=3D PAGE_SIZE);
> +
>  	while (len) {
>  		unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offset, len);
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
> --
> 2.43.0
>

