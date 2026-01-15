Return-Path: <stable+bounces-209953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 807ECD2844D
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 21:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B608B300FD69
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D632145B;
	Thu, 15 Jan 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="JLtqZrjt"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D52EAB82
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507216; cv=none; b=ZAYparxeWrOhq03t54KGGAusJGVhFJMUBK8utXfX9Qk0t9wbSvDjksmA18gFunXEHa6cSKLuaWgqVkNBajK6YPdngrJ54fFLSlbq9x36nMs09QDrixEd3tYGNNM/Elxki6jARj8DW8hKXrQE9bC5kZ6/3ncxZ2FHE61UOlEDMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507216; c=relaxed/simple;
	bh=VMIsD1egwo1cLTvv+6DvzP3o6Rv+S11pibHNd8YKHgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+ZxdxRJlX6SI4/7CVkvDJm2BImY1YiTR3TokTGDOEwudammZkn67n15fAOgcYkqGfnDQBkdWSLc/aF5ZFxwD6p56ndyyPfDQkYTOuQc0NM7bfqPe/LTINZ87M92o+RwbQ7Ie7wzmHALwR0cX2FvRpEHPkx3RAOz0VLVltqsoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=JLtqZrjt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78e6dc6d6d7so14105627b3.3
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 12:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1768507213; x=1769112013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5v/2b9hS4lqAYWxqpA0HCoJBnyBMfO3blrngfEhtmM=;
        b=JLtqZrjtTGojA6nDGjMHNVOPpqoiHs5B/6jFZ8AyOkdFk/x06pY7QwTBtz+KV2KjgB
         H3/ayaH568c692KWbAeAa+xVHzNvRI+2j+/RnIaIg2/qSbw5/AqxmTSjKZnchaLJVn4f
         WIYM0WbK0k8RBJGz468uLQVVV3LXD3VVnP7t1hkNSXhp8RLQ8C7X/gJVE+zJm+nQqpgA
         wHCV0AITBcVSq/FLqXoPdasDCj+sd1ypmAjdEhwPvqgZpYbEJHOftCrrr/wgzT2e2maP
         BL0YnFsaQhboHbECQ1rtNmsnl4gaVyp7EQSHEIv5QexvHFEHx2qsS171IE83ZJDMAFYf
         rPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768507213; x=1769112013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5v/2b9hS4lqAYWxqpA0HCoJBnyBMfO3blrngfEhtmM=;
        b=LaLQ/o40LW6ncs2Uau7EnXSXZsX21rkJ2OFmdl4E9DRT56JpVcux6xBKHQZ20q3izS
         CO3LcwL49CgOeCf4HHmmSPaaUUZIF1eoOCkg+1W4EF5/WoYUYr1wosVwhgYyCNhtnR+Q
         PURPsmm/qIwscNy2qVOedO09quvROzG8714ckAZCNtseMNRu+PP0k5PVjSsYHj71SZc3
         lXU//VmHgrmtnUZwn0+eUOkvcFQ5WSIA5ze2MTnUeWxiqabj2rpo/aUnWQY208bJPMK2
         wba90/PKLZsN+WBDhXQSwksdqrMHCY/uhjX9FYhvIs1AWkfNBbyoz+i7Pf1/Mr8ECYtn
         /P8w==
X-Gm-Message-State: AOJu0YxQZ02MEZc1Ks3esPeSGXwl4F3l8it8HDDny2te54Mo9L7Y/Fe4
	AJ69mtwU5tcroTlHiS28NxMf3kBGz7NtrlKEjdvrsXoyPtLaAb7hLcSjI6rp5qi7NehlP7gIO/4
	mg0dZsWcK1kTYX4nWq0HTe7TQXKwXTqbZt1zaRN0OrFvX4TqxaimmNwKbwyHcnm4B0iedjIjznv
	paAoHfHJ13hpELAITtv1DD9E3ccRE=
X-Gm-Gg: AY/fxX6tyPfmiMkhsyO8R+ijcVL1gZjw/C/esWuCDgPI1pset62AvSzfCKKpL+V/9aR
	Xvp69I4v9Qq7L8NYKaJ8Lh1i+FpF444jlWupOooTPndbNA4KIrG1wyLapzMNZHp7tQIGLtTboKa
	a6B27NEH870zNTx3BedTaBDTO7QXaCoQwua2evYbqJnR9rV4o8DrxJc3WKmlyU690DlEYVWiAKb
	/xegMr3QPvmWVf2lPworDWPZAbuHVSx+NLCdJG8Us3Zu/K7Mx2S93mKqcm9nBEIxTGnfpzmP75W
	whertjyHccs1rYbT5bnjd6Epv1Yp
X-Received: by 2002:a05:690c:90:b0:786:70d6:96ae with SMTP id
 00721157ae682-793c67f6f84mr2729987b3.37.1768507213288; Thu, 15 Jan 2026
 12:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164202.305475649@linuxfoundation.org>
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 15 Jan 2026 15:00:01 -0500
X-Gm-Features: AZwV_Qg_JnrAlcMrroGYpyFHUDmG0eBuJ3RQfdnuXDZ_Nb9Tpz25ZcFdbDTC_qE
Message-ID: <CAMC4fzJqyDb=yQvSdUxDPr3PxP0PjMT5_-m_YPuVT9enSjZMeA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/181] 6.18.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)

On Thu, Jan 15, 2026 at 11:53=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.6 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.

6.18.6-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

