Return-Path: <stable+bounces-118332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52485A3C8D6
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 20:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371CE189DB42
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249E522AE42;
	Wed, 19 Feb 2025 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JncxpRMf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7B225765
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993546; cv=none; b=U9kOlTIQZXfhNPRYKKWfuBEahxDUeJyb13kiC2ZX2kU7OtFWMSB7xbZCW8dSwG9VTlpY9QsfsTDy2hi+2zlELs5//opwfdYI0C15j+tC9+Qpf16eFbT6PG/bA5sWC0YL/G2GcayDOb5uj5zP7iMUC8TcrzLyTuG4MiGfmR6ckUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993546; c=relaxed/simple;
	bh=KctjGfczjWty0xsrVL48LHSIFJwqtiKKyQGtfSsp8RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSZOvuPHLX8LZBAgtlpzT3Sp18CZ4iVFRNrmryDqpt6rlwrowxaRlkXpj3NIt2UUNV5I4iigpxr63qQYeh0tAzQrjKYoZY3r/DOItx1VN3FQ3BCZiJAY4FtkBCnXJPQgbZLTr1M3PmNpdRPltjK5v60EtypVP6upUmo4rTtQ7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JncxpRMf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so288961a91.0
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739993544; x=1740598344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io3OySw226ibYgdV1c+iE1WuhM2fSihofj/VGBUO3M8=;
        b=JncxpRMfwoV/fNnaarWaJ4eNjL5CxIdppLDu7zsuDIiwK253RVDlJwWvKS+bM8M7x7
         AHhVTJyINf1DHmcUQZmOpDmwqlfJ456pqf/KeQg4CoSMn5zXGkH7O0rOx1/kTdo/XcpN
         txDJAM74Lrt/k2EO5QF6bV5rJ+4W8iTsg8klQ3X/OhXNc70LO4Gh6HAZa3bGmg6m2Y8w
         Jg+X3ZLyfPBzIjsKhBhq+7aBEUrvgHG+M8p6Isc5Iemb7NwEeQTGPEXVfUzym7n/iG9m
         IhIwV2pkuzSmBvw+qCPylZobS4WEAknovg0FbzDGZz9zN0ulYHFQ7hGpULS1ks6udFhD
         +yfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993544; x=1740598344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io3OySw226ibYgdV1c+iE1WuhM2fSihofj/VGBUO3M8=;
        b=VIBB0cMHT2x8wUVp+iJjOx/q7l5lQCKE4ewdRpa6u5Umpwbwr+mFJ4Hl7Kx+fdiMVM
         /mUz1iMg/dgOGQWN7BBzbBXe26a5ExuNHpNw70tSjRN1S3/ycXQUiN0OTCzuxZHG3ydJ
         7K2dcQNhFtBilwpN2KWFrdg5SViCZwTrO8/Pb+scrBZittBfubwv2qD1NsLarmroVMhA
         Hh9V24xQn/ZW+EThOfP8IRC1OrP1hB7FrzPj6DJC5hm1q65JHR51CRBVejDCxBgAamqM
         uk0k0CSvfaSLZ5TNaYgLDiEUXzI57ayJaeSMH115OSt0HiG1Pzg4Vf7CiXLp/LmMBWRl
         zjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVedKpHXQKaYT0Bbt79Qm9JmqlK0mj3Htw0JFv0nFp9xbw0RqvnFDfJ7gT0Pf6Nzf0xVL/Lx0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6W5r5k2d6zjhg5YaqKeGhXItHoA3ZQZhBoOxReeIj/9j4qBM
	duln/Jwgrdx5PAwwUi1To6rXHsMlzcJTV6nvkxNV5nv+V5HMQpbJ67Rq1wUXrPP/4SBhPVktPWY
	ZzUtOe+q/1qh6NND6v1/Q7719B8s=
X-Gm-Gg: ASbGncubVQ4/sbrJQWzIfOPHoUKm2/FmlE1mNz8V4k0rto92bPFedeYNtF3a2JYJdDk
	mPQb7DmJxOVBeTKwtMANs/Q3hCWb5oYhHA/Jd8vWx48ueFXPfIVqun6qilC+QPpHhDxaNteDXrw
	==
X-Google-Smtp-Source: AGHT+IGNvzMUu75Pmf3uB3BubWRx1mrHKqZtWbm8y6n++iOMGNXVAsCRXisPYYMTTX40RrWIGz9tsL4pxooP0B4hAa4=
X-Received: by 2002:a17:90b:224d:b0:2ee:ee5e:42fb with SMTP id
 98e67ed59e1d1-2fcb5a136fdmr7416263a91.13.1739993544436; Wed, 19 Feb 2025
 11:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6h+hfg4RcwuNUDspMrEt+5Gk5hBhE-pfLTF29M9qJLiYtoAQ@mail.gmail.com>
 <CAK-6q+j9QcZmJuJ+5igge8-Y2_1-JPuA6dvqkzJ5Lt+9=P=ndQ@mail.gmail.com>
In-Reply-To: <CAK-6q+j9QcZmJuJ+5igge8-Y2_1-JPuA6dvqkzJ5Lt+9=P=ndQ@mail.gmail.com>
From: Marc Smith <msmith626@gmail.com>
Date: Wed, 19 Feb 2025 14:32:09 -0500
X-Gm-Features: AWEUYZk7XfAVnzyauYeQYsyUb8PXtumn7BR1nDSaL_vb_AhAP5ZedoHy5XLnu7A
Message-ID: <CAH6h+hcvD_WRoaQryyRzZDAAEWaUML=yrsE-GtM74e5b2m90OA@mail.gmail.com>
Subject: Re: Linux 5.4.x DLM Regression
To: Alexander Aring <aahringo@redhat.com>
Cc: jakobkoschel@gmail.com, stable@vger.kernel.org, teigland@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:59=E2=80=AFAM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> Hi,
>
> On Mon, Feb 17, 2025 at 2:24=E2=80=AFPM Marc Smith <msmith626@gmail.com> =
wrote:
> >
> > Hi,
> >
> > I noticed there appears to be a regression in DLM (fs/dlm/) when
> > moving from Linux 5.4.229 to 5.4.288; I get a kernel panic when using
> > dlm_ls_lockx() (DLM user) with a timeout >0, and the panic occurs when
> > the timeout is reached (eg, attempting to take a lock on a resource
> > that is already locked); the host where the timeout occurs is the one
> > that panics:
> > ...
> > [  187.976007]
> >                DLM:  Assertion failed on line 1239 of file fs/dlm/lock.=
c
> >                DLM:  assertion:  "!lkb->lkb_status"
> >                DLM:  time =3D 4294853632
> > [  187.976009] lkb: nodeid 2 id 1 remid 2 exflags 40000 flags 800001
> > sts 1 rq 5 gr -1 wait_type 4 wait_nodeid 2 seq 0
> > [  187.976009]
> > [  187.976010] Kernel panic - not syncing: DLM:  Record message above
> > and reboot.
> > [  187.976099] CPU: 9 PID: 7409 Comm: dlm_scand Kdump: loaded Tainted:
> > P           OE     5.4.288-esos.prod #1
> > [  187.976195] Hardware name: Quantum H2012/H12SSW-NT, BIOS
> > T20201009143356 10/09/2020
> > [  187.976282] Call Trace:
> > [  187.976356]  dump_stack+0x50/0x63
> > [  187.976429]  panic+0x10c/0x2e3
> > [  187.976501]  kill_lkb+0x51/0x52
> > [  187.976570]  kref_put+0x16/0x2f
> > [  187.976638]  __put_lkb+0x2f/0x95
> > [  187.976707]  dlm_scan_timeout+0x18b/0x19c
> > [  187.976779]  ? dlm_uevent+0x19/0x19
> > [  187.976848]  dlm_scand+0x94/0xd1
> > [  187.976920]  kthread+0xe4/0xe9
> > [  187.976988]  ? kthread_flush_worker+0x70/0x70
> > [  187.977062]  ret_from_fork+0x35/0x40
> > ...
> >
> > I examined the commits for fs/dlm/ between 5.4.229 and 5.4.288 and
> > this is the offender:
> > dlm: replace usage of found with dedicated list iterator variable
> > [ Upstream commit dc1acd5c94699389a9ed023e94dd860c846ea1f6 ]
> >
> > Specifically, the change highlighted below in this hunk for
> > dlm_scan_timeout() in fs/dlm/lock.c:
> > @@ -1867,27 +1867,28 @@ void dlm_scan_timeout(struct dlm_ls *ls)
> >                 do_cancel =3D 0;
> >                 do_warn =3D 0;
> >                 mutex_lock(&ls->ls_timeout_mutex);
> > -               list_for_each_entry(lkb, &ls->ls_timeout, lkb_time_list=
) {
> > +               list_for_each_entry(iter, &ls->ls_timeout, lkb_time_lis=
t) {
> >
> >                         wait_us =3D ktime_to_us(ktime_sub(ktime_get(),
> > -                                                       lkb->lkb_timest=
amp));
> > +                                                       iter->lkb_times=
tamp));
> >
> > -                       if ((lkb->lkb_exflags & DLM_LKF_TIMEOUT) &&
> > -                           wait_us >=3D (lkb->lkb_timeout_cs * 10000))
> > +                       if ((iter->lkb_exflags & DLM_LKF_TIMEOUT) &&
> > +                           wait_us >=3D (iter->lkb_timeout_cs * 10000)=
)
> >                                 do_cancel =3D 1;
> >
> > -                       if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &=
&
> > +                       if ((iter->lkb_flags & DLM_IFL_WATCH_TIMEWARN) =
&&
> >                             wait_us >=3D dlm_config.ci_timewarn_cs * 10=
000)
> >                                 do_warn =3D 1;
> >
> >                         if (!do_cancel && !do_warn)
> >                                 continue;
> > -                       hold_lkb(lkb);
> > +                       hold_lkb(iter);
> > +                       lkb =3D iter;
> >                         break;
> >                 }
> >                 mutex_unlock(&ls->ls_timeout_mutex);
> >
> > -               if (!do_cancel && !do_warn)
> > +               if (!lkb)
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >                         break;
> >
> >                 r =3D lkb->lkb_resource;
> >
> > Reverting this single line change resolves the kernel panic:
> > $ diff -Naur fs/dlm/lock.c{.orig,}
> > --- fs/dlm/lock.c.orig  2024-12-19 12:05:05.000000000 -0500
> > +++ fs/dlm/lock.c       2025-02-16 21:21:42.544181390 -0500
> > @@ -1888,7 +1888,7 @@
> >                 }
> >                 mutex_unlock(&ls->ls_timeout_mutex);
> >
> > -               if (!lkb)
> > +               if (!do_cancel && !do_warn)
> >                         break;
> >
> >                 r =3D lkb->lkb_resource;
> >
> > It appears this same "dlm: replace usage of found with dedicated list
> > iterator variable" commit was pulled into other stable branches as
> > well, and I don't see any fix in the latest 5.4.x patch release
> > (5.4.290).
> >
>
> This works, or just init the lkb back to NULL there:
>
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index 1899bb266e2e..7e02e5b55965 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c
> @@ -1893,6 +1893,7 @@ void dlm_scan_timeout(struct dlm_ls *ls)
>                 if (dlm_locking_stopped(ls))
>                         break;
>
> +               lkb =3D NULL;
>                 do_cancel =3D 0;
>                 do_warn =3D 0;
>                 mutex_lock(&ls->ls_timeout_mutex);
>
> Can you provide more details about the use case of timeout? Are you
> using DLM in user space or kernel?

Yes, using dlm_ls_lockx() from DLM user space library in an
application; it's used to protect a shared resource with an exclusive
lock, so if another node attempts to take that lock and it times out
waiting, then we see the kernel panic.

--Marc


>
> - Alex
>

