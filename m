Return-Path: <stable+bounces-105058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A639F5745
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C08188B93F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C61F940A;
	Tue, 17 Dec 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVwGLnx8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063121F8F19;
	Tue, 17 Dec 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465359; cv=none; b=HntItJeCBPmAY9/6jJsccsWKvwqQZ70HxpGE2KU8rVCE8aZePncnCMBD8F6VttSKmtpTEjpELdr51Sna+yds42Gtxgv4zyz2hxHTy3UsGPaSRrXjQ24mGteQRU2hkDsprQsrhsVcDmMSZ/bRnqjrs8hZlPDY9UI5rNG7cnBSdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465359; c=relaxed/simple;
	bh=mfgN5rjkEwiGMviwubi6WbdbTkxBvoPUIoTPAPveYMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyMjkmrY7KHsCKh+mAujJmS4SNFGyzgY3JijjZ55hpOo4FBw++JtF4UO8pl0+wmiXNQYeqn2bx3cX/eh5hZ7WrZ+fm7LYq8GW5sSO0RwJyrTrf0tfrF8xZysh+59T+kDODd59N9mwE+KqaibqkFiAxBKk/7YxSQzlteFq6PQ8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVwGLnx8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2162c0f6a39so563385ad.0;
        Tue, 17 Dec 2024 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734465357; x=1735070157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kmfulnuDhPuLBz/whD5WGXWGKZ/jiZ6fTFdiIMT6aqc=;
        b=gVwGLnx8VjL6r7CMQABlpCKC5NnykBFLVt2A1prvceww4nxocM6nGa8wM+/AF39Rbi
         eIpvixFVEqu8tWn5gbBBYnrMoN/QjOMDDiVM053V4jky9SEw+cLPOpm6sfun0B4dWjMH
         wUxcU0gOY/rMtZ8OHMmEG+9Sj682MPi3gePynfA95ZiZKbi36fxrtS+ZcEYoEVi5iTsK
         tUCzmbPC2sTvT3pqEMmGo2ZbNBQpsfCypxlLmZ53x3bB17Ck7qR/0KfzF4LohWecRNYx
         cGeSCOvwBQFgrpxeuLaJaPPA+nu763Ktdg3dtBTggq0nN9nhI+WIzzcmjA5dE4OauWV8
         +VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734465357; x=1735070157;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmfulnuDhPuLBz/whD5WGXWGKZ/jiZ6fTFdiIMT6aqc=;
        b=IxVwT4OpYKdiePqXARgByHpuAFGC7amVfBmX0DOi2hd9C8xj77BYWLQ3UvrJXVg0ws
         qcZx9tIxwhSkChmgIcArLcJe1PCpD+T5dbQ/iCEb1fHmqRBDvtvoPbHnmspdGnL27bNt
         e1SLJWo79k2X/DLJBaoKSgmK5sfwGGn2oXiP4cgVne91ZnyUNnpEY//2T7D7vbLyn1Ix
         6lNJQL5Jgbu7Ap3GQNpMeVsg1lHHhbd7ah9tevFkjiKP3ID3juj8vEKfiE4ZjSmfCnEJ
         GMbGvC//nvOWai/HDLY7uErDNfxnDFoSAOXjvq9vRRz487WvGRJ+v+TPe0PsP4LICJRY
         AlVw==
X-Forwarded-Encrypted: i=1; AJvYcCU8EmnsJegeoMsbz3D1WqpW+oAzd0nnEEXDec0CbUncEhZRT/2mLbEOvJDOcvO9ZTFOzIPQhZuU@vger.kernel.org, AJvYcCXV+hp0OE1WCQC98vmGEHbQgcrmv98Gq7H24mgSoTopmVLjiT1FbOkFs5l3NMW8DnCKutBgE07rAa2vkhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAotVpm6kNwqFk1dzV1BQcNSK+zRlEKkPjv2ELuiGOJWf8WMc
	xiEsTRx3rTWKEGra5B/38nhIREsDwyfWP5EDK/mLjpQmoP6wsaz1
X-Gm-Gg: ASbGncu86a+pU+6om/LaQQ/NQPb1Gkp4Q2BRQA1zw/bX2XmeuCYXFbftHYgUMLJ6LPR
	VQ0A2u67Kaywwm/1uAqxSgTNABHkPDYE/7WR407wP8LSqG6knyAPS0eHKPvkEtlJ1WeDjKwW2/v
	Y35WYlbYiNo0Dt6cEReH3tGfdiYXK0Zy1fLdk0w2S8ybtZVwbTZNnHc/taNMaiQu6J9Lx0Sa/bl
	mYYaNji3x52u8pxfMdCvpo/6YbgiM9jjxiTUdpnUVvZ4SiYy/C6Uo22mPqHRyN5lYxRKZ1IhOxY
	gRqnsES4
X-Google-Smtp-Source: AGHT+IGk2eT3JyTGSDidhaoWFAeKar8/3y96ZDyfBdDl+Xl0CF7LVIjcri4vxxwBl6yNWDe6vJXvuA==
X-Received: by 2002:a17:902:c944:b0:216:3e87:ca00 with SMTP id d9443c01a7336-218c9370ffbmr72104605ad.28.1734465357332;
        Tue, 17 Dec 2024 11:55:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcaefesm63547845ad.58.2024.12.17.11.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:55:56 -0800 (PST)
Message-ID: <9368fb0c-61c4-42cb-b0ce-3d5d48356a27@gmail.com>
Date: Tue, 17 Dec 2024 11:55:49 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/76] 6.1.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170526.232803729@linuxfoundation.org>
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
In-Reply-To: <20241217170526.232803729@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 09:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.121 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.121-rc1.gz
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

