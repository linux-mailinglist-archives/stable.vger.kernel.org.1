Return-Path: <stable+bounces-118440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1294CA3DBA3
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D271170FF2
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC72B1F8BAF;
	Thu, 20 Feb 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEGUmksA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679681F6679;
	Thu, 20 Feb 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059280; cv=none; b=Rx4b+I8bjEJeMb4RdCGuRdIcaPJt1PWgIoV0LLL2l7UK+jAVUbke1Dj0lXi3z+vpm6DP9xxsxYT8wlbdzNG56ssc9+Nfns/Nanaum3xKmL81YtsyB8D7vZFmfE1w+j5gZXnQCy7Zjes6pxEPVrVMBRKShMw2HImXWiXZRMdi5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059280; c=relaxed/simple;
	bh=EjX5ESsAir2XqCs4X/4wihQDiTT7GnhS01VusetT0zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkr43Wr66yt/dMpajYvMXX9ZjzxKwWFBJWPSbDGRCL5Vo851V5jqDTCyp9u+pIk/nISVJEeowia8kDtSnFGoxHXb3FjZjdRHYFxlj4v0xqTcx5i/81JAnq9gC/+4hSEqFFl38s5MXFqMpcAfDdv1N6EUpowwsTcGo7B8eO1OCKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEGUmksA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CD0C4CEE2;
	Thu, 20 Feb 2025 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740059280;
	bh=EjX5ESsAir2XqCs4X/4wihQDiTT7GnhS01VusetT0zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEGUmksATg1sIRB8cvsqMF0uzgMUk3yK9i+uUh17+oB3uzuBn2iLOxHyj/Q5QZB8x
	 52sjSEwEvCt0zxFFS2oi/Xn2gN/1RvxSIwX/GAUJDLoPfRFBfxCiuK7KMUmFYdJ1fu
	 k/R0vD+iAZniaImx33/QayipVmMW21VcDXs9FwHrreJB13W+zmqeBtx2fhkn4tDgWu
	 sbZZV0DXIrUGh+4bUQTrj0hFEDBEAOfjYh0+WkmyvD6VK0yr2adKeUri487wv9YuZK
	 wmTfQAsVdFYTk5S9jR9DYVDGxWlHLOa9FJutSpVx6bCWj+JneVzCR35l/CunOA/HJq
	 rUMQDmmAG+QmA==
Date: Thu, 20 Feb 2025 13:47:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
Message-ID: <Z7cyjE6ZPUsIg_3X@finisterre.sirena.org.uk>
References: <20250220104500.178420129@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwqByohj4ynWt9DW"
Content-Disposition: inline
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>
X-Cookie: Editing is a rewording activity.


--cwqByohj4ynWt9DW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2025 at 11:58:18AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 258 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--cwqByohj4ynWt9DW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme3MokACgkQJNaLcl1U
h9B+4Qf/cZv/wUULd6C8TUejFC8UbJkwUKydyNt5JDqoeC3YftTcRdMmlSbJWroZ
cFcuCWdx13BnhmIhoFXvZY/K1NLEVsi5zwsDlEqAFA1+Obzq6unqCHXDGCCjKZhQ
SCeI60gv9ZpYqHLaZh2r+rWh2w5AzQQc4ejRH8NvXidK73BT+ey7CeSW9ubvLTH0
1z1B9IEZvRioh02GNDyXq7PD+vQztiqT3o/nWm61DEYb6260ow0pWLsJitT6V0JQ
7a+rm8Cbxz9J1hHJO/nbMhRIH699VCapi2oYGgw+4En5/Vcl5NXiGzRjlEj+jLWU
YcGQcItT+8klRjSL5tsRt3kmaV6O4Q==
=OquN
-----END PGP SIGNATURE-----

--cwqByohj4ynWt9DW--

