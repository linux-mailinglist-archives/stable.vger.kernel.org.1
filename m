Return-Path: <stable+bounces-187913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446BBEF075
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 03:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59931896BDA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0421A840A;
	Mon, 20 Oct 2025 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFBnrjnh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E419B5A7;
	Mon, 20 Oct 2025 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760924518; cv=none; b=quTMJZbEK2QgLhwZd2quiMCuvFX99CbNwZB+YucTq+qPI9JawDCKxOCrAM9jV27YOMkzlp4xgrqKAivRY79/6R9kYBYNcd0ZqlNDPRrQtBeo0wWKBCdc3hPc/GkzduZva9ox73Td5vpaYcelYXyk4qzS7Vb0LvmVo9W4n9jFx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760924518; c=relaxed/simple;
	bh=Cjcf1/xqZW+Uik6yvN4NeKdAMdpCcc66oIiTXtqvHEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZfMrlAP5SL5wloGTtEHGl4hynnGiOuD2odiW28w6mV3M+W+JrPMpIm/pcdymxqVu9VLHtYLtDT5vOECFqeL5SwF0XSB2rahoq9ViCOjwShYzYS3aiLLhsakU8xIIxEFsr/vNiCwfEVvbneh2Sa8HrYukF0AHSo9nBRBN1AZ8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFBnrjnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5462C4CEE7;
	Mon, 20 Oct 2025 01:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760924517;
	bh=Cjcf1/xqZW+Uik6yvN4NeKdAMdpCcc66oIiTXtqvHEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFBnrjnhLCmQwKEpYJomTQd+PHRe17PXgbHBB4kdekJI8C0VJPgCu1ZhtY4VA6y1e
	 Qiq1mI2P5xZkqtP8SXIcXyG/NyF9npEcV/C9cBKWegmH1KahaoVQ6zhOehUslIGa9M
	 eI0X/lpJEKQGK02U6DtDmdi/UauveO3/0k3c7U0lEURhBeAIhGAz6WZ++hL3VgpCK7
	 D0XYiYB7hP4NgiT3VCucfnizTcgkR+j6bLMyL1Qx0fjfyToeQZ2ARhEDMCE6DnRjIh
	 0LPM4uf0WQ7D41cTS70E/GcOD+Lno3LXEYcyHv1JMwNLtzL1lIThZBG+ex3PDA8DZU
	 C3N8UG0igRwbQ==
Date: Mon, 20 Oct 2025 02:41:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: SOF: ipc4-topology: Correct the minimum
 host DMA buffer size
Message-ID: <de8f8b56-ef5d-4d58-92ec-38280badcfb0@sirena.org.uk>
References: <20251002125322.15692-1-peter.ujfalusi@linux.intel.com>
 <20251002125322.15692-2-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dthMWkywLjRNJ4O0"
Content-Disposition: inline
In-Reply-To: <20251002125322.15692-2-peter.ujfalusi@linux.intel.com>
X-Cookie: I'm into SOFTWARE!


--dthMWkywLjRNJ4O0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 03:53:20PM +0300, Peter Ujfalusi wrote:
> The firmware has changed the minimum host buffer size from 2 periods to
> 4 periods (1 period is 1ms) which was missed by the kernel side.
>=20
> Adjust the SOF_IPC4_MIN_DMA_BUFFER_SIZE to 4 ms to align with firmware.

This doesn't apply as a fix, please check and resend.

--dthMWkywLjRNJ4O0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj1k2AACgkQJNaLcl1U
h9C5CAgAhTOILLMaddbt9Pq6slTEERPkL1lmG9yKFRtZ2ymqzHGlruEBmuwkZNfh
qUDaBYRq8CHBdyFIGEqcF63MrK6ixflEeiIF0F/WO80sEcZhWzT1RVMeFJoaul/q
3tMZdSaWWZuMYjf0VY0UyZUDYXD/YDfsyAtOdB/og9k4GpmmBOgk7tCchNmIy2Qo
lwKb6xzvGOLB8XjgG6S03QaOi42/CeC7OEUP2rHkBur5jqZUSuNBZco/NjQ+VwoZ
zMI1zfoQrYGfq5ej0jqaA4BAPLDP8nU2bnWuZsWANXYzAIqeGM1yKMnmi2spYCd5
ymPSKD9ggaUdRkh3L5wHU/RoCW2lCg==
=zHxW
-----END PGP SIGNATURE-----

--dthMWkywLjRNJ4O0--

