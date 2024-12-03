Return-Path: <stable+bounces-97970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F609E2A59
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD60B45758
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6811F76BF;
	Tue,  3 Dec 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igbMQ4yR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566E81ADA;
	Tue,  3 Dec 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242359; cv=none; b=h70PnczEYY9iM7VDkXe05u03qh0FiHSAEP9wMCVO9DfN75rzeOy9Aty5htbw6Yf5ennbiiNmepft/rhrqULbqKEhJ3yIai9xDgCwLyh68eHY8tEg5NvOpZSp7+3T4hp4NFOPPvq0p38Xk4ithzXsGID+IBjKD2N+EDFWR1NXk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242359; c=relaxed/simple;
	bh=F9SO0SqK8bG1I8hFZ3skt7R6pqnnPq9qHCJHYGaW9f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcwk/jZXCByC4FI+6JydQaz0XIGIzHHrhQlWt7IUErJo0dQsMUbTo7Q5XNeslARamcP02EeZEN27srLP+mOPCs2Wss20FhjgfTYMLZV6Hv83MFNJX90Kvy5L4yo6NEY5rCikC7P8OWliS0EyEBZ23/xkgVbEHWG1QXZLz0vMoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igbMQ4yR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F37C4CECF;
	Tue,  3 Dec 2024 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733242358;
	bh=F9SO0SqK8bG1I8hFZ3skt7R6pqnnPq9qHCJHYGaW9f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igbMQ4yRi9reLImfDnJLr2BHCu1Z6F6F0e6W+TcZm5J3kPylbhM5KYLoN3bmunPN6
	 8vVr4LryjKCdHD8Qqr93ucUmUxyyNtFF019BIvNgzInqLGkiHneY5/OTt6mxXchlIq
	 QWDdRsfwGxrBTvC9M8mtoYz5NDXiwvVL8BJfeyUTI+gJ2TDeqBaPLBl+BIu7X6T65t
	 BJaqYpd5wEkGSao0FoVOxlBvD3Rao/umYJvBjgiGdgFPCUfpCngS/mcWQfx0qy39m1
	 mQv6knn+kjCqYJS2cuQPyO4QbOTd5IPBOvmpUqFl3GnPDh02o6xkNwWAKBbLNsYVxl
	 h/R3wWZvFOjNg==
Date: Tue, 3 Dec 2024 16:12:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64/signal: Avoid corruption of SME state when
 entering signal handler
Message-ID: <537fe318-a679-4b5c-b87f-93a7812dbeca@sirena.org.uk>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-5-d853479d1b77@kernel.org>
 <Z08kvi0znVM2RHx4@e133380.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+lgisz515vzeuI55"
Content-Disposition: inline
In-Reply-To: <Z08kvi0znVM2RHx4@e133380.arm.com>
X-Cookie: Alimony is the high cost of leaving.


--+lgisz515vzeuI55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2024 at 03:33:18PM +0000, Dave Martin wrote:
> On Tue, Dec 03, 2024 at 12:45:57PM +0000, Mark Brown wrote:

> > +	get_cpu_fpsimd_context();

> > +		if (current->thread.svcr & SVCR_SM_MASK) {
> > +			memset(&current->thread.uw.fpsimd_state.vregs, 0,
> > +			       sizeof(current->thread.uw.fpsimd_state.vregs));

> Do we need to hold the CPU fpsimd context across this memset?

> IIRC, TIF_FOREIGN_FPSTATE can be spontaneously cleared along with
> dumping of the regs into thread_struct (from current's PoV), but never
> spontaneously set again.  So ... -> [*]

Yes, we could drop the lock here.  OTOH this is very simple and easy to
understand.

> > +		/* Ensure any copies on other CPUs aren't reused */
> > +		fpsimd_flush_task_state(current);

> (This is very similar to fpsimd_flush_thread(); can they be unified?)

I have a half finished series to replace the whole setup around
accessing the state with get/put operations for working on the state
which should remove all these functions.  The pile of similarly and
confusingly named operations we have for working on the state is one of
the major sources of issues with this code, even when actively working
on the code it's hard to remember exactly which operation does what
never mind the rules for which is needed.

--+lgisz515vzeuI55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdPLfEACgkQJNaLcl1U
h9BKOAf+MLS0FpEuVDT0jpRdE+xAaBTIboWgjMz8CcNXxOEGRn3n7smri5xV50BH
Lvvp8PMP9DsUOxWqAAq7MxgEpo1aXopGH1oc84zjtzOD/rl+MQDlxFcS6jOM1dCf
oI9bemAyeqxTT79KiPVTptC20e+VcCDeHM/7hXA1gqGPXz/07sdpgT9ZBX2KCdEI
JD6hdVNzFlj/6Fjy7Awgu9WiqOA8oxjqO3NKgrJMbtdnMlm4SP4O1BX9KPgS35K6
w0rIXthg3E5B1q53ry+07iAhAUA9CgpiKnKTzRe6W0ogv47mtp6FZa9wUcnBz6RM
+vtgOU1CAStCu8pO5UeeO+kv1MSjxA==
=TKmL
-----END PGP SIGNATURE-----

--+lgisz515vzeuI55--

