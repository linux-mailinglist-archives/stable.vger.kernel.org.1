Return-Path: <stable+bounces-207914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B84D0C2E4
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C613A300FFAA
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA2B35B14A;
	Fri,  9 Jan 2026 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="UUQktm/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC7500969
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767990459; cv=none; b=gEbY08hSSVqWiS9C/h1sDxiOmxmBt9I3Po5AVJa3b9wU8VQr9fe/tv5RGUQZCng0MJiyw+i0f36nMhpK/U6QN+ZKEB0MUw51Tcnq/ay+j7AtNkaeOT/kO83t9X1Nhj1iZ+vdM6fNiHWC/Y856hAOWEbpOtRxbmG31WzmvmwPLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767990459; c=relaxed/simple;
	bh=QLLpyUE73qhmQXN+CJkmDiHUYj83Q8PU288Q3UaLlIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMnGirk5J0m5rvr/SYMEcT9OVfWQ+0BzEhauGgmYo54ewvKcY+64+N0D2BK/KR29RTXvWa7gcxM9zA+2SDxs9XloXGgKNio5TK2dpRZSPTfwCCyr1qkSnqMUhpUStEcynSVT9cis/GrMaPfmMA89qbNaiRjAIo8wjucoCc5tiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=UUQktm/e; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso7261627a12.3
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 12:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1767990456; x=1768595256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzn8Cn2Tb2adGsWJFZC/d+iY4+cr9HLX7WNOFFn2IRY=;
        b=UUQktm/ePQ4j74pdVI4RQ2H8g+tqNxpbE/tjV8R5kmOLkZlAZn74PfVJB5oWxJy3pG
         ggvIHmntjYT1OJpMWlBwYRSJFluXnhoyhRK7zqspgm3fvOZkLxzYq6DcTXu651AdE/oa
         F6iNH4WdxcgDcte7LQ9u5onrxofRysbDY37fCHLzOi3tJry51y9oxSJzMrj1uUhRh+xS
         +lcCe8WN5Q2Eh9i/n3S+qdn6XGUXXHeecGLKbs1nJbCq3QQQnXQNM05bDOYzfc9P18Bw
         ggQnSDXKNQjyyDMyNroiZfSpwZMB8HeKkytEvsZF+aVGcgDpDaFZAcD4mFhPJ3I2ytCQ
         zgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767990456; x=1768595256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rzn8Cn2Tb2adGsWJFZC/d+iY4+cr9HLX7WNOFFn2IRY=;
        b=Yucq52QD1GvAhDuUuWvcuizHN9he3lE62QpWhveB4kn9TgOrjYiMzNc2UH8L3/xGbD
         N51Ml97LKeoQXKYsHSb+ovpOTekkBT4Qg60qZ9pLAU3z2A0IZPt35gGJ0mM9C5tYD5GC
         i+y3dcOgJTiDDv9COHLKUg4w52oDmY5aM8bM5C+XHGbMZ8HyGrC0/sq9RSNEYP7q45kS
         08K1J1aGI3+VHqi1/TEMcN0yvACBa+c57joNylJ0OBmHgiRLbDABngvetoDJ6ge8pTbG
         ncuoGE3CD7RwjiZu79UIwE4FenMSB7jxDUl1OHzIr/dVbEcBa6/W5GQFj9O0vWJhn9Ma
         5AFw==
X-Gm-Message-State: AOJu0YynB0PISw+nRfz+WoXnr+i7k6Rlgdr/vq/yPA86KvBHMzYptfr/
	jT6L+ehGPm2GtmQ+sy0kJSjp2MMLUDLkSr4iCI3f6wP7d6dtJQCSWGxeqbnSq99mN/GcUa0V991
	g5w6HGiZb1cZ+bmxABps6gqd0xaVSyHXbgpjt9oyKlhF5dFKn44C4b0Tc+Huo5oqDZBb4zPrjFj
	0c5kQbblCjR8MhCP41vLXGVsEggHZKB1p3T0rA4pzS
X-Gm-Gg: AY/fxX7pdyMOHqhc999ilfLYVdGauhsrhNAaJ48XsmWjKxtWyy/9hZyMqhmWPidFcw9
	m7mApHZTFxWXHzJ+8/6fNWZfHXbcR1T4EdcZA8ls7v8E6HEr22DOzjDOFMP2kwLK5T5zd04UUiM
	+Oj3dLHt2g1JQ56DUSzSC5l5C4UI4E4YOR2aCFiIwBgdjW059Txwi8VjI/gRmJnrihcoLlyNdr0
	ayRz0l2aOe6ZAHPnosA8IXg/rbHaHTW0uy9MVUrCMTiMQ1VCTQRD/10kNXAO50OjjXj9IonWuwg
	/jAGkO/XlB81XAMRDo/OW6Uenaku
X-Google-Smtp-Source: AGHT+IFBvZljOI015gxriiF4607a6cxNtE05LnIO2TIiARNgsemHcw8lW99Sa2jy3JM+sVzV/XSQFUQEvKr1ai7nmpk=
X-Received: by 2002:a05:6402:2812:b0:64d:264e:71f with SMTP id
 4fb4d7f45d1cf-65097e5d56fmr9089181a12.24.1767990455480; Fri, 09 Jan 2026
 12:27:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109112117.407257400@linuxfoundation.org>
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Fri, 9 Jan 2026 15:27:24 -0500
X-Gm-Features: AZwV_QiWmPySgS15kESwDoPBd4PAATDHtJcI1ZzUx9OG6oQ0PyF6PlGKKe-L6xE
Message-ID: <CAMC4fzKNpqO9LM3L1Yvdd5g6hMtXU2bsyw9m=3NL4Q22M5cA7g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/634] 6.1.160-rc1 review
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
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.1-sladew)

On Fri, Jan 9, 2026 at 7:24=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.160 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.

6.1.160-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

