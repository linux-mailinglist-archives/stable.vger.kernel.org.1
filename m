Return-Path: <stable+bounces-179805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB3B7CFC9
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E5A3B2AD5
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031D2F5462;
	Wed, 17 Sep 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYY/7VuB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5ED2206B1
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098132; cv=none; b=KaLP/oxj8prBiBA3YeakZJ7HdYHCMaddOpWNfIbtGKWr5s1qaT2oORC/BmzYJMiL8/nC3c1GrG+VJVeoR5zsa8uUa/LeuKlpyLSqQI3NCZ/8EsDAsHCeAr4e20VGdanc2Pygr0MbBX4i6s4qI5OiuGlcAjq17hPuazIYZHa7Cu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098132; c=relaxed/simple;
	bh=q998US9DM6OvRET551aJFQGCAmTK69Gkhu3kFz33Lo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kS+zHfey5TcI/cjrLtUNsCL02tb/h89AXufeSF6SOQ4uU5d2vTPRX0iiFPq6EG+do+6MbyoCblnA/nUhxLVTngMwb4dML8K6NCLjbc2kP+5F+9kA0IrHAqIpymeUki1ZYwHNUs/149RjJPCOcyROpiZUckW9xl4KHJeuGw3QxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYY/7VuB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpJuW7ScxpFIrDm/6lY2N9UNppFzeLdJ57JW01ss3N0=;
	b=bYY/7VuBDQgVnIvBa68t7Czgxs0EY88Ub4ilLZj+2DbhGWJkIBgACQiX34rQDvQPEMNr+W
	pF3N6q1Ors9ZiIkG2hxipYAebcXvwbhUIn/bYJAsvvUR9NvnBq9ipRtt+Rv3WqK1DEBQZv
	7arakdAFanKnOvLfntGGy72a5tw2EQY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-QgQT0TTqPQqm0UCaI6f5NA-1; Wed, 17 Sep 2025 04:35:29 -0400
X-MC-Unique: QgQT0TTqPQqm0UCaI6f5NA-1
X-Mimecast-MFC-AGG-ID: QgQT0TTqPQqm0UCaI6f5NA_1758098128
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-722866d8e9fso105116407b3.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098128; x=1758702928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpJuW7ScxpFIrDm/6lY2N9UNppFzeLdJ57JW01ss3N0=;
        b=C6vVlhmCfjuz+kXur6bN/ONMQe4JJkURggiX3YC/2yyfXP/Geg/YxVOrgJH3dnltzY
         QasOj3lWX+dtb+sPRYqktWSSgz4Rd+sTpkPeUu1rpfCtG55AQlB4XB4SY337KJNS5O4s
         zff91pBSI9OgJsIEA5aoE/m1Z8TyiripiV6sfftIgF6snJvnhfO3+wXKlhF48bIPjg3C
         1BE6iwyOF+zbwX0/OEGR3jmpghaaqnQ8EXmTIg0V5ICUG2/goctzUiwU+LDvCdBMPMcb
         RmCg7kS4nsIKcORHdbhpM+IAuaIQ/fjWWwIFrIohWi7HIJ9Cx/OOC9sOKrAWr/f68VrT
         yrbg==
X-Forwarded-Encrypted: i=1; AJvYcCWlTW8wvr0HkPQFMz6t3IFGoqqckVh98ZEy7byYBX2U0XrccnhA62JbRW7oji5k1UHAgmiZIT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XGA41gKX2nEdEM1xSVBPcM/LIJw33Le04T/DTCKyrZdW1x4Y
	1N04kW3ivvRsGjapooCFKIfuUxnR4Eht/BUyN+lpkx/95wYj0ddNvqyC/ancsnwKPytZ4WB2h7E
	OeHJ5pOWq7oJMsGOroRyrGJXoj7QZF1V/oZxx89aPT8JgP/o+2N/z2TCXvltLcyLJawMZNyM4qX
	xG7geclyxNJe1dTehBRwR9l2nnPeYsgtHE
X-Gm-Gg: ASbGncsUoSFJfwtnSHvFe7MtbPaB4Ef6BY/lZy6I6OQI9Lb+JvR1qBQEyhGamdRmYB4
	4rhFFYP9fFFH6Lcl/dkLB4bZgGoQkCeRzC2kBxDGOZ7WCEHrGzuFJF190O3JdSa2xASu50/daq+
	bUfCP6q2xHYhetCKZb57fQtE40S94NNRPitcFDzFqwL6fT85O3Rcczwa4LDnICiJyvNKvxHV71f
	gbBmJ6W
X-Received: by 2002:a05:690c:6287:b0:734:4c38:8dd7 with SMTP id 00721157ae682-7389284e5e5mr9726437b3.37.1758098128451;
        Wed, 17 Sep 2025 01:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7WOF0rEFwoWJH/Fs+cwlNlhklNtr7tfG2XSvbAwX8kIp4ppyqh9Npvtpo12WegIqko71EKOuElGMUL7KcsA=
X-Received: by 2002:a05:690c:6287:b0:734:4c38:8dd7 with SMTP id
 00721157ae682-7389284e5e5mr9726207b3.37.1758098127956; Wed, 17 Sep 2025
 01:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250917063045.2042-2-jasowang@redhat.com>
In-Reply-To: <20250917063045.2042-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 10:34:50 +0200
X-Gm-Features: AS18NWCp8aMeKQoIpGNO8gXB409fPKuCuu417M71iyj7YQxnhfTZ79uY8_vwglw
Message-ID: <CAJaqyWeWy9L322_-=MNno9JABegb+ByXEHmEyBsqXHUVTiBndg@mail.gmail.com>
Subject: Re: [PATCH vhost 2/3] Revert "vhost/net: Defer TX queue re-enable
 until after sendmsg"
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, jon@nutanix.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:31=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This reverts commit 8c2e6b26ffe243be1e78f5a4bfb1a857d6e6f6d6. It tries
> to defer the notification enabling by moving the logic out of the loop
> after the vhost_tx_batch() when nothing new is spotted. This will
> bring side effects as the new logic would be reused for several other
> error conditions.
>
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and
> trigger the TX watchdog in the guest as reported in
> https://lkml.org/lkml/2025/9/10/1596.
>
> To fix, revert the change. A follow up patch will being the performance
> back in a safe way.
>
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sen=
dmsg")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..57efd5c55f89 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, s=
truct socket *sock)
>         int err;
>         int sent_pkts =3D 0;
>         bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_MAX);
> -       bool busyloop_intr;
>         bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>
>         do {
> -               busyloop_intr =3D false;
> +               bool busyloop_intr =3D false;
> +
>                 if (nvq->done_idx =3D=3D VHOST_NET_BATCH)
>                         vhost_tx_batch(net, nvq, sock, &msg);
>
> @@ -780,10 +780,13 @@ static void handle_tx_copy(struct vhost_net *net, s=
truct socket *sock)
>                         break;
>                 /* Nothing new?  Wait for eventfd to tell us they refille=
d. */
>                 if (head =3D=3D vq->num) {
> -                       /* Kicks are disabled at this point, break loop a=
nd
> -                        * process any remaining batched packets. Queue w=
ill
> -                        * be re-enabled afterwards.
> -                        */
> +                       if (unlikely(busyloop_intr)) {
> +                               vhost_poll_queue(&vq->poll);
> +                       } else if (unlikely(vhost_enable_notify(&net->dev=
,
> +                                                               vq))) {
> +                               vhost_disable_notify(&net->dev, vq);
> +                               continue;
> +                       }
>                         break;
>                 }
>
> @@ -839,22 +842,7 @@ static void handle_tx_copy(struct vhost_net *net, st=
ruct socket *sock)
>                 ++nvq->done_idx;
>         } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)=
));
>
> -       /* Kicks are still disabled, dispatch any remaining batched msgs.=
 */
>         vhost_tx_batch(net, nvq, sock, &msg);
> -
> -       if (unlikely(busyloop_intr))
> -               /* If interrupted while doing busy polling, requeue the
> -                * handler to be fair handle_rx as well as other tasks
> -                * waiting on cpu.
> -                */
> -               vhost_poll_queue(&vq->poll);
> -       else
> -               /* All of our work has been completed; however, before
> -                * leaving the TX handler, do one last check for work,
> -                * and requeue handler if necessary. If there is no work,
> -                * queue will be reenabled.
> -                */
> -               vhost_net_busy_poll_try_queue(net, vq);
>  }
>
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *soc=
k)
> --
> 2.34.1
>


