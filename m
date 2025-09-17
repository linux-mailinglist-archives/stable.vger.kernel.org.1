Return-Path: <stable+bounces-179798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A0B7F4AE
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089183B63B9
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA53B306D50;
	Wed, 17 Sep 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoKeeMTK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6C305E02
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096964; cv=none; b=hilEA1jPLvxYE5lIabwNGRwy00XK0GU9It21ldD+38DultCPPk0DQXsMcchzvlptIBQb2W3xvtyXP1FehKgKU62/cms0CM/2AjsKxOb0BDIz0I+uqGaXEkmlIcrS4uFpSc/8eXeRirWN0S6telOfV6MBsacq8ZG8Ya3ghY3bUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096964; c=relaxed/simple;
	bh=DZJjEilvh8soI1BKTSfA4Ey5iDL2dw9rLc+r+sxOjtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE1TjKJEErvoIaYtT3O7+tYnePlZgPEdttQ6xcr8V9YMIsZQ9eZ5WJIy7sCjkuJ211vGCv/wNPS/A3+bjvzmXWDDb6zh6OmrpSgTr7IEPeCSyWA3SYUECPpsbfigDYCckJ+l/DMWtqsV3KVqXPHey2G31yfpyRn726J6D7/bEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoKeeMTK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758096961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eedUNpaU5+NqwyQ8eXKTY11TfX3TYBW7jRyqO48Q8K4=;
	b=XoKeeMTKu0gpgfJHuLWswxJAGqCjjKpuINRBQraqSY9q8vgpNcBVtjXiFhSYkG8W4YN65/
	4No2q9FHPyuJunUXhi+DU1IrMASJ8MZbKZ05kGdhWhR4jesmx7GqtO92rXF0vz9CIUef5g
	2e0YdnswDRE6uKV5HwS3Q7hKbtluozk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-KrG6Ng6FNTGbIDO-PhNClw-1; Wed, 17 Sep 2025 04:16:00 -0400
X-MC-Unique: KrG6Ng6FNTGbIDO-PhNClw-1
X-Mimecast-MFC-AGG-ID: KrG6Ng6FNTGbIDO-PhNClw_1758096960
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-73894444cebso3778907b3.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 01:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096960; x=1758701760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eedUNpaU5+NqwyQ8eXKTY11TfX3TYBW7jRyqO48Q8K4=;
        b=VtCFQ+4hBGWQyPWkVuJb00+9Ue3ngoQntF8hE+hlwmW5qn4GDHyDviG7r/2cwCgjRs
         m08S/CcT95RgY04Q66B7Nn3ttueQnNxvtAdXFu0PQUm+xwTrxXDVWIdXB9di+vJBsIuM
         dEKIMXCH6kEaZ9fOV/xsiYNBpGG8vf9mr4ZEyCEWppCu898V3Yqb8SVht1hWwLCunhvY
         0l9GyUP4gyskCHQDvm3GUSpNjcIiebwTIQ7i8hTIcLTV61FkvcPhLlszpB5NqC/wGqra
         Oj3nhQfKFpEHp3I6GypiUPB9+BSA8vA6fZqpiKqKsNX5R7xhmzurYxeCHbsTu8O8r2uC
         kjuw==
X-Forwarded-Encrypted: i=1; AJvYcCUBo1VIlZ3YIrN98qxWquoyHNKaqt/7p1beB6N4v6HrL4s5/FFNZoObQlWkfqMQaACvOYO1mzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqOW1pv6v9KuIuKiYwoeFGeGx0cM5kYe0zkh64YBj3syNPjdG
	ZzFjX01Iw7bXPAEV+fu+j/XtPh0pKoCvt0Clvu7jRLz0jOkxpIjlSYJIPgZcSA0PQUAwnwNvmNz
	QG1Z01h//xJmUxdyX97/3FcAKJp4dCrf/SQgzo1Ec0lxuwNxubJxUHJbV/5CZ2WjMpHNIv6lMTR
	H/RV0+79QGXdPEf6XduccbqjnFfAR5yHGp
X-Gm-Gg: ASbGncvUlZnANusJgjXXxL8AZZvtL6bBnZe+dlfSrKzkLGGLCbSYrAb6JcKND5y1qUv
	adj7IghGE4JTycnrZpG47AFNH1ydhdhOez5MT1sU826bHIPGbFuusRy4GynNZWWiG4gABZsBWyw
	h4nROUqDpdAuez0y/BV2ELBZ2qx1lRaat9sr5dPqsTSKQw4WtoaNGk36XOT9QrbNc+XciXVHQ67
	fwQkhNq
X-Received: by 2002:a05:690c:6c86:b0:723:b37b:f75f with SMTP id 00721157ae682-73891b87784mr10853817b3.26.1758096959687;
        Wed, 17 Sep 2025 01:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyEE0NjY/G5cvHcAfaFUYZLAJa4QZLLCvZPWadjWH10jQVSkAeb7QCxJDkVvvAIV4aZoNVgVWuy6Xs42oRk5I=
X-Received: by 2002:a05:690c:6c86:b0:723:b37b:f75f with SMTP id
 00721157ae682-73891b87784mr10853617b3.26.1758096959304; Wed, 17 Sep 2025
 01:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com>
In-Reply-To: <20250917063045.2042-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 10:15:22 +0200
X-Gm-Features: AS18NWDDF_GZcJeZupVOj5tO-bkVG3qVNzTBHe2X19uvGqJmtk3QOixi1mHlzhU
Message-ID: <CAJaqyWdoLiXJ8Skgwp14Ov66WP1wjnJkR0wwUdmcziSAFJoxCA@mail.gmail.com>
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, jon@nutanix.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:31=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> of used elem to vhost_net_rx_peek_head_len() to make sure it can
> signal the used correctly before trying to do busy polling. But it
> forgets to clear the count, this would cause the count run out of sync
> with handle_rx() and break the busy polling.
>
> Fixing this by passing the pointer of the count and clearing it after
> the signaling the used.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Cc: stable@vger.kernel.org
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c6508fe0d5c8..16e39f3ab956 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue=
 *rvq, struct sock *sk)
>  }
>
>  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock=
 *sk,
> -                                     bool *busyloop_intr, unsigned int c=
ount)
> +                                     bool *busyloop_intr, unsigned int *=
count)
>  {
>         struct vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_VQ_RX];
>         struct vhost_net_virtqueue *tnvq =3D &net->vqs[VHOST_NET_VQ_TX];
> @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_=
net *net, struct sock *sk,
>
>         if (!len && rvq->busyloop_timeout) {
>                 /* Flush batched heads first */
> -               vhost_net_signal_used(rnvq, count);
> +               vhost_net_signal_used(rnvq, *count);
> +               *count =3D 0;
>                 /* Both tx vq and rx socket were polled here */
>                 vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
>
> @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
>
>         do {
>                 sock_len =3D vhost_net_rx_peek_head_len(net, sock->sk,
> -                                                     &busyloop_intr, cou=
nt);
> +                                                     &busyloop_intr, &co=
unt);
>                 if (!sock_len)
>                         break;
>                 sock_len +=3D sock_hlen;
> --
> 2.34.1
>


