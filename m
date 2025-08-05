Return-Path: <stable+bounces-166546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0671AB1B1A6
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 12:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB60D3BE30C
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B295D26E16C;
	Tue,  5 Aug 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNEpDem1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3B261581
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388136; cv=none; b=tKOKS7OhXxRc5oSK1+2tgMVJnx1TPtUwf43nbA1liBkDkJgKEUwoR0KKCzvRnpnxp9fNbylAx/dDmHVp4Eoj6QCm27D238wZmrX8rDave9K7nU6rgdJttMD5FFDK0Vj7dV792vO1LqGu1f3/qHffJsX04qzwE5SI3/cEkB0Mj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388136; c=relaxed/simple;
	bh=ghVc4jUywvAFQR8Cbgq1AJpVrOuHaExsk9z8LbGUnck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugQNA6VGN6iYaeV9hgV1TwuLZUon1tFRyhXFf4L0HoJVf068CBHcE6LDNtKFVnsdhKgkb0KCLurmzLSH1CHHWQLjB4DO8Y2jmjwrs5lBescR3HSPMVCjhg8PD6e3SfKSvIDXct6l5sqUnxyvHEYTFXpvo7YEQrzpegPnr9IVdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNEpDem1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754388133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C8iq3DcQDje5KaWsGWyrnSm7HvAQMMkFMgKVgyZHegI=;
	b=JNEpDem1tnZ2osolE/+QjFSsYyRHmVY1nCBbz5N3W8MwaigL3/2YTyetHzSE+6vEKxC1jQ
	OWi0oCIGYW4m48pSMYBFHNnQm0HicrsAOhbLwrt+37X3ltLuDX2rZeqLX1w8uI2Lwzirue
	U8RjPW7qrBGJewJFuDlEDJvtCy5EPBE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-0iakOFQ7PdyWYlSRBE0Ciw-1; Tue, 05 Aug 2025 06:02:10 -0400
X-MC-Unique: 0iakOFQ7PdyWYlSRBE0Ciw-1
X-Mimecast-MFC-AGG-ID: 0iakOFQ7PdyWYlSRBE0Ciw_1754388129
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b78329f007so4730845f8f.1
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 03:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388129; x=1754992929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8iq3DcQDje5KaWsGWyrnSm7HvAQMMkFMgKVgyZHegI=;
        b=eDZQI9jZyUdfBUmiocq5A/lnVeQE0wJsRLmOoLTAhF9WBO/UTp1DBQSZvi8SXQfMvX
         sTWDYjarjIiOBbnnEoWcAE5BYxXfIj73dA7I4Ix6OAEl2T5Fh7cn7YGWrgsNeaBt55FZ
         wD16jkqdw10DR7tBelzW3aL+4HJwoEoY7r0mleutNzCaCqAIkCZC2MJ9xRFNij3InGU+
         6Ym3+Aud0ujRMLhSVntlADhfKyCRJ8TxroTe1gFVcFcu+66fQNgzlkYiteuDNg45DzsH
         WOuN2B71MxdtCaofnz62/Pd6h8YV37KHQdF4XAlsVqJsvZBKa78iSyc0GiKeaaNUtMcE
         G3jw==
X-Forwarded-Encrypted: i=1; AJvYcCWSbcIDUmgNsbpoRhOC1D8PzQk7htn+9pX4TJJooQnDRr7HGj5hFdOIvQL7iyQzXvxYKLNINOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSSXzFJNoBayOYGX0kKeXtS28iWZRLzO0dqi+g7iSfQJ2PsUlE
	5obMpzo6qJjZFtLGv4PIzoqZp7R60F4HLJ/gcTow7iumiH+Rt18HWns28GIWylrB0UhgR3uqMaK
	YcabaWLIamx5hU5xubcgk2E2rDuoQXXd8AFINjyREl1TqKGeq23qSLUYxDg==
X-Gm-Gg: ASbGncuQ76C/LU0ugqdtje2aQY9pQV195Bfk3Oozjm1od+5crI/HcOYBbyz+M74Z0Ay
	n2hWLHD5NrOxUaWZb0O9Jq1lqZugxydqBoGcfpv3GKDNGGVYSUeu9BMjPpRibNKgYhMEmO6zifX
	EEQWbrLQMJwYbJjFOrKE9N2oVRqIMzHkxUtrLk6tk7wHTNgu1bt82WaIp4NTglylgpoTwUZxrp/
	XINGTk0tEAH+WsbOfQqACOqVCEyuyuogvwBZWtkwE9QWLL/eij2qsFPKjivV7NT5RnsvDnKVC6h
	gYe8tneWfBejmtG7bytGRJRo0sb+skWR
X-Received: by 2002:a5d:584b:0:b0:3b7:924a:998f with SMTP id ffacd0b85a97d-3b8d946b3a2mr10486265f8f.5.1754388128689;
        Tue, 05 Aug 2025 03:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0h3EuzIaMa9Wir/mQMI0EF1I5NZk8tEiHqXjJLyBPOFpTj+sXNt2uVT98K1ru7T8YB22hmw==
X-Received: by 2002:a5d:584b:0:b0:3b7:924a:998f with SMTP id ffacd0b85a97d-3b8d946b3a2mr10486210f8f.5.1754388128107;
        Tue, 05 Aug 2025 03:02:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm18532205f8f.67.2025.08.05.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:02:07 -0700 (PDT)
Date: Tue, 5 Aug 2025 06:02:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Lei Yang <leiyang@redhat.com>, Hillf Danton <hdanton@sina.com>,
	stable@vger.kernel.org, Andrey Ryabinin <arbn@yandex-team.com>,
	Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH v2] vhost/net: Replace wait_queue with completion in
 ubufs reference
Message-ID: <20250805060149-mutt-send-email-mst@kernel.org>
References: <20250718110355.1550454-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718110355.1550454-1-kniv@yandex-team.ru>

On Fri, Jul 18, 2025 at 02:03:55PM +0300, Nikolay Kuratov wrote:
> When operating on struct vhost_net_ubuf_ref, the following execution
> sequence is theoretically possible:
> CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NET_SET_BACKEND
>                              // &ubufs->refcount == 2
> vhost_net_ubuf_put()                               vhost_net_ubuf_put_wait_and_free(oldubufs)
>                                                      vhost_net_ubuf_put_and_wait()
>                                                        vhost_net_ubuf_put()
>                                                          int r = atomic_sub_return(1, &ubufs->refcount);
>                                                          // r = 1
> int r = atomic_sub_return(1, &ubufs->refcount);
> // r = 0
>                                                       wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
>                                                       // no wait occurs here because condition is already true
>                                                     kfree(ubufs);
> if (unlikely(!r))
>   wake_up(&ubufs->wait);  // use-after-free
> 
> This leads to use-after-free on ubufs access. This happens because CPU1
> skips waiting for wake_up() when refcount is already zero.
> 
> To prevent that use a completion instead of wait_queue as the ubufs
> notification mechanism. wait_for_completion() guarantees that there will
> be complete() call prior to its return.
> 
> We also need to reinit completion in vhost_net_flush(), because
> refcnt == 0 does not mean freeing in that case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0ad8b480d6ee9 ("vhost: fix ref cnt checking deadlock")
> Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
> Suggested-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Tested-by: Lei Yang <leiyang@redhat.com> (v1)
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>


Nikolay should I expect v3?

> ---
> v2:
> * move reinit_completion() into vhost_net_flush(), thanks
>   to Hillf Danton
> * add Tested-by: Lei Yang
> * check that usages of put_and_wait() are consistent across
>   LTS kernels
> 
>  drivers/vhost/net.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..69e1bfb9627e 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
>  	 * >1: outstanding ubufs
>  	 */
>  	atomic_t refcount;
> -	wait_queue_head_t wait;
> +	struct completion wait;
>  	struct vhost_virtqueue *vq;
>  };
>  
> @@ -240,7 +240,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  	if (!ubufs)
>  		return ERR_PTR(-ENOMEM);
>  	atomic_set(&ubufs->refcount, 1);
> -	init_waitqueue_head(&ubufs->wait);
> +	init_completion(&ubufs->wait);
>  	ubufs->vq = vq;
>  	return ubufs;
>  }
> @@ -249,14 +249,14 @@ static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	int r = atomic_sub_return(1, &ubufs->refcount);
>  	if (unlikely(!r))
> -		wake_up(&ubufs->wait);
> +		complete_all(&ubufs->wait);
>  	return r;
>  }
>  
>  static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	vhost_net_ubuf_put(ubufs);
> -	wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> +	wait_for_completion(&ubufs->wait);
>  }
>  
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
> @@ -1381,6 +1381,7 @@ static void vhost_net_flush(struct vhost_net *n)
>  		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  		n->tx_flush = false;
>  		atomic_set(&n->vqs[VHOST_NET_VQ_TX].ubufs->refcount, 1);
> +		reinit_completion(&n->vqs[VHOST_NET_VQ_TX].ubufs->wait);
>  		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  	}
>  }
> -- 
> 2.34.1


