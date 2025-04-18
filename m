Return-Path: <stable+bounces-134634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0BA93B9B
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3667D4A0BBD
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A35217701;
	Fri, 18 Apr 2025 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="f8rcAPZd"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DA4CB5B;
	Fri, 18 Apr 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995800; cv=none; b=ioVEIsp3/O4KUPOybyXn3VTM5Ac2Wi1NlbAs4YyjTjBxps/cdNOqmZLSPQ1VdoNVLr6uQMr64sZiW+9nSAHvrbj0+ao0n8WQ0llgDo2TbrzABQ2f7xQqBgUqbtkUiAfXHVM/BcsZMkrzXSHHo8oEy4kgVaK2rhpo9ZkjcuIu6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995800; c=relaxed/simple;
	bh=3yZrrJGOXM7r2a4fOoqHfAicY7yN/Iqf8k1LBE56EDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FreoUO32q0dGPCmSk1jzQSFJiaCRqzzIIGL+zvTMldfganJ4eZFyu4VqaD9aDZ1CkNlNbzMTKqth7yI52sC+08fi53AOZ2usdubN7xvK0WctMXvloLWfPMIF10wHXdncbWPJ+KUKGZnx18fw2Bp380j3WKSZ8+lkYgCK1kTddL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=f8rcAPZd; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9730E10273DBF;
	Fri, 18 Apr 2025 19:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744995796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OWXzo4OMHnLS4NPQ/xzmDOeZDiOZxuFA/2rUofiU76s=;
	b=f8rcAPZdZjOYwq/L6E43t7xdHa2uzRG7aoJK1AlbVOvb0Wdex2AB+58FT2G+ra1DgX2jzW
	GBwvToPhERvW1Onx5v8ydQhHXxgY7s7jPllGOHywOZmeWdX7iIge9fYORMp3hjQTFH9+I1
	DZkjZ228evpalH8amOCq7QU1Gf2tfZHdLWC37fOQWWV/SkNHtMY/Ee6Dj6goFxurWAP6KC
	ucbs7wdfripyT0OSheDZ7KbsuXez2ITU2wo7GOywr6ONRcLEzxEhVvo3IAiVT9+wpi7UUA
	LbHLlWRwremYGaLrssdh+27y2SauRb1ITB8CwwmrP6t/uazu0QOZ4SZUqk+QvA==
Date: Fri, 18 Apr 2025 19:03:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 15/15] Bluetooth: hci_uart: fix race during
 initialization
Message-ID: <aAKFz3wsy+HOMphC@duo.ucw.cz>
References: <20250403191002.2678588-1-sashal@kernel.org>
 <20250403191002.2678588-15-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vc6D8ODBsAjs0Y2/"
Content-Disposition: inline
In-Reply-To: <20250403191002.2678588-15-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--Vc6D8ODBsAjs0Y2/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Arseniy Krasnov <avkrasnov@salutedevices.com>
>=20
> [ Upstream commit 366ceff495f902182d42b6f41525c2474caf3f9a ]
>=20
> 'hci_register_dev()' calls power up function, which is executed by
> kworker - 'hci_power_on()'. This function does access to bluetooth chip
> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
> be executed before setting this bit. In that case HCI init logic fails.
>=20
> Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
> 'hci_uart_register_dev()'.

Ok, but do we need to adjust the error handling?

> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -706,12 +706,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, =
int id)
> =20
>  	hu->proto =3D p;
> =20
> +	set_bit(HCI_UART_PROTO_READY, &hu->flags);
> +
>  	err =3D hci_uart_register_dev(hu);
>  	if (err) {
>  		return err;
>  	}
> =20
> -	set_bit(HCI_UART_PROTO_READY, &hu->flags);
>  	return 0;
>  }

Should we clear the bit in the error path to undo the effects?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Vc6D8ODBsAjs0Y2/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAKFzwAKCRAw5/Bqldv6
8nteAKC0ZaQK2eqV9AEc2XJ5g+RVdnJTbQCgt9ZXQXxEKNTvTonIxI6BFOcY8kw=
=+60M
-----END PGP SIGNATURE-----

--Vc6D8ODBsAjs0Y2/--

