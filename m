Return-Path: <stable+bounces-95322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4739D76B1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21142833E6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59471126BFF;
	Sun, 24 Nov 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="oKdyp31C"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511A6BFCA;
	Sun, 24 Nov 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469328; cv=none; b=PEm+xqeSERnZz4K+eQtNq+UYFq+tiHbGegNTPN0+TFRLeVYq/weMCUBG8WrU8wSIeEsz55mkYkZRzwMPRl7jUJTI0/kZf6w7f7E5F80bJMnIpETWJI2i6PjDp4LiOI0HNy4VY7N6ZRG4IP4XZdIJNLo2+dDehDK+GelQwBjGoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469328; c=relaxed/simple;
	bh=23YXZvXSvlYMAH/LpaMhZqwM2pEkhpubyUmRPL8IVsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRwTQJ0VXgpU53GYbem8ugi3S4zV8xNeio7I/zTi+XlxI7h8pSJLq2AbfsxJlyQyUp77YMPjxz7aSPqGOR3nSKtWr2WkvZ9BI35k2Ups33r92mA7kd7DKMU6AhFUmPHun407pfCXt6uk9CIw/78nOmDcF/U03l/uVKkRRYzLuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=oKdyp31C; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 116E11C00A0; Sun, 24 Nov 2024 18:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1732469315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Epemhhjoi2Dlp4oRqy52RRl1XF2wcWjGQEYsNh/wVpM=;
	b=oKdyp31CT2If5C2rcRnSV2riJik/IBBTQywAYtYF3zxDQICoPmBZ2Rzt2v19T1vKlzX0+I
	Cc+GOdR8WSPDiwcWF6/zVC5gsPshpkwHBNhQe4wzYVWsXnZSCkALVooldcMy/6jVwUUfRF
	dYS9sgFZxsJDgKCB4XN24rBpyGPQIX0=
Date: Sun, 24 Nov 2024 18:28:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 01/15] xfrm: extract dst lookup parameters
 into a struct
Message-ID: <Z0NiQk76qhCMpg6M@duo.ucw.cz>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2agmBltyen3f0m4S"
Content-Disposition: inline
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>


--2agmBltyen3f0m4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit e509996b16728e37d5a909a5c63c1bd64f23b306 ]
>=20
> Preparation for adding more fields to dst lookup functions without
> changing their signatures.
>=20
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This does not sound like a bugfix.

BR,
								Pavel

>  include/net/xfrm.h      | 26 +++++++++++++-------------
>  net/ipv4/xfrm4_policy.c | 38 ++++++++++++++++----------------------
>  net/ipv6/xfrm6_policy.c | 28 +++++++++++++---------------
>  net/xfrm/xfrm_device.c  | 11 ++++++++---
>  net/xfrm/xfrm_policy.c  | 35 +++++++++++++++++++++++------------
>  5 files changed, 73 insertions(+), 65 deletions(-)
>=20
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index b280e7c460116..93207d87e1c7f 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -342,20 +342,23 @@ struct xfrm_if_cb {
>  void xfrm_if_register_cb(const struct xfrm_if_cb *ifcb);
>  void xfrm_if_unregister_cb(void);
> =20
> +struct xfrm_dst_lookup_params {
> +	struct net *net;
> +	int tos;
> +	int oif;
> +	xfrm_address_t *saddr;
> +	xfrm_address_t *daddr;
> +	u32 mark;
> +};
> +
>  struct net_device;
>  struct xfrm_type;
>  struct xfrm_dst;
>  struct xfrm_policy_afinfo {
>  	struct dst_ops		*dst_ops;
> -	struct dst_entry	*(*dst_lookup)(struct net *net,
> -					       int tos, int oif,
> -					       const xfrm_address_t *saddr,
> -					       const xfrm_address_t *daddr,
> -					       u32 mark);
> -	int			(*get_saddr)(struct net *net, int oif,
> -					     xfrm_address_t *saddr,
> -					     xfrm_address_t *daddr,
> -					     u32 mark);
> +	struct dst_entry	*(*dst_lookup)(const struct xfrm_dst_lookup_params *pa=
rams);
> +	int			(*get_saddr)(xfrm_address_t *saddr,
> +					     const struct xfrm_dst_lookup_params *params);
>  	int			(*fill_dst)(struct xfrm_dst *xdst,
>  					    struct net_device *dev,
>  					    const struct flowi *fl);
> @@ -1728,10 +1731,7 @@ static inline int xfrm_user_policy(struct sock *sk=
, int optname,
>  }
>  #endif
> =20
> -struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
> -				    const xfrm_address_t *saddr,
> -				    const xfrm_address_t *daddr,
> -				    int family, u32 mark);
> +struct dst_entry *__xfrm_dst_lookup(int family, const struct xfrm_dst_lo=
okup_params *params);
> =20
>  struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp);
> =20
> diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
> index c33bca2c38415..01d4f6f4dbb8c 100644
> --- a/net/ipv4/xfrm4_policy.c
> +++ b/net/ipv4/xfrm4_policy.c
> @@ -17,47 +17,41 @@
>  #include <net/ip.h>
>  #include <net/l3mdev.h>
> =20
> -static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flow=
i4 *fl4,
> -					    int tos, int oif,
> -					    const xfrm_address_t *saddr,
> -					    const xfrm_address_t *daddr,
> -					    u32 mark)
> +static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
> +					    const struct xfrm_dst_lookup_params *params)
>  {
>  	struct rtable *rt;
> =20
>  	memset(fl4, 0, sizeof(*fl4));
> -	fl4->daddr =3D daddr->a4;
> -	fl4->flowi4_tos =3D tos;
> -	fl4->flowi4_l3mdev =3D l3mdev_master_ifindex_by_index(net, oif);
> -	fl4->flowi4_mark =3D mark;
> -	if (saddr)
> -		fl4->saddr =3D saddr->a4;
> -
> -	rt =3D __ip_route_output_key(net, fl4);
> +	fl4->daddr =3D params->daddr->a4;
> +	fl4->flowi4_tos =3D params->tos;
> +	fl4->flowi4_l3mdev =3D l3mdev_master_ifindex_by_index(params->net,
> +							    params->oif);
> +	fl4->flowi4_mark =3D params->mark;
> +	if (params->saddr)
> +		fl4->saddr =3D params->saddr->a4;
> +
> +	rt =3D __ip_route_output_key(params->net, fl4);
>  	if (!IS_ERR(rt))
>  		return &rt->dst;
> =20
>  	return ERR_CAST(rt);
>  }
> =20
> -static struct dst_entry *xfrm4_dst_lookup(struct net *net, int tos, int =
oif,
> -					  const xfrm_address_t *saddr,
> -					  const xfrm_address_t *daddr,
> -					  u32 mark)
> +static struct dst_entry *xfrm4_dst_lookup(const struct xfrm_dst_lookup_p=
arams *params)
>  {
>  	struct flowi4 fl4;
> =20
> -	return __xfrm4_dst_lookup(net, &fl4, tos, oif, saddr, daddr, mark);
> +	return __xfrm4_dst_lookup(&fl4, params);
>  }
> =20
> -static int xfrm4_get_saddr(struct net *net, int oif,
> -			   xfrm_address_t *saddr, xfrm_address_t *daddr,
> -			   u32 mark)
> +static int xfrm4_get_saddr(xfrm_address_t *saddr,
> +			   const struct xfrm_dst_lookup_params *params)
>  {
>  	struct dst_entry *dst;
>  	struct flowi4 fl4;
> =20
> -	dst =3D __xfrm4_dst_lookup(net, &fl4, 0, oif, NULL, daddr, mark);
> +	dst =3D __xfrm4_dst_lookup(&fl4, params);
>  	if (IS_ERR(dst))
>  		return -EHOSTUNREACH;
> =20
> diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> index 444b0b4469a49..246a0cea77c26 100644
> --- a/net/ipv6/xfrm6_policy.c
> +++ b/net/ipv6/xfrm6_policy.c
> @@ -23,23 +23,21 @@
>  #include <net/ip6_route.h>
>  #include <net/l3mdev.h>
> =20
> -static struct dst_entry *xfrm6_dst_lookup(struct net *net, int tos, int =
oif,
> -					  const xfrm_address_t *saddr,
> -					  const xfrm_address_t *daddr,
> -					  u32 mark)
> +static struct dst_entry *xfrm6_dst_lookup(const struct xfrm_dst_lookup_p=
arams *params)
>  {
>  	struct flowi6 fl6;
>  	struct dst_entry *dst;
>  	int err;
> =20
>  	memset(&fl6, 0, sizeof(fl6));
> -	fl6.flowi6_l3mdev =3D l3mdev_master_ifindex_by_index(net, oif);
> -	fl6.flowi6_mark =3D mark;
> -	memcpy(&fl6.daddr, daddr, sizeof(fl6.daddr));
> -	if (saddr)
> -		memcpy(&fl6.saddr, saddr, sizeof(fl6.saddr));
> +	fl6.flowi6_l3mdev =3D l3mdev_master_ifindex_by_index(params->net,
> +							   params->oif);
> +	fl6.flowi6_mark =3D params->mark;
> +	memcpy(&fl6.daddr, params->daddr, sizeof(fl6.daddr));
> +	if (params->saddr)
> +		memcpy(&fl6.saddr, params->saddr, sizeof(fl6.saddr));
> =20
> -	dst =3D ip6_route_output(net, NULL, &fl6);
> +	dst =3D ip6_route_output(params->net, NULL, &fl6);
> =20
>  	err =3D dst->error;
>  	if (dst->error) {
> @@ -50,15 +48,14 @@ static struct dst_entry *xfrm6_dst_lookup(struct net =
*net, int tos, int oif,
>  	return dst;
>  }
> =20
> -static int xfrm6_get_saddr(struct net *net, int oif,
> -			   xfrm_address_t *saddr, xfrm_address_t *daddr,
> -			   u32 mark)
> +static int xfrm6_get_saddr(xfrm_address_t *saddr,
> +			   const struct xfrm_dst_lookup_params *params)
>  {
>  	struct dst_entry *dst;
>  	struct net_device *dev;
>  	struct inet6_dev *idev;
> =20
> -	dst =3D xfrm6_dst_lookup(net, 0, oif, NULL, daddr, mark);
> +	dst =3D xfrm6_dst_lookup(params);
>  	if (IS_ERR(dst))
>  		return -EHOSTUNREACH;
> =20
> @@ -68,7 +65,8 @@ static int xfrm6_get_saddr(struct net *net, int oif,
>  		return -EHOSTUNREACH;
>  	}
>  	dev =3D idev->dev;
> -	ipv6_dev_get_saddr(dev_net(dev), dev, &daddr->in6, 0, &saddr->in6);
> +	ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
> +			   &saddr->in6);
>  	dst_release(dst);
>  	return 0;
>  }
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 6346690d5c699..04dc0c8a83707 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -263,6 +263,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_s=
tate *x,
> =20
>  	dev =3D dev_get_by_index(net, xuo->ifindex);
>  	if (!dev) {
> +		struct xfrm_dst_lookup_params params;
> +
>  		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
>  			saddr =3D &x->props.saddr;
>  			daddr =3D &x->id.daddr;
> @@ -271,9 +273,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_=
state *x,
>  			daddr =3D &x->props.saddr;
>  		}
> =20
> -		dst =3D __xfrm_dst_lookup(net, 0, 0, saddr, daddr,
> -					x->props.family,
> -					xfrm_smark_get(0, x));
> +		memset(&params, 0, sizeof(params));
> +		params.net =3D net;
> +		params.saddr =3D saddr;
> +		params.daddr =3D daddr;
> +		params.mark =3D xfrm_smark_get(0, x);
> +		dst =3D __xfrm_dst_lookup(x->props.family, &params);
>  		if (IS_ERR(dst))
>  			return (is_packet_offload) ? -EINVAL : 0;
> =20
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index b699cc2ec35ac..1395d3de1ec70 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -251,10 +251,8 @@ static const struct xfrm_if_cb *xfrm_if_get_cb(void)
>  	return rcu_dereference(xfrm_if_cb);
>  }
> =20
> -struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
> -				    const xfrm_address_t *saddr,
> -				    const xfrm_address_t *daddr,
> -				    int family, u32 mark)
> +struct dst_entry *__xfrm_dst_lookup(int family,
> +				    const struct xfrm_dst_lookup_params *params)
>  {
>  	const struct xfrm_policy_afinfo *afinfo;
>  	struct dst_entry *dst;
> @@ -263,7 +261,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, =
int tos, int oif,
>  	if (unlikely(afinfo =3D=3D NULL))
>  		return ERR_PTR(-EAFNOSUPPORT);
> =20
> -	dst =3D afinfo->dst_lookup(net, tos, oif, saddr, daddr, mark);
> +	dst =3D afinfo->dst_lookup(params);
> =20
>  	rcu_read_unlock();
> =20
> @@ -277,6 +275,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struc=
t xfrm_state *x,
>  						xfrm_address_t *prev_daddr,
>  						int family, u32 mark)
>  {
> +	struct xfrm_dst_lookup_params params;
>  	struct net *net =3D xs_net(x);
>  	xfrm_address_t *saddr =3D &x->props.saddr;
>  	xfrm_address_t *daddr =3D &x->id.daddr;
> @@ -291,7 +290,14 @@ static inline struct dst_entry *xfrm_dst_lookup(stru=
ct xfrm_state *x,
>  		daddr =3D x->coaddr;
>  	}
> =20
> -	dst =3D __xfrm_dst_lookup(net, tos, oif, saddr, daddr, family, mark);
> +	params.net =3D net;
> +	params.saddr =3D saddr;
> +	params.daddr =3D daddr;
> +	params.tos =3D tos;
> +	params.oif =3D oif;
> +	params.mark =3D mark;
> +
> +	dst =3D __xfrm_dst_lookup(family, &params);
> =20
>  	if (!IS_ERR(dst)) {
>  		if (prev_saddr !=3D saddr)
> @@ -2424,15 +2430,15 @@ int __xfrm_sk_clone_policy(struct sock *sk, const=
 struct sock *osk)
>  }
> =20
>  static int
> -xfrm_get_saddr(struct net *net, int oif, xfrm_address_t *local,
> -	       xfrm_address_t *remote, unsigned short family, u32 mark)
> +xfrm_get_saddr(unsigned short family, xfrm_address_t *saddr,
> +	       const struct xfrm_dst_lookup_params *params)
>  {
>  	int err;
>  	const struct xfrm_policy_afinfo *afinfo =3D xfrm_policy_get_afinfo(fami=
ly);
> =20
>  	if (unlikely(afinfo =3D=3D NULL))
>  		return -EINVAL;
> -	err =3D afinfo->get_saddr(net, oif, local, remote, mark);
> +	err =3D afinfo->get_saddr(saddr, params);
>  	rcu_read_unlock();
>  	return err;
>  }
> @@ -2461,9 +2467,14 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, =
const struct flowi *fl,
>  			remote =3D &tmpl->id.daddr;
>  			local =3D &tmpl->saddr;
>  			if (xfrm_addr_any(local, tmpl->encap_family)) {
> -				error =3D xfrm_get_saddr(net, fl->flowi_oif,
> -						       &tmp, remote,
> -						       tmpl->encap_family, 0);
> +				struct xfrm_dst_lookup_params params;
> +
> +				memset(&params, 0, sizeof(params));
> +				params.net =3D net;
> +				params.oif =3D fl->flowi_oif;
> +				params.daddr =3D remote;
> +				error =3D xfrm_get_saddr(tmpl->encap_family, &tmp,
> +						       &params);
>  				if (error)
>  					goto fail;
>  				local =3D &tmp;

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--2agmBltyen3f0m4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ0NiQgAKCRAw5/Bqldv6
8msyAJwIfrhkq2TAikDGuYdCIFjZZgmLugCgw78SCfODXuJpmrUZk+GUUBE2TUE=
=4fNE
-----END PGP SIGNATURE-----

--2agmBltyen3f0m4S--

