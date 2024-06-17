Return-Path: <stable+bounces-52551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 887B090B51C
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8572B3432D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAF1BD001;
	Mon, 17 Jun 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq+QdEWE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF51BC096;
	Mon, 17 Jun 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632203; cv=none; b=bZbezNCqh4RLCRB1IsiRj1jSF8Ij28XBr7z6nujJRAtxChoUH86ML3krIrvMfWZCYitWhd7opLBsZwQSrUpJfE9gAe05uyCAYenFrijYsKB8YjM4Vmu5QbHp8nyosSZSOxJW1xvtiEXd8g0Gwk2bWO2o8WrltgXesTYYBtnLkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632203; c=relaxed/simple;
	bh=yrKK/FLgdeL4vTw1EPHbtUzwl+yDef64SSBgC5EFVdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqX9oQ8GhOClRTYukk0qUrXRe93NMymMfMAnGUaQa8fMlJBP7S+IWKb+PCtS4x1lAK+IHDf9KDNPNcJ14D9hk6teJ769DRtH64kc3GuJVQ5atgw2gpdGACOWcGEc88MMcRep/AeGFAEpiqTIbV4UFYwviAByP4vg5x+1xcjcYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq+QdEWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF1C4AF51;
	Mon, 17 Jun 2024 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718632202;
	bh=yrKK/FLgdeL4vTw1EPHbtUzwl+yDef64SSBgC5EFVdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bq+QdEWEZzkWlhGFnMRc16Abid5TDmHgFYYqE6xIk1R8Bk3pbIulBckc1uXM7hz1R
	 5nmTLgWwo7C2QPeJPyGyMRS9P67Jbk5fcRPXymkmoOPk4SFGiZCIEyP2/o1w+2Uajd
	 8agf+TalVvhWGl0hg9OYKWOPIsa5cqxaYHKyvvgwMvEx6S0LA6oPRyxfcvZNbSBJOo
	 SsmF9YKnTZ1LriNPn47UR//SSzkmOfWPUaSRKKnppkOoRLYBnWLIbE+nLvyGCTqRk9
	 DXlA+SnnF2vFYiwOg7qrQsgjKk/sN4G7vy3TPMQujehKWrve1B3PRti1qGZrxxrrGK
	 no4E4mEfyquIA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso485977466b.0;
        Mon, 17 Jun 2024 06:50:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdqT4Fbjj25xfwnzQg4BO8pA/a1qDaOZz6ASFf5QNAq/2lJxQjEdYPm1Jgo3nLrUnuDn8pQbQblBJacNhfu0NkpgcgAiJ1UN13GwanwbBPbZP2jQfcEmLbDU28ejWPf7PnrHTT
X-Gm-Message-State: AOJu0YxeVol11nEpTyoO9novY3360Jh90ZdNzxlq17VbG9KUW+8UO+YF
	6TJlAapbm/3IpqmadXCka+ZG7ai8wbhSAahojP+gOAf2hLduYbydFI2hN8TejB7aOWSxrg9birI
	Qx/Z44hZGO3AaPNrocZC298fqIW0=
X-Google-Smtp-Source: AGHT+IE/oHHeYe88noG8KjRtPsLqaTqOpO+t//9vr/Ts4ydA6Uentyu9J9fqUU6wRbgsZdYwMlN9Ey9cccSUsO6DQTY=
X-Received: by 2002:a17:906:a447:b0:a6f:5a47:a59e with SMTP id
 a640c23a62f3a-a6f60dc55fcmr657469266b.59.1718632201209; Mon, 17 Jun 2024
 06:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
 <20240613-loongarch64-sleep-v1-2-a245232af5e4@flygoat.com>
 <CAAhV-H7VKGMAH10S4sOZLkbgkUSMAYzpYt-dL83S0Vg286PsaQ@mail.gmail.com>
 <f9a0d11e-53c7-4a15-a7b3-209da8bcf52d@app.fastmail.com> <CAAhV-H5C0rn-bY11FxoGANX+hEFrrbpj095ZAEbjC0ksQGuWpA@mail.gmail.com>
 <b291e5fb-bf3a-4129-96a0-99182e11f506@app.fastmail.com>
In-Reply-To: <b291e5fb-bf3a-4129-96a0-99182e11f506@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Jun 2024 21:49:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H48ZO6XH51g5kgB8jB59qpLPYJiuaC5_zNxPkB4QvhZvw@mail.gmail.com>
Message-ID: <CAAhV-H48ZO6XH51g5kgB8jB59qpLPYJiuaC5_zNxPkB4QvhZvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Fix ACPI standard register based S3 support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:44=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=883:32=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> > On Fri, Jun 14, 2024 at 10:25=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygo=
at.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=
=8A=E5=8D=883:11=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> >> > Hi, Jiaxun,
> >> >
> >> > On Fri, Jun 14, 2024 at 12:41=E2=80=AFAM Jiaxun Yang <jiaxun.yang@fl=
ygoat.com> wrote:
> >> >>
> >> >> Most LoongArch 64 machines are using custom "SADR" ACPI extension
> >> >> to perform ACPI S3 sleep. However the standard ACPI way to perform
> >> >> sleep is to write a value to ACPI PM1/SLEEP_CTL register, and this
> >> >> is never supported properly in kernel.
> >> > Maybe our hardware is insane so we need "SADR", if so, this patch ma=
y
> >> > break real hardware. What's your opinion, Jianmin?
> >>
> >> I understand why your hardware need SADR. Most systems DDR self-refres=
h
> >> mode needs to be setup by firmware.
> > _S3 is also a firmware method, why we can't use it to setup self-refres=
h?
>
> That's the problem from ACPI spec. As per ACPI spec _S3 method only tells
> you what should you write into PM1 or SLEEP_CTL register, it will NOT per=
form
> actual task to enter sleeping. (See 16.1.3.1 [1])
>
> On existing LoongArch hardware _S3 method is only used to mark presence o=
f S3
> state. This is violating ACPI spec, but I guess we must live with it.
>
> Furthermore, on Loongson hardware you have to disable access to DDR memor=
y
> to access DDR controller's configuration registers. Which means self-refr=
esh
> code must run from BIOS ROM.
>
> [1]: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/16_Waking_and_Sleeping=
/sleeping-states.html
I think "if (!acpi_gbl_reduced_hardware)" should be before "if
(!acpi_sleep_state_supported(ACPI_STATE_S3))", I applied this patch
with adjustment.

https://github.com/chenhuacai/linux/commit/4bb9e051a4e9430c89ce83ca68a2f599=
8926e6f6


Huacai

>
> Thanks
> - Jiaxun
>
> >
> > Huacai
> >
> >>
> >> There is no chance that it may break real hardware. When firmware supp=
lied
> >> SADR it will always use SADR. The fallback only happens when _S3 metho=
d exist
> >> but no SADR supplied, which won't happen on real hardware.
> >>
> >> For QEMU we don't have stub firmware but standard compliant SEEP_CTL i=
s
> >> sufficient for entering sleep mode, thus we need this fallback path.
> >>
> >> Thanks
> >>
> >> >
> >> > Huacai
> >> >
> >> >>
> >>
> >> --
> >> - Jiaxun
> >>
>
> --
> - Jiaxun

