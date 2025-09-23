Return-Path: <stable+bounces-181504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F586B960C7
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8453B9E0D
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59D3277A9;
	Tue, 23 Sep 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="g+Fnp81f"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310134204E
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634945; cv=none; b=Yz7oRm8dzk1xbXqe7cAUYxqH17ljF2mb785PzjR5sprPwOg5182PVLMs9XdioKxEDJbLyIg2/v4YnE5OPWYp/TBEsKuJ644k2WhD2MwmyvEopk8qwrBB64liuFZNXGKIZTtTBRcDISNr0fILDS1HV1lstOukj9suBHWFEts9Ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634945; c=relaxed/simple;
	bh=HS9NBcbYrfF6iVaTRVwQjnuNP9ZIEYwzdwsQ7rWcF6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYLIwI2WN98TZhYzwblfKJCpHEguI31teOL8H9TbhGF5AGjeptCsC6IxVPmyDsl58FMDLEmvKMjNZmM/yd8E8LQN+UNjHPeYPTx/MW9hFgGF341RAJ9Nly2NxY3Kei9atqgJiqywOZsAkIziicgC++TxcZL+AnwXChHBnMrQLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=g+Fnp81f; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4d46af01e95so5618241cf.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1758634943; x=1759239743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJZq8+MPLRJ3ip5LcrsBDiUfLaLP/BnDgi1MJHXazU8=;
        b=g+Fnp81f8NEBFGQD+r4hiyqktMd9n/P398edJxqfW9gfCYwiY3SYI6AEP4Iw48rye/
         HeDnl2QiPD7t6czMd+Tg1FhzJatV9ZBQbX67UPKo7V36l6vRd2h3rdsw8PDM66U/UFml
         q7M1hPsAwHfnYIWgLkpt3UzthOR79jaKmLX8GvogszNQ5sG1bl3fABVWIamJ61c/WLpG
         qvSegANZCOTtWDI8cBOwo9xv+J9vcvq1fEmeE4CisP8sgqjPacFCXsgB+LSpj8y6Sw19
         DyxDYnEsWKaRoeBmq+EiWiAtRySfLUk+R7atXlG2ABxWJCa+BU9Qt3Y7Pr23/ZSGbg+q
         48iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634943; x=1759239743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJZq8+MPLRJ3ip5LcrsBDiUfLaLP/BnDgi1MJHXazU8=;
        b=v8vGeyOoY7r6/Vh0VwN7tZ0XH29cwuewC8e8oxL6jAiIgWawpF9Sy39+iAFP6Uhf4C
         UigDTfN99VtKXPguZNDillfi9IGAM3m3mLd8Pgey6uQsi+fy2I28ITb9tkVk++yvXyEk
         TqnGcDyUlAf2Q+7ybBOEBHQtGduYosHaC4MY9ELVW+52ocZqDA/kbJvBnQidF3KR7f2k
         VxF428Wr/bXFOHh8xghf9px2zbrsCfJuZkfM93YaDMLO6v1D7b2bYweVtua6EjpGjRLt
         c05eBkUBH0eCO++gxfDP4lLfsumCz1LOzUKxj55UlCRN5foFJqjvxhhP4MabwoO0/WMS
         tGSw==
X-Gm-Message-State: AOJu0Yy4kxDcrkJ3/HM3tFL7I57afxlQVMxnPqep/BBKJE5RUy4Akqi0
	aIR38leGdu+SSIoLE6rpmIiX60KycV+Vb1NNdS92yqyQjspVNqpFT7ahMVQh2m7ch2pfQP37dv8
	/hQGScYpolJw9NHntcfmOI5aIId4tVqJbcIjkDpErAg==
X-Gm-Gg: ASbGnctRGmzxV2RmceMYmBLO3RK9qyBP6qKzaKoIlE8qXnmmeT6gJJJ+vPLed5h6FKS
	0uH63VOOkjF1yXf4QpOAkbqQr3b3sWg98WD/UM4ciBMt2pg8wyzs/XQlkY7WY9JOc2pLSTjClSf
	GHPldxHp4cAiL93K2v3DN6Upob6NkPQnwWO8e1ekK/y53Njp/QQTm35DN1XyyRaJpfN9DdakJvR
	ZPs8vrP
X-Google-Smtp-Source: AGHT+IEqCByMJIyOisFneYcEhg1XccZAqMYXIft+cqIQMRrJVBiZ/D9q5dXHkPruO+JLDBqSs2MuwjOhSz0Yq99OO8o=
X-Received: by 2002:a05:622a:4a18:b0:4d2:6ecf:9123 with SMTP id
 d75a77b69052e-4d36a18d5c2mr26501131cf.34.1758634943106; Tue, 23 Sep 2025
 06:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192408.913556629@linuxfoundation.org>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Tue, 23 Sep 2025 09:42:12 -0400
X-Gm-Features: AS18NWDivHJSj_z1iQ5jwb40ouc0fUOHoSfttu2yx42awG0vFzK1u2_FMqUyWE0
Message-ID: <CAOBMUvhU3VMwD2OnmR3zewO=MQhT0o6WbE=4rEbZiC=xTn_xcQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:37=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.49-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

