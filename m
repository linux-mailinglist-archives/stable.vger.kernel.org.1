Return-Path: <stable+bounces-152581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782AAD7D46
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 23:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A5E3B7559
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EEB226D02;
	Thu, 12 Jun 2025 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="priIKhSy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C8189BB0;
	Thu, 12 Jun 2025 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763052; cv=none; b=ffv43jLefTVNS0wUlxbL32fkeijAxRQidGz/iGIavlNxP4GGt1comBNiuflYlsvkQ5lNRaQPWNlCvSCW13z/rlZw9E+F8KacNYEL+e02Tz5yJ42e+jrPV33fJUDwFSo8DzlqqNabOXKy5tyobQGzLaGO3AZOShCouhmbFtO/dGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763052; c=relaxed/simple;
	bh=ULQj/IndkM1c0cZtsKAlkQSqzG5yO/i3mQB5z5aC9wQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=knIxxCAqyv628yGwG4FJClI2iM7VjmFGsn6wpCSkpwPMT5ceH9TRvf34tmjG1/QHOOvIh9juHCBg2kfWkQ+j6qkzcMRTRdtiEfFDOKyE08Sb/JjpBlEjtD1e2XobQV9DTyrJkkqYOMF5idBmzGdH2NEcUNYS4P9QZw7jRjt5frg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=priIKhSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5860FC4CEEA;
	Thu, 12 Jun 2025 21:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749763051;
	bh=ULQj/IndkM1c0cZtsKAlkQSqzG5yO/i3mQB5z5aC9wQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=priIKhSynhe3LOKjsbfpEaAlJ5iUs3DiDPSow9QMyFvsZlAcO4Weo3zaP80wA8P0w
	 +L9GFn0xIP9F+AFIWZy+u1UoNPFAx3dNQD5J0ThpoCLEnbeWcaOWmZ2euotrZR29vD
	 o0ES1InMy2emevirTDCXtCAB+JXtVYoDQ6UHtgr5s3sDbjwo1a8s18U/Jd1Xm0rU4v
	 kAUAllnTdO10bDY/o0h/302TvzQkOuULhQ+dGwCdQ2ZrLB/iKlXiD9mHDBsbXUUMWW
	 be2/U05lNjxVhRRqPp0cEDqd2L1Xm9dXTOTFipOyYb3bx9PnMBPQZzoE6MZsn9mMOE
	 qiSo+WMexZSDw==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Fri, 13 Jun 2025 00:17:25 +0300 (EEST)
To: Sasha Levin <sashal@kernel.org>, 
    Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
cc: Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
    stable-commits@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
    "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
    Willem de Bruijn <willemb@google.com>
Subject: Re: Patch "tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()"
 has been added to the 6.6-stable tree
In-Reply-To: <aEspV8Ttk7uBM4Gx@lappy>
Message-ID: <175e6075-a930-196d-37ce-7f2815141d07@kernel.org>
References: <20250522224433.3219290-1-sashal@kernel.org> <CANn89i+jADLAqpg-gOyHFZiFEb0Pks46h=9d8-FiPa1_HEv3YA@mail.gmail.com> <aEspV8Ttk7uBM4Gx@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-184378114-1749763045=:12898"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-184378114-1749763045=:12898
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

+ Chia-Yu


On Thu, 12 Jun 2025, Sasha Levin wrote:
> On Thu, Jun 12, 2025 at 01:40:57AM -0700, Eric Dumazet wrote:
> > On Thu, May 22, 2025 at 3:44=E2=80=AFPM Sasha Levin <sashal@kernel.org>=
 wrote:
> > >=20
> > > This is a note to let you know that I've just added the patch titled
> > >=20
> > >     tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
> > >=20
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue.git;a=3Dsummary
> > >=20
> > > The filename of the patch is:
> > >      tcp-reorganize-tcp_in_ack_event-and-tcp_count_delive.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > >=20
> > > If you, or anyone else, feels it should not be added to the stable tr=
ee,
> > > please let <stable@vger.kernel.org> know about it.
> > >=20
> > >=20
> >=20
> > May I ask why this patch was backported to stable versions  ?

As you see Eric, you got no answer to a very direct question.

I've long since stopped caring unless a change really looks dangerous=20
(this one didn't) what they take into stable, especially since they tend
to ignore on-what-grounds questions.

> > This is causing a packetdrill test to fail.
>=20
> Is this an issue upstream as well? Should we just drop it from stable?

It's long since I've done anything with packetdrill so it will take some=20
time for me to test. Maybe Chia-Yu can check this faster (but I assume=20
it's also problem in mainline as this is reported by Eric).

--=20
 i.

--8323328-184378114-1749763045=:12898--

