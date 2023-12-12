Return-Path: <stable+bounces-6472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C54C80F23F
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E26281B41
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232677F08;
	Tue, 12 Dec 2023 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="My5iUGhM"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBF2D72
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:17:33 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d559a71d8so3098255ab.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397852; x=1703002652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZZsDTMwulx2C3PHKVWLrfVDevlLtMgvyrHa2kD2onU=;
        b=My5iUGhMjRl7x8qpUmPLn1QgT7QenFhVs7dVxTpeffupXcFR0RxmYnCOoCx00M3tOj
         4wWhmqV/8TWdRAhBZyOVEhp02zjFTPU3S0np/GamYs+C2e2rfv9xlr2oNv7PyG53Itq4
         AsxFd9E4pXYAAqQDdJrE2y3NkgWNqoJvZ/tlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397852; x=1703002652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZZsDTMwulx2C3PHKVWLrfVDevlLtMgvyrHa2kD2onU=;
        b=Jt16qde4KUohGIKUkKEzJGYDH+okO4rqgSaqONgYbomhjKsdDxbsEeol7FXOzvCGYS
         2HVlY2d/u33PvF8QMGnNeZIGDY3VxZIZNdgnvETz7sqqxyKfSA7sG6V35BwbnJnF38Zi
         HupDQX9MIHPbDMGKqVnMnD5T2SPsvmRuqbKMEb9Z+zJ58KCX/WxC0zBzBbUKHCRlf4JF
         hUVRe2597ATEirhtnvYdvj3gAwIVNCTDCQY6HZaaCl/UbusHWxiOequZDeGdPPIwtfjG
         G6nPTu5K4m94ePp+7d6drVvwVIdyBcax3soZL7cehzSWDEWuzLYh83gSu/Nib6v3ACqc
         n36A==
X-Gm-Message-State: AOJu0Yx3/xjESPEPUSHj9Fzz+J1RqNS6XMs0qQqMgn4ZnHJ+qvbX/GqJ
	0AYO7Rg1vBsz8jmdcLzD9JDPhw==
X-Google-Smtp-Source: AGHT+IEw06m80JBwgXxznxRucxWd2rsVfnN7r+g4/CDkw9yYXOxydY/mOkQq1kN0lweotU7cVET3yA==
X-Received: by 2002:a05:6e02:17c8:b0:35d:5550:76b7 with SMTP id z8-20020a056e0217c800b0035d555076b7mr12405452ilu.0.1702397852518;
        Tue, 12 Dec 2023 08:17:32 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id by4-20020a056e02260400b0035cb9b85123sm3014243ilb.46.2023.12.12.08.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:17:32 -0800 (PST)
Message-ID: <a716de20-d5fa-40c0-bb11-e34c1034d2eb@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:17:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231205183249.651714114@linuxfoundation.org>
 <fa221062-03b4-46d7-8708-9d3ce49961dd@linuxfoundation.org>
 <2023120932-revolver-apple-d4c9@gregkh>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2023120932-revolver-apple-d4c9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/23 04:44, Greg Kroah-Hartman wrote:
> On Wed, Dec 06, 2023 at 09:31:48AM -0700, Shuah Khan wrote:
>> On 12/5/23 12:22, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.10.203 release.
>>> There are 131 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Compiled. Fails to boot up. Boot hangs during systemd init sequence.
>> I am debugging this and will update you.
> 
> Anything come of this?
> 

Still working on it. I upgraded distro on my system which is complicating
things. Not sure if this is related distro upgrade or not. I suspect it
is distro related since 5.10.202 which booted just fine prior to distro
upgrade is behaving the same way.

For now ignore this and I will update you.

thanks,
-- Shuah


