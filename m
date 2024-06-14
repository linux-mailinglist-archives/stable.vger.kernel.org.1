Return-Path: <stable+bounces-52128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9295908179
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 04:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A377B21ED8
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 02:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBBD1448D8;
	Fri, 14 Jun 2024 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="K7DYKIK7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tb4k5zti"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2342836A;
	Fri, 14 Jun 2024 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331481; cv=none; b=vDBJVlnxG8vZUPL//HTPB7lx0ifdjzn+DlHLjnRcLdpB+ibMexcghml2ANvXM8tEahlMva/F/zFwoQMvkHOykaNnGyHG+hc2HRGI57GGlcj00wp8pA22rsaySgWUHIVzSLLBp6emwP6b+MzcuuscGT+Ky2fe7d8kY+crULsvtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331481; c=relaxed/simple;
	bh=Q+lIvtLpThZG6CRqJ7f7HeZMpCWSSrDuKx3Z2SawB7M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=bckF6Uubn0zi3oQJGyhGeUn/IzWO+pkWO7nfziYi+Y0hUvb1/zN0eePLzWrWHvpXpl4QmPCccfTOIjMxB9zeCW3QbEU9Q7DQORJ0/eWjT0PHePYkoLHaAc81ocFH2t4a1Am3zgF+ycG+riZqZyvJv3O+D0Do2zpy3qN8aJHbG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=K7DYKIK7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tb4k5zti; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D9AF81380102;
	Thu, 13 Jun 2024 22:17:57 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 13 Jun 2024 22:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718331477;
	 x=1718417877; bh=5jttrt05zCIewX9sbVQCfLsJdZV7ftC5N5jiHF3VYXI=; b=
	K7DYKIK78zXkHqouoe0za0XG8zdgOma+RvwbLUSqKCnoyq7YRzA2OjXhB03fssR/
	B2ww3xgVUnRRMHCv/OydogvV6bSSAR4M65bd4Zq/55CnB6wTl9zXZ8Y3NiuRZQtf
	6LOdZu+SlNM/FLbLaiUqqHWgGNvMZ04aD6w29fJTFGLTAt250l0FZJZ3NAyssGHx
	2m9mocq+/nbBFNi4tyvcFAqFCYa8SbNcfoyzUcAf55gz8CGuBJmBhDub7YegjMxi
	qvnBNWhqTJC9TGa9R3dFipZPdpYmPw7C+wX76KSBmsIKw2tGB2zQVWfhFY/Kg9Xn
	4AuegXfXKR7tiZZk7xbnxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718331477; x=
	1718417877; bh=5jttrt05zCIewX9sbVQCfLsJdZV7ftC5N5jiHF3VYXI=; b=T
	b4k5zti4k2mBwj/P1bAFhwfZHSL1YB0qPKehDLQB7ePsaiLB/zzmjnqXGoOhQFLo
	xzwHG5jH+xVvIy+P7alPJsP04AVgwf2hZL90aNU9HNxcxfHBrtjYrDSXHjXg8HF5
	kg4JEB7WlElbdD9EGGPhPtnVxzlKW6Oqs95zF9/iStEgaSzukeFKU0gtrKNWPjtA
	q+bTIZ2n89O3dGxL1APK/MvKHYgcpaTj/F5r8UqVf4F2YQn09ImnLKML9rEGjdiO
	28u3zZKsI2JTxlEWXsjrnifBek1+XiNkc0ok/KUORXA1isteJ0n68uEC1TsCG/Uu
	ILI0ZadZKXtfRyJKTogiw==
X-ME-Sender: <xms:VahrZsqpZTJO9GanR4h_CDGceIow7LtLkfrwsC2ItyrDmX7tJZ3gtw>
    <xme:VahrZirjAsah9bslA6X4Q6cj_a5otkHU532C66I_Oyc7C2Wi_BxOjFoZyrj0x91gw
    nCg_0rpk3ngPDyyN4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeuffdvtedvffeigeekueejudegtdehtddvhfevteef
    gfffjedvjeeffefftedttdenucffohhmrghinhephhgvrggurdhssgdpshhushhpvghnug
    gprghsmhdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:VahrZhPNarU0Q91Emd0VP-nU0bdkdemjegs4mQ0XptNl5zZgjjMD-w>
    <xmx:VahrZj7PH__-6Qw2Bdru90X4lFQxH3AvXg6uWFBmYfmy040zrlHL_A>
    <xmx:VahrZr61KEJtkhshHsRmeKlALVb0LaA8rQU2h7Y0zZ3jcIUw08MDlw>
    <xmx:VahrZjiyrI4wSGKoGQGDgb6NpwtaDBTYDNv6Ua0nYH0gS1dvOyMVXA>
    <xmx:VahrZu0fO1zkF2JHdrJi3pptRoFsAFgmbx825JwWluQuzOSQWX8IY3lO>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1F4E936A0074; Thu, 13 Jun 2024 22:17:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3e3d6ee8-a758-4d99-be77-89b26b0ab591@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H7TqgJiR9z9jEOpv34kijONLVu5Bv2PChjUWxhMKU_Zvw@mail.gmail.com>
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
 <20240613-loongarch64-sleep-v1-1-a245232af5e4@flygoat.com>
 <CAAhV-H7TqgJiR9z9jEOpv34kijONLVu5Bv2PChjUWxhMKU_Zvw@mail.gmail.com>
Date: Fri, 14 Jun 2024 03:17:38 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@kernel.org>
Cc: "Xuerui Wang" <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] LoongArch: Initialise unused Direct Map Windows
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=883:13=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> Hi, Jiaxun,
>
> On Fri, Jun 14, 2024 at 12:41=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flyg=
oat.com> wrote:
>>
>> DMW 2 & 3 are unused by kernel, however firmware may leave
>> garbage in them and interfere kernel's address mapping.
>>
>> Clear them as necessary.
> I think the current status is as expected, we don't want kernel access
> to non-8000 and non-9000 addresses. And low-end chips may have only
> two DMWs.

I see, I'll remove U-Boot's dependency to DMW 2 and 3 then.

Thanks
- Jiaxun

>
> Huacai
>
>
> Huacai
>
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  arch/loongarch/include/asm/loongarch.h   |  4 ++++
>>  arch/loongarch/include/asm/stackframe.h  | 11 +++++++++++
>>  arch/loongarch/kernel/head.S             | 12 ++----------
>>  arch/loongarch/power/suspend_asm.S       |  6 +-----
>>  drivers/firmware/efi/libstub/loongarch.c |  2 ++
>>  5 files changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/=
include/asm/loongarch.h
>> index eb09adda54b7..3720096efcf9 100644
>> --- a/arch/loongarch/include/asm/loongarch.h
>> +++ b/arch/loongarch/include/asm/loongarch.h
>> @@ -889,6 +889,10 @@
>>  #define CSR_DMW1_BASE          (CSR_DMW1_VSEG << DMW_PABITS)
>>  #define CSR_DMW1_INIT          (CSR_DMW1_BASE | CSR_DMW1_MAT | CSR_D=
MW1_PLV0)
>>
>> +/* Direct Map window 2/3 - unused */
>> +#define CSR_DMW2_INIT          0
>> +#define CSR_DMW3_INIT          0
>> +
>>  /* Performance Counter registers */
>>  #define LOONGARCH_CSR_PERFCTRL0                0x200   /* 32 perf ev=
ent 0 config */
>>  #define LOONGARCH_CSR_PERFCNTR0                0x201   /* 64 perf ev=
ent 0 count value */
>> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch=
/include/asm/stackframe.h
>> index d9eafd3ee3d1..10c5dcf56bc7 100644
>> --- a/arch/loongarch/include/asm/stackframe.h
>> +++ b/arch/loongarch/include/asm/stackframe.h
>> @@ -38,6 +38,17 @@
>>         cfi_restore \reg \offset \docfi
>>         .endm
>>
>> +       .macro SETUP_DMWS temp1
>> +       li.d    \temp1, CSR_DMW0_INIT
>> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN0
>> +       li.d    \temp1, CSR_DMW1_INIT
>> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN1
>> +       li.d    \temp1, CSR_DMW2_INIT
>> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN2
>> +       li.d    \temp1, CSR_DMW3_INIT
>> +       csrwr   \temp1, LOONGARCH_CSR_DMWIN3
>> +       .endm
>> +
>>  /* Jump to the runtime virtual address. */
>>         .macro JUMP_VIRT_ADDR temp1 temp2
>>         li.d    \temp1, CACHE_BASE
>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/hea=
d.S
>> index 4677ea8fa8e9..1a71fc09bfd6 100644
>> --- a/arch/loongarch/kernel/head.S
>> +++ b/arch/loongarch/kernel/head.S
>> @@ -44,11 +44,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>>  SYM_CODE_START(kernel_entry)                   # kernel entry point
>>
>>         /* Config direct window and set PG */
>> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0, 0x8000 xx=
xx xxxx xxxx
>> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
>> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0, 0x9000 xx=
xx xxxx xxxx
>> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
>> -
>> +       SETUP_DMWS      t0
>>         JUMP_VIRT_ADDR  t0, t1
>>
>>         /* Enable PG */
>> @@ -124,11 +120,7 @@ SYM_CODE_END(kernel_entry)
>>   * function after setting up the stack and tp registers.
>>   */
>>  SYM_CODE_START(smpboot_entry)
>> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0
>> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
>> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0
>> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
>> -
>> +       SETUP_DMWS      t0
>>         JUMP_VIRT_ADDR  t0, t1
>>
>>  #ifdef CONFIG_PAGE_SIZE_4KB
>> diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/powe=
r/suspend_asm.S
>> index e2fc3b4e31f0..6fdd74eb219b 100644
>> --- a/arch/loongarch/power/suspend_asm.S
>> +++ b/arch/loongarch/power/suspend_asm.S
>> @@ -73,11 +73,7 @@ SYM_FUNC_START(loongarch_suspend_enter)
>>          * Reload all of the registers and return.
>>          */
>>  SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
>> -       li.d            t0, CSR_DMW0_INIT       # UC, PLV0
>> -       csrwr           t0, LOONGARCH_CSR_DMWIN0
>> -       li.d            t0, CSR_DMW1_INIT       # CA, PLV0
>> -       csrwr           t0, LOONGARCH_CSR_DMWIN1
>> -
>> +       SETUP_DMWS      t0
>>         JUMP_VIRT_ADDR  t0, t1
>>
>>         /* Enable PG */
>> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmw=
are/efi/libstub/loongarch.c
>> index d0ef93551c44..3782d0a187d1 100644
>> --- a/drivers/firmware/efi/libstub/loongarch.c
>> +++ b/drivers/firmware/efi/libstub/loongarch.c
>> @@ -74,6 +74,8 @@ efi_status_t efi_boot_kernel(void *handle, efi_load=
ed_image_t *image,
>>         /* Config Direct Mapping */
>>         csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
>>         csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
>> +       csr_write64(CSR_DMW2_INIT, LOONGARCH_CSR_DMWIN2);
>> +       csr_write64(CSR_DMW3_INIT, LOONGARCH_CSR_DMWIN3);
>>
>>         real_kernel_entry =3D (void *)kernel_entry_address(kernel_add=
r, image);
>>
>>
>> --
>> 2.43.0
>>
>>

--=20
- Jiaxun

