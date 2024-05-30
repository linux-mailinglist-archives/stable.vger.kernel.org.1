Return-Path: <stable+bounces-47695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED78D48EB
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185B6283B9E
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA71534ED;
	Thu, 30 May 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="IHVWIpq+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9HeyhDu"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C614D71B;
	Thu, 30 May 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062651; cv=none; b=DOnK0Fvh+Awzixabho8+fAiPaL+qjACuFExFYXiws4dE5ktBTk7+zrJDUt/Z1U1d53VmAMMPlpc8aPJ0DR1QhDri1LkdEOzSDn8nZSfC1YP6vTOksSajoXSTe/0VCY91r4CokCa5A6coJItJZIEv67fCST5rVYPlbwwNEaE+8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062651; c=relaxed/simple;
	bh=TYAa6LrsH4ZpL/6JA7vVWCjcf2hW1D1GbSww//UmSu8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=eoCJ903fuHLlKARafAJxWsX9zsFEy6tzwsvDvSfYP06QmeTq314ZJ3RwDzdp9VFH7jAjc32Mrh/5eoYslkv0cAQD+8xApd1eOd5uHf0GxknjJnTbsAK5+YTL8524oUiSxFX5R8YAJ6qeGkJT45cak3eTT0z9mzXdYzJwgJjFlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=IHVWIpq+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9HeyhDu; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id F092D1800124;
	Thu, 30 May 2024 05:50:47 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 30 May 2024 05:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1717062647;
	 x=1717149047; bh=EoCF9CEsDQuWFBvfe+ol3H4MmAOovrJ/lqBuRsL+qrY=; b=
	IHVWIpq+4MC3JbXynRj67WVI5IDA6ZfPq2aA2lOFyyc/zeO5Q0j0PbzhR9FIgn4U
	NsCPgYvFnRF66lA9CNOqYXirnBUdC3fl1yBxMdHN+bRO61kogSv1aEO4t6KFwVh2
	KItd2Q7h4SEM0qAMkZ5yB+e34zSYBVksl3PD/be6T1sCfOEILWcVCQr0FbS7q94P
	7r5K9vjLxrMszQmuuwPlOPqHZUm2BaWPTx0L+N4Lcx0DFxKQhHmZ6VjtIPqeLeLf
	gS2wzVbPX809PKl9vm1+cAxY4N/NUQP3x7WSfGqaeyqRPpudA3OrhTV5BvWz4yrH
	Jt+BbJQZo8ivtK0VnB8T+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717062647; x=
	1717149047; bh=EoCF9CEsDQuWFBvfe+ol3H4MmAOovrJ/lqBuRsL+qrY=; b=g
	9HeyhDuhRnwF4cqgc9xluXiTWjS4yRJ8jIbJTwp8mcBrub6ysbVpZEANthgymuFc
	/t/y4sq4uexrNQed+DnaA9lTsgr6V+AW9FG0bplSlYlhsjFDpQSVSG/Hd9ReQa6Y
	VhKdOI9n9WOuzNUuRV0MaXkTainj8FScAW4El/C2UIbw0Uv3DD0qfY6ZvCHUIhX3
	NY1qXqr8Ds8w7TwKlwmi8NUtLAfzLGfmyPVu+6t+WUKjPsGh3ch6LmFuvzIORwvU
	8KRZApTEYbSunoVlH5IzV3HOF93NZ8Wy7KYbTLA9HGjno9fUMGDjgRjoZ6jelc7a
	EZybXeykhg3EdrwH0T8HQ==
X-ME-Sender: <xms:90tYZlu7qQGD3oqWeWfLbvTiXMaM6f71qDrrrtRKBqixvZp4CazHfg>
    <xme:90tYZuejch2GzeXAJVKm4NF8ngwAzuNYe42KXBCTcP0lMFebpQTh4e8574gJW9EzV
    NlyBYVOXsDKDhUpov4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:90tYZoyrZesAnpVcCjeKkSPpwiRuufK5eZ8LE0Ch5rWbknTgm0lr0w>
    <xmx:90tYZsM-XWT2lBvcUEn-VsCcf2CXnYoayg5-_Rk1PQiDIPkgqGXFgg>
    <xmx:90tYZl-vHrTufnERdg9BSRoiIv3j4VVn5SU4WpgC3kDFpG_d9MTTeQ>
    <xmx:90tYZsWhGtHvBQnw3vtbS-KgXzKXI-RScbEZS2pxiyXgFgJDHRARqA>
    <xmx:90tYZonkFlVI5r00elI4uWDNsyt_KNay1xBPJ-PLjJYG062D9aKLrFTj>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5723E36A0076; Thu, 30 May 2024 05:50:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <173627fe-3370-413b-8f9c-50c65892cef9@app.fastmail.com>
In-Reply-To: 
 <CAHirt9hbzVxcKzwnSF_5jpwma+kr-WJHBQjc47ojB95Ph9SnqA@mail.gmail.com>
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
 <20240522-loongarch-booting-fixes-v3-3-25e77a8fc86e@flygoat.com>
 <CAHirt9hbzVxcKzwnSF_5jpwma+kr-WJHBQjc47ojB95Ph9SnqA@mail.gmail.com>
Date: Thu, 30 May 2024 10:50:28 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "WANG Rui" <wangrui@loongson.cn>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 "Binbin Zhou" <zhoubinbin@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] LoongArch: Fix entry point in image header
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B45=E6=9C=8830=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=886:01=EF=BC=8CWANG Rui=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>  /*
>>   * Put .bss..swapper_pg_dir as the first thing in .bss. This will
>> @@ -142,6 +143,7 @@ SECTIONS
>>
>>  #ifdef CONFIG_EFI_STUB
>>         /* header symbols */
>> +       _kernel_entry_phys =3D kernel_entry & TO_PHYS_MASK;
>
>  -       _kernel_entry_phys =3D kernel_entry & TO_PHYS_MASK;
>  +       _kernel_entry_phys =3D ABSOLUTE(kernel_entry & TO_PHYS_MASK);
>

Thanks Rui!

Huacai, do you mind committing this fix?

Thanks
[...]
>>
>>
>
> - Rui

--=20
- Jiaxun

