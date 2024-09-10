Return-Path: <stable+bounces-75759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8558297448F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 23:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C00B2319E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7261A4E93;
	Tue, 10 Sep 2024 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRR034iT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52B17622D
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002520; cv=none; b=Mx81yc4halowTgXgEFGsFBvoeEVK7xqlFidxbPTylD+y3me2IZuY3vQQZy+hIZ14V7SMarH4MhsR0rR9X9eQxmoXXTTfkMK0RlR0rBO0VGQZk0QwHRjIUSbj4ECdMdON87mOrOwtsKcRTWO393Ke9C8gCXtqmqbkegreTjaQM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002520; c=relaxed/simple;
	bh=+Fk9UzrrxgDtzk9tBnqOZptBV+x80xDALxfGAbo/iTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNtFXEKxkz6jLiwUTOWC4ZD9CsAp7VLy33Lulwc72+VNCJu5GOmoFoe5I381lLmvw86Y6bFJHWbf4R1kGq8OYU83Ew2PiCbG0NQ144B2iPqjfgpN7W8D2x4sLW+wTIw5RitLbnPmCOkrpcZuwq8PEKt76+RdWIT+ButEgATIJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRR034iT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2056aa5cefcso261805ad.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 14:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726002518; x=1726607318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BveGV6iRF9zFVjpBi+nwgxW4944d2bGaHruQFFGYVJk=;
        b=HRR034iTaxRUQE+UvHN6nf4awSdi3SCvhTO/WHc8uIl5yQ5SOr/ZUP8OT2VRZhQUEw
         TpDHlLpjsRsM0/EPTCZ8B5IG7uu7QeKdkykIJZZ8yAyS6IqshFFc1J+uNVGv6NZdOzwS
         tUf349mwJ0MSGS1grZKgDbn6068uNc6cEuWRDG6mul+A4YE9o2/UPn91DbWr/8z3QEVU
         Qu8i4mjE3I2scknJcZ4HUB6461OswKMop1B4eQpcU8o+d+42yyGxz5nktIZv/VIp6L6M
         QON3+M/e5LPHhHmEf+Sz9S1zgGX5QB7okmbSQ0WkrGa4ysGoZd0v4mkcIk9gQn4JkeAv
         ystQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726002518; x=1726607318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BveGV6iRF9zFVjpBi+nwgxW4944d2bGaHruQFFGYVJk=;
        b=ZlSisi/NfVvgoKOyME4wtsGQTkf+ytf4kdyxQabYcz5a+bH4R778swwJP+f0VhQLMS
         dt93+Qo79AqB7lf91AUtB7uuoxM69ce4T42YojkfwzE82rVybOu+F2lITKjbETQggamR
         IeynH9G7FdmFnsAQfrSRX9n4gPqeM/JHdMwatb7IAtl47FgvJNS6NI+1Y0INRozUCy8t
         KIfzF/ll2rvSJWngh+8WNtvWbHrZtokUwVTAsXVrCCjH/XJdu/Y5i22ZJzXAN71Gplje
         QyRlKsEwOzkQ1Kry7k5K+BZMHkz6HHynbaWMAIPcRDlYs6DgBo9jikzaDePLrPmNpSGP
         4CXw==
X-Forwarded-Encrypted: i=1; AJvYcCXvYMdaTFkNoLy8s0WNZlp+uRjsnokyGhbiNMVHG6QVuwcQM3FT0H+rx8Tfdk75Cv9FcDP5Q7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBGRoh7bX6aD19Q8J8PbqpuwXQRuUqSUld6ObEUWBM4GcsGOnX
	mfGClBdj22P7RoJTZRe3Cejx9B1ypnE3+CD6tmwwWjdFCgJ0s22mxSBH7ju4yT3XLvasvRboRRY
	XlO8TNwFZ9QIsvKD2/3C/tFVEU82/TbcR0hSeWjzRENiXZvA59g==
X-Google-Smtp-Source: AGHT+IFC9yDBHadulsKhLHkQ8edvdmasODgKlo+OL0JfS70ItBNSRIPdBzMcm3B167u4esU1PZxmDa/fInewSmUZgQw=
X-Received: by 2002:a17:902:d4cd:b0:206:ad19:c0fa with SMTP id
 d9443c01a7336-20753a1237cmr886275ad.0.1726002518392; Tue, 10 Sep 2024
 14:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
 <20240909163610.2148932-1-ovt@google.com> <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
 <CACGj0ChtssX4hCCEnD9hah+-ioxmAB8SzFjJR3Uk1FEWMizv-A@mail.gmail.com> <8d95e5334c664d10a751e5791c8291959217524e.camel@hammerspace.com>
In-Reply-To: <8d95e5334c664d10a751e5791c8291959217524e.camel@hammerspace.com>
From: Oleksandr Tymoshenko <ovt@google.com>
Date: Tue, 10 Sep 2024 14:08:25 -0700
Message-ID: <CACGj0CgobBUv9CgpAhw+XWFwJY7+A0MryOTyukXz8Jsoc9hdQw@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>, "jbongio@google.com" <jbongio@google.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 5:22=E2=80=AFPM Trond Myklebust <trondmy@hammerspace=
.com> wrote:
>
> On Mon, 2024-09-09 at 16:06 -0700, Oleksandr Tymoshenko wrote:
> > On Mon, Sep 9, 2024 at 10:56=E2=80=AFAM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Mon, 2024-09-09 at 16:36 +0000, Oleksandr Tymoshenko wrote:
> > > > > > nfs41_init_clientid does not signal a failure condition from
> > > > > > nfs4_proc_exchange_id and nfs4_proc_create_session to a
> > > > > > client
> > > > > > which
> > > > > > may
> > > > > > lead to mount syscall indefinitely blocked in the following
> > > > > > stack
> > > >
> > > > > NACK. This will break all sorts of recovery scenarios, because
> > > > > it
> > > > > doesn't distinguish between an initial 'mount' and a server
> > > > > reboot
> > > > > recovery situation.
> > > > > Even in the case where we are in the initial mount, it also
> > > > > doesn't
> > > > > distinguish between transient errors such as NFS4ERR_DELAY or
> > > > > reboot
> > > > > errors such as NFS4ERR_STALE_CLIENTID, etc.
> > > >
> > > > > Exactly what is the scenario that is causing your hang? Let's
> > > > > try
> > > > > to
> > > > > address that with a more targeted fix.
> > > >
> > > > The scenario is as follows: there are several NFS servers and
> > > > several
> > > > production machines with multiple NFS mounts. This is a
> > > > containerized
> > > > multi-tennant workflow so every tennant gets its own NFS mount to
> > > > access their
> > > > data. At some point nfs41_init_clientid fails in the initial
> > > > mount.nfs call
> > > > and all subsequent mount.nfs calls just hang in
> > > > nfs_wait_client_init_complete
> > > > until the original one, where nfs4_proc_exchange_id has failed,
> > > > is
> > > > killed.
> > > >
> > > > The cause of the nfs41_init_clientid failure in the production
> > > > case
> > > > is a timeout.
> > > > The following error message is observed in logs:
> > > >   NFS: state manager: lease expired failed on NFSv4 server <ip>
> > > > with
> > > > error 110
> > > >
> > >
> > > How about something like the following fix then?
> > > 8<-----------------------------------------------
> > > From eb402b489bb0d0ada1a3dd9101d4d7e193402e46 Mon Sep 17 00:00:00
> > > 2001
> > > Message-ID:
> > > <eb402b489bb0d0ada1a3dd9101d4d7e193402e46.1725904471.git.trond.mykl
> > > ebust@hammerspace.com>
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Date: Mon, 9 Sep 2024 13:47:07 -0400
> > > Subject: [PATCH] NFSv4: Fail mounts if the lease setup times out
> > >
> > > If the server is down when the client is trying to mount, so that
> > > the
> > > calls to exchange_id or create_session fail, then we should allow
> > > the
> > > mount system call to fail rather than hang and block other
> > > mount/umount
> > > calls.
> > >
> > > Reported-by: Oleksandr Tymoshenko <ovt@google.com>
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  fs/nfs/nfs4state.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > > index 30aba1dedaba..59dcdf9bc7b4 100644
> > > --- a/fs/nfs/nfs4state.c
> > > +++ b/fs/nfs/nfs4state.c
> > > @@ -2024,6 +2024,12 @@ static int
> > > nfs4_handle_reclaim_lease_error(struct nfs_client *clp, int status)
> > >                 nfs_mark_client_ready(clp, -EPERM);
> > >                 clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
> > >                 return -EPERM;
> > > +       case -ETIMEDOUT:
> > > +               if (clp->cl_cons_state =3D=3D NFS_CS_SESSION_INITING)=
 {
> > > +                       nfs_mark_client_ready(clp, -EIO);
> > > +                       return -EIO;
> > > +               }
> > > +               fallthrough;
> > >         case -EACCES:
> > >         case -NFS4ERR_DELAY:
> > >         case -EAGAIN:
> > > --
> >
> > This patch fixes the issue in my simulated environment. ETIMEDOUT is
> > the error code that
> > was observed in the production env but I guess it's not the only
> > possible one. Would it make
> > sense to handle all error conditions in the NFS_CS_SESSION_INITING
> > state or are there
> > some others that are recoverable?
> >
>
> The only other one that I'm thinking might want to be treated similarly
> is the above EACCES error. That's because that is only returned if
> there is a problem with your RPCSEC_GSS/krb5 credential. I was thinking
> of changing that one too in the same patch, but came to the conclusion
> it would be better to treat the two issues with separate fixes.
>
> The other error conditions are all supposed to be transient NFS level
> errors. They should not be treated as fatal.

Sounds good. Will you submit this patch to the mainline kernel? If so
please add me to Cc. Thanks for looking into this.

