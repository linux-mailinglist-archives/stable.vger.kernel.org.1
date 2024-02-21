Return-Path: <stable+bounces-23263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C4C85ED5B
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 00:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA001C2190F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FBF1272A9;
	Wed, 21 Feb 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="bDKYXu1L"
X-Original-To: stable@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7621A35
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559292; cv=none; b=pySbCsjw5Antfjqt6+r86zra3Kqnus8FWHwtt7f/mRdBKirfNr4EZA40BSJmr/6ELwv0faJaCRA7X1jwfxJq+v39JWPhSorEvKCzFCaEK13/sqApKKgppZ8JIRaDHfTKXOrFGVNSFcj7obYfCqyrJSqkG4RVoFaFLj9LGHOrBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559292; c=relaxed/simple;
	bh=VZQuzm3buqRNubtJLVqXNVm0GYmocLKhq84fL6UN0rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLe5bZxPoQlaab9W8BqCXQrzcuXro7oM89nHb4u8lHi7pcgynv5UvRIJObAyN50rOSXPqRsL+HO8DXwukZHIctAQZvaXDXkPXCN3Yaxhx1jCtVMj7wGH5wYtJ1C+7fycN58jFVERc6HtwGIQmxFMc3GWvqKm8RaTkdxlURLm950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=bDKYXu1L; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 40425635B057;
	Thu, 22 Feb 2024 00:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1708559286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rtc76yJvkC9edmoOvEbasHk3QNkjiHa3uAzTwwExflw=;
	b=bDKYXu1LTjj5Buze2bUVCSykVhY4zL2YJDdRrKUWQTdiFGmYFKeISm1YJHul9EZrguGqOR
	/DZbukpwnMLYHKDTKz43JeyJbDjeII6MdxvrSQ2OhMprGMId6Z8uHcM0vJEX/HwbQaJSSI
	zCqaXMM0SV5uJYVcgdNefvF8utgOeWk=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Vlastimil Babka <vbabka@suse.cz>, Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, Jiri Benc <jbenc@redhat.com>,
 stable@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Date: Thu, 22 Feb 2024 00:47:53 +0100
Message-ID: <13458305.uLZWGnKmhe@natalenko.name>
In-Reply-To: <ZdaAFt_Isq9dGMtP@sashalap>
References:
 <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <aaf2f030-b6f4-437b-bb4e-79aa4891ae56@suse.cz> <ZdaAFt_Isq9dGMtP@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2925697.e9J7NaK4W3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2925697.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Vlastimil Babka <vbabka@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: Re: fs/bcachefs/
Date: Thu, 22 Feb 2024 00:47:53 +0100
Message-ID: <13458305.uLZWGnKmhe@natalenko.name>
In-Reply-To: <ZdaAFt_Isq9dGMtP@sashalap>
MIME-Version: 1.0

On st=C5=99eda 21. =C3=BAnora 2024 23:58:30 CET Sasha Levin wrote:
> On Wed, Feb 21, 2024 at 07:10:02PM +0100, Vlastimil Babka wrote:
> >On 2/21/24 18:57, Greg KH wrote:
> >> On Wed, Feb 21, 2024 at 05:00:05PM +0100, Oleksandr Natalenko wrote:
> >>> On st=C5=99eda 21. =C3=BAnora 2024 15:53:11 CET Greg KH wrote:
> >>> > 	Given the huge patch volume that the stable tree manages (30-40 ch=
anges
> >>> > 	accepted a day, 7 days a week), any one kernel subsystem that wish=
es to
> >>> > 	do something different only slows down everyone else.
> >>>
> >>> Lower down the volume then? Raise the bar for what gets backported?
> >>> Stable kernel releases got unnecessarily big [1] (Ji=C5=99=C3=AD is i=
n Cc).
> >>> Those 40 changes a day cannot get a proper review. Each stable release
> >>> tries to mimic -rc except -rc is in consistent state while "stable" is
> >>> just a bunch of changes picked here and there.
> >>
> >> If you can point out any specific commits that we should not be taking,
> >> please let us know.
> >>
> >> Personally I think we are not taking enough, and are still missing real
> >> fixes.  Overall, this is only a very small % of what goes into Linus's
> >> tree every day, so by that measure alone, we know we are missing thing=
s.
> >
> >What % of what goes into Linus's tree do you think fits within the rules
> >stated in Documentation/process/stable-kernel-rules.rst ? I don't know b=
ut
> >"very small" would be my guess, so we should be fine as it is?
> >
> >Or are the rules actually still being observed? I doubt e.g. many of the
> >AUTOSEL backports fit them? Should we rename the file to
> >stable-rules-nonsense.rst?
>=20
> Hey, I have an exercise for you which came up last week during the whole
> CVE thing!
>=20
> Take a look at a random LTS kernel (I picked 5.10), in particular at the
> CVEs assigned to the kernel (in my case I relied on
> https://github.com/nluedtke/linux_kernel_cves/blob/master/data/5.10/5.10_=
security.txt).
>=20
> See how many of those actually have a stable@ tag to let us know that we
> need to pull that commit. (spoiler alert: in the 5.10 case it was ~33%)
>=20
> Do you have a better way for us to fish for the remaining 67%?

With all due respect, once a measure becomes a target, it ceases to be a go=
od measure.

> Yeah, some have a Fixes tag, (it's not in stable-kernel-rules.rst!), and
> in the 5.10 case it would have helped with about half of the commits,
> but even then - what do we do with the remaining half?
>=20
> The argument you're making is in favor of just ignoring it until they
> get a CVE assigned (and even then, would we take them if it goes against
> stable-kernel-rules.rst?), but then we end up leaving users exposed for *=
years*
> as evidenced by some CVEs.
>=20
> So if we go with the current workflow, folks complain that we take too
> many patches. If we were to lean strictly to what
> stable-kernel-rules.rst says, we'd apparently miss most of the
> (security) issues affecting users.

It's not a catastrophic problem to miss fixes, you will never be able to re=
ach 100% anyway, guaranteed. Introducing a new, untested and not reviewed c=
ode on scale is a bigger problem. Yes, backports should be considered as a =
new code that needs appropriate review. Regardless of how skilled you two a=
re, it's not a task for you. There must be another way of doing this.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart2925697.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXWi6kACgkQil/iNcg8
M0u8CA/6AygdrAQAXnOauqUoFrSWVDZoYl3mecCTwZCeMeu0dFVoTeNlRzZb2Oj5
PFfHMUTOGwA38eBKzUMFpB/eIX2bJmn1KmI7kWTWMwzfJ4CVjmbT4mnqJJpQOGXq
Mr0Wzf+sapgc5PEbmgG4qNVnW0PwcprVrlK1id2Bq6t0JzH/6MuqCGV3I73DSQak
5COBCDlm3OrtRmOvI4EBeVAJTlCLVYCVf2MfZSkxm2mOQzZoYTqWwGGLbT3tbiBt
Vw8ok1jjDxGPazuB4l4YJocyASRsBwDgj4dCGGqpH/HsX1fQrWyX3n4xzYuodubR
f1x4Mun3o3BBfieVvi5HG7GdlC5L5xlSL6dZ2iYd7LWIGa4eJv3hjmPDOPiH/Wmi
mNoisU4F1dwpoIXH+k7VIrD8EaiTGjO2WQpHT1u/fA9eysNDNboPAM5usH4Ir1gy
tKOmKHXe1qtGk0y9A6pstKa9uVD1z4JHX/VpyNE+3pO+OQGnt6xo8g1hIRRP+F81
n+bsE6TV42dOIT50EbqiXg2WwFhcAX/6NLatq4SSdqBGbkEWtsfDV+DYiEJNfqi7
gWUbGQlJJVhNPfubqivQhklepIW4hlpYT8mH7QP5NIlr7nX/k2lLikpeo68bT40H
RsP0C/Sk5prT32nMEfB0PKD5wC6O1xoXm9eJ4UEurbg1thQZQw0=
=x/f7
-----END PGP SIGNATURE-----

--nextPart2925697.e9J7NaK4W3--




