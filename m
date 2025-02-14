Return-Path: <stable+bounces-116464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A964BA36903
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 00:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83817188C752
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C02D1FCFCA;
	Fri, 14 Feb 2025 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="mASSejbB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E471FCD0C
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575187; cv=none; b=iLjHT0x+69E6IjTGYoT1JNTKENOeWiT5EHUBTEFMESOtlLAXdFOIlOdg9DBXD9eMmIbNJx8fLf2EoROcDzhLmnELe0DQ+7xp3Iv6/8UFn488MCeEbEpfhmas/HfO5Si8G5Nch/O9MwDUasjzxQH5H9236Xzv+pj5ApJtxl3UtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575187; c=relaxed/simple;
	bh=IVCW8vVwUdVf2Ohvyaabldfb9qJTAjpef7lVg2IxJj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TD3y+wpS+kzNqBn/dcd7+uPmHhvAtPPHAta2/BWfb4Hac5N4INdlz2OQT3cpDS1OydeOmr22PIN6ZC3wi4jW/Wu+WWxG39/UplZya63ixjU4W4tbBqlfvPo6iEpk7fp2xjpSfYGh0P4Qa1sbOjVaP1U70Rwz+Cy8Fvytqzl+OYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=mASSejbB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc11834404so3483011a91.0
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 15:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1739575184; x=1740179984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1kptu5/J+vpdEp6ep3Tn6E02zBSHfeej1qMSG9kR5Y=;
        b=mASSejbBqka2CMPACMh5Jijdrd0+x9m+VwFin12UjxJbeemt8yTj26NmWJONoGAoCg
         RqCWmPqFqVdwJO4tNX5P/zlR6swXWTFkEypWm6D2aczv2WZtiMrJZMsIweLSb3S5AnCr
         AukdAQ3lnoAE6hONNK/M6Dj53POg9c0v82x1ezd9wB8Ry1a3VLSF8LwAjJepyeGbN+p4
         D5+1egzW3lAWPHHuqdDl6PWnx5FESNucEgVcBiVxLWeqpcyDs3np2pmWHj/XrbF94Ul9
         JCw+YdfuPLq5E6SEA6KrbUjtIrNwN5q6gMQjbt9p5QCenquNR2xjmgqgeOX/CUjMoRiw
         ydSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739575184; x=1740179984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1kptu5/J+vpdEp6ep3Tn6E02zBSHfeej1qMSG9kR5Y=;
        b=mbqwwSbT9p/Axzr+XlL+IbnLGZJlcAVhexMrdDNUD/og4cSQzyB9lh5J8A+buAzKhM
         p5aMyKdB7axSa4EGSTPOisUQ+7VZ3221f9/Z+axCTgBzTeH6UwZwzMMMNQxdhla29Fh5
         jGRyRpP/CV0qIOIoic7Jb4b9Y1qFMJzMsdy6jyH/MMb+5DBshtnjX0IfR3dhN8SaQPaV
         6N5fGevhbrZGJrlZMEqWy1/CUAuMajfJvKtQhqNsaez8wKfdaJSe5tHjU42tfQQ4qNE6
         8CIC1zBVAifCcbyQOxUGJv1Zi2LUdnw8wsZbcoE5bfWCFaWzpiE+0F4E4ETISd9dBG2m
         9z7w==
X-Gm-Message-State: AOJu0Yz+EfSrgnSM3uVfb2vU2EtjdAgCQAacewDopWYmD5GpvWsfHzfQ
	e02CZDp6Nu0yFMnlGM6oRIiops2yPdHAzfgVgxWV3p2CoqpzQZUITPAAmR6GguVNyj2tnk32QvL
	Z1JBJ4VFltFgpWpEUz1Nt0Ie25I1XS+lf4r8dEg==
X-Gm-Gg: ASbGncslfDxdlk+WNM0aj320tdwMK7MtGqRv3lJ0lHOeGkzXbFWpFfkQnt+OyJ6TFA9
	B5pHtDvdJM2athnHdGyG+UfsEGPlteP5rPDuNdoIwbvpUlNOlboy1FhIsHnD08yNRzukGF7M=
X-Google-Smtp-Source: AGHT+IEMDk4JmHkWwYaC0JdU3mrceeG+mLsI96RmyYTF792fB06bA49XHLnAxr/Cg0xW5tlJasKPprqGg2xWInDdScY=
X-Received: by 2002:a17:90b:4fcf:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2fc40f1040dmr1245930a91.8.1739575184167; Fri, 14 Feb 2025
 15:19:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214133842.964440150@linuxfoundation.org>
In-Reply-To: <20250214133842.964440150@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 15 Feb 2025 08:19:33 +0900
X-Gm-Features: AWEUYZmSJWzwPPeIoaUIOQDKvcgfilAIixByMHWDgVxEElGNhm8DLhW2jW1DgKE
Message-ID: <CAKL4bV6p=1wrzk_HoLMTog7a8SyDaZz5UtkNRgV+j-OtkTjq2w@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Feb 14, 2025 at 10:59=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 16 Feb 2025 13:37:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.3-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.3-rc2rv-gac5999a6c007
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Sat Feb 15 07:57:54 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

