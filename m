Return-Path: <stable+bounces-104343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490199F3169
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0058318866F5
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151762054E6;
	Mon, 16 Dec 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdHnvuBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478C20011E;
	Mon, 16 Dec 2024 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355440; cv=none; b=kXOW08ptyrwr61NMXJCXzN6GEr2IXm6HC1ugI9plHsQBNwRBpewb9/ae/rm4BJD9vEIFRnaElrF4atmXGDvkxUCL6c3wCj230zjHznEzJnMIjUWgSWm0gWNRTkDSIMhEnwwde9ECqgudKpftIJHG6jPGyk8+GyuSyAks7USRGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355440; c=relaxed/simple;
	bh=GJputwvqPFp8XHDoVt2MCbWbXO/bSXIWyKEjo2h5cdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx4rhPMwQbcxrXf0Itpcwv6g9sNj0xoNiuFwU1ecnH51/L8Tn5HOhKfebFRjqnnBwwGTxD6ulrzi4rHW7kYCwOYVyIEUTjOffMe1xi71vTDq1wgexLWdZAAGQ+HfnNN/EBn5VBSeew1IYvCOjQHlNGmNYsR7n4mLmahSgIRoaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdHnvuBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16B7C4CED0;
	Mon, 16 Dec 2024 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734355440;
	bh=GJputwvqPFp8XHDoVt2MCbWbXO/bSXIWyKEjo2h5cdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdHnvuBM6bPFioPn2l9M8vNgNFewmnsOzAxSf3q89sHLdZ3C5rynChVOyHucUewmM
	 0mYDwV6FUv1676hrEYMT55QYQNcx165VWZt5SP7JteoTiEwqJX+2BWfVrILfikwbxs
	 xAGCYOt485Z6SE33E3RAzSB4IgSlBAP+LZrCciaVNccqV+Ms84wNDZ+ZqFmfHOsl+L
	 t7Qowf3T6dJrFHlW0oGQ6UqzgKRtHnvJPk+ybesAZr/nl8Zkn0pIU7osMoheC8E61H
	 BsMMiYBr77sZfG7Mvhxv8WbHu0gvQ3/zRePQE5nRMXCiD4zBx+NSOg51uHLSwd37dC
	 sJPlWoH/3/l2Q==
Date: Mon, 16 Dec 2024 13:23:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <855dbb91-db37-4178-bd0b-511994d3aef7@sirena.org.uk>
References: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
 <87a5cysfci.wl-maz@kernel.org>
 <709a0e75-0d0c-4bff-b9fd-3bbb55c97bd5@sirena.org.uk>
 <Z2Agntn52mY5bSTp@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tQvdM+9sz/vOFjes"
Content-Disposition: inline
In-Reply-To: <Z2Agntn52mY5bSTp@J2N7QTR9R3>
X-Cookie: Be different: conform.


--tQvdM+9sz/vOFjes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2024 at 12:44:14PM +0000, Mark Rutland wrote:

> ... didn't matter either way, and using '&boot_cpu_data' was intended to
> make it clear that the features were based on the boot CPU's info, even
> if you just grepped for that and didn't see the surrounding context.

Right, that was my best guess as to what was supposed to be going on
but it wasn't super clear.  The code could use some more comments.

> I think the real fix here is to move the reading back into
> __cpuinfo_store_cpu(), but to have an explicit check that SME has been
> disabled on the commandline, with a comment explaining that this is a
> bodge for broken FW which traps the SME ID regs.

That should be doable.

There's a few other similar ID registers (eg, we already read GMID_EL1
and MPAMIDR_EL1) make me a bit nervous that we might need to generalise
it a bit, but we can deal with that if it comes up.  Even for SME the
disable was added speculatively, the factors that made this come up for
SVE are less likely to be an issue with SME.

--tQvdM+9sz/vOFjes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdgKesACgkQJNaLcl1U
h9Dn1Af6Aoi1kYEJgEpP9SuLVKjtDdtspvPJ1Zxcn5F9yCCeGy6jEdCF64uMyukR
zRDEveJcHwLSdXwWI3vuogbEugswRQGaCZkqXq6GIYcqkL4bK0rZuO9MbsEY/evo
lSuvJTX77/lHZnIpFYVL6kMuDGgTanmm+moofxK6ae8y9edKYGpsNqiJsyIUQ44G
t0QqBHLFQzaEzjZV39B89oSIDWmilLJr6Hzw3Ht7S33xCa4IPICjfYxFSapua2Lg
nyqGOLkIVafK7Ob8Bs1ZnZdt84rL24d72f4cM+Frb7X7yNlWUstqJVRGjjVwxPhU
+UEB5595YufyuCdHMCBKWu8T64mNPQ==
=b0ul
-----END PGP SIGNATURE-----

--tQvdM+9sz/vOFjes--

