Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD43071F061
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjFARMC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjFARMB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 13:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25638E2
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685639474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8HY4z673x9a3/InZ+bsdvSB0Odk2lcvwHGXF60TyWU=;
        b=DYTKdMzDcyyQcqESsz2W4/duERNkb3P5+jkO9vJx1F2G7VBBzz3KC72jLnX8LmwxhjD0b2
        7cIBaieyjkmn0p7fwrosTrfnkp3O28rbnsM2jeILKxtzY1c/s9Vj6H+9KAlC8VopCiRPBp
        ObB1/3KnCjZXe/Hj+Hs/dK+F1LcLGe0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-N9cNrv6fPGmfAUFUJxA96g-1; Thu, 01 Jun 2023 13:11:11 -0400
X-MC-Unique: N9cNrv6fPGmfAUFUJxA96g-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b03ae23eacso10521965ad.0
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 10:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639470; x=1688231470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8HY4z673x9a3/InZ+bsdvSB0Odk2lcvwHGXF60TyWU=;
        b=hdtd3DR/GO5wzKbJTAfmulsK1Es9bhkp27RnXcycfw0fMEDHn6NtCxRQg9UIAy/lTr
         LR6+XCWoEHs2zEeog17XOFy2DWIUEpFah45SkBn4FcqYjxJJc9UQTDqYhiAl2WqJRLAE
         ZUcSrMEu+AGqwznCvnJKlTVX2bLJcQI0lxEL5VA19TbsNv7TZujF55zRaZAk17OSEZac
         q3WkQUT1SM1XkWQO7ooxOaXGRrrJ6rX0YY1j2eY3lWo5LWQlMfBJacU/xCARuBYs3WUj
         zSecrH5k8h+5DtbZKtY870u6VZNXjMUIvzZCzT+pUYjpyvMJrrO8kd9HbxTNTT7eOSlo
         x4sQ==
X-Gm-Message-State: AC+VfDwWvlixl7OY7NfI9LKCsQM7bvSD+zDyVvvg5DFV6OwrYWjZnpwR
        IYClMSShhDDo+DTDpFfXOYFft8LlFPY/y+0kRmwtpi0eYccM0zgNqwriuzBJ39Kw1jXRnPJCG5b
        Hgix6bOlhq0iFevUzU6dAyhqEmG1hAUnS
X-Received: by 2002:a17:903:1cf:b0:1ad:c736:2090 with SMTP id e15-20020a17090301cf00b001adc7362090mr146570plh.3.1685639470045;
        Thu, 01 Jun 2023 10:11:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5BUgTkN7zJXRHZpxy6ufmqzTuHF4LgcgX+VhLp/15IqhR8Edxzu8TgQDTzhdJqJf5zVtvG4nM034r1KvES/Yg=
X-Received: by 2002:a17:903:1cf:b0:1ad:c736:2090 with SMTP id
 e15-20020a17090301cf00b001adc7362090mr146545plh.3.1685639469687; Thu, 01 Jun
 2023 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160204.1042858-1-aahringo@redhat.com> <CAHc6FU7vaQmbwzL7Memu9YpsqXM9Ay4Mj52pDpkG6UdXw6hKVg@mail.gmail.com>
 <CAK-6q+gvSO-MRMUPrGVzkO+ki48itzTjnaUC6t_4a+jUs2xV7w@mail.gmail.com>
 <CAHc6FU4BCSFk+St-cndUr24Gb1g1K1DEAiKkMy-Z-SxLjhPM=w@mail.gmail.com>
 <CAK-6q+i8z6WEf5fEGgbcbMi6ffB12UnegPXxjAVJ7-Gxe4S=Bw@mail.gmail.com>
 <CAHc6FU4Y18NUL_D0mtLpY41pNXqdqK6ykPJSTGhg5ou=wQij2w@mail.gmail.com> <CAK-6q+i5-fUX=fYASjn4BbFKWYgTQ9DFP3cCYeQxJDuZ4pkCxw@mail.gmail.com>
In-Reply-To: <CAK-6q+i5-fUX=fYASjn4BbFKWYgTQ9DFP3cCYeQxJDuZ4pkCxw@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 1 Jun 2023 19:10:57 +0200
Message-ID: <CAHc6FU5S-BO+8dJEcrzu8pQnHucC9kM7=ns6ThSze8zxqSXjpw@mail.gmail.com>
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

On Thu, Jun 1, 2023 at 6:28=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
> Hi,
>
> On Tue, May 30, 2023 at 1:40=E2=80=AFPM Andreas Gruenbacher <agruenba@red=
hat.com> wrote:
> >
> > On Tue, May 30, 2023 at 4:08=E2=80=AFPM Alexander Aring <aahringo@redha=
t.com> wrote:
> > > Hi,
> > >
> > > On Tue, May 30, 2023 at 7:01=E2=80=AFAM Andreas Gruenbacher <agruenba=
@redhat.com> wrote:
> > > >
> > > > On Tue, May 30, 2023 at 12:19=E2=80=AFAM Alexander Aring <aahringo@=
redhat.com> wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, May 25, 2023 at 11:02=E2=80=AFAM Andreas Gruenbacher
> > > > > <agruenba@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, May 24, 2023 at 6:02=E2=80=AFPM Alexander Aring <aahrin=
go@redhat.com> wrote:
> > > > > > > This patch fixes a possible plock op collisions when using F_=
SETLKW lock
> > > > > > > requests and fsid, number and owner are not enough to identif=
y a result
> > > > > > > for a pending request. The ltp testcases [0] and [1] are exam=
ples when
> > > > > > > this is not enough in case of using classic posix locks with =
threads and
> > > > > > > open filedescriptor posix locks.
> > > > > > >
> > > > > > > The idea to fix the issue here is to place all lock request i=
n order. In
> > > > > > > case of non F_SETLKW lock request (indicated if wait is set o=
r not) the
> > > > > > > lock requests are ordered inside the recv_list. If a result c=
omes back
> > > > > > > the right plock op can be found by the first plock_op in recv=
_list which
> > > > > > > has not info.wait set. This can be done only by non F_SETLKW =
plock ops as
> > > > > > > dlm_controld always reads a specific plock op (list_move_tail=
() from
> > > > > > > send_list to recv_mlist) and write the result immediately bac=
k.
> > > > > > >
> > > > > > > This behaviour is for F_SETLKW not possible as multiple waite=
rs can be
> > > > > > > get a result back in an random order. To avoid a collisions i=
n cases
> > > > > > > like [0] or [1] this patch adds more fields to compare the pl=
ock
> > > > > > > operations as the lock request is the same. This is also bein=
g made in
> > > > > > > NFS to find an result for an asynchronous F_SETLKW lock reque=
st [2][3]. We
> > > > > > > still can't find the exact lock request for a specific result=
 if the
> > > > > > > lock request is the same, but if this is the case we don't ca=
re the
> > > > > > > order how the identical lock requests get their result back t=
o grant the
> > > > > > > lock.
> > > > > >
> > > > > > When the recv_list contains multiple indistinguishable requests=
, this
> > > > > > can only be because they originated from multiple threads of th=
e same
> > > > > > process. In that case, I agree that it doesn't matter which of =
those
> > > > > > requests we "complete" in dev_write() as long as we only comple=
te one
> > > > > > request. We do need to compare the additional request fields in
> > > > > > dev_write() to find a suitable request, so that makes sense as =
well.
> > > > > > We need to compare all of the fields that identify a request (o=
ptype,
> > > > > > ex, wait, pid, nodeid, fsid, number, start, end, owner) to find=
 the
> > > > > > "right" request (or in case there is more than one identical re=
quest,
> > > > > > a "suitable" request).
> > > > > >
> > > > >
> > > > > In my "definition" why this works is as you said the "identical
> > > > > request". There is a more deeper definition of "when is a request
> > > > > identical" and in my opinion it is here as: "A request A is ident=
ical
> > > > > to request B when they get granted under the same 'time'" which i=
s all
> > > > > the fields you mentioned.
> > > > >
> > > > > Even with cancellation (F_SETLKW only) it does not matter which
> > > > > "identical request" you cancel because the kernel and user
> > > > > (dlm_controld) makes no relation between a lock request instance.=
 You
> > > > > need to have at least the same amount of "results" coming back fr=
om
> > > > > user space as the amount you are waiting for a result for the sam=
e
> > > > > "identical request".
> > > >
> > > > That's not incorrect per se, but cancellations create an additional
> > > > difficulty: they can either succeed or fail. To indicate that a
> > > > cancellation has succeeded, a new type of message can be introduced
> > > > (say, "CANCELLED"), and it's obvious that a CANCELLED message can o=
nly
> > > > belong to a locking request that is being cancelled. When cancellin=
g a
> > > > locking request fails, the kernel will see a "locking request grant=
ed"
> > > > message though, and when multiple identical locking requests are
> > > > queued and only some of them have been cancelled, it won't be obvio=
us
> > > > which locking request a "locking request granted" message should be
> > > > assigned to anymore. You really don't want to mix things up in that
> > > > case.
> > > >
> > > > This complication makes it a whole lot more difficult to reason abo=
ut
> > > > the correctness of the code. All that complexity is avoidable by
> > > > sticking with a fixed mapping of requests and replies (i.e., a uniq=
ue
> > > > request identifier).
> > > >
> > > > To put it differently, you can shoot yourself in the foot and still
> > > > hop along on the other leg, but it may not be the best of all possi=
ble
> > > > ideas.
> > > >
> > >
> > > It makes things more complicated, I agree and the reason why this
> > > works now is because there are a lot of "dependencies". I would love
> > > to have an unique identifier to make it possible that we can follow a=
n
> > > instance handle of the original lock request.
> > >
> > > * an unique identifier which also works with the async lock request o=
f
> > > lockd case.
> >
> > What's the lockd case you're referring to here, and why is it relevant
> > for the problem at hand?
>
> just mentioned that we need a solution which also works for the
> asynchronous lock request (F_SETLK, F_SETLKW) case, there is only one
> user lockd. [0] DLM plock handling implements the behaviour mentioned
> at [0] but lm_grant() callback can also return negative values and
> signals that the lock request was cancelled (on nfs layer) and then
> need to tell it DLM. This however is not supported as we have a lack
> of cancellation.

Ouch, that's a bit messy. But if the vfs_lock_file() description is
accurate, then only F_SETLK requests arriving via lockd can be
asynchronous, and F_SETLKW requests never are asynchronous. And we
only need to cancel F_SETLKW requests. It follows that we only ever
need to cancel synchronous requests.

Andreas

> So far I don't see any issues with the current solution which this
> patch is showing and the async lock request case.
>
> - Alex
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/locks.c?h=3Dv6.4-rc4#n2255
>

