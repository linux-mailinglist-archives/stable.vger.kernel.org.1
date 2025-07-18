Return-Path: <stable+bounces-163340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327BFB09E18
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 10:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EBB1AA5C0E
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85216296151;
	Fri, 18 Jul 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Akv67P4g"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F8293C77
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827556; cv=none; b=nZVGK97RC6L+mCjBh5y1z/5wgBmrJvqRIT+XBQLQ/mM6ESSxgtTcKFS/EqN+1vAcZyUJwWgxEUnpgj82lJWywTDDzJ27gJPxKwjeE6AaScDjDevMOM55PUwBm6k8fWgsIcY5CyjT2AAeoBIB8lziQ/d+AUtf+gYMPQ4amwGqsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827556; c=relaxed/simple;
	bh=u+hOpWXYGqQzlXztN0daxiDWMdTwEOshtpHvQqgxZTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sycs8ZWvnZ4BTQDJGpFoxnZpsdLWy4EjYToFWEUTVMvzhHqXGMNqrCw8WeRmXgkegb02uXI5p6BBuiayRruXd208BRmdaF5KDz9DSIxlP0JjfGSs+Wxv0pruBUh6RT7WCLXAexsQIuF9KigqFR/7Ca5Xc4wyRxzUnMT7Y+kPKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Akv67P4g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752827552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClO7vf6ZBePINFWsPRFr/+WGIgiWW+sfd60JVlzDBe8=;
	b=Akv67P4gdWrlXT3el9DcBoVd/2viIeArNvghPStEE8NL3oJ3osueu62w72Ybg2pIcQU6CF
	QMvqmGhXIQD/zHkXbAZJZFJ8K0mWz10wZLVdpn+bTyEUspxRoJR/juRgdxJOa4dma+6SUv
	mbl8bz1BiRKwsVnWnhr3uTDfzAAjTeM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-2UvSg8X8PBOtK7l7gghMQQ-1; Fri, 18 Jul 2025 04:32:30 -0400
X-MC-Unique: 2UvSg8X8PBOtK7l7gghMQQ-1
X-Mimecast-MFC-AGG-ID: 2UvSg8X8PBOtK7l7gghMQQ_1752827550
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae0c11adcd2so131444166b.3
        for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752827549; x=1753432349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClO7vf6ZBePINFWsPRFr/+WGIgiWW+sfd60JVlzDBe8=;
        b=R/mpFFeOm7ATH58bEw4ix1QzmdZRSjfvJNYNVKuEnm19rZWNolKeZrYuO5nQb5qwmN
         pdgrYW6oUKgRBd6R4JgBw2+2YC5RQs1VFDBsYdkPsuM3/ZBjUT8IqCUBgUt7krXQ5vBo
         bqwYf8RC0EYPscAHu3YFWANas6oe3DajHXF33A9S1M6ZFkDhtwDRYMlHsQOIn/nk/MtM
         pZlQrel12c6XQ/h7hbrVWYbjtSctX/dvlZZyvCfOM9Z8yLDDwh66aUzrbpw49TqO/bBQ
         uJrxvoEsqBjYAvbytliQSnShgIuXtWOTbIsckMjzpVettXn/hrpsJTipMdGOsCkx+86K
         z1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUZQtZSKaRHwLWfayxK1QhiUpKyohttcshNMiOKpj5PVxI8RNLDsMccoh7BxWhZuW0qLBFJwSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UKZ5rK2p3Ky9uQlRjylaL9UrcxXI0ztzs7zVZ/VkxF9tenmY
	aDf3xM30TjynddkRTI2ISgJ1vrhP+WbKtOT2agpDF8EY1rJZcuybm5bjTZMw4KDL5K4qj1n6BL+
	MhTXKlOWfg6WKyFEWUG75UX0/BYUZhD23wbd0loJPgP+CQSEJXKK20zeEXDjFFmwcinpmGixOQh
	Ntt/XolMbtmV0T6a1GFgZTXYZX6w2XL8yW
X-Gm-Gg: ASbGncv4MZnlLVF073H+qQtZaKGWYsK4aPFxyaTcFJn+mLmVEa+DPFkrmAL705OHAwf
	gmGmk/hyT5zrnqKJntOuL4tTLfw3zBVcv32c60Wwb6GV65v0SC8OBJDvUrDU3DNfIKBMadldRD1
	yvQyH1SCOnlZc19hmnBtNMVA==
X-Received: by 2002:a17:907:da4:b0:aec:5a33:1573 with SMTP id a640c23a62f3a-aec5a3354femr462487866b.41.1752827549544;
        Fri, 18 Jul 2025 01:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZRbZf1CSxDdcr2KaS1fw9e3BgI0jPEf8QS4qDJaocQ3CHMAkyjsYYe2SLqnUm1+1w/XSVLxztz/eFpNmyZDs=
X-Received: by 2002:a17:907:da4:b0:aec:5a33:1573 with SMTP id
 a640c23a62f3a-aec5a3354femr462485166b.41.1752827549130; Fri, 18 Jul 2025
 01:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716162243.1401676-1-kniv@yandex-team.ru>
In-Reply-To: <20250716162243.1401676-1-kniv@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 18 Jul 2025 16:31:52 +0800
X-Gm-Features: Ac12FXz3P7sVlSAVAM9be3FkuV1rX0FLSe-KqiVKeDU_xg3yE_St4sNLJJ0dYVg
Message-ID: <CAPpAL=xE4ZCyAhc+fkZwREo-cDHS4CG4fq4+sebazJgRzZoDHg@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: Replace wait_queue with completion in ubufs reference
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, stable@vger.kernel.org, 
	Andrey Ryabinin <arbn@yandex-team.com>, Andrey Smetanin <asmetanin@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Thu, Jul 17, 2025 at 12:24=E2=80=AFAM Nikolay Kuratov <kniv@yandex-team.=
ru> wrote:
>
> When operating on struct vhost_net_ubuf_ref, the following execution
> sequence is theoretically possible:
> CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NE=
T_SET_BACKEND
>                              // &ubufs->refcount =3D=3D 2
> vhost_net_ubuf_put()                               vhost_net_ubuf_put_wai=
t_and_free(oldubufs)
>                                                      vhost_net_ubuf_put_a=
nd_wait()
>                                                        vhost_net_ubuf_put=
()
>                                                          int r =3D atomic=
_sub_return(1, &ubufs->refcount);
>                                                          // r =3D 1
> int r =3D atomic_sub_return(1, &ubufs->refcount);
> // r =3D 0
>                                                       wait_event(ubufs->w=
ait, !atomic_read(&ubufs->refcount));
>                                                       // no wait occurs h=
ere because condition is already true
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
> We also need to reinit completion because refcnt =3D=3D 0 does not mean
> freeing in case of vhost_net_flush() - it then sets refcnt back to 1.
> AFAIK concurrent calls to vhost_net_ubuf_put_and_wait() with the same
> ubufs object aren't possible since those calls (through vhost_net_flush()
> or vhost_net_set_backend()) are protected by the device mutex.
> So reinit_completion() right after wait_for_completion() should be fine.
>
> Cc: stable@vger.kernel.org
> Fixes: 0ad8b480d6ee9 ("vhost: fix ref cnt checking deadlock")
> Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
> Suggested-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  drivers/vhost/net.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..454d179fffeb 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
>          * >1: outstanding ubufs
>          */
>         atomic_t refcount;
> -       wait_queue_head_t wait;
> +       struct completion wait;
>         struct vhost_virtqueue *vq;
>  };
>
> @@ -240,7 +240,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool=
 zcopy)
>         if (!ubufs)
>                 return ERR_PTR(-ENOMEM);
>         atomic_set(&ubufs->refcount, 1);
> -       init_waitqueue_head(&ubufs->wait);
> +       init_completion(&ubufs->wait);
>         ubufs->vq =3D vq;
>         return ubufs;
>  }
> @@ -249,14 +249,15 @@ static int vhost_net_ubuf_put(struct vhost_net_ubuf=
_ref *ubufs)
>  {
>         int r =3D atomic_sub_return(1, &ubufs->refcount);
>         if (unlikely(!r))
> -               wake_up(&ubufs->wait);
> +               complete_all(&ubufs->wait);
>         return r;
>  }
>
>  static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs=
)
>  {
>         vhost_net_ubuf_put(ubufs);
> -       wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> +       wait_for_completion(&ubufs->wait);
> +       reinit_completion(&ubufs->wait);
>  }
>
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *=
ubufs)
> --
> 2.34.1
>
>


