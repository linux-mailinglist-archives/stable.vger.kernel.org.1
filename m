Return-Path: <stable+bounces-169500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8285BB25B25
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 07:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC395C1FD0
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F75231839;
	Thu, 14 Aug 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja91L5aV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394122422E;
	Thu, 14 Aug 2025 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150074; cv=none; b=EEqR6ungFNv/r22VoGE1pOXhqJlNPB1HoyJcseyWsVX5wVEp+u8WO5pQkCK3voZvqONEIhoNh+ubqJB47OAXuXdh/0OCrot7z6TCS+D4Vg/lwBjyBu9MtLp07kxBY8Pj14cOHHF5dMOhS7Fy+Yjk7G0baeWKzESTdhgwaRoKCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150074; c=relaxed/simple;
	bh=QN3DbVOxFlmSd23l3i/P34veh0MEYLlbfjJE89nwiSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9T3YFRmHKvLWrKTX7NgANR9TjWXN898o3VTOBTQ56IY0NEjEwTGgL481npy1vZKnl6l5u0LR2xCgIO6FRq8xM4bDmKipdbcpcpvRZUjIa5TSlzY/kLED3AyU02WsbX6bRGdeZkMTSwcdFGX66H2aDl//QVnQR6w6r8VV65zEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja91L5aV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-333f8f5ca72so3919811fa.1;
        Wed, 13 Aug 2025 22:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755150071; x=1755754871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN3DbVOxFlmSd23l3i/P34veh0MEYLlbfjJE89nwiSQ=;
        b=ja91L5aV2mgny+Et422K0J9lJmohUPqLsUB1XxBTDjQW5Hr2LKz5/8gxdY9erDaQ+S
         t2aU6+TgGfBbiTgDqyWSH4WOGP7aEZ6lTlNaKzokbbW/Cda5Sa/KuKf1bpHtpd5mfMKz
         aVw+C0xqHvPVwWqwz5eyOxjXP8FOlY877aalrAOh0uNr2L5XNUxIAmkZ5Qc3HZjgsXru
         t7eNYVKKp3nuBgQbnTkqd3+wtHev/eQ0xkgIUzzBdI4YtC3DrwNGv/YdM2qf7BaAhTDZ
         fP+e9V5Tf8+5ExLqHsXFhFwUMtibob/vAuMbNyApAMrSvjhMjlzxy1oSnU/wL6RYD0vO
         pRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755150071; x=1755754871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QN3DbVOxFlmSd23l3i/P34veh0MEYLlbfjJE89nwiSQ=;
        b=mIUGtWyK7x+qT5UBldujT052vBk+egxjQO1ShCd0aYEXOideLbq6VKXcfK3tMkM0pL
         xnk1X7OfcG9nDzkEFlv0CnikJPO08MVB7pPLPRyxVFg5pLWEYW+PWbcTa8VMjUMscFYw
         Bi5hRWVyJgGsipmryFSOzf8n/FeHjO42lgHZWyDnkOBFFDbwjKiouX2E4MT69HPwMFne
         Bpp9onKrEhfa3qe/vAELVTrZe6+qeOjly1Na6cIb24tq9jZdpde5BDYzUN0LouKonvfd
         oteKhxcZ3jaEnGOc6sqnkUyHb28+PhZvobglFmpA9MbOxeXfeVgnWkHird9+gCvlmeJ1
         +lug==
X-Forwarded-Encrypted: i=1; AJvYcCVJK0cbJhqPprkMrwE4KPfwKFywiD0nUNlA7VBDKDOwuv0eiwxgGb+mrTBZzVjk6kA3Tw1/JFWF3lk=@vger.kernel.org, AJvYcCXtioJI2BFW2/NC6fSuLc+t+1mZXhPSIKGR/QutgrMQ2UThTm6lYtkMP+MUtWGumZO6CIVpooQd@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYNuqoAjFzPC+iD0tf9nrxUx21jrVXu57QKAwhU5zdn+F53dl
	GzF700z6m3QJrVGme6WIcB3dSBfGU/KlKZ8Gm9e8KweNC0TBCoM7l380kNKfd5UN
X-Gm-Gg: ASbGncsr4XtwswWpM52La0AdJQbFk0/lFI2Jg9m4SlWx/HgJD0erWA658quH6vJR2qf
	9jJz1WFfYDT2b+BNlRJuzEzoUnp4n1DwPXwJb1nAgRhI+OA/W+Z8/W7+TjOvGbOxxKvoNP6UNvT
	5mhgxOMKeJQAT7QNmWK8lChET03C/1w45jC7wVFYrsYyzGC/Axkk+uNPL1kGAMBH6mRSl7lMhQS
	mipH25YLQZ6vzjKVd+4IdABv5deZ0uz+P4e6KT48w3JEJRt6NXyRPVzzFwFgIg84dmXBkiljlhL
	YxnEa9HDJ9h3cpx9GhW/Hb5u+EHUdkDyewQ0BH8l6AzDdyHOJbZkKytHE0TNUDQddXQDcLWCGB8
	iYp0VpYMQq6+rdG/XvXOhuYiQn0va+cvljZI=
X-Google-Smtp-Source: AGHT+IHEUl31P2HvgZjm/kJLJOMms0XyA6TZRZRA7CzFgjdCE5184lgjvICQYvRRmb3dU/Kmgvb4RQ==
X-Received: by 2002:a2e:bea1:0:b0:332:1720:2eb8 with SMTP id 38308e7fff4ca-333fa438e42mr4327681fa.0.1755150070697;
        Wed, 13 Aug 2025 22:41:10 -0700 (PDT)
Received: from foxbook (bfd208.neoplus.adsl.tpnet.pl. [83.28.41.208])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333f8e83c5dsm1445521fa.74.2025.08.13.22.41.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Aug 2025 22:41:10 -0700 (PDT)
Date: Thu, 14 Aug 2025 07:41:06 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Marcus =?UTF-8?B?UsO8Y2tlcnQ=?= <kernel@nordisch.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby	
 <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?B?xYF1a2Fzeg==?= Bartosik
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
Message-ID: <20250814074106.2da56397@foxbook>
In-Reply-To: <3566d1a04de7f61da46a11c7f1ec467e8b55e121.camel@nordisch.org>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
	<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
	<5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
	<4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
	<20250813000248.36d9689e@foxbook>
	<bea9aa71d198ba7def318e6701612dfe7358b693.camel@nordisch.org>
	<20250813084252.4dcd1dc5@foxbook>
	<746fdb857648d048fd210fb9dc3b27067da71dff.camel@nordisch.org>
	<20250813114848.71a3ad70@foxbook>
	<3566d1a04de7f61da46a11c7f1ec467e8b55e121.camel@nordisch.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Aug 2025 12:05:16 +0200, Marcus R=C3=BCckert wrote:
> On Wed, 2025-08-13 at 11:48 +0200, Micha=C5=82 Pecio wrote:
> > OK, three reset loops and three HC died in the last month, both at
> > the same time, about once a week. Possibly not a coincidence ;)
> >
> > Not sure if we can confidently say that reverting this patch helped,
> > because a week is just passing today. But the same hardware worked
> > fine for weeks/months/years? before a recent kernel upgrade, correct? =
=20
>=20
> From 2024-07 until end of July this year (when I upgraded to kernel
> 6.15.7) everything was working fine. Also since I run with the kernel
> where the patch is reverted the issue has not shown up again.

Considering rarity of those events I think you would need to run for
a few weeks to be sure that the problem is gone.

There is also a chance that some hardware change wich doesn't involve
the "usb 1-2" keyboard caused it. In bug 220069, another AMD chipset
was dying every few days if and only if two particular devices were
connected to the same USB controller (the chipset had two controllers).

>=20
> > Random idea: would anything happen if you run 'usbreset' to manually
> > reset this device? Maybe a few times. =20
>=20
> How do I do that?

Run usbreset without arguments (as root) and it will print a small help
text and a list of devices it can reset. If you don't have usbreset,
ask Suse. Normally it should be in usbutils package like lsusb.

But I suspect nothing will happen (ie. the device will reset normally).
We tried it in bug 220069 as well.

So it will be waiting until it crashes spontaneously again.

