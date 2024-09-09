Return-Path: <stable+bounces-74004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22EC971685
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299F21C217E8
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE731BA89C;
	Mon,  9 Sep 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I/MpHrXw"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DF1BA292;
	Mon,  9 Sep 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880708; cv=none; b=cFItBFW5QIqzp2UAyxHUNEUaqwNcWcgwUKUrPhvVmNSPZrwXsVyWqd3BRMgmc6eGWZ3WTxAk/TkUz5eW4jCH8hxsuV5quvKBv8+QqgcGZvTHw1gnrqW7L8uLGUNOGfM5NbmwZaNhdVxud+SfYiKE9p6t72j4QA+eWIMyQW3MQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880708; c=relaxed/simple;
	bh=JgQPE6MdDDcEkxERq/X73e5GlAI5lk2dHeZ2yxI4FaY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTHZmyCvyA5gj1Q1tu5q9ddM7DWU9+jIqfPYGXRGS5crj1OeZDzPLdGjcTCbrzrwDpVGCR6T5WISOVF//rIlGWEJKeAHGc2YsQKt8nyHl8M28cYy3mlxnTlJmVk25zuuBbvJKqUkl4jsTQaGGEi6NvLBwsoVi03i+b2Ckt71SuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I/MpHrXw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725880707; x=1757416707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JgQPE6MdDDcEkxERq/X73e5GlAI5lk2dHeZ2yxI4FaY=;
  b=I/MpHrXw55qV98S5GtmI3tggY4ODKoP+JFYCham7lCNaAMsxnp/XMjgy
   GzXki/7F1gW1+7prz+xHGQwwx7Ds21sqekbCdUU1cqPe+guX39XQeHjcX
   cEmqshmmemDtedhMV34AkhP4AUc4z4GJ8sFodGSZu7sahhyYlN5j/5OL7
   QjjXtsh4uZQxqP9l00bUgILK2Jj7ch3lg7tqDRyJTjbGde2EbCXUn2Gdr
   iW/Ie2kow4Tegz5mN3WnTd9b6KFCIO4H1BvagE9hSz6dPJHSh4deC3qRC
   KLXUnx5Gg+bsYBUP/TWtGi6fbcxZQ8O+A54wrsOGMbSYxZrHzoW0JV1AA
   w==;
X-CSE-ConnectionGUID: 0kZpW7rxQG+yf9Z5H3y6wA==
X-CSE-MsgGUID: v/vNzzZFT5OcLwxWDqcaiw==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="262476603"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 04:18:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 04:17:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 04:17:41 -0700
Date: Mon, 9 Sep 2024 12:17:08 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: WangYuli <wangyuli@uniontech.com>, <stable@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<william.qiu@starfivetech.com>, <emil.renner.berthing@canonical.com>,
	<xingyu.wu@starfivetech.com>, <walker.chen@starfivetech.com>,
	<robh@kernel.org>, <hal.feng@starfivetech.com>, <kernel@esmil.dk>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 6.6 1/4] riscv: dts: starfive: add assigned-clock* to
 limit frquency
Message-ID: <20240909-wrath-sway-0fe29ff06a22@wendy>
References: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>
 <20240909-fidgeting-baggage-e9ef9fab9ca4@wendy>
 <ac72665f-0138-4951-aa90-d1defebac9ca@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mELJ3Yv+VzyNRPTQ"
Content-Disposition: inline
In-Reply-To: <ac72665f-0138-4951-aa90-d1defebac9ca@linaro.org>

--mELJ3Yv+VzyNRPTQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 12:38:23PM +0200, Krzysztof Kozlowski wrote:
> On 09/09/2024 12:17, Conor Dooley wrote:
> > On Mon, Sep 09, 2024 at 03:46:27PM +0800, WangYuli wrote:
> >> From: William Qiu <william.qiu@starfivetech.com>
> >>
> >> In JH7110 SoC, we need to go by-pass mode, so we need add the
> >> assigned-clock* properties to limit clock frquency.
> >>
> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> >=20
> > What makes any of the patches in this 4 patch series stable material?
>=20
> That's for stable? It needs to follow stable process rules, so proper
> commit ID.

[6.6] in the subject and Sasha/Greg/stable list on CC, so I figure it is
for stable, yeah. Only one of these patches is a "fix", and not really a
functional one, so I would like to know why this stuff is being
backported. I think under some definition of "new device IDs and quirks"
it could be suitable, but it'd be a looser definition than I personally
agree with!

Oh, and also, the 4 patches aren't threaded - you should fix that
WangYuli.

--mELJ3Yv+VzyNRPTQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7ZNAAKCRB4tDGHoIJi
0jKnAQD40YnduJKErP7PZ43RAIzAUaKKk6GGIuU8UeCorPAtcQD9EJOR7mfJdlSP
KuYQ2DA4cKmdVMLXWcBOhMbzNUVxuQI=
=gS5N
-----END PGP SIGNATURE-----

--mELJ3Yv+VzyNRPTQ--

