Return-Path: <stable+bounces-150613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05653ACBA23
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFDF3A8695
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD08219A9B;
	Mon,  2 Jun 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMEGN2pD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F4223DFD;
	Mon,  2 Jun 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748884875; cv=none; b=cDEfW3gNF16+hBjQ95z/csY2+rbFTyL/NUOjupePszlqu3FXRZklGG8JH1AP3hX+Xl5g57MiTUueHp7PnZmWd3slfEkZGY2VBJ6Uoqg2IoFzgAm/MJZBBFviagRQ9utmQ4aVNpTI8lwHDyvwPq35Mvhjd4hH5LcjeTLN6NLvE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748884875; c=relaxed/simple;
	bh=Z3VhZ27OqaJjtGCBxlLuZvoD6F2Sb28KfnMZHtv0rWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE1y88n0jJDQhDg2PDtt95p9WAnUoXdHP7fSAtogWopRbotGTiCSeEgEhKyTYrMTAdoO9881xp22Yyh5s0vQNiQwbaXoPR6AK2QGkAeH6CiWZXt5tZXZypaAaYrE3N1o5+r4FiGV53JhacNNiezktMCmNWCaJ4osYKZZidy0arU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMEGN2pD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c33677183so37146155ad.2;
        Mon, 02 Jun 2025 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748884873; x=1749489673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5QCLGF/jA/pwVPHGbVsva9wa8syvBfceE61cp4Byg/w=;
        b=jMEGN2pDBO6rAnGvsVj47+JY+EzuR8g7IMytVk4zPbboeH8QSivrgy5jh1hauD8Svy
         L0rVE0HED2T0JTpC637/KwTYbmxKEOVeXe8HLQbKylYjufPUDZx5dswNtlqjWI+hMcF/
         0kUVoCp5aZ11dT6hP+KY0PZ/pWTz5jNrww1+PHhkKGVlAGETMQ+TfwyMt/w9MY03k++b
         9OFh0PdWXuwzl/SnZpM6P8ebzrffSRhXvAzOXa6+kJDwkNAb9lDwWR7yI+jFS51lPl0Z
         H8eUJqUDk2QpgAj5qjdgrF8UJe6RFj++VcTsfZ+6GuPVLhak9f9l5fu2y8tYrdhlbpEr
         Vo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748884873; x=1749489673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QCLGF/jA/pwVPHGbVsva9wa8syvBfceE61cp4Byg/w=;
        b=joA0VmRycx1IO3eKO79IW9RQotACdgdKkFSXsB+Nn6EhjXN2cbilfLeNNJ/pu6osp9
         2fdwdNz9/Iu0urHw90sBiIa0R5YeTMwg2hOkOMGkscM4dmdx+q7U68RYllqSrCubh0AT
         MoiLTFEZq6t2uhxU6djdwRjZeE4p+6AOsk+V3HWP9I2kSIkPr5HVjvsh8/cJnIlWS+DA
         Yoy6wbLwlJqKaV5nam5uREyqJDdQ2iKIaumN9vZ2yFDtAcnRNoFVOHf0MJXmxGsCy7na
         wzwqNbXX+cMAjSdIPKcraB/OlBVh3tVydaiozPDqGvd/MQlEZhoogpMTHwR+74A7U5zy
         47+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCUbZSMtPjCUmiuI5ctjit+Yo1rEIJGYbDFuggIdqD+Bw/dOL/oGORXXee+BLAafQlo2nfTFD9u81ZCTQ=@vger.kernel.org, AJvYcCXfXPV0KQQYOaHbvqRXZzd5zZH4jZDXJGe66uKGjRrSwOPB6nahR5oZOOeIs4mjA2YOzCT7KcXf@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZtxXcfqF8M4PAxgvctPnZQnhKU84fdlrCnUXHDe/S+VNB1F7
	FaKYaricIwIjCjH0mQZykotk+UjZUDn9tJBkjTkZZhIvlTggxzSK/e2H
X-Gm-Gg: ASbGnctg05+1Vv0eAqNsBb8i5VZQabVG+tdd7xB7ECSNH+uF0co7jMKHqE19yEhURwO
	OJbjncibFVdtaPf9sCObscPNysOR4otuzlvwcJKaXLjKXB03u5ddNT2GlhXs9ObkI49/aAciFdO
	EBAfZul1UAk9hPwKxjYCCEvhS+b/fmS1WJev8FAkDgug4BbCGYYpxtpn3+uT0+uJrZphYaogQJk
	pJJuuznGN7kWxDgBP7p6j9Aedy6u/yKkNt2vPJDHX4+8gQ+vnHxhSYx6UmaJ2fTd+lP7pnLKzSP
	wrNwR7VQjZ6bi43wXfkh6HNCVLLEDbNUNeaxFQXUyAmhad0shYi1CjZQF42mqfdfXgbR/04ScP+
	LE0Q=
X-Google-Smtp-Source: AGHT+IF3I36rhHGMNDA+m8+mAgHzl2n5mxVie/4llNmTfx/BnKErGiVlwrYIpi0JiGEdVnE1uUJFcQ==
X-Received: by 2002:a17:902:d50c:b0:22c:3294:f038 with SMTP id d9443c01a7336-235393fca54mr156551905ad.18.1748884872839;
        Mon, 02 Jun 2025 10:21:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd38e0sm72913675ad.138.2025.06.02.10.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:21:12 -0700 (PDT)
Message-ID: <85464685-f781-41a0-9e79-f670cfa4b220@gmail.com>
Date: Mon, 2 Jun 2025 10:21:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/325] 6.1.141-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134319.723650984@linuxfoundation.org>
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
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 06:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.141 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.141-rc1.gz
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

