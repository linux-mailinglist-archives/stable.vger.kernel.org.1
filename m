Return-Path: <stable+bounces-125829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A322A6CEE7
	for <lists+stable@lfdr.de>; Sun, 23 Mar 2025 12:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED9E1890CB2
	for <lists+stable@lfdr.de>; Sun, 23 Mar 2025 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761918A6C1;
	Sun, 23 Mar 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="Lhaiy5gI"
X-Original-To: stable@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C122612
	for <stable@vger.kernel.org>; Sun, 23 Mar 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742729125; cv=none; b=eIohK6EkgZWbTdZm11A5znF/PeJpXbO745YthGxW6llI4D+664zg7EIE7J2CtHjfStF4b6iTypfrLQMCjfzI1daIGlVtFv1k+RiBCapB63XCiuECQhC41HRlI3XsDhhnbe8b5pfEOb2hNUH7BHTuzGCMYI6R0sL2CJmB52hel7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742729125; c=relaxed/simple;
	bh=J2HRYR96Ynkq+hcgbFbCLYr4zFThAXZP7+nTLdfiS1A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L2rUIfkv3RujJIDTuMinLHGkgSvZijkj/Zf8B0cJXoKbh4i2g16DnPn0TsGYZg5pAVKIFOCgyzup6NEOl6IjuDJ4e+RNy97tef3VzEMZCRSIpxJlKGZrmXcujZ1pdaYfKwoHvVPacrvRtWCdIYW6cE6cbSpFZEXtSWllMbxCds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=Lhaiy5gI; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1742728717;
	bh=J2HRYR96Ynkq+hcgbFbCLYr4zFThAXZP7+nTLdfiS1A=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=Lhaiy5gICUJjCS9DO0dEh2LEgDSzWoGC0fb2fIcV7BGbnFv7ikMoGPaIhM+ztGkdq
	 /RKAVRC71fpDzPn85PdIUg20llnOTjrzcu5gghOQ7jGecd055WJg5owSXN5lZOD7hD
	 oLTq5Zk7ArfA5deI4UW47NXcuqckTIA3i0lfc1xA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 6.1.y 6.6.y 0/3] mm/filemap: fix page cache corruption
 with large folios
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
Date: Sun, 23 Mar 2025 12:18:26 +0100
Cc: Yafang Shao <laoar.shao@gmail.com>,
 ryncsn@gmail.com,
 axboe@kernel.dk,
 brauner@kernel.org,
 clm@meta.com,
 Dave Chinner <david@fromorbit.com>,
 dhowells@redhat.com,
 dqminh@cloudflare.com,
 gregkh@linuxfoundation.org,
 kasong@tencent.com,
 sam@gentoo.org,
 stable@vger.kernel.org,
 willy@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7CD491A-2A14-4DC2-8DAA-3B66D48937FC@flyingcircus.io>
References: <20241001210625.95825-1-ryncsn@gmail.com>
 <5e7ad224-651c-41aa-8d9b-b9ac43241793@gmail.com>
 <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>


> On 22. Mar 2025, at 16:53, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
>> We would appreciate any suggestions, such as adding debug messages to
>> the kernel source code, to help us diagnose the root cause.
>=20
> I think the first thing to do - if you can - is to make sure that a
> much more *current* kernel actually is ok.

Quick checkin from my side: we=E2=80=99ve been running with this fix for =
a while now and have been running smoothly on 6.6 for a bit more than 4 =
months now. We're currently on 6.6.80.

I=E2=80=99ve seen 1 or 2 single reports about blocked tasks that showed =
folio involvement in the traceback since then, but my status so far is =
that those were caused by actually blocked IO and both of them recovered =
cleanly without need of intervention/reboot or any sign of corruption.

When we started diagnosing this we=E2=80=99ve improved our =
infrastructure to be able to more quickly and safely evaluate new kernel =
versions. I=E2=80=99ll put a note in to get the migration to 6.12 going =
and if anything comes up I=E2=80=99ll raise a hand.

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


