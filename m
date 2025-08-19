Return-Path: <stable+bounces-171838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA634B2CDA8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 22:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A55189EDB8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 20:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A7342C86;
	Tue, 19 Aug 2025 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOE/HTA8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16713233707;
	Tue, 19 Aug 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634484; cv=none; b=R5uDLS/csUnZSax+VQjwo7msXca2NqFf9/qa0MuE4pbsR5psOmV+EPknT8wSQVa9KcCQhVzX7Ej3H+d+Gyr9Y+XEEeSPNXI3r3dQxt+p5USa2NpdwXqeLsZf8eShCqwUabLKCUajHAoxDYNTekaUZHeMYj5o8v36C/lseof6EI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634484; c=relaxed/simple;
	bh=OolmA1E6f4UZQDmmRkd6bRhmOlCMy5rIQVXKiXzx1QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+HCw3uh09N+cnhe7HV2xwx2bj5tOeYbsVhRY2+VURs5+mPbc6Az8nWMJsGdna5kQ/2UtJ9+F6FTqkzgcqxHaMrcJ2+pdYyXJjQ5B03stPq4nD2mdALg1Qdq0bW3EVlysZYfIOibtealvZwwyySiJI9z7uY6TGbpp0qil0VENkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOE/HTA8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32372c05c5dso2245452a91.0;
        Tue, 19 Aug 2025 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755634481; x=1756239281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W73sVd+N7uqF/LudfqJGmM3/FeGy4NK1TMhJYYrn5N0=;
        b=AOE/HTA8VVQfWvLqKdGqUZvplKW7XfaT/6zd7UuYlxXO46LMEwU2iOTOO/Wme513vy
         CDI6SHUelIx49JJ1FrdjaW+A9/V2VaPIlfCTHewZgzdXkPcw6Vwy7G6QFtLvnGQLjEkS
         tOlT+vQQbNSkM0vbaaDpQQ6VabYmER0u6zLZKUVsQy3U+YEMBXxzW/zzsKotnI3MjSVD
         4mSbu4LTF3vbsU2mDoVoQz+zCdH2WfIizVQQgYBIsKqhKSFVWOuQjt1REiDYoSNQoBQu
         4Mkdp2D2Ko6YYsutP7fr133Qxp6IYOr378sJnZP61vkwFwm64Y7MyGZk6LqMrkskH4we
         fufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755634481; x=1756239281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W73sVd+N7uqF/LudfqJGmM3/FeGy4NK1TMhJYYrn5N0=;
        b=qYJqg2iM3JCIbP5DghMejDeM1F9xhhPp9a6RKsGEfxFfwKw5/jZvs8p0J20ioPfdJK
         iLHrRBGmMna/b5uJAxWU3QFD+SEtg4ETnnKQDSi3O2w9Cz2nmb9rJPcHihNBSx1roNsd
         s8TjcQzghsS+laVpL6x8e7fDryqVhFrqjqXqCEW48DVxYMiF6YrkvzsKlFCh4IegPUXL
         Q7oWDdbYNwno4anVYJGOspOtftcavr894yJUBYwn1BDwvNowwFH6oMgkMmPIelKT8iZV
         yqEN0p6ExHpVV/5MmVe+Ei2fFnDBB0UAbZz32GoQOQmxMXMwXf8JZmlfAWm3YjkdwLLw
         vPyg==
X-Forwarded-Encrypted: i=1; AJvYcCUHQu3DmDv2TmKpVBDmrEtwS8QvOkREbauoCdHEddwzyP/JNn+ozQYQySn/7Hq2ZNRnGGpIMRMc@vger.kernel.org, AJvYcCUyFUDyLCg5+SZFoUdRYRel1Bvg1i8Xkt1Z+qMgw9P873E/39bqIEqHk9iiBPaoi8qKAy6LGwSCeSQ0OaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iO7P+2Mw8fJrAUaXfntpCmsPMbBFzxDJ53m7yv8/8yfjybi4
	tkQiOY6R/zw7LhCUKJXkGt+AVhK6kgrDPdEGLYNexkHzVJKBr9uk1lrb
X-Gm-Gg: ASbGncumtMopyj84YSiZGrsYymRyr/vk/jGQrx+o2gFBO9g/ODkoDAT90pytoSnOXwj
	H47htZmN0z6rL4Oro50NrXefUVTpKIN811StKBLrQODVszqDaUVboQPvhKTlRQwrBNwHwXbRf6u
	UXdihJppS1S+KvZ1ozSnahnGil6IugHzNSAvzdT8uiy5ly8pEwf5TCa7Yrn8WMLP4UwbpHEAfZ3
	zR/cbltNfC6bGzt/W0BrQELc67yKTISs7MWBlQZh7HAreC3oiZYRPhZ1Rwwx0hXtNxDsGPdyNc7
	Hh0g9IIQIrt4MhkA6j+bkhNvi+r9mjsNjBZhU/5uVAionHtuvHt125wSHJg4KwUwkD3YuiWCpB5
	G+P4YoVEbV6ZLnV5WxlwTH4o8hxbx8HyesYOrfrPhmmuM
X-Google-Smtp-Source: AGHT+IFARVu7RhkMrgt1lXl6S/Use2BcQ+zHOPhn+JhotfEN9jUN6dNrFSWcbiPHIsc8h/OOnxrBmg==
X-Received: by 2002:a17:90b:4e8b:b0:31f:210e:e34a with SMTP id 98e67ed59e1d1-324e128f8c6mr544831a91.8.1755634481199;
        Tue, 19 Aug 2025 13:14:41 -0700 (PDT)
Received: from [10.236.102.133] ([207.212.61.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e26259b6sm17569a91.17.2025.08.19.13.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 13:14:40 -0700 (PDT)
Message-ID: <2b2f13c2-fe4b-465f-9c83-f76be8f2f45b@gmail.com>
Date: Tue, 19 Aug 2025 13:14:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/438] 6.12.43-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250819122820.553053307@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/2025 5:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Aug 2025 12:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.43-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <floria.fainelli@broadcom.com>
-- 
Florian


