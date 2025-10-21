Return-Path: <stable+bounces-188324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29EBF5FBC
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24154854C3
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B22F3635;
	Tue, 21 Oct 2025 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHwOwlpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99890217F33;
	Tue, 21 Oct 2025 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045433; cv=none; b=oSsx4UAQWVAOT+R7JJiI93yOdFTxexzOroDj0ShvJVCJc9+0ozhxVQvyOKg4XB08jtJO5wGJnOVwrh24Vo5KUwKBOrPkkze8DKvgDz2kALb2BnaT4aB0SIh61wNfIRjNsisUtLjBuX7JUo7/X8bAuZ70GZP4lFI8HJgjSH6p+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045433; c=relaxed/simple;
	bh=gJIwZQiL4zI1GIryusrRwtuwJs9WkUU1wLaU9aw+LR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdzs6fq2zjLHnblxwBYljHDbnrqY5Ty4q0eVDH6MnIKjyRrDuR3iG3mES7y0QRYpYqwpsdV/cVOaS6HvC7tOLIgKM0XSrNmhUaZYgZve7WpFCqhQbGjn9d9R1rELtxAGR0PX93y8MepHGG/xUALrrzo9ImJzgyuxdXPnIwpkjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHwOwlpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527C0C4CEF1;
	Tue, 21 Oct 2025 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761045433;
	bh=gJIwZQiL4zI1GIryusrRwtuwJs9WkUU1wLaU9aw+LR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHwOwlpaCrt5RiBXgoOHi7HjarCt/t/L/+q/HZAlnD29oFQJCWM2Re5/vIYiR1xck
	 0OofGdtU+4nazkIdSNkq0G1bqpsyC4Zn8DFTeoTWr2O2a4WUyG7f6sNVH8hLD8tRRe
	 U6sP2udfWOzHyOLXFwRGmgSBU3VPQmGHmvKpPOTfGHRpKa46BtCRzmWcJc6UYjg19L
	 WVPTPZKc+zJKvlLWsUWzMRE/Gglep7wI9VeD+suV5WcZmyznNiLSo8XfmD+fxqOUz7
	 EZYDOkB3TCpaJVvtT6C8DJf0maAhgLP8fIvo+eY0vxW5lLqNg2CEokf9ULNeMAqJlR
	 VU/3YUeKsskhw==
Date: Tue, 21 Oct 2025 12:17:09 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
Message-ID: <aPdrtbW-n3RIFbDo@horms.kernel.org>
References: <20251021040155.47707-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021040155.47707-1-jasowang@redhat.com>

On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> initialize the tunnel metadata but forget to zero unused rxhash
> fields. This may leak information to another side. Fixing this by
> zeroing the unused hash fields.
> 
> Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")x

nit: there is a stray 'x' at the end of the line above

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

nit: The indentation seems off, probably a spaces vs tabs issue

>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> -- 
> 2.42.0
> 
> 

