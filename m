Return-Path: <stable+bounces-188877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3251BF9E17
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C840E4230E8
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 03:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943F72D5938;
	Wed, 22 Oct 2025 03:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uQANblin"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67323958D;
	Wed, 22 Oct 2025 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105302; cv=none; b=fLNo//muyU/g/M0rLzZp/VORrM3+MGu2cZi7l4Ey5BnkFOlLNTdmRg0UL6w/Sd3mdLXNoX+SqoRZVGkxHLGP6QltWwyzo1CwbdxsMgjmY6sAycQ1rMue+0r03jabPWlg/MoflE1eLTlKx0uET1Z2/uL9RXBmj9Ars2UfjnN8lRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105302; c=relaxed/simple;
	bh=uQfk3Le9KERMMWm52SnZ/oM/1kH5gLp0h68A3u/zq7I=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=IcFYWIKXZ4YaMm2tPfAjehtJ0oHqR23QL6f8rTEuzWRkSrq0puhwxJD3vyyJ/s8PEfddGAJ1fZptqTFToBJC4gr9ZSCffesBSh4AQYEsHNXQ5vKahHJ4mJAV6Uj+AqggsiHJVr1mgVK4+ma/H99J7F8flBZgPKaZQJ3Oqt6q6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uQANblin; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761105295; h=Message-ID:Subject:Date:From:To;
	bh=S0LUDwuX2bVNX84XTQkfDh81t8I2QtGUEauu7kdK/QI=;
	b=uQANblin50gzpIj42XzDV45dJTF17+9iY/AHO+6jjvUi6MZ0J9pWu45pr5/+Jn3ZGlSPVY7RTLDpa7SsBNZ5Z3dRCYv5H6xlcoqOd2SNc0JdVptul8QcnVrfwXUvEwjhABa1IqliHBMKMcCXMs16ev8W0tbCNr2ZOM/CABMrKls=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqlI4cU_1761105294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 11:54:55 +0800
Message-ID: <1761105287.0200958-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net V2] virtio-net: zero unused hash fields
Date: Wed, 22 Oct 2025 11:54:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 stable@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 pabeni@redhat.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251022034421.70244-1-jasowang@redhat.com>
In-Reply-To: <20251022034421.70244-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Wed, 22 Oct 2025 11:44:21 +0800, Jason Wang <jasowang@redhat.com> wrote:
> When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> initialize the tunnel metadata but forget to zero unused rxhash
> fields. This may leak information to another side. Fixing this by
> zeroing the unused hash fields.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/virtio_net.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..4d1780848d0e 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>
> +        vhdr->hash_hdr.hash_value = 0;
> +        vhdr->hash_hdr.hash_report = 0;
> +        vhdr->hash_hdr.padding = 0;
> +
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> --
> 2.42.0
>

