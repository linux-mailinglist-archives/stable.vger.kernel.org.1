Return-Path: <stable+bounces-75659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516729739FE
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8418B1C247B8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F71946DF;
	Tue, 10 Sep 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFBcdUGt"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66181922E1
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978941; cv=none; b=DVjOAG/Pr2RMEpHc4i9HsNo7iVdprhRzbnFXgyzeocFBIj1POiIIJcVa4UImSUKXhFxJG++Yc/dml5XY1+0MZymXDJ8Nax/G0mXlfp+QSjOK9dcj23GoXWyoLz/9TxAzXwYnDkH0IKkTt2fQ8bA/JNuYQPPzexRj966BX9t0zYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978941; c=relaxed/simple;
	bh=7RCDHK+BTLtJJc3M9GwORWj8tI6RSH+IGiIxcm0cxME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SK0dk5pVGj1zgSJG7EBpgmTPw84DAEw+jDcDzxqhBSDKx+bDvzPSSLp96blVpCMLsPpW4D4XQtRutwmdkbYj9JO81a+ffqbRIW2kkGlILjSlXkFMDA/hFA1VqVf467aBxNRm36y+ylBOTOtgFame0vxxQck90U8w9016oJqh5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DFBcdUGt; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5011af337d4so229617e0c.2
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725978939; x=1726583739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WifKBD4WaotF8X+UtX2lfxD1eqAgMkavmDZNd0guNfs=;
        b=DFBcdUGtlcNfs8DXsRQ2bmFiOpc3pCRTp4d7NQhUL1OOBMvUZix8AsEOi1TqZtzcUq
         fMjNbb6plPaX0ixcYDcT4eupqn+lfDdctfhMYj+J5gBvp/7x7ny8FcDpoytfcF/1/tXu
         r58YdKfp8drHXShS0Pg2ak/1WSpNc/S0nJZUgVN3wH4YxTY8342DEqZvxFScNcd4GR6P
         XrVL7uYEPnUmsvIyIo7PreecZtymLvU92mzRmlVXFd8TtEwwnA/kaMYRlTzmXQ3IxlJf
         2YCdAO97/7ymI7n6gIceVjxcLyuxfhzNCbK3Y04cUcopCY7ygvfYp6Ua/PnaSR0GoykS
         gmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725978939; x=1726583739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WifKBD4WaotF8X+UtX2lfxD1eqAgMkavmDZNd0guNfs=;
        b=HC11rIKcYjKCz6iFu9He3K10sgT+Q0W/Fq5RaU3nog7LsH9AGTwzxlIfcOHY3M1/9e
         gRIAknvuGKpoTE38teY+1klli4+sgnJzoe9r0scFf/iZUaWbsrc1hvp3DARx4Lm9GuOk
         nPylTFj/Z9SGl54rtXySXIudh+2xMzLZGqoylfqGAUQJsyTgJMCnrMXzFY2Zo2MK6Lbw
         7ClsFJpWYH3ZPgMKgJIwdS2r7onPeMhQmjT4oJENts7GEQs9DOzs9lmFINpXjXeituS7
         7j4bcSC3ipDozidd2isN8MCYzv55pWhlLr6aVBWYyf3C1cX1oQZ7e1OvdBnloja3CGa/
         U9YA==
X-Gm-Message-State: AOJu0Yzolac1ZD3OUDwNDDLhmYr1M3nUDn7R1gMEHd3ci/33hHtfXEJS
	z2O4u1h2k8FXPYhkpVIAsEEkF2TcO1+gzT/Ghg6peJiglNd2O+8+o6j1IH6M38MMXDAldrKUVU4
	kn1EXGuiE9fWIuTwKGC+O4BOtls7mto3rWcx3Ew==
X-Google-Smtp-Source: AGHT+IG56IxeJxMzo//8/ECLyeSetMnxmdoCauE97u7O2Z/LJKU+8CVElNiOE3Mdlcu/xMKPnyg4APMxgLv49j/w4BI=
X-Received: by 2002:a05:6122:791:b0:4f5:3048:ee20 with SMTP id
 71dfb90a1353d-502be8cecb7mr8674939e0c.5.1725978938569; Tue, 10 Sep 2024
 07:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092557.876094467@linuxfoundation.org> <CA+G9fYufdd0MGMO1NbXgJwN1+wPHB24_Nrok9TMX=fYKXaxXLA@mail.gmail.com>
In-Reply-To: <CA+G9fYufdd0MGMO1NbXgJwN1+wPHB24_Nrok9TMX=fYKXaxXLA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Sep 2024 20:05:27 +0530
Message-ID: <CA+G9fYv1yHoL9r7PkunHPNyPznLxfB9spSFbWvoFBBSwOYrT3g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/192] 6.1.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Peter Zijlstra <peterz@infradead.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 18:24, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 10 Sept 2024 at 15:36, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.110 release.
> > There are 192 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.110-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> The SuperH defconfig builds failed due to following build warnings / errors
> on the stable-rc linux-6.1.y.
>
> * SuperH, build
>   - gcc-8-defconfig
>   - gcc-11-shx3_defconfig
>   - gcc-11-defconfig
>   - gcc-8-shx3_defconfig
>
> Build log:
> --------
> In file included from  include/linux/mm.h:29,
>                  from  arch/sh/kernel/asm-offsets.c:14:
>  include/linux/pgtable.h: In function 'pmdp_get_lockless':
>  include/linux/pgtable.h:379:20: error: 'pmd_t' has no member named 'pmd_low'
>   379 |                 pmd.pmd_low = pmdp->pmd_low;
>       |                    ^
>  include/linux/pgtable.h:379:35: error: 'pmd_t' has no member named 'pmd_low'
>   379 |                 pmd.pmd_low = pmdp->pmd_low;
>       |                                   ^~
>

Anders bisected this down to,
# first bad commit:
  [4f5373c50a1177e2a195f0ef6a6e5b7f64bf8b6c]
  mm: Fix pmd_read_atomic()
    [ Upstream commit 024d232ae4fcd7a7ce8ea239607d6c1246d7adc8 ]

  AFAICT there's no reason to do anything different than what we do for
  PTEs. Make it so (also affects SH)

--
Linaro LKFT
https://lkft.linaro.org

