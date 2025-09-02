Return-Path: <stable+bounces-177547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D298B40EDB
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 22:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AD856200A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA752DFA2F;
	Tue,  2 Sep 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmpMlspF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63A2E7659;
	Tue,  2 Sep 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846236; cv=none; b=LmX4szOgiilZUEAFthG2+t7qP5ag+mCXuYa6JcjdiEsKbDrRXRSPhoqKwbDexnYklpm7U0iS4wRsy1TC0apUmr0dPlKVNHrjrh30BODHMpDhU3X5FoSBeElm5KvONFSg+NRGF6K5Z1kgBQG8Pn90yUzsqilLLuHjeCYwmCaA/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846236; c=relaxed/simple;
	bh=dCRlS3pv+NPs3wOV3tVEzSnNjvt9IFtaC1tNIwQyWJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a57MOPEmO0dha83B7rvkXS/+FWh+iLAUpmUPBTVTcYo9xGQ+nYMvJGf15BS49Q+ODhknhaWn5fGWobXLjjaDBJXgf2V9+BTLTE6DOSS2wvFtKBgZy8O1ws8BJ5nKss3QtVWApzOoVtZ474Y/O6YEOQJYKKfCr6Y/O7ABkSOx8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmpMlspF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8704e9687so543795385a.1;
        Tue, 02 Sep 2025 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756846234; x=1757451034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LWQ/OAw6scTxHWYZBRrURzjaLxJ33N1756x/XY//jVI=;
        b=SmpMlspFOGwp6s5CWLjHTkl4Mi8C6MWMHSGl4LXLV0hfDtK7PWhX0cqroaSHi6OgTj
         FaIWUW6iWnpQaKsKJIqZAWI19BaClLumAMBmCWAYitUBYIK3tIZC0CzNAlto+XTGP0xs
         hW4aIuUWysdl0JrFWcjkLYlxVcv7vGkGv8SKr/ll13+1UxRX066DS7RBIgulMykq2qiJ
         nsfGzQGb0aptZejEExqPsMETkShOjyhxTYNkhNR+Esgmgsh00Rs3/ORs7yhIm1RBUzmw
         KiSo481mHTNx95CbansWoo7vKax4ulwfbsjsokoWcAy8+lNcRvA5NvqEP4xEk3EdaUpR
         hTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756846234; x=1757451034;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWQ/OAw6scTxHWYZBRrURzjaLxJ33N1756x/XY//jVI=;
        b=MejAFVh4UUYhZaqc8U65gipC1czTuSMQfsceSvfY7cRG5IBO2p2IXmkTyk3JewUtt2
         m8ko+pVHMoFjB2nvD9L1/qdo8tqRJv9ftXmwtmfH0hSliiUXb1D8T0qLAHTa7/F4b9Js
         z3nKxplSOjlWICz6qxZrQnDyZ+9eUJgAM7Hr+/Xt8A0jdCb0qU+D/s+m1uI9a0Y2HY5m
         73bkXB+3cxLFWf4O+dgSDSzaxE/I5IWBAnIO+iDlT0ld//dT7pHqlBKpwE6HljxieFvE
         A66uID4iGLuRoRG9MOCHP0OBln1icJ0mPPSrEzahv3/CwbCdnpWhxoLoEq1DC9yMzBY+
         n+mw==
X-Forwarded-Encrypted: i=1; AJvYcCUe8uYAq+qQERQtolleOO6zPDfWMU/PUWjdkfQca1RNx9/CwA9DVrgu+oE3NOit+N2ysiLeLxYqUhhTgoE=@vger.kernel.org, AJvYcCWvp3iVpGygRS4s8BZ7A1AL/hrWNzT/4xmkxDGL2GSEc6e7EjO7NBjpK1PCPYIIPw4BK8mJjXYS@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMrnGDpVApIJsGpqm7NEVFnAcBy6WGso6ctgghXKngOT783iQ
	hwKm2e1JviI3C57UHD1WrePPqjZZJLaKb4wn5ny1FPc51KqMpGse7VdC
X-Gm-Gg: ASbGncuEGI6VZGRRoh8QZfYHcLKColRJKkOgrqu3XkX50IKpwPhZS2thyJ+sE6UTTaV
	nTX5h4lAa76svWKs5dGo/JmqjmDMLDO70tKANPLvIuiJyEbCgDpIfeo81fgR+S9+Ks0knSb5w1E
	H/CAofKPsPirF29Tpnlwb4sCYmbIer6STimqmOQ9MVodQBL8ZVNUsPZ5is6ZIxXw5qDslSQqxnM
	kWUko6QwHjUmFX7TPmB3rS8YnbrKvT7nQjyy/2szoK4KemBkhB+MtxvzvWDLJsPqtF5QQrSYzjh
	M6uX3j1TK1zxaVzPzc/dffAXjGRL6RIdC6RjInZetaPNsXSUoBGiV6gxewDC8ZE/I29NJB0+orY
	aA4G85PpLcknRYLk4aMB7+KzMZbzsqpDV6goFND0mz2Yvx8LPPQ==
X-Google-Smtp-Source: AGHT+IEJPs/9LF36yuHEJI1/SJS2ioDiYjYtNpp8P4U84BCKShYwigccpWSSZRMQ8mpzH5US7zKocQ==
X-Received: by 2002:a05:620a:1921:b0:801:1c9e:7aaa with SMTP id af79cd13be357-8011c9e7c3bmr1183460285a.67.1756846233877;
        Tue, 02 Sep 2025 13:50:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac262a5asm18064466d6.2.2025.09.02.13.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 13:50:33 -0700 (PDT)
Message-ID: <3b4cbd98-234d-435c-bd6e-0e1acb756d33@gmail.com>
Date: Tue, 2 Sep 2025 13:50:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250902131948.154194162@linuxfoundation.org>
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
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 06:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

