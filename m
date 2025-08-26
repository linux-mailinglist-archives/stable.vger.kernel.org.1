Return-Path: <stable+bounces-176427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87924B372AC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 20:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DA71B2043E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0286531A54F;
	Tue, 26 Aug 2025 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtNNx9S8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96D17D346;
	Tue, 26 Aug 2025 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234561; cv=none; b=B+JF5cvbGg7Qg0awds3XzJtiPnAugYY/MOEkbc92pMQS0NDCKHr/R0vjnOqxtOHPwvrMtUVQSlnwQeK6FMe2KXhPxicYg/6nJz/CFRX4fq3kzjHT9BJ+86+Tn5h1WfgfP0Z8x6ipUSzRp28QQvLgmR8FDlE5GthPGpg7Z9zbATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234561; c=relaxed/simple;
	bh=EZAnQ9ZfiyvsU0/rq7y+a5XNe5p24HqLN1Mx6cV98qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LddGv4TUGfVZGUo4m/3MP9sWW0CKR30wesFhmn5GcPK+mnsF08Ay1rXhtFfKTm91xgirbJa2i7mpIYT9CQLs3LeXn4TaPEtM4NIIMyPJpMKPPqXzORnC5QGEyR4NsR7qUa4ePKPt539GD2lAx8lG4398ojAcNyAc/lTI1i7z5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtNNx9S8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70dd5de762cso7300546d6.1;
        Tue, 26 Aug 2025 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756234559; x=1756839359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bXkU4l4gOfHlfRACubLRP1wlKNvjSzxXqDvlqU3MAlA=;
        b=KtNNx9S870B0KDJ2v5bgKUVUygp1PBIKQoITrG2/TbduozV0Ntldmt3HXIC3ymS3bx
         LWFFqVPN3qHM422UP3IKHQGqlJ6GNFo9eNiuDYQb92a1/AFtbzJOVMj3nig8NmsIydrW
         nEvUqdtC8V5Nhc/MwUY1JexKEop9Nd2hXL/e4+RT/bHezLI7rRgI/5BeX9Ykl0D0itUh
         FX/0Cx/WCfMZBaoIsvNVXYOgTmoy4CUD1b6uM/qxqomW3l0qL2VHtwRF/ExBeBNVb6Xw
         80fEKg4Qq4yJYYdve1A+twzBZZwfeaaqsmfSNh3ETzDHkVlnSIZZrYlw8kecGyoHkxR+
         tcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234559; x=1756839359;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXkU4l4gOfHlfRACubLRP1wlKNvjSzxXqDvlqU3MAlA=;
        b=Vej5A6NnBYXUENePRhfGX3qLsjRIF/1JZwP9zx1rJoBaCoi+YjQaEw/1trxgHfupGx
         4jsdLRU6lx8upBHxffhiorAne3+MfgkDu+PUhoTNoRaDOdnhHbxZFFul/bqVp+cQ/x7g
         mFtlpI/tqQs8/284Zq6sFXOgBzXsiyon6cnM5NGkUaymg6gPc+IsXSHcr7OGlykeJIUV
         YfC4gaZCFFslK6xAUKOAdQqhN7Sfx9Jx6p/faOSn9lYT98kQ/y+kvE0KaYcOh+yhT+i8
         A35gvm8dJZzvIZPt+h4KXpK5x1G8sYLeq9Zf5q4cJKcJZYGgF9l5sCLRDmoX1xV+tRks
         DibQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwCx0s5iPmkTu5UhSGYx405+RxDdZ8dRjWRQmShsf47vZF4Z88ZbbTMHGuRBJ2U/OdtH0LZ6nPsWXfD0k=@vger.kernel.org, AJvYcCXo9PIyJT8gjQHnEGsPynzzyHhWY7fXfcAY/htve1/K9EDJH0Y041Q+73S8K+H3Hh909OGiq8pL@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6+XyZsBaNugxa7gk8xT1pJDUgmVFidrPRg2A3qpo2O3612Vp
	odOowX9+8CKHZ6fMMlz0Fidw+++tDkBo1Kya0cVPgkIloNTT51JfhVlU
X-Gm-Gg: ASbGncvq6Tbnq6hLzukRTcWpsSIMKDn/5UsfhysqzMYdmjzkt94ZTRwnUydaRd7TjIg
	L+98/aZcO3jVGo9+NPUy0Ro83/hUuyfcegZT566iNzXV7gBl2GbyvWQJ0AM3UTL1zaceI7h7rII
	ncjJrsBjrRjvsEdNxfO9DEano6e2pti9rVSEvnZ42Nq6bVRuPL9e3LEDdoE/svbFA010ju97Pp1
	cyejAVvZlQvLe6pot7Vg9BQ2uy+U79BpBDPql9yOYIjkbkYECKNLMEnh4BLnbb6CzcDhQ0b9gnO
	IchJ8u569/Voq1bpJx/m1OOO4LA5uUZ7MNO3uZ48+WvWWsGb/ZcwMCoC0YIIVzmD6qvNDNxrYtf
	tDlOZAGOUTdhTNDwYAlMljnwX/AUwx12SnRPTBNIxXqGo+3zmrUU4u/WY+fIM
X-Google-Smtp-Source: AGHT+IEIkZaP2r1eklkwQiwwqSbBEuAc/jmBPwft/PH7LD4MKnBe9eqm55gzYoxd423BJGgC/GWuvg==
X-Received: by 2002:ad4:5cc9:0:b0:709:b6a7:5f16 with SMTP id 6a1803df08f44-70d97125da7mr214476666d6.28.1756234558794;
        Tue, 26 Aug 2025 11:55:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dc949bcc6sm27661876d6.8.2025.08.26.11.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 11:55:58 -0700 (PDT)
Message-ID: <b50ba970-c39a-46f4-9bcf-abdcad1f7e54@gmail.com>
Date: Tue, 26 Aug 2025 11:55:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/587] 6.6.103-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250826110952.942403671@linuxfoundation.org>
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
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCZ7gLLgUJMbXO7gAKCRBhV5kVtWN2DlsbAJ9zUK0VNvlLPOclJV3YM5HQ
 LkaemACgkF/tnkq2cL6CVpOk3NexhMLw2xzOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJn
 uAtCBQkxtc7uAAoJEGFXmRW1Y3YOJHUAoLuIJDcJtl7ZksBQa+n2T7T5zXoZAJ9EnFa2JZh7
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 04:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.103 release.
> There are 587 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.103-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

