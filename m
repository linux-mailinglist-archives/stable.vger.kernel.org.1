Return-Path: <stable+bounces-60796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7793A386
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 17:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C89F2844D5
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6C155351;
	Tue, 23 Jul 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0OfeBCH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113413B599
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747447; cv=none; b=TkIpVIW1XWAdSN3w1nCrk69yKlk9a6zvHDDZeUxvXihmIx9aiY8vfC5HovcXq7PCWPjFz/bKEhi/mZQtgmNqzVtj/N0a/2/rtCW5LA4BaoifBpsfdrml0MWqVDnyKLyKWk2Ntu9IYd7kJylrQSJph/eMMSEN0/RYHauTWtU6Crs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747447; c=relaxed/simple;
	bh=h9rdsExAYkah/9HXr0Bq4RhbbyHUq5e4cri8lqIqx+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yvz7ytw6ocdAdlqBi7tWkxKu1WR4jGvC8XHr4oig+d6am9yYCUl+PdDSVgBqyeET0cn+sdZ8qivLOVZboZiMmbujfGhzCh0pHJgNwGq+5zH3u/tvNM4IxMTP2q8mTiJJWki8gqVCf4HsNoG9+6Kq42F2veWPhusbJTuof+kbiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0OfeBCH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso18213a12.0
        for <stable@vger.kernel.org>; Tue, 23 Jul 2024 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721747444; x=1722352244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=141zF03RZVnD+aDB2CpBuT4/vbbNhplPjuAH2IdR4gY=;
        b=n0OfeBCHwVewK/pDPNQnjaCkwMJKTPAvRh6uX+sSWiKWL8uw+CYUFElWj7uNJuSyAz
         5P0pn9yPsyYaWqf4yP6Ry4cclXpUnAYTvMkVF4TMdd0XkT9G9a1ornyrKuhRHi1ElK4W
         JDnaSFZp2N9l7IxwAOm+xVjm0yA1V7gUyP8pqNqQ/uyv8Vo+D5PpdbXTmx4HZPMBQi7z
         rgcGCwEmMMj6pjc2DiLF4DqIEKkd8FPPfw63xdaAi9nqjxj65z3RbMLa1TrA2p+kAMHK
         kazHmUkwQEH8A6iryxEvkrbrKAaTchOu2ATVtqdqDfpq8NGve1/JRBMuRaR4ULVASotJ
         VNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721747444; x=1722352244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=141zF03RZVnD+aDB2CpBuT4/vbbNhplPjuAH2IdR4gY=;
        b=W60Ch/16QL3ruhjLxY6U0KJTsHr+nBtGQ0eWCzDG+yIGT6BteiXN/+lX6VEznEb2BS
         Vq69YqB9lW4aonDHDmFNgcpyiSvvzSB9f021J8t0pFGenMgrPMJLwk/ZLQPV5a7lfyXU
         fvuxHjkQinA+fmjijgBs0AKM/7DaQUHsF0KqDwRSbVQa5Vnh8xil8eXj0KCMT0XzkEsL
         P1e8L923hGB5koS5Tu48zv3JAFLiBCsJnKf7g04xK9LO6dICMlhvuB9dWF678g1xb01J
         yHJfN62Evq5qfkIUWMymFVTJmMUvI4MIEtj00hrdcW/WHDFXHD/iBVs92PKTOrfY1FRu
         qPjA==
X-Gm-Message-State: AOJu0Yz3mnrXvnG0+lwPfm8NOPNev9dU3AEFRw5AvKAEIHJe4R423tbp
	BjEcDkUKvqg3zqZlItpccqOYEstUMFPpCeG20W/9mHV2Jxae4qrT379/iSwDWUf0s1uirT4Oz0B
	omSjx1uhBLog7EQoAX3NIgOG8QLK7ZkWbb7yff/ZqFwbMwKB16ksqrcc=
X-Google-Smtp-Source: AGHT+IEZKzsYIufxwsx6xHXcvgT9CyGXpJPB748DbnlvBuXBZNz5E6e31JB2yVYHf/Gr3IUhTMWLUiNfNeaVy434ty8=
X-Received: by 2002:a05:6402:35d6:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5a4a8428366mr600632a12.1.1721747442879; Tue, 23 Jul 2024
 08:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722142250.155873-1-jannh@google.com> <2024072315-oppressor-traps-56a1@gregkh>
 <2024072353-deceptive-subsector-54fb@gregkh> <2024072328-delirious-wired-1720@gregkh>
 <CAG48ez0hRdmTjTO6+6qeEra89i_c3-2c_n84KeMV3=jdJv1thA@mail.gmail.com> <2024072310-anointer-unusable-fd67@gregkh>
In-Reply-To: <2024072310-anointer-unusable-fd67@gregkh>
From: Jann Horn <jannh@google.com>
Date: Tue, 23 Jul 2024 17:10:05 +0200
Message-ID: <CAG48ez2Qp48fe3912kuD1q97QWOV8o2bqgEY0dmaBPW1T4gs0Q@mail.gmail.com>
Subject: Re: [PATCH stable 4.19-6.6] filelock: Remove locks reliably when
 fcntl/close race is detected
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:52=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Tue, Jul 23, 2024 at 03:36:07PM +0200, Jann Horn wrote:
> > On Tue, Jul 23, 2024 at 3:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 03:00:28PM +0200, Greg KH wrote:
> > > > On Tue, Jul 23, 2024 at 02:56:08PM +0200, Greg KH wrote:
> > > > > On Mon, Jul 22, 2024 at 04:22:50PM +0200, Jann Horn wrote:
> > > > > > commit 3cad1bc010416c6dd780643476bc59ed742436b9 upstream.
> > > > > >
> > > > > > When fcntl_setlk() races with close(), it removes the created l=
ock with
> > > > > > do_lock_file_wait().
> > > > > > However, LSMs can allow the first do_lock_file_wait() that crea=
ted the lock
> > > > > > while denying the second do_lock_file_wait() that tries to remo=
ve the lock.
> > > > > > In theory (but AFAIK not in practice), posix_lock_file() could =
also fail to
> > > > > > remove a lock due to GFP_KERNEL allocation failure (when splitt=
ing a range
> > > > > > in the middle).
> > > > > >
> > > > > > After the bug has been triggered, use-after-free reads will occ=
ur in
> > > > > > lock_get_status() when userspace reads /proc/locks. This can li=
kely be used
> > > > > > to read arbitrary kernel memory, but can't corrupt kernel memor=
y.
> > > > > > This only affects systems with SELinux / Smack / AppArmor / BPF=
-LSM in
> > > > > > enforcing mode and only works from some security contexts.
> > > > > >
> > > > > > Fix it by calling locks_remove_posix() instead, which is design=
ed to
> > > > > > reliably get rid of POSIX locks associated with the given file =
and
> > > > > > files_struct and is also used by filp_flush().
> > > > > >
> > > > > > Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
> > > > > > Cc: stable@kernel.org
> > > > > > Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=
=3D2563
> > > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > > Link: https://lore.kernel.org/r/20240702-fs-lock-recover-2-v1-1=
-edd456f63789@google.com
> > > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > [stable fixup: ->c.flc_type was ->fl_type in older kernels]
> > > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > > ---
> > > > > >  fs/locks.c | 9 ++++-----
> > > > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/locks.c b/fs/locks.c
> > > > > > index fb717dae9029..31659a2d9862 100644
> > > > > > --- a/fs/locks.c
> > > > > > +++ b/fs/locks.c
> > > > > > @@ -2381,8 +2381,9 @@ int fcntl_setlk(unsigned int fd, struct f=
ile *filp, unsigned int cmd,
> > > > > >   error =3D do_lock_file_wait(filp, cmd, file_lock);
> > > > > >
> > > > > >   /*
> > > > > > -  * Attempt to detect a close/fcntl race and recover by releas=
ing the
> > > > > > -  * lock that was just acquired. There is no need to do that w=
hen we're
> > > > > > +  * Detect close/fcntl races and recover by zapping all POSIX =
locks
> > > > > > +  * associated with this file and our files_struct, just like =
on
> > > > > > +  * filp_flush(). There is no need to do that when we're
> > > > > >    * unlocking though, or for OFD locks.
> > > > > >    */
> > > > > >   if (!error && file_lock->fl_type !=3D F_UNLCK &&
> > > > > > @@ -2397,9 +2398,7 @@ int fcntl_setlk(unsigned int fd, struct f=
ile *filp, unsigned int cmd,
> > > > > >           f =3D files_lookup_fd_locked(files, fd);
> > > > > >           spin_unlock(&files->file_lock);
> > > > > >           if (f !=3D filp) {
> > > > > > -                 file_lock->fl_type =3D F_UNLCK;
> > > > > > -                 error =3D do_lock_file_wait(filp, cmd, file_l=
ock);
> > > > > > -                 WARN_ON_ONCE(error);
> > > > > > +                 locks_remove_posix(filp, files);
> > > > >
> > > > > Wait, this breaks the build on 5.4.y with the error:
> > > > >
> > > > > fs/locks.c: In function =E2=80=98fcntl_setlk=E2=80=99:
> > > > > fs/locks.c:2545:50: error: =E2=80=98files=E2=80=99 undeclared (fi=
rst use in this function); did you mean =E2=80=98file=E2=80=99?
> > > > >  2545 |                         locks_remove_posix(filp, files);
> > > > >       |                                                  ^~~~~
> > > > >       |                                                  file
> > > > >
> > > > > I didn't do test-builds yesterday, my fault for not noticing this=
 yet.
> > > > >
> > > > > I've dropped this from the 5.4.y queues for now, can you fix this=
 up and send
> > > > > an updated version, or give me a hint as to what to do instead?  =
Odd that this
> > > > > works on 4.19.y, let me see why...
> > > >
> > > > Ah, I see why, it applied to the wrong function in 4.19 and that di=
dn't
> > > > get built on my test systems (i.e. 64bit only.)  And I see how to f=
ix
> > > > this up, let me go do that now, sorry for the noise.
> > >
> > > And it's fixed now on 5.4.y as well, I just reference current->files =
and
> > > all is good.
> >
> > Uuuugh, but actually as you mentioned the buggy code is duplicated
> > (which was why you had that build success for 4.19). Even in mainline
> > there are two versions and I missed the one for 64-bit offsets on
> > 32-bit systems.
> >
> > So I guess I gotta go back and send another patch to mainline for the
> > second path, and then get that through stable too... bleh.
>
> Hey, the stable review process found a bug in mainline, that's a good
> thing!  :)

Yeah, I'm just a bit mad at myself-from-three-weeks-ago for not
noticing this, I know I must have seen that compat code several
times...

I've sent a patch to the VFS folks now for fixing the compat path in
mainline, with CC stable.

> If you need help backporting, I'm glad to do so.

Thanks for the help!

>
> thanks,
>
> greg k-h

