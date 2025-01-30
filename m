Return-Path: <stable+bounces-111756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26583A23730
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 23:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117483A7331
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712431B0F00;
	Thu, 30 Jan 2025 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz8YnXTZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB612E7E;
	Thu, 30 Jan 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738275971; cv=none; b=kG+VV4s8nN+CKzKCUDRKFivK2zXzEPSjk3Jon/nI3BsXPDbSV5lg6wVU6RFh1NLiosnndCDMLVBJEqkfJu2zBWwzwsTPVcEu7S8aALyUqv8AObR89K9z3vHk8fLxQORmOGR035QQdu8UuTg7evIuBXGQ0HgdWUFpjDOM4Xg1/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738275971; c=relaxed/simple;
	bh=xHl2SQMgOA2XBZOrSdNO1kp9Qrn0rIX+mKbYFjUHk+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGRGl5AuUV+f9VqPGQp/WVw5tbY6/Brdn1B5OV1PXoYQi13oUVZU2OjgpCjoZ7/Wwq1ogYG6OJaV+L80tuCmN9AURjUPsiCdNv0zwVKlL3qD94KyAGcGxZfpejjJtjKVwQry0QCJ3GryKbCo94G+Sy5OV2mHBzAqECtv/5QSqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz8YnXTZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so1823869a91.2;
        Thu, 30 Jan 2025 14:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738275969; x=1738880769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qptudTT3cNZ8XsCDenWkL6YV3Q4JTNcPbCB8ghHw3uE=;
        b=Jz8YnXTZXewTCyAPwXzn6O875NqNQXK4Pmut3rD6FfusVVK4RL8B/shICamo5ZvFp+
         Iosa3GijuCYkvr0o5LD/+OCkzcRlND+B4mkXKIrWAupAEaWVJeSkAg+vCLuG5jxl4dZ2
         puqDSuxVXiJF4a/M9aQVQsingysTOhz4n0BiRGieONm3YTWrojRZ4VFjzWwaRrW7X8WA
         cy2qFMYUBVZTIfxV0oYbwZgg4p5/yJ6WjDSUjVLaYZVnKxmw353CxucLKf+09N8TV/VE
         fxUJNCRH+ZT1+d9MjCxmSm6IO29EAXsD5aQF5+Ug2aYxFJ+8uptdPi5jwGlYX/5qCDbs
         sodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738275969; x=1738880769;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qptudTT3cNZ8XsCDenWkL6YV3Q4JTNcPbCB8ghHw3uE=;
        b=p0pA7O59QXnPVEW7aaK4YfLhCA4iGn3sqCEueYI+NtJhUKBQaLgvJW2AVc/DOXFcyc
         9afFx5b3Se2BZXjBYnwcs4qH6x7DjBo7sSOLoAnwt+lArRufrghN0B2YDJC7Jq6uo6Z/
         wQeC4g3gMAcP6hlzY1ue/2B7AltYtL44heyVgRe1uknaZ3l7HXPCSOhtIyr2948K2Vvt
         ZtU3bvrCup4PsaTRQQ81wuzEcjoNi4ax1p0XiN87pYhZk1mG8vwgdKBpiOttv+aCKlzt
         anXoNgClQSOjXamRUUdOC2Vtce3xqrxH7txmDowbom0jhWkHRs9xMk4iiYDDiawPo9vd
         6sQw==
X-Forwarded-Encrypted: i=1; AJvYcCVpKMhPqiBYnOq6KyF14+km0hnMgE+ttjfBI+1kc6Tfm6gWwsjbq483JqcwrxXSYSTaMMTmttiZDLuzvc0=@vger.kernel.org, AJvYcCXiZ2oWNx0PmPkzzrPGRwf7xve4xLLoS1bdLwDqcQjMXK2KUNS/QfOaQykaymy4ngw6C44DsH91@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/pvyJxN72BFPu1kRP7JGlZTDkRI2n+OBTGu5arauElm5ZQAwh
	eX9G76zOpeAIL5gp8OWQOQ4tty10/cnmEg8IfxtRkXHpu0hRnVRI
X-Gm-Gg: ASbGncve/seqPMcXavQmEOUZKTUIR5VolYubDXU9nbnAHoAIJrXO/D6W7Eravcgz+3A
	3hcELpanEVrQ45y9obIrL1vaYy0t1bMdNvjzkL0+uNGbs56AHAOXNtVR+cX3Gh2x8EbQUzURN9F
	SDRRkwPW7cMGbzPA1avcBVvGK2EX+eYFeFoBf4FWcMpy2go0bnBXM0jOGfJLg6SmEClZNZh7bMC
	vJH1ROBgBPgU7D8xkhG2/vwr02gL7QFj76YUc5wROipqwNKh6FB6W28uSOAMUR7IjReco/UyG1X
	YZnfiG/cOc7OMv3ydPnC9ijJpcYRgCmNbfLYAv946q8=
X-Google-Smtp-Source: AGHT+IGK07wTgifXspdE/ygnEIrvYCe4ktwMGoUL+Q/ZZyV5X//pqHLw9f5VXS1Xyf3fTr9Dt02PdQ==
X-Received: by 2002:a17:90b:4d06:b0:2ee:d024:e4e2 with SMTP id 98e67ed59e1d1-2f83abb3be9mr14009883a91.7.1738275969016;
        Thu, 30 Jan 2025 14:26:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ebf4csm18997975ad.141.2025.01.30.14.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 14:26:08 -0800 (PST)
Message-ID: <0a1af8e4-2fe9-4a0e-a9da-f93fa9716767@gmail.com>
Date: Thu, 30 Jan 2025 14:26:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130133456.914329400@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wncEExECADcCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgBYhBP5PoW9lJh2L2le8vWFXmRW1Y3YOBQJnYcNDAAoJEGFXmRW1Y3YOlJQA
 njc49daxP00wTmAArJ3loYUKh8o0AJ9536jLdrJe6uY4RHciEYcHkilv3M7DTQRIz7gSEBAA
 v+jT1uhH0PdWTVO3v6ClivdZDqGBhU433Tmrad0SgDYnR1DEk1HDeydpscMPNAEByo692Lti
 J18FV0qLTDEeFK5EF+46mm6l1eRvvPG49C5K94IuqplZFD4JzZCAXtIGqDOdt7o2Ci63mpdj
 kNxqCT0uoU0aElDNQYcCwiyFqnV/QHU+hTJQ14QidX3wPxd3950zeaE72dGlRdEr0G+3iIRl
 Rca5W1ktPnacrpa/YRnVOJM6KpmV/U/6/FgsHH14qZps92bfKNqWFjzKvVLW8vSBID8LpbWj
 9OjB2J4XWtY38xgeWSnKP1xGlzbzWAA7QA/dXUbTRjMER1jKLSBolsIRCerxXPW8NcXEfPKG
 AbPu6YGxUqZjBmADwOusHQyho/fnC4ZHdElxobfQCcmkQOQFgfOcjZqnF1y5M84dnISKUhGs
 EbMPAa0CGV3OUGgHATdncxjfVM6kAK7Vmk04zKxnrGITfmlaTBzQpibiEkDkYV+ZZI3oOeKK
 ZbemZ0MiLDgh9zHxveYWtE4FsMhbXcTnWP1GNs7+cBor2d1nktE7UH/wXBq3tsvOawKIRc4l
 js02kgSmSg2gRR8JxnCYutT545M/NoXp2vDprJ7ASLnLM+DdMBPoVXegGw2DfGXBTSA8re/q
 Bg9fnD36i89nX+qo186tuwQVG6JJWxlDmzcAAwUP/1eOWedUOH0Zf+v/qGOavhT20Swz5VBd
 pVepm4cppKaiM4tQI/9hVCjsiJho2ywJLgUI97jKsvgUkl8kCxt7IPKQw3vACcFw6Rtn0E8k
 80JupTp2jAs6LLwC5NhDjya8jJDgiOdvoZOu3EhQNB44E25AL+DLLHedsv+VWUdvGvi1vpiS
 GQ7qyGNeFCHudBvfcWMY7g9ZTXU2v2L+qhXxAKjXYxASjbjhFEDpUy53TrL8Tjj2tZkVJPAa
 pvQVLSx5Nxg2/G3w8HaLNf4dkDxIvniPjv25vGF+6hO7mdd20VgWPkuPnHfgso/HsymACaPQ
 ftIOGkVYXYXNwLVuOJb2aNYdoppfbcDC33sCpBld6Bt+QnBfZjne5+rw2nd7XnjaWHf+amIZ
 KKUKxpNqEQascr6Ui6yXqbMmiKX67eTTWh+8kwrRl3MZRn9o8xnXouh+MUD4w3FatkWuRiaI
 Z2/4sbjnNKVnIi/NKIbaUrKS5VqD4iKMIiibvw/2NG0HWrVDmXBmnZMsAmXP3YOYXAGDWHIX
 PAMAONnaesPEpSLJtciBmn1pTZ376m0QYJUk58RbiqlYIIs9s5PtcGv6D/gfepZuzeP9wMOr
 su5Vgh77ByHL+JcQlpBV5MLLlqsxCiupMVaUQ6BEDw4/jsv2SeX2LjG5HR65XoMKEOuC66nZ
 olVTwmAEGBECACACGwwWIQT+T6FvZSYdi9pXvL1hV5kVtWN2DgUCZ2HDiQAKCRBhV5kVtWN2
 DgrkAJ98QULsgU3kLLkYJZqcTKvwae2c5wCg0j7IN/S1pRioN0kme8oawROu72c=
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 05:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

