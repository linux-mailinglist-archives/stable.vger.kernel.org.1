Return-Path: <stable+bounces-83439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71399A2B7
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DBE1F237B4
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D164197A9A;
	Fri, 11 Oct 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aGokPkRi"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD01E7C0E
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646241; cv=none; b=bYI2Gp+vFfrbTdq5jKjwQw1V7d0oIEROaWmRpgALgk3JDXcl0zLHa8HD2j+BQK1HLgJjuX3UBinJBOiJJXEo8ovHEpJjO5MasvONHabZAwaQoyRofE0Rw6+CT7ka/f8j6A5RqqrJXN8IeSIvtEBkjA2gMpRLsnUcA8K+RHMpfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646241; c=relaxed/simple;
	bh=UNLAWWt1/blknds8vIVgWrKzsvLMP2c7msjkiLK8n30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NidoD8c7Zy34ElUwWovrOglc3gHrBKQxUE/ZtrwyndjeaGbvoxFwcexDjiG3ev5OOky/n+lHWql9WZtiYCERB7DuDGfTcLgpaa9e2H0rmgzXqja3g2m2gxSKGVpJJCKd3Fmrw9ote8HG3zXxRhf0Oq4T+SAdlJBwYorEepLtOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aGokPkRi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from pwmachine.localnet (84-115-216-151.cable.dynamic.surfer.at [84.115.216.151])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4539920CECDE;
	Fri, 11 Oct 2024 04:30:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4539920CECDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728646233;
	bh=Bwn74pDeLe3P2zKAb6cNYfXC9Ixy8klS60Ys5rhGfyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGokPkRiSTCIn0NkscAiEdfZq+J0PyVkZlbGEwKrw8tBdXvDZf+PoniPcphq9rHIZ
	 kcWcOtw07ENkjUC3rrDc2rSopTo7phEfsEqJj+Ldlop0cEns8eJWQc7Fl/3zVbuOMx
	 1rWN/YfRRRMs8itAFN10OYtVp9dL/0R11aYc/W7w=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>, Sherry Yang <sherry.yang@oracle.com>
Cc: linux-stable <stable@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, "jeyu@kernel.org" <jeyu@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com" <mingo@redhat.com>, "ast@kernel.org" <ast@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: Re: [PATCH 5.10.y 0/4] Backport fix commit for kprobe_non_uniq_symbol.tc test failure
Date: Fri, 11 Oct 2024 13:30:28 +0200
Message-ID: <2204888.irdbgypaU6@pwmachine>
In-Reply-To: <D36D144A-02BB-4F79-B992-00C2BF6FB8C9@oracle.com>
References: <20241008222948.1084461-1-sherry.yang@oracle.com> <2024100909-neatness-kennel-c24d@gregkh> <D36D144A-02BB-4F79-B992-00C2BF6FB8C9@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi!

Le jeudi 10 octobre 2024, 18:11:51 CEST Sherry Yang a =C3=A9crit :
> > On Oct 9, 2024, at 6:36=E2=80=AFAM, Greg KH <gregkh@linuxfoundation.org=
> wrote:
> >=20
> > On Tue, Oct 08, 2024 at 03:29:44PM -0700, Sherry Yang wrote:
> >=20
> >> 5.10.y backported the commit=20
> >> 09bcf9254838 ("selftests/ftrace: Add new test case which checks non
> >> unique symbol")
 which added a new test case to check non-unique symbol.
> >> However, 5.10.y didn't backport the kernel commit
> >> b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches
> >> several symbols")to support the functionality from kernel side. Backpo=
rt
> >> it in this patch series.
=20
> >> The first two patches are presiquisites. The 4th commit is a fix commit
> >> for the 3rd one.
> >=20
> >=20
> > Should we just revert the selftest test instead?  That seems simpler
> > instead of adding a new feature to this old and obsolete kernel tree,
> > right?
>=20
>=20
> Sorry about the confusion. If kprobe attaches a function which is not the
> user wants to attach to, I would say it=E2=80=99s a bug. The test case un=
covers the
> bug, so it=E2=80=99s a fix.
=20
> Sherry
>=20
>=20

Let me add a bit of context as I wrote the third patch of this set.

It all started with a problem I had when trying to trace symbol names=20
corresponding to different functions [1].
The patch was accepted to upstream and I wanted to backport it to stables.
Sadly, the patch itself was relying on other patches which were not present=
 in=20
some stable kernels, which leaded to various problems while releasing the n=
ew=20
stable kernels (once again: sorry about having caused troubles here) [2]...

The current series seems to hold all the patches for the third one to work,=
 so=20
I guess we can now have it merged to stable without problems.

Best regards.
=2D--
[1]: https://lore.kernel.org/all/20231018130042.3430f000@gandalf.local.home=
/T/
[2]: https://lore.kernel.org/all/2024010402-commerce-variably-ef86@gregkh/



