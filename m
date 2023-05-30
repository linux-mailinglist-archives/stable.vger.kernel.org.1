Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC0716340
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjE3OKY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjE3OKX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 10:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96649D9
        for <stable@vger.kernel.org>; Tue, 30 May 2023 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685455762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPR07ZPmxL6u/O0yXo07NGx5bbi7yr8OZIxPLX1z/wM=;
        b=btp8A/cjXtVbTN1RQP/93tnWNagY2PgekpZmZOQiRt/1lwYROh4gVh8w7E0nqeYIpuT5K+
        rY2frX0fNiuUBQ5gAuecQWrK4fxRUPWuM0Mho9P3pKZ/0OGeBgBv8+uUMb0hGMYV+48zZM
        ziJyHBcF9XCp0Si9tUNRSAuCJrPgCH4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-zUmVrmciPBWXrG-OAwICIg-1; Tue, 30 May 2023 10:07:12 -0400
X-MC-Unique: zUmVrmciPBWXrG-OAwICIg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-514b19ded99so598575a12.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 07:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455602; x=1688047602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPR07ZPmxL6u/O0yXo07NGx5bbi7yr8OZIxPLX1z/wM=;
        b=WSSNYFZvD0ooMYIzDF8H7WPp+qngYT4cMgEk+fyM4SFm/RvWIhSi4CUeCM1KeSc4MX
         0EbfvzbqFRA+19OItpf4lEXhEKBx/9m/+s5U7Sb+lfbyjf5zhwYT3AtC2BCL0ddtuPEb
         ubTolxZmeRHJ0HALiUn2YTkEnJRHnwb9Ju0h7xtR111VrptTKjGhSUjrXxCrnw8wpB12
         PvBvbKHhDeuxDc1TMbjhLvrdp5aMUwmTI1wsDSMw+q2XpYGYOwLo8KROpAF/Q02X5HOZ
         oXwVvS1INExyrj0Z43HExQxM6jMqwpwa000enn34/YkVxuVUxpFECxig030ZYdGvtj9Y
         W6cQ==
X-Gm-Message-State: AC+VfDyVIwnuhysynfTNyZ2ifGz5f+fSv59t3VK+Hk56nSJES2pP0BCX
        98jIp/w/GIyVmjhNVPTwQbr7HIF4ImvhufRpurcnJ0VU162Do6qvVrZ64MI50x793Hg4qSwOi8v
        gJ9XIimjcUYT6V4GPczcYcN5Sl6TgVv7Y
X-Received: by 2002:a05:6402:788:b0:514:9e2c:90c6 with SMTP id d8-20020a056402078800b005149e2c90c6mr1788478edy.38.1685455602624;
        Tue, 30 May 2023 07:06:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RWztAVobiCwRXG9aueBa+E+XgfHCLK3Hg7wpof9k/jAdzqFDRLlr+XDyR8Oxiv/aGRsNzbRECuqgqXiTFK8c=
X-Received: by 2002:a05:6402:788:b0:514:9e2c:90c6 with SMTP id
 d8-20020a056402078800b005149e2c90c6mr1788462edy.38.1685455602293; Tue, 30 May
 2023 07:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160204.1042858-1-aahringo@redhat.com> <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
 <CAK-6q+gvSO-MRMUPrGVzkO+ki48itzTjnaUC6t_4a+jUs2xV7w@mail.gmail.com> <CAHc6FU4BCSFk+St-cndUr24Gb1g1K1DEAiKkMy-Z-SxLjhPM=w@mail.gmail.com>
In-Reply-To: <CAHc6FU4BCSFk+St-cndUr24Gb1g1K1DEAiKkMy-Z-SxLjhPM=w@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 30 May 2023 10:06:30 -0400
Message-ID: <CAK-6q+i8z6WEf5fEGgbcbMi6ffB12UnegPXxjAVJ7-Gxe4S=Bw@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next] fs: dlm: avoid F_SETLKW plock op lookup collisions
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Tue, May 30, 2023 at 7:01=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
>
> On Tue, May 30, 2023 at 12:19=E2=80=AFAM Alexander Aring <aahringo@redhat=
.com> wrote:
> > Hi,
> >
> > On Thu, May 25, 2023 at 11:02=E2=80=AFAM Andreas Gruenbacher
> > <agruenba@redhat.com> wrote:
> > >
> > > On Wed, May 24, 2023 at 6:02=E2=80=AFPM Alexander Aring <aahringo@red=
hat.com> wrote:
> > > > This patch fixes a possible plock op collisions when using F_SETLKW=
 lock
> > > > requests and fsid, number and owner are not enough to identify a re=
sult
> > > > for a pending request. The ltp testcases [0] and [1] are examples w=
hen
> > > > this is not enough in case of using classic posix locks with thread=
s and
> > > > open filedescriptor posix locks.
> > > >
> > > > The idea to fix the issue here is to place all lock request in orde=
r. In
> > > > case of non F_SETLKW lock request (indicated if wait is set or not)=
 the
> > > > lock requests are ordered inside the recv_list. If a result comes b=
ack
> > > > the right plock op can be found by the first plock_op in recv_list =
which
> > > > has not info.wait set. This can be done only by non F_SETLKW plock =
ops as
> > > > dlm_controld always reads a specific plock op (list_move_tail() fro=
m
> > > > send_list to recv_mlist) and write the result immediately back.
> > > >
> > > > This behaviour is for F_SETLKW not possible as multiple waiters can=
 be
> > > > get a result back in an random order. To avoid a collisions in case=
s
> > > > like [0] or [1] this patch adds more fields to compare the plock
> > > > operations as the lock request is the same. This is also being made=
 in
> > > > NFS to find an result for an asynchronous F_SETLKW lock request [2]=
[3]. We
> > > > still can't find the exact lock request for a specific result if th=
e
> > > > lock request is the same, but if this is the case we don't care the
> > > > order how the identical lock requests get their result back to gran=
t the
> > > > lock.
> > >
> > > When the recv_list contains multiple indistinguishable requests, this
> > > can only be because they originated from multiple threads of the same
> > > process. In that case, I agree that it doesn't matter which of those
> > > requests we "complete" in dev_write() as long as we only complete one
> > > request. We do need to compare the additional request fields in
> > > dev_write() to find a suitable request, so that makes sense as well.
> > > We need to compare all of the fields that identify a request (optype,
> > > ex, wait, pid, nodeid, fsid, number, start, end, owner) to find the
> > > "right" request (or in case there is more than one identical request,
> > > a "suitable" request).
> > >
> >
> > In my "definition" why this works is as you said the "identical
> > request". There is a more deeper definition of "when is a request
> > identical" and in my opinion it is here as: "A request A is identical
> > to request B when they get granted under the same 'time'" which is all
> > the fields you mentioned.
> >
> > Even with cancellation (F_SETLKW only) it does not matter which
> > "identical request" you cancel because the kernel and user
> > (dlm_controld) makes no relation between a lock request instance. You
> > need to have at least the same amount of "results" coming back from
> > user space as the amount you are waiting for a result for the same
> > "identical request".
>
> That's not incorrect per se, but cancellations create an additional
> difficulty: they can either succeed or fail. To indicate that a
> cancellation has succeeded, a new type of message can be introduced
> (say, "CANCELLED"), and it's obvious that a CANCELLED message can only
> belong to a locking request that is being cancelled. When cancelling a
> locking request fails, the kernel will see a "locking request granted"
> message though, and when multiple identical locking requests are
> queued and only some of them have been cancelled, it won't be obvious
> which locking request a "locking request granted" message should be
> assigned to anymore. You really don't want to mix things up in that
> case.
>
> This complication makes it a whole lot more difficult to reason about
> the correctness of the code. All that complexity is avoidable by
> sticking with a fixed mapping of requests and replies (i.e., a unique
> request identifier).
>
> To put it differently, you can shoot yourself in the foot and still
> hop along on the other leg, but it may not be the best of all possible
> ideas.
>

It makes things more complicated, I agree and the reason why this
works now is because there are a lot of "dependencies". I would love
to have an unique identifier to make it possible that we can follow an
instance handle of the original lock request.

* an unique identifier which also works with the async lock request of
lockd case.

> > > The above patch description doesn't match the code anymore, and the
> > > code doesn't fully revert the recv_list splitting of the previous
> > > version.
> > >
> >
> > This isn't a revert. Is it a new patch version, I did drop the
> > recv_setlkw_list here, dropping in means of removing the
> > recv_setlkw_list and handling everything in the recv_list. Although
> > there might be a performance impact by splitting the requests in two
> > lists as we don't need to jump over all F_SETLKW requests.
> >
> > > > [0] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase=
/testcases/kernel/syscalls/fcntl/fcntl40.c
> > > > [1] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase=
/testcases/kernel/syscalls/fcntl/fcntl41.c
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/include/linux/lockd/lockd.h?h=3Dv6.4-rc1#n373
> > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/fs/lockd/svclock.c?h=3Dv6.4-rc1#n731
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > > ---
> > > > change since v2:
> > > >  - don't split recv_list into recv_setlkw_list
> > > >
> > > >  fs/dlm/plock.c | 43 ++++++++++++++++++++++++++++++-------------
> > > >  1 file changed, 30 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > > > index 31bc601ee3d8..53d17dbbb716 100644
> > > > --- a/fs/dlm/plock.c
> > > > +++ b/fs/dlm/plock.c
> > > > @@ -391,7 +391,7 @@ static ssize_t dev_read(struct file *file, char=
 __user *u, size_t count,
> > > >                 if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> > > >                         list_del(&op->list);
> > > >                 else
> > > > -                       list_move(&op->list, &recv_list);
> > > > +                       list_move_tail(&op->list, &recv_list);
> > >
> > > ^ This should be obsolete, but it won't hurt, either.
> > >
> >
> > No it is necessary, I tested it and looked deeper into the reason.
> > dlm_controld handles the lock requests in an ordered way over a
> > select() mechanism, but it will not always write a result back when
> > it's read the request out. This is the case for F_SETLKW but also for
> > all other plock op requests, such as F_GETLK. Instead of writing the
> > result back it will send it to corosync and the corosync select()
> > mechanism will write the result back. Corosync will keep the order to
> > write the result back. Due the fact that it's going through corosync
> > multiple non F_SETLKW can be queued up in recv_list and need to be
> > appended on the tail to later find the first entry which is non
> > F_SETLKW to find the result.
> >
> > This ordered lock request read and write the result back (for non
> > F_SETLKW ops) is not part of UAPI of dlm plock and dlm_controld did it
> > always this way.
>
> This sounds pretty confused. Let's look at
>

As I said, yes it is a lot of specific handling of user space why this
is actually working.

> > > >                 memcpy(&info, &op->info, sizeof(info));
> > > >         }
> > > >         spin_unlock(&ops_lock);
> > > > @@ -430,19 +430,36 @@ static ssize_t dev_write(struct file *file, c=
onst char __user *u, size_t count,
> > > >                 return -EINVAL;
> > > >
> > > >         spin_lock(&ops_lock);
> > > > -       list_for_each_entry(iter, &recv_list, list) {
> > > > -               if (iter->info.fsid =3D=3D info.fsid &&
> > > > -                   iter->info.number =3D=3D info.number &&
> > > > -                   iter->info.owner =3D=3D info.owner) {
> > > > -                       list_del_init(&iter->list);
> > > > -                       memcpy(&iter->info, &info, sizeof(info));
> > > > -                       if (iter->data)
> > > > -                               do_callback =3D 1;
> > > > -                       else
> > > > -                               iter->done =3D 1;
> > > > -                       op =3D iter;
> > > > -                       break;
> > > > +       if (info.wait) {
> > >
> .> > We should be able to use the same list_for_each_entry() loop for
> > > F_SETLKW requests (which have info.wait set) as for all other request=
s
> > > as far as I can see.
> > >
> >
> > We can't match non F_SETLKW operations on all fields because F_GETLK
> > will change some fields when it's handled in user space. This is the
> > whole reason why the ordered handling is done here.
>
> I know that F_GETLK uses the l_type field to indicate the outcome of
> the operation. But that happens in dlm_posix_get() when processing the
> reply from dlm_controld; it doesn't affect info.optype or any other
> fields in struct dlm_plock_info. So we actually can compare all of the
> key fields in struct dlm_plock_info.
>

F_GETLK also uses start, end, etc. to tell the caller about the region
which is in conflict. The region which is in conflict is returned into
the result info struct. See [0] [1].
Is this more clear now that other fields are affected?

- Alex

[0] https://pagure.io/dlm/blob/main/f/dlm_controld/plock.c#_428
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/plock.c?h=3Dv6.4-rc4#n359

