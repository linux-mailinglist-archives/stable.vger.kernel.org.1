Return-Path: <stable+bounces-98776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1419E52A8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921621882053
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15C1F03F6;
	Thu,  5 Dec 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzbxdELE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8451F131A
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395243; cv=none; b=PyHKbGHR99iogTvfwGqhCV161hbban2x5XG5uTIpsqIoh1ceDLQAH7JaqHdpLvmJcqX0bKgmUPr/Vpg/pRiKPWzgjt80Gn2DduIJbSKs6n+zC1tB5Ep1RzjKkbGb2pu7LK/Rr1DRQNrSqUVbQ/t4XdUUi/0keV88b3XgZCZLObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395243; c=relaxed/simple;
	bh=eshHAQfNSHOzASdNe9Ca6yUEiJvbhuYcQfpae53AkRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYa23bhgq/4S3EIAxz5BpslNmHCQ5lES+3wFSYKreL26Ourbx1z+bNISu6IzGmCwSE7niRe5WwcgdSgWG2YItPMkxU4k2hgqf2wr05N5NgkJqWKENC8qvn4UScdPOngOJNH67hkMo2fIPHh+XnYyZEX32wQGW6gNyjJgr2YVegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzbxdELE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733395240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpCGJ4eeYXK6hXhyy8nkE9QIN4zLNYIGTlUdRPmUVpo=;
	b=NzbxdELEolBXpW+x0eTUpQL8y4JifnZIXG9HMnRrTvmI6Puq4QpNsIkQa1Cads+hmJcKOr
	12KuXyVbqNA4kBmjAsXYGMr3dUKmjSeCZEZ3edfdeoLH7twNMbyTx+hhiqr2zB+JUGnn0P
	kvKtTdMY51gIqpnfNlpVPhpgXhB9/bs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-DQOfQJCYMKCFB5MpuOZoOQ-1; Thu, 05 Dec 2024 05:40:39 -0500
X-MC-Unique: DQOfQJCYMKCFB5MpuOZoOQ-1
X-Mimecast-MFC-AGG-ID: DQOfQJCYMKCFB5MpuOZoOQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4349f32c9a6so6615835e9.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 02:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395238; x=1734000038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpCGJ4eeYXK6hXhyy8nkE9QIN4zLNYIGTlUdRPmUVpo=;
        b=vCGnZ6k1T/jCvF4UZ7FJHcPkK8yIjuGUn17aMBVfsaZnbADtT+PzVIPQWUyylBbDGw
         5dQeu+4TQC3uvlZMTqKBm3zj+PtbozvAKGXogpAom1gNMfB3oEMBZAhqGEsIbE9/aW50
         BZ3TFMylPFQXmX2zN4EYE8902HTt3cfVbmDCJfK2QH02b78lINKYz4LiFtcaIK4LGdIz
         AYqWIRIVIpWWOxlB39dNTGGA7xzqrfl5vPfMSlZyYES0/0zHckp5Mi/fMEjM1XzHbuAW
         7k3J6bPaRbNjkivEUIi77bR7/q6TUCu2yz8z2ZmiAJn5ZStGTEaQ6vTbyk3huxWXTl3B
         fL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVtn0XXBPyy4SI0z57880aqT7ZRvdyJ8vlWEdWEK5+xlFnmQM9WjUkrOIFnC3BPKAeLT5Ae0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3wcGajbA8x8gzj1o7v0S4MBGgHtu0vXNBR7KVZVwgOnUi0GR
	G9AFr6qwrYed9nX3bi55pdMUQNX+d7fX/Bmts8zNatLW2RezE/Kkn1Qe2ytpVlloaqFIT+AWBVt
	yzE58LciJIV1WK57hLCl/RBQsxNPEphfeT9YW8BC5+m1N/DPMEvRHLQ==
X-Gm-Gg: ASbGnctAMIELZ1fMYaiE3DNnUwxDeFkZdudGdFB5g9A2STJcQ/A/co26Gv7fA4r4JK9
	k99g5bLyML/ioJjNrfxdkSJ01ErGAsnb+2a272250J7qqynDbaF86XSa2fOtk60e+bvX8KoQQD0
	KmYigWxLo8MCBP7Nd5QxJqXfGWqLfqc1iN9gn3+W8hr4S34pJZtdzf12UAwhq9VPlMlNmqzjiWM
	DSFcw+GCDlKRNFrrUNQ+7lJyWws/bN3azYBLsM=
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr98426115e9.30.1733395238175;
        Thu, 05 Dec 2024 02:40:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsUHluXJQKUT4U9GZXEYGz55h1e+WikGnJtrY5qJkX8kQnZ3tgKpsrMkwfLF3sVmYTJvd9jg==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr98425925e9.30.1733395237817;
        Thu, 05 Dec 2024 02:40:37 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5272f99sm55804775e9.11.2024.12.05.02.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:40:37 -0800 (PST)
Date: Thu, 5 Dec 2024 05:40:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce
 virtnet_sq_free_unused_buf_done()
Message-ID: <20241205054009-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-4-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204050724.307544-4-koichiro.den@canonical.com>

On Wed, Dec 04, 2024 at 02:07:20PM +0900, Koichiro Den wrote:
> This will be used in the following commits, to ensure DQL reset occurs
> iff. all unused buffers are actually recycled.
> 
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

to avoid adding an unused function, squash with a patch that uses it.


> ---
>  drivers/net/virtio_net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1b7a85e75e14..b3cbbd8052e4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
>  static struct virtio_net_common_hdr xsk_hdr;
>  
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
>  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			       struct net_device *dev,
>  			       unsigned int *xdp_xmit,
> @@ -6233,6 +6234,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  	}
>  }
>  
> +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
> +{
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	int i = vq2txq(vq);
> +
> +	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
> +}
> +
>  static void free_unused_bufs(struct virtnet_info *vi)
>  {
>  	void *buf;
> -- 
> 2.43.0


