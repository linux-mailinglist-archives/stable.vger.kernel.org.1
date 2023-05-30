Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D751716B57
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 19:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjE3RlV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjE3RlQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 13:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0777298
        for <stable@vger.kernel.org>; Tue, 30 May 2023 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685468428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucVScV4sdyNVCqyw1+3t1xIZfOFojPzX1vWAJ5zfJSY=;
        b=RmcexB6JWkZ2iqd/ij8w9d/hPBdo+X25odJR9DuDBBCdRdH1gQTcmqCKbRQZ678Ad6/Yhi
        QEijeFQAS6jt6sj+fHils9KMdpJpV6kHc5fp7LoO3oXIyOFRYREQPNL3iENlfqqDBEfbn7
        NV4iy2RmToypwf7eS6cORpyHa4S9gF4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-nCM3kEiJPC6ko6JfoNRi8w-1; Tue, 30 May 2023 13:40:26 -0400
X-MC-Unique: nCM3kEiJPC6ko6JfoNRi8w-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b03f9dfd52so15756545ad.3
        for <stable@vger.kernel.org>; Tue, 30 May 2023 10:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468426; x=1688060426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucVScV4sdyNVCqyw1+3t1xIZfOFojPzX1vWAJ5zfJSY=;
        b=YS0YCxr+zxidd9U2RoqWYH4DK3mF2jQdqYveVs2+4/8KYsBPwydT0qQECeHMBJE6ZI
         22HzjRVBWSLsST8yOdud1aktyPSG+VbGccwJCq67EFUddPz6eh2EIMR1sOA+zVpuw8rJ
         j0cuYP7pkOwP0L+PeVwJ9qNIp24pNKVCvIwdMlBONkdn1AgeIw5lbllIt6JsOxmwR0SC
         3OSlzrP6bgLG2vGOI2wYmGNuLX9AdAb0IY/0ZV9i0305aMmS9xJs3R4ENEpFYbgQAaqZ
         kR3KtcIGgpCqgAxSFPMFJ7C2sFAF3B+RaQXXp2KA5uvqwgZO6wE1NZf2+d5hbDJYbb3c
         qUog==
X-Gm-Message-State: AC+VfDy6zLyO3EtCQX9hi/RJmkBNtall3Xb4zLGnHSiMMyhqBukLN55C
        XnhhC/TWs3MHZvgCNJUMHmXMgQvBrgEi42c9eJsturpW/fVrqm8qCpvvOV1RCERYHgAeWe0BxLr
        lX21ffj9MzBhMBnoycfiyZT/YMKkAhlpV
X-Received: by 2002:a17:902:cecb:b0:1b0:6480:1788 with SMTP id d11-20020a170902cecb00b001b064801788mr2477593plg.61.1685468425632;
        Tue, 30 May 2023 10:40:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4SWNXUogOo8XIdh10noG7U63oer7uEE1TSY24j83/mVyeiy3S/zM9QvSMe4mZwAPw4xFXQ7HG+YgmDLo39m90=
X-Received: by 2002:a17:902:cecb:b0:1b0:6480:1788 with SMTP id
 d11-20020a170902cecb00b001b064801788mr2477571plg.61.1685468425139; Tue, 30
 May 2023 10:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160204.1042858-1-aahringo@redhat.com> <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
 <CAK-6q+gvSO-MRMUPrGVzkO+ki48itzTjnaUC6t_4a+jUs2xV7w@mail.gmail.com>
 <CAHc6FU4BCSFk+St-cndUr24Gb1g1K1DEAiKkMy-Z-SxLjhPM=w@mail.gmail.com> <CAK-6q+i8z6WEf5fEGgbcbMi6ffB12UnegPXxjAVJ7-Gxe4S=Bw@mail.gmail.com>
In-Reply-To: <CAK-6q+i8z6WEf5fEGgbcbMi6ffB12UnegPXxjAVJ7-Gxe4S=Bw@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 30 May 2023 19:40:13 +0200
Message-ID: <CAHc6FU4Y18NUL_D0mtLpY41pNXqdqK6ykPJSTGhg5ou=wQij2w@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next] fs: dlm: avoid F_SETLKW plock op lookup collisions
To:     Alexander Aring <aahringo@redhat.com>
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

On Tue, May 30, 2023 at 4:08=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
> Hi,
>
> On Tue, May 30, 2023 at 7:01=E2=80=AFAM Andreas Gruenbacher <agruenba@red=
hat.com> wrote:
> >
> > On Tue, May 30, 2023 at 12:19=E2=80=AFAM Alexander Aring <aahringo@redh=
at.com> wrote:
> > > Hi,
> > >
> > > On Thu, May 25, 2023 at 11:02=E2=80=AFAM Andreas Gruenbacher
> > > <agruenba@redhat.com> wrote:
> > > >
> > > > On Wed, May 24, 2023 at 6:02=E2=80=AFPM Alexander Aring <aahringo@r=
edhat.com> wrote:
> > > > > This patch fixes a possible plock op collisions when using F_SETL=
KW lock
> > > > > requests and fsid, number and owner are not enough to identify a =
result
> > > > > for a pending request. The ltp testcases [0] and [1] are examples=
 when
> > > > > this is not enough in case of using classic posix locks with thre=
ads and
> > > > > open filedescriptor posix locks.
> > > > >
> > > > > The idea to fix the issue here is to place all lock request in or=
der. In
> > > > > case of non F_SETLKW lock request (indicated if wait is set or no=
t) the
> > > > > lock requests are ordered inside the recv_list. If a result comes=
 back
> > > > > the right plock op can be found by the first plock_op in recv_lis=
t which
> > > > > has not info.wait set. This can be done only by non F_SETLKW ploc=
k ops as
> > > > > dlm_controld always reads a specific plock op (list_move_tail() f=
rom
> > > > > send_list to recv_mlist) and write the result immediately back.
> > > > >
> > > > > This behaviour is for F_SETLKW not possible as multiple waiters c=
an be
> > > > > get a result back in an random order. To avoid a collisions in ca=
ses
> > > > > like [0] or [1] this patch adds more fields to compare the plock
> > > > > operations as the lock request is the same. This is also being ma=
de in
> > > > > NFS to find an result for an asynchronous F_SETLKW lock request [=
2][3]. We
> > > > > still can't find the exact lock request for a specific result if =
the
> > > > > lock request is the same, but if this is the case we don't care t=
he
> > > > > order how the identical lock requests get their result back to gr=
ant the
> > > > > lock.
> > > >
> > > > When the recv_list contains multiple indistinguishable requests, th=
is
> > > > can only be because they originated from multiple threads of the sa=
me
> > > > process. In that case, I agree that it doesn't matter which of thos=
e
> > > > requests we "complete" in dev_write() as long as we only complete o=
ne
> > > > request. We do need to compare the additional request fields in
> > > > dev_write() to find a suitable request, so that makes sense as well=
.
> > > > We need to compare all of the fields that identify a request (optyp=
e,
> > > > ex, wait, pid, nodeid, fsid, number, start, end, owner) to find the
> > > > "right" request (or in case there is more than one identical reques=
t,
> > > > a "suitable" request).
> > > >
> > >
> > > In my "definition" why this works is as you said the "identical
> > > request". There is a more deeper definition of "when is a request
> > > identical" and in my opinion it is here as: "A request A is identical
> > > to request B when they get granted under the same 'time'" which is al=
l
> > > the fields you mentioned.
> > >
> > > Even with cancellation (F_SETLKW only) it does not matter which
> > > "identical request" you cancel because the kernel and user
> > > (dlm_controld) makes no relation between a lock request instance. You
> > > need to have at least the same amount of "results" coming back from
> > > user space as the amount you are waiting for a result for the same
> > > "identical request".
> >
> > That's not incorrect per se, but cancellations create an additional
> > difficulty: they can either succeed or fail. To indicate that a
> > cancellation has succeeded, a new type of message can be introduced
> > (say, "CANCELLED"), and it's obvious that a CANCELLED message can only
> > belong to a locking request that is being cancelled. When cancelling a
> > locking request fails, the kernel will see a "locking request granted"
> > message though, and when multiple identical locking requests are
> > queued and only some of them have been cancelled, it won't be obvious
> > which locking request a "locking request granted" message should be
> > assigned to anymore. You really don't want to mix things up in that
> > case.
> >
> > This complication makes it a whole lot more difficult to reason about
> > the correctness of the code. All that complexity is avoidable by
> > sticking with a fixed mapping of requests and replies (i.e., a unique
> > request identifier).
> >
> > To put it differently, you can shoot yourself in the foot and still
> > hop along on the other leg, but it may not be the best of all possible
> > ideas.
> >
>
> It makes things more complicated, I agree and the reason why this
> works now is because there are a lot of "dependencies". I would love
> to have an unique identifier to make it possible that we can follow an
> instance handle of the original lock request.
>
> * an unique identifier which also works with the async lock request of
> lockd case.

What's the lockd case you're referring to here, and why is it relevant
for the problem at hand?

> > > > The above patch description doesn't match the code anymore, and the
> > > > code doesn't fully revert the recv_list splitting of the previous
> > > > version.
> > > >
> > >
> > > This isn't a revert. Is it a new patch version, I did drop the
> > > recv_setlkw_list here, dropping in means of removing the
> > > recv_setlkw_list and handling everything in the recv_list. Although
> > > there might be a performance impact by splitting the requests in two
> > > lists as we don't need to jump over all F_SETLKW requests.
> > >
> > > > > [0] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testca=
se/testcases/kernel/syscalls/fcntl/fcntl40.c
> > > > > [1] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testca=
se/testcases/kernel/syscalls/fcntl/fcntl41.c
> > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/include/linux/lockd/lockd.h?h=3Dv6.4-rc1#n373
> > > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/fs/lockd/svclock.c?h=3Dv6.4-rc1#n731
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > > > ---
> > > > > change since v2:
> > > > >  - don't split recv_list into recv_setlkw_list
> > > > >
> > > > >  fs/dlm/plock.c | 43 ++++++++++++++++++++++++++++++-------------
> > > > >  1 file changed, 30 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > > > > index 31bc601ee3d8..53d17dbbb716 100644
> > > > > --- a/fs/dlm/plock.c
> > > > > +++ b/fs/dlm/plock.c
> > > > > @@ -391,7 +391,7 @@ static ssize_t dev_read(struct file *file, ch=
ar __user *u, size_t count,
> > > > >                 if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> > > > >                         list_del(&op->list);
> > > > >                 else
> > > > > -                       list_move(&op->list, &recv_list);
> > > > > +                       list_move_tail(&op->list, &recv_list);
> > > >
> > > > ^ This should be obsolete, but it won't hurt, either.
> > > >
> > >
> > > No it is necessary, I tested it and looked deeper into the reason.
> > > dlm_controld handles the lock requests in an ordered way over a
> > > select() mechanism, but it will not always write a result back when
> > > it's read the request out. This is the case for F_SETLKW but also for
> > > all other plock op requests, such as F_GETLK. Instead of writing the
> > > result back it will send it to corosync and the corosync select()
> > > mechanism will write the result back. Corosync will keep the order to
> > > write the result back. Due the fact that it's going through corosync
> > > multiple non F_SETLKW can be queued up in recv_list and need to be
> > > appended on the tail to later find the first entry which is non
> > > F_SETLKW to find the result.
> > >
> > > This ordered lock request read and write the result back (for non
> > > F_SETLKW ops) is not part of UAPI of dlm plock and dlm_controld did i=
t
> > > always this way.
> >
> > This sounds pretty confused. Let's look at
> >
>
> As I said, yes it is a lot of specific handling of user space why this
> is actually working.
>
> > > > >                 memcpy(&info, &op->info, sizeof(info));
> > > > >         }
> > > > >         spin_unlock(&ops_lock);
> > > > > @@ -430,19 +430,36 @@ static ssize_t dev_write(struct file *file,=
 const char __user *u, size_t count,
> > > > >                 return -EINVAL;
> > > > >
> > > > >         spin_lock(&ops_lock);
> > > > > -       list_for_each_entry(iter, &recv_list, list) {
> > > > > -               if (iter->info.fsid =3D=3D info.fsid &&
> > > > > -                   iter->info.number =3D=3D info.number &&
> > > > > -                   iter->info.owner =3D=3D info.owner) {
> > > > > -                       list_del_init(&iter->list);
> > > > > -                       memcpy(&iter->info, &info, sizeof(info));
> > > > > -                       if (iter->data)
> > > > > -                               do_callback =3D 1;
> > > > > -                       else
> > > > > -                               iter->done =3D 1;
> > > > > -                       op =3D iter;
> > > > > -                       break;
> > > > > +       if (info.wait) {
> > > >
> > .> > We should be able to use the same list_for_each_entry() loop for
> > > > F_SETLKW requests (which have info.wait set) as for all other reque=
sts
> > > > as far as I can see.
> > > >
> > >
> > > We can't match non F_SETLKW operations on all fields because F_GETLK
> > > will change some fields when it's handled in user space. This is the
> > > whole reason why the ordered handling is done here.
> >
> > I know that F_GETLK uses the l_type field to indicate the outcome of
> > the operation. But that happens in dlm_posix_get() when processing the
> > reply from dlm_controld; it doesn't affect info.optype or any other
> > fields in struct dlm_plock_info. So we actually can compare all of the
> > key fields in struct dlm_plock_info.
> >
>
> F_GETLK also uses start, end, etc. to tell the caller about the region
> which is in conflict. The region which is in conflict is returned into
> the result info struct. See [0] [1].
> Is this more clear now that other fields are affected?

Ah, that sucks.

Thanks,
Andreas

