Return-Path: <stable+bounces-97763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36629E25EE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7E616D890
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321A1F76D2;
	Tue,  3 Dec 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzTiOEur"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022A1F76A4;
	Tue,  3 Dec 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241650; cv=none; b=cEaX++lH7D97Tzy5FBm6S8gGyOk0Qmawi7DehKyoXGxxM3FmSmKpqPUwGr2W+mADFD3nc13GXr+fpAiCP/t7rI+dPcnpqJW5T6aKLyno5S/CDzZqa1Jmjy++nHf83+MDX7yhXL2K7pMXwpB4usXkwUp4AvQtdZr0hw1rwmjtqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241650; c=relaxed/simple;
	bh=AoSfdUmW3Qz5Qt+tAkE3FSMWGkGJm0lI7MA7iR7Z2XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl4zFG9UXXGbmncXU3rLZJYV7T/cDOZ6cR7HqKMmeaklqud46YGZFLHyRAEWBt29stOt5DUiUNfUFi1HTXPyQexvwnK6nOgD9Sl2AaNI9SZa2ipKipjD1A+jAJ4CqzQiRIbHYE9pHs+JzkZY/7lhUKQpyE/XzSCZckrKZj7M2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzTiOEur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4CBC4CECF;
	Tue,  3 Dec 2024 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733241650;
	bh=AoSfdUmW3Qz5Qt+tAkE3FSMWGkGJm0lI7MA7iR7Z2XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzTiOEurjyVeVI5dFKRU9eRnhBKoYPc9hLs95uUzANDHYMGm0wnLAdMIGbVc7pJU1
	 513WZCumFL/KcT+McSJuLydoIrU1mwtHGc9Z4pF/Km4XqtEow8ZF49H+WJtMsFU4FJ
	 RHz8IrQNgttya/E4TBzT4YQARJQf91ZPn/DlJG1DfSzzIhEjMdCvrrpVkmRrWntr9D
	 FQROKR7Je54MYvOA745ZfZ7f+IAn7InbXkbQd4Mz+h0andR0LtMnEEai5pQmbevFAn
	 GKfK1ZnJFTQ1B0cFhrjGOZj2xQZnuCqYZ14KK3a1jFcVX13vQNxiyo3saljahpKVs2
	 nwI52REa3QzJQ==
Date: Tue, 3 Dec 2024 16:00:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64/sme: Flush foreign register state in
 do_sme_acc()
Message-ID: <9365be76-8da6-47ce-b88e-dfa244b9e5b7@sirena.org.uk>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-1-d853479d1b77@kernel.org>
 <Z08khk6Mg6+T6VV9@e133380.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V8rFlpgqAXwiQFZA"
Content-Disposition: inline
In-Reply-To: <Z08khk6Mg6+T6VV9@e133380.arm.com>
X-Cookie: Alimony is the high cost of leaving.


--V8rFlpgqAXwiQFZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 03:32:22PM +0000, Dave Martin wrote:
> On Tue, Dec 03, 2024 at 12:45:53PM +0000, Mark Brown wrote:

> > @@ -1460,6 +1460,8 @@ void do_sme_acc(unsigned long esr, struct pt_regs=
 *regs)
> >  		sme_set_vq(vq_minus_one);
> > =20
> >  		fpsimd_bind_task_to_cpu();
> > +	} else {
> > +		fpsimd_flush_task_state(current);

> TIF_FOREIGN_FPSTATE is (or was) a cache of the task<->CPU binding that
> you're clobbering here.

> So, this fpsimd_flush_task_state() should have no effect unless
> TIF_FOREIGN_FPSTATE is already wrong?  I'm wondering if the apparent
> need for this means that there is an undiagnosed bug elsewhere.

> (My understanding is based on FPSIMD/SVE; I'm less familiar with the
> SME changes, so I may be missing something important here.)

It's to ensure that the last recorded CPU for the current task is
invalid so that if the state was loaded on another CPU and we switch
back to that CPU we reload the state from memory, we need to at least
trigger configuration of the SME VL.

--V8rFlpgqAXwiQFZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdPKy0ACgkQJNaLcl1U
h9CH2gf/QFro82I1W2CYtFjXn3+fT0ntbUwmrgC4GyyCfObCK/FCTSG8n1F6oA8B
bFtwo5vwtVL1WnIIrzpO3LZUDRM/JPWIEms7dN9s+90ruai9tA4ckWDlA4Ej06fF
l/8heEM3xi34XzzNdqDTEWnxp4fWJaxXWA+2DMpR0FFMyxCNlaem5EA2M+6O7mcO
gjrleyVIoTZk37u8nOpJvdK6UMKl8pkwjCL1S8sPtFYLOmXprCXeNE6IdHf3KNqx
90n/MEAqqJc/tKXJHKAbZCSGVeClNFzXOLVksv4MCy+vYO2usa2MLDez64z3Q5Z3
MFjHni48OLHEmbCTivMMycStc4sWMg==
=Go4M
-----END PGP SIGNATURE-----

--V8rFlpgqAXwiQFZA--

