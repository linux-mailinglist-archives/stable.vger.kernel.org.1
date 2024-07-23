Return-Path: <stable+bounces-60786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FC93A1A6
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3218C1F2291C
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA51534E7;
	Tue, 23 Jul 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfMMQdWj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B9152E15
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741811; cv=none; b=VF8Biub27ZCPzotVuLydpAmebZ7KBnFgbVKY+so7GORSUP1pVAc9iiNH/eBGb5kZVuc6OMc9uVkVhWGPNFe9ZW13+QlZro7gON0kbenVQBA0COh/txnTDnHKwKo2NrdJq93pUXW3/YEDfPYDYe8Wd7kur6BogFLmxOfQ5btaCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741811; c=relaxed/simple;
	bh=x222k2RZvrt4Nqn4Lvd9nMlX7TppO8TBMlNy+aBJ8Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By5oXHouWALWdcnaDs0rMSIMKSC9FLQPFxngHd+j6U1LUtPRLJaSaP6pzSxvNukcJCCVE6KQ5Tpjo69+FRy3ZmYoVZtNpUOCz7a0Gmzdwl8EbVlS+IGjrUpO4eG11VWAbbJqWnVHNSpkun8j7dXkVWnY+LUO5M2lyBb4ZACLl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfMMQdWj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso16514a12.0
        for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721741808; x=1722346608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBu8PlGIgkV+w30O66G0mDLkm7MrnhBRHH/sUI7ZTXo=;
        b=QfMMQdWjn5AzfNvjIQQG+SyWahCo4mwtG+tq/gYQwNpPng9ChoUUGV70T6a2eJAgmN
         WlQv1uYMOwYQR1xLRNbwkYqaKWN/H2dsVE+CtFu2iIlYoySFawjH9l5eEbr3kgE0rT1g
         NPpyke/kjTn+2lwUyv7D18d17jmFpyOKixxcN0TGZyMTcVZpEJb4ka8vpqMV0Vx8Gnrz
         A72W/M18R2e23PNUKirgE52yi9UVhJV68BXuLddv4nRP8Y4Q1OP0RF2fxm4LIAp4RHMD
         udqEYvqsx01yE3TzGyYGukpQrY+htQ3H+OPgMzcmVs+jqHzEXDvo29FEHmqmlba/nCAe
         zMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741808; x=1722346608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBu8PlGIgkV+w30O66G0mDLkm7MrnhBRHH/sUI7ZTXo=;
        b=IuU3DEjxffoba3ffQEBlxFOGRcmbm8zGJXo0YEd1C3CN3E+UksPspJcymNQCX7C+qi
         UxW4KxQWyOOuYom7rffHGOezk2K0/vwfAzH6dhrWtVEPbXMRusfqQDCDwKDqK6CCrVX1
         QbWu0zGmkSj1uTFGc3+gNdaKwIMbxbOTm9F+jSW+8kYbVwBsJRsZNR14ho3chYTXxddy
         DHCQic5I5ihR8xVJfZllGsAVbRA8F0xagLU7xdMBcxNzeAGPhXD4UNkWcK0ncWSZ4zpb
         LEs0SqIBmY14jlAM/OwUgpBsvw71kHNR/+IhIp7vjvSJTLRzmzMUU0XTzgsb+QFOY97z
         Qm7A==
X-Gm-Message-State: AOJu0YyCH9WsvUR2uz8CyWYVa3qJCJ6sYOQ0f285oxdb1EcO5ULvDPaS
	JKmBLZQFOIjusgvd/4yThXDJVdwJGn70aW2V/IMAbd8naN72PKU0pKilEE/RW6Um/bTjbV/ibO6
	KZe6NhZRAepUVdwomvQfhYP6qaU71yEJVi7Wur+skfaSwkQo/l77O1KY=
X-Google-Smtp-Source: AGHT+IG+hs7od8X4yPyMRH0Kr5dqJKkzW/zoaniqWUokO8xuSD/m4tc5KP02VFiy1M+ppgYRitF1UuGJCSja+gEwn54=
X-Received: by 2002:a05:6402:27c6:b0:5a1:4658:cb98 with SMTP id
 4fb4d7f45d1cf-5a44fe634f7mr563055a12.0.1721741806031; Tue, 23 Jul 2024
 06:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722142250.155873-1-jannh@google.com> <2024072315-oppressor-traps-56a1@gregkh>
 <2024072353-deceptive-subsector-54fb@gregkh> <2024072328-delirious-wired-1720@gregkh>
In-Reply-To: <2024072328-delirious-wired-1720@gregkh>
From: Jann Horn <jannh@google.com>
Date: Tue, 23 Jul 2024 15:36:07 +0200
Message-ID: <CAG48ez0hRdmTjTO6+6qeEra89i_c3-2c_n84KeMV3=jdJv1thA@mail.gmail.com>
Subject: Re: [PATCH stable 4.19-6.6] filelock: Remove locks reliably when
 fcntl/close race is detected
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jul 23, 2024 at 03:00:28PM +0200, Greg KH wrote:
> > On Tue, Jul 23, 2024 at 02:56:08PM +0200, Greg KH wrote:
> > > On Mon, Jul 22, 2024 at 04:22:50PM +0200, Jann Horn wrote:
> > > > commit 3cad1bc010416c6dd780643476bc59ed742436b9 upstream.
> > > >
> > > > When fcntl_setlk() races with close(), it removes the created lock =
with
> > > > do_lock_file_wait().
> > > > However, LSMs can allow the first do_lock_file_wait() that created =
the lock
> > > > while denying the second do_lock_file_wait() that tries to remove t=
he lock.
> > > > In theory (but AFAIK not in practice), posix_lock_file() could also=
 fail to
> > > > remove a lock due to GFP_KERNEL allocation failure (when splitting =
a range
> > > > in the middle).
> > > >
> > > > After the bug has been triggered, use-after-free reads will occur i=
n
> > > > lock_get_status() when userspace reads /proc/locks. This can likely=
 be used
> > > > to read arbitrary kernel memory, but can't corrupt kernel memory.
> > > > This only affects systems with SELinux / Smack / AppArmor / BPF-LSM=
 in
> > > > enforcing mode and only works from some security contexts.
> > > >
> > > > Fix it by calling locks_remove_posix() instead, which is designed t=
o
> > > > reliably get rid of POSIX locks associated with the given file and
> > > > files_struct and is also used by filp_flush().
> > > >
> > > > Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
> > > > Cc: stable@kernel.org
> > > > Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=3D2=
563
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > Link: https://lore.kernel.org/r/20240702-fs-lock-recover-2-v1-1-edd=
456f63789@google.com
> > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > [stable fixup: ->c.flc_type was ->fl_type in older kernels]
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > ---
> > > >  fs/locks.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/fs/locks.c b/fs/locks.c
> > > > index fb717dae9029..31659a2d9862 100644
> > > > --- a/fs/locks.c
> > > > +++ b/fs/locks.c
> > > > @@ -2381,8 +2381,9 @@ int fcntl_setlk(unsigned int fd, struct file =
*filp, unsigned int cmd,
> > > >   error =3D do_lock_file_wait(filp, cmd, file_lock);
> > > >
> > > >   /*
> > > > -  * Attempt to detect a close/fcntl race and recover by releasing =
the
> > > > -  * lock that was just acquired. There is no need to do that when =
we're
> > > > +  * Detect close/fcntl races and recover by zapping all POSIX lock=
s
> > > > +  * associated with this file and our files_struct, just like on
> > > > +  * filp_flush(). There is no need to do that when we're
> > > >    * unlocking though, or for OFD locks.
> > > >    */
> > > >   if (!error && file_lock->fl_type !=3D F_UNLCK &&
> > > > @@ -2397,9 +2398,7 @@ int fcntl_setlk(unsigned int fd, struct file =
*filp, unsigned int cmd,
> > > >           f =3D files_lookup_fd_locked(files, fd);
> > > >           spin_unlock(&files->file_lock);
> > > >           if (f !=3D filp) {
> > > > -                 file_lock->fl_type =3D F_UNLCK;
> > > > -                 error =3D do_lock_file_wait(filp, cmd, file_lock)=
;
> > > > -                 WARN_ON_ONCE(error);
> > > > +                 locks_remove_posix(filp, files);
> > >
> > > Wait, this breaks the build on 5.4.y with the error:
> > >
> > > fs/locks.c: In function =E2=80=98fcntl_setlk=E2=80=99:
> > > fs/locks.c:2545:50: error: =E2=80=98files=E2=80=99 undeclared (first =
use in this function); did you mean =E2=80=98file=E2=80=99?
> > >  2545 |                         locks_remove_posix(filp, files);
> > >       |                                                  ^~~~~
> > >       |                                                  file
> > >
> > > I didn't do test-builds yesterday, my fault for not noticing this yet=
.
> > >
> > > I've dropped this from the 5.4.y queues for now, can you fix this up =
and send
> > > an updated version, or give me a hint as to what to do instead?  Odd =
that this
> > > works on 4.19.y, let me see why...
> >
> > Ah, I see why, it applied to the wrong function in 4.19 and that didn't
> > get built on my test systems (i.e. 64bit only.)  And I see how to fix
> > this up, let me go do that now, sorry for the noise.
>
> And it's fixed now on 5.4.y as well, I just reference current->files and
> all is good.

Uuuugh, but actually as you mentioned the buggy code is duplicated
(which was why you had that build success for 4.19). Even in mainline
there are two versions and I missed the one for 64-bit offsets on
32-bit systems.

So I guess I gotta go back and send another patch to mainline for the
second path, and then get that through stable too... bleh.

