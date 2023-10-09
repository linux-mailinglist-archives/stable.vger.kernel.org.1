Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640B57BD4E7
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 10:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345459AbjJIIKe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 04:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbjJIIKd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 04:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3558F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696838985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqPDhZB6/AeVtIYszpl2A9PEXcu7eSDjsahfk9WGBvY=;
        b=AEqYA0d0Yq5uqSA8DsTzG6YNeZv/cIlyxrgszKvwkMuCk8gVY+85TU3ncAX4QsiN7TNWiB
        ciQMXsXcUH3YLDbHMTlDBizysdPX79CB8AFE/Q5Ml/b5FCYFtBvMeP0z9u/9U2qfw0xi6U
        vUjASAzppGxoc7Dl9gfNefd46/h5Fsg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-bm3yI52EPcCaPWMBMmDCWw-1; Mon, 09 Oct 2023 04:09:33 -0400
X-MC-Unique: bm3yI52EPcCaPWMBMmDCWw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a9e12a3093so470535266b.0
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 01:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696838971; x=1697443771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqPDhZB6/AeVtIYszpl2A9PEXcu7eSDjsahfk9WGBvY=;
        b=sDqvwQWp0tg1rHIJjWHZ5UQkD+bJH4gsVjwvLPrC85vKtUhXUKyNKlEuGi5CJC+vH1
         sxo+HtDUQhGCQAKfud1VOdSEVRyibQ0fXa/d6nlF4Tz/LrEJb+rWml0o3gg6ml3/1arH
         mK8y1JOVpDD1kqRTABisTMddGYM+VNo3zvoGCWutCF5aeJ+2nw2G4QF7oe4wUjQzMJwI
         jZQ0U/FKYiGb0IwVJcre2O91/VXPJD0nfL3kWz/AN7cAPX9bENmT8avjY28c387zotM4
         AtBqOBSpiGZd+of/Wm9j23iB3KHLBdFnJi940EtwY3fd/pg3wMuQV5MNuApDOrlxqj+/
         sZZg==
X-Gm-Message-State: AOJu0YzPI20v/shELA/DX0k3TNWEjLe70J1Nsa9ka45KEaMGdvW4mT0f
        qEHtwq+audymMKArQlWPXU+S8gURodbSDNrI5R3Ga7QarqC9PVrxvAPDztLdp2lNXrHlth3dDfx
        ZFqDV4gJrlSySzt4evC7pqVXqIALD+7iA
X-Received: by 2002:a17:906:739c:b0:9a1:ca55:d0cb with SMTP id f28-20020a170906739c00b009a1ca55d0cbmr10743959ejl.23.1696838971768;
        Mon, 09 Oct 2023 01:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmlWzwg4gDqOfBiB3fQBb8xrlYRnlav6xsAYgYZnmAfFLAQTsEXYXh3I/cro0z8JHTx2pAY+ucplFtAtlXVwQ=
X-Received: by 2002:a17:906:739c:b0:9a1:ca55:d0cb with SMTP id
 f28-20020a170906739c00b009a1ca55d0cbmr10743939ejl.23.1696838971440; Mon, 09
 Oct 2023 01:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230907002211.633935-1-xiubli@redhat.com>
In-Reply-To: <20230907002211.633935-1-xiubli@redhat.com>
From:   Milind Changire <mchangir@redhat.com>
Date:   Mon, 9 Oct 2023 13:38:55 +0530
Message-ID: <CAED=hWCKc-pnMQUKmjwgyG5489c5OjUHt-ri2gL+Ps1hGdewrw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: remove the incorrect caps check in _file_size()
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Looks good to me

Reviewed-by: Milind Changire <mchangir@redhat.com>

On Thu, Sep 7, 2023 at 5:54=E2=80=AFAM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> When truncating the inode the MDS will acquire the xlock for the
> ifile Locker, which will revoke the 'Frwsxl' caps from the clients.
> But when the client just releases and flushes the 'Fw' caps to MDS,
> for exmaple, and once the MDS receives the caps flushing msg it
> just thought the revocation has finished. Then the MDS will continue
> truncating the inode and then issued the truncate notification to
> all the clients. While just before the clients receives the cap
> flushing ack they receive the truncation notification, the clients
> will detecte that the 'issued | dirty' is still holding the 'Fw'
> caps.
>
> Fixes: b0d7c2231015 ("ceph: introduce i_truncate_mutex")
> Cc: stable@vger.kernel.org
> URL: https://tracker.ceph.com/issues/56693
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>
> V2:
> - Added the info about which commit it's fixing
>
>
>  fs/ceph/inode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index ea6f966dacd5..8017b9e5864f 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -769,9 +769,7 @@ int ceph_fill_file_size(struct inode *inode, int issu=
ed,
>                         ci->i_truncate_seq =3D truncate_seq;
>
>                         /* the MDS should have revoked these caps */
> -                       WARN_ON_ONCE(issued & (CEPH_CAP_FILE_EXCL |
> -                                              CEPH_CAP_FILE_RD |
> -                                              CEPH_CAP_FILE_WR |
> +                       WARN_ON_ONCE(issued & (CEPH_CAP_FILE_RD |
>                                                CEPH_CAP_FILE_LAZYIO));
>                         /*
>                          * If we hold relevant caps, or in the case where=
 we're
> --
> 2.41.0
>


--=20
Milind

