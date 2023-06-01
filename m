Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5C871EEF8
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjFAQ3S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFAQ3R (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 12:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F54D1
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685636909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCl+syLrlgp+WL4FL8SAAChvmVC8U+rW6rWS8Fs+F2c=;
        b=SkVvyhOWgBtI0Cat2cynIuhg97HU0qS3XCyEyTK4klZUi47VmHRKU4v8saL/LYCVizQWRw
        LntF1Sgt3YeWAHPgBuWezfpB8+bhumwb3gCO/shs1mOBVj/dKNC3q7EvY5Eo084wa7d/WU
        Yh/9vIzcLktavyZw8VpIQ0pVdEmErg0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-UlFzx3D9PEeuFu7v7PaGVQ-1; Thu, 01 Jun 2023 12:28:28 -0400
X-MC-Unique: UlFzx3D9PEeuFu7v7PaGVQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51494233c2cso808183a12.1
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 09:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685636907; x=1688228907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCl+syLrlgp+WL4FL8SAAChvmVC8U+rW6rWS8Fs+F2c=;
        b=mAwXoqrRM7OeSfgkEcwhjpDOiqmyb/nL/m4ZbTVwhugu6kD5am7d2Jr7O1+CEJzfWS
         pID59J8EtpE6wtdQZQDoFeI8b/R0QhdTJg5tUhEfn0keznWtLpaCMDwRgJUoWgYXbgU7
         ZoGCUVAyb6qVyzvNIs9rGg69+T/XnsYnNEeCsl1rpN1U0riLq58EhKXAR8T8x81YSIDD
         GKu6Ec9XIk+zZrQw3ydHi0v7Ne4vwsRia4t5Q8lNOapKUfRhfNUG7HPawLTtlToSog7J
         z207PC2FmmF1Okal5CaSXaZZYOORwxKi4A9Sijrm7JD5dI3W4vJR+L30JhQ51vdEL54Z
         t+LA==
X-Gm-Message-State: AC+VfDw6adnFcLJiKDFZ+cc6wC8MYhpRimiu3b1TFjFGWfbPXeG5VY/p
        GISM/Y7Pcos8s/IT2ie7OoBQbKNEpFuqOvE232FbyUATITTgPk7im1lQLPaf4kHmMKE38YxXcQZ
        AgTnHpeIp6MCHcCjaLy1gWQVD6+TBCBgr
X-Received: by 2002:a05:6402:28d:b0:514:c43e:3881 with SMTP id l13-20020a056402028d00b00514c43e3881mr268604edv.35.1685636906887;
        Thu, 01 Jun 2023 09:28:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5eth36gdx5ldU2XGsAm8V1NGZFPlyvGFxJhp+RfwayRqysEISZTuMjCBlyFUWjkUxEZxoNxsH2FMejuS7yJdE=
X-Received: by 2002:a05:6402:28d:b0:514:c43e:3881 with SMTP id
 l13-20020a056402028d00b00514c43e3881mr268585edv.35.1685636906571; Thu, 01 Jun
 2023 09:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160204.1042858-1-aahringo@redhat.com> <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
 <CAK-6q+gvSO-MRMUPrGVzkO+ki48itzTjnaUC6t_4a+jUs2xV7w@mail.gmail.com>
 <CAHc6FU4BCSFk+St-cndUr24Gb1g1K1DEAiKkMy-Z-SxLjhPM=w@mail.gmail.com>
 <CAK-6q+i8z6WEf5fEGgbcbMi6ffB12UnegPXxjAVJ7-Gxe4S=Bw@mail.gmail.com> <CAHc6FU4Y18NUL_D0mtLpY41pNXqdqK6ykPJSTGhg5ou=wQij2w@mail.gmail.com>
In-Reply-To: <CAHc6FU4Y18NUL_D0mtLpY41pNXqdqK6ykPJSTGhg5ou=wQij2w@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 1 Jun 2023 12:28:15 -0400
Message-ID: <CAK-6q+i5-fUX=fYASjn4BbFKWYgTQ9DFP3cCYeQxJDuZ4pkCxw@mail.gmail.com>
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


On Tue, May 30, 2023 at 1:40=E2=80=AFPM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
>
> On Tue, May 30, 2023 at 4:08=E2=80=AFPM Alexander Aring <aahringo@redhat.=
com> wrote:
> > Hi,
> >
> > On Tue, May 30, 2023 at 7:01=E2=80=AFAM Andreas Gruenbacher <agruenba@r=
edhat.com> wrote:
> > >
> > > On Tue, May 30, 2023 at 12:19=E2=80=AFAM Alexander Aring <aahringo@re=
dhat.com> wrote:
> > > > Hi,
> > > >
> > > > On Thu, May 25, 2023 at 11:02=E2=80=AFAM Andreas Gruenbacher
> > > > <agruenba@redhat.com> wrote:
> > > > >
> > > > > On Wed, May 24, 2023 at 6:02=E2=80=AFPM Alexander Aring <aahringo=
@redhat.com> wrote:
> > > > > > This patch fixes a possible plock op collisions when using F_SE=
TLKW lock
> > > > > > requests and fsid, number and owner are not enough to identify =
a result
> > > > > > for a pending request. The ltp testcases [0] and [1] are exampl=
es when
> > > > > > this is not enough in case of using classic posix locks with th=
reads and
> > > > > > open filedescriptor posix locks.
> > > > > >
> > > > > > The idea to fix the issue here is to place all lock request in =
order. In
> > > > > > case of non F_SETLKW lock request (indicated if wait is set or =
not) the
> > > > > > lock requests are ordered inside the recv_list. If a result com=
es back
> > > > > > the right plock op can be found by the first plock_op in recv_l=
ist which
> > > > > > has not info.wait set. This can be done only by non F_SETLKW pl=
ock ops as
> > > > > > dlm_controld always reads a specific plock op (list_move_tail()=
 from
> > > > > > send_list to recv_mlist) and write the result immediately back.
> > > > > >
> > > > > > This behaviour is for F_SETLKW not possible as multiple waiters=
 can be
> > > > > > get a result back in an random order. To avoid a collisions in =
cases
> > > > > > like [0] or [1] this patch adds more fields to compare the ploc=
k
> > > > > > operations as the lock request is the same. This is also being =
made in
> > > > > > NFS to find an result for an asynchronous F_SETLKW lock request=
 [2][3]. We
> > > > > > still can't find the exact lock request for a specific result i=
f the
> > > > > > lock request is the same, but if this is the case we don't care=
 the
> > > > > > order how the identical lock requests get their result back to =
grant the
> > > > > > lock.
> > > > >
> > > > > When the recv_list contains multiple indistinguishable requests, =
this
> > > > > can only be because they originated from multiple threads of the =
same
> > > > > process. In that case, I agree that it doesn't matter which of th=
ose
> > > > > requests we "complete" in dev_write() as long as we only complete=
 one
> > > > > request. We do need to compare the additional request fields in
> > > > > dev_write() to find a suitable request, so that makes sense as we=
ll.
> > > > > We need to compare all of the fields that identify a request (opt=
ype,
> > > > > ex, wait, pid, nodeid, fsid, number, start, end, owner) to find t=
he
> > > > > "right" request (or in case there is more than one identical requ=
est,
> > > > > a "suitable" request).
> > > > >
> > > >
> > > > In my "definition" why this works is as you said the "identical
> > > > request". There is a more deeper definition of "when is a request
> > > > identical" and in my opinion it is here as: "A request A is identic=
al
> > > > to request B when they get granted under the same 'time'" which is =
all
> > > > the fields you mentioned.
> > > >
> > > > Even with cancellation (F_SETLKW only) it does not matter which
> > > > "identical request" you cancel because the kernel and user
> > > > (dlm_controld) makes no relation between a lock request instance. Y=
ou
> > > > need to have at least the same amount of "results" coming back from
> > > > user space as the amount you are waiting for a result for the same
> > > > "identical request".
> > >
> > > That's not incorrect per se, but cancellations create an additional
> > > difficulty: they can either succeed or fail. To indicate that a
> > > cancellation has succeeded, a new type of message can be introduced
> > > (say, "CANCELLED"), and it's obvious that a CANCELLED message can onl=
y
> > > belong to a locking request that is being cancelled. When cancelling =
a
> > > locking request fails, the kernel will see a "locking request granted=
"
> > > message though, and when multiple identical locking requests are
> > > queued and only some of them have been cancelled, it won't be obvious
> > > which locking request a "locking request granted" message should be
> > > assigned to anymore. You really don't want to mix things up in that
> > > case.
> > >
> > > This complication makes it a whole lot more difficult to reason about
> > > the correctness of the code. All that complexity is avoidable by
> > > sticking with a fixed mapping of requests and replies (i.e., a unique
> > > request identifier).
> > >
> > > To put it differently, you can shoot yourself in the foot and still
> > > hop along on the other leg, but it may not be the best of all possibl=
e
> > > ideas.
> > >
> >
> > It makes things more complicated, I agree and the reason why this
> > works now is because there are a lot of "dependencies". I would love
> > to have an unique identifier to make it possible that we can follow an
> > instance handle of the original lock request.
> >
> > * an unique identifier which also works with the async lock request of
> > lockd case.
>
> What's the lockd case you're referring to here, and why is it relevant
> for the problem at hand?

just mentioned that we need a solution which also works for the
asynchronous lock request (F_SETLK, F_SETLKW) case, there is only one
user lockd. [0] DLM plock handling implements the behaviour mentioned
at [0] but lm_grant() callback can also return negative values and
signals that the lock request was cancelled (on nfs layer) and then
need to tell it DLM. This however is not supported as we have a lack
of cancellation.

So far I don't see any issues with the current solution which this
patch is showing and the async lock request case.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/locks.c?h=3Dv6.4-rc4#n2255

