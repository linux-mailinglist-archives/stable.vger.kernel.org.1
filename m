Return-Path: <stable+bounces-80593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3516198E285
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 20:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BDA28719A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0C2141B6;
	Wed,  2 Oct 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3gYsRiA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C612141BF;
	Wed,  2 Oct 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893850; cv=none; b=W7jlShf293vNJAOfsu3rK6BZ97XMJwnstFfE/bws3PyPOUe3rM9ifWsyVLYDV4Z1XZh9OU+JLB6SYwBrmtDrbAVM/mBK1C0619lbaNqgwlZQhkrll6Rn3MMaSDnYfvsEyWWJFRXfLaMDvNfLAcrqB/lleOMuI5Lr6ALBh7nz5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893850; c=relaxed/simple;
	bh=fM8zcIN6ZzgFzJMi8vX85wRIXm/I6mt/k2t8S8BjaWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1S3eO/yTbpd9sAWQTV5I0y8cg7nxLveHUreUOdZm370SbbMN+D4IXR8UE+lyXMFdEH7OA+PhbLbNBDq4v4Jtnd+ZfsCu2i4lu+gmsVzfVSQKpIcbYJONVoYcU5ukJM5k181d2E08DjWq3hECWTztgrnbXqNBqCKY95QqvOV6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3gYsRiA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso1459181fa.1;
        Wed, 02 Oct 2024 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727893846; x=1728498646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCJKQj92YUp9lYjcAYVWHDwb92zO+RIIleVkehLxHkk=;
        b=P3gYsRiAtUVVXAR/FICWNFJf17M+FZZnMPwpEUw7V78TR7+OfpS7X4cCd10rjhlOik
         D9tM6+SNVXAxytYdB2+e6oYx8r6C9YleH+53gm343roBBpodBIUmH5It5Zkc0SEV1dWo
         qDG9/Mr0U0IIUbRaJP3tMDAAtlfr2Kvr8W5uylvoGWqIxG8HefLLmDkjGNPpH2sIKup1
         8ZdJ4EhLTWe7JdrojlXypjXtGPe4f82gkAxXfDBtZZSgxcTh0thfQ/9vRD18QEBnbuHt
         W9IxyypVg8R5AAqjPhnOUpCvghUz4c1M2UDPoeFltkgEBNxWAnqOe9fcbk2lsP7eXkqk
         Gi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727893846; x=1728498646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCJKQj92YUp9lYjcAYVWHDwb92zO+RIIleVkehLxHkk=;
        b=OKuXh9eWDA693AuJes+9c496BHbXq/Ush6DLpkmoBqjcfr7spfATBjK2it8ZtZAqRu
         CGincM7FR98TtKFbA9wttI5uYdP7k/TSQoIOOIlBqUEGA6NeTuLWtu1W29l8ZeJH7GVx
         wuKqkfYMu2eu0x8DyWa3FmgkJgLftaUDyMYJnYnZh+DQuft/A4b2Ej6QyAHaFCG08iIF
         hRACPRAE/l6gDkiJ4wMgjRmYYMVgo4C04YeQiK6g/PcaUEkStz+1/zQglW1amw08J8EE
         wlgerAZljhwNyVWBJbb6sdifkhiRBgLd19qfrv8EJcbDu1bxs/cDuNc0ir+VZZ/JaLS6
         bOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFlr2Mk2dxLw+enenJWqRxwXb7lCpmBffcPyp6G11Ppuo46yYgT7AfdGDhiCzw1KVcYbistY6+Xsl/100=@vger.kernel.org, AJvYcCVgeMNqA88kIn2r2Z3GJzgleEdnXGoaiLeAWCfe+lgokhqgr39BBlLbNx9tEO4aUU+9Og/SIy4w@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIjruae/gt6Z7kYZombpMBxcvn1ROjNwV3gzyqbaQPH4tKfUL
	Cdc+aLYi3niepGmucNIhRQ1cnKZu98puXNrWH3lxVpGMJg9m47Q9MQbfHqFmZs9O/0xWLk5mGb2
	hzMuBlvJM5NhuLDStthOdtghCACA=
X-Google-Smtp-Source: AGHT+IGejH4I7ojpQ9eTpLEzvNUqv6TXekoWAianOs0i1fVMU1e8y3mYHlllAqf3VecKFG7Of/ZhNSRZbPNVMb8b5yo=
X-Received: by 2002:a05:651c:2105:b0:2fa:c0c2:d311 with SMTP id
 38308e7fff4ca-2fae10226e4mr37736171fa.5.1727893845890; Wed, 02 Oct 2024
 11:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y137nxqs.fsf@yhuang6-desk2.ccr.corp.intel.com> <20241002015754.969-1-21cnbao@gmail.com>
In-Reply-To: <20241002015754.969-1-21cnbao@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 3 Oct 2024 02:30:29 +0800
Message-ID: <CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG03+2i_mhuP5CQPSOPrmQ@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid unconditional one-tick sleep when
 swapcache_prepare fails
To: Barry Song <21cnbao@gmail.com>
Cc: ying.huang@intel.com, akpm@linux-foundation.org, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	liyangouwen1@oppo.com, mhocko@suse.com, minchan@kernel.org, sj@kernel.org, 
	stable@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:02=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Oct 2, 2024 at 8:43=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > On Tue, Oct 1, 2024 at 7:43=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
> > >>
> > >> Barry Song <21cnbao@gmail.com> writes:
> > >>
> > >> > On Sun, Sep 29, 2024 at 3:43=E2=80=AFPM Huang, Ying <ying.huang@in=
tel.com> wrote:
> > >> >>
> > >> >> Hi, Barry,
> > >> >>
> > >> >> Barry Song <21cnbao@gmail.com> writes:
> > >> >>
> > >> >> > From: Barry Song <v-songbaohua@oppo.com>
> > >> >> >
> > >> >> > Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache=
")
> > >> >> > introduced an unconditional one-tick sleep when `swapcache_prep=
are()`
> > >> >> > fails, which has led to reports of UI stuttering on latency-sen=
sitive
> > >> >> > Android devices. To address this, we can use a waitqueue to wak=
e up
> > >> >> > tasks that fail `swapcache_prepare()` sooner, instead of always
> > >> >> > sleeping for a full tick. While tasks may occasionally be woken=
 by an
> > >> >> > unrelated `do_swap_page()`, this method is preferable to two sc=
enarios:
> > >> >> > rapid re-entry into page faults, which can cause livelocks, and
> > >> >> > multiple millisecond sleeps, which visibly degrade user experie=
nce.
> > >> >>
> > >> >> In general, I think that this works.  Why not extend the solution=
 to
> > >> >> cover schedule_timeout_uninterruptible() in __read_swap_cache_asy=
nc()
> > >> >> too?  We can call wake_up() when we clear SWAP_HAS_CACHE.  To avo=
id
> > >> >
> > >> > Hi Ying,
> > >> > Thanks for your comments.
> > >> > I feel extending the solution to __read_swap_cache_async() should =
be done
> > >> > in a separate patch. On phones, I've never encountered any issues =
reported
> > >> > on that path, so it might be better suited for an optimization rat=
her than a
> > >> > hotfix?

Hi Barry and Ying,

For the __read_swap_cache_async case, I'm not really against adding a
similar workqueue, but if no one is really suffering from it, and if
the workqueue do causes extra overhead, maybe we can ignore it for the
__read_swap_cache_async case now, and I plan to resent the following
patch:
https://lore.kernel.org/linux-mm/20240326185032.72159-9-ryncsn@gmail.com/#r

It removed all schedule_timeout_uninterruptible workaround and other
similar things, and the performance will go even higher.

> > >>
> > >> Yes.  It's fine to do that in another patch as optimization.
> > >
> > > Ok. I'll prepare a separate patch for optimizing that path.
> >
> > Thanks!
> >
> > >>
> > >> >> overhead to call wake_up() when there's no task waiting, we can u=
se an
> > >> >> atomic to count waiting tasks.
> > >> >
> > >> > I'm not sure it's worth adding the complexity, as wake_up() on an =
empty
> > >> > waitqueue should have a very low cost on its own?
> > >>
> > >> wake_up() needs to call spin_lock_irqsave() unconditionally on a glo=
bal
> > >> shared lock.  On systems with many CPUs (such servers), this may cau=
se
> > >> severe lock contention.  Even the cache ping-pong may hurt performan=
ce
> > >> much.
> > >
> > > I understand that cache synchronization was a significant issue befor=
e
> > > qspinlock, but it seems to be less of a concern after its implementat=
ion.
> >
> > Unfortunately, qspinlock cannot eliminate cache ping-pong issue, as
> > discussed in the following thread.
> >
> > https://lore.kernel.org/lkml/20220510192708.GQ76023@worktop.programming=
.kicks-ass.net/
> >
> > > However, using a global atomic variable would still trigger cache bro=
adcasts,
> > > correct?
> >
> > We can only change the atomic variable to non-zero when
> > swapcache_prepare() returns non-zero, and call wake_up() when the atomi=
c
> > variable is non-zero.  Because swapcache_prepare() returns 0 most times=
,
> > the atomic variable is 0 most times.  If we don't change the value of
> > atomic variable, cache ping-pong will not be triggered.
>
> yes. this can be implemented by adding another atomic variable.
>
> >
> > Hi, Kairui,
> >
> > Do you have some test cases to test parallel zram swap-in?  If so, that
> > can be used to verify whether cache ping-pong is an issue and whether i=
t
> > can be fixed via a global atomic variable.
> >
>
> Yes, Kairui please run a test on your machine with lots of cores before
> and after adding a global atomic variable as suggested by Ying. I am
> sorry I don't have a server machine.

I just had a try with the build kernel test which I used for the
allocator patch series, with -j64, 1G memcg on my local branch:

Without the patch:
2677.63user 9100.43system 3:33.15elapsed 5452%CPU (0avgtext+0avgdata
863284maxresident)k
2671.40user 8969.07system 3:33.67elapsed 5447%CPU (0avgtext+0avgdata
863316maxresident)k
2673.66user 8973.90system 3:33.18elapsed 5463%CPU (0avgtext+0avgdata
863284maxresident)k

With the patch:
2655.05user 9134.21system 3:35.63elapsed 5467%CPU (0avgtext+0avgdata
863288maxresident)k
2652.57user 9104.87system 3:35.07elapsed 5466%CPU (0avgtext+0avgdata
863272maxresident)k
2665.44user 9155.97system 3:35.92elapsed 5474%CPU (0avgtext+0avgdata
863316maxresident)k

Only three test runs, the main bottleneck for the test is still some
other locks (list_lru lock, swap cgroup lock etc), but it does show
the performance seems a bit lower. Could be considered a trivial
amount of overhead so I think it's acceptable for the SYNC_IO path.

