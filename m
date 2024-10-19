Return-Path: <stable+bounces-86892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4019A4B2A
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 06:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E0E283C1F
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 04:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9FC190684;
	Sat, 19 Oct 2024 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Mzjr68pZ"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302D2F2F;
	Sat, 19 Oct 2024 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729310640; cv=none; b=Oiy9kIjMCoLB53Z+ijl925nm1nLl/qxKVLMhti/8GBzeWAvWjBI2hYVF2WduXcJposTLm/wkrVrtN1aoScKHHkR+YXTH8JLFL3aosfpoYjMLeTQGyapp3IehQH4IAuoC8aa3QxVpHyik+00vYBc8NLGGToLF3bYabcYQ4I9tfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729310640; c=relaxed/simple;
	bh=Np6tb5qPcKgHyu5TaEn5jmf/fDwFMHtk6jUlAJFbDBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gg/HzU1On7YaBNZ39e2HVPtnTzAohptv2xP7ZzJg4Ghuld8qAPyyN+t/9Cd5LnTC6KRsWjSkIIRML+gIOqHI5AvvyQpdjQA96i0OT4HlprBDv0o8ThqosjSKMh6V+zteTT7cvK1bnT8sFqkvfR44sWZUun32Hvqx0OVwkqTR2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Mzjr68pZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729310630;
	bh=qd8jsyRLx7YstWWVlCZdtcvSwDMaz6hqBEQ9KqC4CRQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mzjr68pZ/ylolqykpBL+b+Lqleblww/4741u3+aT9e2oSEN4/Of6yf4o5xtbGaGd0
	 TW+DqzTWMQDIGl7p74FA/1j3ha1YVa98vGYI9EIWqfJ8UgmSo8jELdR71RCp5NTBEs
	 cJli6an6dkkUiko+ZVSIGN9kznOQ6NzdnarIiwFJUvhFo+kC/eNwDAy4OCs+FlUe+E
	 frdj0eqgv14V/RbMuyeqBqJSRGt6Nr7YDi0GuT7/k6NuC3ksDEk3fQuLXq5Rs4xhm0
	 SAW1P4M4NXG9m//7UrOOzvdDSJLkzVh4E3UJ+Gn/yICJV7qUVZmhZp594IYc1vkB7h
	 wd0r5ZrcZG33w==
Received: from [192.168.12.102] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 10FBB683FB;
	Sat, 19 Oct 2024 12:03:48 +0800 (AWST)
Message-ID: <e53bf7e851fc90945d54860d37bff7e92b0cd5ae.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] mctp i2c: handle NULL header address
From: Matt Johnston <matt@codeconstruct.com.au>
To: Simon Horman <horms@kernel.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  stable@vger.kernel.org, Dung Cao <dung@os.amperecomputing.com>
Date: Sat, 19 Oct 2024 12:03:48 +0800
In-Reply-To: <20241018200606.GC1697@kernel.org>
References: 
	<20241018-mctp-i2c-null-dest-v1-1-ba1ab52966e9@codeconstruct.com.au>
	 <20241018200606.GC1697@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Simon,

On Fri, 2024-10-18 at 21:06 +0100, Simon Horman wrote:
> On Fri, Oct 18, 2024 at 11:07:56AM +0800, Matt Johnston via B4 Relay wrot=
e:
> > From: Matt Johnston <matt@codeconstruct.com.au>
> >=20
> > daddr can be NULL if there is no neighbour table entry present,
> > in that case the tx packet should be dropped.
>=20
> Hi Matt,
>=20
> Is there also a situation where saddr can be null?
> The patch adds that check but it isn't mentioned here.

AF_MCTP protocol will always have saddr set, but=C2=A0it may be possible to=
 route=C2=A0
other protocols out a mctp-i2c interface where saddr=3DNULL.
(Perhaps=C2=A0other protocols should be prevented separately?)
I'll update the commit message.

> > Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> > Cc: stable@vger.kernel.org
> > Reported-by: Dung Cao <dung@os.amperecomputing.com>
> > Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> > ---
> >  drivers/net/mctp/mctp-i2c.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git drivers/net/mctp/mctp-i2c.c drivers/net/mctp/mctp-i2c.c
> > index 4dc057c121f5..e70fb6687994 100644
> > --- drivers/net/mctp/mctp-i2c.c
> > +++ drivers/net/mctp/mctp-i2c.c
>=20
> Unfortunately tooling expects an extra level of the directory hierarchy,
> something like the following. And is unable to apply this patch in
> it's current form.

Sorry, this was my first time using b4 [1].

Cheers,
Matt

[1]
https://lore.kernel.org/tools/20241019-pr-diff-prefix-v1-1-435e6c256e2f@cod=
econstruct.com.au/T/#u

>=20
> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index 4dc057c121f5..e70fb6687994 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c
>=20
> > @@ -588,6 +588,9 @@ static int mctp_i2c_header_create(struct sk_buff *s=
kb, struct net_device *dev,
> >  	if (len > MCTP_I2C_MAXMTU)
> >  		return -EMSGSIZE;
> > =20
> > +	if (!daddr || !saddr)
> > +		return -EINVAL;
> > +
> >  	lldst =3D *((u8 *)daddr);
> >  	llsrc =3D *((u8 *)saddr);
> > =20
> >=20
> > ---
>=20


