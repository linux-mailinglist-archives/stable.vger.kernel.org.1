Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D887A9EEB
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 22:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjIUUOS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 16:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjIUUNz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 16:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A7D448A
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695316944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqoOPgme4Uuv5hKrBPiJj6+uKIVnMHAtPkgpqGU6vG4=;
        b=TWSl9O1w12Vb7S1rK8jOQ2jInvDieEPYn6pKYNPhtnAjjJWk+qv/l0/C8DuFONBAD6C3G+
        ESWMVUXoHaikX0GET0GHeoz9I8lMWIliQMXsomQ3ar0Xg5VHn/yFFqdYw3vfM8wx0phtkf
        qrmINJbr79d1gq02jPCDqVlFyBexVWg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-yrLyIV8YPu6nvNS_mim-Xg-1; Thu, 21 Sep 2023 10:07:01 -0400
X-MC-Unique: yrLyIV8YPu6nvNS_mim-Xg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-321544abeeeso679939f8f.1
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 07:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695305219; x=1695910019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqoOPgme4Uuv5hKrBPiJj6+uKIVnMHAtPkgpqGU6vG4=;
        b=RqZW5nbjtqSRfpVa3sj3Prd59kwp1o8MO8KyytWCzn2Hf12nR7V7FWWTo1ECdGpR0f
         XGJjjOyM8Ievnfju1PSMrD0VCubzFOkacwRsdQKj1vUMjWes+mLQEbna2NNsr33zSjeC
         nlQepeLRFi/S7kv/oBJ9vm7ADKOM99q4T9ZTaoq2ypgBCDiwhHwiFyT6U3kWC4nB+CoQ
         dGuZPHmGfTUlvVNG8W4lQh5SJ99Pyer7K2WCvMW3SHazxjxZaMS5NRQ+oiM6EDSVac0S
         9BDSzRrXudg8TpYas+2YNF7PEbj36yWIy9XIjqy6rfvNoFOVqj/Q0Zmb5RF+VkNoSGRU
         0GIQ==
X-Gm-Message-State: AOJu0YzB0JSKgTOqOkc4yJDKXYTpWtVfkrvOhC1xc0j41YnZ4K9uUBjs
        P4rjMlqKFUyFye+L+aXL9MeeYKWBLHh59d7ZEdOHVQOvd1yoZJGiSSSYyBZPzjJnartxTwu9rEQ
        nOlz4nKvA84E8KZZc0K90HU2Xcj3whr1U
X-Received: by 2002:adf:e604:0:b0:319:7c7d:8d1 with SMTP id p4-20020adfe604000000b003197c7d08d1mr4559816wrm.44.1695305219568;
        Thu, 21 Sep 2023 07:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc9cPDe47gAzDmyMLuyvubfic4IfTmoR2y3Zwjncq14ViwH92x3CA0CL7uTBYmXwPLmcQOAKYKkzdqCkjcTCA=
X-Received: by 2002:adf:e604:0:b0:319:7c7d:8d1 with SMTP id
 p4-20020adfe604000000b003197c7d08d1mr4559793wrm.44.1695305219207; Thu, 21 Sep
 2023 07:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-2-lulu@redhat.com>
 <CACGkMEuwjga949gGBKyZozfppMa2UF5mu8wuk4o88Qi6GthtXw@mail.gmail.com>
In-Reply-To: <CACGkMEuwjga949gGBKyZozfppMa2UF5mu8wuk4o88Qi6GthtXw@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 21 Sep 2023 22:06:16 +0800
Message-ID: <CACLfguUu83eYPr=yaSMEAm77igOvdc1ZF-LPNPRcbKrg1OsbUA@mail.gmail.com>
Subject: Re: [RFC v2 1/4] vduse: Add function to get/free the pages for reconnection
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 18, 2023 at 4:41=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Sep 12, 2023 at 11:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > Add the function vduse_alloc_reconnnect_info_mem
> > and vduse_alloc_reconnnect_info_mem
> > In this 2 function, vduse will get/free (vq_num + 1)*page
> > Page 0 will be used to save the reconnection information, The
> > Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
> > the reconnection information for vqs.
>
> Please explain why this is needed instead of only describing how it is
> implemented. (Code can explain itself).
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 86 ++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 26b7e29cb900..4c256fa31fc4 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -30,6 +30,10 @@
> >  #include <uapi/linux/virtio_blk.h>
> >  #include <linux/mod_devicetable.h>
> >
> > +#ifdef CONFIG_X86
> > +#include <asm/set_memory.h>
> > +#endif
> > +
> >  #include "iova_domain.h"
> >
> >  #define DRV_AUTHOR   "Yongji Xie <xieyongji@bytedance.com>"
> > @@ -41,6 +45,23 @@
> >  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
> >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> >
> > +/* struct vdpa_reconnect_info save the page information for reconnecti=
on
> > + * kernel will init these information while alloc the pages
> > + * and use these information to free the pages
> > + */
> > +struct vdpa_reconnect_info {
> > +       /* Offset (within vm_file) in PAGE_SIZE,
> > +        * this just for check, not using
> > +        */
> > +       u32 index;
> > +       /* physical address for this page*/
> > +       phys_addr_t addr;
> > +       /* virtual address for this page*/
> > +       unsigned long vaddr;
>
> If it could be switched by virt_to_phys() why duplicate those fields?
>
yes will remove this part
Thanks
Cindy
> > +       /* memory size, here always page_size*/
> > +       phys_addr_t size;
>
> If it's always PAGE_SIZE why would we have this?
will remove this
Thanks
Cindy
>
> > +};
> > +
> >  struct vduse_virtqueue {
> >         u16 index;
> >         u16 num_max;
> > @@ -57,6 +78,7 @@ struct vduse_virtqueue {
> >         struct vdpa_callback cb;
> >         struct work_struct inject;
> >         struct work_struct kick;
> > +       struct vdpa_reconnect_info reconnect_info;
> >  };
> >
> >  struct vduse_dev;
> > @@ -106,6 +128,7 @@ struct vduse_dev {
> >         u32 vq_align;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> > +       struct vdpa_reconnect_info reconnect_status;
> >  };
> >
> >  struct vduse_dev_msg {
> > @@ -1030,6 +1053,65 @@ static int vduse_dev_reg_umem(struct vduse_dev *=
dev,
> >         return ret;
> >  }
> >
> > +int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +       struct vdpa_reconnect_info *info;
> > +       struct vduse_virtqueue *vq;
> > +       void *addr;
> > +
> > +       /*page 0 is use to save status,dpdk will use this to save the i=
nformation
> > +        *needed in reconnection,kernel don't need to maintain this
> > +        */
> > +       info =3D &dev->reconnect_status;
> > +       addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> > +       if (!addr)
> > +               return -1;
>
> -ENOMEM?
>
sure will change this
Thanks
Cidny
> Thanks
>

