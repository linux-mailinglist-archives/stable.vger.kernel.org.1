Return-Path: <stable+bounces-148147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB6FAC8B5A
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 11:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AFA3A58CA
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717D74BE1;
	Fri, 30 May 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="M1Hwxp3+"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78754652
	for <stable@vger.kernel.org>; Fri, 30 May 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598444; cv=none; b=lI7SHy+MiBgKNsQMMUmh34rEeIHBOY3rP3qrPgWjETnvMlF3yo7e/sUTRB12r9PNe99BFvGoQ8Q0ll6XyOEDJDh+fWmO5MqHJ/BO+h1lxRa3rckW/EoOK6ahpVsxPRBy3lHbFCdfUkOCVoGiFu88Dx5uVYldJvoQIuE1wZ4pBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598444; c=relaxed/simple;
	bh=ouWpbpuJnh93U8NdfvGh/bdUmtK+hW6totfhcEcu8xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7Z9U6pZR6vl5lHjFo8QvbXS2kcsILpU+oX7hizzxVmJHO/kqtFafALr01LtOApt/covG/OPjwquns9E72NYDIjtd3ctXvQhUmTogRPJhUCJWfVcsTrAGn1anfOcSfMZhh37Eja/BADUX6KawCwxkNxOQMjkVC2RhCYOY6EKgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=M1Hwxp3+; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 527611039728C;
	Fri, 30 May 2025 11:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748598438; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TWN/kLntnkKO4KnIl2Gyx+X6XCZ6EQpBtq6gOR3yuUg=;
	b=M1Hwxp3+YytwCxjMOUhR9rFlp4CbE9b1PiledLMPj1c9ZEdiHqgnuLcwDJfiH5maoUxAPE
	2YaXzTm6pigafExtYnedM+7OSboSpItQVSGYmwuBnCo7qZIwtM9+JQIRLmHTiuQ6nlfXmQ
	B6Kx7IAiIslyRA/zA0voQ74SuAwznKsb4ixakK+47gF7S3cJ3d0HJn/iO0pxlj44HwAtRO
	ZT2GbgJypfB/vUMG38Ko9bdcgxbKYTC4moJSQJYB1eJVLdJLbuiAPy2Le0ei0t53zdKlJ7
	hOSNnthEBfl9ARMZStsD1Z/tddytWQkQivIussxABN5wqeXNBQKXWLMHyzSGfQ==
Date: Fri, 30 May 2025 11:47:14 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Balbir Singh <balbirs@nvidia.com>, Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 6.12 305/626] x86/kaslr: Reduce KASLR entropy on most x86
 systems
Message-ID: <aDl+omgjuU1SymXn@duo.ucw.cz>
References: <20250527162445.028718347@linuxfoundation.org>
 <20250527162457.425427604@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ur7TB8GKW4biOVuq"
Content-Disposition: inline
In-Reply-To: <20250527162457.425427604@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Ur7TB8GKW4biOVuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 6.12-stable review patch.  If anyone has any objections, please let me kn=
ow.

Something went wrong with the scripts here:

> [ mingo: Clarified the changelog to point out the broad impact ... ]
>=20
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/Kconfig
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Link: https://lore.kernel.org/lkml/20250206023201.1481957-1-balbirs@nvidi=
a.com/
> Link: https://lore.kernel.org/r/20250206234234.1912585-1-balbirs@nvidia.c=
om
> --
>  arch/x86/mm/kaslr.c | 10 ++++++++--
>  drivers/pci/Kconfig |  6 ++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/mm/kaslr.c | 10 ++++++++--
>  drivers/pci/Kconfig |  6 ++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)

Two diffstats and signoff at the weird place. You'll miss the signoff
if you are not careful.

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Ur7TB8GKW4biOVuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaDl+ogAKCRAw5/Bqldv6
8pPMAJ4jR8CGPeKtLYI9ztqUacBl0yN6VwCfQssuI389VtieuEGsUxU8OTHJVik=
=0HdZ
-----END PGP SIGNATURE-----

--Ur7TB8GKW4biOVuq--

