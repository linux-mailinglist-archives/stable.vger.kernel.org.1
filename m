Return-Path: <stable+bounces-52129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A509A908196
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 04:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0EDB22878
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 02:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3CE183079;
	Fri, 14 Jun 2024 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="V3NL6jSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="enY8kinJ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B31822EB;
	Fri, 14 Jun 2024 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331919; cv=none; b=hW95EDXSStM/U95Fjc6/Do4iFGj+tXIROYXjWca08ouNG1MNfO+JSuK6+BOSBkGo1h2TZY6Lsd1kZvqpq2sA+QjhJI+UVZF+7Fhzv3xlGqI5THbkAuEu+KoSGIjMl9kkR2pShoiKTbA7K26m80VU5l9OGGcRDNTc4G+dn5qgXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331919; c=relaxed/simple;
	bh=Pf7UPKwrd/kvnTcMtegUpf1NMAComiNd4Hhie73WEqY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gSL0vMWXOiVXTjHU04bfHfqBFdI/+/xMitWUU00xBJZllUHWfMr4SmvJQTDSxlmMhOdHpRECGc5lKYOx1SjBTWtFXir9GNnhrb4wDO4ybHx2ywUv9JE+qLGiTnphwHa+tSJNYqVTM88CCoviB+A2ccEdm/EVWunmaV1ReVNpkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=V3NL6jSn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=enY8kinJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B2DD51140220;
	Thu, 13 Jun 2024 22:25:17 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 13 Jun 2024 22:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718331917;
	 x=1718418317; bh=Pf7UPKwrd/kvnTcMtegUpf1NMAComiNd4Hhie73WEqY=; b=
	V3NL6jSnjobA3yCXOVJZnVLoQdK1qnGFjHHxbzLRh1ZAdHmdBFJnam8iut9Ex1ho
	0FzSu5z+3yYUTfh+3DoPextN442seJYLb/p2xfNVFiUs+1uW3jPz6Lg2KxSfoKPf
	s39W+PQd8n6bCWASoD4lCwoymB8mUzVD9amuD05rHyEhn1WHyZd0E9o0eEdqBGF0
	s2laT+mwLwVTugWnUkEJ6zV8XfewI6gmAaKOGgDB1audkt50JKLdgE/w9qGAi8K/
	uK6tsDQCLkbK5WZwILXFFkbsQ4KDS3TYlFcVOZOJH16vh2WZ+R8eHfnVo9XoIahU
	azgrPx64BNVXAdGOhcia0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718331917; x=
	1718418317; bh=Pf7UPKwrd/kvnTcMtegUpf1NMAComiNd4Hhie73WEqY=; b=e
	nY8kinJY1C23yyY7LawTo4tLazXcHQQ4eK/Z38mJnR6DRO5MUnB1DXmPsQMw+9PR
	4mLj7WW93zJw4n6nGc4vxOmcdPnHv3PG2oQrOLFzlMlfMFFv/MDGJMQcFasbpq+J
	ZVSGXA4Nxsz1zB71NWuiA0PUg4jOuJhp0sms2exHwn8VrVptgkHHTd/GsNvbYWkz
	gVbpvXkffXXJfxKGwd/PHnFNnICwQXl5zdn5t1x/0FJSxiQsD7dNxJ8c5w121BZo
	1S9+e6SiEfg9L7qCBd7wPGjTKtVJErgmBLJtaLQv/rU/zTZYwo+KY3P5J3nkrFiz
	fWwHEBiYXSEUCEnmvaa8Q==
X-ME-Sender: <xms:DaprZtqPpwX2tWYaT9p_MDrUpy3d7UxVfz569t_LI01bmFyr2u3opg>
    <xme:DaprZvo3hOR32eZ-eaAKZLbDblRr910CA6Wwv94d5dVSin8W8iuLZTe3AHugMYh3B
    pnysYmRTl3g_2vcnKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:DaprZqPJbnTi0sO8m0IvLwE3Sf9RRtZItiwQoeF4MR-xMq0TrL74jQ>
    <xmx:DaprZo64e533aPxzfv_LRU8bzd77pMNNIG6hTEDwRmrw4nWAYXKxIg>
    <xmx:DaprZs7sqLiuArcf_Cfk3tYVXj1YLB_Gwco2yidLnpjhzFb6MBruwg>
    <xmx:DaprZgiEfNdbfIy9tCklsbi9YIr13Yzihdsord51hchfH5YQQxuyjQ>
    <xmx:DaprZmQkSRNmCKfqSyHxI9NC8wh7PRpdFvR9AihEll6vaV91arXbgEhz>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 383F436A0074; Thu, 13 Jun 2024 22:25:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f9a0d11e-53c7-4a15-a7b3-209da8bcf52d@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H7VKGMAH10S4sOZLkbgkUSMAYzpYt-dL83S0Vg286PsaQ@mail.gmail.com>
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
 <20240613-loongarch64-sleep-v1-2-a245232af5e4@flygoat.com>
 <CAAhV-H7VKGMAH10S4sOZLkbgkUSMAYzpYt-dL83S0Vg286PsaQ@mail.gmail.com>
Date: Fri, 14 Jun 2024 03:24:47 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@kernel.org>,
 "Jianmin Lv" <lvjianmin@loongson.cn>
Cc: "Xuerui Wang" <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] LoongArch: Fix ACPI standard register based S3 support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=883:11=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> Hi, Jiaxun,
>
> On Fri, Jun 14, 2024 at 12:41=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flyg=
oat.com> wrote:
>>
>> Most LoongArch 64 machines are using custom "SADR" ACPI extension
>> to perform ACPI S3 sleep. However the standard ACPI way to perform
>> sleep is to write a value to ACPI PM1/SLEEP_CTL register, and this
>> is never supported properly in kernel.
> Maybe our hardware is insane so we need "SADR", if so, this patch may
> break real hardware. What's your opinion, Jianmin?

I understand why your hardware need SADR. Most systems DDR self-refresh
mode needs to be setup by firmware.

There is no chance that it may break real hardware. When firmware suppli=
ed
SADR it will always use SADR. The fallback only happens when _S3 method =
exist
but no SADR supplied, which won't happen on real hardware.

For QEMU we don't have stub firmware but standard compliant SEEP_CTL is
sufficient for entering sleep mode, thus we need this fallback path.

Thanks

>
> Huacai
>
>>

--=20
- Jiaxun

