Return-Path: <stable+bounces-196913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF3C85748
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 15:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D18C4E255A
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E432571B;
	Tue, 25 Nov 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X3NAf6Ip"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD999325725
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081595; cv=none; b=AoVlHwSomtgZYgB8ypDMgOVBA1pCJP5RUQZFQbBZMn6Nnfi0CPyOlCQ9aNjUzvi/hbcO/brWNbcvwEHhVLz0jrsxGDYsLa6aSzVUONJ+k0rT/2+VZjwBdBzau62L50w1Y7GLaL+8ByPkkcVEwMk2v/07qbZKTEBgMTjM31UC4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081595; c=relaxed/simple;
	bh=/E5kcqzbDlOv2Q7g0QQ8/Xv3tvTqkKVmuRobxTyCVWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FL6cgl50095nJMn94eU5mvMdw2kz89+cwdwkce/B2hPE/+nNXz0/ZwzDH08s7PEwCVfpFTa1WcYnOQwB9Qz2BF0KveKyK801TGd/Bpy2/FP49JiVrRn8nMTUawQ77crudHmgAidF1LE0d2VrmaO/ky7bc7TyN8mzASML0lhFQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X3NAf6Ip; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-595910c9178so3731131e87.1
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764081591; x=1764686391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a50WltabLQuKGTll5L02CIPL9Zw/ClpkvzmWNzTOgB0=;
        b=X3NAf6IpU4vL/C42OzDJGQv1XZROVKXpNoXZHt+9YiIfDQjaYwngPylbBOpuAEgMqD
         X2V1P9qekBCdPfn+/4ch1EQ+KDGjBAAetUyBykmAGtQv/NClVA443aD/Gpm15y9FuqsN
         SbBw3CAVt9uF+aarvTK4gF6B2unQgePAuSsXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081591; x=1764686391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a50WltabLQuKGTll5L02CIPL9Zw/ClpkvzmWNzTOgB0=;
        b=nMptPXTyawA2C+WQ+84rrf3JwM6ZCJCRP6S4KEkxr9PKrS4rxj+k/b4Orp8HmMQcoc
         7UBl/mp37hiPAu4vnAF5hnofyMXwe1iTleGkMFlj+PDCawGsARovHUs0MbQuQa6Xy3BL
         eDqiBSpiydobizJfwfkI+17GyAvbhAGnaJCiRtoM0qxzYJSM3jLhk+hQsloT8y6ARxHV
         4Kkg9GB+3Hlr5F8lM5FvWc6jvwUruvWcwdqw6pegy/pDLlrjQlVbg22KL1uzYHbnJOq9
         t2zErXVhDbHb/OsuyAMU2kpQqDgUMx59S+5snUinijNP4vrWq8WK29XaSrIJEMUfLAC9
         3xtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN9Wcz0bWWZx79XsAaILDY91oe1RtHg0ip5LnSMormd9ZahJwvlHS18YVlpXaugxcF9JLVFGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4DSS5lJxvswcsN9WApmHnK4UFSA4WQQYCB7a25CI+wdp7Z7s
	vWSBT0K/Y63KYl45KeWijwrxqH7hh7Xjk6RVt8DBW9Q37SbYnZ5xbSeGDRR6/2sz1FOM4/75JxA
	63OrTASD8cGMIdrKCv0c/tmpfBT/kUsiXZZePvqE7y2Xodf+xYavTVHo=
X-Gm-Gg: ASbGncuKWMhadGS7cMWJd9AnOA9ryc9xiKqmDmBksiEuEyLM563MlX0UggHZu19CFBX
	tssPmt7VY3vqcxp4VYkkvzb/GYl8THVBZV4jASa/y8/XXivt0+ddSxpxdWXZt413S9tqqMnXjlK
	fPGRcebfAv1rrhL6wp/KGjBhw9qeGmzWlYcZmoIhWTOwR0wxObb54o7ChZmpOAEh1b4y3T8bcvL
	GSv1xu7h58OeWZ66JGVgYcXmSIfp54nZ+6DgKeQelUXzn/T8xkuU2qeZ5G8Cl98XBI=
X-Google-Smtp-Source: AGHT+IGgRfzZDNMu/UOhfk/JjAU4Hwqtik3pmgGKx8O8YmD9v3/SDDi4P4gYUweCizAQOqVKxKwqF7r9+smzzsHDPGE=
X-Received: by 2002:a05:6512:685:b0:592:f3ef:19ad with SMTP id
 2adb3069b0e04-596a3ed1ca7mr6751513e87.34.1764081590780; Tue, 25 Nov 2025
 06:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119212910.1245694-1-ukaszb@google.com> <2f05eedd-f152-4a4a-bf6c-09ca1ab7da40@kernel.org>
 <6171754f-1b84-47e0-a4da-0d045ea7546e@linux.intel.com> <e7ebc1da-1a94-4465-bc79-de9ad8ba1cb6@kernel.org>
 <CALwA+NakWZSY-NOebF9E+gGPf2p0Y5FLOZcpLfSbt5zkNm_qxQ@mail.gmail.com> <2025112537-purgatory-delegator-41fb@gregkh>
In-Reply-To: <2025112537-purgatory-delegator-41fb@gregkh>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 25 Nov 2025 15:39:38 +0100
X-Gm-Features: AWmQ_bliMCOuLBlhEX4j3hTXnUx3n5nHYuBms-9Af5XR4AAmskCSV3CU9Wu9le4
Message-ID: <CALwA+NaT97vDjuPDQsjR=iNrV79A4k4AC2awVPeRCyubBezBhw@mail.gmail.com>
Subject: Re: [PATCH v2] xhci: dbgtty: fix device unregister
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, 
	Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 25, 2025 at 08:53:17AM +0100, =C5=81ukasz Bartosik wrote:
> > On Mon, Nov 24, 2025 at 10:11=E2=80=AFAM Jiri Slaby <jirislaby@kernel.o=
rg> wrote:
> > >
> > > On 24. 11. 25, 8:48, Mathias Nyman wrote:
> > > > On 11/24/25 08:42, Jiri Slaby wrote:
> > > >> Hmm, CCing TTY MAINTAINERS entry would not hurt.
> > > >>
> >
> > Fair point. I will keep it in mind in the future.
> >
> > > >> On 19. 11. 25, 22:29, =C5=81ukasz Bartosik wrote:
> > > >>> From: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > > >>>
> > > >>> When DbC is disconnected then xhci_dbc_tty_unregister_device()
> > > >>> is called. However if there is any user space process blocked
> > > >>> on write to DbC terminal device then it will never be signalled
> > > >>> and thus stay blocked indifinitely.
> > > >>
> > > >> indefinitely
> > > >>
> >
> > Thanks for spotting this.
> >
> > > >>> This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_dev=
ice().
> > > >>> The tty_vhangup() wakes up any blocked writers and causes subsequ=
ent
> > > >>> write attempts to DbC terminal device to fail.
> > > >>>
> > > >>> Cc: stable@vger.kernel.org
> > > >>> Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
> > > >>> Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > > >>> ---
> > > >>> Changes in v2:
> > > >>> - Replaced tty_hangup() with tty_vhangup()
> > > >>
> > > >> Why exactly?
> > > >
> > > > I recommended using tty_vhangup(), well actually tty_port_tty_vhang=
up()
> > > > to solve
> > > > issue '2' you pointed out.
> > > > To me it looks like tty_vhangup() is synchronous so it won't schedu=
le
> > > > hangup work
> > > > and should be safe to call right before we destroy the port.
> > >
> > > Oops, right, my cscope DB was old and lead me to tty_hangup() instead
> > > (that schedules).
> > >
> > > >> 2) you schedule a tty hangup work and destroy the port right after=
:
> > > >>>       tty_unregister_device(dbc_tty_driver, port->minor);
> > > >>>       xhci_dbc_tty_exit_port(port);
> > > >>>       port->registered =3D false;
> > > >> You should to elaborate how this is supposed to work?
> > > >
> > > > Does tty_port_tty_vhangup() work here? it
> > > > 1. checks if tty is NULL
> > > > 2. is synchronous and should be safe to call before tty_unregister_=
device()
> > >
> > > Yes, this works for me.
> > >
> >
> > Greg should I send v3 with typo fix  indifinitely -> indefinitely and
> > elaborate on
> > the tty_hangup() -> tty_vhangup() replacement in changes ?
>
> As this is already in my tree, a fixup on top of that would be good.
>

I sent a fixup. I created it on top of your usb-linus branch.
Please let me know if you expect it to be created differently.

Thank you,
=C5=81ukasz

> thanks,
>
> greg k-h

