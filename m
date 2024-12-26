Return-Path: <stable+bounces-106151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0659FCBF2
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF791882B78
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F745BEC;
	Thu, 26 Dec 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEQHB3k9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770310E0;
	Thu, 26 Dec 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231759; cv=none; b=l4+8QtfCxaiE/Muewm1iZY8OcPuQqKd1eVUA0mjU0HRGJni5ygavwFBaiiTuF+ku90VPq3nay7dDYqW6K0HmfOZuYJmu6YeWQqA1ZN8IZ0i4FRVCklS1ANBP5+wLnDARTGApw1dkhm0JFQUkxlPmt6oVp0UpfEDN9j4YKhLiWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231759; c=relaxed/simple;
	bh=L+cBLo/DSzgj2MCwGGmqKWP3pKu2xdyjynZneTk5mFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvvR4HTH5T/85PIjQ4tXk/qkumivg4rG2/cqmHVSoNhrT/+6CcYsm4JjTJQhiETUyDip5kZsKfjJX6gylh92tyRyCb1Wnee6ITlWqxV9Wcx1YBtGkXY1W2Mfz2FBR1eBIqi1ZbnyaodkckghoW+FvjbMg9AG/WGAFmGLVrHuXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEQHB3k9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so517211585a.0;
        Thu, 26 Dec 2024 08:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735231757; x=1735836557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dKjpTzluOX4sYgZaMCYyXG9mQUoSmGwseybG8AskV4=;
        b=MEQHB3k90a9e/iEVmxNFHIJMH5I2MN2+B+cXpMOdYpBliJRhoqhSEznDjU5uaFa2sx
         A+OsSVuraRBq+7yir3olqckc7UGAtjeMw7n29Ol+aoI1EIsK6PQiV87SuDo+kc/kVFFI
         g/BlbAExgwDLHBGSpTFBRqO6YBrRlVXqkKm/q/yJq1ycAbzEmQg4qaXe5pc8o25ASaHs
         nADHXdChyC53TyLD49f2Gw/MRu5UrkySjf13IBxa7IHRZLY095TiIoo65i/9jn5Y38Xl
         lEE7+NzvEc0WvYdd9uJy/pqxLaqF2pyUz6wJkAgJx+h9SmmBiGiDjEQgYr8FVEQz3YYi
         derw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735231757; x=1735836557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dKjpTzluOX4sYgZaMCYyXG9mQUoSmGwseybG8AskV4=;
        b=N+SvbpNqFHbnWsHO0lLLAxEVArEcNJeC+yPQ6IKP/2ewCOqmaD4hG3uGBheDTiEtKm
         5mwkyDZeX9KyC0fseUkDiXwV50N86zhrq2FRUaqjP6aX+6R/Jv4QaVXpWyKM+mUYFXMb
         wEZ4jqj+xd5LKuf7bLkjufR9yPbo4pD5bRS/9dxUtCBGWrrEMeiQ5mOgzY1DhYWaLu6e
         NJSOmUK+JUZbKWwPYt7WyNton/LSZS3spLTKwPgFP0deD2grLmlPvP1jujjvNAwN+/TK
         F/eGNJfFGuUTLtDYt5aV19kkpEt1lxUNbNtEEQQ/sJdSFLk+jEgn8lA3FGqvWKby5UTh
         ROlg==
X-Forwarded-Encrypted: i=1; AJvYcCUpNdCyGc+LGYbC0mYQfxLf7R6WqE6TfyGHvDpZ4cP7uG6cEjPP2VY9vyRZZn0J44cywz72b1wa@vger.kernel.org, AJvYcCXTiOHb0Aji2B4lTeAXD8c3FN9+ObYX8zEfDfd4iYqexo4jK5NSVHfJD74RcP23u9oKp+R9aRb1d5cbIo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyppFVCZieXu3vbAA1EndpcQHbZ9jtEvRWDarpeWQTaa6TkomNv
	wowokLJa9CjcS/9wJ+Pbik6ySMeH1ict7RA0y63qiRqeEZPFXjrW
X-Gm-Gg: ASbGncsBcF31PrhmcPFuVBG+8RMoT8Sc41jjUhq8HhrjG9SZKa92GmvsnWzpe0pM60L
	WXQjXRw5WJJ0tvsK3XF1O6gNxucbd7j76mdEggYLGTD/0vP7dqFKhFTyC5kK2Uezf8ga43F2c/r
	wOCv9pTVZZEbeLUjGahc9UtBvUs59/+RH+N8lj9vMpDLVE5o4bfOcWNvTvpBaXz8hBCkl1fW5Io
	6RT9EeN3/etUe2aLdiEaF51KY9KGoukW0s+ikY37QCFF7h9Oj0F94YmLZQmi8BdJL73a/vXxSn7
	KWzbMIAZqjWbV2PSfEU=
X-Google-Smtp-Source: AGHT+IGwM0VcOmTyuNkkCH3jDngDzlNY4DYmQMpWUwi+u5p6nJwCC+N8VfHpif9lV2IYuqrv4x/yOA==
X-Received: by 2002:a05:620a:24ce:b0:7b7:5d6:37fa with SMTP id af79cd13be357-7b9ba7ec006mr3847569185a.41.1735231756798;
        Thu, 26 Dec 2024 08:49:16 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30d319sm631532285a.55.2024.12.26.08.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 08:49:15 -0800 (PST)
Message-ID: <899378ff-9960-4857-99e9-c39dd4ebe8f5@gmail.com>
Date: Thu, 26 Dec 2024 08:49:13 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/83] 6.1.122-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241223155353.641267612@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/23/2024 7:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.122 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.122-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


