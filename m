Return-Path: <stable+bounces-46088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D68CE916
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A231F20FAB
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD09212EBFC;
	Fri, 24 May 2024 17:13:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F9381CC;
	Fri, 24 May 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570805; cv=none; b=lY/HxHqrq+gpkQIUEt3ND3GOdLnh7ZeWujG/bhZIY51y6uXnpykRjB4j9cdfnKJ2V9x1SD3v3oTyc8TrfBm2FIYADvDaVCEGsLHTol5W/mTP6I/JMzOsx8tt8WnpVXgZHgXsV8zRxve4/OzrB8c8j1sO7DwNp25ZZzu4RLxUiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570805; c=relaxed/simple;
	bh=vphDPHazOPYYZyWRv4dKhwcY4W9o4i4ZeP8O0B/7XYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBo6iz49gxP9i0f205fGRCnFiJYOoRsv/2zBOw5/PtZ+z75qkkAN7dFqIio6KExi75d7tK8b8kmnzlQoWyled93vPa4jHEYgSogPY1OFNhnz8DSWo0p4m0ghthdsCOtud8D9Yln3/pSSjg+wG/bbqVduTqI2JrSvwGq8HLrErS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2F3C2BBFC;
	Fri, 24 May 2024 17:13:24 +0000 (UTC)
Date: Fri, 24 May 2024 13:14:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Ilkka
 =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240524131411.4bfe89d2@gandalf.local.home>
In-Reply-To: <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 May 2024 12:50:08 +0200
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>=
 wrote:

> [CCing a few people]
>=20

Thanks for the Cc.

> On 24.05.24 12:31, Ilkka Naulap=C3=A4=C3=A4 wrote:
> >=20
> > I have encountered a critical bug in the Linux vanilla kernel that
> > leads to a kernel panic during the shutdown or reboot process. The
> > issue arises after all services, including `journald`, have been
> > stopped. As a result, the machine fails to complete the shutdown or
> > reboot procedure, effectively causing the system to hang and not shut
> > down or reboot. =20

To understand this, did you do anything with tracing? Before shutting down,
is there anything in /sys/kernel/tracing/instances directory?
Were any of the files/directories permissions in /sys/kernel/tracing change=
d?

>=20
> Thx for the report. Not my area of expertise, so take this with a gain
> of salt. But given the versions your mention in your report and the
> screenshot that mentioned tracefs_free_inode I suspect this is caused by
> baa23a8d4360d ("tracefs: Reset permissions on remount if permissions are
> options"). A few fixes for it will soon hit mainline and are meant to be
> backported to affected stable trees:
>=20
> https://lore.kernel.org/all/20240523212406.254317554@goodmis.org/
> https://lore.kernel.org/all/20240523174419.1e5885a5@gandalf.local.home/
>=20
> You might want to try them =E2=80=93 or recheck once they hit the stable =
trees
> you are about. If they don't work, please report back.

There's been quite a bit of updates in this code, but this looks new to me.
I have more fixes that were just pulled by Linus today.

  https://git.kernel.org/torvalds/c/0eb03c7e8e2a4cc3653eb5eeb2d2001182071215

I'm not sure how relevant that is for this. But if you can reproduce it
with that commit, then this is a new bug.

-- Steve

