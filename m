Return-Path: <stable+bounces-52130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4859081B1
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 04:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D575B235AF
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D50183092;
	Fri, 14 Jun 2024 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDZbcEEF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D706183093;
	Fri, 14 Jun 2024 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332383; cv=none; b=IrqzpABmmJ0e3lEfHzG8NqfWCxmBr8Kd3Rc5Fc3eaI7WP9OxNJ6321sCbvYdPc9i6g19BnXqZjD9XpZ4ahHilEOvfh4jUHYgo8gotwzcpeOo4OH/p0qf0XJ8peKQV0964Ggxm0P9s8ikLFnB2leEfo8UWMNDlfyZfFQvWUcbPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332383; c=relaxed/simple;
	bh=Pz9nCDlQgsQ4A3M5HvbVB4dsEro2lGM+ALxa0iEgzRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us4COJozPRxiboOF6eyDXsXrfNLCyDX8bJ0GM5qmSjFb6eEDVQtn5JYpKWY3+fRzydJZoOiYVlEQgfFY9WY8+oWSeJRmBgBaP71pPe3ARG0mRdElCPjf8iyMX9htr3z7N812I3mKwrr8wOs6i/unEPEK1I+E2m45uvDeZ1Z5lOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDZbcEEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA66C4AF1D;
	Fri, 14 Jun 2024 02:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718332383;
	bh=Pz9nCDlQgsQ4A3M5HvbVB4dsEro2lGM+ALxa0iEgzRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VDZbcEEFMD4c7t2DHEo9PB3IKpR0ubzrlRn+k0PIshparo4sXnDAvx1oN4rc+ee5C
	 LB0JoIBXU+SEUMie9dHCXPxwIjRc5FGsP7usn8gUT9DLa6wGWq6LE3+XA165bswoLK
	 biQRF12UwswkiFX8E36wYeOrLso1nvtHcTJKOU7ReX+T4pV3qUv32KvhGV0ybtRTdF
	 mUEdQxPam5FS0D68O/wjVR9NWRBt//j2XN+Yo9GmdADsxf53kO9lAvcaxG6hSV8Esi
	 aryCGCpxsRWy/ZPAw3sorgf+J9fskWp4fz+2dbdKBMxYXQmfADTuP0YpeCEqm/wUT3
	 cbJOYcXmkJtpQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6269885572so481978166b.1;
        Thu, 13 Jun 2024 19:33:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuhTLAwSZElEH2cSN88GihfG0FA0qu8+3eF6F2HPxmSVdJQlfDxXQpTUmgP1jbIBj6m7okS1XYR7NaJucwib6CoPuzFHqXGfu4sIGJo6nLi+Ne5kwxYUEb6cKw7vpShjtObYvz
X-Gm-Message-State: AOJu0YwXpYV2LEOTxis7MxsgjX0W/DwdrUHKb09J7Rtc6zkqLyraNpoK
	VF65YjpDwUTIKLYy7J1pGzjsqzTCrJyK6Uy/rRsJR1pJoeGXLVTc5memNgTSwM0y7V5GqtKG0ac
	tYl42aWhIQWvvpv1Qp2gQevgNJOU=
X-Google-Smtp-Source: AGHT+IG0fLCIldfGtjKG0Vm/cyHpCfqf3lS3mnBCGWiBVoWG6bdQ8CPEKPxVaYzM63bSKNFc/JRo5fFbzjb57gwM/m0=
X-Received: by 2002:a17:906:b15:b0:a6f:5a8a:debe with SMTP id
 a640c23a62f3a-a6f5a8adf73mr223091666b.22.1718332381631; Thu, 13 Jun 2024
 19:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
 <20240613-loongarch64-sleep-v1-2-a245232af5e4@flygoat.com>
 <CAAhV-H7VKGMAH10S4sOZLkbgkUSMAYzpYt-dL83S0Vg286PsaQ@mail.gmail.com> <f9a0d11e-53c7-4a15-a7b3-209da8bcf52d@app.fastmail.com>
In-Reply-To: <f9a0d11e-53c7-4a15-a7b3-209da8bcf52d@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 14 Jun 2024 10:32:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5C0rn-bY11FxoGANX+hEFrrbpj095ZAEbjC0ksQGuWpA@mail.gmail.com>
Message-ID: <CAAhV-H5C0rn-bY11FxoGANX+hEFrrbpj095ZAEbjC0ksQGuWpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Fix ACPI standard register based S3 support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:25=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B46=E6=9C=8814=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=883:11=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> > Hi, Jiaxun,
> >
> > On Fri, Jun 14, 2024 at 12:41=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygo=
at.com> wrote:
> >>
> >> Most LoongArch 64 machines are using custom "SADR" ACPI extension
> >> to perform ACPI S3 sleep. However the standard ACPI way to perform
> >> sleep is to write a value to ACPI PM1/SLEEP_CTL register, and this
> >> is never supported properly in kernel.
> > Maybe our hardware is insane so we need "SADR", if so, this patch may
> > break real hardware. What's your opinion, Jianmin?
>
> I understand why your hardware need SADR. Most systems DDR self-refresh
> mode needs to be setup by firmware.
_S3 is also a firmware method, why we can't use it to setup self-refresh?

Huacai

>
> There is no chance that it may break real hardware. When firmware supplie=
d
> SADR it will always use SADR. The fallback only happens when _S3 method e=
xist
> but no SADR supplied, which won't happen on real hardware.
>
> For QEMU we don't have stub firmware but standard compliant SEEP_CTL is
> sufficient for entering sleep mode, thus we need this fallback path.
>
> Thanks
>
> >
> > Huacai
> >
> >>
>
> --
> - Jiaxun
>

