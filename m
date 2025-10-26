Return-Path: <stable+bounces-189769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7EC0A884
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2553AC888
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 13:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41381B4F09;
	Sun, 26 Oct 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="PAnH4y4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ee4IT5D7"
X-Original-To: stable@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF3749C
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761485187; cv=none; b=UZKteyveUzkG2k5de0T1U5BcjshZLbAwNqPdRVSySAfRc2ber7Wyael6mwKLdBiVvw/Q+8Z5niydvig/HbTUXS4b1+kdivEdtbCF8CerBBCAEHVQ5s3MVAI9ssaKJxnd91tQ6tOa14hCkTO7lTiER5gu/gzR/RUzaJDtCD1G24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761485187; c=relaxed/simple;
	bh=BQ3YAtLrDglczezxYXDYCs7l394Xp2Z8JbEVcWHM0hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4O7sd53MHJRuJmPkX0DNELHHZvfSIQz8vumtT8KUqZ+M+fb9zgaqhKDwBjLm3UF1vsm7sen34r8DyXQovVDFvDBommr5SeUFOOFJ8f4fkjCskFLl7SC8oJWptOxjtoWrcEMxuh7TTaQi5B64CpAzpdz8bJLioC9XMaHQFnILbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=PAnH4y4e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ee4IT5D7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B3038EC00BB;
	Sun, 26 Oct 2025 09:26:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 26 Oct 2025 09:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761485182; x=1761571582; bh=BQ3YAtLrDg
	lczezxYXDYCs7l394Xp2Z8JbEVcWHM0hg=; b=PAnH4y4eaUfCS0gQ+ifpxD94ad
	0gFCkL/THg0uhFiUsLhje6m0zDpms+VfiQsYUgspnV0z4re4njcG6nU348plZwlj
	PUkKxSfaKTYxAWz35G5V84hipGa+qLz0fGa07cGqsmOzxINVtfZvtqTWwwkVFpJx
	LCyFS5wmeEFUCt1236vdwsdg1RSYl+fXSs5tobfDoKWGtwuoHX8pTAtazRDEbC44
	6cSyG0sZHcagagTldl0D0Zkk+UPJaBa2LmF6HfYOXeTBJXX9kjiZh0PE0fa5Q9U3
	wAVBfDrQwyGNdk5HrJatDfocH9kpybK/2SXgjPB605awWiNyLwYBEtD1g13Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761485182; x=1761571582; bh=BQ3YAtLrDglczezxYXDYCs7l394Xp2Z8JbE
	VcWHM0hg=; b=Ee4IT5D7GCnW1E/MjplD++M6JG533WivY4nE1yxbpx7Y5OcOlYs
	6InrO+jG3xrgdXU7b3wfXgEh88LTFhVMvYIt2ywmAUmijhqc2iMU1Xsp5HROjulb
	1v2IJ0popAo1FSRDIDFJddHWzW6OpuTJgO4K4kUjHJb+vzPjIHbSYF8vLwwXhQek
	ybT1YjaWwUlX9q1Vf6BQutpK1sJV/qrLc+Ca/RRbpFzn9SkvyxthQr3wzdwJiE6S
	5sli8RX0GgniiRnKKPcVu4lsfYo9w9aF4XbyZ0ZRsXJhg3YpGqQFJM92FCWhdN3F
	J6AywWmQ7VxnycYOTAzDsvU7cC5RzuH1QvQ==
X-ME-Sender: <xms:fSH-aA1MlopA3Pa9nS2AsO9oejVUFZpPmf0ByO8wFttHpZfX9zfELA>
    <xme:fSH-aB_2eocxNiY0QetCZ5zHVSnpom6Mvwt6in2YszsQ1PojVOGT5BheCJMv8srC8
    ZYcoyPMFFt8WuKKNFjbdxq7a8JEXJz9dWmlYAxhfTZkbLK1859ta9Y>
X-ME-Received: <xmr:fSH-aBM4IZL11ED-KLqOsPkl8LKISKQ4xg2x4AF4x8jSPc8Cb0VO8eqEDkojBa36b0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheehvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesghdtsfertddtjeenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepieeuff
    ehuddtgfdvhfehgefhffeiteduteefvdeljeekfefgtefhjeeljeevgfffnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgruhhrrgdrnhgrohestgholhhlrg
    gsohhrrgdrtghomhdprhgtphhtthhopehuuggrhidrmhdrsghhrghtsehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepphhhihhlmhesmhgrnhhjrghrohdrohhrghdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fSH-aFccq8GyWdnbSVBwN3xSnd3MzFqnV4zFHFynEgXhdAAiurzKhA>
    <xmx:fSH-aAX4mvhpVIC9qd1E3GRFUw_eVbROC-dYmKy9GIj8nEdjgEEeJA>
    <xmx:fSH-aNhxaBNFHUb2DDV49iQHgd6fJYvvQoxDIHZ0ksgNh6m_t5iDCg>
    <xmx:fSH-aP_QGbN3eIN7TJ8DBMZZLc0DmjfLhX5dmb16uze_vhRGIfZiTQ>
    <xmx:fiH-aHhwr-WxvI2saEo580I-Ki476XSp6FnfXfqeyQ_2vAxt93pkCl8Z>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 09:26:20 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id ABC5E61B40AC; Sun, 26 Oct 2025 14:26:19 +0100 (CET)
Date: Sun, 26 Oct 2025 14:26:19 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Philip =?utf-8?Q?M=C3=BCller?= <philm@manjaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Laura Nao <laura.nao@collabora.com>, stable@vger.kernel.org, Uday M Bhat <uday.m.bhat@intel.com>
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
Message-ID: <yyi32aqbvgmvud6egijxurgpbe6mzax73z6l5od3nzt4lsoxzt@msp7t3hsvobw>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
 <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>
 <2025040121-strongbox-sculptor-15a1@gregkh>
 <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>
 <2025060532-cadmium-shaking-833e@gregkh>
 <8dbd9d73-1177-42fc-aa84-78139d957378@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sypdnip4lcphrji5"
Content-Disposition: inline
In-Reply-To: <8dbd9d73-1177-42fc-aa84-78139d957378@manjaro.org>


--sypdnip4lcphrji5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
MIME-Version: 1.0

On Tue, Jun 24, 2025 at 09:05:31AM +0200, Philip M=C3=BCller wrote:
> On 6/5/25 10:46, Greg KH wrote:
> > I have no context here, sorry...
>
> Seems with 5.10.239-rc1 it compiles again just fine ...

We've been seeing this issue[1] since 5.10.244 (specifically commit
b039655d31a1 ("genirq: Provide new interfaces for affinity hints")),
and still in 5.10.245.

Given that this has apparently come up before, and I don't see any
likely cause looking at that diff, I suppose it's probably some build
issue in 5.10 that can be triggered by innocent diffs, and so is liable
to keep fixing and breaking itself until somebody figure out the root
cause=E2=80=A6

[1]: https://github.com/NixOS/nixpkgs/pull/448034#issuecomment-3364278085

--sypdnip4lcphrji5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaP4heQAKCRBbRZGEIw/w
ouKFAQDikS4pCSq02rtJtJIRAQ4Qa6RWLAkfEDjHb1KWHJ7idgD7BB0yMEB3oFEr
PGXxoAeihTn7QQeqB9JFnCH5cMaCxQw=
=SLkN
-----END PGP SIGNATURE-----

--sypdnip4lcphrji5--

