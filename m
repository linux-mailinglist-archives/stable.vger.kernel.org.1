Return-Path: <stable+bounces-192289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F756C2E7E2
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 00:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A200189AE77
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 23:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E965530100B;
	Mon,  3 Nov 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="X7I1CAL6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jiMPU27/"
X-Original-To: stable@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986126B0BE;
	Mon,  3 Nov 2025 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214159; cv=none; b=HdcQXY/iGJALTxYc15nDdZHl4wKpeZ/PCGiqnx++xFu/3Y7ytG+EMhe31JAAz/NAiqimOKVuOvSMfS7twAqu7nFccZkcykmRejKet3ghJx5gboK4ydcjXyqRVMC+Bf33N2ZrzTThsDXgqOK5xoZ2njlXmdq8ek1IcAVnpIn4UfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214159; c=relaxed/simple;
	bh=pLsqA+GwaWiZlSQ5uO0bqASXcT+6PYL/oODkRhTBhbI=;
	h=From:To:Cc:Subject:Message-ID:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5G3X/a0gnCMVo/+mK7QMaOLf1OV3L3A8bA7cxrafDBN9eG1akweXfl96mzjJH7wP5AE+9criVv1TSLrG5wsIenfcSjD+5UQPAGO01USSMvXURV/RwGiNP6IfRagiUVcdqBD3XkM6WzBX5seREvhyIvrBjA3d7qX6WLoXTiWBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=X7I1CAL6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jiMPU27/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 467461D002CF;
	Mon,  3 Nov 2025 18:55:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 18:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762214156; x=1762300556; bh=GPFpyT0a3P
	jc96u0CnhKSUFWAsYD2jF3Fi4Un6BtxyY=; b=X7I1CAL64ZFMNxatSzvGBpCMUY
	NnVjUow9HjTDGr3ezRFPXVzwGncmt2HYvBdpk2URzaaZpgEU7MY2Qqx1XYQ1p7k9
	ci8NJGxmGmdbhVoFLBqQgVwtI1vam+cBGtzmQ3AHIpcFHZ6ed4T+7wiQXvIFtZ8k
	jEAjUFsoG88AB2bDfU4DVUEjR/QK15axSXlSn1IoemCVmKdYsUEyP8O3E8DbCw2f
	lYH4jZxADt1+ikLG0b2Ueqi/rBo/d8+ryZUC0mHLLydUAzU9vY4aPDGtE/YR7mjB
	zQhwmai8U/jjNa7U5+ijAtL9/j9v3QJxUJzskHYHmoGlBVIeGIRjQWUC0BbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762214156; x=1762300556; bh=GPFpyT0a3Pjc96u0CnhKSUFWAsYD2jF3Fi4
	Un6BtxyY=; b=jiMPU27/rU9x4ZA3NXMGwKont9eOfkPwcnzNVzT9JctUY5dmVka
	GhDnWSVvJBiHXJKP6we6YI3sCiOMDD+x5m+lu30NE0djFfzqQ69wGZbCbnnqHUoF
	kMiUG1Le86UhEUR4bwAIJUkZv5sMVqoLoIJN9UE8/WCGtA2EyXHaVij1m7a+UXz6
	ooj8g75nqX1Lz/qpAoE3R16vt8mv2m7SDGf+bnToLLNOEr6beMXaUyfoib1+8ggj
	gbPVY0XhfsXo2IpH8cIE92oETZuVnWzDSIvcKwNgjHDOFI3C3k5P3Js+52RJN+jW
	dmZzznxsKRPVwu78LckGFhTXStWWsP6lkAw==
X-ME-Sender: <xms:C0EJaaYY9NvCybuntHrfRJNMauDMpx_uz8qflLAnd5p_T0OBipeb-A>
    <xme:C0EJaYF7wcQZrkAgR5Q4mjDnq3e8XLXrGibdKwAZt18Pf8iy45nF_3WqqKQV3KpSa
    HqdGpjkoDXZMgbUvCa8047xdTGGdmQlYwEm22ZWnBujbibvNzOqLq1R>
X-ME-Received: <xmr:C0EJabkuA2E-CaEI7GYuQ43CJcbyjbAnCpbg-8s8mA2DBzBHfy1W81BrdFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefukfgfffgjfhggtgesghdtreertderjeenucfhrhhomhepvehhrhhishht
    ohhphhgvrhcuufhnohifhhhilhhluceotghhrhhisheskhhouggvheegrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpedvueffffdvkeduleduueekveduteeivdetgfffiedvueeikeek
    leeujeetuefhheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhisheskhhouggvheeg
    rdhnvghtpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepjhgrshhonhesiiigvdgtgedr
    tghomhdprhgtphhtthhopehgohhurhhrhiesghhouhhrrhihrdhnvghtpdhrtghpthhtoh
    epgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrh
    honhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtph
    htthhopehhphgrseiihihtohhrrdgtohhm
X-ME-Proxy: <xmx:C0EJaXm2CUimv6B8V8i8eS-P8xRtu0feZL2mAiCIlVUnSClJTYZ5bA>
    <xmx:C0EJaQWHPtY1cjnvzi5vYlEBHOEPaT_kigUKjPOzeCZDHaOlCnkmNg>
    <xmx:C0EJaV-SpJZCQiKEnF58hMae1ii7RZDFLiJ8Ev0H17ViXomNH147tQ>
    <xmx:C0EJadpr3uy0GDuE_Ha-ZaymAbW2mXFF-d_1B1wkJUvD0lfJ1jNJPw>
    <xmx:DEEJaS1MrZvmzqQnZVpI1iTe2ZKyja2kOFBFmayak1_HIDl1JRJ8inzc>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 18:55:54 -0500 (EST)
From: Christopher Snowhill <chris@kode54.net>
To: Borislav Petkov <bp@alien8.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Gregory Price <gourry@gourry.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 peterz@infradead.org, mario.limonciello@amd.com, riel@surriel.com,
 yazen.ghannam@amd.com, me@mixaill.net, kai.huang@intel.com,
 sandipan.das@amd.com, darwi@linutronix.de, stable@vger.kernel.org
Subject:
 Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an error.
Message-ID: <176221415302.318632.4870393502359325240@copycat>
User-Agent: Dodo
Date: Mon, 03 Nov 2025 15:55:53 -0800
In-Reply-To: <20251103120319.GAaQiaB3PnMKXfCj3Z@fat_crate.local>
References: <aPT9vUT7Hcrkh6_l@zx2c4.com>
 <176216536464.37138.975167391934381427@copycat>
 <20251103120319.GAaQiaB3PnMKXfCj3Z@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha512"; boundary="===============0180112485978267985=="

--===============0180112485978267985==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On Mon 03 Nov 2025 01:03:19 PM , Borislav Petkov wrote:
> On Mon, Nov 03, 2025 at 02:22:44AM -0800, Christopher Snowhill wrote:
> > Although apparently, the patch does break userspace for any distribution
> > building packages with -march=znver4
> 
> Care to elaborate?

Sorry for the HTML before, apparently I'm not supposed to try writing
replies from my tablet, because it will interpret the quote indenting as
formatting and forcibly send HTML mail.

Anyway. A bug report was sent here:

https://lore.kernel.org/lkml/9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org/

Qt is built with -march=znver4, which automatically enables -mrdseed.
This is building rdseed 64 bit, but then the software is also performing
kernel feature checks on startup. There is no separate feature flag for
16/32/64 variants.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

--===============0180112485978267985==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEdiLr51NrDwQ29PFjjWyYR59K3nEFAmkJQQkACgkQjWyYR59K
3nG/xQ/+KxtWw2uOep/MmIDfo4AvP//rkBJqVKx0RKZ515PoqRYrT5PvUIFi37Oz
ue2pYzmn5mlfW1rHmAZgDIQKuF1ahtmxArqluFi4pUI97rIbq1rtUwzAuy2jqPoy
3t746D5fq7zMs79kwsc6IGeGJjgCnbKm3nvqnqJGhz/eIVoMWInaFWwZtdqwvmrc
LcFJT41WW+K286Oask25aqBLP5c/eGcM/4I0loPFbP1iREZLdtqSSUAdywXCc1Th
4cemnPM3WsleUsc06gqVp3xZN7tUz/mtnwW8n2J6w8YIxsitMflYZ6x11AS/LKjL
Y0YM106uQeWl08csTaVszxTSyFlgjlFO5PYS9+qmnzP3gSAQnmrho1+uj9RT+JqL
X4OL/FZHvVAhMbPJcScSc0StpLz7/yUiBnlH0AJ+FMkWKDvDtgmCewxWUeikkp33
r0iKqKGzsOIaIzg4CgtGg/YseNoxHN3ZpjocXIYgoBIdkP6Qwn5AcBWVEYxDHjep
BR16dpUiztQ28zyJjgII9YIUW6+Gw2Bg5ZtRIMYciVtOZ2uaADunQQLBsVqmXQQN
HOda9c1S6m0tNNafpboJGtd6GnxPgGC6727urr7lJ4r4NE/4gOF8JaYZGBiEllIo
LQd4F8pOuwAybQP6bsaUyU8tfgkeujndURSjcH0qTuRTP73B5sc=
=Xwm4
-----END PGP SIGNATURE-----

--===============0180112485978267985==--

