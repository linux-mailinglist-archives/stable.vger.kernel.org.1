Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433C479C858
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjILHkM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjILHkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 03:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EFC5E73
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694504363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmEyY93Ck8WkDOQRoCLqGrbPgTcfdcNt9t1RcylOzYQ=;
        b=Aqx6Lv0nVgh5PQ8y+DV/c4s9TMd1FGf3r1uXfQqnpPS61RjCfS+xvsh1pN4HX0RXRI+12M
        0lY/d5ZM5++7C14RP028g8gxLKI9zl7FggHqsCYStombjsq2HKxfiAQ3yUTAqAb/yZGGUB
        G8hDtZPUcDkr0itXFtCaBsHdprt6bFE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-4P75eYAHMj2DjgeNTT8FXA-1; Tue, 12 Sep 2023 03:39:21 -0400
X-MC-Unique: 4P75eYAHMj2DjgeNTT8FXA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-500c67585acso5411103e87.2
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 00:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504360; x=1695109160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmEyY93Ck8WkDOQRoCLqGrbPgTcfdcNt9t1RcylOzYQ=;
        b=EWo4tdj6/C6mkv0gOC0NNLwJdOLjSJeKu4ZR6MEMqySzXcBzuMxVgLtfMCmUHgktAr
         qnur5icj9Dd8VaBykgH9gJ3Jq8CUOHv7nB4udTKElQxV8BZEUBNW31csO8SJs6zUhrzB
         sisV2sXWl4SUStbDytm4JwaHPzjvS/C3rogMobmOE7jJw7ymiPwOvSwnYiPn2z0Lj5IV
         qA22aE+YKcsk23aDdviQhpvZDpMZFahuNyOBBUIRUbHB7f2ttjlDrOtftKIhiAuerwvy
         fPXpSxfXw/rety263GHDk3byZJMWM0CEDEqvsiP0UjYFdSBAve18Emj1sdpEUcj2z7R5
         G59w==
X-Gm-Message-State: AOJu0YxSUkaEUv2chRtu3f5cheQQk1/VJeAASQ43//LnDeCMyWJaiyoy
        qjvcSgf9hyOnI7RbPu5YhRbZjY3laaVmt/PJKZdAmH2ArEFP9gFa9Pzi861xlFvPXaEXFMnvwBj
        gbpc+JftglWbtLA1Irjao2k/g0omVJcFX
X-Received: by 2002:a05:6512:2316:b0:502:adbc:9b74 with SMTP id o22-20020a056512231600b00502adbc9b74mr7946542lfu.68.1694504360151;
        Tue, 12 Sep 2023 00:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5gCC4PBq6IeJnmSasULynPErX2GOpzHNHa9ZcLnpFdOr478ISKQkds33cuYD+0XpwR2uPx/pX3MJrAV2owaA=
X-Received: by 2002:a05:6512:2316:b0:502:adbc:9b74 with SMTP id
 o22-20020a056512231600b00502adbc9b74mr7946526lfu.68.1694504359782; Tue, 12
 Sep 2023 00:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-4-lulu@redhat.com>
In-Reply-To: <20230912030008.3599514-4-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Sep 2023 15:39:08 +0800
Message-ID: <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, maxime.coquelin@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 11:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
> with reconnect info, After mapping the reconnect pages to userspace
> The userspace App will update the reconnect_time in
> struct vhost_reconnect_vring, If this is not 0 then it means this
> vq is reconnected and will update the last_avail_idx
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
>  include/uapi/linux/vduse.h         |  6 ++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 2c69f4004a6e..680b23dbdde2 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1221,6 +1221,8 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                 struct vduse_vq_info vq_info;
>                 struct vduse_virtqueue *vq;
>                 u32 index;
> +               struct vdpa_reconnect_info *area;
> +               struct vhost_reconnect_vring *vq_reconnect;
>
>                 ret =3D -EFAULT;
>                 if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
> @@ -1252,6 +1254,17 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>
>                 vq_info.ready =3D vq->ready;
>
> +               area =3D &vq->reconnect_info;
> +
> +               vq_reconnect =3D (struct vhost_reconnect_vring *)area->va=
ddr;
> +               /*check if the vq is reconnect, if yes then update the la=
st_avail_idx*/
> +               if ((vq_reconnect->last_avail_idx !=3D
> +                    vq_info.split.avail_index) &&
> +                   (vq_reconnect->reconnect_time !=3D 0)) {
> +                       vq_info.split.avail_index =3D
> +                               vq_reconnect->last_avail_idx;
> +               }
> +
>                 ret =3D -EFAULT;
>                 if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
>                         break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 11bd48c72c6c..d585425803fd 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -350,4 +350,10 @@ struct vduse_dev_response {
>         };
>  };
>
> +struct vhost_reconnect_vring {
> +       __u16 reconnect_time;
> +       __u16 last_avail_idx;
> +       _Bool avail_wrap_counter;

Please add a comment for each field.

And I never saw _Bool is used in uapi before, maybe it's better to
pack it with last_avail_idx into a __u32.

Btw, do we need to track inflight descriptors as well?

Thanks

> +};
> +
>  #endif /* _UAPI_VDUSE_H_ */
> --
> 2.34.3
>

