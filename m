Return-Path: <stable+bounces-200789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74ACB5856
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 11:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F5D8301143A
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208712FD7BD;
	Thu, 11 Dec 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7K2dqhU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781A27FB1E
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449092; cv=none; b=XROUE83VQKjTdkXBUnx1nCrmplRcs+mWOJf/K0sUxp312DBk/+gqZd1ehLtfnMocoacQrhWpEY/XhrmqothQ7aik1IPMeUKKqVczGBx1RN6huiFj24vRvd50NnEX6+r4nIt/YZDyearBYzwXFxin6Ge6WYWTCww+G7vyFKcwn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449092; c=relaxed/simple;
	bh=HBYDLJR1RdpW/T0fiT1+DSTTlvnHoNCEpEMxydr5GA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq9BMIS+ueb1mR4eo2Y9ZRUiQlUgJMrgQYZiS+Yd41OmcB5Z+kQe7tQjC6qhDw/54TYui8w3PQ06oikNqVY3N9SC4H/ZMlYpi7HO+1Hz/OURCLFnERlACVVIsILccM6S7e6P6QQ/Y88oOu7DAQ6V8K+aLZWa6GJbDYo6Mlv5ltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7K2dqhU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59578e38613so754697e87.2
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 02:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765449089; x=1766053889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNNN4e07rtvztp8zwTQ5hMaN+orhRFxfBuu5WW+g9XY=;
        b=G7K2dqhUdor+MKhbOETVA2MOYlGfwcwZdcZEzlAZpNCMyqTmZr1XVhukb3ehfes/+R
         PN4KC59zUfycFj/usJmAs4SdXjg9954TYVSZPqBqO3yzFjD7zW6y78mxp+h5wX1YRniq
         1dwRWUrok9hR5HyMCiWsG/THLS0vkk120xbwoWwnDGAB4bNp+AWV+9aATUCd6dEhzAY4
         FO0dblM2TEEor+Ulhjmp5+bH1sEFR5JJ6KPO+Sx87RISvGGL9j8Z25FeTre5cTV7R4e6
         +f/3So2/kkcJnwxeDAmJ4GM+KxGngNqeSD8bjmUEQVetHftjxvlJ9oxSe5SsuAN1XKoM
         GrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765449089; x=1766053889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZNNN4e07rtvztp8zwTQ5hMaN+orhRFxfBuu5WW+g9XY=;
        b=RkG5S3u3MP6hV79mAZspfMod53qDG1PETS0V0vHZkqCqlwOXnfUQwh3Gi/VbLRY4dJ
         viksQIguK4L+aWbMKe95yGQAamaZV8Uj3MtL8YT67ps69UAQwLvUbrfdrimrVQvj708p
         dbePTSHO7lQ865GaDe+Sd64c0SV72qL5TDsP2ZdVZsBJA/4m/DHGSPXgjSTbQiiWLTyl
         r1tIBd90aN4RMszbWwlJXUTmRIO9WxGCQXwSJLbmnmRR9O+CsMz3gZxpBhFGcrt8K0Hh
         p+cwW9zaX/XcRfsoz7Dbx29NEOpyYt+GknN7XSjqrvsrZpfa5q2VAp10n51qoISGhd6X
         xw1A==
X-Gm-Message-State: AOJu0YworXXxLP4rpJzWeCadFwQlKJzIfPd4KsV4lmPfufIJ2xPGY2ly
	DtnL2KhXYjtmVmYxWA9BvdO2znAr6DBzuXInFjkCY5YRG7jLMJQFW02eA/bPnCvzvm9VOoW5fer
	tAdrG9tZKT6j5e75bFfwhe7BfdGcyZ0U=
X-Gm-Gg: AY/fxX4PnCyQXhsVQx1idUkOEBEbDmvxh667Vc5UC9C3caCpLLhGIqcug04Nu1Zgz+K
	ME72deLacE9bkhwV/najhMNGaEbB65C90XS/NP2nLDhwaFSwspnjiGBt/78PZHvhIUwICmQrTkZ
	+exlg+isral2gd+JqaBJB2a5/gWBVxpV7Q9jJ5xmP3fJ91HYAXoOTsr/HC79IfEX9LTR/rEwxO6
	53hkRdMpuxiA5aoT/VLwiS3JQEF9h/3XdPzldza9S//bGh331XhAl7PUH/EpQX6Z0VUz5wYtbwY
	ryZFvcKDJGlq6PyZ/bl6btc7yW+sqg==
X-Google-Smtp-Source: AGHT+IFGAcii1E/CggdUmqElEltnS8D49YBwplsr3oHeXBp5BKjX7mxRPMfwqVdr0oWv4bJbRCxWqVJ4LOIP2KYwDbQ=
X-Received: by 2002:a05:6512:3d87:b0:598:de13:609a with SMTP id
 2adb3069b0e04-598ee539ad7mr1700052e87.37.1765449088935; Thu, 11 Dec 2025
 02:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072948.125620687@linuxfoundation.org>
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 11 Dec 2025 16:01:17 +0530
X-Gm-Features: AQt7F2rXHhEiBz1bKTVq_p2PHL7WHxV1XhBnDlEMP2Lhpea71aMLe5-tXzZUTl4
Message-ID: <CAC-m1rrLNC21Fd2Z8yQb8Rnqs8kozFqhhcbVxxzXG9mVAiytAQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 1:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.62 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.62-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
Build and Boot Report for 6.12.62-rc1

The kernel version 6.12.62 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.
No dmesg regressions found.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.12.62
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : 4112049d7836ad4233321c3d2b6853db1627c49c

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

