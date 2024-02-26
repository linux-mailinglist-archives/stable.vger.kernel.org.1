Return-Path: <stable+bounces-23778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE628683D4
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 23:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004291F25998
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0002134CD6;
	Mon, 26 Feb 2024 22:37:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30031350E9
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987036; cv=none; b=P7LL14NdwyPneeYzXR6X3GTQEDP9WfF3Udd8Sxsn797pHBFlert+T9m2pvAgvgm1LTbiejPzB7UVJh/KV36j1lRgWmnZKFhv7NVdGAvPJa2l0mm2nYU3VZ3+NXoLfdLhtCP6zQv9+ryM6se6l2sLqxNIZeODMpt+AjEjjO7F6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987036; c=relaxed/simple;
	bh=QvYJMSfgQQE0jrelwTuaUO8T+ekSr9GHR8TunqaZXbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KVCF4VndUai3Tvx/k+4lq+8kAB+DcSwa7ZqkPBf4mgYtmfLXIalLrf1MiEkuRQHUPBXjCklrENa6bHe/FwSm2gxgQ6hofD5xr9iV7Oh35i1sVgsVM7cQQBC8DEJrtVL28H2h5lfExB+A7AwiYNKPgh5vmMV9J2sQnN8YS5afoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-127-0q1Hyn2MOyKeiN2-uB19eA-1; Mon, 26 Feb 2024 22:37:11 +0000
X-MC-Unique: 0q1Hyn2MOyKeiN2-uB19eA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Feb
 2024 22:37:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 26 Feb 2024 22:37:10 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Greg KH' <gregkh@linuxfoundation.org>,
	=?koi8-r?B?8sHEz9PMwdcg7sXO3s/X08vJ?= <stalliondrift@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: RE: Kernel 6.6.17-LTS breaks almost all bash scripts involving a
 directory
Thread-Topic: Kernel 6.6.17-LTS breaks almost all bash scripts involving a
 directory
Thread-Index: AQHaaM8br5suuE6Hrk+G7FpS6vXjnLEdNmoA
Date: Mon, 26 Feb 2024 22:37:10 +0000
Message-ID: <783a5593b8b248a887bd1d896586dfb3@AcuMS.aculab.com>
References: <fa4cd67e-906d-4702-90e2-b9c047320c34@gmail.com>
 <20240226-porcupine-of-splendid-excellence-22defc@meerkat>
 <2024022645-zoology-oppose-ea92@gregkh>
In-Reply-To: <2024022645-zoology-oppose-ea92@gregkh>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Greg KH
> Sent: 26 February 2024 16:03
>=20
> On Mon, Feb 26, 2024 at 10:52:50AM -0500, Konstantin Ryabitsev wrote:
> > > In the past 4 or 5 years I've been using this script (with an alias) =
to
> > > compress a single folder:
> > > 7z a "$1.7z" "$1"/ -mx=3D0 -mmt=3D8
> > >
> > > I know it doesn't look like much but essentially it creates a 7z arch=
ive
> > > (with "store" level of compression) with a name I've entered right af=
ter the
> > > alias. For instance: 7z0 "my dir" will create "my dir.7z".
> > > And in the past 4 or 5 years this script was working just fine becaus=
e it
> > > was recognizing the slash as an indication that the target to compres=
s is a
> > > directory.
> > > However, ever since 6.6.17-LTS arrived (altough I've heard the same
> > > complaints from people who use the regular rolling kernel, but they d=
idn't
> > > tell me which version) bash stopped recognizing the slash as an indic=
ation
> > > for directory and thinks of it as the entire root directory, thus it
> > > attempts to compress not only "my dir" but also the whole root (/)
> > > directory. And it doesn't matter whether I'll put the slash between t=
he
> > > quotes or outside of them - the result is the same. And, naturally, i=
t
> > > throws out an unlimited number of errors about "access denied" to eve=
rything
> > > in root. I can't even begin to comprehend why on Earth you or whoever=
 writes
> > > the kernel would make this change. Forget about me but ALL linux sysa=
dmins I
> > > know use all kinds of scripts and changing the slash at the end of a =
word to
> > > mean "root" instead of a sign for directory is a rude way to ruin the=
ir
> > > work. Since this change occurred, I can no longer put a directory in =
an
> > > archive through CLI and I have to do it through GUI, which is about 1=
0 times
> > > slower. I have a DE and I can do that but what about the sysadmins wh=
o
> > > usually use linux without a DE or directly SSH into the distro they'r=
e
> > > admins of? With this change you're literally hindering their job!
> > >
> > > I downgraded the kernel to 6.6.15-LTS and the problem disappeared - n=
ow the
> > > slash is properly recognized as a sign for directory.
>=20
>=20
> Any chance you can run 'git bisect' to find the offending commit?

And run under strace to see which system call is behaving differently.

=09David

> Also, what filesystem type are you seeing this issue on?
>=20
> thanks,
>=20
> greg k-h

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


