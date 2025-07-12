Return-Path: <stable+bounces-161752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92529B02D05
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 23:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C403F189514E
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 21:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4A167DB7;
	Sat, 12 Jul 2025 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u6eaM5GW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5AEB672
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354222; cv=none; b=nJzsd+h1+L5qNy/sOyegN98W2xpEYh5GGmwBddoYqQ9p4ndIU0AIL3+KB5hUlTtJqmkCPBS/K39DHJc/V4wHaSYaryg33yKf5Y3wvXZtjKtLnv3HiF0Xdz7WQnHDP7OHCb1wJvAEnvFFLGHIGAK534qj6+1GgHy6G3+gO3l34zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354222; c=relaxed/simple;
	bh=mCFgr44Ce2d6g6ed0eNcp/ui3sl2GYywnZIV/d+tWm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb5XemovKW6mEM7jXxb0Jhq7C58uWjruILgfPrm6Kvb2g5cGFlO/deRxb8qPIwtASsWG3vHkNdmOI7j6GRuKqSDQ+B87Eu8VoindEF+3u+uKi0LNTVfqO3ckuiuvXXvtNDrsMSuPQkkO26RKqzg4P3YLZf52CG41Q8P34buhoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u6eaM5GW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so5989372a12.3
        for <stable@vger.kernel.org>; Sat, 12 Jul 2025 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752354217; x=1752959017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCFgr44Ce2d6g6ed0eNcp/ui3sl2GYywnZIV/d+tWm4=;
        b=u6eaM5GWGL1atrecC0aM1Bg//XT7ymA00dTLam2RbwzfVlqml/XrhtDBdU+6V1AOmd
         sMGW11rV+02VW3WRxZdnZjlWiJv3niOVRN8OgTiMYJV0I7qGpgiZucLdIAgNjG5wjZk7
         E9+lo95qz1Z185Q80/Jzy/3+wG4vQzjpyzCEfVgLiv+s0N+YeHOn7VPZzZigMVx7TJET
         pc52dDB6XQsNlvSvZCKYQFOl8h9Z0+rjKcAZzHG+BgoS4dnfUSLrSZ3vqICTal40PDl0
         71F30uDlKVkNrJWGZN6mOgaq9aF5EppeeDPI5Octf5F1MYxEre7oEHUevdy+XaaE7wyE
         YHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354217; x=1752959017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCFgr44Ce2d6g6ed0eNcp/ui3sl2GYywnZIV/d+tWm4=;
        b=JbXGYOLKld2RbBwTI3rhvOLlk3CersMOX0izRdPIhAPxJJOeGhquIHX9ZQVi4qg+TM
         +UfnKVYgHmcGWAA/FmXTHMSDfOmietdtjY3d6aJGcwa5sxoqZbL+M6cn9jz5/r2t8jUG
         AKcUAvSEce/MWnTFAWmDKdxu9WL5QdLCykdH7FreL7rSElWzHmrwqs67lDz3Lr2MLelv
         bC4FCq8l2Mc4tKtoHXi/j8eKk2ePGQtislYF3SlrIA33DoSEUbStRo0khd1VM3hxGBDI
         Y7LwU90P8umuu6GcdqCvZQDLOhlyseDwu+RKubs3XijWgAqFSiTiixdth30rK1GGTeHq
         d2Jw==
X-Gm-Message-State: AOJu0YwhmNH/a9By6wqQF0f60xwC7U8WGsR1uz/iWhY4QRnR/OOYW5mE
	iYQKje4kk9Kyu3y71eq7hAWJLYEiWrFwaGpaQfyFqb6lY7z8b+xT9bV4Q/F+m7GegiJh0Cuc0eG
	8SJpo
X-Gm-Gg: ASbGncvpMHEyg0Z8zPYvY+BtoA99my9L4LyB77dcntoQWAsa+MAYcNw+LLCbeo9qFcz
	t4ctyuzKFv3/mBMh02PCCX6cyd7N5jZz4JNvClKmjH/3uqaHy37bg5vDQjmNYELoGwddyG9hPfz
	1tofXpJXWmAdgqA21+zUD3wGHiQ5bkXvfn+bNqiUp0z8zlHHKsKjUkDG6EBewlOpxeyzr0oGcjs
	U+4fdaU1BnvEq3up55/y+0iRmSLLZOxErAze808iFJw46TvwUWEIEbzetyPk5gPk/gP2DxuAAPY
	kQEtcfi1NUfW1slQBglTK50GYo1JLxQTG3MEOHGjpD3qL9bUMV/CUdJTsAWyFWlmAYB/vfTan+D
	zusrF3kuDMIdLdhGV2jdIVBlvd50=
X-Google-Smtp-Source: AGHT+IGaDtzKCut8mbRMWj+GxC54Ap0hKC1jXuJ5yzm7/zXGK7TnTPgO7k80GLuvvW77TPjJQKIMYQ==
X-Received: by 2002:a05:6402:40c3:b0:604:e440:1d0b with SMTP id 4fb4d7f45d1cf-611ecaa15a4mr7279336a12.4.1752354216841;
        Sat, 12 Jul 2025 14:03:36 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-611c9542fe5sm3914479a12.35.2025.07.12.14.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:03:36 -0700 (PDT)
Date: Sat, 12 Jul 2025 23:03:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks
 in error path" failed to apply to 6.1-stable tree
Message-ID: <encgoe4ytayvia6idadv637fsvzuhsv3cqes5h7zxwqx633chk@wk34ptu5qgzp>
References: <2025071235-disagree-dolly-ab52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkja3dy3hqp3kupq"
Content-Disposition: inline
In-Reply-To: <2025071235-disagree-dolly-ab52@gregkh>


--kkja3dy3hqp3kupq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks
 in error path" failed to apply to 6.1-stable tree
MIME-Version: 1.0

Hello,

On Sat, Jul 12, 2025 at 04:00:35PM +0200, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 505b730ede7f5c4083ff212aa955155b5b92e574
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071235-=
disagree-dolly-ab52@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

The patch that I prepared for 6.6 also applies to 6.1. See my mail with
Message-Id: 20250712204543.2166878-2-u.kleine-koenig@baylibre.com.

Best regards
Uwe

--kkja3dy3hqp3kupq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhyzaMACgkQj4D7WH0S
/k6I0Qf/WcBBecPxCheBambnb1AJd7yrmYYqwXv4AkcEGCt5nkCFFFvAw76Vxo5E
XHy+Cccd9lLTVw5oMN5C91734xN5vZnDsTZET6cMGOnNcYUyqLv1nQjUN/Epd5GA
gtLxltFgYZI26eBY+XKfDQv7FQp9TcbhZqjVd7/SBYUmGcc7L71oUlFKu/sTNSQG
G8UbHgK+fkJt9baTPJ5xEKcfh3qalCdM8+rqdIN0dBgsu/k+i/xqkAObfVQ3neXI
OZzfgT2UCiSTq3K5zjIWCdDoMy+ap1+VD72sPE+TAvPRa6X/hvP5ywu5RBDwiNUC
u8HQKgjfIePpnWLnHMUCFERhnlIFJw==
=kzoC
-----END PGP SIGNATURE-----

--kkja3dy3hqp3kupq--

