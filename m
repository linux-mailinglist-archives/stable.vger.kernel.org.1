Return-Path: <stable+bounces-32331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696288C6E0
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 16:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836FC1C637AA
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8CD13C9DC;
	Tue, 26 Mar 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrKDxUkf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3A13C9B0
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466862; cv=none; b=tV2p7QkqayYDKaRc1No0szFrbtIMm5ZPbEHqji2VrsRdNpV/eUEbIQmp/l82tSmrW7bm1yVByxbfp4X79CWu70reCNvP7S4IROpa0QtlUA4yXSmqWF6nxPe+UOpn+Gb0tePTNvH34NEwRwZOAMzPeqdB9b4w95Bzopj0dSSbNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466862; c=relaxed/simple;
	bh=YkNsaWX2HTUQq5kOihY1X0/mzkBWN0ikvGkfabNwlk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crP0nqsUXdvSroym8o0hUXUA3nORjSiFM9/3wEmdyKSDyvY5NNywrInOifLbkv9ewREV0c8zTG2MM7RYqwcKgIMIb+S2V6h4JOZZUfw7VRYMWeKDT+RgZUJWm7IptbCj9tm5nH/vWXF4mb4q8jgN4Kw4AmucUf86VUWcKF1VH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UrKDxUkf; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c3d70191c7so657266b6e.2
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711466859; x=1712071659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8KCoF05qOGvpLyJx0EzRCDdY9uRWyKEulxXUNrQvqig=;
        b=UrKDxUkfXY8mcimw0XtLNnPa/d8nW1PV7r9KN2MlBqttbjVtjYhNZ7a2a3m3DcOFeO
         xv/AV+NIM/g8v606uODXX9JD9Blu3vER7cgiUNSouA0KGCm4x/sIltwyVELLaACPo66w
         nFN5ldMT5B4o9bAxJP78iIHvDOkCUYk1JcbxMvD3Zlm1E/WR9VOQYAUPelwDrj8lGcHc
         FQSzXncd/2icmB/HyHFGS18/8mqkFf+rryeLM5zSJ5Ond+ZjsfNn0xSrqslIxbK5rL17
         2+acdTulR9ukWgYuafzRtVp8ZYIJYPE5bmantaJ9L1PKkxemV1Kh9d/2aVocVNZwwIPI
         vXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466859; x=1712071659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KCoF05qOGvpLyJx0EzRCDdY9uRWyKEulxXUNrQvqig=;
        b=le2W+adXPP3Xj+uv0YrysJ9iIW5OhSGXBiroEonOf3ZI8aflv0NkmLHggMuZ+tmuGH
         jEvfESZQ6yVUceiJNdbzzuCxJlt2PFxfNxWU5MlC5qkSs3yM+q4InDJ3KSlfWHBNY2Yo
         5wPomVLu1NyQ8Ao8J9hdAvI+NNtVKCF6rn8/+nYixs0kuq1WugsL1dgpETUy36vODsNf
         dyCw+kcDwxb4VPK/5B3P3peGSJ6CZyZPPjXJVlqH0p+dpWuVNslQ3R/ZRSiaZBGyYa/T
         nZBjnH2lJtTEwnlyXX39y4V0gmV61iTYvAeMERjJxgMXNuxTiP9bMtyynSykLRggO31M
         zZJw==
X-Forwarded-Encrypted: i=1; AJvYcCWfiHQLZ+z7GPKvNrlnqhYqbo07dq9VbknZ/WJ16kCVvelC+RfFeC41YL4LKWW/Ox13d3C75ztwnKQa1cjvmBE7wU8uEZlz
X-Gm-Message-State: AOJu0YyKxb6hbLOz3Oui11IHGePzfOsf/CGchQL6UmwDZHhDaWf+Ij5O
	Q95Ta+0HoEReSa+ujzAcJnYFwwrZxqdFM+oqHegMLcC/LXNzZmRNRhEluKIwv1ld9V+cxeQ5fYR
	Eat0=
X-Google-Smtp-Source: AGHT+IHCzN7eJO+5hXvWc55JPs/oPukABxTnS097+/tb36OwFitfostX+2P9Eu9V3oTVzEPHVe8jpg==
X-Received: by 2002:a05:6808:19a7:b0:3c3:a000:50e3 with SMTP id bj39-20020a05680819a700b003c3a00050e3mr3672752oib.37.1711466858871;
        Tue, 26 Mar 2024 08:27:38 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id es21-20020a056808279500b003c3865ae05dsm1519261oib.4.2024.03.26.08.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 08:27:38 -0700 (PDT)
Message-ID: <289f01fa-a323-4021-8a1d-a12b474d055b@linaro.org>
Date: Tue, 26 Mar 2024 09:27:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 sam@ravnborg.org
References: <20240325120018.1768449-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 6:00 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

There is a build regression on SPARC with allmodconfig, with GCC 8 and GCC 11. These are the first error messages:

-----8<-----
   /builds/linux/arch/sparc/kernel/traps_64.c:253:6: error: no previous prototype for 'is_no_fault_exception' [-Werror=missing-prototypes]
     253 | bool is_no_fault_exception(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~
   /builds/linux/arch/sparc/kernel/traps_64.c:2035:6: error: no previous prototype for 'do_mcd_err' [-Werror=missing-prototypes]
    2035 | void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
         |      ^~~~~~~~~~
   /builds/linux/arch/sparc/kernel/traps_64.c:2153:6: error: no previous prototype for 'sun4v_nonresum_error_user_handled' [-Werror=missing-prototypes]
    2153 | bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
----->8-----

More information (complete logs, binaries, kernel config, etc.) here:

   https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2eDAKInwlwcpYzt67s8SukhrZEZ

Reproducer:

   tuxmake --runtime podman --target-arch sparc --toolchain gcc-11 --kconfig allmodconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


