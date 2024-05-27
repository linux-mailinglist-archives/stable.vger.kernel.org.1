Return-Path: <stable+bounces-47514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F38D0FAA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4B72831BC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879A13A41F;
	Mon, 27 May 2024 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="yJKMqde4"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57626179A8;
	Mon, 27 May 2024 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716846500; cv=none; b=EDDb0NQdJwzDirPtEI+Ke9WGoLZKVdfNjSvZKPbUn7lcgwR4NpgFz2QrZSoxQpbMEHODoXjg68V6F9tgQYbECxo56NbEHQq/V6yXIU8AzF3FaqK1wOv124sQ3pZOlxBAEvi4cOP3h2CZbOpJyTUjuRF3WyvOsziD5deIWTpQXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716846500; c=relaxed/simple;
	bh=zxRDLoTSPNW6sovIA3ZYzXSAjtVP08W0gskGkvCAyZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0EVLXaBYknnvNKJ0YJjdORtJvB5IWArEIBM5cH4lDd/bAU78uxkHTjfQ4eQoiZmjNv70J5/lwajUCX5eocxczQwOrfKpse2D00KVEAMS45kSIBIBLr11qNDTbFncBJ1twMmJdo96n9UYb882MqqhT7dNTCFnNupxbLSAswubcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=yJKMqde4; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1716846491; x=1717451291; i=christian@heusel.eu;
	bh=R+f0Q8VcWIyhz264FCQqt43P/cR/JJ56NeNlZocLLw4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=yJKMqde47Ahc0NAq80bt51xbkq6kVm51B9OxEDiLwFXIt/M47ySp0P/zuOQHvZ7D
	 w5BsiZg/nZYjoDwZK4drmKxhh2AiJN7OC5oeX+iU7Hh9HrzMy+PjTe/rM99uRFDAT
	 qj0PRCrhUGPGl1zFznpuPxGSBEoBS8kb4S4YEHSO2I5bmYLiEVcJ09A202Tm8upwD
	 wPTa2ya9NH7+ZKX4ndxY4l18+kyF58GGg1cK19aQek60WfOy7QSBIX6KpwW/8xF13
	 XdWTi7Hj92ZnWanYsJa1J1BvJxDI2C7EgW/Dn89szhk+PC7H2WmAyyu8u1jgy6n0w
	 tXZRIWZze39Pud0QTQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N9d4t-1sWcaI1wbV-015brs; Mon, 27
 May 2024 23:34:15 +0200
Date: Mon, 27 May 2024 23:34:14 +0200
From: Christian Heusel <christian@heusel.eu>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology
 detection
Message-ID: <r7yx564fpovn2zhelafj6binigdatjrnw5pqbn2qqafn6fxey6@q4qekfqqby4l>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2ym3suufqpgosluf"
Content-Disposition: inline
In-Reply-To: <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
X-Provags-ID: V03:K1:TzN8SZqqqWbrtcPaGOiZy5NIot8TbGA3uyJ8xjfRM1J+7g+Lsv5
 R5KEKqwiwEV3RBdW97Now6z9Sms6+EBLPLZr+kp8iY9eF2dxM+w+M51A82NcvKxZW9tJ9/S
 FqO4nnCfV3kGWD61/oDZGbCIelP0RudwobeHyHh/vpmAJWW5w8e0GmgPyTnQPTlS5EpO9bY
 yR2SJt0qcftQTUNBasr6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fi2kicbCbbQ=;qiGko958NBAVzz7xLKJQlsiZQvm
 bMWX8y+PXGqF9+Jgy1WFiE0JnB3S87eSfe1JQms//d6QcUMwwRs6LrvxeNh3PU9jwLn+ElnA9
 bWwTzU8fWgKlMp8+PV1xXo7MhKf+adWN1Ljb/ToHYs/C7Eh0+x2k7yY9Q1jmCtDF556n7jxFn
 rpZZZYph9x5NZUMl6HYiRG3mz2qxvcxdPG32faYpIcKIvqnRKfqwSS18f6lCEeo0IwMO9JcX+
 AFIF3IRkoif6RkXTSo9Qh6ON82UmB6TnUq/8puL1E0Syan1MS011quPyvwMzbEDGopYXDR9Yv
 GmK4okZ+kEfSvgAxzLk9uweECUWuWYkSXPSE+G5QZ6mBN+hPq7efQ9v84qcBzTXe2TWoxECWv
 bF1+iTYYL4TWjO6gW+frIjUB3DFZrfxs++2xkNN9Go9quO9IhUHxCMk6YmgzQVrkPzeGyw3h6
 r+YMvui7NrFxBnETfPsFDNV/q+EdyWk/ERcDUp8qrULY1LcQt1qmSjtNBIWg/kCJo0O3yZ32q
 r0oUYcAaDhB+jKD0GmTgtf3e5MisTyOfBXsVx+HfhSp7Cy9QldSi75/lJ3nD6SnDSonxZn/55
 TMp7bTOHCNd1khDabKFhqgOiUrKW/i0zm5DkkluWpzshvv35FzZ3au7HRjf5zG5EJ/pCxD41Y
 cVX0O+7nWUf3QuJn9Ey1I3rYtkmvR01TqXKOBy+C3fBm+raL7AnDTTud7RnL2JPnTPSy/Muft
 yYFwTSKrzWrVGtkaRw1A/99kSgTjLynMuY9uC5CPcXbmAcmHjM5Fis=


--2ym3suufqpgosluf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Peter,

On 24/05/27 11:15PM, Peter Schneider wrote:
>=20
> I want to add one thing: there is a log entry in the dmesg output of a "b=
ad"
> kernel, which I initially overlooked, because it is way up, and I noticed
> this just now. I guess this might be relevant:
>=20
> [    1.683564] [Firmware Bug]: CPU0: Topology domain 0 shift 1 !=3D 5
>=20
> This does not appear in the 6.8 kernel dmesg.
>=20

I also can't comment on whether this is relevant or not, but I have
noticed this in more places:

    - https://bugzilla.kernel.org/show_bug.cgi?id=3D218879
    - https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/iss=
ues/57

Cheers,
Chris

--2ym3suufqpgosluf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZU/FYACgkQwEfU8yi1
JYVmzxAAtW7Y1RVf3PrMoBU9g590MNPJUU9rDfbjxIJvlVLNAuUO28Ace7twgezB
/nRFCvBa4swGyG8GmJNpNnfUjKkAdK3iBXGWJP2X7EIqfgMeQHh95+6d47EICxKx
GxlxP6tikMkb8b8S1EXxFcXZOFvCmXCQD1EkEImm++Twy40jL90v74Nedy0Ksvve
94Gzf9qM6YQs6GM5LNthlEtKIVLiXkJif6HkQ8mmxT3yKemDJo6UkdRV77Ng4nAp
lv33XQSvnihgKFeINa/WXGMGuJOyEynbEQwO2KacPvCqUNv17NR4O67kNZjzUVtn
KeCl5+/N/UGW8j7WZhk7QeY02hTdYv64nAPBXVehZXlGgUH5I6HieYU5l+2aBvJy
SixmWX8EaRNVDGFY7X/kkMf4/7UzZM2dzj/iI/40H90anAhj1+nWWH73tZXscanE
+rX1IMHf5d8sJAPgE9nFEJoPv86291sG37NJjUrHgrWksIesX+flLkBdS51qIdfn
Vil+8a8hB6GV1pqd5740iuoVb+AEwHgCS0UOt3kaxZHX7GtQBPSAMkkYwHH5ko17
E6rSyb0W8AWaKEsaxfR3QepOLTzBVy10zjoVsTD84YQBZy9Yg4U55G0lOKHKih6y
I43T2ZzbcmKhZBAYhmJvfMe4K3FSyYAu4OFRElsxN8c/g5h5Oh8=
=QlDh
-----END PGP SIGNATURE-----

--2ym3suufqpgosluf--

