Return-Path: <stable+bounces-177529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84846B40BDE
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97281B64F4D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A8E341646;
	Tue,  2 Sep 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7H0Lm7N"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4A4C9D;
	Tue,  2 Sep 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833631; cv=none; b=o4dxW5i5nJfYkx/F+2Bn4NRMGeeMH1EMnT9hA9SGdWCL3JGgd73++kYenxa6ug+nYotei20HXfF5p9VgGHJ3baPtDBfw9k+7J9Kg1niwMNbbfRC8l3yzIUxd2j6FoaZ2tQyrkdOX0sQSfu0E763Mqb0YYfYUE3qef+ulMyOMXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833631; c=relaxed/simple;
	bh=aAIA/74ykFG0qSe/yOMdbXjAvsrrRajO6wp0FuGkyIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smjMseoU2ug8GDLogoVmTesNt6ynWJao4nK4XFMzFui/+6hejwO3jQODrszcsiSTxea/+6NfsgqcsZg0mK+RRcCTSMVLtqFIolUGxmXbwsObo/YPEgDsOnTajpsWYootVthWzmlkCGT3pBAFeiEmUbaq1Q0BVm4xc2F8kRX+J0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7H0Lm7N; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b30f73ca19so28518701cf.0;
        Tue, 02 Sep 2025 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756833628; x=1757438428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9UcAoezJikf05g2UoojgkOql9xoE6wdqt1xJrbbCb4g=;
        b=k7H0Lm7NoGVDF1kd8SF5uWoECd2n/pTpxZ7WAB941/8WCroN+eklyGB3ujD/IIYx7v
         x3oRnLkrDYjsfusC62KKp5xP0O9U3EeZ/+c/d9Bo5ei+hMg5hkL1+fYqBKStLF3LBcYP
         U/+uNKwlRBcwII/yAvnzgEe3qMs4/jlbJJGevkepB0geC+aFCzZ/AiL1LXuigz7V2xhM
         k5P7wEAp81wFSpEXyuJ4kh11PvDvNCEAa9sD8pWxot/YhOtK6mu2+A58EnvXyJEhYiRi
         DTyLcgBYY1rCSCiG73CTVTaNEB9jhUVkcOAwCPynLbZny1lcgw5yr0bQx6ro5DwxwbE4
         X8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833628; x=1757438428;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UcAoezJikf05g2UoojgkOql9xoE6wdqt1xJrbbCb4g=;
        b=Z/d0TaJpDd6++P+4KdxRCAkz7TIrsxwbnRzxZrecwqp+3StyKmo3mRJmjr/y4EJSPJ
         /MfABbJ/JFjnDPEXw+pAuqIYduFDBTPvHegTklx9rp5/+YfA9DDkFH47eTOPnpBI+qNX
         FUZJZ43HO4XvM8hAd3BltUCSAst44Qo1G3xDOoM+me5WI11LvyRjlNZhjFmEPXLhRPId
         Pi/ylCLE3H02MUKSK/VJxZfUG/vV8IAVdQb1MdZoenicz306mITbsVCniSTEcvexO8z2
         2A1kZqBWlsb7zk9LGq6l2U6y0RssWi3IynyBKVdUR7JJSZz50aqZw4bcxi1VXV4xuZsm
         CaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV53vRDGrEC8hcyg1jSjmxlWDH7YS4UBoRgBrYVWc07mY0ewVYfsScdJbvUh/PGhhcrczsC1n1alBlf9zg=@vger.kernel.org, AJvYcCVGXZHfkfL6oV/nLZxPmM0ML57Ie9qUybm+Oi78WlwM1I+2QZhgAH4Ushi0QwSVJJuMgqDHrme+@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDdUGdR9lGSTBw9HvxRmBIj7SdaQDa9cyQrDA85oNNKuvfpNO
	Y5BE2CGfpV6kIcsqPNHncrdWAubumo9hsu9/rsLIYDum5yg3or9xou0l
X-Gm-Gg: ASbGncuT1poob88eSIG+Gqij3W0lkI2QQopkgmouUcZjOmMbmhEfOc1asvvPODVLIlI
	g6f0XKxwvSsSSty9VIiNjPj07jB0zvcwErwhibLb3XvcVLdbQpyHCNkZGC7Wg7WAiVPvew0m7Qg
	J9erqRhs8dSErfuS/jpveHc7WZndtzUOHJlzEEa02HUSC8izpLZlGrFUgDjrSXY/280019iOsmJ
	tDz+Vzzk6inUTkHEvVp12z6BkDyv+hZbaB9gMaVkIuX7GHpmhSG72OZNtEq8p8pQLnkl01jBlgJ
	FkLKzGduw64nPTOX+54q7MZWusilWG5/uYuVhg95tlbii15gCQdvkrvGTsXrq7HeqUlTMoIY6xb
	74hZw3y+Q+K593wBzADcO6GFYhUFP3x9qXDsmEsws0MJQq2Pp24DTtfM6cd6a
X-Google-Smtp-Source: AGHT+IEYQHz3uH6yvGi4Ms/HZ2DRPyjwin79idavp89EMunKhbND7hmID6a/w+sfeYcDIjyfLR1mWQ==
X-Received: by 2002:a05:622a:a18:b0:4b3:1230:f6e4 with SMTP id d75a77b69052e-4b31da1803bmr131402531cf.54.1756833628275;
        Tue, 02 Sep 2025 10:20:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80698a04af4sm170640285a.28.2025.09.02.10.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:20:27 -0700 (PDT)
Message-ID: <b546967f-d347-473b-bf57-901a63abe292@gmail.com>
Date: Tue, 2 Sep 2025 10:20:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/34] 5.10.242-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250902131926.607219059@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250902131926.607219059@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 06:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.242 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.242-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

