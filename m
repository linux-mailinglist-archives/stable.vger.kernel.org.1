Return-Path: <stable+bounces-33018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179488ED6F
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 19:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A741C324B1
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD325153567;
	Wed, 27 Mar 2024 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCeTsRHG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAE3152509;
	Wed, 27 Mar 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562183; cv=none; b=BD49dXrNol97md5vvbtLUEjn8MP7oCg1eKD2XcccMmBv+VIs6JcqLogczm7Vxrh9z/WqNOXz6LOgGGLFDu7sKa9AGhdZewZPwrSBBa72zLj4dYYGLjMdQzsbga99f8lBEFEbNyyyJ47mJmqgyViRHrHfv5jVjtcyi1fGXavvAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562183; c=relaxed/simple;
	bh=A5OZfumW4Nkr75ub5aDkdy9ZipNjU4eDXOpIbr2SpUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXZwUdirMvQP60vlwpzgJa4pQDTdHU3shEfVf/AOapUl50RMJFYpuc18ai8nPgllxU+H21n1ocoUOAOYzIfDpQ3U2cPbvd3il9xuRYEDO5cF3wDFrWtK5FIE45ebpvj46nkJ76zN9SbdZWOSrowjItmtOGwEzMlGQyrnAMXdUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCeTsRHG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45f257b81fso11411266b.0;
        Wed, 27 Mar 2024 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711562180; x=1712166980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nFAttpJe54vOxcMGlEb92SUE6AplwRdjAbuLfITMrE=;
        b=QCeTsRHG07sre+Z/8Ei11Wq53tHFjhVqdt6ZUwA8uQ8kMk9V1ulRyVQomFEggVUQcK
         lJsAyKbzlLxHGxV2sFk68T28+/ZY3gwPuKXicTlHEBOp5osOD57RuoE1SlYQmZaQFyZc
         O4PPMZzvSigdZZ8LZnmZQ2piN7U/DpUn3TD+vUCG/wjxgxRVJ0Caxdldq+kFoB5QsdcQ
         jrPSaaJ0cm3rFVXvXISKNGLB9u5v1PUNb4HTMLyMMSwhTcw89Em91L3XjleOPtPA47mv
         U9AbQD9ydf4zVN0tRJ8p4KxL4UuA7TVCF8bvggI30C7udxxHOt4J2esHoHNY4tRD9jF6
         ChmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711562180; x=1712166980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nFAttpJe54vOxcMGlEb92SUE6AplwRdjAbuLfITMrE=;
        b=u9MjucjBOgMoaFwZ+2WIlgs31W8RS7TiW9ZDMaUscWu0YoQ5XNXhI7ZtHULDmtHMh7
         IqePuYWvRW4IDbVX5Lp7DaWpxo+zHldzMTvwHrCTDHAUNvRlaihmeqMeuXAMCJF902KY
         m1ju287GjbeXj7OHgD5s2vQ0MjP+2goS3YKCE9wS6leluRuCiMp7bWC7AoAcrmG3ieJY
         W1B7nlBsD6zaHvVMynnulT20PoKbJJmPofAqZp62+4k24PRH5+NzH1DuQPPXD1XTAn3u
         aSMSTqzfGfJUZlXrCgLmkAek6cmxyRDxLu/mwF1EtkaueyYXopWPjZ4/6g1zx689hpHA
         cUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjfoDX+sP80lIc1suevu+HaqFdJjoxrMtpir8H7re/VHXrnvLaNg+KA+S3UxZZaRbuPve2jVt+Md8VzZwNEX53n7H78gR5
X-Gm-Message-State: AOJu0Yyx6i1lRxIQ6PDfBcbp5nU0YlQbMuFasGOZIlFAnN5ImgZDGVyQ
	wc/7za5xEReG0kCuPDoVKkped/X+K9V6J96DF2FwZjj8AmsTR0+7szM/nyiSmTRVSAfA
X-Google-Smtp-Source: AGHT+IEFmDKZx9ODziEI4Hzu/xvKsmsptouiDseI82xiELxTSU7AxNk9ZVeKY0s2/vTcGDeazOUpHQ==
X-Received: by 2002:a17:906:c316:b0:a48:7cbd:8b13 with SMTP id s22-20020a170906c31600b00a487cbd8b13mr154217ejz.52.1711562179875;
        Wed, 27 Mar 2024 10:56:19 -0700 (PDT)
Received: from [192.168.50.7] (net-93-144-80-247.cust.dsl.teletu.it. [93.144.80.247])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906c01200b00a472eb53793sm5668834ejz.161.2024.03.27.10.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 10:56:19 -0700 (PDT)
Message-ID: <bc0c1a15-ba31-44ba-85be-273147472240@gmail.com>
Date: Wed, 27 Mar 2024 18:56:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Revert "ASoC: amd: yc: add new YC platform variant
 (0x63) support"
Content-Language: en-US
To: Jiawei Wang <me@jwang.link>, Mark Brown <broonie@kernel.org>,
 Mukunda Vijendar <vijendar.mukunda@amd.com>, Sasha Levin <sashal@kernel.org>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20240312023326.224504-1-me@jwang.link>
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <20240312023326.224504-1-me@jwang.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

Can those changes be pulled in stable? They're currently breaking mic 
input on my 21K9CTO1WW, ThinkPad P16s Gen 2, and probably more devices 
in the wild.

Thanks, Luca.

On 12/03/24 03:33, Jiawei Wang wrote:
> Please revert my previous two commits:
>
> ASoC: amd: yc: add new YC platform variant (0x63) support
> [ Upstream commit 316a784839b21b122e1761cdca54677bb19a47fa ]
>
> ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2
> [ Upstream commit ed00a6945dc32462c2d3744a3518d2316da66fcc ]
>
> PCI revision id 0x63 is the Pink Sardine (PS) platform, not Yellow
> Carp (YC). Thanks to Mukunda Vijendar [1] for pointing out that.
>
> The mic on Lenovo 21J2 works after enabling the CONFIG_SND_SOC_AMD_PS
> flag, which I had not enabled when I was writing these patches. 21J2
> does not need to be in this quirk table.
>
> I apologize for the inconvenience caused.
>
> Link: https://lore.kernel.org/linux-sound/023092e1-689c-4b00-b93f-4092c3724fb6@amd.com/ [1]
>
> Signed-off-by: Jiawei Wang <me@jwang.link>
>
> Jiawei Wang (2):
>    Revert "ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2"
>    Revert "ASoC: amd: yc: add new YC platform variant (0x63) support"
>
>   sound/soc/amd/yc/acp6x-mach.c | 7 -------
>   sound/soc/amd/yc/pci-acp6x.c  | 1 -
>   2 files changed, 8 deletions(-)
>

