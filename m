Return-Path: <stable+bounces-171796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B378AB2C5C5
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A9F1887600
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9DF303CB0;
	Tue, 19 Aug 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="INlLeRhW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709A1DE89B;
	Tue, 19 Aug 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610446; cv=none; b=emGs/2tTQ+091BBb9IqtIz9s7vQugulJQjI5XFl3IT7rxQecD0GyODGOYv2UuiB+EoM616Qs5k3KgWn3o5ofU/TWch+O2B9Nuoe9iLQu5fM8z8n9akKnMW69i8kekowbxDSx4GSO16bRSDW3Xle5j+GGr7RJ41umN0Gif3Ldy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610446; c=relaxed/simple;
	bh=MWXq9VOomp2DQvGtRoxuj8RooMO765vG+1jEaxttcbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIpMs0OOXDZTtB7OMrZ3y1786xvCFa8chxArhMCw3jZYcWptTMy3b10jtr/3Gyk/RydVxZ9gRNVIs2NX4pwGPk06dZla20gltXMV2iJp+OXxu/dayWEfZtyzgY0maVcHOjtmfBDxd/eYC1VLcYZ21vKGaV4OWaLZivntquCttrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=INlLeRhW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7347e09so864415166b.0;
        Tue, 19 Aug 2025 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755610443; x=1756215243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMkS39Gi4zmwPHBP8zrSol7/0clLz5vuWWWUq0yrTRE=;
        b=INlLeRhWGQk6A2zAfsnD+PvjqQ2xawanX8XAbXElfgAljKLCGdbsRV61PlRZv7ihp4
         CemcUfKbZVPRTi62kYGgPDHk1xd6qME6FUfw4K+yINChBkDQBGR8KhuDv3Uv2A5Xv5+q
         RhVoY7GtpFIiILkOoUZst7sJcdXuR7Ez0wPmtkRWonGq5zPH+bLsOipkgUyniDJACiXW
         ER+650+G2tIYdXHDjiqbvYI7pA4pT8BURHNwMBSDx/jmGThx6Z674SEDv9sWCCY8LfNx
         iXiEr8z3r2HsaghOky/jdFpYMCv19I4VSd4i1+xapbRkNX0eil0egjO0oTpA/c7pD61Q
         R2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610443; x=1756215243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMkS39Gi4zmwPHBP8zrSol7/0clLz5vuWWWUq0yrTRE=;
        b=weTllvdsMdktzVrvv0dCZIry/rvbOJ1bypaSnemecgw+oxSti6xJBU+fyHgBjN4qAZ
         /8DDE2tj63Sr8kc5XjvaFcLoS6jL+dgkENAVQpYrPetWSL5AJigs/ShclXdI9vUgCo1a
         iFTayWkgjZI1Uyq+rHBwmIgSP83yDNCnoeBstqkx1R33xwTkImvWdM6TVbbrUi5fIFOn
         734cG10v2oks22Kpb3NzFDwDg+l/SSTFCmsSzhuxttABgwygLLBuDhWfgx/iLIxR2kBd
         qGUMRNOUuMI7fg4NFT/YfDJ3Ms8Q3qMzNamEwnNDwUqHF5NxIHkFCsOdrCkj9lsWzoIo
         8U+w==
X-Forwarded-Encrypted: i=1; AJvYcCVTUPqZ/gidfVGmJU6AogyIrZK65LhYRIlYJkFAbIGR7MlJkM4dW0N/cQwDhVYRCbN+325MmLl6A8g/Zjc=@vger.kernel.org, AJvYcCVsWtAcn3cUEPXG+Ecy8VzrgqxUz1hC9RlZNBuFj/PzhKQc0x6yTXxbVp/Ws0CAVMcjBU5z/C7J@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLcneWAGmrfcdtgIyy+luramzj1tUqhAR0KAila8iRmtJFbqc
	YNWQxPYvo6oY6dIudaZskmlhG1av58eltJjmJyMP2LRTT2/NPfr9a7Y=
X-Gm-Gg: ASbGnctVNRKPbQRzys+h1Oedfs80ULzSXHbGMPkMhU4vXDn+sCS3Lfjg5wHIR0TUmqe
	kr2tvr5gF0M7t5n4ltxfJme2NSgAYzF5Jflf46wYm9YWKHMaphXbURtYsiEnJcYvvqFxe44TEpT
	CcPYAJofDh3dnrZlYAGgehSmTLKYkOKhiQCtiLaQyP0kooOTNIsl1q/ycqO0WkpcG7rnauXzlzf
	nhlckbbpQwjmojfR52bfT9g/nCF6caP9Julmm4CynSUbV1Lm4xVG/3IYQRZq86gO47mcy3aA4GY
	0CNwwR7CmSqAdTx+2NNO+s9pJLcqlKGaoJnM096UmNYxtuM015TSq8O27w6JcFd8V8z9OSO1NQH
	NBRQgP91CSAPKLcjJdHdt/9l6b09XKUNvNPkN8bKjWies3406Ez9BLmY+vjbowLvnKH14o0D/Tb
	Gy
X-Google-Smtp-Source: AGHT+IHqb65cxZhCI23Qs7ElnV2Fp1AewHXJ5M8S9mU/JU4c1+05mdgft4OeUeZc8+F+7RhCjRM65w==
X-Received: by 2002:a17:907:9801:b0:af9:2f26:4f80 with SMTP id a640c23a62f3a-afddd1eb10bmr287721666b.46.1755610442504;
        Tue, 19 Aug 2025 06:34:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac4f3.dip0.t-ipconnect.de. [91.42.196.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm1697593a12.48.2025.08.19.06.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:34:01 -0700 (PDT)
Message-ID: <ece58364-ba74-4182-90c0-4d9b63567684@googlemail.com>
Date: Tue, 19 Aug 2025 15:34:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/438] 6.12.43-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250819122820.553053307@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.08.2025 um 14:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

