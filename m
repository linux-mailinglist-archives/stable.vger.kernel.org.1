Return-Path: <stable+bounces-154642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCCCADE54E
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 10:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970E5189C46F
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960227EC76;
	Wed, 18 Jun 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="EdntvusL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DFA239561
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234331; cv=none; b=nq7HfdSiA2Cyn+/eiUQtIlBpz91FV/2Ylkyuq8zcRS9MZma2rFfII+assUX33uDO07F2/fSXOOUNRDQonlUvOaa+4aUW8sFvhVAtqFJYAosIkbKkJc8be+aA1aXUGJ7CjWbIOguBL2N9Hll77a2uwmScsngRbIyEKae0vt6OlFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234331; c=relaxed/simple;
	bh=0RQPUVwvAOsk5IBp82srvzdKvozlrwpTmR5FjAY3tkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcdXdxHer/PtqpqyUsWfF+LTwqBPc2fo68+NGkDPn/eSF0hDvMU7QH251RP4tRVIfBIphQnKPNcIyY7sW6cfvi/n9eVZjI4JGC6CPBzM0Vqo80+3hMp0z5EemNkEPgnT9VrkG40z1zJFHDRqb5+yBD+P0vHpjdil3E4LxLVa5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=EdntvusL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2366e5e4dbaso4274475ad.1
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1750234329; x=1750839129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brjF5TFgyuOObGUl0vP/36GKYjNLHFU9TL+BiTpUMpo=;
        b=EdntvusLIWNlwvN1hiHkvQOPSq1PSmVx19x9i9cABqQIryizJOks5J1WuMJ6bb6RmU
         LCn/vzdO6FJPgzqJyaEgfqcYCohpbYvplaI8PsRf1TlXKWyHToV+zm/zns/ZeFGHhEZd
         IqceooA2hi6ED+Onv+qzTLsTHssHWDsFhgoWCy/43AQbRHHiL3UEeC9+NyfBS83ABKYZ
         VPlGXBGiLcXEhU4AioSdDKzeUk/m5LOrhJAYfx0h+QxT2D65auorMmbxx6fz18zIWfV7
         OvQSXpYqkIOlLpDedRCpDfqnov6sMHtQKydl9JU6dJbdOFzenJV2LOVm3me1zFsZC9op
         6Gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750234329; x=1750839129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brjF5TFgyuOObGUl0vP/36GKYjNLHFU9TL+BiTpUMpo=;
        b=IQC4qR3eIe+Pd/uG4ThrRIpAzaxdiuUEBCIyFQm4U1lT/yZzR3ScpHWM4jFTqpBavz
         Oi/eVMw42+mN19NqZiNDG4vAppiKo9r3Uw/DGE6O8Np8EWkvTCawLSIEjOFIuQf9D8m+
         0Ji6gwArwRBkzrJGstJQ2tEkAUKs4pCckxdg/gNhym+fQ/G5G9zTn+r+PDzCIFCt2+Av
         xgRzHnRC0sr/u4KUBytJXnEtgjZzuCHOktN7yszaY3Rsl4eazNg2Bwv5MHP3dmc6Pda8
         gtEZe90RTBcSVA6fi9GsbpWbTtzFJ30dFYUfn5ZhUeHqBL0psY8WDXQLM81MquVJtSqM
         1NwA==
X-Gm-Message-State: AOJu0Yz6eLvVLZINWK+nnPRIA89ITCXT47YAIq/oYb8dWvFubT4+cdQf
	Kyp8dz39Sr0Dp7GqOStduH1ENi1B1GSRO4C/dC1qSff0i+Y60jtGbWl5jkyoZj6nuM/OWeTr1Ph
	fvcmj0T0VwmWAHQegPemC/h+tLFQbzzCivWjOHg+KAg==
X-Gm-Gg: ASbGncs00Udd/LXqKAINQoIsk3evFeJ1ptANO+x3NTXK0lh52pnl71UuxqCdmQ2pbpS
	ubvPfkgS/m4FUxoUGCjgr6D5WsW9843z3Z5aKWO/81hbnht3/cRrIwfe4J4gdmQ7lgMinUJu5S/
	TW7YaERr3xDC16uCuryvflv5/I++fW4a34j+5/xq7GLMc=
X-Google-Smtp-Source: AGHT+IGpJLHZtnqyqQh2JhkwSxrOCuHgk1TDDY09x7fcoLDuh3vm/ooqXWD5JEagbJwkl/efavMkytyKfGh/yNK0AJQ=
X-Received: by 2002:a17:903:228b:b0:234:11e2:f41 with SMTP id
 d9443c01a7336-237c2046e94mr26764865ad.6.1750234329638; Wed, 18 Jun 2025
 01:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617152451.485330293@linuxfoundation.org>
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 18 Jun 2025 17:11:53 +0900
X-Gm-Features: AX0GCFvsu6UCDmq2tIZWb5YR-nmqe-aN02_fZ-ldFZkqfeOhcwzzccegmgganmE
Message-ID: <CAKL4bV7fgF4uFC04rDjjAYVYG9vJHhYzfwq4yB0s7ns-kqdvXA@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
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

On Wed, Jun 18, 2025 at 12:29=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.3 release.
> There are 780 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Jun 2025 15:22:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.15.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.3-rc1rv-gd878a60be557
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed Jun 18 16:32:09 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

