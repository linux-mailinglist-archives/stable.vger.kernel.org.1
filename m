Return-Path: <stable+bounces-54955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE6913CF5
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 19:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B011C21F41
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951B1822E2;
	Sun, 23 Jun 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fQVZyLH5"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D18BE7
	for <stable@vger.kernel.org>; Sun, 23 Jun 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162235; cv=none; b=PX0DQ82soQz9ZpSjZMu2R1muMPvP4L0fvfAvm+4pIMym8hF029EOlfgWts5C5ZHtVunKBHjYlDy49zLurWWYmSXmLPldJA/FrHr8GtSuwzGjrG7ZMcFTIAyj2ENF4KNZbDQUmdO6GSviAWnwDWTiyTrBKXCRDRR8UtVOPJWrncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162235; c=relaxed/simple;
	bh=xog/wiW80hd3PJYwxSGwG2Ynkf2vzKMYNgAx3TVvvEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMvK2E6upELrUNW1u+tgWMEy4SFmPy5Eu1KRmnjJBotqRKIRlGfGW6YeZqRQuPfDy22jAl3kyZGWnB2fp7BDnFeMTPuFQa3rmhmagBSX+zPFItaym+veQnipoZyYllHqSxpBWxryygQHL9AeMnWhojOOuHDc4+8TnBh7OaMmm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fQVZyLH5; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W6cr52vg3z9sZP;
	Sun, 23 Jun 2024 19:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1719162229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xog/wiW80hd3PJYwxSGwG2Ynkf2vzKMYNgAx3TVvvEg=;
	b=fQVZyLH5/rHBmOilhunZjgaxKVkSlXPMAqkLt9PLHP9HY6k2VwuVGq4w0ByZTins21IkJ1
	1YwxdsJ3vUh1DsPCtJStKvUA9ncDi98EEro9iJ1j9lxZOmUKIuMTLonnuJJ9UnS+HrrBSO
	nyy3aPgidPhaLaMGiNgoVdMoEeJNj827BAtUR4WEIDBJ3/imqroWqAwGCqg6bQSGjRCcJY
	Op21WTr5V3r+OpLqUPYlBMhsBwyiquYkaDF1okzdBb26TqzJXJCG3aL3AOjqMru5fX6Ijg
	g8R9c9YUOQBzLhsfj54FWzA2rXa7J/hOnQ+5IbW3Ket85AN/PG9h5RUJEuSl1g==
Date: Sun, 23 Jun 2024 19:03:44 +0200
From: Andreas Radke <andreas.radke@mailbox.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, yazen.ghannam@amd.com
Cc: stable@vger.kernel.org
Subject: Re: [regression] x86/amd_nb  in 6.9.6/6.6.35/6.1.95
Message-ID: <20240623190344.3b22344d@laptop-andy>
In-Reply-To: <20240621232911.01b144f3@workstation64.local>
References: <2024062120-quilt-qualified-d0dd@gregkh>
	<20240621232911.01b144f3@workstation64.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J7+KY_rQwAlC71QeTI2wxWD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-MBO-RS-ID: 76fb492a5865dbdcef0
X-MBO-RS-META: mnfhaxnu1fehtwqehjdhrtdjpy5h9mcb

--Sig_/J7+KY_rQwAlC71QeTI2wxWD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I cannot reproduce the issue anymore with any later compiled kernel not
matter if I keep the commit included or revert it. Maybe the initial
compile had some weird issue.

Sorry for noise.

-Andy

--Sig_/J7+KY_rQwAlC71QeTI2wxWD
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAmZ4VXAACgkQlGV6sg8q
CSt8Hgf/Rop2Sj1DMKafh7Yulkq6RnJhQyl7uTAwc/CY0h3W5s4EdfEP19f7w8Z4
n6q3WmvemAF4/hk71TpO2czLoq6RFC3FZNcLwzNavbdfYDHUpnNco+L/aJsVo65e
rRuMcpszDFhTvRlT3bsxy6is7S/9B+uUH2gZ/2vBmWNRKKaIBvmt/moYeY/dV+fi
V7XdfAaOdZ5AquVbx6Wzthfo13CGfAuDYkFzXn7gMP47KP5gnROmyUHj93vavtkP
+qKUusuAOuMBJto5HR/81vn6UKKAGYB0VzkmS1d1/k3zR9q/OyI09xSiiuuwwzwc
7mMJ8QhB5eKQB6lwVXLfIOPZsLWiYg==
=wLLl
-----END PGP SIGNATURE-----

--Sig_/J7+KY_rQwAlC71QeTI2wxWD--

