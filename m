Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EF7151BD
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 00:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE2WUF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 18:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjE2WUB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 18:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F11FCF
        for <stable@vger.kernel.org>; Mon, 29 May 2023 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685398740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhMup7LkBGdAPOz5NDd6KX324j84K3z1CaAR0UneiSQ=;
        b=ZU32GB1sD1HHOh66cG46+woXSFqzPkXplL07gOihRTI7vTkdETDMOm5xN1il6geTA8yfwd
        cupad4xScOd6oOq2byqC7ig08VOOH9gajDxaSO3MGgfWdIIMFE/sVuLsb2sSnZtMTqrhN1
        +LDfG2meocML8KVVil/NFeOPQ+IrODk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-zBUH9U8wMwqXPVjz-i8xgg-1; Mon, 29 May 2023 18:18:59 -0400
X-MC-Unique: zBUH9U8wMwqXPVjz-i8xgg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-506beab6a73so3638597a12.1
        for <stable@vger.kernel.org>; Mon, 29 May 2023 15:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685398738; x=1687990738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhMup7LkBGdAPOz5NDd6KX324j84K3z1CaAR0UneiSQ=;
        b=AowYRovczCYuvA9kQAxyKoJqt9HqBOj0U6ZwH6W0RNGWUX6kwUKYUsFPV65tUdJjyx
         /GansboVMaSMixI+A9su/2Q4tES8Gc83jx9/usYLdiy+BJIbJt6YilxUB6QDy1XQ+BZa
         9fRnLtdMGedQNVBvlfNAusQw8xWgVDFXaFcdW1W+bxjXd2Sy3qF3CPn/i1LEoBs/aveC
         /2WY6Ka9HFSksdskk58nVAhGA1ZEtv7xVuBxI5/ohhg2dnlS+KAfygoQdzTYsSk0AxDn
         NXP/UDtztrmQpt+RCjsXl/PtJyA0za1nGfSZLhFlAZCYEpPNVQp36wshSabrKc4AhMfP
         uR7A==
X-Gm-Message-State: AC+VfDw8MOqvHulU9MOv51CFX6B+eWMdiecqlm1v15HIIRaMdBMYtTZF
        nbD2TG+qk3hIUtrYcA8tw57MWjVVZ6LA0F8G4wyZeVVGkqeTe0T9WG5jOa9qfZtcbY1UKpVBfeW
        2EQNHX1Y5IOecdNBXhetmdPlT8AFMa4oj
X-Received: by 2002:aa7:d951:0:b0:514:a0e9:3deb with SMTP id l17-20020aa7d951000000b00514a0e93debmr132476eds.23.1685398738218;
        Mon, 29 May 2023 15:18:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VDL8U27vZmlDIiAWDqR3X5lbyyXtVtZT5XZw3S73YSsIlPfiu14jTerFrx/9yJ6bdrsXD3OX+FAhhUwIy4tY=
X-Received: by 2002:aa7:d951:0:b0:514:a0e9:3deb with SMTP id
 l17-20020aa7d951000000b00514a0e93debmr132469eds.23.1685398737949; Mon, 29 May
 2023 15:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160204.1042858-1-aahringo@redhat.com> <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
In-Reply-To: <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 29 May 2023 18:18:46 -0400
Message-ID: <CAK-6q+gvSO-MRMUPrGVzkO+ki48itzTjnaUC6t_4a+jUs2xV7w@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next] fs: dlm: avoid F_SETLKW plock op lookup collisions
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Thu, May 25, 2023 at 11:02=E2=80=AFAM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> On Wed, May 24, 2023 at 6:02=E2=80=AFPM Alexander Aring <aahringo@redhat.=
com> wrote:
> > This patch fixes a possible plock op collisions when using F_SETLKW loc=
k
> > requests and fsid, number and owner are not enough to identify a result
> > for a pending request. The ltp testcases [0] and [1] are examples when
> > this is not enough in case of using classic posix locks with threads an=
d
> > open filedescriptor posix locks.
> >
> > The idea to fix the issue here is to place all lock request in order. I=
n
> > case of non F_SETLKW lock request (indicated if wait is set or not) the
> > lock requests are ordered inside the recv_list. If a result comes back
> > the right plock op can be found by the first plock_op in recv_list whic=
h
> > has not info.wait set. This can be done only by non F_SETLKW plock ops =
as
> > dlm_controld always reads a specific plock op (list_move_tail() from
> > send_list to recv_mlist) and write the result immediately back.
> >
> > This behaviour is for F_SETLKW not possible as multiple waiters can be
> > get a result back in an random order. To avoid a collisions in cases
> > like [0] or [1] this patch adds more fields to compare the plock
> > operations as the lock request is the same. This is also being made in
> > NFS to find an result for an asynchronous F_SETLKW lock request [2][3].=
 We
> > still can't find the exact lock request for a specific result if the
> > lock request is the same, but if this is the case we don't care the
> > order how the identical lock requests get their result back to grant th=
e
> > lock.
>
> When the recv_list contains multiple indistinguishable requests, this
> can only be because they originated from multiple threads of the same
> process. In that case, I agree that it doesn't matter which of those
> requests we "complete" in dev_write() as long as we only complete one
> request. We do need to compare the additional request fields in
> dev_write() to find a suitable request, so that makes sense as well.
> We need to compare all of the fields that identify a request (optype,
> ex, wait, pid, nodeid, fsid, number, start, end, owner) to find the
> "right" request (or in case there is more than one identical request,
> a "suitable" request).
>

In my "definition" why this works is as you said the "identical
request". There is a more deeper definition of "when is a request
identical" and in my opinion it is here as: "A request A is identical
to request B when they get granted under the same 'time'" which is all
the fields you mentioned.

Even with cancellation (F_SETLKW only) it does not matter which
"identical request" you cancel because the kernel and user
(dlm_controld) makes no relation between a lock request instance. You
need to have at least the same amount of "results" coming back from
user space as the amount you are waiting for a result for the same
"identical request".

> The above patch description doesn't match the code anymore, and the
> code doesn't fully revert the recv_list splitting of the previous
> version.
>

This isn't a revert. Is it a new patch version, I did drop the
recv_setlkw_list here, dropping in means of removing the
recv_setlkw_list and handling everything in the recv_list. Although
there might be a performance impact by splitting the requests in two
lists as we don't need to jump over all F_SETLKW requests.

> > [0] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/tes=
tcases/kernel/syscalls/fcntl/fcntl40.c
> > [1] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/tes=
tcases/kernel/syscalls/fcntl/fcntl41.c
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/include/linux/lockd/lockd.h?h=3Dv6.4-rc1#n373
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/fs/lockd/svclock.c?h=3Dv6.4-rc1#n731
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> > change since v2:
> >  - don't split recv_list into recv_setlkw_list
> >
> >  fs/dlm/plock.c | 43 ++++++++++++++++++++++++++++++-------------
> >  1 file changed, 30 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > index 31bc601ee3d8..53d17dbbb716 100644
> > --- a/fs/dlm/plock.c
> > +++ b/fs/dlm/plock.c
> > @@ -391,7 +391,7 @@ static ssize_t dev_read(struct file *file, char __u=
ser *u, size_t count,
> >                 if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> >                         list_del(&op->list);
> >                 else
> > -                       list_move(&op->list, &recv_list);
> > +                       list_move_tail(&op->list, &recv_list);
>
> ^ This should be obsolete, but it won't hurt, either.
>

No it is necessary, I tested it and looked deeper into the reason.
dlm_controld handles the lock requests in an ordered way over a
select() mechanism, but it will not always write a result back when
it's read the request out. This is the case for F_SETLKW but also for
all other plock op requests, such as F_GETLK. Instead of writing the
result back it will send it to corosync and the corosync select()
mechanism will write the result back. Corosync will keep the order to
write the result back. Due the fact that it's going through corosync
multiple non F_SETLKW can be queued up in recv_list and need to be
appended on the tail to later find the first entry which is non
F_SETLKW to find the result.

This ordered lock request read and write the result back (for non
F_SETLKW ops) is not part of UAPI of dlm plock and dlm_controld did it
always this way.

> >                 memcpy(&info, &op->info, sizeof(info));
> >         }
> >         spin_unlock(&ops_lock);
> > @@ -430,19 +430,36 @@ static ssize_t dev_write(struct file *file, const=
 char __user *u, size_t count,
> >                 return -EINVAL;
> >
> >         spin_lock(&ops_lock);
> > -       list_for_each_entry(iter, &recv_list, list) {
> > -               if (iter->info.fsid =3D=3D info.fsid &&
> > -                   iter->info.number =3D=3D info.number &&
> > -                   iter->info.owner =3D=3D info.owner) {
> > -                       list_del_init(&iter->list);
> > -                       memcpy(&iter->info, &info, sizeof(info));
> > -                       if (iter->data)
> > -                               do_callback =3D 1;
> > -                       else
> > -                               iter->done =3D 1;
> > -                       op =3D iter;
> > -                       break;
> > +       if (info.wait) {
>
> We should be able to use the same list_for_each_entry() loop for
> F_SETLKW requests (which have info.wait set) as for all other requests
> as far as I can see.
>

We can't match non F_SETLKW operations on all fields because F_GETLK
will change some fields when it's handled in user space. This is the
whole reason why the ordered handling is done here.

However there can be matched more fields but because F_GETLK we
require that this mechanism works in the above mentioned ordered way.
Those fields are checked by WARN_ON() that we get aware about changes
and "things" doesn't work anymore as they should.

> > +               list_for_each_entry(iter, &recv_list, list) {
> > +                       if (iter->info.fsid =3D=3D info.fsid &&
> > +                           iter->info.number =3D=3D info.number &&
> > +                           iter->info.owner =3D=3D info.owner &&
> > +                           iter->info.pid =3D=3D info.pid &&
> > +                           iter->info.start =3D=3D info.start &&
> > +                           iter->info.end =3D=3D info.end &&
> > +                           iter->info.ex =3D=3D info.ex &&
> > +                           iter->info.wait) {
> > +                               op =3D iter;
> > +                               break;
> > +                       }
> >                 }
> > +       } else {
> > +               list_for_each_entry(iter, &recv_list, list) {
> > +                       if (!iter->info.wait) {
> > +                               op =3D iter;
> > +                               break;
> > +                       }
> > +               }
> > +       }
> > +
> > +       if (op) {
> > +               list_del_init(&op->list);
> > +               memcpy(&op->info, &info, sizeof(info));
> > +               if (op->data)
> > +                       do_callback =3D 1;
> > +               else
> > +                       op->done =3D 1;
> >         }
>
> Can't this code just remain in the list_for_each_entry() loop?
>

It can, but we need two of them then in each loop because two loops
are necessary (see above).

- Alex

