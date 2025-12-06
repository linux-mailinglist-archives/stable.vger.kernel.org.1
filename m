Return-Path: <stable+bounces-200221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9B7CAA2FF
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 09:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB6C530651B3
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C842D949C;
	Sat,  6 Dec 2025 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncOiKQCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C31C5D57
	for <stable@vger.kernel.org>; Sat,  6 Dec 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765010772; cv=none; b=NoFuNMqgtkXyZoeSwltuGWr4obWCCwcqePyJANdQGhGGgKmPKvWwiyKnAUZaM1aiiUFH6eynnbGpGfA0ms4Bk56HzKI2t4PgqlUYjcFSdMDL2h8ED/pjWbxiEvEZ25YkIn+SzciGlP9rf4+6udqS5MYPZSf8LnOtGNo4o8lzP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765010772; c=relaxed/simple;
	bh=l23eQBxowLDUkwKLSW3NdG/SYFfNTBJlr47OR+Xy0Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWfAjHwSUolDcHx0k1lyJSbXM7nD81lZ9MUN3/5bwX0z4SQFX/0qwj/9uK1ONHL86H1uT65Yv+Mm4A/Xdg4SJRg1NrPr1nyMAApiho/krD3bHVrXj9ode86YaXfSLXljD7FLxzAqNGOL9tdzydo5zA2hbuPrGMS59sQocd032yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncOiKQCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B83C116D0
	for <stable@vger.kernel.org>; Sat,  6 Dec 2025 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765010771;
	bh=l23eQBxowLDUkwKLSW3NdG/SYFfNTBJlr47OR+Xy0Mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ncOiKQCxmDj7RpevkyIEsjv+Bt8caYUfp9Lcx1K/gROI8LpfpsGQA4gwlt62PzMV6
	 Z8EXzc8B0Oegga4Bpa0BZI3fsoaMEYB0kBIXommQn8wfykvwNFiFm19Hy+zZrV2u+q
	 8xJ8xSQhGh8luP5HaYG1r4XNxf7nfFZegDKfDLCLKmkbzij2fhlcZfE1c5/2v2BXkv
	 NWl9+Q2nU/QWilShZTiVdPzTSZTG5j0r0PZokjSO6Hhebkrqing7lzSimM5uQYTH1q
	 djnVfLXukjOL9TPJJKUfowu1JQUvtigkfyxb0Jl4xeckiO7sekCM2lvIzv9kyBA8p0
	 dRe2shg3yYFWA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-597de27b241so1517413e87.2
        for <stable@vger.kernel.org>; Sat, 06 Dec 2025 00:46:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWchG81wyKcYq20r20XkXUAC4IRmBhvWfNwi+8DOl0x5+IOWP/T+BYdMC65eLl9WMNMNToAYpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1H7L5lDc+Kb8HN6Pw5LG3ptEm8qyUcacgZ+e+MP4F7Dch6wT
	OvleX2qqUGXgFAS36ryfFJqlC1HlF/Ef/0jaK0QPI0JHFcM+dyxVsAU3vF/E9uSUFrKc1u6zvm/
	5pyKhybMK9J0nZHqZs20nXikrESTrLrvtmaujFj+9Ug==
X-Google-Smtp-Source: AGHT+IGucR2/tx3mm4e04rNJ6GQ+QKyOmuN/v4P5oTZGEahPIPDthPlIHk8CD9vXn21vuftEEXo7+53EV8RUxK11y6Q=
X-Received: by 2002:a05:6512:2341:b0:594:4b3c:bbf with SMTP id
 2adb3069b0e04-5986cdd4c06mr515656e87.0.1765010770144; Sat, 06 Dec 2025
 00:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204094412.17116-1-bartosz.golaszewski@oss.qualcomm.com>
 <75004da5-1ff6-4391-9839-2d134709eea0@kernel.org> <CAMRc=McEX6y_9JF=ji_TQ0aSMaQYe4kjq8Tj1S=vOcbawyXw3w@mail.gmail.com>
 <0fc5c657-4edf-474f-9df7-3c3473b5f458@kernel.org>
In-Reply-To: <0fc5c657-4edf-474f-9df7-3c3473b5f458@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Sat, 6 Dec 2025 09:45:58 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfNP4=PB5DwFJijTffW2uBa+k6=2F0=VT87uD7LPfusjg@mail.gmail.com>
X-Gm-Features: AWmQ_blQ-RhJj7QWYCX5wa5888qO9adziKaeA1O67PzPVpl12psuN-92m3OAetE
Message-ID: <CAMRc=MfNP4=PB5DwFJijTffW2uBa+k6=2F0=VT87uD7LPfusjg@mail.gmail.com>
Subject: Re: [PATCH] reset: gpio: suppress bind attributes in sysfs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 12:53=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 04/12/2025 12:22, Bartosz Golaszewski wrote:
> > On Thu, Dec 4, 2025 at 12:14=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 04/12/2025 10:44, Bartosz Golaszewski wrote:
> >>> This is a special device that's created dynamically and is supposed t=
o
> >>> stay in memory forever. We also currently don't have a devlink betwee=
n
> >>
> >> Not forever. If every consumer is unloaded, this can be unloaded too, =
no?
> >>
> >>> it and the actual reset consumer. Suppress sysfs bind attributes so t=
hat
> >>
> >> With that reasoning every reset consumer should have suppress binds.
> >> Devlink should be created by reset controller framework so it is not
> >> this driver's fault.
> >>
> >
> > Here's my reasoning: I will add a devlink but Phillipp requested some
> > changes so I still need to resend it. It will be a bigger change than
> > this one-liner. The reset-gpio device was also converted to auxiliary
> > bus for v6.19 and I will also convert reset core to using fwnodes for
> > v6.20 so we'll significantly diverge in stable branches, while this
> > issue is present ever since the reset-gpio driver exists. It's not the
> > driver's fault but it's easier to fix it here and it very much is a
> > special case - it's a software based device rammed in between two
> > firmware-described devices.
>
> That's not the answer to my question. You can unbind every other reset
> controller. Why is this special although maybe you mentioned below?
>

Well, for one: when you unbind the device, it's never removed from the
reset-gpio lookup list, the next consumer will never be able to get
its reset control again. I recall seeing either a comment, an email or
a commit message saying that this device stays in memory forever so my
point stands: there's no reason to allow unbinding it. The kernel will
never do it, nor should user-space.

> > I don't care if we keep the tag, it's just that this commit introduced
> > a way for user-space to crash the system by simply unbinding
> > reset-gpio and then its active consumers.
> >
> > And the difference here is that there is no devlink between reset-gpio
> > and its consumers. We need to first agree how to add it.
>
> So you mean that between every other reset consumer and reset provider
> there is a devlink? And here there is no devlink?
>

Effectively: yes, but only because reset is OF-only (as of commit
8bffbfdc01df ("reset: remove legacy reset lookup code")) so device
links are created from device-tree. If you look at any device using
reset-gpio in sysfs, you'll see a supplier:gpiochipX entry but no
entry for the reset. So the answer is: yes, there's no devlink between
the reset-gpio provider and its consumers unless we create them
explicitly, which we should eventually do but I need to rethink the
patch because we should possibly also remove the devlink between the
gpiochip and the reset consumer as well.

Of course, here we could mention a different story: reset seems like
one of these subsystems suffering from object lifetime issues: if you
remove the supplier and the consumer tries to use the reset, you'll
crash because of the dangling rstc->rcdev pointer. That should be
addressed as well eventually.

Bartosz

