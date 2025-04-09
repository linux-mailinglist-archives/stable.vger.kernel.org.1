Return-Path: <stable+bounces-132002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFDA83206
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 22:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8BA8A5367
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629622116F5;
	Wed,  9 Apr 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+LQmf11"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F820297D;
	Wed,  9 Apr 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744230684; cv=none; b=Q/iMrWxWQVmrUl5gLu5E0oAdGfURO+FggBfR3che97sBFWdmx+NlN8na/F1Vwevc3OldhIEXZ0kHRxxXXUi/GDZMfA6x6AZZ+WzS+71CMNcdMrkWbTFLCRcOakZpULc7Wm8lTHlxsTF6A5s0AoecG01Sy23RF29bKAfGx6mrBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744230684; c=relaxed/simple;
	bh=NbC5ELZN9Ih2DYNkyX4oHCuEmbu6CSmsTujIBO0gs6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyFSdxOMfvVpynmrIF10oooOW5C4/JgZ5hnWhxOXN4jzlGKzQLO8pqln+prAnAo0QWkknIily4LA3UR0K3Z7OBz2Z9cqKsXa6jT4/lJdDZNq6Xd0Pm/t9cm0Z5UaVi9KCW9YoSHFrixYEMq0zwO1SLd/N2YoNgN00EiYwUjsE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+LQmf11; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso23978fac.0;
        Wed, 09 Apr 2025 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744230681; x=1744835481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s4XngN7z2szBMR/KQWm2XGibZ6ERUrLePzEKPhYqqW8=;
        b=K+LQmf11EIQvXeyYp9XBV+J/+qhzfE0UcWOk0nnC0Squ9xN5n1++PoViYThca+uCMJ
         Dw5P5e0Bax20JneQNBx8iJNL/OwnDmMqaiJJ+W+gcdCKqFBSfyvKraHNhc9Leuts4YQ1
         xJv5OlHlvgOUDZT129EcA1/fYxKlYtjty8Dvr3tg5khmHUBX7qBpnUaLWWsEBUqTt+fL
         u/xikwz18qfJ++30tpcaIIL+LDjJpY9VzIQ2aBupVfZLlWhdBlfwLx+y7V2UgYEDV2zl
         1WtNYQJWfJ553pAHGnPNMorYjjCYzV+qIdPzcYAAotFbvgnkwNvLOigjP4rGrxKlww+f
         R/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744230681; x=1744835481;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4XngN7z2szBMR/KQWm2XGibZ6ERUrLePzEKPhYqqW8=;
        b=B3vRISkx1/YB6ZbIWsNC3cMtOHMD10GdTziBsqMmo8jpgjcdywLxOpwf84MjedtDqO
         TvRCInFEWYnVioVJbNtBvxBQ1eHrHUocvkPy1mJir7zBkPPESNQguwixtBTDENXHgCmg
         Em23gW8CefbTRndxs3bIDZkIaD40Cof+FW4HSksWdLwiGK/DCMKc4MDofJT5IdxQ+tA7
         67JMsvXqzhEpxX7C6kBnNclWo42nfOXkq1GYLB7K6X0pdhLZsl4t2/2RBoKX24u32eAp
         KRVabtYPC0Ly324ADFxiasT4yDyqgTJjZHi+uW+5hBIab90quiZBXWp5TtgQQl9yAfPV
         KxiA==
X-Forwarded-Encrypted: i=1; AJvYcCUFoqbJMr1ecSO3keIxuV2mRaE1/Cb631Tr884FhTSPQEbyQiYaY145iKMQ4ieharYtmRSiBI7b@vger.kernel.org, AJvYcCX8S76AJKybfoY/0Usf1V49sEGryPbBlFN2qsWaB5LB0LOZdYTddSjSb0sx03qF3ZrgN8/cy0hbvqzclm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1x9f63QYCMW+YACVISe8LNcvJGzfhmE9agmnwdsED4nO9mqZ
	g+ovm9toQyrwlMwOgIq++1nt1NQmMP7GBqBTBlP4IQb5FU99/kSq
X-Gm-Gg: ASbGncuqH9KKk0sCh4YF2F7Oypi4Xhor6u8WBpyIkbrJddTu8AvcA6N1jfwLdor1JeZ
	qyqbfMaHuz2tn7Cx7MoP0ZfMrnUi030jDW7OrA8iatqnv9D2E/SCUjMEQSp4O7VUZ85P8orxWFn
	bflZI30YlBcEvgVUe2wS3kcTW2IJSjVdy86VzFwTmmYdGeIJ9p+rrx0D/A7KdHeDzj9sKGz2WY6
	nG7a2sZbG6V8JjGC6oL6UmiybPLcb28TD7Jd4fYh4xtAJ1xkJBW8obGNNhCQAy1lyNcpZHxiA5U
	M6iE+lWF03YPnnY7iqo6Gx0jethMd7kD7/DTKcfL+gcpLhX0E2BTLAiAZFurFpPtuw9x
X-Google-Smtp-Source: AGHT+IGbt9Nnnn3HrngqyM2dww5q+XbKn3BlEvNDeWur58HwfY5FSf3BgPJFJjHgXcFpXiFsDFySwA==
X-Received: by 2002:a05:6870:b9ce:b0:2bc:9197:3508 with SMTP id 586e51a60fabf-2d0b3893c94mr74039fac.34.1744230680874;
        Wed, 09 Apr 2025 13:31:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096a20194sm375761fac.30.2025.04.09.13.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 13:31:20 -0700 (PDT)
Message-ID: <62bda51b-8a3b-480c-beb4-5ae1009260b6@gmail.com>
Date: Wed, 9 Apr 2025 13:31:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/205] 6.1.134-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115832.610030955@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250409115832.610030955@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 05:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.134 release.
> There are 205 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:58:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.134-rc2.gz
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

