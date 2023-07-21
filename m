Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB0875BCBE
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 05:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGUDU5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 23:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGUDUz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 23:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891F2737
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 20:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689909603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYC8NzIvQBfwMzCN4Y1JOBLQ6XrEE/2B7fUpOXrUmEI=;
        b=UOou8QTfjxXTcno8FoKmJcG0BQpk9GOfcU4bKaKsjYjMqHecL4M2mgy+YZRCRlwJvOKk8u
        yObIxoix7UNvhgiw460+kD+R3ZzFYTdtgNO9KRsaFuX2+huQLDAHYNCuRUXo7l3n2nGofN
        XegKuHysKOv9chbWP++B9yWOcKlFrnE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-rjIt131FOt-s2BXL25b6qA-1; Thu, 20 Jul 2023 23:20:02 -0400
X-MC-Unique: rjIt131FOt-s2BXL25b6qA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9932e8e76b9so108227866b.3
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 20:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689909601; x=1690514401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYC8NzIvQBfwMzCN4Y1JOBLQ6XrEE/2B7fUpOXrUmEI=;
        b=AYiwFZKPxXhopw51BeS5dzGTUJNP6vqZRVaCoZ7cJMEG2NjGj9Gn6WE3Zcr4p+Mvnl
         /PMzBwrs93NqDDUiG1a/4luHhy1wKAsZYYYw0QTQCOKr8chg1tT1FiNYL9tmRpcmGr9Z
         luQhnhwAhAP5AEb/OAvVUJF8Ft9Sa582VWX6FA+l4WAlgFB0aurAGIucq/f6olSDyfmL
         qsKvshMcRUyRbDrO/hSnPIiZ0s7yxir0A85Bc7sBfN+h13sXCbAMItcZWZb45zwQmPGn
         g5U2Uxdx3sh6RF+hzg615N5jMI+fo1DpIzp094gL7mVkAIMaD2oPY1mn8fmRwBPtLncY
         QpLA==
X-Gm-Message-State: ABy/qLbSHJRkR82i28IlR7V8AYK7fQNaQnJPXy+lcB5Fvp/xyG8fjVb7
        79y3vbGyg8HCq9l0WcJS9L189UDbEMMur66n53UC8g3j8YZ4tPjiXd7bgCYoMrQA88dwhwMmiyU
        ZJfmI1tEvUmq4j7tfbpohj06EUA22MWuH
X-Received: by 2002:a17:907:2cd0:b0:997:e7d9:50f7 with SMTP id hg16-20020a1709072cd000b00997e7d950f7mr524602ejc.66.1689909601021;
        Thu, 20 Jul 2023 20:20:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxZ/7dmQ0ACW+P/oCGilRh3gbPCGWZCS1cQlobNnvAlXPulCfJCA6v70a4Rl8/p73DNoW7OzSpxKuezbFoMUo=
X-Received: by 2002:a17:907:2cd0:b0:997:e7d9:50f7 with SMTP id
 hg16-20020a1709072cd000b00997e7d950f7mr524588ejc.66.1689909600689; Thu, 20
 Jul 2023 20:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230629033533.270535-1-xiubli@redhat.com>
In-Reply-To: <20230629033533.270535-1-xiubli@redhat.com>
From:   Milind Changire <mchangir@redhat.com>
Date:   Fri, 21 Jul 2023 08:49:24 +0530
Message-ID: <CAED=hWCkMMjina5q1VhygNnkHD+nqLfeNKVp8Oof623K6iEwbw@mail.gmail.com>
Subject: Re: [PATCH] ceph: defer stopping the mdsc delayed_work
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Looks good to me.

nit: typo for perioudically in commit message

Reviewed-by: Milind Changire <mchangir@redhat.com>


On Thu, Jun 29, 2023 at 9:07=E2=80=AFAM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Flushing the dirty buffer may take a long time if the Rados is
> overloaded or if there is network issue. So we should ping the
> MDSs perioudically to keep alive, else the MDS will blocklist
> the kclient.
>
> Cc: stable@vger.kernel.org
> Cc: Venky Shankar <vshankar@redhat.com>
> URL: https://tracker.ceph.com/issues/61843
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/mds_client.c | 2 +-
>  fs/ceph/mds_client.h | 3 ++-
>  fs/ceph/super.c      | 7 ++++---
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 65230ebefd51..70987b3c198a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5192,7 +5192,7 @@ static void delayed_work(struct work_struct *work)
>
>         doutc(mdsc->fsc->client, "mdsc delayed_work\n");
>
> -       if (mdsc->stopping)
> +       if (mdsc->stopping >=3D CEPH_MDSC_STOPPING_FLUSHED)
>                 return;
>
>         mutex_lock(&mdsc->mutex);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 5d02c8c582fd..befbd384428e 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -400,7 +400,8 @@ struct cap_wait {
>
>  enum {
>         CEPH_MDSC_STOPPING_BEGIN =3D 1,
> -       CEPH_MDSC_STOPPING_FLUSHED =3D 2,
> +       CEPH_MDSC_STOPPING_FLUSHING =3D 2,
> +       CEPH_MDSC_STOPPING_FLUSHED =3D 3,
>  };
>
>  /*
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 8e1e517a45db..fb694ba72955 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1488,7 +1488,7 @@ static int ceph_init_fs_context(struct fs_context *=
fc)
>  static bool __inc_stopping_blocker(struct ceph_mds_client *mdsc)
>  {
>         spin_lock(&mdsc->stopping_lock);
> -       if (mdsc->stopping >=3D CEPH_MDSC_STOPPING_FLUSHED) {
> +       if (mdsc->stopping >=3D CEPH_MDSC_STOPPING_FLUSHING) {
>                 spin_unlock(&mdsc->stopping_lock);
>                 return false;
>         }
> @@ -1501,7 +1501,7 @@ static void __dec_stopping_blocker(struct ceph_mds_=
client *mdsc)
>  {
>         spin_lock(&mdsc->stopping_lock);
>         if (!atomic_dec_return(&mdsc->stopping_blockers) &&
> -           mdsc->stopping >=3D CEPH_MDSC_STOPPING_FLUSHED)
> +           mdsc->stopping >=3D CEPH_MDSC_STOPPING_FLUSHING)
>                 complete_all(&mdsc->stopping_waiter);
>         spin_unlock(&mdsc->stopping_lock);
>  }
> @@ -1562,7 +1562,7 @@ static void ceph_kill_sb(struct super_block *s)
>         sync_filesystem(s);
>
>         spin_lock(&mdsc->stopping_lock);
> -       mdsc->stopping =3D CEPH_MDSC_STOPPING_FLUSHED;
> +       mdsc->stopping =3D CEPH_MDSC_STOPPING_FLUSHING;
>         wait =3D !!atomic_read(&mdsc->stopping_blockers);
>         spin_unlock(&mdsc->stopping_lock);
>
> @@ -1576,6 +1576,7 @@ static void ceph_kill_sb(struct super_block *s)
>                         pr_warn_client(cl, "umount was killed, %ld\n", ti=
meleft);
>         }
>
> +       mdsc->stopping =3D CEPH_MDSC_STOPPING_FLUSHED;
>         kill_anon_super(s);
>
>         fsc->client->extra_mon_dispatch =3D NULL;
> --
> 2.40.1
>


--=20
Milind

