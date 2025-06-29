Return-Path: <stable+bounces-158850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3137DAECF59
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412D87A42A2
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589CD235055;
	Sun, 29 Jun 2025 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="f5j4E4oj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YppB/KH0"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427C235074;
	Sun, 29 Jun 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751219569; cv=none; b=ENHEwxIAHmjNEtk8Cn6uPH53mb8uWFQN0WwbLE8rzeTHcbuWjH5zeILaHUFZqwIenfVTc6v2c/4dCoaoBrGz239VylVEuG6QQB3z2Dl2hpspQcbiDuFjH2Ww0aUY1/oTfC50xTyTVaIGyZGkes92o4EIRE4Ml32ZprOxNWn0ACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751219569; c=relaxed/simple;
	bh=Jh3m77P3PQ/B7E+ACnzpZWeLOCGladQ4T7buUTuFBEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkjVs/neP3CoaenbAzN+I0HbunribfE2qzVl5/DDL6IrDPexw+lVmqNeiYhgj/7wImbe8RnwtvVQ/A4XdjYToJEvJHiOiOOD9LUGjWOEYTt4/dsyFz826vblCseDeTo5xURThDeJrVJH9quy0ayJmF+J7t3gvGL11XqgA7nF2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=f5j4E4oj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YppB/KH0; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B10927A007D;
	Sun, 29 Jun 2025 13:52:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 29 Jun 2025 13:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751219564; x=1751305964; bh=sTmHH/giVf
	oxCmMF/goE2epW2Hw/LB/RMXLl9DOR2ro=; b=f5j4E4ojW2SFu3kpWV7gWwrIgb
	XKy57GGZwWPIFPG3XB87e79r12RVIbQFAb/13M0L/wAmYZiSnTei6HWcmz6ret+Q
	w3DjDxc/spcBglS8RKWZiTiVpIC9GITUs3wnSe/Mm7OElnVsNf91GFOP+VzHsuDw
	Z9Z+7mfGJtOqj2Rgy4Wq2mM3Wz7YT6uqQDdnXcKezsdYmOdNDIL2h9jM1O4d1dxB
	ZjY4E4FXJMZRhDWw7aoaPnRZP3gCD0UM/71KNtKEtxIiqAqjl9+Pw/DHVgXYT7hD
	J+6GsN5jKNUNFJAK4sXfxIyZu34k2lL1M4hxF5jfVGwY3U6xqwNr0Y2PbXNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751219564; x=1751305964; bh=sTmHH/giVfoxCmMF/goE2epW2Hw/LB/RMXL
	l9DOR2ro=; b=YppB/KH0N+LG4+Cg78UnNp5bnpZJf08Rfw+ec+2j++kJL/NTFIa
	+7ED9nXU8DZKbKlASMuxjmr7FAJYF5U12kzsu7ttxNCS0blJUEhSYWUVsHPTJIEs
	shFSpJFZpHzoFCXiClddgYzirvkmmj10/ws+WGlo51eCCb6vgfZZRHWocfpj61Nv
	CWcW1FLSyHqCLBvWTefjyFrD0FRK2ZdKDNu8AstO25JBG32AIhHPs6AhOYZaoPVu
	ggqvBRZ7i3ye3N611q22AaM0lggGCRlkbG0DEd54DluFhLkq0N3ZPc+eBpFlhaXL
	sJNkpLXtOIP4CWHQKbp3VM9vlqsx/PSCPdQ==
X-ME-Sender: <xms:a31haKBd75CUdoCH8koM-xwpb-h3Yb6jja09aIa11AxcYdU01TNnfA>
    <xme:a31haEi5fhuSCbKro6klStF3QSFHvfyFMbHzaPgwq_myh-mQcl9OeIdalwngADwCJ
    HhSyiX01b2yAaYI4A>
X-ME-Received: <xmr:a31haNnrK8Vh-2DRb2f5BMuxqj5DJCesWeNCD_cMTbM1llQcbPEUujD50B5lr87v4HhHGZmLwdDR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesghdtsfertddtjeenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepledvvdejke
    efhfegteeuuddvgfduueetgfevffetudehvddvgeehueetgeegtefgnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggp
    rhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhioh
    drlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopeihvghhvgiikhgv
    lhhshhgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrshdrnhhovghvvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhimhdrlhhinhgusggvrhhgvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhdrjhgrmhgvthesihhnthgvlh
    drtghomhdprhgtphhtthhopehrrghjrghtrdhkhhgrnhguvghlfigrlhesihhnthgvlhdr
    tghomhdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhuphgvrhhmudeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvshhtvghrihes
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a31haIzNh0j_ejP-AvfP2DrnDp7KEuBkQREksGHKEoYaeydumDwFmg>
    <xmx:a31haPQQ0gVd7zIou7hz8RCvRDASd2D9VE_FDeE9gLdkoK41Wyf12g>
    <xmx:a31haDYMg-9eBAadpIg6DmdFXx7sEoN6d2JO6PpJRC37Lg3USvQ5zg>
    <xmx:a31haIRIKkB5lw3tCcd5pLrIlOF6hStTBq-z9I42iLyGcfmU0c2L5A>
    <xmx:bH1haCH8zel9jedTIdbMr8AZ6V4WqPeFXyazB_QDA7tASwDRRoW-VFrO>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 13:52:43 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id E5C02C2C24F; Sun, 29 Jun 2025 19:52:41 +0200 (CEST)
Date: Sun, 29 Jun 2025 19:52:41 +0200
From: Alyssa Ross <hi@alyssa.is>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com, 
	michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com, 
	rajat.khandelwal@intel.com, mika.westerberg@linux.intel.com, linux-usb@vger.kernel.org, 
	regressions@lists.linux.dev, kim.lindberger@gmail.com, linux@lunaa.ch, 
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] thunderbolt: Fix a logic error in wake on connect
Message-ID: <cavyeum32dd7kxj65argtem6xh2575oq3gcv3svd3ubnvdc6cr@6nv7ieimfc5e>
References: <20250411151446.4121877-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3u3w6kzefk6kcdxr"
Content-Disposition: inline
In-Reply-To: <20250411151446.4121877-1-superm1@kernel.org>


--3u3w6kzefk6kcdxr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [REGRESSION] thunderbolt: Fix a logic error in wake on connect
MIME-Version: 1.0

On Fri, Apr 11, 2025 at 10:14:44AM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> commit a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect
> on USB4 ports") introduced a sysfs file to control wake up policy
> for a given USB4 port that defaulted to disabled.
>
> However when testing commit 4bfeea6ec1c02 ("thunderbolt: Use wake
> on connect and disconnect over suspend") I found that it was working
> even without making changes to the power/wakeup file (which defaults
> to disabled). This is because of a logic error doing a bitwise or
> of the wake-on-connect flag with device_may_wakeup() which should
> have been a logical AND.
>
> Adjust the logic so that policy is only applied when wakeup is
> actually enabled.
>
> Fixes: a5cfc9d65879c ("thunderbolt: Add wake on connect/disconnect on USB=
4 ports")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Hi! There have been a couple of reports of a Thunderbolt regression in
recent stable kernels, and one reporter has now bisected it to this
change:

 =E2=80=A2 https://bugzilla.kernel.org/show_bug.cgi?id=3D220284
 =E2=80=A2 https://github.com/NixOS/nixpkgs/issues/420730

Both reporters are CCed, and say it starts working after the module is
reloaded.

Link: https://lore.kernel.org/r/bug-220284-208809@https.bugzilla.kernel.org=
%2F/
(for regzbot)

> ---
>  drivers/thunderbolt/usb4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> index e51d01671d8e7..3e96f1afd4268 100644
> --- a/drivers/thunderbolt/usb4.c
> +++ b/drivers/thunderbolt/usb4.c
> @@ -440,10 +440,10 @@ int usb4_switch_set_wake(struct tb_switch *sw, unsi=
gned int flags)
>  			bool configured =3D val & PORT_CS_19_PC;
>  			usb4 =3D port->usb4;
>
> -			if (((flags & TB_WAKE_ON_CONNECT) |
> +			if (((flags & TB_WAKE_ON_CONNECT) &&
>  			      device_may_wakeup(&usb4->dev)) && !configured)
>  				val |=3D PORT_CS_19_WOC;
> -			if (((flags & TB_WAKE_ON_DISCONNECT) |
> +			if (((flags & TB_WAKE_ON_DISCONNECT) &&
>  			      device_may_wakeup(&usb4->dev)) && configured)
>  				val |=3D PORT_CS_19_WOD;
>  			if ((flags & TB_WAKE_ON_USB4) && configured)
> --
> 2.43.0
>

--3u3w6kzefk6kcdxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaGF9ZwAKCRBbRZGEIw/w
okxoAQDBclWigTvBxa6JKIkkt52I4sMh08AHziTd+wt3Sl2g8QEAp6S/3yciQUx2
pXrMwDIZuq7mBlrT3HJOmOu+FOqI8AQ=
=B+2Q
-----END PGP SIGNATURE-----

--3u3w6kzefk6kcdxr--

