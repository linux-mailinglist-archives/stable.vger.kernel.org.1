Return-Path: <stable+bounces-89262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5289B5570
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 23:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FE41F23D63
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0C209684;
	Tue, 29 Oct 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmDaC4uF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F82010F8;
	Tue, 29 Oct 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239299; cv=none; b=G0EfEt8vt8w7qPPmTChlNItF8sOB4SyD2GTZJMPjQ98FMrjDvF8LtCTfeAuNITpOBi/2XQtBu6WPzmkNwOVN9zOuykhYEr1Blc742nOsQJUJL0MYh0YXUKiXVQtwQT1x3+FpI6oz9q0bso1hCswbNgjGrPVGGhmKUm8FXmTb79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239299; c=relaxed/simple;
	bh=yOEdc3sgZpEcIJK+lxO9rihNZuaybqjoAWpsACwOUAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk9OJbIQdiUvKWqdwsKjxgbxH8kBxmXtRHihg3pLteslQSLt49UoDaKRWTr1FQXKO3G15aT032tJVv5sChnXUAclzA2Xwc2fiGVTgXX+UpHiRu4wD41BKeSX7d/xQI7Oibk0Ug8jpVgOEk8ZGgYU6JBHJ6ctDTi1wExbeQ3dx60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmDaC4uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CCBC4CECD;
	Tue, 29 Oct 2024 22:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730239299;
	bh=yOEdc3sgZpEcIJK+lxO9rihNZuaybqjoAWpsACwOUAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VmDaC4uFHK/uQ2d/Sq4XchtJRPk0qURBpBU7xUhu9cJUQbPNP+KuSvvr2zo+5UjVx
	 CkKM5FuZOVdjqkQJW/RRCa9Wv62WM218nARidlJ7h2OBltn9myjXTOZI7qxvKssqDa
	 QghZYqyx1Bmvvd+qcAWHGulgXr6Y1JM40Mxr+DLooAhqitkoD6M56k57lUf/NYiWTn
	 HRFb1o5oGDvITIjBzzIcsCfepniCOyaSSyuB31z2bpYAeetYgVoW6n0cRXMuXRcIkn
	 tUwMf2WalH+U39HoQGOALuwzf1MKJoTkeq5f/GUES3sy++yKPydkTRgHozppldplZm
	 iAKN/icDg1YBA==
Date: Tue, 29 Oct 2024 15:01:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: vertexcom: mse102x: Fix possible double free
 of TX skb
Message-ID: <20241029150137.20dc8aab@kernel.org>
In-Reply-To: <10adcc89-6039-4b68-9206-360b7c3fff52@gmx.net>
References: <20241022155242.33729-1-wahrenst@gmx.net>
	<20241029121028.127f89b3@kernel.org>
	<10adcc89-6039-4b68-9206-360b7c3fff52@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 22:15:15 +0100 Stefan Wahren wrote:
> > Isn't it easier to change this function to free the copy rather than
> > the original? That way the original will remain valid for the callers. =
=20
> You mean something like this?
>=20
> diff --git a/drivers/net/ethernet/vertexcom/mse102x.c
> b/drivers/net/ethernet/vertexcom/mse102x.c
> index a04d4073def9..2c37957478fb 100644
> --- a/drivers/net/ethernet/vertexcom/mse102x.c
> +++ b/drivers/net/ethernet/vertexcom/mse102x.c
> @@ -222,7 +222,7 @@ static int mse102x_tx_frame_spi(struct mse102x_net
> *mse, struct sk_buff *txp,
>  =C2=A0=C2=A0=C2=A0=C2=A0 struct mse102x_net_spi *mses =3D to_mse102x_spi=
(mse);
>  =C2=A0=C2=A0=C2=A0=C2=A0 struct spi_transfer *xfer =3D &mses->spi_xfer;
>  =C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg =3D &mses->spi_msg;
> -=C2=A0=C2=A0=C2=A0 struct sk_buff *tskb;
> +=C2=A0=C2=A0=C2=A0 struct sk_buff *tskb =3D NULL;
>  =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 netif_dbg(mse, tx_queued, mse->ndev, "%s: skb %=
p, %d@%p\n",
> @@ -235,7 +235,6 @@ static int mse102x_tx_frame_spi(struct mse102x_net
> *mse, struct sk_buff *txp,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!tskb)
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -E=
NOMEM;
>=20
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_kfree_skb(txp);
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 txp =3D tskb;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> @@ -257,6 +256,8 @@ static int mse102x_tx_frame_spi(struct mse102x_net
> *mse, struct sk_buff *txp,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mse->stats.xfer_err++;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> +=C2=A0=C2=A0=C2=A0 dev_kfree_skb(tskb);
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>  =C2=A0}

Exactly, I think it would work and it feels simpler.

