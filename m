Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E8F710EFE
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbjEYPDX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbjEYPDU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 11:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F498
        for <stable@vger.kernel.org>; Thu, 25 May 2023 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685026949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KplMHxrwKxFIh3NafdKXeYGBI6uFXbptgidYK5SSf8c=;
        b=Mp7D1UAv4JoFr+vD+wL9isGxosxthB05u11WvTcqcv9uv0lviA+UBiTApM6PgN1Z9kV3v9
        7E8o2KaIJvTkjK+/Ia8zWmGeThZPSyfYWTFLaDsm8/SxeH9J0OZ4OzVldz6OrahEFp6PKi
        Dk8trkXa5h3rbUL3Tn+PDE67ZdC+WQM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-o8UchM8FNpO8g5wQJ9CItw-1; Thu, 25 May 2023 11:02:23 -0400
X-MC-Unique: o8UchM8FNpO8g5wQJ9CItw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-25376f7737aso1705095a91.3
        for <stable@vger.kernel.org>; Thu, 25 May 2023 08:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026941; x=1687618941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KplMHxrwKxFIh3NafdKXeYGBI6uFXbptgidYK5SSf8c=;
        b=fLvPJ2cE97jK43VTEqA4ninZePU+9tpgkUaPJfV+BOy6Qxm5TzAQyIoEvlXC1VwWQQ
         N8yLYVcDG0zCiReLyzctjP4SinK8w+h5oDuBF6UVw+4uZ2z48lv31nLIfUOkZixfB9H1
         xZ31wCun/8+WKAJxL/eiGf/qRXfSo/F32jTlDqtbgj1m58HT0nFX94hMKuNuexUViu3n
         S4mEHILVEI4Jm1IwAhnh/PGCaKB3MGk10om9o89x8eXxUWOsiSFAy6sJLgchPEv3bvyx
         Hp1K/PK4sFwepv2OzfB/kPb0oBtPuCXx/AFfMcOi+mc8AETX6VPONdgkqHchCRoCjI6A
         m7QQ==
X-Gm-Message-State: AC+VfDw2FMWMlPtn8W0EVUjus6jtzNS+t7G1Wdw9g3swlJv5ngb8fNjx
        I/IQd9WJ5wXQ09vO7FbAEsPKdZnCpSnHn0UsC8dUpQaH9yJelBZsim7/zH89zlb7CL46tMDF/3J
        jWHAx5WuAqsq+IscJxlM66Iy6kHWPtmgw
X-Received: by 2002:a17:902:f545:b0:1a6:81fc:b585 with SMTP id h5-20020a170902f54500b001a681fcb585mr2193428plf.41.1685026941107;
        Thu, 25 May 2023 08:02:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qUdEFy2FQfQhMgr0Qzs3fyWRJaYGwZmRFOXJGEkR62u5XGN1UvQ8uEFgTRf2LVj5O5OQECsdbuAjlYNRsOhk=
X-Received: by 2002:a17:902:f545:b0:1a6:81fc:b585 with SMTP id
 h5-20020a170902f54500b001a681fcb585mr2193384plf.41.1685026940715; Thu, 25 May
 2023 08:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160204.1042858-1-aahringo@redhat.com>
In-Reply-To: <20230524160204.1042858-1-aahringo@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 25 May 2023 17:02:09 +0200
Message-ID: <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next] fs: dlm: avoid F_SETLKW plock op lookup collisions
To:     Alexander Aring <aahringo@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 24, 2023 at 6:02=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
> This patch fixes a possible plock op collisions when using F_SETLKW lock
> requests and fsid, number and owner are not enough to identify a result
> for a pending request. The ltp testcases [0] and [1] are examples when
> this is not enough in case of using classic posix locks with threads and
> open filedescriptor posix locks.
>
> The idea to fix the issue here is to place all lock request in order. In
> case of non F_SETLKW lock request (indicated if wait is set or not) the
> lock requests are ordered inside the recv_list. If a result comes back
> the right plock op can be found by the first plock_op in recv_list which
> has not info.wait set. This can be done only by non F_SETLKW plock ops as
> dlm_controld always reads a specific plock op (list_move_tail() from
> send_list to recv_mlist) and write the result immediately back.
>
> This behaviour is for F_SETLKW not possible as multiple waiters can be
> get a result back in an random order. To avoid a collisions in cases
> like [0] or [1] this patch adds more fields to compare the plock
> operations as the lock request is the same. This is also being made in
> NFS to find an result for an asynchronous F_SETLKW lock request [2][3]. W=
e
> still can't find the exact lock request for a specific result if the
> lock request is the same, but if this is the case we don't care the
> order how the identical lock requests get their result back to grant the
> lock.

When the recv_list contains multiple indistinguishable requests, this
can only be because they originated from multiple threads of the same
process. In that case, I agree that it doesn't matter which of those
requests we "complete" in dev_write() as long as we only complete one
request. We do need to compare the additional request fields in
dev_write() to find a suitable request, so that makes sense as well.
We need to compare all of the fields that identify a request (optype,
ex, wait, pid, nodeid, fsid, number, start, end, owner) to find the
"right" request (or in case there is more than one identical request,
a "suitable" request).

The above patch description doesn't match the code anymore, and the
code doesn't fully revert the recv_list splitting of the previous
version.

> [0] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/testc=
ases/kernel/syscalls/fcntl/fcntl40.c
> [1] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/testc=
ases/kernel/syscalls/fcntl/fcntl41.c
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/include/linux/lockd/lockd.h?h=3Dv6.4-rc1#n373
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/lockd/svclock.c?h=3Dv6.4-rc1#n731
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
> change since v2:
>  - don't split recv_list into recv_setlkw_list
>
>  fs/dlm/plock.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index 31bc601ee3d8..53d17dbbb716 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -391,7 +391,7 @@ static ssize_t dev_read(struct file *file, char __use=
r *u, size_t count,
>                 if (op->info.flags & DLM_PLOCK_FL_CLOSE)
>                         list_del(&op->list);
>                 else
> -                       list_move(&op->list, &recv_list);
> +                       list_move_tail(&op->list, &recv_list);

^ This should be obsolete, but it won't hurt, either.

>                 memcpy(&info, &op->info, sizeof(info));
>         }
>         spin_unlock(&ops_lock);
> @@ -430,19 +430,36 @@ static ssize_t dev_write(struct file *file, const c=
har __user *u, size_t count,
>                 return -EINVAL;
>
>         spin_lock(&ops_lock);
> -       list_for_each_entry(iter, &recv_list, list) {
> -               if (iter->info.fsid =3D=3D info.fsid &&
> -                   iter->info.number =3D=3D info.number &&
> -                   iter->info.owner =3D=3D info.owner) {
> -                       list_del_init(&iter->list);
> -                       memcpy(&iter->info, &info, sizeof(info));
> -                       if (iter->data)
> -                               do_callback =3D 1;
> -                       else
> -                               iter->done =3D 1;
> -                       op =3D iter;
> -                       break;
> +       if (info.wait) {

We should be able to use the same list_for_each_entry() loop for
F_SETLKW requests (which have info.wait set) as for all other requests
as far as I can see.

> +               list_for_each_entry(iter, &recv_list, list) {
> +                       if (iter->info.fsid =3D=3D info.fsid &&
> +                           iter->info.number =3D=3D info.number &&
> +                           iter->info.owner =3D=3D info.owner &&
> +                           iter->info.pid =3D=3D info.pid &&
> +                           iter->info.start =3D=3D info.start &&
> +                           iter->info.end =3D=3D info.end &&
> +                           iter->info.ex =3D=3D info.ex &&
> +                           iter->info.wait) {
> +                               op =3D iter;
> +                               break;
> +                       }
>                 }
> +       } else {
> +               list_for_each_entry(iter, &recv_list, list) {
> +                       if (!iter->info.wait) {
> +                               op =3D iter;
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       if (op) {
> +               list_del_init(&op->list);
> +               memcpy(&op->info, &info, sizeof(info));
> +               if (op->data)
> +                       do_callback =3D 1;
> +               else
> +                       op->done =3D 1;
>         }

Can't this code just remain in the list_for_each_entry() loop?

>         spin_unlock(&ops_lock);
>
> --
> 2.31.1
>

Andreas

