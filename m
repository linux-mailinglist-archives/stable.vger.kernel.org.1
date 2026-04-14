Return-Path: <stable+bounces-237955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAdmIjKF3mnjFQAAu9opvQ
	(envelope-from <stable+bounces-237955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:19:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B2D3FD924
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45E78300BBBB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2245318ED2;
	Tue, 14 Apr 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8zc0Qg8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF830FC1E;
	Tue, 14 Apr 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190767; cv=none; b=WaJuMcLZipEHpbH37gu/NAqbXV/YLmm0Ek+AVnTs2CKj6MO2jwFBdpiCwMj1Ozjlj74GC6cZKC6I7fM+qztvljafK9uygxoEpZ2kfyAgXZ2FWrD10JQBWQAR4RbPtjrlJD8bhWBPrG158+XjlxsSDzk7MMdNmi8yg7Gam8AxYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190767; c=relaxed/simple;
	bh=uDlNxdNmwJW2szyXUb7/D7F/c6EvJjkv5oXFsDZSH3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe/BGEg50YOhRnb7lNxSL9iwuyfuvxc3SgYzrMMWlLhOeYb8Az8mxTa+g0GL8iIh1iauuoSO1HP7uT6tBMr2lt54U6ft4Twsqe6cVbIVPOhTFwEb7Zi7pIckC+bdknrutHWmoB+iOzyheKQRAgNy1Wt7F5kTNFh60eNP8pmmUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8zc0Qg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28A8C19425;
	Tue, 14 Apr 2026 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776190767;
	bh=uDlNxdNmwJW2szyXUb7/D7F/c6EvJjkv5oXFsDZSH3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8zc0Qg83cHvQ5bDnSl5PcQ+cS405NsmjRMsM4wr6Bhz7124F2/UcI2iqWYMhKfwh
	 /LL3/5ymArXjJFHe9yYgiwnE8UewWxlKH0dlw23v/JfO++A7W2cYf1c+ds3hUyX+Qo
	 /RAci4OJ/qIRhszbwBbXoLW+nCkGHCFyyiOETdHhxuJUtbwr4D4clZzNc2wS+kRO1F
	 +dObxTpTlHUQS8GIMXXxP0cFZ+qhdUe6FJeNy5TRZD4DjKSNkHnj1QWnLMEeTlu9ob
	 xlWQEhTVu2PaOYI6XsqxXqwmPVDMMCoi7MLo8i21dd1tqQhYKH/FcdK22ePUQFW8/N
	 NiDYgWElPUCwg==
Date: Tue, 14 Apr 2026 19:19:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.15 000/570] 5.15.203-rc1 review
Message-ID: <121d4a97-2514-43b5-bb13-97c21e272fd2@sirena.org.uk>
References: <20260413155830.386096114@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NjHWhZ5zH2fbo9Mt"
Content-Disposition: inline
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
X-Cookie: Academicians care, that's who.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237955-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28B2D3FD924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--NjHWhZ5zH2fbo9Mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 05:52:11PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.203 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--NjHWhZ5zH2fbo9Mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnehSgACgkQJNaLcl1U
h9Ds1Qf+KaDt7m86igIJo2926ghStPVb4lQE1u4KZsLDxJZKzCH3UJHy1vFkTPlM
NOMJMyzYShDmb5/yPhAKuhv7NCv6smdnnN9s0WUb/vmKor5xiFIU04AS2vVhefuT
8OfRY3F8Ehaaj9AnudG7vwvrINl3GpPQKIJAFN0ScM4YdNBsEXKB3htpbWse7SuY
cjIOfCy6PCVJLSwWSV9N9WDkyG+6ZDsCipKAFv9/xDg/1g+fZnaS+tcQQ0gF1vl+
6mkS8np25sPlWe1MOtsChK+5I7Pv796SwL6P5dHBPrUOal9f0NuCyrSXjxuKYJX+
1o2whrNaelQHYcGsOiTpo6RiXj/Llw==
=iwQ2
-----END PGP SIGNATURE-----

--NjHWhZ5zH2fbo9Mt--

