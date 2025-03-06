Return-Path: <stable+bounces-121290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B73A55424
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55AC3B90DA
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074325D53F;
	Thu,  6 Mar 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyiIQfpa"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355025D534;
	Thu,  6 Mar 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284271; cv=none; b=F1NZqIBbPqcsgJNScQRcI2LjcsMqmUROtXywWuBW3KFhTWniooIuxTn4FFiXcozo/U1O9p5IbO53rjUwiz6kJu7ajf0+uyjGIYrk5VNyf55zCGbmqg+p7tlfdq5FzJFlrNXkPa7eRMhP0lvcscPxrlpuQLRLJ2cisUk335t49HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284271; c=relaxed/simple;
	bh=4YSM/EJdFgswIm6yxDCr+/iyOSjb1lnmdeFlJsPCDmY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZmnwpRbS+4XoOWZD3Mkr18rmY//Te69ZGxIME1FwG5YaOte31kEhZaA0IcZqJ85E+UGvL4iVHhMGZvEU68Ea8n7AdPUyB0hdGKmPUy0hVYXw+HtZjD1842onQDPmi7HGbpqyNJG7XxZ2Vjjw4kG6HJ8XRp3eXRhq+XQe/d1CR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyiIQfpa; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c1be520943so424174fac.0;
        Thu, 06 Mar 2025 10:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741284269; x=1741889069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z2u4ZrmShZSJJKEHUFNA9BhL2Usd8rm+GOTZPlUQHBs=;
        b=XyiIQfpaYipxuBRh9s9+K52+nR9wGrL96Ps2bDqNaFhvPIf8tMCha2VidSWupos4gD
         jIpUlla+ZHoLSP1ybgyVRltIFtOMN5M+iQhFEABo0dxg2BEivhTY1N24F5YR8iyIV/5Z
         5u/6eFWW/qA0bYrTfbjNzOST09lN4UyHli1tbWZcZdFC4OvfFXnzT7hjuzQ1ju5X6P7a
         ARbTYaQM19RSgWIV2kafbCoKicK/IpFBcDQCzzt4G2hdETCbUtZ1+l4Dczs572mWUhrB
         eMXvdXwOwBfwVNCH143KUZrEpWR7uMHv6NTAMVI3uLYWe+qp+zQ/2drN/Fh5clRNuSQF
         VmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284269; x=1741889069;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2u4ZrmShZSJJKEHUFNA9BhL2Usd8rm+GOTZPlUQHBs=;
        b=WiaXqJ95cRhQX9IR8a6ng7XceIHU6LVyIHlz0bprYO/Au2Qyj4QGLRKtd+8WmD/du7
         eIXHlTfWVLJLMGk+69unP82V/K0anNHNWjuXqe62D4IdVzq6m2ZsFdycxxkOu4+FSxe1
         Ql+DL7kiZAn9/ZaAYnkkrs/rVKqLbhoMaRpazfL7wmFbh1c+hz5HY5GX3coe/wmvHmw8
         vAnLTrzNNYSMIuMJp+wbj2HJrTEEFV6R9GjGgNCV8bCbQzC5CiHdLgf4mwPi+VAi1B98
         2h0DEfZA2NzY/sNnKFo4X5fXI7h9OnUZQdLCHdPwq5vKAUNeFKhTb7lo85u84NfswzLO
         tGMw==
X-Forwarded-Encrypted: i=1; AJvYcCV6lElHrzwBaH9cIsB+JepbjepmvjE9VsWjZpzSv2yakOfbr130i6XQw7lslY8Dt5hoLTF6Jip+@vger.kernel.org, AJvYcCVXY+VlvBUnvrxp2VWNugDTf6/ZBUvjCYGvlkIuX/EA2eizBoiquzZl+U5ra/Ya1ydlHa/xPrap+C8M0Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzoKDSf4Zq5nvq28h4SW7xbOaEphMDmXf31pa6GkLY6g8DhUDw
	Um7BpM0HZrmX/NNpZp8x5tl5bEPNIZ1ly2DnhY3x/t6xElrLoO5I
X-Gm-Gg: ASbGnctjNusxBvMayS0beWebMv0u5SFGwENKsUuyr5yxnHhK9Y2rLt9X9EhmL/8jeV3
	bLKUv5QXvzjhi+5Kw/cxvgqJ4AWrPGL7pPdXB9UrtR/T0FWXLaQR3Dt3e0neIF8AvWPCDnmy1/h
	zozGq/HoJswtgWSA35iRAjk/ldF47vaguAeFAkX9NVE5pWDPvNedRB7ucxENQMI4rjnzs9OG8yC
	NPuMS1HoGGDkdKTa9TrcFnPE8rR+eN78KVqkM1VKiG0NXEaQaGDn0mM0Q/7y26RBXVGkFA83bNo
	Pqps3A1GGrBhPxmFwkusDpJVbeoqrN03DJ1gRTJ7nTksCS656eOG509Y3U9/RGHRGoGW+FGV
X-Google-Smtp-Source: AGHT+IG2UfKn9ZmqXgVtJDba3qPnm26iC89ikqVa+58/kExfueQz/E47yQKnZht2YekA823NpG6jGA==
X-Received: by 2002:a05:6871:8005:b0:29e:3921:b1ea with SMTP id 586e51a60fabf-2c26142a194mr115079fac.30.1741284269317;
        Thu, 06 Mar 2025 10:04:29 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dbc3457sm337298a34.60.2025.03.06.10.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 10:04:28 -0800 (PST)
Message-ID: <7d3401cf-403f-4e9c-b30c-6da462ed8b6f@gmail.com>
Date: Thu, 6 Mar 2025 10:04:22 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/161] 6.1.130-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250306151414.484343862@linuxfoundation.org>
Content-Language: en-US
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
In-Reply-To: <20250306151414.484343862@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/2025 7:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.130-rc2.gz
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



