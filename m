Return-Path: <stable+bounces-25447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69086BB64
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 23:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DD5B212DF
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 22:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7476F06;
	Wed, 28 Feb 2024 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VYXwrRpH"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2C76EEC;
	Wed, 28 Feb 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161138; cv=none; b=IgUcp2X6umGgcF1Xmax0wsM34u2TvUIw2x5xdycD6ioX37hI3f8IeiFqXWpw4eKwsROO0XQyP7D2blzz0riHspNly2U09YcfV4QC9q0aAz0ZtUecoZYl47EIFA7Qi+4tBubP0QcqvN8fmz710jgaj/21zGfp/vL2IQ6LcW5MP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161138; c=relaxed/simple;
	bh=ZuIJTceCtZ2xSuE9RAflMaDB1tn1/NCs2BITgHRDVWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lIx7EkAu4+6uF0N2/j7gTrBz1zGBmY5fu1ZznbQI160qAgJ63sFyyRN1wLgCbwpkfzgP7e2js98fvpbtSLSw9TKLPmtz6cfSb3XD91NjntlTMeQSUut//CLQULmqwsIRq3cp4Y8hGnUCIOgRt1vH4+v2AbcRJH5ppCg2jUnKgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VYXwrRpH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 95885418B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709161135; bh=bMQo17aK5IXMuIY8jqYlZuQKMdqgCIgA46aWjm0/nSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VYXwrRpHFQ6ml2TODjNhVttcrfUEx3DPssenggkI3hzswGMnK8ZJXrZPXbHdXF6Yb
	 rgByaD95z/FRLtkv24KMv356Qnvdy6KeH05zlsyu0AD6Q5ODXsQnUmoADc1w9UBrus
	 bNOOeQhkqiBRyqA8KnKg3Cv0rLKH9mjLBDd11AeZeKhFiRREDUgHiWuf4O+Cfe5LHt
	 BLQWu1hfF3Yp0ec3uj8JwVcoymwKytFIBauig4AWHdastX51T6XqSxGWj4kIK9GxAk
	 7yH8E6UiVpQloXcXUvp1W8Gq2faaaHBUUrugUF/KeovJFlBZ11i4SD5U2F8WsxuaqZ
	 4efrguHDQ/6Eg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 95885418B5;
	Wed, 28 Feb 2024 22:58:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
Cc: Akira Yokosawa <akiyks@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] docs: Restore "smart quotes" for quotes
In-Reply-To: <20240225094600.65628-1-akiyks@gmail.com>
References: <20240225094600.65628-1-akiyks@gmail.com>
Date: Wed, 28 Feb 2024 15:58:54 -0700
Message-ID: <8734tcp55d.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Akira Yokosawa <akiyks@gmail.com> writes:

> Commit eaae75754d81 ("docs: turn off "smart quotes" in the HTML build")
> disabled conversion of quote marks along with that of dashes.
> Despite the short summary, the change affects not only HTML build
> but also other build targets including PDF.
>
> However, as "smart quotes" had been enabled for more than half a
> decade already, quite a few readers of HTML pages are likely expecting
> conversions of "foo" -> =E2=80=9Cfoo=E2=80=9D and 'bar' -> =E2=80=98bar=
=E2=80=99.
>
> Furthermore, in LaTeX typesetting convention, it is common to use
> distinct marks for opening and closing quote marks.
>
> To satisfy such readers' expectation, restore conversion of quotes
> only by setting smartquotes_action [1].
>
> Link: [1] https://www.sphinx-doc.org/en/master/usage/configuration.html#c=
onfval-smartquotes_action
> Cc: stable@vger.kernel.org  # v6.4
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
>  Documentation/conf.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index da64c9fb7e07..d148f3e8dd57 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -346,9 +346,9 @@ sys.stderr.write("Using %s theme\n" % html_theme)
>  html_static_path =3D ['sphinx-static']
>=20=20
>  # If true, Docutils "smart quotes" will be used to convert quotes and da=
shes
> -# to typographically correct entities.  This will convert "--" to "=E2=
=80=94",
> -# which is not always what we want, so disable it.
> -smartquotes =3D False
> +# to typographically correct entities.  However, conversion of "--" to "=
=E2=80=94"
> +# is not always what we want, so enable only quotes.
> +smartquotes_action =3D 'q'
>=20=20

Applied, thanks.

jon

