Return-Path: <stable+bounces-2547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD05F7F8548
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 21:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD01B296A9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E1381CE;
	Fri, 24 Nov 2023 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/UG+KXH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD535DD
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:52:02 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58cdc801f69so1328208eaf.3
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700859122; x=1701463922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4ZyDfd3honPM2/fA7tF19iIjRCm2MXFd8wkmMXPhO4=;
        b=B/UG+KXHEQM36eF/q4tCkI/NqZJNrfD/p5YzELjzmaqjc5Hi/NOymdKGZrqWxXI/E/
         PNyxRZhnXUinLYmM0k3B0X9RaiiyG9+jLAPVz99zpWDY1VJab1SrILvAD0ctlKwYxwgT
         IjEmmW3v891PwRgShUrk9cCmPoTYKLJ0LhVUqNafq4tGiHHVoAguNCC+sCQwAAgES2j9
         /yykuG+DuEIPWBTKHxJ+EUeZGP3RIOkbjA6MJuHrIdO6dn46WA4yNVPPnMBgqOgA30vM
         Mway4v84QYV84jOAxUd9ELvRlJcwi390RQJjnpdWQjP9XkgCyl2sVqBTMBdjnm91YaM+
         dFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700859122; x=1701463922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4ZyDfd3honPM2/fA7tF19iIjRCm2MXFd8wkmMXPhO4=;
        b=CdWN84yeaK4765IOBfBMEtahU18u2wVsKXWFANLt7bHZbdnIpv1dsHXz9Ui1CtC+C1
         KD5Ec1LkiwbhrSEhz1S6hMQdHbT3wnFYai3tGMW92zipY5zZfbKx1byTZEpbDAEOA8ZH
         UIM62jwcZeEOhOPSk+H+0zw/jOtWFPcl5cH7yRvBpVO8lILjcLGCfaixK/8erlwUfkZT
         ZHcEFfDRhEQ6mzRZvy6Ywz/jScX+lYct/f6rv+QtlbeE7ADjJ2+IRVISvzNdLJOwLiXZ
         Mx+gI+cJqUbOVvs4VZPyBoW6IfYWyodRBmgvXAzpWkCII+N5XHCkQaRMXCfTM0fsrBSk
         y6ag==
X-Gm-Message-State: AOJu0YyAWXWCTV/izUR8e1uWbgrPp4TdXEoMhYmcqzD3QW3EdPIt1rNs
	E5vfHyZlgyODxO3WrfGn6HsglA==
X-Google-Smtp-Source: AGHT+IFnPOoo7uHkuaczD7YVgTMWwAGAx+c+puPLrgID5BSi2hhH8bVTzbml5YEV1Q9nKQg47wIn6A==
X-Received: by 2002:a05:6820:1517:b0:58d:363:e600 with SMTP id ay23-20020a056820151700b0058d0363e600mr5615984oob.9.1700859122092;
        Fri, 24 Nov 2023 12:52:02 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id h6-20020a4aa9c6000000b005840b5783a1sm632335oon.43.2023.11.24.12.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 12:52:01 -0800 (PST)
Message-ID: <8761f367-1928-40f2-a4da-9d57ecb73218@linaro.org>
Date: Fri, 24 Nov 2023 14:51:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/57] 4.14.331-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hca@linux.ibm.com
References: <20231124171930.281665051@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231124171930.281665051@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.331 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.331-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

There are System/390 build failures here:

-----8<-----
   In function 'setup_lowcore_dat_off',
       inlined from 'setup_arch' at /builds/linux/arch/s390/kernel/setup.c:961:2:
   /builds/linux/arch/s390/kernel/setup.c:339:9: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]
     339 |         memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     340 |                sizeof(lc->stfle_fac_list));
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /builds/linux/arch/s390/kernel/setup.c:341:9: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]
     341 |         memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     342 |                sizeof(lc->alt_stfle_fac_list));
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /builds/linux/arch/s390/mm/page-states.c: In function 'mark_kernel_pgd':
   /builds/linux/arch/s390/mm/page-states.c:181:45: error: request for member 'val' in something not a structure or union
     181 |         max_addr = (S390_lowcore.kernel_asce.val & _ASCE_TYPE_MASK) >> 2;
         |                                             ^
   /builds/linux/arch/s390/mm/page-states.c: In function 'cmma_init_nodat':
   /builds/linux/arch/s390/mm/page-states.c:208:14: error: 'i' undeclared (first use in this function); did you mean 'ix'?
     208 |         for (i = 0; i < 4; i++)
         |              ^
         |              ix
   /builds/linux/arch/s390/mm/page-states.c:208:14: note: each undeclared identifier is reported only once for each function it appears in
   In file included from /builds/linux/arch/s390/include/asm/page.h:181,
                    from /builds/linux/arch/s390/include/asm/thread_info.h:24,
                    from /builds/linux/include/linux/thread_info.h:39,
                    from /builds/linux/arch/s390/include/asm/preempt.h:6,
                    from /builds/linux/include/linux/preempt.h:81,
                    from /builds/linux/include/linux/spinlock.h:51,
                    from /builds/linux/include/linux/mmzone.h:8,
                    from /builds/linux/include/linux/gfp.h:6,
                    from /builds/linux/include/linux/mm.h:10,
                    from /builds/linux/arch/s390/mm/page-states.c:13:
   /builds/linux/arch/s390/mm/page-states.c:210:30: error: 'invalid_pg_dir' undeclared (first use in this function)
     210 |         page = virt_to_page(&invalid_pg_dir);
         |                              ^~~~~~~~~~~~~~
   /builds/linux/include/asm-generic/memory_model.h:54:45: note: in definition of macro '__pfn_to_page'
      54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
         |                                             ^~~
   /builds/linux/arch/s390/include/asm/page.h:164:34: note: in expansion of macro '__pa'
     164 | #define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
         |                                  ^~~~
   /builds/linux/arch/s390/include/asm/page.h:167:45: note: in expansion of macro 'virt_to_pfn'
     167 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                             ^~~~~~~~~~~
   /builds/linux/arch/s390/mm/page-states.c:210:16: note: in expansion of macro 'virt_to_page'
     210 |         page = virt_to_page(&invalid_pg_dir);
         |                ^~~~~~~~~~~~
   make[3]: *** [/builds/linux/scripts/Makefile.build:329: arch/s390/mm/page-states.o] Error 1
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [/builds/linux/scripts/Makefile.build:588: arch/s390/mm] Error 2
   In file included from /builds/linux/arch/s390/kernel/lgr.c:12:
   In function 'stfle',
       inlined from 'lgr_info_get' at /builds/linux/arch/s390/kernel/lgr.c:121:2:
   /builds/linux/arch/s390/include/asm/facility.h:88:9: warning: 'memcpy' reading 4 bytes from a region of size 0 [-Wstringop-overread]
      88 |         memcpy(stfle_fac_list, &S390_lowcore.stfl_fac_list, 4);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[2]: Target '__build' not remade because of errors.
----->8-----

This one above is with allnoconfig and GCC 12. Bisection points to:

   commit 76dc317ac655dafe1747dba6ce689ae3c3a35dd6
   Author: Heiko Carstens <hca@linux.ibm.com>
   Date:   Tue Oct 24 10:15:20 2023 +0200

       s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir
       
       commit 84bb41d5df48868055d159d9247b80927f1f70f9 upstream.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


