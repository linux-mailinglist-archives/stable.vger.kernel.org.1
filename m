Return-Path: <stable+bounces-166491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D782B1A553
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA018A22E7
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D4212B1E;
	Mon,  4 Aug 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhOxv0Hy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA9205513
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319376; cv=none; b=mXsW20RqcV24w316ajoIjegstgb1AauogGPnf4KJcolLoFYt2h6QCZNNDVpYqTaBmMenl/T3weVXYXBlxXJXSyKD5LbCRXjziXN17K/v08Jy20r7kQU7kJK+oEwiBTtWmEmCV7ECQVCSa+nnKMHhHcVsFpixj2Th9GHUD5EwZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319376; c=relaxed/simple;
	bh=dVdTAN2x6P43907+J1kuyQHg6fpi47cOZkiklqMG5+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYMed3L32blqOsvAx1GCkERHhx/LJTeXKX6mIjBcdPsUcfk/WLh/hFVhO8K+4bgkzmcI1vXACcYc066TPQ/JCJP1d+rCdP+EIawdzdZ2ld/0cdsoTZLlFij5BYSxL0+RHOFT6HXnX1OzgolSMT/x6lpcWJorRso81EXmye3GcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhOxv0Hy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso16260a12.1
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754319373; x=1754924173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yG7q4AtpIF13Ztwzp94d6pI4f+GNZwbRUugDPX70tPo=;
        b=AhOxv0HydbCl+HiPXNoKA1sVimGheONMaXGSmr0tAtJtQdtZPR0pb/+bCdJNDZm5LV
         +hk/3/kQLFhRyed9K7/vAnvOBVoR6QSa9XyLp6lyuxwaoB7fJUAEuLx7ndOEW8RPUHuE
         uatvcVlUJJ3/ujvZg0B0IzVtL9zigEsuusyZgnitOjxxHFcdKhTqH8OjPJx0icZ6HoBf
         t8RVirrltbbEmTygc8qik076qPt4WIH7eMLfYd7WTKRJXVMPpdU3YXelerXIXmtllji5
         v6uav6G07WlmGex2YVLMqPQlj7kd1rEcoCHhbZBhgS6J3W/KyB3Ypo87WnZQ9eBJJV+g
         X5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319373; x=1754924173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG7q4AtpIF13Ztwzp94d6pI4f+GNZwbRUugDPX70tPo=;
        b=IvHPltmQ72tp/rw9NXMSfsK9k6RyQBH89Yuc69P4xwXP72wEVhAYr+yaS7cN2mDM/s
         EAkZg6J0MXisrbgAnyNKU1i0YfQEzp+GMTBWXP1ic/8yMff/nDSzIAMeg0QWwQtr6sPg
         PzsGJ4ObPYn4/UJqHz8Tj0A6VVfou5Y2m5963Gp4S7R4vmRQ7HG41b8ZzSVQn9YmWT1J
         eiZ5oLL6xsZTA3V9626E6CQzpggXxF2YiJC9OjgFJ72u5Bj5qbb6BHvxlUYBrCVM58Un
         qUuJ4ZOBD4Uaem5RQI3PoEMTVnh5AYxILfo4aT1Kmhi/QIBKu6jVD4p+Ujqt6t2qanta
         p2SA==
X-Forwarded-Encrypted: i=1; AJvYcCXrG2hhayK9IJjDACIfHkFDQWiArhX4UlxEupA0dPRLi5nJKB4vu0+iyt5gmNcHnNpdLJxg6Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/ys+wl50dZ/M5URCTIRS0gWtj9WO/IVpSyA+SUPjgR6JuS2g
	Wq+Ud6EN/S8+tIc3oYD60pKp1PwaWfEK0edY6JVUjVH8L9jvBC0Fy5oWbJeRAL5YG6DRiVnMFNY
	G1AydKLwGnnoq7cidJZ2cMbSxOlKYcV181cSg233k
X-Gm-Gg: ASbGncsFzdfUxnsXQtYx5ya0ZD35da+Mzv5PlOM6ra9tD0+eX/xQyGtQC8E0M3DFXtN
	swsW1hKkIxKhEmH5Yq/rrLSPC5AK96/H6Tkds1StrarxG1fLbTsnCIQ38TIQ4KtLVkyeapjdONF
	do9BpTpRh+wm7MOL3SP2rm83DkVcMgRod9lkQkE86pq9WMBmULuTueH1JX0JG5GcbMo2X0ntkgs
	mXPdRiRcYulFK31e/K9GyWC/mWFzBifVufG
X-Google-Smtp-Source: AGHT+IFcOjuCnbYQZwvlG5KyfYqyjzSOQr9Nwb/TB0qh9/KM5LnDN1rLp3TAHQFhp0YRSrHDXnlOUyIJakH1n20Rlg4=
X-Received: by 2002:a05:6402:221b:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-615e7bcec79mr123893a12.2.1754319372415; Mon, 04 Aug 2025
 07:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com> <aIvusYlauznxttGc@google.com>
In-Reply-To: <aIvusYlauznxttGc@google.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 4 Aug 2025 16:55:36 +0200
X-Gm-Features: Ac12FXzGdw8VlISssOEsTsIwyDft5BIvfr4SPTIVHbJ3HmW4ozwT00KZBfHMOJU
Message-ID: <CAG48ez3mzb=qTQ9H3qwYaRc3aVtnA0pu=eB8JFHgqv1YUNYTrw@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: Fix semi-unbounded recursion
To: Carlos Llamas <cmllamas@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:31=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
> On Fri, Jul 11, 2025 at 06:33:36PM +0200, Jann Horn wrote:
> > Ensure that epoll instances can never form a graph deeper than
> > EP_MAX_NESTS+1 links.
> >
> > Currently, ep_loop_check_proc() ensures that the graph is loop-free and
> > does some recursion depth checks, but those recursion depth checks don'=
t
> > limit the depth of the resulting tree for two reasons:
> >
> >  - They don't look upwards in the tree.
> >  - If there are multiple downwards paths of different lengths, only one=
 of
> >    the paths is actually considered for the depth check since commit
> >    28d82dc1c4ed ("epoll: limit paths").
> >
> > Essentially, the current recursion depth check in ep_loop_check_proc() =
just
> > serves to prevent it from recursing too deeply while checking for loops=
.
> >
> > A more thorough check is done in reverse_path_check() after the new gra=
ph
> > edge has already been created; this checks, among other things, that no
> > paths going upwards from any non-epoll file with a length of more than =
5
> > edges exist. However, this check does not apply to non-epoll files.
> >
> > As a result, it is possible to recurse to a depth of at least roughly 5=
00,
> > tested on v6.15. (I am unsure if deeper recursion is possible; and this=
 may
> > have changed with commit 8c44dac8add7 ("eventpoll: Fix priority inversi=
on
> > problem").)
> >
> > To fix it:
> >
> > 1. In ep_loop_check_proc(), note the subtree depth of each visited node=
,
> > and use subtree depths for the total depth calculation even when a subt=
ree
> > has already been visited.
> > 2. Add ep_get_upwards_depth_proc() for similarly determining the maximu=
m
> > depth of an upwards walk.
> > 3. In ep_loop_check(), use these values to limit the total path length
> > between epoll nodes to EP_MAX_NESTS edges.
> >
> > Fixes: 22bacca48a17 ("epoll: prevent creating circular epoll structures=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
>
> Hey Jann,
>
> I've bisected an LTP test failure to this commit and I can't find any
> reports of this. The test is epoll_ctl04:
>
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sy=
scalls/epoll_ctl/epoll_ctl04.c
>
> This is what I get:
>   ####################################################################3
>   root@debian:~# ./epoll_ctl04
>   tst_test.c:2004: TINFO: LTP version: 20250530-116-g91e6272fe
>   tst_test.c:2007: TINFO: Tested kernel: 6.16.0-rc1-00017-gf2e467a48287 #=
28 SMP PREEMPT Thu Jul 31 21:12:22 UTC 2025 aarch64
>   tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>   tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
>   epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number=
 of nesting is 5 expected EINVAL: ELOOP (40)
>
>   Summary:
>   passed   0
>   failed   1
>   broken   0
>   skipped  0
>   warnings 0
>   ####################################################################3
>
>
> I haven't looked much into this but it seems the test expects EINVAL at
> nesting depth 5 and is instead getting ELOOP. Any chance there is an
> off-by-one error in ep_loop_check() as it fails with depth=3D4 and
> upwards_depth=3D0, which isn't correct?

This is an area where the existing code is very inconsistent in how it
reports errors; limits on the structure of the epoll graph (in
particular limits on the graph depth) are enforced by both
ep_loop_check() (which fails with ELOOP) and reverse_path_check()
(which fails with EINVAL). The comments suggest that ep_loop_check()
is supposed to be doing depth checks, and reverse_path_check() is
mostly supposed to count wakeup paths, but reverse_path_check()
happens to be what you hit in that LTP testcase.

The manpage also says that ELOOP is for too-deep nesting, and does not
mention this case of EINVAL at all. (It doesn't even mention the
wakeup path count restriction in the ERRORS section...)

I think this is one of those cases where the existing semantics are
too convoluted and tainted with kernel implementation details for
userspace to have handled the existing error cases well enough to be
broken by this change; the existing behavior was something like (not
sure if I'm getting it exactly right) "ELOOP is for loops; EINVAL is
for hitting a depth limit when constructing a chain of epoll instances
with a file at the bottom; ELOOP is for hitting a depth limit when
constructing a chain of epoll instances with no file at the bottom and
you'd only get it depending on which way around you build the chain
and, for more complex structures, in what order the addresses of
kernel objects are"; and the implementation was different from what
the manpage says.

So my opinion is that the right fix is to change the testcase to also
accept ELOOP, though I can see how a bugfix that breaks a unit test is
going to raise eyebrows.

> ---
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 44648cc09250..811960b2a74c 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2237,7 +2237,7 @@ static int ep_loop_check(struct eventpoll *ep, stru=
ct eventpoll *to)
>         upwards_depth =3D ep_get_upwards_depth_proc(ep, 0);
>         rcu_read_unlock();
>
> -       return (depth+1+upwards_depth > EP_MAX_NESTS) ? -1 : 0;
> +       return (depth+upwards_depth > EP_MAX_NESTS) ? -1 : 0;

Here I am calculating: We want to create a new link between two nodes,
and want to know how long the longest resulting chain of epoll
instances will be. For that, I add the following numbers of links:

 - The number of links going upwards from "ep".
 - One for the new link we're adding.
 - The number of links going downward from "to".

So I think this is correct.

