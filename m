Return-Path: <stable+bounces-192175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67952C2B054
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C7504E7BBE
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E82FBE05;
	Mon,  3 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="BIJd45/L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qr6EnPNi"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABCD28E5;
	Mon,  3 Nov 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165370; cv=none; b=gW54BciWcLR87rVywIFwomptsXwiKeLurY6KfY5yUkqpMWPVE6pgGE06IOx6EmUFUTLZxrvbmY+qkoRsZ/WHhpbQE0PvX6t2E6mFWIJC3GgzvBAA3rZSFwNAB5MVc7TEbk6it8LK/BX/vG1cxOyQipiGC/UVniLwclTnQiCH+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165370; c=relaxed/simple;
	bh=3wRV7CeniUorjG96t2erMGtiJ3p0ua3G9UN8TjUqKjk=;
	h=From:To:Cc:Subject:Message-ID:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyUSXGJU9rzVXjVeAk8v/4mxOihKrF1ufHLt73wLSlwh7OX75+ayEhceV2VD4/6Hth0mZ0Ng3MMsAOrzlavr9mbVpiX9M3iscHwyTjGjzga3Bl35s3zh8w50CpBf+VoaQq1EiStCR+Ycj4Olp0tPiuxFLb+R1C8yPdEILdr+oDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=BIJd45/L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qr6EnPNi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A7E1EC021C;
	Mon,  3 Nov 2025 05:22:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 05:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762165368; x=1762251768; bh=7mFsgqontR
	l3A2paZrszVOmG7hPL+m4xfAMwJHrVT38=; b=BIJd45/LUHJjtd1TWXXy3m7Ot9
	UbWXiZGiik8/6dxJ0U19BensaB/x2E/8AvxMRSzr40oq4mw30wGBSCC6t0SxeVR3
	vMmveAyCCRZysSrxrOZsJhrA8rtTZ2pNIL4+yCl1fVtYHVoWSIXOem2JBdCvCqrg
	9KZDeV6V6Tx+zf7mT9+EI1AZHRX4rdW5cg4oXsIWY91hpsjK+2Kc92Sshna8x4tA
	i+cFTStaeD/4Ux2X/3193Fw1fJ6CqGKgrsSbHV5F/EFERAJ3UpmgpvuQhDuVc8EB
	NnZeCwGfpkPG/eGaFaW1norKqgktNfWYd8RFuqvy6IOSmexRvBt+14zF5U2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762165368; x=1762251768; bh=7mFsgqontRl3A2paZrszVOmG7hPL+m4xfAM
	wJHrVT38=; b=Qr6EnPNiZfeC6KVP0piV7ZaJa2wlCzVHZLNR9i6sfMA3Azk6WFD
	MB3uTJb7m0kGhDzdRV8Zow5H8YH9NlUKn1Ysis79zmgLgbdWvQBxDTF2Be5sEfeq
	S/sxSX3tJRlGEV8vLCeI6GExEI6XY8M6qlwSDpXlsn1cOwf/dcCXPlOZutDdGxDM
	u7jB2kfGtoa7G5LtYpEzEtpw6T8MGipCTEJni1Y5vuoyNUAas0SgdijTpsRbJO+5
	m3FVhlCUWMaczzKviOZYc0/tcQCx6OvUNp7ZhB82R2KagdXebc/G+ix51fkMjo/t
	C/S8DA1NxunjLb0fzItmjp0v09Vz8hAguhQ==
X-ME-Sender: <xms:doIIaT1uhLynBnZPh7U9HI55mFePxmyScbiMcoHvWvPkW8nksOXwyw>
    <xme:doIIacyWT-iOzBc3LuknRpp-hVatJ_XqO2RpnloelddgtXGvUaJrokkS2AszWzzQ5
    -cSIpzShOGo8ksVzAz3N-9d1ye64DrbMhW2Ymu2c7_LxewvhlByuw>
X-ME-Received: <xmr:doIIaagvLmSClA8kFNeQvG8ay1m9VtPadL9CIp1U4qh-8JjacMnNgE6D1GU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefukfgfffgjfhggtgesghdtreertderjeenucfhrhhomhepvehhrhhishht
    ohhphhgvrhcuufhnohifhhhilhhluceotghhrhhisheskhhouggvheegrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeejvdetveefkeeggfeuveeukeetffdutddvuedvueektdekfeef
    ffejfeejtdfgteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegthhhrihhssehkohguvgehgedrnhgvthdpnhgspghrtghpthhtohepudekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjrghsohhnseiigidvtgegrdgtohhmpd
    hrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepghhouhhrrhihsehg
    ohhurhhrhidrnhgvthdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhngh
    hosehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhhprgesiiihthhorhdrtghomh
X-ME-Proxy: <xmx:doIIaTzWg2J_Sx85B4Pw1q-7j6Rw63F4mVDl6MG-mdNK85mrFKb_1w>
    <xmx:doIIaQw_izYFDzfhbE06NhfsuDhz8hi38txS7USSnNKxbda1L1fxHw>
    <xmx:doIIaVo3GT3Jof188O1mGO5kwqeCC50A8A4772CsxG6UQ-SoiKn0Ug>
    <xmx:doIIabksJlqJB7n4yJyDIkFrFtzIQOWUPKrrydpj6yScHzF_puQ9QQ>
    <xmx:eIIIadSjesKdecIn17BTFpxnjna104o3KeOcXwpd9IcLw4N07zBErjKi>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 05:22:45 -0500 (EST)
From: Christopher Snowhill <chris@kode54.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Borislav Petkov <bp@alien8.de>, Gregory Price <gourry@gourry.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 peterz@infradead.org, mario.limonciello@amd.com, riel@surriel.com,
 yazen.ghannam@amd.com, me@mixaill.net, kai.huang@intel.com,
 sandipan.das@amd.com, darwi@linutronix.de, stable@vger.kernel.org
Subject:
 Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an error.
Message-ID: <176216536464.37138.975167391934381427@copycat>
User-Agent: Dodo
Date: Mon, 03 Nov 2025 02:22:44 -0800
In-Reply-To: <aPT9vUT7Hcrkh6_l@zx2c4.com>
References: <aPT9vUT7Hcrkh6_l@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha512"; boundary="===============5056424951694076744=="

--===============5056424951694076744==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On Sun 19 Oct 2025 05:03:25 PM , Jason A. Donenfeld wrote:
> On Sun, Oct 19, 2025 at 05:00:27PM +0200, Borislav Petkov wrote:
> > On Sun, Oct 19, 2025 at 04:46:06PM +0200, Jason A. Donenfeld wrote:
> > > While your team is checking into this, I'd be most interested to know
> > > one way or the other whether this affects RDRAND too.
> > 
> > No it doesn't, AFAIK. The only one affected is the 32-bit or 16-bit dest
> > operand version of RDSEED. Again, AFAIK.
> 
> Oh good. So on 64-bit kernels, the impact to random.c is zilch.
> 
> Jason
>

Although apparently, the patch does break userspace for any distribution
building packages with -march=znver4

- Christopher

--===============5056424951694076744==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEdiLr51NrDwQ29PFjjWyYR59K3nEFAmkIgnQACgkQjWyYR59K
3nGg5Q/9HwqTQmyZmJmlaNOajSOMdy/ktzMmuis4X1c14Ri+P9E1uD9h95jOp9Ks
TNvPhe7haYL5/5yhP9chuuZT8Skd0aECw2wxmmZ1Ah2qoUQpY6jbYSG8KAaoWH5C
ujX/xZaYSqfpgk37dlaPTE8PA2cq+x1AJOlEZn4Re3sGUadU6qYMG7S+BjvLAI4h
IprXvD45cjDv5AnisZYQEq0KpM+wYfHrOSuHEkf3q+rFDGO7ityuKtXzuIfH/skZ
70/xw5fZ5Dm0fhj8j5CSy6BLPu8rLl5cirPnPYY02nVDzHBeWS3YTHtOSRSMDzJ6
7spzj4hzrk1xGLDtCQdyqGJlgHF1/w88SG+UD9BkIHOJWcnpDSKcqBEy8hW66UQJ
j5eml8leqPC1Qk/QwDFmP8LuRa6RLMJZuSLIB3LahdCyRrcxy3Trf7aNmuRTb5ic
t9i3D6ltVNuS2GJ1XVJBdk1cpH8lwVCo+9Fn0KOkA5YhcWCOkxOrKBMxSitCmeBY
JdOB+nC5gzqLSS0RsvTt6nda49hOjQWS9AdK+hAOPzZFp9mP3QytfUmJwAT6L+XN
3wZolRgLH4e/n0XoxvqOYWdoDviEysDjIyRMxnS908sDk+g8pR9cbPTBxP+m8abQ
+d8setlnsWwaMxbcD1x1vqGnb26GeXMLRva2qw7eUv98dxIN2V0=
=pAL5
-----END PGP SIGNATURE-----

--===============5056424951694076744==--

