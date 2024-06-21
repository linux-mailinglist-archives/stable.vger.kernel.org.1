Return-Path: <stable+bounces-54845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 202FF912F90
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 23:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D035F280FF8
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953316D310;
	Fri, 21 Jun 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WNqsqHjI"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F64A3F
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005359; cv=none; b=l7zFneAz52vuWwRepnJbretcfHw2FMrASO+8TNUThjJmz/2NLDZPMo1UK44FkbY9U/1ty52BoTo/4uFhAvAUpFr4xlCqS5aaqhHm4HAs5w2sFmKb2NZCr8dWNlOh5gd+0tFM6X5vzLyJqgTem9psfPCAp9pQpS2z0H4viOKh6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005359; c=relaxed/simple;
	bh=Zd4saSiqCKssMjKaqz2Ol3OuXzU1mdJ2OqzqwTxZ/Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCHPCHQKpuUbjLcDlxxNkZXxdHMrPPMMssZHKMZNvqTBoLNtxZYlUrKF/yVKtLrcCTTIEAWp8ZjR143ycUbTjc8sNjUB4cMEXNIQZL0se8rCq907a5X0fZhli5KG4loQ0b4744UTSHdq7o+AAkSaTityLmO0aPlMBEwaBQ9PzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WNqsqHjI; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W5VqF20Qyz9sQl;
	Fri, 21 Jun 2024 23:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1719005353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27jhZNb8HotDFeV+hKVT7NMwfY4iifHG0Uh+BspSccE=;
	b=WNqsqHjIefkSvVskYF/rQYsyyMicpBSrP3ToasB98wBAjuwrfrrcdSUffyYYbve90UNhoD
	jB3xQBveaCxrddpOln7qyiFfJb+btCz5Tu/2X0+vxUzAN9BACAi5/KBb9uyq6Ge/MhmJ7F
	ch2oMN6FEyAjfDRiSQ8kUVAcHMFuXoCg9rMhEGv6uRznbyWcHvsN0OUyqqrNd7h2cEVeZJ
	eFDfCqiE/TPqeJr97E8QL69sj56japL2zOLs4JDjzn5ty2FudX7/+lAHARnVn1jz8Cn+Gv
	l7wGFJVVkQ+ibvSe0JPF0PO/aOntz8HEXrmbhSlNp28zk2Sn2kPqcXMIxLD6bg==
Date: Fri, 21 Jun 2024 23:29:11 +0200
From: Andreas Radke <andreas.radke@mailbox.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, yazen.ghannam@amd.com
Cc: stable@vger.kernel.org
Subject: [regression] x86/amd_nb  in 6.9.6/6.6.35/6.1.95
Message-ID: <20240621232911.01b144f3@workstation64.local>
In-Reply-To: <2024062120-quilt-qualified-d0dd@gregkh>
References: <2024062120-quilt-qualified-d0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m07L2NiSBW6p9MGpSVTgNpG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-MBO-RS-ID: d3d178cd23b397d7315
X-MBO-RS-META: ypqkhm89ekuq5ti66khxwzsrphej4w39

--Sig_/m07L2NiSBW6p9MGpSVTgNpG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 21 Jun 2024 14:59:20 +0200
schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

> I'm announcing the release of the 6.9.6 kernel.
>=20
> All users of the 6.9 kernel series must upgrade.
>=20
> The updated 6.9.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> linux-6.9.y and can be browsed at the normal kernel.org git web
> browser: https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable=
.git;a=3Dsummary
>=20
> thanks,
>=20
> greg k-h

Subject: x86/amd_nb: Check for invalid SMN reads

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/?id=
=3D348008f0043cd5ba915cfde44027c59bdb8a6791

This commit is breaking lid close system suspend
and opening won't bring the laptop back and no input is possible anymore
here. I have to hard reboot the laptop. It's a Lenovo Thinkpad T14 Gen1.
There's nothing in the journal.

Reverting this commit on top of 6.6.35 allows proper suspend/resume
again.

-Andy
Arch Linux

--Sig_/m07L2NiSBW6p9MGpSVTgNpG
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEErcih/MFeAdRTEEGelGV6sg8qCSsFAmZ18KgACgkQlGV6sg8q
CSv75QgArzTyAKaMUZCxLHIqSLF6CMidnkX/gJriqUW1U2INiUGUQuxEJPg+aij2
qglTdJJQOYv7j8A0M1/qYWxM/3o7laS60D4hd7VFz7daRJLJoh2YWeeFnh54XxW3
U4UnsfSv6Z0zZmvbtsbN17xTO5bTILtWQiESE0ngXUaI0N1aFHQwVTwErTeghItG
464FNZLakL+XaovdpOXljtKONIVF8n1DrpTw9zx3ZEddh0y+MJPMcUhXnl9ch/t/
y8kI5C5xtDx0peMgD+HNWiSmr/tRpACFrOe3eMyv5v4e/Esg2AtzVoivouKE1IuQ
luzPlTKsV2iuGmhqlF1eklX05yaYGQ==
=B73g
-----END PGP SIGNATURE-----

--Sig_/m07L2NiSBW6p9MGpSVTgNpG--

