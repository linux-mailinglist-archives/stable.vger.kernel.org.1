Return-Path: <stable+bounces-152360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D7EAD4788
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 02:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496E63A8A62
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 00:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09641F949;
	Wed, 11 Jun 2025 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="g9/YJ2Dj"
X-Original-To: stable@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B4522615;
	Wed, 11 Jun 2025 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749602605; cv=none; b=DXEEhykyT96EnSlg3Z+NqTlNfz9skHpBRt/YqxxEpwlu3kK5y8QgXjgBGYF2VxbIDcryJijlrLQP0rnso7dNe7Smxc3cK+5HTbkf/MA6JR7+WhcInaUtS7CITTsZv8iBHk9yUuCNOqJh5iDFiAI59VXwo4qogws1u5qd+kxPrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749602605; c=relaxed/simple;
	bh=I8t6h3r38m2D7tiAk/9KquFvJg+280QTUDJCjmQBCz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N//8/pJBw0xKM1+sH5wHdUq5R6K5O/nP69y8LbGIdUfFMH+++Nup1itnusBgolYyaCi7nxPAwvB4XYCbzz7BPkLxrQEyCuf7qqBugBANSHtSmSUwQ/HUL4psFUIseNoqsFS93stzzz9Go8+L5BVbjx9r6UlwBE2nCBAgWlE6dI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=g9/YJ2Dj; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I8t6h3r38m2D7tiAk/9KquFvJg+280QTUDJCjmQBCz8=; b=g9/YJ2DjEe9kGecPlPlzOD/ALa
	y2UJvmlBmKGLGn72KqIAJdrDBXbchbtKzYj0TTVpFZ7ZnWczLMDQkbon9aTOOd8DkncTCv6J6N5kX
	+DVFZXy2z3m9zPMGhdJfBdQQdc9lbOmfl77IKOBSX6R4VeiTNsNbPINvMdIwO0nmG2kMvtnWfafL3
	qscRsLXcppZ5sFyjcLZJIlRRuXVDNHUbLOfnjp9G89KhHs2Ubp9o1ZJmKjjlyxuUqrHG9okcicKaL
	uJOPS41obsezibw/d4drgMfoFmd5rNFBaSfbz64fhu2WSfE4YyY/3o92BJS9liMm41CtfhilfYCEQ
	qYwpFRxQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uP9YT-000000004oV-0NEv;
	Tue, 10 Jun 2025 20:43:01 -0400
Message-ID: <ce520c1e28475703c71ab817de790823e29cda7e.camel@surriel.com>
Subject: Re: [PATCH] x86/mm: Disable INVLPGB when PTI is enabled
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo
 Molnar <mingo@kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Peter
 Zijlstra	 <peterz@infradead.org>, stable@vger.kernel.org
Date: Tue, 10 Jun 2025 20:43:01 -0400
In-Reply-To: <20250610222420.E8CBF472@davehans-spike.ostc.intel.com>
References: <20250610222420.E8CBF472@davehans-spike.ostc.intel.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-10 at 15:24 -0700, Dave Hansen wrote:
>=20
> Disable INVLPGB if PTI is enabled. Avoid overrunning the small
> bitmap.
>=20
> Note: this will be fixed up properly by making the bitmap bigger.
> For now, just avoid the mostly theoretical bug.
>=20
Does that mean the patch to make the bitmap bigger
is a dependency that needs to be in place before
the RAR code (hoping to send out v4 later this week)
can be merged?

> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: 4afeb0ed1753 ("x86/mm: Enable broadcast TLB invalidation for
> multi-threaded processes")

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

