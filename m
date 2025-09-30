Return-Path: <stable+bounces-182841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FEBADF06
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EFE19440AE
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8927307AD3;
	Tue, 30 Sep 2025 15:40:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3203090F7
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246836; cv=none; b=XFdERG7IQBmtiU5RMXKqZ+jbVQs/k2ELvPPqFaqdezfXmRJT1crWLfko0s8BhGkQPNbC/iDUFVlvhm4mz9bMl95/OQHFrb+dSFjlJBxzk2allAozK8wUaf4hZmi8cIvkgbU7sp9Rj+YdSZTHavt5T1QxwrZbgM6xfxxzYKBDP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246836; c=relaxed/simple;
	bh=08nF264kPnb09l/Vpi/EDkqosub5X+SZ4wkXjGyuHJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL7nQ9Qppk2olsVNxy9fWTkxsL9NH+FhU0RbOjT1nxzj3fcM7GOqYgIk/yh8BXjHfuTuPO3ygWwonSU0uQznXtN7nIcxq+rsfuLQFUn6jCseys+Y9MRmRew/pJe15qLHPfRs38Q/mTmODDY+rmLHuiByyf4Ccf1CjTgHKGqAYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3cSn-0004af-2I; Tue, 30 Sep 2025 17:40:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3cSm-001Gqw-19;
	Tue, 30 Sep 2025 17:40:24 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EF79F47D51F;
	Tue, 30 Sep 2025 15:40:23 +0000 (UTC)
Date: Tue, 30 Sep 2025 17:40:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Maximilian Schneider <max@schneidersoft.net>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] net/can/gs_usb: populate net_device->dev_port
Message-ID: <20250930-adorable-loud-scallop-faed25-mkl@pengutronix.de>
References: <20250930-gs-usb-populate-net_device-dev_port-v1-1-68a065de6937@coelacanthus.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lnucko7usyhni2xq"
Content-Disposition: inline
In-Reply-To: <20250930-gs-usb-populate-net_device-dev_port-v1-1-68a065de6937@coelacanthus.name>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--lnucko7usyhni2xq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net/can/gs_usb: populate net_device->dev_port
MIME-Version: 1.0

On 30.09.2025 14:53:39, Celeste Liu wrote:
> The gs_usb driver supports USB devices with more than 1 CAN channel. In
> old kernel before 3.15, it uses net_device->dev_id to distinguish
> different channel in userspace, which was done in commit
> acff76fa45b4 ("can: gs_usb: gs_make_candev(): set netdev->dev_id").
> But since 3.15, the correct way is populating net_device->dev_port. And
> according to documentation, if network device support multiple interface,
> lack of net_device->dev_port SHALL be treated as a bug.
>=20
> Fixes: acff76fa45b4 ("can: gs_usb: gs_make_candev(): set netdev->dev_id")
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lnucko7usyhni2xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjb+eQACgkQDHRl3/mQ
kZypgAf/Xj9cS2TujQe8t0YRmaldbPu6iIqp+AZkIh1VJR5iIfjjMtDJZMmN/CA5
ah97zSKuvE93FnPYChI0lcmICoVZ4k1Gv4R+xywOlPL8ASiuEv48FjVJb9ggPuue
ps/qEVtoJs0MHvEskN0QzI8oMzbYZk8YV/0dMKeipKQjhDM28WUYvpvd8HA1QVag
A3AFhIuyfUq0mjkEJw8nqZUdoo0/tZVze48nMB8Z04rSGrhme6ItjHNvnxsPKQka
Yn35AzxBw82yRtOfE8Wa46yQVh9EhoQIrCvA2lrgFHYF4JmCpyY/KrBMWfIGp8k+
IBVaFfesLljyqTpnQrpPGKX5P7JECw==
=9VQW
-----END PGP SIGNATURE-----

--lnucko7usyhni2xq--

