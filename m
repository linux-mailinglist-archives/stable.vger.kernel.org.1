Return-Path: <stable+bounces-74095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D350197258D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 01:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F931F2483E
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D808F18D64B;
	Mon,  9 Sep 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkqQABt5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556918CBF0
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923196; cv=none; b=eyyXanKWTVy1v7dQ6M4KGNbYEix/o/7/cpEvCw2VYQS/tf4JA+cBG0cG9UkWzG4ZzETT6S16ZY6iXFDAwt8i+voeiar0YYtqYrhK5V4YhyPlcM32Pe2vt/336A0li1bth8SC+FjSfI655zFqO4oFNnsOVyeN7W/8wux4zWCQzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923196; c=relaxed/simple;
	bh=tA4DWGGXl2wN/3VFbN2IepAYv+ZlqamBVMEW+67Gtp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVNZyhu4FXSrGlFdr0I7Fp4O8Db+OVPi5k1s7W+d2pgC6p7wvNXcW6qL5KFdD7flitv9ZAQHcBVkHCm1TJ0IYhx9eGVJU/IIxUAMAaXb4PC04/RWk0japkBJpgdbjeCwkjq8jtxIdxsgVrWLbuQqhhlAT5me54Yp5bTID2nMWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkqQABt5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207349fa3d7so35335ad.1
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725923194; x=1726527994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aShBmLESaA758ZKF/fFu1kSn26baZ/8Qzf7h76tj0Gg=;
        b=wkqQABt570HHQiPAmy3fxs4uHmc5axYekRsI6+LQjeA3lUVDDccK2QHCZ76Au15d4k
         ly3wjcAIFdF2uKSpiAIfrl8u9QEI8K4eIYkhCjew3KY5a1OvWAeu1mVInys7NlxzAejW
         WscRWf5YqCJ83bAWdrGnBZiRC2TzYRXGNFtC1l2E8RgB3Htz/FflVVuT3SmsN5OYV/5j
         3ADPa54lBXojSse54ZYkDb8ELsWfN31a72ZARkjb0wjbBeHZS6n/nXJ4EVB/XPyiUCMN
         3qSDP4m5GUgg0yTlPryXJVf9cYUlu0SjG62Gp6AV1semDzD5BY5dKORCo60QGmbIydRv
         QZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725923194; x=1726527994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aShBmLESaA758ZKF/fFu1kSn26baZ/8Qzf7h76tj0Gg=;
        b=Yyk61VB4JTwYblSGiZaJsl0zHHHLg8AbWxkrJAq72TTXW/G5R8XS32pOO9u7r9afRe
         7k+45rOQ2syXPbTFr9PlUeJpXejOAEtKauzUusOITPdhR4Gvuu/vdn+91nD9TfHzz1H1
         Qjqsf+dU+W6l3DLtuRG86VMbWtK8JMWqU7XPcsXT6Dgc3TIzeI7T+c3pYgW7wpSsZf6p
         G+OZxR/lcx32DTJ1/x1C2v1WiTcSHoz9JAx5sfO4nNqLauhnLHi4hu/luEFoFrMRritR
         qnol7RLy41g8iQKI86t1F1W1FbbYtStMDTbtCX70ApS+fNQc7fR8z0oKaI7jlxiIyzlt
         rKMw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+1Gw2DFvFKHfUwY1taOOv2l9AaIhg+Oe8oZ5FIa94X0sSu+oBT+MTt+lSafAPbWPKIrYexI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQR/hPeqDCNy6dRK+DHPxv1TWAQs1DE4M2e3QFsVjbvLYaYS3
	1r9jBi/FdTkcesyr6C7EYqJEeYt0oL3kH3GdmTheo4/Nl0EkViKVmHXHdYutLAstbOef3OklbT/
	WfYwjU5VYuC4/6WFZYx533JW498s3NEIC540H
X-Google-Smtp-Source: AGHT+IEkl1RiJp8XN4JioEsMZ2jra1Qgct/x2XpU+RcMxsDsTaY/b2vMZRoRdd8MaezkBBSKSZKew7Xjwwe+1O5GRiE=
X-Received: by 2002:a17:902:dacd:b0:201:e646:4ca with SMTP id
 d9443c01a7336-20744a38838mr1137015ad.14.1725923194141; Mon, 09 Sep 2024
 16:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
 <20240909163610.2148932-1-ovt@google.com> <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
In-Reply-To: <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
From: Oleksandr Tymoshenko <ovt@google.com>
Date: Mon, 9 Sep 2024 16:06:21 -0700
Message-ID: <CACGj0ChtssX4hCCEnD9hah+-ioxmAB8SzFjJR3Uk1FEWMizv-A@mail.gmail.com>
Subject: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>, "jbongio@google.com" <jbongio@google.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:56=E2=80=AFAM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Mon, 2024-09-09 at 16:36 +0000, Oleksandr Tymoshenko wrote:
> > > > nfs41_init_clientid does not signal a failure condition from
> > > > nfs4_proc_exchange_id and nfs4_proc_create_session to a client
> > > > which
> > > > may
> > > > lead to mount syscall indefinitely blocked in the following stack
> >
> > > NACK. This will break all sorts of recovery scenarios, because it
> > > doesn't distinguish between an initial 'mount' and a server reboot
> > > recovery situation.
> > > Even in the case where we are in the initial mount, it also doesn't
> > > distinguish between transient errors such as NFS4ERR_DELAY or
> > > reboot
> > > errors such as NFS4ERR_STALE_CLIENTID, etc.
> >
> > > Exactly what is the scenario that is causing your hang? Let's try
> > > to
> > > address that with a more targeted fix.
> >
> > The scenario is as follows: there are several NFS servers and several
> > production machines with multiple NFS mounts. This is a containerized
> > multi-tennant workflow so every tennant gets its own NFS mount to
> > access their
> > data. At some point nfs41_init_clientid fails in the initial
> > mount.nfs call
> > and all subsequent mount.nfs calls just hang in
> > nfs_wait_client_init_complete
> > until the original one, where nfs4_proc_exchange_id has failed, is
> > killed.
> >
> > The cause of the nfs41_init_clientid failure in the production case
> > is a timeout.
> > The following error message is observed in logs:
> >   NFS: state manager: lease expired failed on NFSv4 server <ip> with
> > error 110
> >
>
> How about something like the following fix then?
> 8<-----------------------------------------------
> From eb402b489bb0d0ada1a3dd9101d4d7e193402e46 Mon Sep 17 00:00:00 2001
> Message-ID: <eb402b489bb0d0ada1a3dd9101d4d7e193402e46.1725904471.git.tron=
d.myklebust@hammerspace.com>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Mon, 9 Sep 2024 13:47:07 -0400
> Subject: [PATCH] NFSv4: Fail mounts if the lease setup times out
>
> If the server is down when the client is trying to mount, so that the
> calls to exchange_id or create_session fail, then we should allow the
> mount system call to fail rather than hang and block other mount/umount
> calls.
>
> Reported-by: Oleksandr Tymoshenko <ovt@google.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4state.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 30aba1dedaba..59dcdf9bc7b4 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2024,6 +2024,12 @@ static int nfs4_handle_reclaim_lease_error(struct =
nfs_client *clp, int status)
>                 nfs_mark_client_ready(clp, -EPERM);
>                 clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
>                 return -EPERM;
> +       case -ETIMEDOUT:
> +               if (clp->cl_cons_state =3D=3D NFS_CS_SESSION_INITING) {
> +                       nfs_mark_client_ready(clp, -EIO);
> +                       return -EIO;
> +               }
> +               fallthrough;
>         case -EACCES:
>         case -NFS4ERR_DELAY:
>         case -EAGAIN:
> --

This patch fixes the issue in my simulated environment. ETIMEDOUT is
the error code that
was observed in the production env but I guess it's not the only
possible one. Would it make
sense to handle all error conditions in the NFS_CS_SESSION_INITING
state or are there
some others that are recoverable?

