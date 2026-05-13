Return-Path: <stable+bounces-246897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ns8Fa2TBGrYLgIAu9opvQ
	(envelope-from <stable+bounces-246897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:07:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D6535C0A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A8153058384
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1C477E41;
	Wed, 13 May 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycxhpsog"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEFE3D413C;
	Wed, 13 May 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684566; cv=none; b=DDMu7sLRR8AMhLpvuTNPh61I+FmsfJItTtyevqclhXpLocIltAaTjjM2dpCJufBa6mHSvpDs+/bTnFlQAFtWBJFsm5uSP1nkiBkRCMdOGC6GOS6Y03+UZ1C/hjF22BTpcBwlj19ixtR58NyE+8aLUjBAHuBsBySBaJSzgRb6q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684566; c=relaxed/simple;
	bh=/XSeiiJr5eoVT9AozxVDFtM36fxG0nrnTSRuUepTcS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qfigz9UhCqdjLAl+6RRTgh9SE7A+GCYeF2JaKXd+V3vyKoQQwB9H4KbxaAkMHOu1h5+YIdaC/+f8ImekQ2AtWsQt8aLcuyvbf77YO2Il3mzWZAO7r2cw1opgYbZAd+g4z2S0+jmoTHjCLsQs2Wd64HnWTBxXmE+y7qS0akoTINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycxhpsog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FFBC19425;
	Wed, 13 May 2026 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684565;
	bh=/XSeiiJr5eoVT9AozxVDFtM36fxG0nrnTSRuUepTcS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcxhpsogAa8hcBo5awcsIsUPIg9jrWd7qlvN+7j/VusRi2x1dbSbxA+Nzxbe+yjaX
	 8MLigV3SM+f3ey5fP64+prui86Gk+Wr2Cl+gP0SKZ80oMAras5EM+RIManBhATm1GE
	 Nib+MVVEney0ayTDyChODXzApQCoxNSXmIrgovTJpfMieqk6VOx7ytBzJdM5C3ZV0h
	 1lLkVS1V7SJ+rNUbiutAL1oRCk6K999ARODxBklKQFN5DrWnz44wq5q9Eh9qkuBe+k
	 P9OWNeQAZnG4UnkBnebzedn5usRV9zbyZ+tIctjl/HP17ZcnpL38nIV9ITWNO5AsMJ
	 iQrfqVP6jyJJQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 910871AC58CB; Wed, 13 May 2026 16:02:43 +0100 (BST)
Date: Thu, 14 May 2026 00:02:43 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/270] 6.18.30-rc1 review
Message-ID: <agSSk1ciwekdqUiP@sirena.co.uk>
References: <20260512173938.452574370@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ot+dvuSws3bXQzNM"
Content-Disposition: inline
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
X-Cookie: Truckers welcome.
X-Rspamd-Queue-Id: 8C3D6535C0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246897-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.co.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--ot+dvuSws3bXQzNM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 07:36:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.30 release.
> There are 270 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--ot+dvuSws3bXQzNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoEkpIACgkQJNaLcl1U
h9D6FAf+IqOqP0wLjpQNp+PgjmtKISDfD2sPQctexazfYpTuhlkDOg7X2HkCUODe
7+P/8C8poEGnlNNkz5giIM1oXVcleK7AgFCLsSl3Fropm/Goryqq5nQx8co1QVe/
4+yYgvzoEbVrq81gPbVM7VL+KO0DeEwrwVSxhoH1UN6rO1XcHaJIkaWGYBk6S9gG
fbDQLGQFRzBhc4hc0+X9LjQAuTejm0PedYhQZlJTgfDP1rj/ibLHtawN0KnLY9iU
6o/g50tSyM8dBneOAwHycuLAiCtS91VzeY4mpQf78jQNSw0XtbirZY1IJ5Zt7D7N
T+mEEGuFiDJKdE7TJXoq2+AgzCwlNQ==
=ETgm
-----END PGP SIGNATURE-----

--ot+dvuSws3bXQzNM--

