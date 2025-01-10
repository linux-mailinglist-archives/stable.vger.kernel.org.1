Return-Path: <stable+bounces-108240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA84A09E58
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F8D188B4AF
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320121516E;
	Fri, 10 Jan 2025 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="ZfofuTOQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F521C18F
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549325; cv=none; b=gbhATcJHLXxtObF28UXNSkk+2cqeOgZdZSq6t3SK2vSWNF4BONUjkf+6CX4J3Mw93zHvND1JxnA7iSmCma6k1/LN3OF7pt/2mQoFKqWKr6dCGe3vnNR/hAhaoed6ZILcOrRuHyi6fJ5p22KcUKVMB1sQBLgAoR+Tj0HKezoICBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549325; c=relaxed/simple;
	bh=AWn3AuB7yHOLd4iesrrxgcRSmxPBHT0ef3tOlCuWqWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqohlw+BPqJCKlmiSoaq4InVy06v9suKNGIdUznLVH55Q3rUELQT3tdvKm28JXaQHX3EGwMXm1q14lvLeN9S1TT8B60di5+2zR0jF/7xuWdf6ejHJdOy2yhV6k2vKSFCFLwr+nkVVklFrfXvD/j+X4NB76E2kYahiAsb+wpR1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=ZfofuTOQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216401de828so42630845ad.3
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736549323; x=1737154123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzXivbWavWl+dN7CMkxVZypF4oLVVAvtUtJdUE5p7A0=;
        b=ZfofuTOQaH+V2FRiaPv/56FlYOSSqGW34iuKAPEAMGYGj0a9hjKWh6uXQ86MxCjVK7
         XzT/7DT3Z4Qt8nHTi79/FUlHg2Gg1aZj9YBkMZkQt4w50YwBfH8Nr+sXOwM99PCGqif1
         5e0tE2gy9BpOID+Mk4F/+vJM+gJjiuZGgjjrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549323; x=1737154123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzXivbWavWl+dN7CMkxVZypF4oLVVAvtUtJdUE5p7A0=;
        b=hPb348QQxbvAZLye7tw/VADTTmowZiDK+yw/yqObkHnAe6grY7IPPgOso9uQaeE5at
         Ew0MkFnB08B9ByA8wKPUeXYeMnLOnMY8RHAoev8sUgmS2O3zdmJXuI+NgJnCdZqUSxQC
         IADyT3H2i6wJR30tHuoZkk8ulh7fRff9IWel9XYGWPE4ucn9zsQG2Vx43JrARVrx6uwQ
         1uxm3W24CTFjfc7OgvfYk2PZdr3oHZ/w548dxjzcr/0+bQHKB4A1j+tfDFL36eiHaOnc
         o2HRB6qYht4Q2LtvI32uSp0y4ZmPULF5rzBStctl7ScOzK44jGNqP3wfQf1OgKRTSgtU
         ha8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/AN0gMHWIKcNmjjd9kvMXGdDcoNJZ4qJXWtur0VfWPgL7+iK4a5QIGgTwHTzLmgvUkfExuEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlhV1ldrfPw9USInx13mIC79OQpQddKWXB5AmcU1BxQjrnVX1Y
	bOWwtTdvw2NRLhA4ZJV3L0JFilTsW61uRRXr+R6sGBLxIVyt7VrqeC3sIAPU1oA=
X-Gm-Gg: ASbGncum90kLBj0R1N0rGPfuLPTMR3xfhmZVKN6FW419de29coRWALQzu5u0v9Owtz+
	jComyxdLMSmOhh3yP9wH+jc79VktRFFT3oN5MYrkqIS7rjAeOOKVXgNPcrKurzbSXnjhKVKElhe
	NN2wovkbIbmwOPfBqoJmP20qX65d+fdjwbFIVzUYL3I6AB6fTpSUezUk9cDLXPAJEPJrFcQhaku
	0ucGGp6axeJglJgY3iWtQ4I+3FKWSg71w2fH/CcTHNeZtCv2GXjBrxGCwwwjYOgdDcEbg==
X-Google-Smtp-Source: AGHT+IFL3U05bezNqg95x2HmYQVnB18znOwGddscITDSjOdMEJTGA2bZLmFShcBBgvVENgRqTIzeYw==
X-Received: by 2002:a05:6a20:a10c:b0:1db:ec0f:5cf4 with SMTP id adf61e73a8af0-1e88d0d9c40mr20159487637.39.1736549323168;
        Fri, 10 Jan 2025 14:48:43 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4068178csm2065630b3a.148.2025.01.10.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:48:42 -0800 (PST)
Date: Fri, 10 Jan 2025 17:48:35 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net v2 3/5] vsock/virtio: cancel close work in the
 destructor
Message-ID: <Z4Gjw6QMqnUsQUIw@v4bel-B760M-AORUS-ELITE-AX>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-4-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:09AM +0100, Stefano Garzarella wrote:
> During virtio_transport_release() we can schedule a delayed work to
> perform the closing of the socket before destruction.
> 
> The destructor is called either when the socket is really destroyed
> (reference counter to zero), or it can also be called when we are
> de-assigning the transport.
> 
> In the former case, we are sure the delayed work has completed, because
> it holds a reference until it completes, so the destructor will
> definitely be called after the delayed work is finished.
> But in the latter case, the destructor is called by AF_VSOCK core, just
> after the release(), so there may still be delayed work scheduled.
> 
> Refactor the code, moving the code to delete the close work already in
> the do_close() to a new function. Invoke it during destruction to make
> sure we don't leave any pending work.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <v4bel@theori.io>
> Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 51a494b69be8..7f7de6d88096 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -26,6 +26,9 @@
>  /* Threshold for detecting small packets to copy */
>  #define GOOD_COPY_LEN  128
>  
> +static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> +					       bool cancel_timeout);
> +
>  static const struct virtio_transport *
>  virtio_transport_get_ops(struct vsock_sock *vsk)
>  {
> @@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
>  {
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  
> +	virtio_transport_cancel_close_work(vsk, true);
> +
>  	kfree(vvs);
>  	vsk->trans = NULL;
>  }
> @@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
>  	}
>  }
>  
> -static void virtio_transport_do_close(struct vsock_sock *vsk,
> -				      bool cancel_timeout)
> +static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> +					       bool cancel_timeout)
>  {
>  	struct sock *sk = sk_vsock(vsk);
>  
> -	sock_set_flag(sk, SOCK_DONE);
> -	vsk->peer_shutdown = SHUTDOWN_MASK;
> -	if (vsock_stream_has_data(vsk) <= 0)
> -		sk->sk_state = TCP_CLOSING;
> -	sk->sk_state_change(sk);
> -
>  	if (vsk->close_work_scheduled &&
>  	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
>  		vsk->close_work_scheduled = false;
> @@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
>  	}
>  }
>  
> +static void virtio_transport_do_close(struct vsock_sock *vsk,
> +				      bool cancel_timeout)
> +{
> +	struct sock *sk = sk_vsock(vsk);
> +
> +	sock_set_flag(sk, SOCK_DONE);
> +	vsk->peer_shutdown = SHUTDOWN_MASK;
> +	if (vsock_stream_has_data(vsk) <= 0)
> +		sk->sk_state = TCP_CLOSING;
> +	sk->sk_state_change(sk);
> +
> +	virtio_transport_cancel_close_work(vsk, cancel_timeout);
> +}
> +
>  static void virtio_transport_close_timeout(struct work_struct *work)
>  {
>  	struct vsock_sock *vsk =
> -- 
> 2.47.1
> 

The two scenarios I presented have been resolved.

Tested-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim

