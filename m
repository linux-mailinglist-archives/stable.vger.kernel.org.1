Return-Path: <stable+bounces-91443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B09BEDFE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE021F25941
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBB11E5712;
	Wed,  6 Nov 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGmwz3OA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD181E04AD;
	Wed,  6 Nov 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898748; cv=none; b=fAH9Ly+vjSFhE9LC1CSNHqVuejoEw2b5wx9udpwJODhoz6Q/XemdxKTKG16/sCbAjpzonh5h+Du6GWQnPbS2Gy6drBmx9tFsGnaGSgST+nELCL/LnzuyIFGNTtqJGmbt6zVISQW7sMB7evaSzsG+k6kECWDY5uOUazUchOVUAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898748; c=relaxed/simple;
	bh=3SfESvrKfdyPsR2Toa1m1lCX2fQeSf+A2nGffmF11BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGenyS9gPLtx7E6bODNeeZZ1/tPEJEKkj+J4+/XTZkcJPYSWn6uQWcm6BCDFIiFRAkL5j1sotrOTiaSCg+PyMx41lyM+YpaMufL1+abpqBQdrCJyRxT2vVBw5+11Ify9NVwF2YJtwBhmxSsnjU1hfVN17jLcZMU/yk76lDNu0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGmwz3OA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AE1C4CED4;
	Wed,  6 Nov 2024 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730898747;
	bh=3SfESvrKfdyPsR2Toa1m1lCX2fQeSf+A2nGffmF11BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGmwz3OAHtxzQimhPb+0ta8GU6ekMnC0Nr55rDVo5Z3eBQBSlzx2R0yCIlpqJTOug
	 j2jouZOq2FDue45FB9L57askeLY0wQvdBhk/Gs0RrA+xfuh6r844UNGSxzP1OQXWIs
	 WXhKJLIxD2erc+Tx9VY3wDSHDZY+JfqC87LI5/t4yCyTb2NIa+Jd6NPO6/Ndk+e/sn
	 7wPD0pSWLEOAvVSYTLYShwVsWDCllhThbE4uSdrDpnIealbuz3ZctYPnh6JBIFnxXG
	 77B/lfXugrwKHs9CL6LdpZVWzV+0Ah6f+DmjxZMCmxviBIoCDOqDZRF9mx6ufS7cB3
	 YKiC40WL00LVg==
Date: Wed, 6 Nov 2024 13:12:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, conor.dooley@microchip.com,
	Jason Montleon <jmontleo@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev
Subject: Re: FAILED: Patch "RISC-V: disallow gcc + rust builds" failed to
 apply to v6.11-stable tree
Message-ID: <20241106-undead-cupbearer-a22f27c8b9e2@spud>
References: <20241106020840.164364-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T7IwLFePnUSWKnbZ"
Content-Disposition: inline
In-Reply-To: <20241106020840.164364-1-sashal@kernel.org>


--T7IwLFePnUSWKnbZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2024 at 09:08:39PM -0500, Sasha Levin wrote:
> The patch below does not apply to the v6.11-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I sent 20241106-happily-unknotted-9984b07a414e@spud that should be a
6.11 viable version of this change.

Cheers,
Conor.

--T7IwLFePnUSWKnbZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZytrNwAKCRB4tDGHoIJi
0lrZAQDwZgrJpDCrMBOUflphmluD0ARCIvhYF9shsNzm9sAm5gEA4dQEww2rvB2W
ETWhXsstVjfNvdt4kg8SZh+nFLTwKQc=
=IEMP
-----END PGP SIGNATURE-----

--T7IwLFePnUSWKnbZ--

