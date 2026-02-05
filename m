Return-Path: <stable+bounces-214450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGClLhSKhGl43QMAu9opvQ
	(envelope-from <stable+bounces-214450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 13:16:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36334F24A7
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 13:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BB6F3045AA4
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96C3AA1BF;
	Thu,  5 Feb 2026 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soL5zDUK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63035CBAF;
	Thu,  5 Feb 2026 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293522; cv=none; b=kOXA6Ssoeau26PdzgbCFlGywleBhEDpAXeObWxbrRRpfEnQIcthulK7mS2bzWjYtZrjClE05+9fBXe5YsqVHAs2crOPA5E5VL5xU0CKwEX4yEFVeukUX39B0tbTX59ve8cDiqdeItgxC5DC/ktZcDf0GtHuNlVDPuYRd6a1d2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293522; c=relaxed/simple;
	bh=r5rQ2mGQR2yd65bsIkBczjcUoz01MvRR1aYNFyIj1fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRBNxpbFQoT5bg7VLgw4Yzor6ZN/sA3S9pdmW0pmHsEZ02nAjpTnk7OP7wFu91mw8qMcNz6h9L+z6M4zmbKOt2rh9ubaI9z6bhGep04OfpmxGlty8opoXXUGNZIr+86EMoYBsoRtLSyIHD8T2a3IMEFMB1F86xmJ4EADqxGZSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soL5zDUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F98C4CEF7;
	Thu,  5 Feb 2026 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770293522;
	bh=r5rQ2mGQR2yd65bsIkBczjcUoz01MvRR1aYNFyIj1fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soL5zDUKHtUbqyJGhlRUxxXdJGP4iM2sjfepz0RjAr51rIbbeSYqXATql7gi20+JP
	 l+sSAG0lhLVenRzU/C/VjxcnxdOX/rs0HnaXYyA+v3GpeSY8GV/4yNNRkL5iUzC9nu
	 k7bcw5BzqofbNLcZPEFKPhMrrf3+P3Ebq51VcnGYPOjVle31MxseKi76LzD3w8dJm1
	 Jct5mxNkGI1NVMGkEEs2Qva4mKj7D0XZCfFp4/3ujrFsiFAmGX26UtOvH1mka7FGSl
	 64+qOXl5NZeUQeBNJnKJSERKG0q3WUxtdVwOz2/+sIfmq1IeJQhfR20Ypot/H5D6eu
	 aHF56YA7Jrp5A==
Date: Thu, 5 Feb 2026 12:11:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.10 000/161] 5.10.249-rc1 review
Message-ID: <4d7c35da-6397-4541-866c-2b5bc066601b@sirena.org.uk>
References: <20260204143851.755002596@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qBSZttGkiL8Gi9gp"
Content-Disposition: inline
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
X-Cookie: Non-sequiturs make me eat lampshades.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214450-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 36334F24A7
X-Rspamd-Action: no action


--qBSZttGkiL8Gi9gp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 03:37:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.249 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--qBSZttGkiL8Gi9gp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmEiQoACgkQJNaLcl1U
h9AVTAf+IZB1hwbZoLsm5kYXGo+gcN+3kb6jRNynK5PVpIumnQo63UnTqDalZHgb
yjTVKho9gWvHQgyk61zpMmorY1Wv2pVdH7YjTC1sbR64nC3TGeJ9bhkIByOMorO3
dBmygjbIdUE2wxRvstTBJZtBcsLcCPQgwTQHKTnTLAgXZoxljyp6EGcrAu/Vhjo7
+E1gYzVelv1QHQqFeL9VZ2lMreTCuiBIAwyJo3Wllwcg1Cj7HdpOBVCiM1d1qTdp
m/eMjki0uCgakdABcfZVzP8y5JGX3FmlecaU/dlUAdF9X/rYPJL2bElpbNEMNXlf
1I3ERciumxzP88sD3uIp30bcY9z8gA==
=o4ka
-----END PGP SIGNATURE-----

--qBSZttGkiL8Gi9gp--

