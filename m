Return-Path: <stable+bounces-124076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417DA5CDFD
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AEB17788A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E6156F3C;
	Tue, 11 Mar 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlcAXZ0t"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624225FA2D;
	Tue, 11 Mar 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718314; cv=none; b=CiRFyJ5yBm6QSnzA04hyserK6jP1zBBFS7o6nuMhImfC6B/2r9f8F3242l6CrAuRDMVFdJjv/ida+9/rKuPKNRHtYcFdyi3bRdexwmVUPFDKFKg49OkoSz2Az4Hs51MCTihTQtNKq5SNgNTZ52BqVM2EHtpovLLWjM1lzaYsLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718314; c=relaxed/simple;
	bh=JQMvBmSUnEOfFCl7wk0Kzpgglw2xDSk+h9+CJN6vN24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7VMGrvTwSuJsOzKY7cQxdanI7VaLVXolmKkm0oc55DIf3MpHMJrdeqStUmyY1e3euHbbtr0K6slXC49QCzY+OATKIztSXr+IylX45GdeGB2VgZKY59jbzAui+vmJO06f1RSutvbxKLlynDnamxid9Ed0xknQecxPHUjnsbedeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlcAXZ0t; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bcca6aae0bso3920561fac.1;
        Tue, 11 Mar 2025 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741718312; x=1742323112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uhVgBBWNaSmDcrv+hoLH9xcvrHQeKIG9+v/Scb+fpyA=;
        b=dlcAXZ0tAEIzvroqKoo9L55gOWosagFLmhJb2Qc3zkdGU0FKKFbF4NyEWKeFa2TMFg
         SKw+XPTNgVtQt+Xt3iqg5QpSBXRe6G1BBe+u779K5I3HAuRh7OTyBb5k4Wqsfaar07Bk
         2pTWcs0yTira457KC8wD7z7k7M87N10r/KcAaBTLtnLJ8zkvy+dJmr+ydCXe3VDAEku6
         yQHCn4rKjtd3EOgem9lEuhPyrDNNH1yOTbF/JFdaatMmiasPIGqM4l0KFvmg/8RJCCux
         /6BhkUDnZ4G4240gB+UOWz654SlHFI6p0F4uqdiMwnn1Nkq6/TEdKehzmPO2iKtt3X0I
         1ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741718312; x=1742323112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhVgBBWNaSmDcrv+hoLH9xcvrHQeKIG9+v/Scb+fpyA=;
        b=mSyQ0nxbXPb4cst8qvAPeYfB/i0YXNkFn1leWo/YUCBUrDFPAf9VBeZLoSuY/mGkcG
         TqdoFP300vSO8gzuuqcK9GD8oPB9KjETfIQAl4lN4I06f/60GM10/tQvHQy/ZsUze3fU
         df1XJTl0pEpYWxpBDhVWQqSYMZDM8ou8GmgLBAVvZ1uMtnQgifpuIseHDuJQSQbLY8tr
         CSwmoXaTesPMrZ/EsM2r2+YSE5d+MSsWtVasFHjjsY4tNjuhLeuIMM0OoU7uGDG19azK
         2JBKA0VfmqUqV7b/0kk5dma/xXB1dsJNhTrH0qGmAsoDwHdVLf6S4NLLpDBZ0DQwlHFO
         X6gw==
X-Forwarded-Encrypted: i=1; AJvYcCUAHwrtbnDhnDxQ2UKSdxbuWpFsODiWvZMDEskI0VMWIPdbNhlKZcrFGBkNEhFfSiTFFjQHnfv0@vger.kernel.org, AJvYcCXTnkorJ0+J3F+cU34N58aEIdf7+xyl4EAzO9GAxHagZRihH0Wx8eSTDcqVU6NPl7eo+IzTqi+2kVotnSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2pShKbE5kpH1ym1uRp7QdQjy2QeezXIJdDv7rKFxsBI/05HJ
	RFm59VBWZxRXcTugEth1djLOhCTGFlPmfnTgsAn4jAdM6f0+7WaB
X-Gm-Gg: ASbGncsRGxE+twXoQFU0Z25Icml0lgHXh6XPG0jOhc7xtCSJIMI/1cGUmc4iIczPaAP
	IoUtQFsqH65tPb+/1V2ipGukU6P+yng1qytjZ/ZcvQpcUpESDlgZDlZ8E2IShgt3hny5aq1v5e2
	6VLf24cuvrI9nDaIPBdBDcwrkau24rAdIlY6f6m3zDcQfrD9KndUkd6AhjZlpa2bTyRxOEYW8wH
	/DQV3pB1M53qitH1to2WDs0TX+WY0KZmp1VdiSEmGvQqkvNTSPzh+ZjFpwfuz6upLQl38EH+JI3
	wWv9AyaQNqpLqEP09eMOUWBrDkXiH0LwECkzHGoDE0Nfxwdz5djbfMfz9fOMIVLIOG25QHqz
X-Google-Smtp-Source: AGHT+IEeO1Su5duSEokcrJQRq0t4evD/7K9UjO7IEFqR7+Am5Ke5eujTvXj8OYiD37lEFUudO5mfyw==
X-Received: by 2002:a05:6871:7502:b0:2a7:d856:94a with SMTP id 586e51a60fabf-2c26111fda8mr9685421fac.22.1741718312232;
        Tue, 11 Mar 2025 11:38:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248dd621fsm2692945fac.42.2025.03.11.11.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:38:31 -0700 (PDT)
Message-ID: <0f5c904f-e9e3-405f-a54d-d81d56dc797e@gmail.com>
Date: Tue, 11 Mar 2025 11:38:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/328] 5.4.291-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250311145714.865727435@linuxfoundation.org>
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
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 07:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.291 release.
> There are 328 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Mar 2025 14:56:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.291-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Please note that "udp: gso: do not drop small packets when PMTU reduces" 
does cause the following build warning:

In file included from ./include/linux/uio.h:8,
                  from ./include/linux/socket.h:8,
                  from net/ipv6/udp.c:22:
net/ipv6/udp.c: In function 'udp_v6_send_skb':
./include/linux/kernel.h:843:43: warning: comparison of distinct pointer 
types lacks a cast
   843 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
       |                                           ^~
./include/linux/kernel.h:857:18: note: in expansion of macro '__typecheck'
   857 |                 (__typecheck(x, y) && __no_side_effects(x, y))
       |                  ^~~~~~~~~~~
./include/linux/kernel.h:867:31: note: in expansion of macro '__safe_cmp'
   867 |         __builtin_choose_expr(__safe_cmp(x, y), \
       |                               ^~~~~~~~~~
./include/linux/kernel.h:876:25: note: in expansion of macro '__careful_cmp'
   876 | #define min(x, y)       __careful_cmp(x, y, <)
       |                         ^~~~~~~~~~~~~
net/ipv6/udp.c:1144:28: note: in expansion of macro 'min'
  1144 |                 if (hlen + min(datalen, cork->gso_size) > 
cork->fragsize) {
       |

we need a more targeting fix for 5.4 which replaces the use of min, with 
min_t:

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 58793dd7ac2c..db948e3a9bdc 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1141,7 +1141,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, 
struct flowi6 *fl6,
                 const int hlen = skb_network_header_len(skb) +
                                  sizeof(struct udphdr);

-               if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
+               if (hlen + min_t(int, datalen, cork->gso_size) > 
cork->fragsize) {
                         kfree_skb(skb);
                         return -EMSGSIZE;
                 }

Thanks!
-- 
Florian

