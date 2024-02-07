Return-Path: <stable+bounces-19250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED984D55D
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 23:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25DFB26B13
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 22:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A3149DF7;
	Wed,  7 Feb 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKlnVZON"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7D13699C
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341285; cv=none; b=M7CPcrtHotgz0aF1RfXa0oDWlzAY3oJz4se1OHGIl6E1Aogj4D8XwTnwGmvUGy5AwynKdbagPZ8v22JOGXCM0mSDDqVgs+nNlMuF29Vetnc43hB4IWrPs5me+hmKQQFDC6w8ngM0m1FZl0SALtOIkZC8yZQ7g8ePjBjYot+rgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341285; c=relaxed/simple;
	bh=TcuoTBYzJOyVKpA/NOdorcJZuoBN+Bx+mnRuQV92i2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbdCvrEDg+CNC+OE3wiLDq1qeg29ZCRzwpWHSZnwZnw0ip13GPFunoyStNZgswmCCbkocy5i3C8PmNZZ23dIu9Fgohfp2GJ/Uj7ZPpuaB/pE/7iVHVSu7G27N3y/JwdVyvmYpXc0i6gqESBK/xpvoGqX47q/QrO5BzKooHoOoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKlnVZON; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707341283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsF5scQbGC/NKEqVyzUdcfrlWaBsz3GB8A3Ix6fxwJM=;
	b=EKlnVZON0TRtxGa5MPgaos3JZDc7hRrDIi2Nk3LPiXqIfqTiTK02GnSCfyGGHQU4q4/1z5
	J+j5sckBlKpp50Lto5eisydXXIpZLO1eKGokwTHcogLISmbzhWdumY4rXO7iIaTssUDSat
	YcX70eTygfalCU2/cwDq/pq2swdENUs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-9GIhdDOEMpGkb23I-UXxgQ-1; Wed, 07 Feb 2024 16:28:01 -0500
X-MC-Unique: 9GIhdDOEMpGkb23I-UXxgQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d0a20a788dso11822881fa.1
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 13:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341280; x=1707946080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsF5scQbGC/NKEqVyzUdcfrlWaBsz3GB8A3Ix6fxwJM=;
        b=DGW5gQHrRZ6FbJm7Pv0J9bRWqHzw/8jYML9jzxtkQ+uLsxUijciMLhW4Py0fw0OY9B
         bh+G6Xdh3CYd7y2D7fVUZJg1Inuf6ICgUgSIAZ3sM/O44u84U0Ye0mCqdlGk+9eim6fb
         MzRf9h2TQub0aJgnhzsbOk+odhvYDa4aFzOqGjJcvdnu0ocp6U+3H419Ri/65716FrDZ
         lmbot3s1TNi8PttST1HNDROKVVYLw5D/Gy7gnttETOqvJOxGUORoA70VYpmQB7oW8/4G
         8Y/BKfrG5nNm7CS/RteuztAIKnSkzIXgzNW0vWF4QAinovuwyIcwr9VCbuTx2PND+brY
         knFw==
X-Forwarded-Encrypted: i=1; AJvYcCXOHUsvEToRwA/hRQqwH6eHNpeMSlzUbOLcCaudkPYxV94FqxPJEFfSu4aqvlRxZHGn73sXKTMXng9B0ibg+tXLrCKfxF94
X-Gm-Message-State: AOJu0YzAiA+Rgw7gGSvhx784PmgMhMOWKga0OqKTWSoChjThvoxAZxtj
	XfckxMrNG8b91K3KrhIaAZXH0HbACOmaJh+UhnlmLqzdCJyXSiZIZ8aenmTrx1HV5OlyUzvB5uH
	x8kdeTLcdy8bbmLbg7Pz9X2tRGfABR1gJL9rsw0EDhJBjCwBf+Xy77UQpJgPQi+pENe8mfP5fbl
	gTCfRshgxU3SarPgeTfdde/8pmtkYk
X-Received: by 2002:a05:651c:211c:b0:2d0:c176:ebcc with SMTP id a28-20020a05651c211c00b002d0c176ebccmr5145862ljq.18.1707341280229;
        Wed, 07 Feb 2024 13:28:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn1f4xD8ODxbeXjM0ldAqf8jj+ZejpBEaAt+zqZ446U/CEMk1rYJTD5iEcL9px/pawkKbLVveasSpw7fcHSDI=
X-Received: by 2002:a05:651c:211c:b0:2d0:c176:ebcc with SMTP id
 a28-20020a05651c211c00b002d0c176ebccmr5145847ljq.18.1707341279916; Wed, 07
 Feb 2024 13:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan> <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
In-Reply-To: <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 7 Feb 2024 16:27:48 -0500
Message-ID: <CAK-6q+hza9yXb5KpBS2VJMNHJa805nXqiYPTovnf9G-JFadBsg@mail.gmail.com>
Subject: Re: [regression 6.1.67] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Jordan Rife <jrife@google.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Valentin Kleibel <valentin@vrvis.at>, 
	David Teigland <teigland@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 7, 2024 at 1:33=E2=80=AFPM Jordan Rife <jrife@google.com> wrote=
:
>
> On Wed, Feb 7, 2024 at 2:39=E2=80=AFAM Salvatore Bonaccorso <carnil@debia=
n.org> wrote:
> >
> > Hi Valentin, hi all
> >
> > [This is about a regression reported in Debian for 6.1.67]
> >
> > On Tue, Feb 06, 2024 at 01:00:11PM +0100, Valentin Kleibel wrote:
> > > Package: linux-image-amd64
> > > Version: 6.1.76+1
> > > Source: linux
> > > Source-Version: 6.1.76+1
> > > Severity: important
> > > Control: notfound -1 6.6.15-2
> > >
> > > Dear Maintainers,
> > >
> > > We discovered a bug affecting dlm that prevents any tcp communication=
s by
> > > dlm when booted with debian kernel 6.1.76-1.
> > >
> > > Dlm startup works (corosync-cpgtool shows the dlm:controld group with=
 all
> > > expected nodes) but as soon as we try to add a lockspace dmesg shows:
> > > ```
> > > dlm: Using TCP for communications
> > > dlm: cannot start dlm midcomms -97
> > > ```
> > >
> > > It seems that commit "dlm: use kernel_connect() and kernel_bind()"
> > > (e9cdebbe) was merged to 6.1.
> > >
> > > Checking the code it seems that the changed function dlm_tcp_listen_b=
ind()
> > > fails with exit code 97 (EAFNOSUPPORT)
> > > It is called from
> > >
> > > dlm/lockspace.c: threads_start() -> dlm_midcomms_start()
> > > dlm/midcomms.c: dlm_midcomms_start() -> dlm_lowcomms_start()
> > > dlm/lowcomms.c: dlm_lowcomms_start() -> dlm_listen_for_all() ->
> > > dlm_proto_ops->listen_bind() =3D dlm_tcp_listen_bind()
> > >
> > > The error code is returned all the way to threads_start() where the e=
rror
> > > message is emmitted.
> > >
> > > Booting with the unsigned kernel from testing (6.6.15-2), which also
> > > contains this commit, works without issues.
> > >
> > > I'm not sure what additional changes are required to get this working=
 or if
> > > rolling back this change is an option.
> > >
> > > We'd be happy to test patches that might fix this issue.
> >
> > Thanks for your report. So we have a 6.1.76 specific regression for
> > the backport of e9cdebbe23f1 ("dlm: use kernel_connect() and
> > kernel_bind()") .
> >
> > Let's loop in the upstream regression list for tracking and people
> > involved for the subsystem to see if the issue can be identified. As
> > it is working for 6.6.15 which includes the commit backport as well it
> > might be very well that a prerequisite is missing.
> >
> > # annotate regression with 6.1.y specific commit
> > #regzbot ^introduced e11dea8f503341507018b60906c4a9e7332f3663
> > #regzbot link: https://bugs.debian.org/1063338
> >
> > Any ideas?
> >
> > Regards,
> > Salvatore
>
>
> Just a quick look comparing dlm_tcp_listen_bind between the latest 6.1
> and 6.6 stable branches,
> it looks like there is a mismatch here with the dlm_local_addr[0] paramet=
er.
>
> 6.1
> ----
>
> static int dlm_tcp_listen_bind(struct socket *sock)
> {
> int addr_len;
>
> /* Bind to our port */
> make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
>    addr_len);
> }
>
> 6.6
> ----
> static int dlm_tcp_listen_bind(struct socket *sock)
> {
> int addr_len;
>
> /* Bind to our port */
> make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
>    addr_len);
> }
>
> 6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on heap)=
 which
> changed
>
> static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
>
> to
>
> static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];
>
> It looks like kernel_bind() in 6.1 needs to be modified to match.
>

makes sense. I tried to cherry-pick e9cdebbe23f1 ("dlm: use
kernel_connect() and kernel_bind()") on v6.1.67 as I don't see it
there. It failed and does not apply cleanly.

Are we talking here about a debian kernel specific backport? If so,
maybe somebody missed to modify those parts you mentioned.

- Alex


