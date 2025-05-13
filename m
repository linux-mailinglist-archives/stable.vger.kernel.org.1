Return-Path: <stable+bounces-144205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1401AB5B58
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3457AF6BF
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F092BE0F0;
	Tue, 13 May 2025 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bhT0K+8k"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FC1A304A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157543; cv=none; b=nX055NrMhWiYVzAH/pCQ8sLB1tpzdLG0br4h+f3IjjESNS0IEfWAheXBmxLsYbcT9vGdpwET3/g5d5tFL7M8w0VHQxTdceQugqN+CsdfIohqRT00uQy1kvFX2isbAeB297LoPpipYtj/6/jH6A/484ed2KAW72VUZfiThUAkmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157543; c=relaxed/simple;
	bh=xkx8Y1zm0IbWHQo28qfYmM0rx/fAXJplkL8G5rh9aeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krugJcFVaexUewwykc2gImMHkdkWG4a9YClVnbrinfChDZLPAOPjCpaoZ1qa8IzNCRBI1u/4K4ew1kBoeIf0FJC40QHZgVdMt1/PBZ0bqkeKv+JBh0bYFvQmdRmDG0xBIBaUUQu8RFsPrzcXB3YOAYNHmAe+Nd2Et21FKiPM2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bhT0K+8k; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85d9a87660fso612738739f.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747157538; x=1747762338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+MbZDnbUPKSUoUZsaJjBizYbNkZOWSQfb1Bn7Itqcg=;
        b=bhT0K+8kau0WGPsNRyRN8IppwJ/9tg+j2heuZv2CJadmW9U+uLI7nprpbXseRpxQ9Y
         QDE9NdoLCIhvVLBzNVtI1+4NZIE0LvGI4oCnWoxNmIptqaJYjDu7fvjwlO87IvCMuT10
         XKos9Q/q6kgok0xD10GiXyf0PXv9aDmAiUe7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157538; x=1747762338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+MbZDnbUPKSUoUZsaJjBizYbNkZOWSQfb1Bn7Itqcg=;
        b=svaKf1G0NsvOeSHL1DdGnzedZxJYj3Ise1IcGYu9h0UDkruPgL8MtVi4/uy9sZ9U81
         oFA+07mL3fLOuKQ6kDA9gvcTeM1mQUVZfVXcuLV+bm5TCtn+pp69ha1jXv63hSP+MW/e
         Mf9ljjkWs1o6gmf3DEDkHwt93iJtKg/rNoFS9nmEA9vJnHuAjBNdF81sylGwUxGmowIq
         H2IX4kP+Tgq1QNMXLuGj6xqSBusin+cCKdF8SOkBtJiUpGDbxOue0tArnnRzui+YMErl
         iKxMO3gGq6tGcSU2ABSwI6waHUJj1qDPSmNL5FMGUNqBnAZmydM1UahvYTePRTmM6wrd
         Pcjg==
X-Forwarded-Encrypted: i=1; AJvYcCUK0ttLqI3C7hpVz7ieYzFiU+I5s5SnMqe9ZqTFCCCMDhfbIJMvjHlkD6EAN06OM6RqxEWszz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmVsaww7SIXbgkX3haRnYsSeA3dg4MT1YSsFSTLNdG+3MDfx3
	QoFAkfz2qiJ7yaGJimDux2sIwpD4qvd76nQ0AHiYSKbghRn28LTYIu1BYQS9FZHDH+LOzQtk6wR
	4
X-Gm-Gg: ASbGnctJZ+meB9L4BH0GoUpSg8gueV3fVn2jjDgJQqxvjALywULVNVaj4pPpujNUILW
	8tvdKTuOKp4GSTwl/RzPddJM+7nojwPXd3BOW6bxAofgTzj3l94jLxBdtt451Abwtks9RiIpRCX
	ZYE2kdN/YZPH24OClgrJPNAmFw1xuRKEAw9t0ZdFip/50dgHufpt5VlRiI+eVCp2kohQ2Z60rUN
	ABXSqdBIrOwDr5Ok2x2yAfHqxQI+37SbQXT3ipuGEFS0/zszFsQOYdxDA7bIhbAoks9ObIQ1kmX
	Ajjl88p36SN9vqUFC2pZCQXVOjg1LcsH7swuDOrS0F9psPrglTluSXSKB//FNJqIyjaXPN7g
X-Google-Smtp-Source: AGHT+IFWdHjRRXf8QVQEUR5t3ZnpDNlogFJNUICkx9nlc80riFRqz3gqNSj0dPMtDWrDfIPLhITPkA==
X-Received: by 2002:a05:6e02:178f:b0:3d6:cbad:235c with SMTP id e9e14a558f8ab-3db6f7ad141mr4886995ab.6.1747157528157;
        Tue, 13 May 2025 10:32:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2262d462sm2229617173.84.2025.05.13.10.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 10:32:07 -0700 (PDT)
Message-ID: <50ab86c1-4b23-4ebe-ad87-7c8f3f90e7e5@linuxfoundation.org>
Date: Tue, 13 May 2025 11:32:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.139-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250512172023.126467649@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 11:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.139-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

