Return-Path: <stable+bounces-148153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5403AC8B83
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 11:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60A51BA4739
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC121E082;
	Fri, 30 May 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KA15+su1"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0C78F59
	for <stable@vger.kernel.org>; Fri, 30 May 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598997; cv=none; b=ohSRnaqziEXFOSJVVNrhc7+XDhYAirU1MB2q4b8gwNgENmCLzWYsEnaQz+gWyEN/ErsiZ8DkE4S0LKexJBJpeD3pbOXT48YLbzSMo+w62jY15Pg1YesMGXhKpWAsDTlaWSOk9Q1GFy3vstj7SURD+PGvVVJRgvPmKRBc6+i5UzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598997; c=relaxed/simple;
	bh=97uZXwCbMzjtNiv+xCxbvzriM0FY2toOMbIEnIjQrFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlyBPbIn26MSGMn4qHb/kH4ThPu7/qo0zWWhNDxDA9bi713fnXSAjnj+TIWk7BXpebRNOeW4cKhi03CPiAFvlbFAdlvyLa7JWcFgMl+71i6G8NTK1z5I8Q7nRrP7uVAxA/c7OlqW+G9YzrrKY6hx4YuHhhgjOtSmF+blR5iwG2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KA15+su1; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC4E9103972A6;
	Fri, 30 May 2025 11:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748598993; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kRELN26s0aAmuJoO+DiSWkxsO0ilowOEJFYK5+KpCCQ=;
	b=KA15+su1XL3IdS4aXSxId93/ZGSak5ut1JNyz48ofvbjLWg7Jj6yqErONENPdQEAaYEho1
	COJEwHEVka+hoqMSacntczBaVSco4mODwObMxpiyMd/LB+yC/ZF6K1JO8Rff1y6LUE26Px
	ok1PtqdSjFk4L/0sTMOn3wXlEZ+//LzJck0aLUfi9YxBmGEdWksf1Pn+KKwtbR9fFPrde9
	x8PNA5gaSa3rMgyv0e4hEMBsXavOY5xHfob22gkxtZQFawFdsXCaJawRkMXwwWHpPXqRVT
	T4puLlh8DQmitMyXcHpHF3il2ZngPFG7WpIWkyAHtRkPexiB1BYjDimDhR3Xhw==
Date: Fri, 30 May 2025 11:56:29 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.12 620/626] serial: sh-sci: Save and restore more
 registers
Message-ID: <aDmAzfFcDdRPQXf5@duo.ucw.cz>
References: <20250527162445.028718347@linuxfoundation.org>
 <20250527162510.188701315@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1b5UNz4O3p+LzBKK"
Content-Disposition: inline
In-Reply-To: <20250527162510.188701315@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--1b5UNz4O3p+LzBKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 6.12-stable review patch.  If anyone has any objections, please let me kn=
ow.

Something went wrong with the scripts here:

> Fixes: 22a6984c5b5df8ea ("serial: sh-sci: Update the suspend/resume suppo=
rt")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link: https://lore.kernel.org/r/11c2eab45d48211e75d8b8202cce60400880fe55.=
1741114989.git.geert+renesas@glider.be
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

We should not really have two sign-offs in a row.

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1b5UNz4O3p+LzBKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaDmAzQAKCRAw5/Bqldv6
8vYTAJirnapQkrsnfcSFphf7Zd/My2xLAJ44CPF4+T2OsXPDmMuJ7mXCQdPDQQ==
=fCn0
-----END PGP SIGNATURE-----

--1b5UNz4O3p+LzBKK--

