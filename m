Return-Path: <stable+bounces-40724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F68AEAF6
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AF71C21D67
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5513BADD;
	Tue, 23 Apr 2024 15:25:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B17F499
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885906; cv=none; b=eLwgPpZjZhaB6U1I82e5SQ/tdopDH+N/y7qJQI95ThEbIrHWNYp1+gjVqe3Pj5k6SY2lt9rkEu6afug4MCpoKkMGShqPiacH+b4RogDGUAzyn7c2tuxLzgS9Gp8rJmlEfJfDghdJmcHPSMZAgUB33Ddp9D5ZpKs1nGcWS423Iu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885906; c=relaxed/simple;
	bh=mADyzFtFPTrL0Ew3/frBE7gKimsxCan2ktRjhg6ggoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+eq8qI0TQXAF/8zjvjqjy3yaF67grpV76yQwcEbICDsbhhQNgu+4UgJMwS8LEMI5VrtQgZwauDWD3h6rN88w/EfKIHVTFIqKZCpTKdjaEXatNaPYZBytx6Y3MbhTKykzN6HYIof2j3IUYir+tT31HvXiKxmyXZsUw3VDmr49og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzI0z-0000Kz-VF; Tue, 23 Apr 2024 17:25:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzI0z-00Dv27-IB; Tue, 23 Apr 2024 17:25:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzI0z-0078xG-1Y;
	Tue, 23 Apr 2024 17:25:01 +0200
Date: Tue, 23 Apr 2024 17:25:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] serial: stm32: Return IRQ_NONE in the ISR
 if no handling" failed to apply to 5.15-stable tree
Message-ID: <k5twtnplrzkqw3fi5th2s6qdtk6ds7wgjjabhitkm3i2llsnve@ir76mfzyj5nk>
References: <2024042344-phonics-simile-0b3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhmzfqdmrknfty6w"
Content-Disposition: inline
In-Reply-To: <2024042344-phonics-simile-0b3c@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--uhmzfqdmrknfty6w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 23, 2024 at 05:36:44AM -0700, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 13c785323b36b845300b256d0e5963c3727667d7
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042344-=
phonics-simile-0b3c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>=20
> Possible dependencies:
>=20
> 13c785323b36 ("serial: stm32: Return IRQ_NONE in the ISR if no handling h=
append")
> c5d06662551c ("serial: stm32: Use port lock wrappers")
> a01ae50d7eae ("serial: stm32: replace access to DMAR bit by dmaengine_pau=
se/resume")
> 7f28bcea824e ("serial: stm32: group dma pause/resume error handling into =
single function")
> 00d1f9c6af0d ("serial: stm32: modify parameter and rename stm32_usart_rx_=
dma_enabled")
> db89728abad5 ("serial: stm32: avoid clearing DMAT bit during transfer")
> 3f6c02fa712b ("serial: stm32: Merge hard IRQ and threaded IRQ handling in=
to single IRQ handler")
> d7c76716169d ("serial: stm32: Use TC interrupt to deassert GPIO RTS in RS=
485 mode")
> 3bcea529b295 ("serial: stm32: Factor out GPIO RTS toggling into separate =
function")
> 037b91ec7729 ("serial: stm32: fix software flow control transfer")
> d3d079bde07e ("serial: stm32: prevent TDR register overwrite when sending=
 x_char")
> 195437d14fb4 ("serial: stm32: correct loop for dma error handling")
> 2a3bcfe03725 ("serial: stm32: fix flow control transfer in DMA mode")
> 9a135f16d228 ("serial: stm32: rework TX DMA state condition")
> 56a23f9319e8 ("serial: stm32: move tx dma terminate DMA to shutdown")
> 6333a4850621 ("serial: stm32: push DMA RX data before suspending")
> 6eeb348c8482 ("serial: stm32: terminate / restart DMA transfer at suspend=
 / resume")
> e0abc903deea ("serial: stm32: rework RX dma initialization and release")
> d1ec8a2eabe9 ("serial: stm32: update throttle and unthrottle ops for dma =
mode")
> 33bb2f6ac308 ("serial: stm32: rework RX over DMA")

I think it's not that important to backport this patch further than 6.1.
It only improves the behaviour in the presence of another bug. If
someone wants to look anyhow, it would probably make sense to backport
13c785323b36 on top of a backport of 3f6c02fa712b.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uhmzfqdmrknfty6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYn0swACgkQj4D7WH0S
/k5J9Af/fVtGANGhUAsi/MN8Y3e9OSI8OuTFvSAdZIoxTPZJMk17cb763NarKhE3
IGXErWseUGJRPV7QxP0EcLFQY4iGS/X2Ov41e8q/kh5xZDZYRfl9CNV3LXVTufBK
eraPQYG2gLT1xw565FYlxkzUuK3PmBIMQrPJMy6lya7oySaBc4qv9wboW3O1h7+o
cjxYE/Nbb8xym9LUIxDpelVce1zsclMOpWZZ7uiFpxF/zi4u3aVoOb+DUPAqqqAX
ptOzIv2ERcoKMhD++7NN7vpXR5C+0nZBLprlRmBaKH3XyVIST3SGM9R+UlesOFhK
2kqJk9ThkfyAlJTGFZ9ZsxRNH+k/iw==
=K9O0
-----END PGP SIGNATURE-----

--uhmzfqdmrknfty6w--

