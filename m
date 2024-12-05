Return-Path: <stable+bounces-98774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD7C9E5262
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967F8163730
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333601D63EF;
	Thu,  5 Dec 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLVFVg+B"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AB1D4600
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394851; cv=none; b=uvKFPHx8oZW2VzlqT8oCbzV94Et3sEBArSRkKUsUAA4vEO7l6QSHE9OBk105avmkcko1zVQJnDDcRo93vDaj3igqjXU1DYBOxYi0oCIdM+MNQY0J8IMwzEw5KluUMS5zKcGrtdI44TL9YmSa/l6dTxMOnq8lHw0soosVCA90hB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394851; c=relaxed/simple;
	bh=4iSivaet3eWbcYQfu+va8eySU1IR4UGuLLebIGaqXaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFc0dcHIiSJWAFG+wUB4kMTMu0SC/TilcUsh0k8brGMFBCQ/tzJTIis/uaG9uiST9AB66sN6hOUMzDlTYw3RFWk+zxxNmiv+TLW4HEuN9GpiVWATYT4ww82QbuQniHMlm5XJAeAqUT1O7IdWzhd53r3Ow/HInUzI8JWElkjU13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLVFVg+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733394848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDeeDy80KRfvjt8kuE4hEk8FzYVKJ9eiZDXqXeHcTmI=;
	b=hLVFVg+BOVMljeoA00eQgysoxre3Uowf1+7ZiHJOcRKgFmpxqO+bf+ccNyvVA5MUKZTbK2
	UEHdDE4K1sY/c6fnqA1HYY39mVmwuTf+d1wuXVGtj4Yv2EuU9l9RjweThJr93Z3Y/af2UP
	kHhgc/kZvaAIUIP1tIu3Ebzh+W+Tp4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-i6V_BLwNO6qEdaH8h-32uA-1; Thu, 05 Dec 2024 05:34:07 -0500
X-MC-Unique: i6V_BLwNO6qEdaH8h-32uA-1
X-Mimecast-MFC-AGG-ID: i6V_BLwNO6qEdaH8h-32uA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385ded5e92aso301481f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 02:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394846; x=1733999646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDeeDy80KRfvjt8kuE4hEk8FzYVKJ9eiZDXqXeHcTmI=;
        b=v5AiToTLtuHlwegMeljYD+apqQU8IzO0BoYMff59SZFOKya7XpkhFLjaxkAME2lJ/R
         72AwHKpC5QHQ2yWMjqHSxw/KrMKiVL2Ik3g5QRSfahiO3cm1o3MB9Yt0FCDUefYwvWFn
         3SkAb//pB81ee+SycRUqhW+Vyp2siKssqwn7kPSm4CqBK/jQ3EHdem5T2QeziqCcqIBg
         XIjIT47UGmYbE93bW2SMoOqIZX2CuzWlie9Rsik0VzzuxJD4LoqYyyOryoYv4urij+yy
         o3vJFIfRNzEPCdiJPLid2iT90mEB0TQGy6YUkFZemshaJ74ls0aaZuqK+ynIdduvkWah
         c6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7A8Hs+y/8ELBqSLI0SXZTy4y/LKDNcpuNSEhSD+6bXnsp+13LPsxjPAxakaCQ7vxAlII6XBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQDlszg34/iEriC0OdKmlE3SUJRcw+olxbY3DqlYql29OKG+3
	Rwu358MRgH80I6WF5Le6uN0nATonaMgpdVG9pTTjXOi0IGpbb5c6g8yIYZUMG0GYU0TVwtE4vzy
	AGYfVcQ1ZfU5snEhYjHf93Qr+FjoFW9eRDDphQo3xYGLO0y3R20MhqA==
X-Gm-Gg: ASbGncuXK11smkYZduuJa7KEamKf7gWmQZ6MiQANV6at4GUAZ5kiNp+cqO/+koK67h1
	Y4qjouSan9n18dCqqfqeSX79By5WckhTn4Zojjh9MV0hx2UnCHfTjtQ4+vu38Lh7DVjEhtV8gLW
	5R1B18bnvXmuMMz8Y090ayElgvItYQTUa71w4v6NdLA0bp2PXBWYCKRZuOP9+iM/d5wZogtpTja
	bPS9n84HDUx3NvS77NgUHjb7mByOetzz256GAo=
X-Received: by 2002:a05:6000:1a88:b0:385:e30a:3945 with SMTP id ffacd0b85a97d-385fd3e9cafmr8027399f8f.23.1733394845863;
        Thu, 05 Dec 2024 02:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJNPFWgvbSY2I3/I8jqi8rh7xZnIPunyw/bGll0UrDgSSCV6D1wzgUrHuDPt3xOF7WivnpAg==
X-Received: by 2002:a05:6000:1a88:b0:385:e30a:3945 with SMTP id ffacd0b85a97d-385fd3e9cafmr8027369f8f.23.1733394845539;
        Thu, 05 Dec 2024 02:34:05 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909952sm1556182f8f.69.2024.12.05.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:34:04 -0800 (PST)
Date: Thu, 5 Dec 2024 05:34:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq
 where appropriate
Message-ID: <20241205053355-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-3-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204050724.307544-3-koichiro.den@canonical.com>

On Wed, Dec 04, 2024 at 02:07:19PM +0900, Koichiro Den wrote:
> While not harmful, using vq2rxq where it's always sq appears odd.
> Replace it with the more appropriate vq2txq for clarity and correctness.
> 
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 48ce8b3881b6..1b7a85e75e14 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
>  	struct send_queue *sq;
> -	int i = vq2rxq(vq);
> +	int i = vq2txq(vq);
>  
>  	sq = &vi->sq[i];
>  
> -- 
> 2.43.0


