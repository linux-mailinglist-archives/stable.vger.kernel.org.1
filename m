Return-Path: <stable+bounces-64795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE2943496
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 19:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E904E285A8C
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFD1BD02F;
	Wed, 31 Jul 2024 17:00:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188912B8B;
	Wed, 31 Jul 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445212; cv=none; b=tJI9v0VL+E8RzpojtTKHsdK3H+KiJJR+1LD50U5X8XlAYGFlt9bkX6ULvgZnpG7wPO6/ubBkxB/S2YviR522FYzI2ChhWaDAhY6+zRQHbCxd5s6GCHbkhKydaGdoWvQvkubxe+M3YBSEjPR4f/lZA22OYwPpCJkNI7KLGNShEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445212; c=relaxed/simple;
	bh=FzOcWg3ydDqPokvS0+peckNMd6IQ8EkTJOZDmhSS428=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0FU9zec66IrgsjDzOF1HPpQON90j9mD9PAvJfn8MJ/W38fto17VxoxVcd2vlt+3iqUyM2ub/rfr1XJqGCNMywhDQvtDpsHMnyxmdZDncbCQHvACKKoyjjWAx+K9UoU4g/WP7q8qkxJM8W9ZIlOuUVXQfEXXuwPPAzT5OVt2JM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,  matoro
 <matoro_mailinglist_kernel@matoro.tk>,  John David Anglin
 <dave.anglin@bell.net>,  Linux Parisc <linux-parisc@vger.kernel.org>,
  Deller <deller@gmx.de>,  John David Anglin <dave@parisc-linux.org>,
  stable@vger.kernel.org
Subject: Re: Crash on boot with CONFIG_JUMP_LABEL in 6.10
In-Reply-To: <2024073133-attentive-important-d419@gregkh> (Greg KH's message
	of "Wed, 31 Jul 2024 15:41:03 +0200")
Organization: Gentoo
References: <096cad5aada514255cd7b0b9dbafc768@matoro.tk>
	<bebe64f6-b1e1-4134-901c-f911c4a6d2e6@bell.net>
	<11e13a9d-3942-43a5-b265-c75b10519a19@bell.net>
	<cb2c656129d3a4100af56c74e2ae3060@matoro.tk>
	<20240731110617.GZ33588@noisy.programming.kicks-ass.net>
	<877cd1bsc4.fsf@gentoo.org>
	<2024073133-attentive-important-d419@gregkh>
Date: Wed, 31 Jul 2024 18:00:05 +0100
Message-ID: <87sevpa44q.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Jul 31, 2024 at 02:31:55PM +0100, Sam James wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>>=20
>> > On Tue, Jul 30, 2024 at 08:36:13PM -0400, matoro wrote:
>> >> On 2024-07-30 09:50, John David Anglin wrote:
>> >> > On 2024-07-30 9:41 a.m., John David Anglin wrote:
>> >> > > On 2024-07-29 7:11 p.m., matoro wrote:
>> >> > > > Hi all, just bumped to the newest mainline starting with 6.10.2
>> >> > > > and immediately ran into a crash on boot. Fully reproducible,
>> >> > > > reverting back to last known good (6.9.8) resolves the issue.=
=C2=A0
>> >> > > > Any clue what's going on here?
>> >> > > > I=C2=A0can=C2=A0provide=C2=A0full=C2=A0boot=C2=A0logs,=C2=A0sta=
rt=C2=A0bisecting,=C2=A0etc=C2=A0if=C2=A0needed...
>> >> > > 6.10.2 built and booted okay on my c8000 with the attached config.
>> >> > > You could start
>> >> > > with it and incrementally add features to try to identify the one
>> >> > > that causes boot failure.
>> >> > Oh, I have an experimental clocksource patch installed.=C2=A0 You w=
ill need
>> >> > to regenerate config
>> >> > with "make oldconfig" to use the current timer code.=C2=A0 Probably=
, this
>> >> > would happen automatically.
>> >> > >=20
>> >> > > Your config would be needed to duplicate.=C2=A0 =C2=A0 Full boot =
log would also help.
>> >> >=20
>> >> > Dave
>> >>=20
>> >> Hi Dave, bisecting quickly revealed the cause here.
>> >
>> > https://lkml.kernel.org/r/20240731105557.GY33588@noisy.programming.kic=
ks-ass.net
>>=20
>> Greg, I see tglx's jump_label fix is queued for 6.10.3 but this one
>> isn't as it came too late. Is there any chance of chucking it in? It's
>> pretty nasty.
>
> What is the git id of this in Linus's tree?

Ah, you're right, it's not there. Sorry, I thought I'd seen it pulled.

>
> thanks,
>
> greg k-h

