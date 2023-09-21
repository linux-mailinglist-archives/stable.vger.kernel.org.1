Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5E97A9E4D
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 22:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjIUT74 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 15:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjIUT7S (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 15:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BC8566D7
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695316681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlC67XxjnP+ZVW2NhM88mr2tYX+uJkcJVmDqrakHLxg=;
        b=VU2LT1mz5JbntVTGf/ZCuhURAY0yN0iDepEZ/jNpIn2EZzhx9v8drAs6xhHKEbxT0aoojT
        /PS+WiCetrv8E5/KKCa/elPi8FGVnH6fPlyfjvgFyEb7i+vJlrQIFaySlqxY5A9T/AQqod
        V1zec4+gT5J7K6KSn8D4Ua2/yTVKJTQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-DTzJ-8SnMaukuK3ihlUoKQ-1; Thu, 21 Sep 2023 10:02:35 -0400
X-MC-Unique: DTzJ-8SnMaukuK3ihlUoKQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401bdff6bc5so7830685e9.1
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 07:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695304949; x=1695909749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlC67XxjnP+ZVW2NhM88mr2tYX+uJkcJVmDqrakHLxg=;
        b=b+Cq3Ja/4xW802xVnE4vHnt4CkV5LuCk3ffXtbY6z9HyVdsqfWWf08CJJ2OhX+C3Us
         r5O7FgAwEKVmcsIP0yHb0GOglbPApTy72A+w90mTYtqXgAjQQ4gcUgwW3ui54hUIEess
         H2We/KnorAzbHm3MD1y9QxQeYT8kHNVtgfDMIvuI4VrpdJXcQaQTSHta0mrjW7v2zJA1
         x4lSrgugASMLINEGTSYui8FCKwD+VCQaHFQobTpnlbiuWRFuLp+up9KfmH9+i2L6GTma
         Y3olEnUp54bgAvl1/7AVj28VCQLSFDvnOUxLImPOF2WbQjIRmgdAL5FDDZp6XbhgrlSA
         85Cg==
X-Gm-Message-State: AOJu0YzVqKqIMHedP4KFDZo1ii7yD/ijR9pNIMXxMhNXWOsBb1CwXx8e
        C1dCpocUPpPoGv41BHBFP2W1GptzvgWccqTzxGLB/vt5MSZ906+8BXvjtRMxo3uZTh+zjCM9y1Q
        vSYElgmqC8g3tbsr7VebuC7JPCCP8X6gl
X-Received: by 2002:a5d:6909:0:b0:31f:f1f4:ca8e with SMTP id t9-20020a5d6909000000b0031ff1f4ca8emr5334198wru.36.1695304949279;
        Thu, 21 Sep 2023 07:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNTL6nYnReHMxIE2eeSXN3WfDyrQQNkn8rAgYHxF7+Q3qpnqcBEXgV8EV9/Y02we+Lvs9Dzqktaq7bM20Yrgk=
X-Received: by 2002:a5d:6909:0:b0:31f:f1f4:ca8e with SMTP id
 t9-20020a5d6909000000b0031ff1f4ca8emr5334163wru.36.1695304948913; Thu, 21 Sep
 2023 07:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-5-lulu@redhat.com>
 <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
In-Reply-To: <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 21 Sep 2023 22:01:46 +0800
Message-ID: <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, maxime.coquelin@redhat.com,
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

On Mon, Sep 18, 2023 at 4:49=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Sep 12, 2023 at 11:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
> > and The number of mapping memory pages from the kernel. The userspace
> > App can use this information to map the pages.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++++++
> >  include/uapi/linux/vduse.h         | 15 +++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 680b23dbdde2..c99f99892b5c 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1368,6 +1368,21 @@ static long vduse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >                 ret =3D 0;
> >                 break;
> >         }
> > +       case VDUSE_GET_RECONNECT_INFO: {
> > +               struct vduse_reconnect_mmap_info info;
> > +
> > +               ret =3D -EFAULT;
> > +               if (copy_from_user(&info, argp, sizeof(info)))
> > +                       break;
> > +
> > +               info.size =3D PAGE_SIZE;
> > +               info.max_index =3D dev->vq_num + 1;
> > +
> > +               if (copy_to_user(argp, &info, sizeof(info)))
> > +                       break;
> > +               ret =3D 0;
> > +               break;
> > +       }
> >         default:
> >                 ret =3D -ENOIOCTLCMD;
> >                 break;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index d585425803fd..ce55e34f63d7 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -356,4 +356,19 @@ struct vhost_reconnect_vring {
> >         _Bool avail_wrap_counter;
> >  };
> >
> > +/**
> > + * struct vduse_reconnect_mmap_info
> > + * @size: mapping memory size, always page_size here
> > + * @max_index: the number of pages allocated in kernel,just
> > + * use for check
> > + */
> > +
> > +struct vduse_reconnect_mmap_info {
> > +       __u32 size;
> > +       __u32 max_index;
> > +};
>
> One thing I didn't understand is that, aren't the things we used to
> store connection info belong to uAPI? If not, how can we make sure the
> connections work across different vendors/implementations. If yes,
> where?
>
> Thanks
>
The process for this reconnecttion  is
A.The first-time connection
1> The userland app checks if the device exists
2>  use the ioctl to create the vduse device
3> Mapping the kernel page to userland and save the
App-version/features/other information to this page
4>  if the Userland app needs to exit, then the Userland app will only
unmap the page and then exit

B, the re-connection
1> the userland app finds the device is existing
2> Mapping the kernel page to userland
3> check if the information in shared memory is satisfied to
reconnect,if ok then continue to reconnect
4> continue working

 For now these information are all from userland,So here the page will
be maintained by the userland App
in the previous code we only saved the api-version by uAPI .  if  we
need to support reconnection maybe we need to add 2 new uAPI for this,
one of the uAPI is to save the reconnect  information and another is
to get the information

maybe something like

struct vhost_reconnect_data {
uint32_t version;
uint64_t features;
uint8_t status;
struct virtio_net_config config;
uint32_t nr_vrings;
};

#define VDUSE_GET_RECONNECT_INFO _IOR (VDUSE_BASE, 0x1c, struct
vhost_reconnect_data)

#define VDUSE_SET_RECONNECT_INFO  _IOWR(VDUSE_BASE, 0x1d, struct
vhost_reconnect_data)

Thanks
Cindy




> > +
> > +#define VDUSE_GET_RECONNECT_INFO \
> > +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> > +
> >  #endif /* _UAPI_VDUSE_H_ */
> > --
> > 2.34.3
> >
>

