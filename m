Return-Path: <stable+bounces-204758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46176CF3EE7
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0061F3169E0D
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095833F8B4;
	Mon,  5 Jan 2026 12:44:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EB33F398
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617086; cv=none; b=a0ZqkNoJJtaZmSSWmdI4/ZuipW1aRLX4F/NvsOP5YXwWrAHINVtMgHsPOWY8oh7qtfT/ahNICRo6+BoYZfVTMw5oX+3oS/ClDa6pVK6ItQgWyFy4zaTjatzsEy/UWARanq8t4Wza9xdugCYU6X2cEUZFoiej2YeawysI0gGXVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617086; c=relaxed/simple;
	bh=4lhYeAVnDUcO7MjINejzeyEh1elj7BpTqDqq6DdfleY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ0EsMhy22Vf9xEBBec4oXI8GcskexVU1Q0ImbECOs4UTr99CTvGINHOyBi+poktYU/lX63dfUCddOkUzFgGvllHq3sQDvbZvTpkXOKDfRWiP14GsyvbDQMJQvtPKWCKKF8jO5UyFj3RUJP4kuyuw9UewinyrvczxyN7jQdgOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vcjws-0007qq-Uz; Mon, 05 Jan 2026 13:44:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vcjws-009Agf-2Q;
	Mon, 05 Jan 2026 13:44:38 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6D9474C6647;
	Mon, 05 Jan 2026 12:44:38 +0000 (UTC)
Date: Mon, 5 Jan 2026 13:44:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can v2] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
Message-ID: <20260105-sweet-fox-of-wholeness-5fc00d-mkl@pengutronix.de>
References: <20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvbbsombzbarg4ph"
Content-Disposition: inline
In-Reply-To: <20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--rvbbsombzbarg4ph
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can v2] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
MIME-Version: 1.0

On 05.01.2026 13:35:54, Marc Kleine-Budde wrote:
> In gs_can_open(), the URBs for USB-in transfers are allocated, added to t=
he
> parent->rx_submitted anchor and submitted. In the complete callback
> gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
> gs_can_close() the URBs are freed by calling
> usb_kill_anchored_urbs(parent->rx_submitted).
>
> However, this does not take into account that the USB framework
> unanchors the URB before the close function is called. This means that
> once an in-URB has been completed, it is no longer anchored and is
> ultimately not released in gs_can_close().
>
> Fix the memory leak by anchoring the URB in the
> gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.
>
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devic=
es")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

applied to linux-can

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rvbbsombzbarg4ph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlbsjMACgkQDHRl3/mQ
kZyFcgf+O5HOFnmXbM8w0r0pmN+9ZdH9k6DhL8wQX2I3pRv0TNQ0+BUJTsVJndyJ
BPScPh2D44UJb3cegn7Qt4h4N9A5VG08b85tob00cDLCK+l52x/3XJ4JWpRAenSv
8Ng4O2RGjmvKGJincvWUAoaaFnUBg129NpFWnDhdN6k6DO3sDkKm2JS2nxV0AR5o
PvMuydLvcC7zIBMiIIC9du1Jvn3eF6mnZlVl4+TOIlYdCDNkCe3TAjp60KkETyVU
uMjDXc1d3nqt7QDFKBsX4SfLmDZ/prIreks96h470ys6+aKcX/5vWx2oqh1zO39t
HfLLKY9nwpRLI7C2U2cIf054eRUeMA==
=hWfG
-----END PGP SIGNATURE-----

--rvbbsombzbarg4ph--

