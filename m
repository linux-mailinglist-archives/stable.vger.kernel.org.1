Return-Path: <stable+bounces-143016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C7AB0DB2
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37863A1FA9
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0626FA57;
	Fri,  9 May 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="HTww9T2a"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D342741DF;
	Fri,  9 May 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780143; cv=none; b=TSD0PC59RbrN0GcF1swlmfxtMqf/ipdzFvKmptp09R7QlKXnnNVipC0WRJP/DBu8U4pnHM9F09N3UcACBlhZlruXju+GgDH7bYPqqyGLcOZGbPz7eNlXB3kWu6yaNM/frw6cdx/wKgoF7nMkuCDxvFnm9NbhlyzxgToK+cx4Vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780143; c=relaxed/simple;
	bh=SEoSsi3ett6o6pUdRiHxp7fe3M4N18U+wukVJjqimCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWitrcsm6WhzASPJq5JJwGPumNa5xSXU3gpJu+SC+WxDPS2aHDlCWi25AAZN+cPJZ9Po01KvfUxeR7lRXB2e2PpetwEMa/tedfcCX0bx78tADGmdfFBVjlAHzxgQBD7W4RQ12WIh0WzWKOQCnStu2ClRKEWBPwbTiya6SVUml40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=HTww9T2a; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1746780092; x=1747384892; i=christian@heusel.eu;
	bh=TIojQnKcGA8HumCrxDJ31cFYqtelx81BtXW1fwzCys8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HTww9T2aMAkVR2/R2rV/26WHTCdsJ4WTiH65/daYhEnY4wpH+nqlzmxOLRwB9zyL
	 Qw50npQv2v0g72CwoCbCqS2Am2zo2aV/soxyA32IZaj9SjPU973bFJW4jL4H+QwDR
	 6wM4dz6p7Id5qjo++5HRTefvTwnwXbObHeT/uXUQhPqBG7QGM+RSjsX0kzEJR9gIK
	 ttYfX4dzfFcK2y5JQpqD5LzM6EgbXI+0XpH/OznCL8+2BDkeXfGZ9ShlEzG0ZKyqp
	 i3GilVNGAqIuVrKvkTTkoKUw1A//ZrUFdYy7eOMxxYUJX5sBfRz0kAdAHsIXtj8Ib
	 tamqE6TaZ0b0Uln9ng==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([129.206.222.166]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOAmt-1uO4oP2IXZ-00I6FV; Fri, 09 May 2025 10:41:32 +0200
Date: Fri, 9 May 2025 10:41:29 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/183] 6.14.6-rc1 review
Message-ID: <e82396ea-ca7a-4ccf-814c-2d674698a839@heusel.eu>
References: <20250507183824.682671926@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3uhr5mzdzw2ymni"
Content-Disposition: inline
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
X-Provags-ID: V03:K1:RLGs2bY4QbKII0bIzj9LCZhoPD5sEVfNozmAVbsDnVyTS0+t+eX
 oRvy41WJTiLPlWaBE5NmipmtHomEEVB2xy0kwThayvTLyGmEU8G0/N9R/JpxiMbZ8jFFjBa
 EObbg3Sdzp6bl/EWMoGo3DZVxuiVcNYTMsBMgE+femjBMCGQ02ZyyhoifCQOmLqH/82NMlF
 MyUrNfWzYJn45c1yj4q1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qDBu2Cn7V+U=;0U2DSi3Fck/RImMwAgSzQ3Vt11W
 cQR0X5d2x+i6ipFcX6olsvezaHyyk0ffcacl8KfRBg4Cs3bYK6aNrJYt7i0aa6E2MmmPxtHAr
 OMjGUHB98TuHhPEqre9Gfrrcaze7gbDLqyQWBqQ1Wo0gZMmcV/hghBgLwU9rWJ4GaYD/yffhK
 XT+iscrAEfQqfUE7BiomfajbulKmcTMddsrNETfCorJ60gBFaCinVI4dcX3oo0oNdkSNbxkR9
 i1RgN13XVFcc0C3XGTRJTLhf83Po3QcTYZ8HXG0Mc/LYEAtY4Q2TOO0rrBxHcSWmUBrGppkwn
 wlYvzzlmF+Q6ZSDKtp3tpcyDGTBgfG+ecf58NH+aPkfap1IeCezoF64jQiHwQ+0mWoSw9Cihk
 IgOkevsGv4ua7BLItu/RGtWsDRZffue0mxkNZRYQXWMHsQFCHPPxmWTpc5g/xmISXcwyW1VS/
 HGbRwxKQvM2/MU5k5QMiUb9IV9fFw7uMjo1czHTmJHQcnf530mN2EN4u9FtptkR5ockQKMMYm
 3gPu7OCzuNsaSNOGzIag/LFSkGWg+oJ9qgZf767EQI30TtxoVW5n9nncPtJcsiz9rMJUjtKVA
 99XAFLi8l1fm0yG04gk88jNzko1pNmGnKZS//EV55g85lQg2jKbPs7wYRpVMmGIltTmsM94Xc
 Nko6TZ+NBD8MEox1hwQVyuYqNsX4vymo+HfKqT8HYZfvU9eCCVjPccecwO1/xhjFzstgqXgg2
 S7puy8cLshKiQnJfp728ZQbIO/XtOUSohMOH5L0NmESpXiHexoOVj1YJ0tTPqWKxa5dO1z3+v
 J1MixErSRK0Y9WRXiwje5t5EWDUspIh29r/bqeRA/3gqpsGfro6sehEDhp0pxjEZnWzc2GJTc
 ZGr4YosVFkMwTtfDB106P9fnUZB3BaMxsUJD72lmLajQzGuehTGxSbMtA7gk72EBpthXR22J1
 hp0eO2avh8VdRR0Tk5wTioyglby3278eXzgfeOVTX5eK0rx/okctAjeXZiUcWKXrUkV0MNsMY
 W9QDTtZW6PR2fWF6gBhlPQ1/2L5ldav6Yi+ybfXUFladU0mOM+t/MLLnQUNKDriAaT9k7DqC/
 94wSz9RdJW+fEJm8YrIThbpZWaxpa96CdgnOF2s4EWvIIttAbNVXqAiFXcuP46bL0RZDxdRNS
 7shnMHInCEN9HvdH7/R4s8fEMvSWJNp2McGlrXkaHz3KWCxIIheRvLOXkTKw4cwNoAboce4Ie
 4QiBaE7M2kPpel7cBAou8jb7Z6TohTPgv/QDwGZSFF/s6oNxHZe3Jg0AFsYbIRA9vpHLE0s2x
 SeJEncSYQmtQ5mVS38KXMGgo8LSrevCcnlG9lo1ycZqJ26E5RZiOtkwp2tC9Vjy+UWR7dh62N
 EdXSnpEQ0itG+uN7yo2AyaDuJ261ODBY9iYTrOHWJz0T3ipz2UaElqPn+4L9O4wGgDWvf/Pn/
 zSe/0uQ==


--u3uhr5mzdzw2ymni
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.14 000/183] 6.14.6-rc1 review
MIME-Version: 1.0

On 25/05/07 08:37PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--u3uhr5mzdzw2ymni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgdv7kACgkQwEfU8yi1
JYWVNA/9GxCifOOnIUC22tB0WhuybgI+4sLGs/5alIJXygyPz0zwsQ9B+/aMfz6I
ga/inQOu039/mJHjiymqF9CZ/Ly1U9HZz8WXEFbwqJTFpU49DdOzOyEyHVxJxs+G
TgYwRy2dFSMpPS43SoY2TlICURgIJV2S7I2sQMYXgqSR8bQlxCf1zr0Qm/1u5v7k
1jox+xPGjD4rmOVFb8mrvLZSUojhdEjTicMbFcEW49amY0Kz1F/93k6Pf++zD9KU
sz4WD7HwDxcOX5SlcFstFXObuREp2B2/LLXBgwrl88d+usGgmk0WTrX9QFE9dGkW
2ITYdMz26yeE/NmpDTLtPt7p/awsEsJ+Li89wWZPOZrwb/k7s01hil34XpMqd5KX
4I2tTeWUTXgWKh6te4ImBtIs9SR26cbCzUCCTHph9tjSmQRdH5d9inxs756V4a6E
SRoutX/g+gL23UIHEav/PJsOXn6kqGEg2FNbS52vrmOIR/XoUwBNfAoecP9XAlNF
5QfgQs4vPUdUfevXIToSZ1MGeaZOPWfGc7RBxO0ttZQtvAz4QLQhOFiewlpcUtZl
S8juvuCbAgJAuzxkttY1Q69z5J4XsAFDKCVUhsLc2vsgmg8zg67rNgqKChn8Zjsf
gkuTLkHM0EcO15GtxK/tisCRA+3eHgxXw5SL8XJ2f5HFl5srVok=
=g2YJ
-----END PGP SIGNATURE-----

--u3uhr5mzdzw2ymni--

