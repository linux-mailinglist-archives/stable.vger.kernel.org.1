Return-Path: <stable+bounces-223836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GETWBHfjr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:25:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EE248551
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE89A3004600
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2C438FE7;
	Tue, 10 Mar 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="INp/buXB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2943C049
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134540; cv=none; b=LXdJrmRnVMMsdJofCsY2T5fhmTE5KITCchKKd9ncezTImroac/fbFuWJtRldQc8YPEjcVPAsoR8jae5yd1ttslkyxBU4pIblGZYCWIG+zdn1d1VFTiR0gGNPWRIexb47m1xGclWRV4H3ne13XFT2gQMWmVMYiQMTILWSqGwsylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134540; c=relaxed/simple;
	bh=o/dGbR/SgN7uW/pRzW0YDchYyVtjObOEnotR+j1CL44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpJ3+AzUU4C+yaZIczcTmWPj4m9+HHhqRYLUzv6n/2UlABxSsP7Z+m6tTR9+AKOomqpSiTeMwrWGzPpJ1PNL3TFIeJd+G8+WZX+RllJE1SrqIsJ/IMkexW1lqOP/CFljUu+2STkxssLklJLbIIUYhs9ZmsePSKF+tFnYlyS+gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=INp/buXB; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-439baf33150so6974160f8f.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773134536; x=1773739336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cVdDKFhypvYGa8JL3zfM0p2k2W6RXruShuUXb6/zJ5M=;
        b=INp/buXByuUc/FEoms93ktmcBPpa9SgcqP92WimSKX6/jQrEK+XDbShHqUm6bjONJU
         CeegcasFaYjVWxAY5yPRQf/yNcr4rpHxPCE8ELQl/apO183I8OyvJEkGLYinXOuZ0tvf
         usUagMZnb9q4urJsnifbW0SlGT6DD6Ma96DscFgxbK+uFMNM8lvyc4Xti0bafbY0UtOR
         ddfncq2vLjXBjN+EGBLmh7quL5Ig7SaiFkmVV43Lt0etkrw3Ku1iJO7RALJb8cSl6hXe
         i/HQJ4fo2Qo9flqtDvWiZX4+iW/xrkZHnBfWz+YQC+coaJbg9eEJ8BnmE/WabHeFiqMl
         YYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134536; x=1773739336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVdDKFhypvYGa8JL3zfM0p2k2W6RXruShuUXb6/zJ5M=;
        b=C3+nR9Md/G7Ki/uE70tI8IjukgyRhMqTp42271gsu6CvimP9IbK7591B810Rni8zPq
         rSf5wPSVDyqycAN4QnyYji8J64cDtT+bVgC3bG8GrcFXh7VpBwb5TVaiCabVoR2WMIlM
         fJUGikxu8GhuyR15XECRg8JzMxQWwy6ArvuxIHy5slA1BE4CsAKb5bQ4nJh3750bS8Ob
         jr9LuWF1tlf1mD3usvr4zlXRFWN97hiddtO9Le9BCmexOQkWcI25eSrDAk1dynBeoKd3
         Tv2Yz5FRkoe8mcLOSINMtnxAS5pBW8TqnylBauBwMdbckwCunOpf+G4MaTOvZRYpkeVk
         2XCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUildz/ZVIi1zRKWykCOsRcuv6M89OdCVXnVXLsiRAv5MmnwGkKXtTmRKAzQQbkOiNi/7mPsxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0syCOB8BPWTN+OQtcMmAOrKu2+ISW8pHge7Sy2dcbzRsER6dP
	Sxq7tuo3bZmpS3YvaEQl1ZWoX0tPxTIHom+ctqA5UiNToiPL3F4ryLZAdqD1cEfnBMg=
X-Gm-Gg: ATEYQzwfcZsfkVIy/rTiUOB4vfi6k4LG/QBhoarg5g6Zu+T7ASOOpSt0SA++rLmLI7m
	i1hvz+sUwIbF6Bl+Q1sgsb2XcSeWIEyXRA6ioUcE1wDKydt0P1C8EwvBgyx+x+/E1wv50AGp+A/
	Cg1BINIe9oATi2wBaqZbIbHfPS7CNFnhgU5ZDVJXOXrGy+06DETSZ3PMi0y/yv3WClpGmBxCIP6
	UPGy5XOeA6UpSlFH/pphPfzwo/iRSqprcU80ED/263UvSla2a+bM6eL1aAXjg0/1VtYhEpPx4gz
	UOjm0R/FCkjNj77Qt7BfarAlKOhgK8H1e+jW333TfqDbRI1wE7wny6ItMIeaGdw/v5/rw68igID
	2qhTtdO5/Nb80L3BcxLhMMkA4lEUfMpRsgy254u8mZ6Bgt8SQukS5lCelFEuq4vbJRHLMd3v4Xg
	3oxDU0aoCb+HmyuV6JSohkXuwsjzM4pBjRTIhfT2V5Q+yHu5moBu/9bOMCC8x4GO0jv1Pc7LwIG
	sAjgpaUuBPWMkY=
X-Received: by 2002:a05:6000:18a6:b0:439:9812:35ea with SMTP id ffacd0b85a97d-439eff12c90mr5308014f8f.3.1773134536149;
        Tue, 10 Mar 2026 02:22:16 -0700 (PDT)
Received: from localhost (p200300f65f20eb04f48475deaf2cf8c5.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:f484:75de:af2c:f8c5])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-439dae57c05sm32072295f8f.39.2026.03.10.02.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:22:15 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:22:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, stable <stable@vger.kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Subject: Re: [5.10.y] "driver core: platform: use bus_type functions" causes
 freeze on shutdown
Message-ID: <aa_hrFevcnH1nHm-@monoceros>
References: <f20634ac-f5e3-4b0e-a91c-d557d0f1aa39@pobox.com>
 <2026030930-iphone-pony-e8ef@gregkh>
 <037126c3-d398-42aa-9883-e9eb74a0ad20@pobox.com>
 <2026031014-dimly-unbaked-4f9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpwdmyfokiv62dsr"
Content-Disposition: inline
In-Reply-To: <2026031014-dimly-unbaked-4f9c@gregkh>
X-Rspamd-Queue-Id: EF5EE248551
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223836-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--dpwdmyfokiv62dsr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [5.10.y] "driver core: platform: use bus_type functions" causes
 freeze on shutdown
MIME-Version: 1.0

Hello Greg,

On Tue, Mar 10, 2026 at 08:07:33AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 09, 2026 at 06:34:47PM -0700, Barry K. Nathan wrote:
> > On 3/9/26 07:43, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 09, 2026 at 07:03:33AM -0700, Barry K. Nathan wrote:
> > > > To be very clear, I want to emphasize up front that this is regardi=
ng
> > > > the *current 5.10.y queue*, and not any 5.10.y release. This does n=
ot
> > > > affect any currently released 5.10.y kernel.
> > > >=20
> > > > When I apply the current 5.10.y queue on top of 5.10.252, the result
> > > > is a kernel that consistently freezes on shutdown, both when running
> > > > directly on my Lenovo ThinkPad T14 Gen 1 (Debian 12 bookworm runnin=
g on
> > > > an Intel Core i5-10310U) and when running in a virt-manager VM (I d=
idn't
> > > > put much thought into it and just happened to pick a Debian 13 trix=
ie VM
> > > > for my testing).
> > > >=20
> > > > (Just once in my testing, there was a visible kernel panic, but the=
re
> > > > was also screen corruption, and it looks to me like it might've fro=
zen
> > > > up partway through the panic being printed on the screen, so I'm not
> > > > sure how useful it would be. I did take a photo so I guess I could
> > > > post it up somewhere if it might be useful, or maybe I'll try to ty=
pe
> > > > it in from the photo later today or tomorrow.)
> > > >=20
> > > > I bisected manually, and it turned out to be this patch:
> > > > "driver core: platform: use bus_type functions"
> > > > (driver-core-platform-use-bus_type-functions.patch)
> > >=20
> > > That patch has been dropped from the queue earlier this morning, so a=
ll
> > > should be fine.
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > $ git pull
> > Already up to date.
> > $ fgrep bus_type queue-5.10/series
> > driver-core-platform-use-bus_type-functions.patch
> >=20
> > It doesn't look like the patch has been dropped yet from the
> > 5.10.y queue in the stable-queue git repo on kernel.org.
> >=20
> > (At least as of this writing, around 6:30 PM PDT, you can go to
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git=
/tree/queue-5.10
> > and see that the patch is still there.)
> >=20
> >=20
> > By the way, if dropping this patch turns out not to be the correct cour=
se
> > of action, I think backporting one additional patch will fix it.
> >=20
> > I applied the following patch directly from mainline to test it; it
> > applied with an offset but no fuzz. I did some brief testing and it
> > seems to fix the problem (no more freezing on shutdown).
> >=20
> > mainline commit 46e85af0cc53f35584e00bb5db7db6893d0e16e5
> > driver core: platform: don't oops in platform_shutdown() on unbound dev=
ices
>=20
> Ugh, my fault, I was confusing this with a different patch.  I'll go
> drop all of these now, thanks for confirming.

I'm unsure why you wrote to "drop all of these" now that the reason for
the breakage is explained and the solution is to pick another patch from
mainline. If you don't really need
driver-core-platform-use-bus_type-functions.patch that's fine, but
otherwise just add 46e85af0cc53f35584e00bb5db7db6893d0e16e5?

I somehow expected that the patch selection procedure for stable notices
if you pick 9c30921fe799 ("driver core: platform: use bus_type
functions") that there are later changes declaring to fix this commit?!

Best regards
Uwe

--dpwdmyfokiv62dsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmv4sMACgkQj4D7WH0S
/k5YrAf/eZlexztGRKzeNjWZAanpwu9F+9SqEL6Vq+oalF2iffotF9sBBtqAzU1d
OsmYZFFYF9aHqSp0oBM6rDc0ZfQBHnRKDo7s/2licwohC8reOaS7qRTjhy9OXIv9
fIWuK84JKDoWn2dwF7p2CL35sdZz+ejE3HZ8ikZAARciRIYduzyoOn9YTiagT7up
aR42Ib2HCrcIBEVk6b4ltl1c/pjzRkzZFB86eIk1idTPNpT8i30iblQ3IxmcpBuz
L7tTMlNuu5Wh0xAC62gX+sF7mj9i5IQjEXVm9b4+crFOTTv+TlcNLqDPp3YUtPCC
7EAKMShRlX8LKmMXJFirNm+Zn/82Ag==
=c0c0
-----END PGP SIGNATURE-----

--dpwdmyfokiv62dsr--

