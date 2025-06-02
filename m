Return-Path: <stable+bounces-150622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B5ACBB01
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D251C1647DC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566815E96;
	Mon,  2 Jun 2025 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1G5I4fk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC5182B7;
	Mon,  2 Jun 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888171; cv=none; b=DbMJyDvA0/kgpcinbwbhGWo/PPYs+90bYSPahY7MjNZJE+PypMf2z/6af/DQan68rt5U9em5m953Zqcq5g0P4YCqkfDarSqrCfh0MHECYKXCREC5eN5OvQhBd/pAob4wBpZ48QlHUVx60SND3AvuPSYdsm/Jc4+xSPGK9A+tWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888171; c=relaxed/simple;
	bh=Co5GERlpdWDkiji2O8QMJh5TNTTCEbKdFnnrTwwjduk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cc7Mk3Tnr5MvZXbaRM+aIKdj515ynAxs4A2QtOyPyy9hzRbdwobqiPcVntYMEg1uURHyeGj9YTGRghX/syoxrXIrtULl0Tl21uLy7r2el25VOEMiHUepErxQoM5HJxtXglE9Nql/aSZz9bImbfrU6UDo1S+cUctt8WFQeEA1Gy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1G5I4fk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso3534543b3a.1;
        Mon, 02 Jun 2025 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748888169; x=1749492969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UyqNwvUqQhnqEGUWsWmeB00ROtyy4Hj45n5IuqVHRfw=;
        b=B1G5I4fkNK0qYSI5Vx6GRXLxOvPrZqxQe4zW4P8QIoenr2ZiRFel1J9ssMGkj/DOAB
         p8iyge61t+cs5GaimbY2u6+DhXBGzxYVJvo4tGRZqiPvDIhje/v0LZVqvmpM1Ntrm6R1
         fvK8a/eHq0jFAy+vrH5Jg/zCXmKvzSbNs8zk9ermW5QWVHlXxWR6wtVZiDB0iUk3PwNH
         GwgeSb5FRdMZfzFRQhtRy5z75AHuYsqJzyZjaUy7kqB4BCIyQbf+Rq3BPUFaaF3sxbBj
         s0VE6oPjntqhAh06Iw58VnFqudCl3KlVAk/gMyVF2M0nJFyfJ2XC0xUFxcBoFAgIjh/a
         b5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748888169; x=1749492969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyqNwvUqQhnqEGUWsWmeB00ROtyy4Hj45n5IuqVHRfw=;
        b=YFEV3EgUzN8j6G4qYCTHwpnskXxl/7wVI131zWGQc2flBRN1V4/QF4yF0FK3nhRlay
         SnHbp+UK/B/tynbL6pZClTG7KPddP7rodXcB5J0c0qzug8VsTVP6ENe10clE9fAeMo7E
         qE9W9BXTZYkj0j0+mCDthLMjxfgZcYmUZM7Pyq4SYQXyR6Ib6uoST4H9Xz7lOVDCUi06
         2GsaXtz8DDrRqw5OcPHXVPxwcH1fBe8FZzA/9Iolrd9zcd+pgHb+9ODd/NIZEJ1pcPlt
         V0mfBPK5k76Oibf1zVEEVIZa5FY+DJM+26qhX2MRtlLHAeqGceXyqP+bods8PmCPil2q
         mB4A==
X-Forwarded-Encrypted: i=1; AJvYcCUHCDq6V01vd74gXwfdZ9LtywpGMOfAnK4vL7r/E3ngWNFJL1wHx5auts4mdZaWZHbBEPcircFgmMsXD8s=@vger.kernel.org, AJvYcCULKDXJJU3WD0953avdg69UWL0HxAf1n3W3i6zdODqDBReB2OGEBtflz/JoYchV/Pjdu50C82vw@vger.kernel.org
X-Gm-Message-State: AOJu0YxsnJ8vGFuB4RqcPeFDhMteAkluzQAIy2rv7sQ4lLFkxD7g0Pj/
	kZHYbz04aSgxTdIuZGYcBI7McYzTU4hF6nq2sDYotgK5VBvIu/1RHRJ4
X-Gm-Gg: ASbGnctDL1vpVHfXcXf6rZwhEJwL3O9PN0qMMNjB5BSiSU67WBMLruvpTuFGItMyy9i
	XMAW6bCeYMSpdEa4kihVDmp4+VieqH+MQEQPl5K+NTN8W7QRxRKH4ari1uvY6hZ0X3wkX9l/NIP
	w4ZQ2sgZpbh76V5OG6UgDYmFR3atFR5SjH4JHb+tW+zXoBScZXbrm3ho652XAejpR74xAHkDHMi
	dn5Erl7Cg5J595HT5CpqMdWlSW7799zyPp6D0Apki/9MLOpOHUiYFuE1n+tuqjSoZoLDywgPqgm
	4edDoqarHyrhoY3ucLLvu1WtB34XlWqfD+cM7SyVzU8el+sbT/UK5Do8cND7b0tWJSZ6fah7/ga
	gN4w+A3B993jpeA==
X-Google-Smtp-Source: AGHT+IE6NLTKTpC6GtHj4EgDT76b1zDKnEQQQlNtkMqV5IiX48QoDmFLvqM7upnX4DnZWuYBYe7VsQ==
X-Received: by 2002:a05:6a21:9991:b0:21a:cc71:2894 with SMTP id adf61e73a8af0-21d0a0d64d1mr543065637.17.1748888169501;
        Mon, 02 Jun 2025 11:16:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed33casm7926329b3a.73.2025.06.02.11.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:16:08 -0700 (PDT)
Message-ID: <a0393fe4-4072-437b-a64d-f040c98bcb41@gmail.com>
Date: Mon, 2 Jun 2025 11:16:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 00/49] 6.15.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134237.940995114@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 06:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

