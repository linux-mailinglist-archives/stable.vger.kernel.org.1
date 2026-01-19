Return-Path: <stable+bounces-210249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3994D39BAB
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 01:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 441443001FC8
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98519FA93;
	Mon, 19 Jan 2026 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="izuf+vwR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EE42050;
	Mon, 19 Jan 2026 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768783694; cv=none; b=RHAhr+6UxNuSHGPLI6zQMqzFChzjWz+oAoUtpYuGYSZBRWoYz2z1PX5MyGkKcrlimEIlAjvBQ2pjD+Gf0GBYQoMDSgUihT6Apl87DFAnOddzZplx5S8ZkgRJNnLl/6eijOOKdViM4l3rpEtp2pXkIfNx9KlpdG7fILeP5PS+A94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768783694; c=relaxed/simple;
	bh=L1cG9GUJU2VG1pKximsbwREpSTyPGuSKjzGBFyCymtI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XhItgYatJnrnh9GDiHY/0vD9ICZ3oY65TNxxiwI/Dt1wMKeAiUf8DYZ6kAbGC0lEio9Ol4W951/KsOaUk4E6Fl9CAzHEi75pKGzRJ23i4ujLcgWVfdJP1P6ZhuKxqBFGLa53/5B6msWKQ4+upPBlKnns7ZKr2lfj82ANkZ4vtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=izuf+vwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58127C116D0;
	Mon, 19 Jan 2026 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768783693;
	bh=L1cG9GUJU2VG1pKximsbwREpSTyPGuSKjzGBFyCymtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=izuf+vwRKzywnW+D6nrCZpFYVxKMjSMYmWxOwMMzAgeFtoygz2PAVxF+RJ3t7zV51
	 2kaUV1Y7cr9er9EMPR9K1Higso5pgupl6cCPn4EcrlQmsV7Yh9/VhHZL4Ixtag21J1
	 QtkX2MCH/mD0jmwOGnbirG/wsATbtO15aN98BxeI=
Date: Sun, 18 Jan 2026 16:48:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Maciej =?UTF-8?B?xbtlbmN6?=
 =?UTF-8?B?eWtvd3NraQ==?= <maze@google.com>, Maciej Wieczor-Retman
 <m.wieczorretman@pm.me>, Alexander Potapenko <glider@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 kasan-dev@googlegroups.com, Uladzislau Rezki <urezki@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 joonki.min@samsung-slsi.corp-partner.google.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/kasan: Fix KASAN poisoning in vrealloc()
Message-Id: <20260118164812.411f8f4f76e3a8aeec5d4704@linux-foundation.org>
In-Reply-To: <CA+fCnZcFcpbME+a34L49pk2Z-WLbT_L25bSzZFixUiNFevJXzA@mail.gmail.com>
References: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com>
	<20260113191516.31015-1-ryabinin.a.a@gmail.com>
	<CA+fCnZe0RQOv8gppvs7PoH2r4QazWs+PJTpw+S-Krj6cx22qbA@mail.gmail.com>
	<10812bb1-58c3-45c9-bae4-428ce2d8effd@gmail.com>
	<CA+fCnZeDaNG+hXq1kP2uEX1V4ZY=PNg_M8Ljfwoi9i+4qGSm6A@mail.gmail.com>
	<CA+fCnZcFcpbME+a34L49pk2Z-WLbT_L25bSzZFixUiNFevJXzA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 17 Jan 2026 18:08:36 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:

> On Sat, Jan 17, 2026 at 2:16 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Fri, Jan 16, 2026 at 2:26 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
> > >
> > > So something like bellow I guess.
> >
> > Yeah, looks good.
> >
> > > I think this would actually have the opposite effect and make the code harder to follow.
> > > Introducing an extra wrapper adds another layer of indirection and more boilerplate, which
> > > makes the control flow less obvious and the code harder to navigate and grep.
> > >
> > > And what's the benefit here? I don't clearly see it.
> >
> > One functional benefit is when HW_TAGS mode enabled in .config but
> > disabled via command-line, we avoid a function call into KASAN
> > runtime.
> 
> Ah, and I just realized than kasan_vrealloc should go into common.c -
> we also need it for HW_TAGS.

I think I'll send this cc:stable bugfix upstream as-is.

Can people please add these nice-to-have code-motion cleanup items to
their todo lists, to be attended to in the usual fashion?


