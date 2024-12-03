Return-Path: <stable+bounces-98136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49829E2C6D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B23B3D3E8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9781F76AE;
	Tue,  3 Dec 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4fWRbkN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EEA1F4731;
	Tue,  3 Dec 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246684; cv=none; b=TPxOAyd8f0kbfrsbq4PlOLn9Wgye7uXEzZ6qaMds+OUDyGNyHW8prOSs/jw+zSQ7wzTmot6+0RzLmqUgoBikQO8fz/GfunEZqjbQ8X6nrGMNz6+OQ5GlfYIHYK6ctknEp7z7m/VseWisBPXfw+Y2hMAz74y0ToQL7HR/x7/JvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246684; c=relaxed/simple;
	bh=LNXxnd+wAtX8yjnWtSQBVcGs5jeF1cYxXYnclU8AnDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH/Z3ZLqcyBNVYaPZ9iXv1RjrKlhRaZeYsy2eyTBJ6gsUNJ1MiWEpOXUghSfcxrRShhvHW6MOlxnGh+1xUL6Ilwe62mBgNI0ZYtEWNhyLrJUQ4oZf7mgF/NeZYA2Juo63QURc9tGDC1m/LwC6qgRPs/PNTlk1EOJrf5PE+uGIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4fWRbkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5597DC4CECF;
	Tue,  3 Dec 2024 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733246683;
	bh=LNXxnd+wAtX8yjnWtSQBVcGs5jeF1cYxXYnclU8AnDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4fWRbkNm3jIkzfpx0pDOYw+KFGofLZR7Wkua0flCruEk9CYgjatRvlLgPHHy1ilD
	 +WRMYBCdOJKYuHwHcfz4P+AY/FiH5A4c7paI3nsojLe8d1UYXjPFZL+Jieq4TPzKR+
	 YPT3BdwA8JIKaPoJohyzwnFAjVS28hYvsatDGWDDhC4Q/1A8D+ZDHVquBLJlUBDzBf
	 5KmDbKd0dGmv32Q3W+TRwteyk0Xw/ATWLjtku9mZw4eUTOYrofbJjNzMySg3fB0o0R
	 Ic+q6vFVxzRcugP5nf1717ZCRcdX59WvuMK0vU0no9HyLqBGhGi8l5kbrtLsAE7Pw0
	 fS+HssiZ74Uhg==
Date: Tue, 3 Dec 2024 17:24:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64/sme: Flush foreign register state in
 do_sme_acc()
Message-ID: <44d67835-1e43-47cc-9a18-c279c885dcec@sirena.org.uk>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-1-d853479d1b77@kernel.org>
 <Z08khk6Mg6+T6VV9@e133380.arm.com>
 <9365be76-8da6-47ce-b88e-dfa244b9e5b7@sirena.org.uk>
 <Z085GKS8jzEhcZdW@e133380.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tHDCWXL5Z30wlzvr"
Content-Disposition: inline
In-Reply-To: <Z085GKS8jzEhcZdW@e133380.arm.com>
X-Cookie: Alimony is the high cost of leaving.


--tHDCWXL5Z30wlzvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2024 at 05:00:08PM +0000, Dave Martin wrote:
> On Tue, Dec 03, 2024 at 04:00:45PM +0000, Mark Brown wrote:

> > It's to ensure that the last recorded CPU for the current task is
> > invalid so that if the state was loaded on another CPU and we switch
> > back to that CPU we reload the state from memory, we need to at least
> > trigger configuration of the SME VL.

> OK, so the logic here is something like:

> Disregarding SME, the FPSIMD/SVE regs are up to date, which is fine
> because SME is trapped.

> When we take the SME trap, we suddenly have some work to do in order to
> make sure that the SME-specific parts of the register state are up to
> date, so we need to mark the state as stale before setting TIF_SME and
> returning.

We know that the only bit of register state which is not up to date at
this point is the SME vector length, we don't configure that for tasks
that do not have SME.  SVCR is always configured since we have to exit
streaming mode for FPSIMD and SVE to work properly so we know it's
already 0, all the other SME specific state is gated by controls in
SVCR.

> fpsimd_flush_task_state() means that we do the necessary work when re-
> entering userspace, but is there a problem with simply marking all the
> FPSIMD/vector state as stale?  If FPSR or FPCR is dirty for example, it
> now looks like they won't get written back to thread struct if there is
> a context switch before current re-enters userspace?

> Maybe the other flags distinguish these cases -- I haven't fully got my
> head around it.

We are doing fpsimd_flush_task_state() in the TIF_FOREIGN_FPSTATE case
so we know there is no dirty state in the registers.

> (Actually, the ARM ARM says (IMHTLZ) that toggling PSTATE.SM by any
> means causes FPSR to become 0x800009f.  I'm not sure where that fits in
> -- do we handle that anywhere?  I guess the "soft" SM toggling via

Urgh, not seen that one - that needs handling in the signal entry path
and ptrace.  That will have been defined while the feature was being
implemented.  It's not relevant here though since we are in the SME
access trap, we might be trapping due to a SMSTART or equivalent
operation but that SMSTART has not yet run at the point where we return
to userspace.

> ptrace, signal delivery or maybe exec, ought to set this?  Not sure how
> that interacts with the expected behaviour of the fenv(3) API...  Hmm.
> I see no corresponding statement about FPCR.)

Fun.  I'm not sure how the ABI is defined there by libc.

--tHDCWXL5Z30wlzvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdPPtYACgkQJNaLcl1U
h9APOAf/UFW40tTbHb8uLiLKWdPsreOHsimNJmtyKr1ffXaDSWdfVPDpmIkD2Pq0
IfxTti7phJ0HbaSbSPQE5Q4wAuoWBKPBF1MA//sROlRYOrgRyGnoh4wYPHsKyHsC
te9Y7m8YRG5BjAWU9AZxXDqrAzAD0Z2FUzPWHoeCfZfMzF39LVeT9fWrXifq//JL
pukr0jwLO8Cl6h5beYMmvhhV+tUFooMIyswL0ao+U8oR34CtbTO43JsGwvIQ4jtN
jkLXq4qeAFpbCdfepZcfO0GM3MIFMBu646I3pUVppZj0FAtQzShBrTdEz8IxAr4/
Ae/GFy0QGUkCC6ZHRyE/6ZC3sp7Vmw==
=MArm
-----END PGP SIGNATURE-----

--tHDCWXL5Z30wlzvr--

