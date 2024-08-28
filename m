Return-Path: <stable+bounces-71361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC1961C72
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 05:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E721F24F27
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8E129E93;
	Wed, 28 Aug 2024 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UEdniFD4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD7A288D1;
	Wed, 28 Aug 2024 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814148; cv=none; b=QokoamMGvJo42Nqd0KUS/MX07dpftu3VilYWXk6R3vL5uvi5kj0uUbCAHjLBwUzzxYBClXZKZS9+jLFOg1Cp/dF7T9sq+kTUM+ahBjRrRlw1Xxk6OxE8ZkDr0cfjML7g5N8awu0dEVgub4ETW4UrDTZnGAvTqh8KdQy2diVhQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814148; c=relaxed/simple;
	bh=SOTxwbFrMSqTW71U+pEymAMKbZxNgOikX6p9B7/ca0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5+M1HMx5fPgo+X/VyaSSV9kYkMXkO6uNlFkBfUfCibOP5Yr596K9IuON1FUQdAr+vLtc+rH0YaZtPvgEm3GOo/9lVgJRKzlAUuAC30vJM2z8R3sV4CtBcCQmoVV/t7uOAoMSWXNK1JQWwF1C235EGs6M4vQz17PLjK9W1n77iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UEdniFD4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8695cc91c8so660286666b.3;
        Tue, 27 Aug 2024 20:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1724814146; x=1725418946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJAYrp+cQrXiacMO/ZldsdhoCD1fUbRejySfU9vG1kw=;
        b=UEdniFD4dBiamrEs6T0ErbWdt6zSakIUysdX5UvItYEzGSs2+0L5cp/JH9lmGI030p
         EaefxAv8Se/0rBsjaLaAcR74N+A1tpVD22AJIfvakpiUVHtAc22UNLIzzyXkGUwKcMTQ
         FnXCjpnyxVaihw1HUgFA+8NSshKEuYXpAIMXa3Ux+R8QT4aU5DxfCUZpsle2nTJl0GvI
         2sjRhsauGbTogbPKRZlFcamQM7Z7ioEkH1ccvAcLHKjatm8GwkTquuFIw/Wr3MuImp/k
         rpsCMHauGwYopyG+Ismo7qTlvbqKFpsK9vaiIsvn0ruP4Ua/ZN1MPLFzdwcVxC9Z7h9d
         kBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814146; x=1725418946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJAYrp+cQrXiacMO/ZldsdhoCD1fUbRejySfU9vG1kw=;
        b=BYVTOYwV9jWId2pnMxFGswEtKA/AjGMmc4omGKnOeFkpZ2K439yEDmcoDQ4FsXQ6f7
         A/p+opHj/bTV89ER506KD8SGak6udKkXhamWXQTYTqMfMfalqom1NNKd7ocROis1S192
         4ZCJyM9FUr33gyZPNaZ4NImlPXj/9hJMgFxbtj+oiba+j+RlwWAX1D3IVIflYuIa9mwz
         xeFBz2jie1WGhjLJlbLqFo5Wj3NUwRSfl5TEFWgOiYlMQ8r8J4X4LOMhNz0zzvfdjn+6
         GIW0acTT3MalNJ6MUIssMCMnaFbFYoAbxmUfHxxyV8FJlXXyS1TX8vgnCCuV7Y6XtKhv
         fc5A==
X-Forwarded-Encrypted: i=1; AJvYcCVTAQrYQECrLPrsDluj+VLHVIZ9Zlc3aV8Bk0LkFduLrI/Et04TLUUA4Vld72D1wKsvC4KiKCRo@vger.kernel.org, AJvYcCXEKXWLrfJrNgEy/WM4X5wyZ1Q4g5zbSFSPv58hT74BbuJU+d+KyvogxexncJB2w4QMlqJeptk81H4r6MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKop62DcJr552cKuiARvI/uNAjIv3ZKd0W/8SVyMa2whMSO+By
	VALgCEYMqb2qOafhePJwbhfC0XCeJxndvbfQBHVUOwr5vR01X6s=
X-Google-Smtp-Source: AGHT+IGnRvkbr6RpGnEb2i9qd3/t6Se9AspfMmTn6r7ANZTx4fnF//jyWcRSwVeMlhldo5OoDMYUTQ==
X-Received: by 2002:a17:907:9812:b0:a7a:bae8:f297 with SMTP id a640c23a62f3a-a870a9b10c1mr48077466b.15.1724814145336;
        Tue, 27 Aug 2024 20:02:25 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd20.dip0.t-ipconnect.de. [91.42.205.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86ecaaba4esm147767466b.132.2024.08.27.20.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:02:24 -0700 (PDT)
Message-ID: <ac87b6c9-cca6-4eeb-b5c4-c65665873f5a@googlemail.com>
Date: Wed, 28 Aug 2024 05:02:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/321] 6.1.107-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143838.192435816@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.08.2024 um 16:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.107 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

