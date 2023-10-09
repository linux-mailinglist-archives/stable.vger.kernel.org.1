Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BC7BD248
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 05:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjJIDCZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 23:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjJIDCZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 23:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825119E
        for <stable@vger.kernel.org>; Sun,  8 Oct 2023 20:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696820501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfPpj/NYnLhR9rt7gcQcCsZvzAr7nC8MCFto+fdVExs=;
        b=SxSVbgTwnJ9efB5SQhRtIzf06tnbarvWjfd8dLs6GqK4D8/WPTNdYVETyVPT6WfVIwAqpo
        cf/YjX21QuixmtQGGefhQdavnVSRJ40VA+glhBReg4quYKjAlhfXvMRO8xE5kbif38tf0+
        qLpcWP0PKmnK1/vz4TLMBAqEZMhY2gQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-gCttNOvcMiauv4JGi8SGaQ-1; Sun, 08 Oct 2023 23:01:40 -0400
X-MC-Unique: gCttNOvcMiauv4JGi8SGaQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae57d8b502so328607866b.2
        for <stable@vger.kernel.org>; Sun, 08 Oct 2023 20:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696820499; x=1697425299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfPpj/NYnLhR9rt7gcQcCsZvzAr7nC8MCFto+fdVExs=;
        b=n+GFsUa3d2VrbeorU/FWUHbyihsbo2nVXqb/WGmxaGbXMsqa22V/tAQBo7LRJGMycx
         aC01Z+DvtE+skMKlRHCPGixwqpajqsoBeMGIv1e3h0Ezheu9AWZ2WO3Gjqrlgl/+NcZZ
         blmssw51YqJej/ekKnKHW49eJ2GiN22J8T5S/pdkXB/oEaFxgMn0qUK/GW0cMVMuj2WN
         Efin5P6+4YxrpWva2tqvNQunc1i3YhzUcUuNNsEOrTknbGeMaZNmaqyDVKQWk5c8KNpT
         Y2ibUzzdgRhOV+rGe53oV1ZS6POmjcct8MpoLAGI9LQsF8DRZsxDzBlhdBs3kjC4oCw1
         jZkw==
X-Gm-Message-State: AOJu0YzxhyVhi6xn/T290Sb5ZUXt8hbs4b9y6TUvYMhIq4EIW/G5dvQx
        Gcf6JEVy7+O4AEUQ2cYdhF8A1cPM6e8DNSu9seZDW+FR/rl9Cz3JOf/8w7vBxLEdPJKSZryYrzg
        qFgh1PNUKlUqq+HlrtxV/ZR+p4HFdXFwn
X-Received: by 2002:aa7:da83:0:b0:533:d81b:36d5 with SMTP id q3-20020aa7da83000000b00533d81b36d5mr11984917eds.15.1696820498954;
        Sun, 08 Oct 2023 20:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg4sPgUHGxpJD5KhVuPwe4H/WIDtwx1mSl/00KPjO0l64EypHEQ5kVl/x8SOlNYipG4eXQiG5yboehI1B3TtU=
X-Received: by 2002:aa7:da83:0:b0:533:d81b:36d5 with SMTP id
 q3-20020aa7da83000000b00533d81b36d5mr11984907eds.15.1696820498625; Sun, 08
 Oct 2023 20:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-5-lulu@redhat.com>
 <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
 <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com>
 <CACGkMEt-m9bOh9YnqLw0So5wqbZ69D0XRVBbfG73Oh7Q8qTJsQ@mail.gmail.com> <6c4cd924-0d44-582e-13a4-791f38d10fe8@redhat.com>
In-Reply-To: <6c4cd924-0d44-582e-13a4-791f38d10fe8@redhat.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Mon, 9 Oct 2023 11:00:30 +0800
Message-ID: <CACLfguVTxZR2U-CFhkFWYFcgvB-6TLcQjUaEvtm+oka2XstVqw@mail.gmail.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 29, 2023 at 5:08=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 9/25/23 04:57, Jason Wang wrote:
> > On Thu, Sep 21, 2023 at 10:07=E2=80=AFPM Cindy Lu <lulu@redhat.com> wro=
te:
> >>
> >> On Mon, Sep 18, 2023 at 4:49=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>>
> >>> On Tue, Sep 12, 2023 at 11:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> w=
rote:
> >>>>
> >>>> In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
> >>>> and The number of mapping memory pages from the kernel. The userspac=
e
> >>>> App can use this information to map the pages.
> >>>>
> >>>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >>>> ---
> >>>>   drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++++++
> >>>>   include/uapi/linux/vduse.h         | 15 +++++++++++++++
> >>>>   2 files changed, 30 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_=
user/vduse_dev.c
> >>>> index 680b23dbdde2..c99f99892b5c 100644
> >>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >>>> @@ -1368,6 +1368,21 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> >>>>                  ret =3D 0;
> >>>>                  break;
> >>>>          }
> >>>> +       case VDUSE_GET_RECONNECT_INFO: {
> >>>> +               struct vduse_reconnect_mmap_info info;
> >>>> +
> >>>> +               ret =3D -EFAULT;
> >>>> +               if (copy_from_user(&info, argp, sizeof(info)))
> >>>> +                       break;
> >>>> +
> >>>> +               info.size =3D PAGE_SIZE;
> >>>> +               info.max_index =3D dev->vq_num + 1;
> >>>> +
> >>>> +               if (copy_to_user(argp, &info, sizeof(info)))
> >>>> +                       break;
> >>>> +               ret =3D 0;
> >>>> +               break;
> >>>> +       }
> >>>>          default:
> >>>>                  ret =3D -ENOIOCTLCMD;
> >>>>                  break;
> >>>> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> >>>> index d585425803fd..ce55e34f63d7 100644
> >>>> --- a/include/uapi/linux/vduse.h
> >>>> +++ b/include/uapi/linux/vduse.h
> >>>> @@ -356,4 +356,19 @@ struct vhost_reconnect_vring {
> >>>>          _Bool avail_wrap_counter;
> >>>>   };
> >>>>
> >>>> +/**
> >>>> + * struct vduse_reconnect_mmap_info
> >>>> + * @size: mapping memory size, always page_size here
> >>>> + * @max_index: the number of pages allocated in kernel,just
> >>>> + * use for check
> >>>> + */
> >>>> +
> >>>> +struct vduse_reconnect_mmap_info {
> >>>> +       __u32 size;
> >>>> +       __u32 max_index;
> >>>> +};
> >>>
> >>> One thing I didn't understand is that, aren't the things we used to
> >>> store connection info belong to uAPI? If not, how can we make sure th=
e
> >>> connections work across different vendors/implementations. If yes,
> >>> where?
> >>>
> >>> Thanks
> >>>
> >> The process for this reconnecttion  is
> >> A.The first-time connection
> >> 1> The userland app checks if the device exists
> >> 2>  use the ioctl to create the vduse device
> >> 3> Mapping the kernel page to userland and save the
> >> App-version/features/other information to this page
> >> 4>  if the Userland app needs to exit, then the Userland app will only
> >> unmap the page and then exit
> >>
> >> B, the re-connection
> >> 1> the userland app finds the device is existing
> >> 2> Mapping the kernel page to userland
> >> 3> check if the information in shared memory is satisfied to
> >> reconnect,if ok then continue to reconnect
> >> 4> continue working
> >>
> >>   For now these information are all from userland,So here the page wil=
l
> >> be maintained by the userland App
> >> in the previous code we only saved the api-version by uAPI .  if  we
> >> need to support reconnection maybe we need to add 2 new uAPI for this,
> >> one of the uAPI is to save the reconnect  information and another is
> >> to get the information
> >>
> >> maybe something like
> >>
> >> struct vhost_reconnect_data {
> >> uint32_t version;
> >> uint64_t features;
> >> uint8_t status;
> >> struct virtio_net_config config;
> >> uint32_t nr_vrings;
> >> };
> >
> > Probably, then we can make sure the re-connection works across
> > different vduse-daemon implementations.
>
> +1, we need to have this defined in the uAPI to support interoperability
> across different VDUSE userspace implementations.
>
> >
> >>
> >> #define VDUSE_GET_RECONNECT_INFO _IOR (VDUSE_BASE, 0x1c, struct
> >> vhost_reconnect_data)
> >>
> >> #define VDUSE_SET_RECONNECT_INFO  _IOWR(VDUSE_BASE, 0x1d, struct
> >> vhost_reconnect_data)
> >
> > Not sure I get this, but the idea is to map those pages to user space,
> > any reason we need this uAPI?
>
> It should not be necessary if the mmapped layout is properly defined.
>
> Thanks,
> Maxime
>
Sure , I will use mmap to sync the reconnect status
Thanks
cindy
> > Thanks
> >
> >>
> >> Thanks
> >> Cindy
> >>
> >>
> >>
> >>
> >>>> +
> >>>> +#define VDUSE_GET_RECONNECT_INFO \
> >>>> +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> >>>> +
> >>>>   #endif /* _UAPI_VDUSE_H_ */
> >>>> --
> >>>> 2.34.3
> >>>>
> >>>
> >>
> >
>

