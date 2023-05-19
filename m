Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFB670A1AB
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 23:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjESVVt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjESVVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 17:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC2319A2
        for <stable@vger.kernel.org>; Fri, 19 May 2023 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684531225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDW6L5XcQGm718KjhEwJ0qelmoF6zHK3o1HR0XotUW4=;
        b=FiyOCQ/qWRbcUr/0EogXji6PgJzdlvBs26HfM4Lt9ZuzUH4k/h9ItL6lArwySGX/0g2PYz
        klsTjXEAGLzLO/p+paUu8j8LG9exBqy4/dcXXagnFi9RkQdSY0dDyv8nfrdizEdKaBBnYk
        bUHN5N7Svzb/HLiWNSdwn57JiQqQ0VM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-4ws01GJ9OyuXYBLQ7wWtwA-1; Fri, 19 May 2023 17:20:24 -0400
X-MC-Unique: 4ws01GJ9OyuXYBLQ7wWtwA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50bf847b267so4511413a12.3
        for <stable@vger.kernel.org>; Fri, 19 May 2023 14:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684531222; x=1687123222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDW6L5XcQGm718KjhEwJ0qelmoF6zHK3o1HR0XotUW4=;
        b=M01gNos8TCT/yG67Cs04QwVbAP4KPem+DJNVQe0ELTqeKPWT23B5ItbzjZPxNUZPoW
         1q7C9N1oKcK9v5xSpcc/BoWgMBH8DEMi6rjfVmryXqPKNIyADFwnlWUERxida2A80FV7
         CdYMmpBwVL9hfPpXSCf6r53vePHZoU5ibIBFB8jKIXDatP6An0uZYOHfUxntrTNeqFVR
         K11CiUmwCtqp8etnvhmioHhtuN8DMvXdvq+4mQ1jjVSK2Clk7M1i5bD/Js05d4YzNMkp
         TLAdHNJ5m463n7RbI12Oz8Rwk4temMg5TX4xfLOiHpLvadeJU18kD6XRFP2vJOSzNqGw
         VNMg==
X-Gm-Message-State: AC+VfDySaFn4Kjc0SjJsnGYOSltKlkKg4WAu03CZg0Wskxs0dEIIzk7s
        EqjyxGECaJ6BiSH1mUdQYvQcnX548zmMXDBF4q8jtfbB7EwDe3u89MLzRGaVoe1/E/9TCyIBlf3
        4RJW0OUGyAW2yyuHPenMfLcCn52INgHVgRHjoHmAhV+c=
X-Received: by 2002:aa7:ccc6:0:b0:510:6ccf:84aa with SMTP id y6-20020aa7ccc6000000b005106ccf84aamr3521171edt.32.1684531222576;
        Fri, 19 May 2023 14:20:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wIzt5Cy1icVhOGc2ztAmVv/6PXSB4C74oLH1vbhp7Obnssq3hv+O6tIkFXSXaPO8wqHUtoEcGIzr+wdv+pX0=
X-Received: by 2002:aa7:ccc6:0:b0:510:6ccf:84aa with SMTP id
 y6-20020aa7ccc6000000b005106ccf84aamr3521162edt.32.1684531222310; Fri, 19 May
 2023 14:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230519152128.65272-1-aahringo@redhat.com> <20230519152128.65272-5-aahringo@redhat.com>
In-Reply-To: <20230519152128.65272-5-aahringo@redhat.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 19 May 2023 17:20:11 -0400
Message-ID: <CAK-6q+gmmKqZgsvL_jGVzfd+kQhEvtX=w034j2ORkjQ-Vx7bRA@mail.gmail.com>
Subject: Re: [PATCH v6.4-rc2 5/5] fs: dlm: avoid F_SETLKW plock op lookup collisions
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, agruenba@redhat.com,
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

Hi,

On Fri, May 19, 2023 at 11:21=E2=80=AFAM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> This patch fixes a possible plock op collisions when using F_SETLKW lock
> requests and fsid, number and owner are not enough to identify a result
> for a pending request. The ltp testcases [0] and [1] are examples when
> this is not enough in case of using classic posix locks with threads and
> open filedescriptor posix locks.
>
> The idea to fix the issue here is to split recv_list, which contains
> plock ops expecting a result from user space, into a F_SETLKW op
> recv_setlkw_list and for all other commands recv_list. Due DLM user
> space behavior e.g. dlm_controld a request and writing a result back can
> only happen in an ordered way. That means a lookup and iterating over
> the recv_list is not required. To place the right plock op as the first
> entry of recv_list a change to list_move_tail() was made.
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
>
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
>  fs/dlm/plock.c | 47 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index c9e1d5f54194..540a30a342f0 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -17,6 +17,7 @@
>  static DEFINE_SPINLOCK(ops_lock);
>  static LIST_HEAD(send_list);
>  static LIST_HEAD(recv_list);
> +static LIST_HEAD(recv_setlkw_list);
>  static DECLARE_WAIT_QUEUE_HEAD(send_wq);
>  static DECLARE_WAIT_QUEUE_HEAD(recv_wq);
>
> @@ -392,10 +393,14 @@ static ssize_t dev_read(struct file *file, char __u=
ser *u, size_t count,
>         spin_lock(&ops_lock);
>         if (!list_empty(&send_list)) {
>                 op =3D list_first_entry(&send_list, struct plock_op, list=
);
> -               if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> +               if (op->info.flags & DLM_PLOCK_FL_CLOSE) {
>                         list_del(&op->list);
> -               else
> -                       list_move(&op->list, &recv_list);
> +               } else {
> +                       if (op->info.wait)
> +                               list_move(&op->list, &recv_setlkw_list);
> +                       else
> +                               list_move_tail(&op->list, &recv_list);
> +               }
>                 memcpy(&info, &op->info, sizeof(info));
>         }
>         spin_unlock(&ops_lock);
> @@ -434,18 +439,34 @@ static ssize_t dev_write(struct file *file, const c=
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
> +       if (info.wait) {
> +               list_for_each_entry(iter, &recv_setlkw_list, list) {
> +                       if (iter->info.fsid =3D=3D info.fsid &&
> +                           iter->info.number =3D=3D info.number &&
> +                           iter->info.owner =3D=3D info.owner &&
> +                           iter->info.pid =3D=3D info.pid &&
> +                           iter->info.start =3D=3D info.start &&
> +                           iter->info.end =3D=3D info.end) {

There is a missing condition for info.ex, otherwise a lock request for
F_WRLCK and F_RDLCK could be evaluated as the same request. NFS is
doing this check as well by checking on fl1->fl_type  =3D=3D fl2->fl_type,
we don't have fl_type but info.ex which is the only difference in
F_SETLKW to distinguish F_WRLCK and F_RDLCK.

I will send a v2.

- Alex

