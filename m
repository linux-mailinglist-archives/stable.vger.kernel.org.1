Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5E769534
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjGaLtP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 07:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjGaLtO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 07:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25424A1
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690804107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YziiKnn8voDaCyjPYmisx0zTR3jRLqnBFMA9BcQ83PU=;
        b=chYnjydiKuRGCJbMxWIKotC9qip4nmGuu0mLHwYUqD6Rh/BKEFx+ySzt+V1k1KPO/jMdHd
        ZRAtOHBhshXptezxQJoELwMuMuKIasbAMg+fybJzBNbvQdonb/DKMcyrIOtWo1mC0L/pBy
        CSOpmZjLPAJ7zCuiiHFxSz9wsSNGmDk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Cd5isaP-Mvy2RTAyUdtjYQ-1; Mon, 31 Jul 2023 07:48:26 -0400
X-MC-Unique: Cd5isaP-Mvy2RTAyUdtjYQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9b50be2ccso35291921fa.2
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 04:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690804104; x=1691408904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YziiKnn8voDaCyjPYmisx0zTR3jRLqnBFMA9BcQ83PU=;
        b=eA54nbeO4tj1DmnIohlYyR6+pITVMtnpwwuBGtCSVruPEJY0BZ7k2V1YM1b2qE2W75
         9U9iGTHkGfQLoEd/NJILAsoN7G9Ac866XH9iBEjG1Q6/wDfIy5L9cBpXXyuWsdnnxv7V
         Wu5+483TtB3eKTKe8xfZHYK9FyBCGOWkqeMwlFwgMhmZ5IjPasB4LLIrln9DQ76WUMv9
         6/7lQQNzLZ3jsToLxC8cniP3icvvy2x/RKiS+S3i/EomdAjBYsKE0RHsYcZoKxybT+UP
         CbiONsGddSakRdYN59hF5XqwQ0wUkMCBPcCISjefmavS3s866hXzT2TYLVLxALs7F1EB
         hmRg==
X-Gm-Message-State: ABy/qLZ2SOaA/qHRCgCiimekH15prB49Qw+pcJsf6gdUPVw+zwUkOPCz
        zdtfGhWK1oEEVKs/YrKY+vRs71rJjpzihRqnPsfKVNy8F2xlf/Rp1Rjs7onR3UC3W6lBQaTBexW
        CZ0IRHiad910GYu4aHI+O4sN5JCSy5lEq
X-Received: by 2002:a2e:8782:0:b0:2b6:d8e4:71b3 with SMTP id n2-20020a2e8782000000b002b6d8e471b3mr6095248lji.21.1690804104527;
        Mon, 31 Jul 2023 04:48:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEFLDFU8nctGmGZYlJJsepp3JQbR5ZTrNQrhQtKN5zMX4xzl1Dda86TPz8ftDRZvxGgqub7EKAou43A9GX9yX0=
X-Received: by 2002:a2e:8782:0:b0:2b6:d8e4:71b3 with SMTP id
 n2-20020a2e8782000000b002b6d8e471b3mr6095237lji.21.1690804104195; Mon, 31 Jul
 2023 04:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230725040359.363444-1-xiubli@redhat.com>
In-Reply-To: <20230725040359.363444-1-xiubli@redhat.com>
From:   Milind Changire <mchangir@redhat.com>
Date:   Mon, 31 Jul 2023 17:17:48 +0530
Message-ID: <CAED=hWDNP2AsnqHWxyHxuQij1KWVoT+oEETD7r3GqtBP=k7yBA@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: defer stopping the mdsc delayed_work
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 9:36=E2=80=AFAM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Flushing the dirty buffer may take a long time if the Rados is
> overloaded or if there is network issue. So we should ping the
> MDSs periodically to keep alive, else the MDS will blocklist
> the kclient.
>
> Cc: stable@vger.kernel.org
> Cc: Venky Shankar <vshankar@redhat.com>
> URL: https://tracker.ceph.com/issues/61843
> Reviewed-by: Milind Changire <mchangir@redhat.com>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>
> V3:
> - Rebased to the master branch
>
>
>  fs/ceph/mds_client.c |  4 ++--
>  fs/ceph/mds_client.h |  5 +++++
>  fs/ceph/super.c      | 10 ++++++++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 66048a86c480..5fb367b1d4b0 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4764,7 +4764,7 @@ static void delayed_work(struct work_struct *work)
>
>         dout("mdsc delayed_work\n");
>
> -       if (mdsc->stopping)
> +       if (mdsc->stopping >=3D CEPH_MDSC_STOPPING_FLUSHED)
>                 return;

Do we want to continue to accept/perform delayed work when
mdsc->stopping is set to CEPH_MDSC_STOPPING_BEGIN ?

I thought setting the STOPPING_BEGIN flag would immediately bar any
further new activity and STOPPING_FLUSHED would mark safe deletion of
the superblock.



>
>         mutex_lock(&mdsc->mutex);
> @@ -4943,7 +4943,7 @@ void send_flush_mdlog(struct ceph_mds_session *s)
>  void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
>  {
>         dout("pre_umount\n");
> -       mdsc->stopping =3D 1;
> +       mdsc->stopping =3D CEPH_MDSC_STOPPING_BEGIN;
>
>         ceph_mdsc_iterate_sessions(mdsc, send_flush_mdlog, true);
>         ceph_mdsc_iterate_sessions(mdsc, lock_unlock_session, false);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 724307ff89cd..86d2965e68a1 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -380,6 +380,11 @@ struct cap_wait {
>         int                     want;
>  };
>
> +enum {
> +       CEPH_MDSC_STOPPING_BEGIN =3D 1,
> +       CEPH_MDSC_STOPPING_FLUSHED =3D 2,
> +};
> +
>  /*
>   * mds client state
>   */
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 3fc48b43cab0..a5f52013314d 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1374,6 +1374,16 @@ static void ceph_kill_sb(struct super_block *s)
>         ceph_mdsc_pre_umount(fsc->mdsc);
>         flush_fs_workqueues(fsc);
>
> +       /*
> +        * Though the kill_anon_super() will finally trigger the
> +        * sync_filesystem() anyway, we still need to do it here
> +        * and then bump the stage of shutdown to stop the work
> +        * queue as earlier as possible.
> +        */
> +       sync_filesystem(s);
> +
> +       fsc->mdsc->stopping =3D CEPH_MDSC_STOPPING_FLUSHED;
> +
>         kill_anon_super(s);
>
>         fsc->client->extra_mon_dispatch =3D NULL;
> --
> 2.39.1
>


--=20
Milind

