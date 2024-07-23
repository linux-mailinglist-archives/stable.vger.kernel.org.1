Return-Path: <stable+bounces-60771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A32A93A0A9
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 14:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7571C22163
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859001514F3;
	Tue, 23 Jul 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLjxgBag"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66A26AD3
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739499; cv=none; b=WyFtTBMyawLFHCpMpaT53LJ80lT57jpB+UC5ygOwU0zxGIvW+AMObPhJgkqNuQATagO4jZvgox0pbLeYC0uxNqAORT2HUPosyNCyeX0KByxP8YbmHF6hBJkjbElmqSzDHP+noyhlieoiu95Y5Fl2e5oJQ7iiy0xGPKoDBnmq8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739499; c=relaxed/simple;
	bh=BW2vqIeRBd05X0VEaepK6CaI95O18zS42XL2aKMmtGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN3lCvzYGWDYag70SnryJvFcyrboRHQhyclMM+pYdc87WkVu5PRB4PeO6bNUMAPM6+kk9Z/akT6ZczqY7YwESs9p0S33lfKtLOntXbdqmVQ1gP1rReDSYWoZXAvKtOskM9Oyi+72zz5PQfxPKL223PbMjPMouilzeOMPPKb3weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLjxgBag; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso17286a12.0
        for <stable@vger.kernel.org>; Tue, 23 Jul 2024 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721739496; x=1722344296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VdQdc9fmkH4grO+yqqe9Pd1UmSdbquRyEXuUNWQpak=;
        b=cLjxgBagN9Tqk9NZZH6ipt8NPyDsUwpB7U6lwEsd/ZxRPICP5mVNhd4rKdFswwNllP
         1rd/OgOWYGdrxZyMczOXOPPlVZns/8H0PkMxod4T46ZfmrI/oWkirjq08JrtW09yGJgD
         LLU2Shtd8HDoEPNCs5yreQxObyaHIKASDSFD+sdaRp6RO5uKFD6cpo37jaPLFHxOulXS
         tt4x3eewVpSCLdvXGXObLTT27x7tnG5y7HDbZDQcFSzIG2Y9ydd+ndyfUGVv650MYGLc
         QVClH1hHlYuqUBv9iDNTEJkW/mvBNZr7XzWK2QWE+fisooVYDWHQFEVxpXS2w7o7/GF4
         zacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721739496; x=1722344296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VdQdc9fmkH4grO+yqqe9Pd1UmSdbquRyEXuUNWQpak=;
        b=Bl1ddyIg0iru0RMYdfX8jtVEyPqdgI5I8XsNVA0cem1TStIww7CJcI+zNPdl+vZSwX
         DHmK0tV7Ce17//8Q/dVugV4vsiDIiumyy/GkNoCp9TSAEsS3L7I3TgDyutGIPVkrfaUj
         SbILydh1bQwb7KhaMtLXA5eYOThkno/htE4b7JCicYxW/81dgChjC1yqKsGJ2icDJgPn
         jfkI8b0AmqM0znv5inktnaHfi8jlzucp/PaLag1Y+oSaCdQPdxzXeNgW+TIx7Ko/i0E3
         bMZY8comFbnXtp0Odc5ogW1f35jnux2PCyuCJGyAdDcrEWwX+GfAjsvHy3K6T7TWncWT
         aOaQ==
X-Gm-Message-State: AOJu0YyzIrW++JDOERNvrFe293AUlfyGug/nEc1KZ9sZ6clziQXdQk13
	/pFuJCY/yvVymF9RhN7cLvwYxOCKR1kzorLlQGENuAfPf3gzk/NkMeaAI+1xhHpADeN0IAvgNFg
	ZVLIzbjk5qm0/i5eCyUz1K73SRJ7LK/G5sI+3
X-Google-Smtp-Source: AGHT+IECLA4pxcVv4tisY6u4aleGXMCda+H2SAjkjGVcoS87oBNwbEiKxI5JvL8XT6PaYcQncztOwSaCTPEzKnYf4TI=
X-Received: by 2002:a05:6402:34d6:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5a4a9300bddmr543790a12.7.1721739491945; Tue, 23 Jul 2024
 05:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722142250.155873-1-jannh@google.com> <2024072315-oppressor-traps-56a1@gregkh>
In-Reply-To: <2024072315-oppressor-traps-56a1@gregkh>
From: Jann Horn <jannh@google.com>
Date: Tue, 23 Jul 2024 14:57:34 +0200
Message-ID: <CAG48ez3f0UVAfYud8jcO9KckjB9Ng+BCZ3BnOwKxore7PQW+WQ@mail.gmail.com>
Subject: Re: [PATCH stable 4.19-6.6] filelock: Remove locks reliably when
 fcntl/close race is detected
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 2:56=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Mon, Jul 22, 2024 at 04:22:50PM +0200, Jann Horn wrote:
> > commit 3cad1bc010416c6dd780643476bc59ed742436b9 upstream.
> >
> > When fcntl_setlk() races with close(), it removes the created lock with
> > do_lock_file_wait().
> > However, LSMs can allow the first do_lock_file_wait() that created the =
lock
> > while denying the second do_lock_file_wait() that tries to remove the l=
ock.
> > In theory (but AFAIK not in practice), posix_lock_file() could also fai=
l to
> > remove a lock due to GFP_KERNEL allocation failure (when splitting a ra=
nge
> > in the middle).
> >
> > After the bug has been triggered, use-after-free reads will occur in
> > lock_get_status() when userspace reads /proc/locks. This can likely be =
used
> > to read arbitrary kernel memory, but can't corrupt kernel memory.
> > This only affects systems with SELinux / Smack / AppArmor / BPF-LSM in
> > enforcing mode and only works from some security contexts.
> >
> > Fix it by calling locks_remove_posix() instead, which is designed to
> > reliably get rid of POSIX locks associated with the given file and
> > files_struct and is also used by filp_flush().
> >
> > Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
> > Cc: stable@kernel.org
> > Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=3D2563
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Link: https://lore.kernel.org/r/20240702-fs-lock-recover-2-v1-1-edd456f=
63789@google.com
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > [stable fixup: ->c.flc_type was ->fl_type in older kernels]
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  fs/locks.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/locks.c b/fs/locks.c
> > index fb717dae9029..31659a2d9862 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2381,8 +2381,9 @@ int fcntl_setlk(unsigned int fd, struct file *fil=
p, unsigned int cmd,
> >       error =3D do_lock_file_wait(filp, cmd, file_lock);
> >
> >       /*
> > -      * Attempt to detect a close/fcntl race and recover by releasing =
the
> > -      * lock that was just acquired. There is no need to do that when =
we're
> > +      * Detect close/fcntl races and recover by zapping all POSIX lock=
s
> > +      * associated with this file and our files_struct, just like on
> > +      * filp_flush(). There is no need to do that when we're
> >        * unlocking though, or for OFD locks.
> >        */
> >       if (!error && file_lock->fl_type !=3D F_UNLCK &&
> > @@ -2397,9 +2398,7 @@ int fcntl_setlk(unsigned int fd, struct file *fil=
p, unsigned int cmd,
> >               f =3D files_lookup_fd_locked(files, fd);
> >               spin_unlock(&files->file_lock);
> >               if (f !=3D filp) {
> > -                     file_lock->fl_type =3D F_UNLCK;
> > -                     error =3D do_lock_file_wait(filp, cmd, file_lock)=
;
> > -                     WARN_ON_ONCE(error);
> > +                     locks_remove_posix(filp, files);
>
> Wait, this breaks the build on 5.4.y with the error:
>
> fs/locks.c: In function =E2=80=98fcntl_setlk=E2=80=99:
> fs/locks.c:2545:50: error: =E2=80=98files=E2=80=99 undeclared (first use =
in this function); did you mean =E2=80=98file=E2=80=99?
>  2545 |                         locks_remove_posix(filp, files);
>       |                                                  ^~~~~
>       |                                                  file
>
> I didn't do test-builds yesterday, my fault for not noticing this yet.

Ugh, sorry, I think maybe I only test-built on 6.6...

> I've dropped this from the 5.4.y queues for now, can you fix this up and =
send
> an updated version, or give me a hint as to what to do instead?

Yeah, I'll have a look.

> Odd that this
> works on 4.19.y, let me see why...

