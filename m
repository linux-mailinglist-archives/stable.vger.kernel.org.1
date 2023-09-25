Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607537ACE8B
	for <lists+stable@lfdr.de>; Mon, 25 Sep 2023 04:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjIYC6t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 24 Sep 2023 22:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYC6s (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 24 Sep 2023 22:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76548A3
        for <stable@vger.kernel.org>; Sun, 24 Sep 2023 19:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695610681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03qSg2yEAIVwRPqjjQs4G4M60zsU0m+0zE8R/M2ccL4=;
        b=Gx7p+WNaMcz41qn7JSOpljDkAZ+m4EuctKM8tD7FgNW2+zGr5N6AZQhGGJ0Qd9i7wLf/Ja
        EDdTrRU19+BIvyt/bQ+iseTcH0qGhY9lDo31XnNdM95O75qLAWC+RYPkJEnecBhHmmkWOK
        JYfR8ElawbhwEAXoXoniewbgcVYuVx4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-UxUYx7sFOtKV5dI8Mb3zpQ-1; Sun, 24 Sep 2023 22:57:59 -0400
X-MC-Unique: UxUYx7sFOtKV5dI8Mb3zpQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50421897564so7582182e87.0
        for <stable@vger.kernel.org>; Sun, 24 Sep 2023 19:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695610678; x=1696215478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03qSg2yEAIVwRPqjjQs4G4M60zsU0m+0zE8R/M2ccL4=;
        b=hsBUiWrBmPfCIJewItw/HbK2AA2VCZPXpl+Fbq495zrvJ4zRkmDmCgl1WtJIMVoCBT
         IHjQLo3o5JmRo7sYAYy2ZgpzWmQafO4tBzuBgHFsKEDvnNkttLz304dcnFOV+Ih1Ty7/
         6WyQtks1Qk9mbdhV6l63AOkzFBcmmf5bflZqrE1IWWprJLHeKvtyAAHdDyYan7mCrGm/
         arZieddFdD3wBWugrreL1oprmQeg9iVT67DcYdhGMDBTgqwLj4LTfTmxix55qRkpy7CX
         8uASOPg4o6S0EOlHDfvbpYP+kwx6rQLcstdxlSeCryYpwLBZS6T8l62g1DCe2c+QZWnD
         tJXw==
X-Gm-Message-State: AOJu0YxI6pmHuJ1l6eY2fKMP/hBOT4+hfAwkVZV7oo3iBq2vRD9cE7Ng
        14bLxxMbsBaN132nLnrq07hjKpGk5zvLyG7gjic0dTAaAd4EVHlBxyUWdr97klbIUe4bsM1Lk0n
        1sMElRNR1xK16TUIVYe63oWmOteUK5Qk6
X-Received: by 2002:a05:6512:12c5:b0:4fb:8948:2b28 with SMTP id p5-20020a05651212c500b004fb89482b28mr5070668lfg.63.1695610678403;
        Sun, 24 Sep 2023 19:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHF2qhzIv6Pe7cJCbr0RrCTBfYBL4roCVlrTfhCiGgKQygDz63GyQyQzV/OUarEVYJNkAsC1zhXb8toENTH6k=
X-Received: by 2002:a05:6512:12c5:b0:4fb:8948:2b28 with SMTP id
 p5-20020a05651212c500b004fb89482b28mr5070657lfg.63.1695610678004; Sun, 24 Sep
 2023 19:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-5-lulu@redhat.com>
 <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com> <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com>
In-Reply-To: <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Sep 2023 10:57:47 +0800
Message-ID: <CACGkMEt-m9bOh9YnqLw0So5wqbZ69D0XRVBbfG73Oh7Q8qTJsQ@mail.gmail.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, maxime.coquelin@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 21, 2023 at 10:07=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, Sep 18, 2023 at 4:49=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Sep 12, 2023 at 11:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> > >
> > > In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
> > > and The number of mapping memory pages from the kernel. The userspace
> > > App can use this information to map the pages.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++++++
> > >  include/uapi/linux/vduse.h         | 15 +++++++++++++++
> > >  2 files changed, 30 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 680b23dbdde2..c99f99892b5c 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1368,6 +1368,21 @@ static long vduse_dev_ioctl(struct file *file,=
 unsigned int cmd,
> > >                 ret =3D 0;
> > >                 break;
> > >         }
> > > +       case VDUSE_GET_RECONNECT_INFO: {
> > > +               struct vduse_reconnect_mmap_info info;
> > > +
> > > +               ret =3D -EFAULT;
> > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > +                       break;
> > > +
> > > +               info.size =3D PAGE_SIZE;
> > > +               info.max_index =3D dev->vq_num + 1;
> > > +
> > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > +                       break;
> > > +               ret =3D 0;
> > > +               break;
> > > +       }
> > >         default:
> > >                 ret =3D -ENOIOCTLCMD;
> > >                 break;
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index d585425803fd..ce55e34f63d7 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -356,4 +356,19 @@ struct vhost_reconnect_vring {
> > >         _Bool avail_wrap_counter;
> > >  };
> > >
> > > +/**
> > > + * struct vduse_reconnect_mmap_info
> > > + * @size: mapping memory size, always page_size here
> > > + * @max_index: the number of pages allocated in kernel,just
> > > + * use for check
> > > + */
> > > +
> > > +struct vduse_reconnect_mmap_info {
> > > +       __u32 size;
> > > +       __u32 max_index;
> > > +};
> >
> > One thing I didn't understand is that, aren't the things we used to
> > store connection info belong to uAPI? If not, how can we make sure the
> > connections work across different vendors/implementations. If yes,
> > where?
> >
> > Thanks
> >
> The process for this reconnecttion  is
> A.The first-time connection
> 1> The userland app checks if the device exists
> 2>  use the ioctl to create the vduse device
> 3> Mapping the kernel page to userland and save the
> App-version/features/other information to this page
> 4>  if the Userland app needs to exit, then the Userland app will only
> unmap the page and then exit
>
> B, the re-connection
> 1> the userland app finds the device is existing
> 2> Mapping the kernel page to userland
> 3> check if the information in shared memory is satisfied to
> reconnect,if ok then continue to reconnect
> 4> continue working
>
>  For now these information are all from userland,So here the page will
> be maintained by the userland App
> in the previous code we only saved the api-version by uAPI .  if  we
> need to support reconnection maybe we need to add 2 new uAPI for this,
> one of the uAPI is to save the reconnect  information and another is
> to get the information
>
> maybe something like
>
> struct vhost_reconnect_data {
> uint32_t version;
> uint64_t features;
> uint8_t status;
> struct virtio_net_config config;
> uint32_t nr_vrings;
> };

Probably, then we can make sure the re-connection works across
different vduse-daemon implementations.

>
> #define VDUSE_GET_RECONNECT_INFO _IOR (VDUSE_BASE, 0x1c, struct
> vhost_reconnect_data)
>
> #define VDUSE_SET_RECONNECT_INFO  _IOWR(VDUSE_BASE, 0x1d, struct
> vhost_reconnect_data)

Not sure I get this, but the idea is to map those pages to user space,
any reason we need this uAPI?

Thanks

>
> Thanks
> Cindy
>
>
>
>
> > > +
> > > +#define VDUSE_GET_RECONNECT_INFO \
> > > +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> > > +
> > >  #endif /* _UAPI_VDUSE_H_ */
> > > --
> > > 2.34.3
> > >
> >
>

