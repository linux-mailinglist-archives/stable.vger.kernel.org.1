Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167E07A43E3
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbjIRIFY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjIRIFO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 04:05:14 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882A114
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 01:04:21 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1ba5cda3530so2671942fac.3
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 01:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695024259; x=1695629059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPP0JSvglHXB5a6MB2wK6irdRvbJ0js+qbHXjwIeNOU=;
        b=RGbnh5BRQis+xReCI/hs20z23c9nIvO97E+B55VTscKrTehC9/Eg2YrHhSpfWpsFfk
         0DGODe7Y5O+Ecv08CD+y0e5Cg1vusVgLmAgeiyjjkvsT5Qx3TIlc+ebKJHuoS2aDkvYs
         Ldpq8sQA2JvhYvGPs3+0yERNna0nsyFDLlNGIarP6J7Y0SI4S6hm/wvtIxqvnNBoKrXf
         6HQYsoTDgzmh3/2FBCmY1c0kCCYniL//DlaLdeGykRqk4vsIOlfrMkvEJANjcNu5chNP
         VMO77NLZH6P3JQvBtV6iIzbfCh7eWNNEmjbPuWOU2UUctcdK7QWkcSutLq09D2XWjYhb
         Vj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024259; x=1695629059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPP0JSvglHXB5a6MB2wK6irdRvbJ0js+qbHXjwIeNOU=;
        b=Q9YVeI4YGOb1dy0OKTsz5Pe2ES0+rBeaDpCWOxv7CiEViuQHCAh9hhU+tu7U/hx3x1
         n9wxcROTT2l2dPZzG9DMAz8/pEf+WC5Y7T0/yW8MT1kjhth4BInDlh73onjdAKuiQd+g
         wLW6zS5m+fBMlOC5uVLlV0bQBzxWf3RSZG5X4l56PT3PQDodMo9XUiKsmG8n1Stc+Jaq
         XynEyhdNt4tLVZ1gWVa9UuT76gGnG4i0o0tMV1lAdUtqZzPntwZ9p5E68UGyet6wq1Em
         jzVMp5/z7VUbEEJA8n+hTg5FAm7BILFjtHXG5k6wWvRqZLoGQN0KyEtixs4o7Pen49+h
         L+yw==
X-Gm-Message-State: AOJu0YykGX0GGavOu4gYKJztL054nepxkS2wqr58o3FCE/zpuu3ATUtC
        v2NqffQfDq0IfJ792rMRT+m359sBrye1+E9BaHM=
X-Google-Smtp-Source: AGHT+IHQpVuGvrGSLu2qPivoM1jgXWzjRIFWvsbeUKzZ0adYjeJzemaCk5yAN5b3j88OAoAl67U+GmR3m0xaBmycl1w=
X-Received: by 2002:a05:6870:8991:b0:1c0:3110:12cc with SMTP id
 f17-20020a056870899100b001c0311012ccmr11379120oaq.55.1695024259470; Mon, 18
 Sep 2023 01:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191051.639202302@linuxfoundation.org> <20230917191055.579497834@linuxfoundation.org>
In-Reply-To: <20230917191055.579497834@linuxfoundation.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 18 Sep 2023 10:04:07 +0200
Message-ID: <CAOi1vP9Mh02NB4-n5Wy3Zs1Y8M33qJsZzd12Y6k991jubQVzwQ@mail.gmail.com>
Subject: Re: [PATCH 6.5 113/285] ceph: make members in struct
 ceph_mds_request_args_ext a union
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 17, 2023 at 9:49=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.5-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Xiubo Li <xiubli@redhat.com>
>
> [ Upstream commit 3af5ae22030cb59fab4fba35f5a2b62f47e14df9 ]
>
> In ceph mainline it will allow to set the btime in the setattr request
> and just add a 'btime' member in the union 'ceph_mds_request_args' and
> then bump up the header version to 4. That means the total size of union
> 'ceph_mds_request_args' will increase sizeof(struct ceph_timespec) bytes,
> but in kclient it will increase the sizeof(setattr_ext) bytes for each
> request.
>
> Since the MDS will always depend on the header's vesion and front_len
> members to decode the 'ceph_mds_request_head' struct, at the same time
> kclient hasn't supported the 'btime' feature yet in setattr request,
> so it's safe to do this change here.
>
> This will save 48 bytes memories for each request.
>
> Fixes: 4f1ddb1ea874 ("ceph: implement updated ceph_mds_request_head struc=
ture")
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Milind Changire <mchangir@redhat.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/ceph/ceph_fs.h | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index 49586ff261520..b4fa2a25b7d95 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -462,17 +462,19 @@ union ceph_mds_request_args {
>  } __attribute__ ((packed));
>
>  union ceph_mds_request_args_ext {
> -       union ceph_mds_request_args old;
> -       struct {
> -               __le32 mode;
> -               __le32 uid;
> -               __le32 gid;
> -               struct ceph_timespec mtime;
> -               struct ceph_timespec atime;
> -               __le64 size, old_size;       /* old_size needed by trunca=
te */
> -               __le32 mask;                 /* CEPH_SETATTR_* */
> -               struct ceph_timespec btime;
> -       } __attribute__ ((packed)) setattr_ext;
> +       union {
> +               union ceph_mds_request_args old;
> +               struct {
> +                       __le32 mode;
> +                       __le32 uid;
> +                       __le32 gid;
> +                       struct ceph_timespec mtime;
> +                       struct ceph_timespec atime;
> +                       __le64 size, old_size;       /* old_size needed b=
y truncate */
> +                       __le32 mask;                 /* CEPH_SETATTR_* */
> +                       struct ceph_timespec btime;
> +               } __attribute__ ((packed)) setattr_ext;
> +       };

Hi Xiubo,

I was going to ask whether it makes sense to backport this change, but,
after looking at it, the change seems bogus to me even in mainline.  You
added a union inside siting memory use but ceph_mds_request_args_ext was
already a union before:

    union ceph_mds_request_args_ext {
        union ceph_mds_request_args old;
        struct { ... } __attribute__ ((packed)) setattr_ext;
    }

What is being achieved here?

    union ceph_mds_request_args_ext {
        union {
            union ceph_mds_request_args old;
            struct { ... } __attribute__ ((packed)) setattr_ext;
        };
    }

Thanks,

                Ilya
