Return-Path: <stable+bounces-148104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3669EAC80C4
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C9F4A62A3
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2FA22D790;
	Thu, 29 May 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E855mhUF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247C22B8D2
	for <stable@vger.kernel.org>; Thu, 29 May 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535450; cv=none; b=KQjKEOqf5wLtuNTjtSs+4Wg8Ku7q/cNXWqAAYnoKVKuq93qmbrWNFLDT4nRkeHuNcP5w7omqFk5VLBS+He/x2UK6g6cbs6LR8HkZK90K3wCm7RbZIoHKhdv+bp0HtbEr33KqDQcH+Re+LT2BjxoExYeI6eMNO6y4CEbecZ/gALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535450; c=relaxed/simple;
	bh=FY8UJr/g+f5NMmL3wgjX3wt97XPE5ermVVXqzKDxh8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1cnIzQCQg+0o3/eyPRqNTrCoRGFaSDdvjD6cYXIeBR+ecl6tBuQ+wcGK7t9UERcWmEdDB5xe9atGQPnYKCug3hkf5CmUPDURshz72FuBkBKFZmo1Yk1LHhL1YDaqO2gAN69lgX7F7qetr+iTArnB6h7WTx9gfZ84iDES6o4nYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E855mhUF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32a7a12955eso4865641fa.3
        for <stable@vger.kernel.org>; Thu, 29 May 2025 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748535446; x=1749140246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jgJKTXVnj6f8YCLQX9p0jhEG5ZRzucQkXQ/lqtbPwI=;
        b=E855mhUFIKfWSHiloB5Y7nU7zLaqsQ8LhxZaseB+lNJqx4CqdLs9UvkUgBcRtkaRMP
         Zy/xV4O2wuJ8WScw5L7CCVZc+/q8FsBJ2+HlnArIatvOnyhKdE5FdhDqOikZptrZFFci
         xq7guXpGPVmYal494gvHrdrJgRv5VQihcoiyM8xGxZX5TDydF3/vX2Ru5O85zGhnKvmq
         DceHGJNMRPhBWo4in/CsIb5k1c7NmNeu/t2xTB0r4PiTOtN5UJpjEg+Dq0dtKRRYBsE4
         GE/UZxY6jrEkDq9p3j4MTpfiy+PPhRiSYSQJ5N8DiqCK/6HLnd5Bjt0QzdJ0RDLgGwQM
         avRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748535446; x=1749140246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jgJKTXVnj6f8YCLQX9p0jhEG5ZRzucQkXQ/lqtbPwI=;
        b=H8uNU/TxSMl5J3OgqU+qB08ib/NKnt6/iuH8ua8Ad4r1206D42IU7hNhhojFAoQGyH
         +azOvJ7/Hw8p7i/ywlpwZmrJFfA+7xjUmlUztrRQBXEDgSE7wXbB+FH2ex5qPtCQY6ye
         LbisDZzY8BArdqqHfKBmkOOEntb5b98LmkdTYGEiMw+AsbjXWDW7hp4WlNe2vWPseyUT
         LmISZ8P+GjEKvVkW0OXvLwPwbzCJ48pfGxe76BprHAmN4y+jop9RrreA1dantV9x0cp/
         L8AI5aNulGfGigGXsD1hcoqS4CE2kz10dtS3ZLp/GqilgGJGfmf8BmJwIEwtyxIVV17Q
         yU/g==
X-Gm-Message-State: AOJu0YzMu/z42LmqfngdfeafxKnbvMnV0ngkbnuFNgS8wVZhaxfxfNDu
	YTtddUK4yPcoWDkzh0dkf8Ok1cyL7CYxRSE1OTu2OU6Gwr5RO/GAPb2vp1zkIUOBNoiQkvhikHX
	5/eGiczlaV+Y9eR1J046GFCwQxtlQr3geaC8=
X-Gm-Gg: ASbGncufBJA8G3Y4atO/6Nv8plIhi15xqqz9fHZj38MjIU9lnl4Lm95OE21KGdeOFa0
	Vn14Nnb7b08MvjFix60ylW+trYEBXovzEKcJGYN4JtfzoesGeMbxEZSH6zKEkASXkuN4dfjQd/c
	R1VZ/I9+KpMV3HhHd1MBhDwJXxXeGbUe3GwOcAYTPjdn+XyHQ=
X-Google-Smtp-Source: AGHT+IEymqDwVw9xb6SnmJx+Z0cvqa6rUfL1KnraMAqKFT9Y938Sfu2Ihk2ACz/8Bhs5ueNFlxh7/9XoAvhSlH+rqSw=
X-Received: by 2002:a05:651c:1549:b0:32a:6c63:935 with SMTP id
 38308e7fff4ca-32a8cd295d5mr1661941fa.4.1748535446050; Thu, 29 May 2025
 09:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527162513.035720581@linuxfoundation.org> <20250527162530.470565771@linuxfoundation.org>
 <CAMzpN2hwSXUybfvcas2X5213V=Ow+nqGqqurC_tjfCdb44aFfg@mail.gmail.com> <2025052945-squabble-romp-6304@gregkh>
In-Reply-To: <2025052945-squabble-romp-6304@gregkh>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 29 May 2025 12:17:14 -0400
X-Gm-Features: AX0GCFt3X3ZfQfNuUHPxH832YhIHcNZGBocfQfbrKm3jTaQuo5E4XRm35NDAYrw
Message-ID: <CAMzpN2inYN7uXgdfDXwDPWRp0WnEYkOew1Ys=bPPperrwCz5uw@mail.gmail.com>
Subject: Re: [PATCH 6.14 426/783] x86/boot: Disable stack protector for early
 boot code
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 2:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 28, 2025 at 01:52:16PM -0400, Brian Gerst wrote:
> > On Tue, May 27, 2025 at 1:39=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 6.14-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Brian Gerst <brgerst@gmail.com>
> > >
> > > [ Upstream commit a9a76b38aaf577887103e3ebb41d70e6aa5a4b19 ]
> > >
> > > On 64-bit, this will prevent crashes when the canary access is change=
d
> > > from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses f=
rom
> > > the identity-mapped early boot code will target the wrong address wit=
h
> > > zero-based percpu.  KASLR could then shift that address to an unmappe=
d
> > > page causing a crash on boot.
> > >
> > > This early boot code runs well before user-space is active and does n=
ot
> > > need stack protector enabled.
> > >
> > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Link: https://lore.kernel.org/r/20250123190747.745588-4-brgerst@gmail=
.com
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  arch/x86/kernel/Makefile | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > > index b43eb7e384eba..84cfa179802c3 100644
> > > --- a/arch/x86/kernel/Makefile
> > > +++ b/arch/x86/kernel/Makefile
> > > @@ -44,6 +44,8 @@ KCOV_INSTRUMENT_unwind_orc.o                       =
   :=3D n
> > >  KCOV_INSTRUMENT_unwind_frame.o                         :=3D n
> > >  KCOV_INSTRUMENT_unwind_guess.o                         :=3D n
> > >
> > > +CFLAGS_head32.o :=3D -fno-stack-protector
> > > +CFLAGS_head64.o :=3D -fno-stack-protector
> > >  CFLAGS_irq.o :=3D -I $(src)/../include/asm/trace
> > >
> > >  obj-y                  +=3D head_$(BITS).o
> > > --
> > > 2.39.5
> > >
> > >
> > >
> >
> > This doesn't need to be backported.  It's harmless, but not necessary
> > without the rest of the stack protector changes.
>
> What specific changes?  I see stackprotector code in this, and the 6.12
> tree, so what commit id does this "fix"?

Here is the whole patch series:
https://lore.kernel.org/lkml/20250123190747.745588-1-brgerst@gmail.com/

This patch is a prerequisite for patch #8 (Use relative percpu
offsets).  It does not fix an existing problem.


Brian Gerst

