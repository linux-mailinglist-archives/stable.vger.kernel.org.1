Return-Path: <stable+bounces-110201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DAA19641
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A621889581
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6D7214A7C;
	Wed, 22 Jan 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDFO1120"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D447211475
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562488; cv=none; b=qYYKCi8X74tyv6TOd6ubs0Q5xKU3lsmDwHGtGkuyayvBkL/R4ydHYJyVB1KDgUaUginMoExvuE1kzA5CdslnLNYCV0FYlx2YGxyE2vO9urg9XO26/IVJbvKVSWgqiCFev3apzE/XPaLYTgwt7Z4/rpmKE8ZHD4ZG5V4jBU8eRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562488; c=relaxed/simple;
	bh=L90sZMVSRI61zDd+r0xCrvsVnNL+fFVXJgWGwi3VFZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIZEDZZXvt6syFdUHEAWyfoYNQL+7PPb60lfbSjJQLL/f9DWPZqYffceUK/J4rt74lRrNt+zgPBI3e/beh6k46+gD0lXmDFUZ4WBeUABXzXOg8NSUUOtFGXQ5mADYRxAivE4uJ/JzhC45JccK9MQTXDxMdEFjy6imexFMi9VZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDFO1120; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85c5adbca8eso1570698241.0
        for <stable@vger.kernel.org>; Wed, 22 Jan 2025 08:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737562485; x=1738167285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L90sZMVSRI61zDd+r0xCrvsVnNL+fFVXJgWGwi3VFZs=;
        b=gDFO1120mJ15MiGhKtxZMgtmaj/HPR5QBAjTf3A6ZjmT43E7D9wMl1iZOVIIN7p+Iz
         eNZP7DYFlZIudqBT0zx6m59bdzQy/HfrKIGmLtCVRyCWldc2UcrLNuuW4WmgJBfwfh6n
         f2HS+DkdgpQqOyjVfa2nma/UrQsig638w2/+Oq2mr3GCKl4M6NsuUOsUDiFZ/97pbZqr
         08gtfI13U2cHBwu8vtnLqFE74ikuP6pQF7mWlKo8rKl6kUFHZCQ7as4Y15o7qV3/lSKR
         v1GXkXjuGUCUcUSaNyNKpIHRIRUhhq24Gs3/12hWvm29ENIf+v/UnAmyp/XtfVhOQaj7
         P0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737562485; x=1738167285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L90sZMVSRI61zDd+r0xCrvsVnNL+fFVXJgWGwi3VFZs=;
        b=a9eNjfjdW7Gg4SJ0p13xjEMHNkBlU7EUhrL5h55ZXSAOabrDgzQYg49kNkAkvKlrq4
         439sHV7eVTFJflfQxGxqhb0F7ePTS/HNwEj4TZ1Wge2qDEj4tK57HcUdahnxU5hEr61l
         SzU35fWUoYSD6RzfuOp2pDWYPhP7Xf0s0B23O9wCAxXVqsRdJlXcS0JYo1gpU/1LLzCn
         8kS1/dzUSst2sonzcmpNjj7WlX63C0/w0gILXxYNmRtHbzZ8kRJD0yuLP3Wn4islkCex
         oxuYitJkawJ4jJprIHoAoqGYls9dDmFLoA0x5IcrMYp6Gh0M18mW1etPxHZN0OjkJhQF
         3lDw==
X-Forwarded-Encrypted: i=1; AJvYcCVxHJ9+d7BY7zGzVdM2b710vIbR/oYTqBZwaPkEk9V6puNmwXEB+Yd8I3GlcdQaxFuoAYdoHxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZm98ZpeNI4GE8yIHrT990svo0JoBUAfAbj///IYoEsTj2XhPM
	QeZRQWKmq8oVNiTZn2KQbdZjQ0k+oAmBvJrCCWG1WB6XiJAQd3itIEFpAP2qc+BGTSD2PlSic7b
	TveS9QUFg0mKZvDOli2CMRsuIutQ=
X-Gm-Gg: ASbGncv4Zd1RDun4KlCbi9dSTzePjesSkIVloEU/EvCyIoaNukNAtAE8tjreXm6oddr
	4DMboJ9jlL+aEBWA5tcNy9114Zv8NOIzP9dQbVFpFmEMwJrlw0A==
X-Google-Smtp-Source: AGHT+IH9Ho83lBV6TMHgYgljDAwNsqtklElSNEk9D5aJEBsAKrdJ/QgR1X1viYVpeLp+Sc9VJAf6nhfXBEx1VpGYIzY=
X-Received: by 2002:a05:6122:3704:b0:50a:b604:2bb2 with SMTP id
 71dfb90a1353d-51d5b39b8a2mr18644132e0c.11.1737562485302; Wed, 22 Jan 2025
 08:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACW2H-7QEMKA+LUAzFJ+srmRCzSuLk2G7shWt0SGR9SfmxwOjA@mail.gmail.com>
 <CAGxU2F4_59X-Fj7vRCoDqM394699uxqLQZ5yCuH+jXUYcYO81g@mail.gmail.com>
 <CAGxU2F40eWaLxS8tsQaFeQ_ndjwdQXMj7VghH3VidcbkcVPrgw@mail.gmail.com>
 <CACW2H-4UivUO+aVt-Bb7GGwxLWite7hKSBzJ5WhSXyvWCkh8bg@mail.gmail.com>
 <CAGxU2F57EgVGbPifRuCvrUVjx06mrOXNdLcPdqhV9bdM0VqGvg@mail.gmail.com> <CAGxU2F4F2jETc9+NFi=9xNkthAbRDOKCVa4-UeOpyfzHjtLdeg@mail.gmail.com>
In-Reply-To: <CAGxU2F4F2jETc9+NFi=9xNkthAbRDOKCVa4-UeOpyfzHjtLdeg@mail.gmail.com>
From: Simon Kaegi <simon.kaegi@gmail.com>
Date: Wed, 22 Jan 2025 11:14:34 -0500
X-Gm-Features: AWEUYZmZcU1GmKMuuZTPJ57CKZtgRLQaOvxIv78qf1vkO56jfpONopN1Ypi4Jw8
Message-ID: <CACW2H-4Z6PTUrQQas=YGeM4vjxSPbw3iBm3=dymPUiMsWvbT3A@mail.gmail.com>
Subject: Re: [REGRESSION] vsocket timeout with kata containers agent 3.10.1
 and kernel 6.6.70
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: heruoqing@iscas.ac.cn, Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Martin KaFai Lau <kafai@fb.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks so much Stefano and to Moritz Sanft
https://github.com/containerd/ttrpc-rust/pull/280

We've rebuilt and everything is again working as expected - all resolved.

Thanks again everyone
-Simon

On Wed, Jan 22, 2025 at 6:12=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, 22 Jan 2025 at 10:23, Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
> >
> > CCing Ruoqing He
> >
> > On Wed, 22 Jan 2025 at 04:48, Simon Kaegi <simon.kaegi@gmail.com> wrote=
:
> > >
> > > Thanks Stefano,
> > >
> > > The feedback about vsock expectations was exactly what I was hoping
> > > you could provide.
> >
> > You're welcome ;-)
> >
> > >
> > > In the Kata agent we're not directly setting SO_REUSEPORT as a socket
> > > option so I think what you suggest where SO_REUSEORT is being set
> > > indiscriminately is happening a layer down perhaps in the tokio or ni=
x
> > > crates we use. I unfortunately do not have an easy way to reproduce
> > > the problem without setting up kata containers and what's more you
> > > need to then rebuild a recent kata flavoured minimal kernel to see th=
e
> > > issue.
> >
> > I talked with Ruoqing He yesterday about this issue since he knows
> > Kata better than me :-)
> >
> > He pointed out that Kata is using ttrpc-rust and he shared with me this=
 code:
> > https://github.com/containerd/ttrpc-rust/blob/0610015a92c340c6d88f81c0d=
6f9f449dfd0ecba/src/common.rs#L175
> >
> > The change (setting SO_REUSEPORT) was introduced more than 4 years
> > ago, but I honestly don't think it solved the problem mentioned in the
> > commit:
> > https://github.com/containerd/ttrpc-rust/commit/9ac87828ee870ecf5fb5fea=
a45cc0c9e3d34e236
> > So far it didn't give any problems because it was allowed on every
> > socket, but effectively it was a NOP for AF_VSOCK.
> >
> > IIUC that code, it supports 2 address families: AF_VSOCK and AF_UNIX.
> > For AF_VSOCK we've made it clear that SO_REUSEPORT is useless, but for
> > AF_UNIX it's even more useless since there's no concept of a port, so
> > in my opinion `setsockopt(fd, sockopt::ReusePort, &true)?;` can be
> > removed completely.
> > Or at least not fail the entire function if it's unsupported, whereas
> > now it fails and the next bind is not done.
> >
> > I don't know where this code is called, but removing that line is
> > likely to make everything work correctly.
>
> It looks like they already released a new version of ttrpc to fix it:
> https://github.com/containerd/ttrpc-rust/pull/281
>
> And Kata is updating its dependency:
> https://github.com/kata-containers/kata-containers/pull/10775
>
> I hope it will fix your issue!
>
> Stefano
>

