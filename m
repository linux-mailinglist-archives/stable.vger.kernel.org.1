Return-Path: <stable+bounces-6885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF3815AF0
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 18:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A57E1F220EA
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796CA30F91;
	Sat, 16 Dec 2023 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leolam.fr header.i=@leolam.fr header.b="gDBJJ7fl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356117729
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=leolam.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leolam.fr
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ssv3r1kSyzMq2jV;
	Sat, 16 Dec 2023 17:59:20 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Ssv3q32KwzMpnPr;
	Sat, 16 Dec 2023 18:59:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leolam.fr;
	s=20210220; t=1702749560;
	bh=szUHEFSp4j+Un2MtFaNsKCgciTua9FQw2V6FMsGfelk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=gDBJJ7flpgPpP9TQlLGKmIpmSYyyycFNkEWHhWAnX+MpuW2LnTy55r5lJiUHXwoi+
	 0s8J/mtdBrFvI2wfWGPQJZmeOfuKdEjrwP5JfT4543AlD9PZ2tqpDV8PYS3Y5zcuba
	 yykOgBr3y7DcfNve315GIJpQ9Wp3frl/PbVYpFqA=
Message-ID: <eff5692861533201b7a1e680bc36c551d0aa0a65.camel@leolam.fr>
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
From: =?ISO-8859-1?Q?L=E9o?= Lam <leo@leolam.fr>
To: Philip =?ISO-8859-1?Q?M=FCller?= <philm@manjaro.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Berg, Johannes" <johannes.berg@intel.com>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
In-Reply-To: <a6d9940b-76e4-43cf-9a37-53def408a5b4@manjaro.org>
References: <2023121139-scrunch-smilingly-54f4@gregkh>
	 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
	 <2023121127-obstinate-constable-e04f@gregkh>
	 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
	 <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
	 <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
	 <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
	 <2023121423-factual-credibly-2d46@gregkh>
	 <DM4PR11MB535948386880F5A2DB3C5582E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
	 <779818b0-5175-449f-93fb-6e76166a325f@manjaro.org>
	 <2023121450-habitual-transpose-68a1@gregkh>
	 <a6d9940b-76e4-43cf-9a37-53def408a5b4@manjaro.org>
Autocrypt: addr=leo@leolam.fr; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Dec 2023 17:58:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.50.2 
X-Infomaniak-Routing: alpha

On Sat, 2023-12-16 at 17:47 +0700, Philip M=C3=BCller wrote:
>=20
> Leo provided the patch series here:
> https://lore.kernel.org/stable/20231216054715.7729-4-leo@leolam.fr/
>=20
> However, without a cover letter to it. Since we reverted Johannes' patch=
=20
> both in 6.1.67 and 6.6.6 both patches may added to both series to=20
> restore the original intent.
>=20

Ah sorry, I assumed the link I added in the patch description provided
enough context!

Also I should note that my Tested-by only covers 6.6.7, while Phillip's
Tested-by covers both 6.1 and 6.6 as there are forum users who tested
both.

--=20
Thanks,
Leo


