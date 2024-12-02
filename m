Return-Path: <stable+bounces-96003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F26A9E01D1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042DB285307
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0224B1FECD2;
	Mon,  2 Dec 2024 12:06:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C21FE46C;
	Mon,  2 Dec 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141216; cv=none; b=Mq4lBB6LjnM4ZPCbGVVyMbd+n6xlmavrVS8ok9Wur2/TlDilPPgE3UsNAXBigcFeAfNNY1B/mvYP7bTOUY4jTp4YG7qFelp78YrdKDSxoH5PW4lssJQ1udKOmVE/Wm2N1KzwVhK+jN8h9P8YlpU0DlA2Nz46CcTzV4z7K/HTPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141216; c=relaxed/simple;
	bh=/NJEki+b5/NQQfsKxs1+I4KchZ8MKAhP9Vdvy1eej6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H18wdb4EeyAeNd4Ic0AZzEv1fFAuAn/bXL/MLCqChrXr+m2RG60qTE18SSlaENRv222AXlIEDIyK53eOkqfNWTU+COZGO2EG5yqE6H0vQC6cnLN4I+a/G7FX99+LizlkdMu6tMUUtj+IRRRvKym6Gl+Qv2oDiLloffJlqLqBGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 14BD51C00CD; Mon,  2 Dec 2024 13:06:53 +0100 (CET)
Date: Mon, 2 Dec 2024 13:06:52 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, rdunlap@infradead.org,
	paulmck@kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 2/2] timekeeping: Always check for negative
 motion
Message-ID: <Z02i3MxY7JEJfgQ4@duo.ucw.cz>
References: <20241124124733.3338551-1-sashal@kernel.org>
 <20241124124733.3338551-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mu3/zcq+hBBdqq0s"
Content-Disposition: inline
In-Reply-To: <20241124124733.3338551-2-sashal@kernel.org>


--mu3/zcq+hBBdqq0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit c163e40af9b2331b2c629fd4ec8b703ed4d4ae39 ]
>=20
> clocksource_delta() has two variants. One with a check for negative motio=
n,
> which is only selected by x86. This is a historic leftover as this functi=
on
> was previously used in the time getter hot paths.
>=20
> Since 135225a363ae timekeeping_cycles_to_ns() has unconditional protection
> against this as a by-product of the protection against 64bit math
> overflow.
> timekeeping_advance(). The extra conditional there is not hurting anyone.

We don't have 135225a363ae in 5.10. So we probably should not have
this?

Best regards,
								Pavel

> +++ b/arch/x86/Kconfig
> @@ -107,7 +107,6 @@ config X86
>  	select ARCH_WANTS_THP_SWAP		if X86_64
>  	select BUILDTIME_TABLE_SORT
>  	select CLKEVT_I8253
> -	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
>  	select CLOCKSOURCE_WATCHDOG
>  	select DCACHE_WORD_ACCESS
>  	select EDAC_ATOMIC_SCRUB
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index a09b1d61df6a5..5cbedc0a06efc 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -17,11 +17,6 @@ config ARCH_CLOCKSOURCE_DATA
>  config ARCH_CLOCKSOURCE_INIT
>  	bool
> =20
> -# Clocksources require validation of the clocksource against the last
> -# cycle update - x86/TSC misfeature
> -config CLOCKSOURCE_VALIDATE_LAST_CYCLE
> -	bool
> -
>  # Timekeeping vsyscall support
>  config GENERIC_TIME_VSYSCALL
>  	bool
> diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping=
_internal.h
> index 4ca2787d1642e..1d4854d5c386e 100644
> --- a/kernel/time/timekeeping_internal.h
> +++ b/kernel/time/timekeeping_internal.h
> @@ -15,7 +15,6 @@ extern void tk_debug_account_sleep_time(const struct ti=
mespec64 *t);
>  #define tk_debug_account_sleep_time(x)
>  #endif
> =20
> -#ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
>  static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
>  {
>  	u64 ret =3D (now - last) & mask;
> @@ -26,12 +25,6 @@ static inline u64 clocksource_delta(u64 now, u64 last,=
 u64 mask)
>  	 */
>  	return ret & ~(mask >> 1) ? 0 : ret;
>  }
> -#else
> -static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
> -{
> -	return (now - last) & mask;
> -}
> -#endif
> =20
>  /* Semi public for serialization of non timekeeper VDSO updates. */
>  extern raw_spinlock_t timekeeper_lock;

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mu3/zcq+hBBdqq0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02i3AAKCRAw5/Bqldv6
8vHwAJ9b5+dkxAbMdcnFOJ+/sy9vrHaySQCeNf2QVkHmWLNyMN2g+x0P1HoleCY=
=TzYU
-----END PGP SIGNATURE-----

--mu3/zcq+hBBdqq0s--

