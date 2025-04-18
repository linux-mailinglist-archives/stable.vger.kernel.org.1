Return-Path: <stable+bounces-134633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B8A93B97
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8943A3A7768
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FB9219A8D;
	Fri, 18 Apr 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZTta/6gI"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D112144D6;
	Fri, 18 Apr 2025 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995697; cv=none; b=J7FcOQabwu6y/b/WAduNHz8JizEp+3kCLizclOMrV4koZZFJkgFtccBbQs2OFiXyY5pIwf4xAAFL7zq+7YfQenNTqjiB6CDIX6M5Gy44y+NRgFBN1OjcRyD+B1XWDWC9g214Rdidwzv2aRuzMCj469MC13DBI9DuvlKoXXCRGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995697; c=relaxed/simple;
	bh=oI+EaJPKASRaj7ZktB84nugSnxLbHdpW/DC7Ynxq2b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqwkvH5J95h+nBQFpJL1FSLm+hHrT/tQo/5/O9VcrpSLk0vsYFn4faMjOsALNKGLGAxwAImZfDWGEiEn2LguL/nGUJ6yGq9leYIT67tLBSGmCG+WcrzRa9WJJRqHyoCYVXXUtCQ+K9hSvKCEt0FSZF/klGtqM9/TrZa9O1BKu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZTta/6gI; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91FAB101BF2CB;
	Fri, 18 Apr 2025 19:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744995692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tBWiIVtzQkFeHoj4T9tvDBw4U0JfIJ9IFgfClrd78xY=;
	b=ZTta/6gIatx/2uKRev0Lo3JfA6NTfSrNlGjUkaEApTJ5CPR8pAmVVlJruzwF/8ERax+qyu
	nwmQ1jXCPb5HUcudTgnZskN5oKszxyfOI0/tT0MA5sjOGV2a0OuI7tD/QXNU/jra9Cuz8F
	/T6w6oeBtTZFGoOsv9E2QhBTtRA+WmAaYrdvIjw3qokrhv6T0ouxsnbomlHjDkWsZsViqs
	R1UkQiGoFPI2cZT1QVhWXjCIFy+o6U7p3EK9w6cjghuSQdIlSdejnsSIRQLpjMlHhT5Z60
	gY1jJGXv9CkRZzZvxdHB0Yx/dCJ7HaqotiKNSkdHaCS10eSDHevHSVFciD/pXQ==
Date: Fri, 18 Apr 2025 19:01:25 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	aleksander.lobakin@intel.com, kory.maincent@bootlin.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 13/15] net: vlan: don't propagate flags on
 open
Message-ID: <aAKFZT6sPCZX63y6@duo.ucw.cz>
References: <20250403191002.2678588-1-sashal@kernel.org>
 <20250403191002.2678588-13-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bC8Y275hHWkIX4eN"
Content-Disposition: inline
In-Reply-To: <20250403191002.2678588-13-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--bC8Y275hHWkIX4eN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2025-04-03 15:10:00, Sasha Levin wrote:
> From: Stanislav Fomichev <sdf@fomichev.me>
>=20
> [ Upstream commit 27b918007d96402aba10ed52a6af8015230f1793 ]
>=20
> With the device instance lock, there is now a possibility of a deadlock:

"now". Does the same problem exist in 5.10?

Best regards,
								Pavel

> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -272,17 +272,6 @@ static int vlan_dev_open(struct net_device *dev)
>  			goto out;
>  	}
> =20
> -	if (dev->flags & IFF_ALLMULTI) {
> -		err =3D dev_set_allmulti(real_dev, 1);
> -		if (err < 0)
> -			goto del_unicast;
> -	}
> -	if (dev->flags & IFF_PROMISC) {
> -		err =3D dev_set_promiscuity(real_dev, 1);
> -		if (err < 0)
> -			goto clear_allmulti;
> -	}
> -
>  	ether_addr_copy(vlan->real_dev_addr, real_dev->dev_addr);
> =20
>  	if (vlan->flags & VLAN_FLAG_GVRP)
> @@ -296,12 +285,6 @@ static int vlan_dev_open(struct net_device *dev)
>  		netif_carrier_on(dev);
>  	return 0;
> =20
> -clear_allmulti:
> -	if (dev->flags & IFF_ALLMULTI)
> -		dev_set_allmulti(real_dev, -1);
> -del_unicast:
> -	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
> -		dev_uc_del(real_dev, dev->dev_addr);
>  out:
>  	netif_carrier_off(dev);
>  	return err;
> @@ -314,10 +297,6 @@ static int vlan_dev_stop(struct net_device *dev)
> =20
>  	dev_mc_unsync(real_dev, dev);
>  	dev_uc_unsync(real_dev, dev);
> -	if (dev->flags & IFF_ALLMULTI)
> -		dev_set_allmulti(real_dev, -1);
> -	if (dev->flags & IFF_PROMISC)
> -		dev_set_promiscuity(real_dev, -1);
> =20
>  	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
>  		dev_uc_del(real_dev, dev->dev_addr);
> @@ -474,12 +453,10 @@ static void vlan_dev_change_rx_flags(struct net_dev=
ice *dev, int change)
>  {
>  	struct net_device *real_dev =3D vlan_dev_priv(dev)->real_dev;
> =20
> -	if (dev->flags & IFF_UP) {
> -		if (change & IFF_ALLMULTI)
> -			dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
> -		if (change & IFF_PROMISC)
> -			dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
> -	}
> +	if (change & IFF_ALLMULTI)
> +		dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
> +	if (change & IFF_PROMISC)
> +		dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
>  }
> =20
>  static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bC8Y275hHWkIX4eN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAKFZQAKCRAw5/Bqldv6
8kP0AKDB9qbJiZzzNyzkREcjPbqHR+RpRgCgmExl2z2MS8hgpfFzPz8xpNPeFPM=
=S3W+
-----END PGP SIGNATURE-----

--bC8Y275hHWkIX4eN--

