Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3973FD4A
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjF0N65 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 09:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0N64 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 09:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1453211B
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687874288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zqq7h7cm69/C9ev3ZJHDEt0CRQFqksZRkCslwkFy7X0=;
        b=VcTS+A5r18iKFjeh14trXJ6/+z/d3ThSkhaJf3VFTGpRCIvE/funRXROmUyDbomKKKo8zj
        g6sfRqf9He1BxLxZeGs5sy3M54jVAq2JUe8hvTsXCDJ7AuS/SHnqURgVunFNRt5B5ngV35
        bOWRzgjSNGXGKwGOO03L99jXt4MvpTE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-cMUFO0VxPXCC1CdtiydLUg-1; Tue, 27 Jun 2023 09:58:07 -0400
X-MC-Unique: cMUFO0VxPXCC1CdtiydLUg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6af6868baso6656721fa.2
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 06:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687874285; x=1690466285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqq7h7cm69/C9ev3ZJHDEt0CRQFqksZRkCslwkFy7X0=;
        b=Z/za7TS7o0EEaQSL9FqJIPWdEOZxo9heSEl4CGprv6smeykDxlpuTaAilaKHRGkizH
         A4nEZoYD3N6Iw7Gul7vEZKY0WPj0tp4ZW908wNuOS90NFk9O0tHP6EoNuEajoAUmHq2w
         66Hin4P0GT2wTzirzjsYha3wziL7jQ2knZkQ6Npaj7aU9cMxJcpbm5DBRyFDYndwxsws
         /IDPfr4Ye++/N3RMkJsir4jVpQsJ/loLBRePwXfHrb6YL//OCg4UCYriYQny55B962IC
         iXZwQFR5n/i58ASrRmdp7zWNO4CPUc/OSCclAN+yyib5Nkw71lNFCC31t1ARKr3TT6oD
         R2Sg==
X-Gm-Message-State: AC+VfDw0TdbBxvp1P+Sr4XsMqZbWMWzytwzBgibVyPuUFlUPJKsVHVgs
        6ehNIStNkcgx0JwOHCtKM2rxq3UqOxy5SM3+GblIHojzttCkULFr1TlZ4b6XtRKwUgBJ770DDfq
        50ylqTzT2TrLt7+LcrAdcKpeHOiYA3St3K7NqX6VQ
X-Received: by 2002:a05:651c:203:b0:2b6:b79e:7628 with SMTP id y3-20020a05651c020300b002b6b79e7628mr498626ljn.53.1687874285647;
        Tue, 27 Jun 2023 06:58:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DFztL2jcY/RWHezsy++5n18bc5MaVukjSzTzTVdz0P+6IjrmGuInhOxwUP7Bgwnm8EKJoHTYc2nvctiTfgUI=
X-Received: by 2002:a05:651c:203:b0:2b6:b79e:7628 with SMTP id
 y3-20020a05651c020300b002b6b79e7628mr498612ljn.53.1687874285358; Tue, 27 Jun
 2023 06:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230627070101.170876-1-xiubli@redhat.com>
In-Reply-To: <20230627070101.170876-1-xiubli@redhat.com>
From:   Milind Changire <mchangir@redhat.com>
Date:   Tue, 27 Jun 2023 19:27:29 +0530
Message-ID: <CAED=hWCAMVX-Y8GDCU7VOSEgB_aBZxZWqdjdVsF6_jAzdAfyMA@mail.gmail.com>
Subject: Re: [PATCH] ceph: don't let check_caps skip sending responses for
 revoke msgs
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, stable@vger.kernel.org,
        Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 27, 2023 at 12:33=E2=80=AFPM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> If just before the revoke request, which will increase the 'seq', is
> sent out the clients released the corresponding caps and sent out
> the cap update request to MDS with old 'seq', the mds will miss
> checking the seqs and calculating the caps.
>
> We should always send an ack for revoke requests.

I think the commit message needs to be rephrased for better
understanding to something like:

If a client sends out a cap update request with the old 'seq' just
before a pending cap revoke request, then the MDS might miscalculate
the 'seqs' and caps. It's therefore always a good idea to ack the cap
revoke request with the bumped up 'seq'.

Xiubo, please let me know if this sounds okay to you.


>
> Cc: stable@vger.kernel.org
> Cc: Patrick Donnelly <pdonnell@redhat.com>
> URL: https://tracker.ceph.com/issues/61782
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/caps.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 1052885025b3..eee2fbca3430 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3737,6 +3737,15 @@ static void handle_cap_grant(struct inode *inode,
>         }
>         BUG_ON(cap->issued & ~cap->implemented);
>
> +       /* don't let check_caps skip sending a response to MDS for revoke=
 msgs */
> +       if (le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_REVOKE) {
> +               cap->mds_wanted =3D 0;
> +               if (cap =3D=3D ci->i_auth_cap)
> +                       check_caps =3D 1; /* check auth cap only */
> +               else
> +                       check_caps =3D 2; /* check all caps */
> +       }
> +
>         if (extra_info->inline_version > 0 &&
>             extra_info->inline_version >=3D ci->i_inline_version) {
>                 ci->i_inline_version =3D extra_info->inline_version;
> --
> 2.40.1
>


--=20
Milind

