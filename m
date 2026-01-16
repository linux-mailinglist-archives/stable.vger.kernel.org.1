Return-Path: <stable+bounces-209983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE481D2AB9C
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 04:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E346300B346
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 03:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2761EB5C2;
	Fri, 16 Jan 2026 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASM6X+NW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5317A308F30
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534059; cv=none; b=G1q/QaKperbzE6Q++gxcwYB2mwY9+pIonzD1FXNNszYYdwBiS/WKlQ2hdw0Tq1GoON2ES2hOx/F5UM3EaBMJrNM8rA2nBtHBV6q/eV6E/iPYSpn/o0ENjJf0qrH0xbtFkXEUCibZ2+xX7yVEyd17KuhOAr4MwVrHEKkcd4h5EbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534059; c=relaxed/simple;
	bh=p3d1EHXMUOQeKyrfaJSUhMDbMgpFor3RXHIRlsf6DtY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cJ9YWILaW8AvDuSRnVTSEU77uy3lUGgZ2hfLW0bxBp1cLRJcP5JIQfKnwOP+DQi3nd5vpmVxvqthqlrarM6deqcOjSIxFUqANUjPiLhmD0Ba9zieE+aQJEbh93i2M4CF3gVZGFVtu8o1pkjkgAim9PmrscFhpW7sU0/L7nCehW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASM6X+NW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c52e25e636so247511385a.2
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 19:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768534057; x=1769138857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3AL5LKDwPeiFpaSLwckrMLYTWVT1GdxdmD3JKnqXBI=;
        b=ASM6X+NWT8HfvXAO06sdWdHkojMHtffsXCVrUkQkhMPRvJYEtr7Nzyb3WCC5k/hvrj
         rgEi33U9OjELHchbxNrAt8qE1Y+ZECp7V3SS2Xshk5o4OXceUet80PMz6veUvaOgl8+P
         tiYuPZ1WfvbdSmIknh6qo27J4pE43fF4Ys0Ad3SfglGbag/S3yyBk3luNBp2+1Rxahbc
         Va0QM1W37XX1GEwEsFi9mheaAyzf5ZY1gD2poh4uFjonAVw4oOPwGtonF5g42+Xynw1w
         tCKZbQgma5owI3Y5X81UX2x29CCF0E/rrjQTNmy4ZSOqClu3wlwVkZsFxgZ8f9u7S52x
         KfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768534057; x=1769138857;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3AL5LKDwPeiFpaSLwckrMLYTWVT1GdxdmD3JKnqXBI=;
        b=aAjRW1xV7UyAdFXnUf2MAlBzGSt+oSudOzwzknlS89OZkZCvm0cXdN77cVL6Yssrri
         5NhVnTDOHdmXSOW9qhQd8zJOL8UzEqpuToGV+Dlmp5qu1x/Ml79JlGYI4/RTh+S4+0sf
         DrsLvtGbnvL49xB11OxZBKtg9g78de4+etUBYJJRLMZtFju/ei9FfuridvuofcUPG/72
         R4YFynXMSUm6YCZNUV1PlifUCkkrwQJeuf3odWY1XWlkcP+EmxpyiAcRq0RvNZa3zUJZ
         JhCBnT9Hpp218ly9cXPe99TtZJ19qLRjxaOCk/G18KmfpQgLmksugxttieG3U/pgjM/n
         QznQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpSkVZG8o72WhxJdeCbJhtsDXaFrlmj3U1PDhR1b3iAp7TdD92gDKnHj9rSPKzAWRzEbgPikI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYdRON5fJM1eroane3s3rfIP+sRBM0/1+Qdn13lEogGRLIQ8M
	u/9r8Sp9r/b4pN4JBXJxHJUPIsyMnQ1NDk/uLp/+UKzjYYIIW49i1bFIUr+U
X-Gm-Gg: AY/fxX7Nts7L+sqvm6RHCMNGj2u7ZD6tghDMmlDmNvlw0OxGv1cN9GpavQfAgQZVwzn
	v4LsmuSbUPkFw2hd26YOYJvg3bnUbYIcrrIKUaJqjOijapPya60mwRNrFoOxI92+smBk2N2VncV
	aCytefXCqN/1wish0JIp8KCZKRxOWwgnDSDq1v1bt32rs/nMjNtpP1cSTWsrCiMkeCx1hF83YZK
	RufHDucLSwSPuIPN2kLmO24bP5XM18hiOcGpEo4VsBZkB0oyd1T3YpcNAT89lhK9CbHPZ+tLnmc
	EvEt1rIyn5V2KbxjclkuyaC49uvkNFEi+hcH2mLzc86qXo2j2sYlqEmecMYFTxn9UvscJFbPlBj
	jyOLe7BCrRuOhuI6XlQys58aO+uJd+vZfMhQmeKk24inz0XiUGW1i1lopKTKNoxaZYphHRSg0Mg
	2IYQ1GHRgijIRd2RNLLZ0mfETf37U8u1eGUuxqPss=
X-Received: by 2002:a05:620a:1909:b0:8c5:2e5a:5c88 with SMTP id af79cd13be357-8c6a6963474mr220639685a.64.1768534057140;
        Thu, 15 Jan 2026 19:27:37 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72985a8sm119245085a.54.2026.01.15.19.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 19:27:36 -0800 (PST)
Subject: Re: [PATCH 5.10 000/451] 5.10.248-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164230.864985076@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <2710f4fe-1ee3-575d-0bae-f1e8c02e9117@gmail.com>
Date: Thu, 15 Jan 2026 22:27:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.248 release.
> There are 451 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>

Limited-features 32-bit i386 5.10.248-rc1 compiled without problems and run ok on a test device.
No regressions noticed.

The VT console fbdev bug seems fixed. Hurray!

Tested-by: Woody Suwalski <terraluna977@gmail.com>

Thanks, Woody


