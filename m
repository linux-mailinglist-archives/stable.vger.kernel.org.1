Return-Path: <stable+bounces-52131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307FD9081D0
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 04:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213EA1C21963
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 02:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121E18309C;
	Fri, 14 Jun 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="JvoDMu8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qtefudHW"
X-Original-To: stable@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE118308F;
	Fri, 14 Jun 2024 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333098; cv=none; b=jfoc+DUEC3KVENrVGLlJuHn7vryPoI8uSQ7xC7gxA806PFlumuHvAUARIllWl6DbvsvmDfXEcDw84qoqgOtFChBSDjW6Y4p8nF2gkbLdjbO4zDEW63+ykesSVXzjnXcMI+u4o/mr7Ab23j3dloq5dnMwLaKSY3fdFNzoDefXLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333098; c=relaxed/simple;
	bh=DGZI5mG40FnyaDB0BC1fbYrQ9V/VYVQVkIVUveeQsQI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=lLb0AIiguhoM7oHMLrfFymY6YyFFM++TRdGoDmI5OHhwAJnMXHgN0AZ0DxK2thhJKUpyGEuUchIsGg8osC1p15xVEM/8PJfLH04FDlz4JRhdAMcpvm+bq7EEOimkmw4XJdGTQna8vzWFIoo4gXxB1KFMwgfZJGhtiMAQ/76yJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=JvoDMu8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qtefudHW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8CE1013801A4;
	Thu, 13 Jun 2024 22:44:56 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 13 Jun 2024 22:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718333096;
	 x=1718419496; bh=DGZI5mG40FnyaDB0BC1fbYrQ9V/VYVQVkIVUveeQsQI=; b=
	JvoDMu8GtVyp/R7dzBMEhsJaWn3rMv3yGKSDsQgoC6JYmqsVf92GxAs9qnrgt5h9
	VW9YbiNmkCV2aX8alm6YUmmMoueg/A7epiVr1dX64dwYU9cF8fNJTMcoxmpX+YeQ
	8QghXkxTGa79NXx73/4+Ch5n2PDhy/LkyZKwDX/J37sYxBqBTmnV33ZaqjhBgUYN
	W4UBysPQTeyYqc0OZ517U20coAKhUBztawapEs3gJEBAj+MTFagqov5f0cWdGxu0
	Aag6RjR4aDvJCxdYsr9bDw08Mb6cVAO+ESCbT2Z/IGkSQi6pUnaMtT+++QGQb9NR
	IKRlj4lhI+mWf8D3CDcqnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718333096; x=
	1718419496; bh=DGZI5mG40FnyaDB0BC1fbYrQ9V/VYVQVkIVUveeQsQI=; b=q
	tefudHW7BEfc2lKY1jot8DKvoh/aWDHpoooOZ6nLjPh5Kp9dOPkAXIT7yl2BNqj8
	r9cf5XMeFyPYGjtzDtKmb6EfA6piN4wyKWIXLezFOUxVgZ6RhPYN4lCIJsoukR+y
	rsLUbIUrmtMVT4enAJmKBwBqR36XKWewROK7r1GusvAghyrOpQ45tXYT7Um1KyGg
	6SFqW2GvkjY9o7Lci2mxne9/49EpndNNsu5xdb1DI4dhBwXJL5wMylz8EArUBcNZ
	dHB0b67YxHzEtivCh2W93ezpFj9PyPF9SwvL4Ud1Eb26fBe5WDpPI5LIp13f8t7O
	kKMrD63HeIOifT5wAlmzA==
X-ME-Sender: <xms:p65rZkaoNjTqCbbZ3Sug1tiOFOnXeuTgcmAdY3epW_qAnyVkYN1L6A>
    <xme:p65rZval8nKRirZVmf_Qt_8PNyI9FjIWNyFWt0s1vPMkbMbk3V2XmWeVb20_cq8Xf
    TZETmVH9_c_qXq7cnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeivdefffdvgfegfeehjeelteevheehkeefvdffhfej
    tdejvdeuhedtgfekudelleenucffohhmrghinhepuhgvfhhirdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:p65rZu8FlDxiVciJ_zDD0QoyOPXA0n-lXt01u8LwwJcSTG5SYPPOCQ>
    <xmx:p65rZuqsksdVJS75a0FmCS5YppWoVR09e58MJKIfE_Tm_8sA3d88ow>
    <xmx:p65rZvqfyVAbXQGGN7MQ9inGhime7gp38GsvuowIMNIjb9NNiTn_Zg>
    <xmx:p65rZsRV8lIXX0pusjCTQW-eBGT4ZddX9GDNlbhdHMDzs6i9x0GW3w>
    <xmx:qK5rZgCqWFyz6uaU_fkMXgz11HdQCElhJoY5FVPoouK_ceiyJUIieaFy>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 676B736A0074; Thu, 13 Jun 2024 22:44:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b291e5fb-bf3a-4129-96a0-99182e11f506@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H5C0rn-bY11FxoGANX+hEFrrbpj095ZAEbjC0ksQGuWpA@mail.gmail.com>
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
 <20240613-loongarch64-sleep-v1-2-a245232af5e4@flygoat.com>
 <CAAhV-H7VKGMAH10S4sOZLkbgkUSMAYzpYt-dL83S0Vg286PsaQ@mail.gmail.com>
 <f9a0d11e-53c7-4a15-a7b3-209da8bcf52d@app.fastmail.com>
 <CAAhV-H5C0rn-bY11FxoGANX+hEFrrbpj095ZAEbjC0ksQGuWpA@mail.gmail.com>
Date: Fri, 14 Jun 2024 03:44:36 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@kernel.org>
Cc: "Jianmin Lv" <lvjianmin@loongson.cn>, "Xuerui Wang" <kernel@xen0n.name>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] LoongArch: Fix ACPI standard register based S3 support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=883:32=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Jun 14, 2024 at 10:25=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flyg=
oat.com> wrote:
>>
>>
>>
>> =E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=883:11=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
>> > Hi, Jiaxun,
>> >
>> > On Fri, Jun 14, 2024 at 12:41=E2=80=AFAM Jiaxun Yang <jiaxun.yang@f=
lygoat.com> wrote:
>> >>
>> >> Most LoongArch 64 machines are using custom "SADR" ACPI extension
>> >> to perform ACPI S3 sleep. However the standard ACPI way to perform
>> >> sleep is to write a value to ACPI PM1/SLEEP_CTL register, and this
>> >> is never supported properly in kernel.
>> > Maybe our hardware is insane so we need "SADR", if so, this patch m=
ay
>> > break real hardware. What's your opinion, Jianmin?
>>
>> I understand why your hardware need SADR. Most systems DDR self-refre=
sh
>> mode needs to be setup by firmware.
> _S3 is also a firmware method, why we can't use it to setup self-refre=
sh?

That's the problem from ACPI spec. As per ACPI spec _S3 method only tells
you what should you write into PM1 or SLEEP_CTL register, it will NOT pe=
rform
actual task to enter sleeping. (See 16.1.3.1 [1])

On existing LoongArch hardware _S3 method is only used to mark presence =
of S3
state. This is violating ACPI spec, but I guess we must live with it.

Furthermore, on Loongson hardware you have to disable access to DDR memo=
ry
to access DDR controller's configuration registers. Which means self-ref=
resh
code must run from BIOS ROM.

[1]: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/16_Waking_and_Sleepin=
g/sleeping-states.html

Thanks
- Jiaxun

>
> Huacai
>
>>
>> There is no chance that it may break real hardware. When firmware sup=
plied
>> SADR it will always use SADR. The fallback only happens when _S3 meth=
od exist
>> but no SADR supplied, which won't happen on real hardware.
>>
>> For QEMU we don't have stub firmware but standard compliant SEEP_CTL =
is
>> sufficient for entering sleep mode, thus we need this fallback path.
>>
>> Thanks
>>
>> >
>> > Huacai
>> >
>> >>
>>
>> --
>> - Jiaxun
>>

--=20
- Jiaxun

