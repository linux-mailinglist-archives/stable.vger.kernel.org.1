Return-Path: <stable+bounces-196870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8799AC83D9F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 09:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9B3A280C
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C692DE6F5;
	Tue, 25 Nov 2025 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DjICRCdF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D502DC32C
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057212; cv=none; b=Doc11bPEWjRTcomofvQ0UDSir087nUprYZfUafoez12KGN5pB0bE4AuyBevgZiO6ZxDbE6cWfxiwX/R2Janl5Ke7V2FUn8KD6ZZQyRpoH91LuM218fW77mEtMrTdUaH11iBTDddjabMbMB8T3E8u2PPnNy7zWLb5KFHy9FK2Vyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057212; c=relaxed/simple;
	bh=QALkO2l63ElPL+SM8EnCE5RvNLGszpSTCE8PUQlaRbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjmRpB2J/Rg1xWNTXANpCbkNWnnP0wDMMqFJPU5bgO3JeDmCm0U7YAQOf4WkE4mM7JRwsdNLETleQIQmlNZyVL+L0ZUAz1dQ1Drf2tLlpRVuiLJCRfdE1z36hqnAXpCD+dD6yNp//SDqb6l/oATusUw1/4FjMd01N4QYPC5TRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DjICRCdF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5942a631c2dso6842501e87.2
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 23:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764057209; x=1764662009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW9fk+eRBqur6OCFMItr5F2cEB0RbZrpC7YKLRabMpw=;
        b=DjICRCdFmQ2GXQivrzEIDEf+EiAVYtD8PSnFuV17YCQ6F2krCQWR8sQT2hVT1n2H5c
         5qPEPaYM5WRtL8iorylT3sNZmF1xj7Qo+J6WLT3hr/oEW2/HNbE9rbg4MSim3yHpEgVN
         G5TY3zyYGe4bgLDIsXI/to6bibGgxp2rPSED8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057209; x=1764662009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VW9fk+eRBqur6OCFMItr5F2cEB0RbZrpC7YKLRabMpw=;
        b=l3CdQ8JZodIlkGU2p40wkZ5JU5XJZ/WhBmQYJHgr2QZWp5bYzUHUbf7H0Ff6IaaM1M
         14sdV9TTa4cTe2/nUEDKah2Fz3fSYNA8YgPlvzc8lejPoe1vJxKpBzC2u1+J+U0TyzG7
         YMlfnEHcyZFvbev2zrk3CmN000nCjp5DgIsBKjQX7AlO+EozQ90dqfj9DbaWKSE+WoL4
         /BOlO7PMPh2QVx0B9RYxdf8wtsEH9MmzJKElbAa+oHpWs1uVlCAzIDcfUJ5E3+gPYXJU
         pa2aqH6XU1tPO5FipGtCDdsbt59Vvvzl5tFHBzAfxPchdU9RN/PWUO+isw7RdfsinSP0
         Q1WA==
X-Forwarded-Encrypted: i=1; AJvYcCXlF8dZXvA/+LDWMxi/QHjgpLtMz2GnaXuqnGGdSfsQNjLkL8GcaSPSm1VdyxXrFG05tw6jOvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Iv4/66p7td0//4YZKpjOImZzaoLc31L/vSS0dTovhisp5uEa
	6ytjIhC5d7l3bGuP8fKIsBXekkqzyCU/HzOK/T7tAKIMcFFeJ9BG8JgW4nJt31YTgdkLDj+tA44
	MdULCCkXLOHgofGxoZiuCos+7FArA5tNlloRbn/0=
X-Gm-Gg: ASbGncv9/ywvlYUXXBkcowlugEpAit5p2DI3sA6EZ+r5+GxosHtB88xk27qSfdcBPYy
	sS6m8yJV8U6JAiQhoBB28Z6rRo8XceeW0isfwbvJ6V5PtXbC5nnFcX1e0R8CeAq58r8zfyW9bFW
	3K82gUIDv5Biv6F2Q/uUkqHY0ocGUzTLJiRx9FOm20E8JgJ26GNul75EcvMzN9vq07ZEFkRyK5+
	A0YEYc5w5tGpEFKag0IyKV8RCk2gUCQrQMNbwB/kgfD66a1caw5aGSno27cCjf/U/pUrY2IhJyt
	IA==
X-Google-Smtp-Source: AGHT+IEifOJmyiCsFOT5OGXNBDuJrumS8e1OEbDl+tOphrhwx2KdXAfOkAoydLQJLpGr9qVTDLsmhvdTzuXB8683cTM=
X-Received: by 2002:a05:6512:398c:b0:592:f9dd:8f28 with SMTP id
 2adb3069b0e04-596a3ed25cemr4985472e87.35.1764057208763; Mon, 24 Nov 2025
 23:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119212910.1245694-1-ukaszb@google.com> <2f05eedd-f152-4a4a-bf6c-09ca1ab7da40@kernel.org>
 <6171754f-1b84-47e0-a4da-0d045ea7546e@linux.intel.com> <e7ebc1da-1a94-4465-bc79-de9ad8ba1cb6@kernel.org>
In-Reply-To: <e7ebc1da-1a94-4465-bc79-de9ad8ba1cb6@kernel.org>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 25 Nov 2025 08:53:17 +0100
X-Gm-Features: AWmQ_bk4hTtCGqfI6AKAS5toTSvyk-WSSSR6OjN0qv3zrxaYyCIn6l2upPhGeBg
Message-ID: <CALwA+NakWZSY-NOebF9E+gGPf2p0Y5FLOZcpLfSbt5zkNm_qxQ@mail.gmail.com>
Subject: Re: [PATCH v2] xhci: dbgtty: fix device unregister
To: Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Mathias Nyman <mathias.nyman@intel.com>, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 10:11=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 24. 11. 25, 8:48, Mathias Nyman wrote:
> > On 11/24/25 08:42, Jiri Slaby wrote:
> >> Hmm, CCing TTY MAINTAINERS entry would not hurt.
> >>

Fair point. I will keep it in mind in the future.

> >> On 19. 11. 25, 22:29, =C5=81ukasz Bartosik wrote:
> >>> From: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> >>>
> >>> When DbC is disconnected then xhci_dbc_tty_unregister_device()
> >>> is called. However if there is any user space process blocked
> >>> on write to DbC terminal device then it will never be signalled
> >>> and thus stay blocked indifinitely.
> >>
> >> indefinitely
> >>

Thanks for spotting this.

> >>> This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_device(=
).
> >>> The tty_vhangup() wakes up any blocked writers and causes subsequent
> >>> write attempts to DbC terminal device to fail.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
> >>> Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> >>> ---
> >>> Changes in v2:
> >>> - Replaced tty_hangup() with tty_vhangup()
> >>
> >> Why exactly?
> >
> > I recommended using tty_vhangup(), well actually tty_port_tty_vhangup()
> > to solve
> > issue '2' you pointed out.
> > To me it looks like tty_vhangup() is synchronous so it won't schedule
> > hangup work
> > and should be safe to call right before we destroy the port.
>
> Oops, right, my cscope DB was old and lead me to tty_hangup() instead
> (that schedules).
>
> >> 2) you schedule a tty hangup work and destroy the port right after:
> >>>       tty_unregister_device(dbc_tty_driver, port->minor);
> >>>       xhci_dbc_tty_exit_port(port);
> >>>       port->registered =3D false;
> >> You should to elaborate how this is supposed to work?
> >
> > Does tty_port_tty_vhangup() work here? it
> > 1. checks if tty is NULL
> > 2. is synchronous and should be safe to call before tty_unregister_devi=
ce()
>
> Yes, this works for me.
>

Greg should I send v3 with typo fix  indifinitely -> indefinitely and
elaborate on
the tty_hangup() -> tty_vhangup() replacement in changes ?

Thank you,
=C5=81ukasz



> thanks,
> --
> js
> suse labs

