Return-Path: <stable+bounces-112189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F79A27694
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B82166B8C
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60149215168;
	Tue,  4 Feb 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzu2lit1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10320C46D
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684592; cv=none; b=k2xT8fxx0Wo+LDqiB2ojvNyLGR+rLFggQwnShuCSurNIeb5nHWdgAbN9RD0S95HiDT1GAdwVqxnnIO1JAlqpmU2dxgGl1ysPUo+AQZ/sGTzLFVR0o8/LMcoChUwd478VrC5NFlCWdfDB7fMrceyABgDrhfh5dBKnK3Er6upsis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684592; c=relaxed/simple;
	bh=TnDe1ius/7IPe1J9ZK5g3J+Pkg+kyn/jagloz871HJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBwqV8WUIHdiGAZ+6IKWKuPv+Onr8nxoi4IDMAEYhdYny87YPJfjiH1+dxHGmWJY44K9HLjOz/WSh6E0FKqfWHHMT8WYuATMhcQZ+DUtR4aGGu5iwdpRGnM3TP+TX5HcX5jj6F7iVFvGfowcUd3J1BY7bE2fOnGTJ371oqUsKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzu2lit1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124F3C4CEDF;
	Tue,  4 Feb 2025 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738684591;
	bh=TnDe1ius/7IPe1J9ZK5g3J+Pkg+kyn/jagloz871HJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zzu2lit14QmBxaLyTMzzLyIL8FRVYfLoxbaMrN02ksXKHRLq0yf6j/EQHLfs0AsDU
	 rHH4mHBEvtG3z7at5N95S+C7V/skI+JMzRuwlzR96+cHXD9wxMvKVf2YRlStmFyBEQ
	 2orLA9ZkU2+KR2UV3PKSi52QgZMFZaEI+ERwmM0JJXrpbekWRgfhf9/pNyuoaxoFrS
	 5dyPpTVRVGFoSVMxpxTIPXzWFbLQgU7nf7FU0rqfcU4neOeZf4sK8YWpxYWhlc3Jef
	 9f3MRYpQhb3JCOhSTlZLLUu8oVjhIE41UOtJxlWyl/jx6I5vwv4hsPW7yAIZCjXHev
	 xiWad2xOhsVzg==
Date: Tue, 4 Feb 2025 15:56:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 1/8] KVM: arm64: Unconditionally save+flush host
 FPSIMD/SVE/SME state
Message-ID: <2b95bb66-9e83-45f3-90b1-594819cba49a@sirena.org.uk>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-2-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y9e4ZABF7nk4Lxsq"
Content-Disposition: inline
In-Reply-To: <20250204152100.705610-2-mark.rutland@arm.com>
X-Cookie: Spelling is a lossed art.


--y9e4ZABF7nk4Lxsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2025 at 03:20:53PM +0000, Mark Rutland wrote:
> There are several problems with the way hyp code lazily saves the host's
> FPSIMD/SVE state, including:

...

> Avoid these by eagerly saving and "flushing" the host's FPSIMD/SVE/SME
> state when loading a vCPU such that KVM does not need to save any of the
> host's FPSIMD/SVE/SME state. For clarity, fpsimd_kvm_prepare() is
> removed and the necessary call to fpsimd_save_and_flush_cpu_state() is
> placed in kvm_arch_vcpu_load_fp(). As 'fpsimd_state' and 'fpmr_ptr'
> should not be used, they are set to NULL; all uses of these will be
> removed in subsequent patches.

This avoid any confusion so

Reviewed-by: Mark Brown <broonie@kernel.org>

--y9e4ZABF7nk4Lxsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeiOKkACgkQJNaLcl1U
h9DSjQf8DN+GgiJZ/+8XJADu2U9fXZLUryMH+euxShM9rgJsKSrcPVeocBf0ogFy
F/oHkwZ1KJDFIXLHUmtdCw9ktJKVX5IukeV9AEe81oLQ0c5UBAwzHb5JO9Gv3dVC
izGqKFyU+D+UIaZZahQZHCm/bwK8GkDhcjwNIyNDCYoUa1xl4+46bk07dJjKJR0P
NdQBrrzoSWB3GsQ59LCEVnrKV6SNhQ4SqwxI3bwqXOwnZs6+xo5lNzp3uMhFvc1l
0botQf1eemDpMwBSA/95tUtiyfapIV16TU98KknzZBydCGCr25ep2hFazzhcvD5W
U3ZofyAsVUI09uOVFwg2tRcOOK257g==
=R/pD
-----END PGP SIGNATURE-----

--y9e4ZABF7nk4Lxsq--

