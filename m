Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493D1720F17
	for <lists+stable@lfdr.de>; Sat,  3 Jun 2023 12:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFCKEB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 3 Jun 2023 06:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFCKEA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Jun 2023 06:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52C197
        for <stable@vger.kernel.org>; Sat,  3 Jun 2023 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685786592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbRekisLkk4Kf2WnqFRasVqF7zjIrsvjpeyQV3BRS90=;
        b=JzEqEiK+UKJ9h1YrPTaRfUfzHsjKCKssy4gKOTNY0qDgvLR0Tm6PvoQdFZZKa7ALEKIMFJ
        FHwYQC18sfF4fbUJoX0Cxkrqr14r/KUqmDguEO5VqtllQh3GHVT57FmH+0oEyAmTa4dgGX
        kWooMwSon6BOKn85KN8vy+7wbyuVzxo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-sPMh4MWzORKZoeoE3OPdLQ-1; Sat, 03 Jun 2023 06:03:11 -0400
X-MC-Unique: sPMh4MWzORKZoeoE3OPdLQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b01aa55219so28548335ad.0
        for <stable@vger.kernel.org>; Sat, 03 Jun 2023 03:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685786589; x=1688378589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbRekisLkk4Kf2WnqFRasVqF7zjIrsvjpeyQV3BRS90=;
        b=Ok0LFE4pvu/1Y9BGwzL54pYgzWF66etuC7d+c6JhxFQkM8LUn9TLTSZLmIqavA0vn3
         XLHAEopNyAL1JXRbGRmXWE9sSFHRAt92inN2asb4J1Q1ff/xdj8AF0S+SL9hEgs8kFLY
         +7hGkiHf4R7oLe9eYp/7OZ/G7ka6uZUloGE5GALde+bCvx9Lok/54Yw2LuaLSDDffjna
         NZVSU+tZdl+/A2lh2z1iizZRYhvHtS948wm8rX7/5KPnvyFmIUURQm89zdnKnUUEfxz0
         omQeEyXG7rg0KIYN0ZFQRr7s56/7HpjYdJW5mX1BA5BHeEhfD01pi4SXZ2MFQzj/aCl6
         mztg==
X-Gm-Message-State: AC+VfDyqa4ubr2GwaIZQPXdehYgXq3+6Rnt0s2YEr5PCk5lmmN3DT2DG
        lIWzoinxbRwyGTVFqklF5YaU3cflKVyhPpkBzMckz2KPGgsdWkddQnhyoRZ1nmJY/x45vmm3QKR
        xjHm4Bz27fTGH3JKQeGz4zYc72vw7p4rE4CA5JaVgG/I=
X-Received: by 2002:a17:902:e807:b0:1af:d00c:7f04 with SMTP id u7-20020a170902e80700b001afd00c7f04mr2891573plg.12.1685786589065;
        Sat, 03 Jun 2023 03:03:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PmxIK+bvqp4no0fa8XIS66Qw5rHdvYEygGJpLjxcJy9WkSB1bcWSqpwGXTHAKNQMNCqfRzJXDoYssJxuJwvk=
X-Received: by 2002:a17:902:e807:b0:1af:d00c:7f04 with SMTP id
 u7-20020a170902e80700b001afd00c7f04mr2891560plg.12.1685786588676; Sat, 03 Jun
 2023 03:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160204.1042858-1-aahringo@redhat.com> <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
 <CAK-6q+gvSO-MRMUPrGVzkO+ki48itzTjnaUC6t_4a+jUs2xV7w@mail.gmail.com>
 <CAHc6FU4BCSFk+St-cndUr24Gb1g1K1DEAiKkMy-Z-SxLjhPM=w@mail.gmail.com>
 <CAK-6q+i8z6WEf5fEGgbcbMi6ffB12UnegPXxjAVJ7-Gxe4S=Bw@mail.gmail.com>
 <CAHc6FU4Y18NUL_D0mtLpY41pNXqdqK6ykPJSTGhg5ou=wQij2w@mail.gmail.com>
 <CAK-6q+i5-fUX=fYASjn4BbFKWYgTQ9DFP3cCYeQxJDuZ4pkCxw@mail.gmail.com>
 <CAHc6FU5S-BO+8dJEcrzu8pQnHucC9kM7=ns6ThSze8zxqSXjpw@mail.gmail.com> <CAK-6q+ibn8MGgmTYHQz8pXtw2sbwaQ=fK-fGG0aYAbY36UPFuA@mail.gmail.com>
In-Reply-To: <CAK-6q+ibn8MGgmTYHQz8pXtw2sbwaQ=fK-fGG0aYAbY36UPFuA@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 3 Jun 2023 12:02:56 +0200
Message-ID: <CAHc6FU4HU6oiYHBAYndp6wb0-LmkSRiAccjQE6t1Gf1PCnhFQQ@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next] fs: dlm: avoid F_SETLKW plock op lookup collisions
To:     Alexander Aring <aahringo@redhat.com>
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

On Thu, Jun 1, 2023 at 9:10=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
> Hi,
>
> On Thu, Jun 1, 2023 at 1:11=E2=80=AFPM Andreas Gruenbacher <agruenba@redh=
at.com> wrote:
> >
> > On Thu, Jun 1, 2023 at 6:28=E2=80=AFPM Alexander Aring <aahringo@redhat=
.com> wrote:
> > > Hi,
> > >
> > > On Tue, May 30, 2023 at 1:40=E2=80=AFPM Andreas Gruenbacher <agruenba=
@redhat.com> wrote:
> > > >
> > > > On Tue, May 30, 2023 at 4:08=E2=80=AFPM Alexander Aring <aahringo@r=
edhat.com> wrote:
> > > > > Hi,
> > > > >
> > > > > On Tue, May 30, 2023 at 7:01=E2=80=AFAM Andreas Gruenbacher <agru=
enba@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, May 30, 2023 at 12:19=E2=80=AFAM Alexander Aring <aahri=
ngo@redhat.com> wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Thu, May 25, 2023 at 11:02=E2=80=AFAM Andreas Gruenbacher
> > > > > > > <agruenba@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, May 24, 2023 at 6:02=E2=80=AFPM Alexander Aring <aa=
hringo@redhat.com> wrote:
> > > > > > > > > This patch fixes a possible plock op collisions when usin=
g F_SETLKW lock
> > > > > > > > > requests and fsid, number and owner are not enough to ide=
ntify a result
> > > > > > > > > for a pending request. The ltp testcases [0] and [1] are =
examples when
> > > > > > > > > this is not enough in case of using classic posix locks w=
ith threads and
> > > > > > > > > open filedescriptor posix locks.
> > > > > > > > >
> > > > > > > > > The idea to fix the issue here is to place all lock reque=
st in order. In
> > > > > > > > > case of non F_SETLKW lock request (indicated if wait is s=
et or not) the
> > > > > > > > > lock requests are ordered inside the recv_list. If a resu=
lt comes back
> > > > > > > > > the right plock op can be found by the first plock_op in =
recv_list which
> > > > > > > > > has not info.wait set. This can be done only by non F_SET=
LKW plock ops as
> > > > > > > > > dlm_controld always reads a specific plock op (list_move_=
tail() from
> > > > > > > > > send_list to recv_mlist) and write the result immediately=
 back.
> > > > > > > > >
> > > > > > > > > This behaviour is for F_SETLKW not possible as multiple w=
aiters can be
> > > > > > > > > get a result back in an random order. To avoid a collisio=
ns in cases
> > > > > > > > > like [0] or [1] this patch adds more fields to compare th=
e plock
> > > > > > > > > operations as the lock request is the same. This is also =
being made in
> > > > > > > > > NFS to find an result for an asynchronous F_SETLKW lock r=
equest [2][3]. We
> > > > > > > > > still can't find the exact lock request for a specific re=
sult if the
> > > > > > > > > lock request is the same, but if this is the case we don'=
t care the
> > > > > > > > > order how the identical lock requests get their result ba=
ck to grant the
> > > > > > > > > lock.
> > > > > > > >
> > > > > > > > When the recv_list contains multiple indistinguishable requ=
ests, this
> > > > > > > > can only be because they originated from multiple threads o=
f the same
> > > > > > > > process. In that case, I agree that it doesn't matter which=
 of those
> > > > > > > > requests we "complete" in dev_write() as long as we only co=
mplete one
> > > > > > > > request. We do need to compare the additional request field=
s in
> > > > > > > > dev_write() to find a suitable request, so that makes sense=
 as well.
> > > > > > > > We need to compare all of the fields that identify a reques=
t (optype,
> > > > > > > > ex, wait, pid, nodeid, fsid, number, start, end, owner) to =
find the
> > > > > > > > "right" request (or in case there is more than one identica=
l request,
> > > > > > > > a "suitable" request).
> > > > > > > >
> > > > > > >
> > > > > > > In my "definition" why this works is as you said the "identic=
al
> > > > > > > request". There is a more deeper definition of "when is a req=
uest
> > > > > > > identical" and in my opinion it is here as: "A request A is i=
dentical
> > > > > > > to request B when they get granted under the same 'time'" whi=
ch is all
> > > > > > > the fields you mentioned.
> > > > > > >
> > > > > > > Even with cancellation (F_SETLKW only) it does not matter whi=
ch
> > > > > > > "identical request" you cancel because the kernel and user
> > > > > > > (dlm_controld) makes no relation between a lock request insta=
nce. You
> > > > > > > need to have at least the same amount of "results" coming bac=
k from
> > > > > > > user space as the amount you are waiting for a result for the=
 same
> > > > > > > "identical request".
> > > > > >
> > > > > > That's not incorrect per se, but cancellations create an additi=
onal
> > > > > > difficulty: they can either succeed or fail. To indicate that a
> > > > > > cancellation has succeeded, a new type of message can be introd=
uced
> > > > > > (say, "CANCELLED"), and it's obvious that a CANCELLED message c=
an only
> > > > > > belong to a locking request that is being cancelled. When cance=
lling a
> > > > > > locking request fails, the kernel will see a "locking request g=
ranted"
> > > > > > message though, and when multiple identical locking requests ar=
e
> > > > > > queued and only some of them have been cancelled, it won't be o=
bvious
> > > > > > which locking request a "locking request granted" message shoul=
d be
> > > > > > assigned to anymore. You really don't want to mix things up in =
that
> > > > > > case.
> > > > > >
> > > > > > This complication makes it a whole lot more difficult to reason=
 about
> > > > > > the correctness of the code. All that complexity is avoidable b=
y
> > > > > > sticking with a fixed mapping of requests and replies (i.e., a =
unique
> > > > > > request identifier).
> > > > > >
> > > > > > To put it differently, you can shoot yourself in the foot and s=
till
> > > > > > hop along on the other leg, but it may not be the best of all p=
ossible
> > > > > > ideas.
> > > > > >
> > > > >
> > > > > It makes things more complicated, I agree and the reason why this
> > > > > works now is because there are a lot of "dependencies". I would l=
ove
> > > > > to have an unique identifier to make it possible that we can foll=
ow an
> > > > > instance handle of the original lock request.
> > > > >
> > > > > * an unique identifier which also works with the async lock reque=
st of
> > > > > lockd case.
> > > >
> > > > What's the lockd case you're referring to here, and why is it relev=
ant
> > > > for the problem at hand?
> > >
> > > just mentioned that we need a solution which also works for the
> > > asynchronous lock request (F_SETLK, F_SETLKW) case, there is only one
> > > user lockd. [0] DLM plock handling implements the behaviour mentioned
> > > at [0] but lm_grant() callback can also return negative values and
> > > signals that the lock request was cancelled (on nfs layer) and then
> > > need to tell it DLM. This however is not supported as we have a lack
> > > of cancellation.
> >
> > Ouch, that's a bit messy. But if the vfs_lock_file() description is
> > accurate, then only F_SETLK requests arriving via lockd can be
> > asynchronous, and F_SETLKW requests never are asynchronous. And we
> > only need to cancel F_SETLKW requests. It follows that we only ever
> > need to cancel synchronous requests.
> >
>
> I looked into the code and I think the second sentence of [0] is
> important regarding to F_SLEEP "Callers expecting ->lock() to return
> asynchronously will only use F_SETLK, not F_SETLKW; they will set
> FL_SLEEP if (and only if) the request is for a blocking lock.".
> If lockd does a lock request, it will then set args.wait to 1 if it
> was F_SETLKW [1].

Hmm, this sets args.block?

> The receiver will then create a blocking request [2]
> and set FL_SLEEP [3]; it does unset FL_SLEEP when args.wait (now as
> wait parameter) wasn't set. There is a case of [5] which unset wait
> again, but it seems we can end with FL_SLEEP there anyway.
>
> I think we have currently an issue here that we handle F_SETLK when
> F_SLEEP (in case of async lockd request) is handled as trylock which
> isn't right. Don't ask me why they are going over F_SLEEP and F_SETLK
> and not just using F_SETLKW to signal that it is a blocking request.
> So we actually have the F_SETLKW case but it's just signaled with
> F_SETLK + FL_SLEEP?

It seems to me that the vfs_lock_file() description and the
distinction it makes between F_SETLK and F_SETLKW makes sense in a
scenario when locking is implemented locally in the kernel, but not in
the context of dlm_controld, where all the locking decisions are made
in user-space: in the former scenario, F_SETLK requests can be decided
immediately without sleeping, but F_SETLKW requests may sleep. In the
dlm_controld scenario, locking requests can never be decided
immediately, and the requesting task will always sleep. So from the
point of view of lockd, any request to dlm_controld should probably be
treated as asynchronous.

This makes things a bit more ugly than I was hoping for.

Thanks,
Andreas

> - Alex
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/locks.c?h=3Dv6.4-rc4#n2255
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/lockd/clntproc.c?h=3Dv6.4-rc4#n186
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/lockd/svclock.c?h=3Dv6.4-rc4#n501
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/lockd/svclock.c?h=3Dv6.4-rc4#n240
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/lockd/svclock.c?h=3Dv6.4-rc4#n535
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/lockd/svclock.c?h=3Dv6.4-rc4#n489
>

