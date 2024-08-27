Return-Path: <stable+bounces-70334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA8960A10
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371411C20F53
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3191B5EC7;
	Tue, 27 Aug 2024 12:25:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17281B5EBE;
	Tue, 27 Aug 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761509; cv=none; b=dVcFigztO5bYrGeOF51HfSTKXBeo91r89bfpyhMXR61iuJKd4WjkShHOVPM/U2QvC5CrqfUw8SxkxqsMfEKcO/RuhxlvQvxogsIpHvLzq6cil5/EGq2kk3JD23XlqwGhMEjIVgz3vrvpjiTdAiR25f+xg+MHgApUCfMPN8nmKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761509; c=relaxed/simple;
	bh=p1mwGYvxLR5MGl2Xb7+ax17YlPahUpnD9DKyKuWMrTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1P3y9ggBNj2ZrJbaycWBg/yv1VFAlGPX0CptkRNbMbFgf3qHihz7Qjms9R4uVpZe7AWoSI6HJ5NLMpqNdrYpnvfzFZSiuXJiBVjKooXrpQJW/9D5rdDgsLEH9LSDJCns52ZyVkd7UHeqeC1SBLRVO4Xa/+ryUMRlmXcwHFLauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E5B9F1C009B; Tue, 27 Aug 2024 14:25:05 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:25:05 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Richard Maina <quic_rmaina@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Chris Lew <quic_clew@quicinc.com>, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, corbet@lwn.net,
	linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 20/38] hwspinlock: Introduce
 hwspin_lock_bust()
Message-ID: <Zs3FoWRIIJtkJ3JL@duo.ucw.cz>
References: <20240801003643.3938534-1-sashal@kernel.org>
 <20240801003643.3938534-20-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SbUCcGMKf4utf5NG"
Content-Disposition: inline
In-Reply-To: <20240801003643.3938534-20-sashal@kernel.org>


--SbUCcGMKf4utf5NG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> From: Richard Maina <quic_rmaina@quicinc.com>
>=20
> [ Upstream commit 7c327d56597d8de1680cf24e956b704270d3d84a ]
>=20
> When a remoteproc crashes or goes down unexpectedly this can result in
> a state where locks held by the remoteproc will remain locked possibly
> resulting in deadlock. This new API hwspin_lock_bust() allows
> hwspinlock implementers to define a bust operation for freeing previously
> acquired hwspinlocks after verifying ownership of the acquired lock.

This adds unused infrastructure to -stable. Please drop.

Best regards,
									Pavel

> +++ b/Documentation/locking/hwspinlock.rst
> @@ -85,6 +85,17 @@ is already free).
> =20
>  Should be called from a process context (might sleep).
> =20
> +::
> +
> +  int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);
> +
> +After verifying the owner of the hwspinlock, release a previously acquir=
ed
> +hwspinlock; returns 0 on success, or an appropriate error code on failure
> +(e.g. -EOPNOTSUPP if the bust operation is not defined for the specific
> +hwspinlock).
> +
> +Should be called from a process context (might sleep).
> +
>  ::
> =20
>    int hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int timeou=
t);
> diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hw=
spinlock_core.c
> index fd5f5c5a5244d..425597151dd3e 100644
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -302,6 +302,34 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int =
mode, unsigned long *flags)
>  }
>  EXPORT_SYMBOL_GPL(__hwspin_unlock);
> =20
> +/**
> + * hwspin_lock_bust() - bust a specific hwspinlock
> + * @hwlock: a previously-acquired hwspinlock which we want to bust
> + * @id: identifier of the remote lock holder, if applicable
> + *
> + * This function will bust a hwspinlock that was previously acquired as
> + * long as the current owner of the lock matches the id given by the cal=
ler.
> + *
> + * Context: Process context.
> + *
> + * Returns: 0 on success, or -EINVAL if the hwspinlock does not exist, or
> + * the bust operation fails, and -EOPNOTSUPP if the bust operation is not
> + * defined for the hwspinlock.
> + */
> +int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id)
> +{
> +	if (WARN_ON(!hwlock))
> +		return -EINVAL;
> +
> +	if (!hwlock->bank->ops->bust) {
> +		pr_err("bust operation not defined\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return hwlock->bank->ops->bust(hwlock, id);
> +}
> +EXPORT_SYMBOL_GPL(hwspin_lock_bust);
> +
>  /**
>   * of_hwspin_lock_simple_xlate - translate hwlock_spec to return a lock =
id
>   * @bank: the hwspinlock device bank
> diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinloc=
k/hwspinlock_internal.h
> index 29892767bb7a0..f298fc0ee5adb 100644
> --- a/drivers/hwspinlock/hwspinlock_internal.h
> +++ b/drivers/hwspinlock/hwspinlock_internal.h
> @@ -21,6 +21,8 @@ struct hwspinlock_device;
>   * @trylock: make a single attempt to take the lock. returns 0 on
>   *	     failure and true on success. may _not_ sleep.
>   * @unlock:  release the lock. always succeed. may _not_ sleep.
> + * @bust:    optional, platform-specific bust handler, called by hwspinl=
ock
> + *	     core to bust a specific lock.
>   * @relax:   optional, platform-specific relax handler, called by hwspin=
lock
>   *	     core while spinning on a lock, between two successive
>   *	     invocations of @trylock. may _not_ sleep.
> @@ -28,6 +30,7 @@ struct hwspinlock_device;
>  struct hwspinlock_ops {
>  	int (*trylock)(struct hwspinlock *lock);
>  	void (*unlock)(struct hwspinlock *lock);
> +	int (*bust)(struct hwspinlock *lock, unsigned int id);
>  	void (*relax)(struct hwspinlock *lock);
>  };
> =20
> diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
> index bfe7c1f1ac6d1..f0231dbc47771 100644
> --- a/include/linux/hwspinlock.h
> +++ b/include/linux/hwspinlock.h
> @@ -68,6 +68,7 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned=
 int, int,
>  int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
>  void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
>  int of_hwspin_lock_get_id_byname(struct device_node *np, const char *nam=
e);
> +int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);
>  int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock);
>  struct hwspinlock *devm_hwspin_lock_request(struct device *dev);
>  struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
> @@ -127,6 +128,11 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int =
mode, unsigned long *flags)
>  {
>  }
> =20
> +static inline int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned i=
nt id)
> +{
> +	return 0;
> +}
> +
>  static inline int of_hwspin_lock_get_id(struct device_node *np, int inde=
x)
>  {
>  	return 0;

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SbUCcGMKf4utf5NG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3FoQAKCRAw5/Bqldv6
8mvxAJ9LkBphkQB5ck5R8qhhbpxWrj5PDgCbB2mauOcjLtAnkXLW+e9PgFbtd5w=
=qLwo
-----END PGP SIGNATURE-----

--SbUCcGMKf4utf5NG--

