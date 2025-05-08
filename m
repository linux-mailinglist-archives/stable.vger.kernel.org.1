Return-Path: <stable+bounces-142866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD8AAFD29
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC051BC649E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10227465D;
	Thu,  8 May 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iBnNXajP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC90272E6F;
	Thu,  8 May 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714785; cv=none; b=f5wJCFCDnbnP8+qPFu0NfyZnF4uOBmGiQDegiVewWHMJJwNY4s1NlHBtzybjlo3jTLhSLUh8pqD2eja27266qp93bbpPYkjqdj/cLzi+wqrJ4JCcSJfjTuS4bBB8yJBucdLbalReF2RCAlAYc+er8b3ImByWi4HcOOjdHWVX+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714785; c=relaxed/simple;
	bh=PKdwLUJ4b6uhLUaWvClVtRL8TsUOOWdz0nDPWCMBJJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZbSGz6a/ZpxR2JMF3mHKFxeNCcaPfxhhIsoLU/rs7DSAxeEleD0Q/mqkXh9W3N9Cv7CBbDphZ+oYUxzLJIK1WUQCl2VhBVG3dH/WMbaGM0gOnFw9YwlFvlsfBKa9WKD0uPClEoB7fq7yi/X5KSbveHfaAo3v1p323J7mBOOlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iBnNXajP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso8060255e9.2;
        Thu, 08 May 2025 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1746714781; x=1747319581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVpGM+FMo30ysz88lj8EXy3YlqvnT2QjovJbfFcjX/g=;
        b=iBnNXajPc16nQmWf68PPdQgYoQzni2Xa81uvy44Kh+3XE2HI3OxN7bjZxxasYxYFHP
         FMzYXsk4FzWF9CVRuDZc9lzaeb99/3bgTbVndAXf+xBK85J/WY+saYc/AfHzO/s+Sar5
         X1L77h0eKNzn1beP6tM+gXc2HpGxkaLzczyTzYAvfkRceWT2uriCwC0L3m0E96d6qCG5
         u32BfXaRV6CEoN6gAUMKglk0Ibdnw+uTqfiCTqUpadlr4XwTYjl1s/E+mA5aXYqnLwXd
         HXlCZbBwRA+qUUb5beR8XS8gf3JPcFpyWvSw55nERqsv3Ub1S+mi6Sz4GYt1OeFbJSVE
         fAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714781; x=1747319581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVpGM+FMo30ysz88lj8EXy3YlqvnT2QjovJbfFcjX/g=;
        b=joRdnl1CkoGrupCkoeHt1rGMUCDoFAPyuEsXOLRSKuV2etp0qL5oHwKazDUCPLTsV5
         FAdb0545upzpbadqMzLM7ovd0J5S6Jcsk3vBFiky+9m1UVr49+N63qnyeub7Wz0xDZ/I
         hkYfHJJ1gQcVf8+aGvvGfpOGG3RMko2HvKgs2wnY5S9idZv91Mbj5kpFlGOHj3fzZvyb
         YSbhgnvjRitJWU+ZuyVn6QkMDeowgR+0PNX0E9WvEwv7a7ivFYOWfB219nT+SpMQyagp
         nNRP7j48lcos/bUpfWzV4qsGhCcrjtkYdB0Tg1o/t5pL5U9FHYLMIUyKVpdG/KgUvgud
         ptSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2kbC3yq5T5i72AqlvJVSvLIUm6V9WxTfnuFP02ZzOA+hoDZMf+lW8fP5g56kfCweSOQ3HStErHbxrNUE=@vger.kernel.org, AJvYcCWekxtkIHDmfCkuBKUXP2I1CQK/tU7Fuu1VxtCqqIIq/JjnWZlPUncD9d7t7OMo2/W5Z+EIs1fE@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAtqYj7TEyYOspValPCKNBH0MR2w72w9VQuJklgCFkm5VLRbZ
	JaC3v4QvgIk9bHnxkNBl/dyLAsAZ4PogkIb2TwO7r1Rbnozdf7gZ56Af
X-Gm-Gg: ASbGncuPOyQ3TlSZ93bD6LydFB9OmNt9D4RgKV3FYvLH8Rf2kA+wkqoq0kxJT9IzIF5
	m9tSP01IX2Aa3ZSAK4UVyEfFSg0uoJeQXE1AeeLfAwCP6hcAzwGE7GVWOWfFxHyPsUW9aoMc4ft
	qu2DNlcQqw2NHSgyoCbe7f0K6GaCSUbjUI9nF3OmrZ5aJ1fuT0/SWiCDt8wZSobnHoU3grtoPZZ
	rQ6DetPxiBLbwWDr0WlKgsjN11vpe1JExzj9P3uBB5ZaQtxILw+ZgaNfiuCMjq6G1A7R0peQjTc
	Yn4Sd6XNTl3Bf9HVPYpUYaY1jjxTUn5f/8rIAD4epfJZoe/5JtLYEdO3hcpY0c0Y4VXHO5rWc37
	wosYSpyIT7pTbD1nf+MqMpKmbqLu4
X-Google-Smtp-Source: AGHT+IF9TleCEx9QrUeooftYnEaQUJDpvNvn+pJfE+K8zBstr6jKsPRx876FClHihJRY1NHuZqvMZQ==
X-Received: by 2002:a05:600c:4684:b0:441:b3f0:e5f6 with SMTP id 5b1f17b1804b1-441d44dd291mr52581035e9.25.1746714781328;
        Thu, 08 May 2025 07:33:01 -0700 (PDT)
Received: from [192.168.1.3] (p5b05727d.dip0.t-ipconnect.de. [91.5.114.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d11b4c1dsm61965085e9.0.2025.05.08.07.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:33:00 -0700 (PDT)
Message-ID: <8aa84c16-ebd5-4115-8c40-63f82824b6e0@googlemail.com>
Date: Thu, 8 May 2025 16:32:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/164] 6.12.28-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250507183820.781599563@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.05.2025 um 20:38 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.28 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

