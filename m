Return-Path: <stable+bounces-52273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA99097B9
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26041284556
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F838DD6;
	Sat, 15 Jun 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGxivWwe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4AE2E636;
	Sat, 15 Jun 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718448625; cv=none; b=UCEvSGTjjteHa8trAeg3X3ib0s/Ej1xRdRwIyT2busFMrR4gALhq9gWfhIx4Nr8r+x0SNAhNR2mIrpViPsWpWcz2pJG0RnQGmtxJlru+ayOKvR768UEA718YkG0si+k+Vw1qO8bEYzJRhYW1qEX9UrdDf/bVpVh346JxZ+JOJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718448625; c=relaxed/simple;
	bh=+3wzKJYFrmmEQ3zH1YhduyYUW+NkzSU9v/arsIC76BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcWzuUA3pscF3MkupnW0TlWquxF8ZveJMhL74KdOk/PaJ1w84QaRV+W2SnhJFKLBCnw6OpCZv3GbRxwjl5ZuPSeHNdXKovzBEiA6ZZG+2L62x576UTL9NcNtw/DZZam3Ks46zKVi/FrmVJdvKAl3pW6qH4NQ+Lr2vO22k4x8MXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGxivWwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C72C116B1;
	Sat, 15 Jun 2024 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718448624;
	bh=+3wzKJYFrmmEQ3zH1YhduyYUW+NkzSU9v/arsIC76BA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VGxivWwe0bQfL6J1rl1Jziop7/nqJQ+cdzXwhjOYcutq5GSZH8GvMG4DTo4q+/xZP
	 rjbKrju+3wCbdni6Zo9ZfGS0P06ZUD+9H/PouQKgCc2idnebg19NO0TdwQs6jgv/Tf
	 Irrtupy8Nyq2oVTaP2ABFXSB+M3HHEK31vnUyuJ2O1ahhlIbWIH+dfXWijR3oDHw0v
	 SOAnpYhKi16IaPGcIBjRaTPHJZ3lXhPKir+VCWxuJMWv+R/mPTRQX3sKdxeRLzmQTG
	 /W+5VROMjefkpvMBCmhbYg8hTjD3o9ydtBOmEvFQoyuGwJt5OIkikKTPDE4fqEuDzC
	 3VquB+1izvFQw==
Date: Sat, 15 Jun 2024 11:50:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Matti Vaittinen
 <mazziesaccount@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix condition for own trigger
Message-ID: <20240615115018.2b73d6b3@jic23-huawei>
In-Reply-To: <20240614143658.3531097-1-jpaulo.silvagoncalves@gmail.com>
References: <20240614143658.3531097-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 11:36:58 -0300
Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.com> wrote:

> From: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
>=20
> The condition for checking if triggers belong to the same IIO device to
> set attached_own_device is currently inverted, causing
> iio_trigger_using_own() to return an incorrect value. Fix it by testing
> for the correct return value of iio_validate_own_trigger().
>=20
> Cc: stable@vger.kernel.org
> Fixes: 517985ebc531 ("iio: trigger: Add simple trigger_validation helper")
> Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>

Ouch.  Can you give an example of resulting user visible result? That
will help people decide whether to pick this up for their distro kernels
etc.  In some cases, looks like we'll get garbage timestamps and in others
may get stale data (or garbage).

Odd no one has noticed this in the past whilst testing those dependent
features in particular drivers and I worry a little that we may have bugs
in the users as a result of iio_trigger_using_own() reporting the inverse
of the intended. I've take a quick look at the users and 'think' they are
ok, but would definitely like a few others to confirm.

Also on a practical basis I just sent a fixes pull request so this one
probably won't go anywhere for a week or so anyway so we have time.

> ---
>  drivers/iio/industrialio-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index 16de57846bd9..2e84776f4fbd 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -315,7 +315,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *=
trig,
>  	 * this is the case if the IIO device and the trigger device share the
>  	 * same parent device.
>  	 */
> -	if (iio_validate_own_trigger(pf->indio_dev, trig))
> +	if (!iio_validate_own_trigger(pf->indio_dev, trig))
>  		trig->attached_own_device =3D true;
>=20
>  	return ret;
> --
> 2.34.1


