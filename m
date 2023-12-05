Return-Path: <stable+bounces-4739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA61805D2D
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0534E281EB5
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB1B68B85;
	Tue,  5 Dec 2023 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPo5lJIO"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD47A122;
	Tue,  5 Dec 2023 10:21:38 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b83c4c5aefso3363299b6e.1;
        Tue, 05 Dec 2023 10:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701800498; x=1702405298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PgcyvDd+GyU8MF+J1KZ2O9dcJ3DnRcClT2xqXZO8qcA=;
        b=bPo5lJIOUlDWB9TdfLUXqiC/ImoOUgwh/WYYX/fnAWaPw7KwSUL0L4OgN3XoAGhGIZ
         EOv2lD4gvwfgJ7uwIvFfkhzn1KDi4OM/vHB2oZpbkifVRyIHpkUKW+YGaogfyr3ZCCtu
         KDWvF3GoXfXOPreE57gruOgaAbyaRbCpX7aB2DTIsrAMAMcKQSJNfezeTd7yl5Da0Q0K
         sI3oR8Q7T7j6s8kNxIFkPQmUH2LcvxbwKUBPtcLtDKjxh5g83uXuiyvj28U64h/om0fp
         XtKsETN/0Et/bT0T6rYiGU3EyfdbGVBigE7Xcx+JldbaerF3KcOgxMFZtNQg6OUBOv6+
         bWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800498; x=1702405298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgcyvDd+GyU8MF+J1KZ2O9dcJ3DnRcClT2xqXZO8qcA=;
        b=N/JV0W9MfcftTFqY30btitHMFCy4W9s/CNFeSo1MnT3gj2wDpGJj/CR4gOp7+Q1vYy
         FqdNZHn+FJGGNk382xQRJQD4c94ppGJoxv7l0/IH7qFTbLWu5OuFPimp84tX6smcIlW3
         EV+UpoIBJDtn3Y3S50hLbPmXyKMYooX5OF0iVx0qusYbabKzf6SH5k0ZzDD/fNbUgDBk
         U6jeCctCvwWMnSG85afiCc4hbjS+p+NlSJZEMu9w9HbqNjUCLfc12NDkzjPJ7Jk93+gC
         TmmM5uNl0tHQQTMqzPscz9gxht0b5ubu2kgz7m4xcsTvxKxoaOzk7SQi7V9zRtDofHX3
         Kc5w==
X-Gm-Message-State: AOJu0Yz1BeFE9x+BVvCzrJq4J3ACdyb5EYgpIgVn4sbMUK1IDVuAu8Ew
	hcjRG4+tGuaUw78knY48caZgNpDNCy8=
X-Google-Smtp-Source: AGHT+IH0e0BsVVu5PPn4Q2TeakTUfnpt+L3Hj0xiIoNfkyfLhqg1pQ9BbJdXNsEUca+tUpWfQPP+NQ==
X-Received: by 2002:a05:6808:1817:b0:3b8:b67f:b7d4 with SMTP id bh23-20020a056808181700b003b8b67fb7d4mr6149497oib.68.1701800497860;
        Tue, 05 Dec 2023 10:21:37 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bq31-20020a05620a469f00b0077d65ef6ca9sm5203450qkb.136.2023.12.05.10.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:21:36 -0800 (PST)
Message-ID: <2388daf0-3874-457d-a554-882bd3cd2cd6@gmail.com>
Date: Tue, 5 Dec 2023 10:21:29 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231205031519.853779502@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 19:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


