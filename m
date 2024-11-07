Return-Path: <stable+bounces-91853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BB9C0BD7
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06D02850DD
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD75215F6E;
	Thu,  7 Nov 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIJmd3pM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BB8BEC;
	Thu,  7 Nov 2024 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997584; cv=none; b=ekiMXA1ErhCVQSrnlbpUBoPop49faEIETbt0/HFv5ayHS09r29kkGndIbRl+sdkZaXyhsmo+2WKjC6FGT9vfGv0H096NvXnrWbNRDg6ITW6XltT76miTTkb81Nd+XTjLZg52B5pk/0hU2gucqmjs3CaXe2NaPUB+2+6QqVAWYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997584; c=relaxed/simple;
	bh=lJ93r7UQYNp+rlYKZUt1Can6uIRWWwjylI/k8nRrfqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSbvJ/Kyoj6l8a7DzcN1b3AqcH5AHuVIGQcDvRd+IHZ9btbx39b+7++05SxF90soLGGHJsMGH/8xkNpBXlBdtxdUhyDj3BwamCjk9isqvchTWb8Vx4hx6kA3qTn//bEeBTTZN3mbESh7J2cXmUQMkAuC1svY64/mk6SkUKoJZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIJmd3pM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c805a0753so12401305ad.0;
        Thu, 07 Nov 2024 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730997582; x=1731602382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgXJATuyZwVkN70AZDZo/VSscc1RChOphjdktHVIOVk=;
        b=fIJmd3pMNPdPkRSp/LjVPQgLOIR92QBf6HWXmr6X/yPRz+Nc4+H6cqrtpH4HrbJK8Y
         0M3mCGag7NtfpjbhXtQrQPxea64TKDkz/HgeaPOajWm9dPc+q0B/fDyaB18RZTIA+rB0
         0vM/2WUsiBVglMO4rjtrp4eb/1D3PDzryhPuFEyo6dWcjiMkD4Tg0J9x4Zcd1hxI4DJ0
         lMMvbB792TN+TfzdfJ3Bq7HzvYZ9EGgb3BVA090J/lqAWUea9/u4QmCXKvdqbCKvI36k
         kPi3fgxZ5hSilQX1lCQAQKHb4mOgBOAuOrZ63/fy2HnBpUAHdtW6xfnAraqL7gnd4cjQ
         VOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730997582; x=1731602382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgXJATuyZwVkN70AZDZo/VSscc1RChOphjdktHVIOVk=;
        b=mq5MTeXgE7t6zD/8395nQ5a7WKMITJHcbGlMvwvw8ZQud1IJvrvv5p0DmfboRW1MXr
         BQVHivTzdYlzu1uUCc1m3LoEJR1vbZ94pZhL0ewCSciCjfK1+kQbxggxB2K/izvofafd
         8LdvX/SmXPVbCc5q29wfJ/eYtDBBYl1KQn5EvoFas0BRojATpGVn9VpAC0wjIBkN9hoH
         F5UDdYPTOmFX7NL4Uk+vS0TT1b7nXiqKALzEatFJMqHIyMbaiOss2VIl7ZUmynR1iNiN
         qCU23ghvtSB7oJiUYK90bX3nA+NBsL7FkHUe0nQT5Hzwl4GW44Q4vgpYLfilU5tidAdB
         feyA==
X-Forwarded-Encrypted: i=1; AJvYcCVCfLw8afZwwrFFlnrf9aCJrkDNuf4hKfK1sTw0okgx1Itn/EXzr6WM1JbFv2nRLFGrckBN8c49HYf9KNA=@vger.kernel.org, AJvYcCVq5JJ6+nDqFJmjJEi6HwL5MQ3vwyGP2/wgwD7Jf/oMyRfxBNGX1kK0bI7Xp1YK44IVBBPrOhgK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57on5Q5JvFBCu2qXmRT0WEmdbniR5vAH2cBoKyq5baIPz4HA1
	3YtOHPNdsVaX0tWA4fkTHEVay2TdY+oYZtVX7sr0wCxam1otXyVd7MsZ5A==
X-Google-Smtp-Source: AGHT+IFPIGSNoq7pKYDhMfYzlbbJCa5NYMEd+nCZ7spV5q2pirGrNOs8bvGt97VJ9ExX3vwlY/BLrA==
X-Received: by 2002:a17:902:c942:b0:20c:8839:c517 with SMTP id d9443c01a7336-211823b5347mr428465ad.53.1730997582019;
        Thu, 07 Nov 2024 08:39:42 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a471sm14142415ad.233.2024.11.07.08.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 08:39:41 -0800 (PST)
Message-ID: <05671820-dee5-4b31-b585-5e1f034e65f6@gmail.com>
Date: Thu, 7 Nov 2024 08:39:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/461] 5.4.285-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
References: <20241107063341.146657755@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20241107063341.146657755@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/2024 10:47 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.285 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 09 Nov 2024 06:32:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.285-rc2.gz
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

There are however new build warnings, on 32-bit:

In file included from ./include/linux/mm.h:29,
                  from ./include/linux/pagemap.h:8,
                  from ./include/linux/buffer_head.h:14,
                  from fs/udf/udfdecl.h:12,
                  from fs/udf/inode.c:32:
fs/udf/inode.c: In function 'udf_current_aext':
./include/linux/overflow.h:61:22: warning: comparison of distinct 
pointer types lacks a cast
    61 |         (void) (&__a == __d);                   \
       |                      ^~
fs/udf/inode.c:2202:21: note: in expansion of macro 'check_add_overflow'
  2202 |                 if (check_add_overflow(sizeof(struct allocExtDesc),
       |                     ^~~~~~~~~~~~~~~~~~


On 64-bit:

fs/udf/inode.c: In function 'udf_current_aext':
./include/linux/overflow.h:60:15: warning: comparison of distinct 
pointer types lacks a cast
   (void) (&__a == &__b);   \
                ^~
fs/udf/inode.c:2202:7: note: in expansion of macro 'check_add_overflow'
    if (check_add_overflow(sizeof(struct allocExtDesc),
        ^~~~~~~~~~~~~~~~~~
./include/linux/overflow.h:61:15: warning: comparison of distinct 
pointer types lacks a cast
   (void) (&__a == __d);   \
                ^~
fs/udf/inode.c:2202:7: note: in expansion of macro 'check_add_overflow'
    if (check_add_overflow(sizeof(struct allocExtDesc),
        ^~~~~~~~~~~~~~~~~~

In file included from ./include/linux/mm.h:29,
                  from ./include/linux/pagemap.h:8,
                  from ./include/linux/buffer_head.h:14,
                  from fs/udf/udfdecl.h:12,
                  from fs/udf/super.c:41:
fs/udf/super.c: In function 'udf_fill_partdesc_info':
./include/linux/overflow.h:60:15: warning: comparison of distinct 
pointer types lacks a cast
   (void) (&__a == &__b);   \
                ^~
fs/udf/super.c:1162:7: note: in expansion of macro 'check_add_overflow'
    if (check_add_overflow(map->s_partition_len,
        ^~~~~~~~~~~~~~~~~~

-- 
Florian


