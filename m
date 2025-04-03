Return-Path: <stable+bounces-127708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC08A7A7F4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 18:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDD81897613
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768524C669;
	Thu,  3 Apr 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBT04nq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48227706
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697648; cv=none; b=puVXmLNtN89NNMZ1wyqjEGx4kWIIkdU8uReOawrfBOdtbJtM22EQ2h3PZPUSIPtjN3Wb8c2jq3iRUI/IL9y2eR9NRe5KFCoRxSlKZ12CKHriaCSFsz9AXAwi/aQU0sHx5OhdTgQk3CZnl9D7Xfh4vfRsUU3difN6QPY83VbQz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697648; c=relaxed/simple;
	bh=2exr5hDVgpyfq3+D2h8GsMjlPDnBlsybrx/9SoQ3H3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxVBaHG9bGH9+CDGAst/93ba9daDX6HsasTEHQ+f6dfrL/LKA4i8Wkk+zW7ew8E21cexMQ14eDTqOwx8kXfUGUIz+JfTBWPHDxqCO8h/+GrtwXdPFvrRYnKVBdX/SJuWUXczTPsoAXnDQAhQBMi3hm4xGrhY0g+le3KKe8swV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBT04nq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF215C4CEE3;
	Thu,  3 Apr 2025 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743697648;
	bh=2exr5hDVgpyfq3+D2h8GsMjlPDnBlsybrx/9SoQ3H3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBT04nq0jiuMlN7+tC5P1MoNb2A+FZDbm46XFFuhHcHdDpGNAZ/mhPG0oEpt9gkNr
	 XBpn+ut4NR7sbu+u1Xw3B61WFtSDxXc26aQzN+ov8LK6xdKEG779m8wDu9o/XubFu9
	 LJzhpZWUp+YgC2OWW3k/nTBGUFyHKPTnq1sJyOvJce7pBsyeT5YLM404SAMIQi/vrz
	 Mdq3uISuxUhewAYwKDBk0Sg+3+LZEUBCPll/wAF3xbyyw9jGoy0lDGF6lLU1n2b2OD
	 YoQFVraq7LPL6VhKsOVz0AvwaQ7yexnywr2hRDHVY6AUjUmsP3DdFsvt9hrMDnKpZy
	 8xeM5ggaWBmng==
Date: Thu, 3 Apr 2025 17:27:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15 v2 02/10] KVM: arm64: Discard any SVE state when
 entering KVM guests
Message-ID: <8652b1b1-bd08-4691-b8c8-52924943c87c@sirena.org.uk>
References: <20250403-stable-sve-5-15-v2-2-30a36a78a20a@kernel.org>
 <20250403085850-45573ddb54f00a4f@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Np60IhCyns2WLeaI"
Content-Disposition: inline
In-Reply-To: <20250403085850-45573ddb54f00a4f@stable.kernel.org>
X-Cookie: Logic is the chastity belt of the mind!


--Np60IhCyns2WLeaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2025 at 11:39:22AM -0400, Sasha Levin wrote:

> Found fixes commits:
> fbc7e61195e2 KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state

This is patch 6 in the series.

--Np60IhCyns2WLeaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfutusACgkQJNaLcl1U
h9A5zAf/Z7E969s49S1iSFpQ4h7R4XaP0f8K/cYur3AuT1mHbtyIqN4uHK28FJ63
+dmFpr/dvtBBzEfzjjdpvFkLJGd3NaJT2XAkLTiJpFXJOs0DhgsBkB6NMZ+llzck
SLL3WVwiwr7X9U+/JzLo0y1oW6SCiT2a+mtiylNzUFpXwQhc3r+Wy8//YTABuqNS
JHyGZy3cbnMMWu0cbKbxkzbP+euNC0BtyLREhuxEee6kDXXeaf+czCYRl5w0KWUh
22NQUfki/hrLUJdvVFqNFs7u7nqYyKi4hlU9mXCMMq8zmFKy7EokNQCcGGcMgxL+
et6y963zSoCxD+nH2nsPO58fbXV/Xw==
=0fBk
-----END PGP SIGNATURE-----

--Np60IhCyns2WLeaI--

