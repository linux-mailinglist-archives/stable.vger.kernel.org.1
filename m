Return-Path: <stable+bounces-78192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F59890B5
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 19:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1D1281BA5
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750413E41D;
	Sat, 28 Sep 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fblmlo7Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A5200B5
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543748; cv=none; b=gMLmGpuCt6IbW6Sm0NqlBpnE5IzTMvP9Xx3C8mVKWz/ZpqaaqLavmI8VGK4ZdjCIALRC6+yRMj8s57pBOFFGc6/+15GnNOFn6T+IIfeExuFprgLfu6XOT/d3as6v0yS6BON5omRUmgau4gXL06l3R5xTRbezN+yPDDktMkJ18i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543748; c=relaxed/simple;
	bh=brZNRktrqnf16yGsrlDQ5PzC88tuMZ8s8OQMtm/EEgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJvRKNkXJDTjs04MxIAS5NxW+XpbDNcrGGnjgfbNoGHKi5us4q4zTIm0olnO9REFmrPRyg87G/OKrtba4SM7cCZtKfqydZQCNqvVe4e/x4mb0mxZkhkwSvJ2CPiQqE3nyyBc1Hpwo7X4/omOgZqUVfSwnncheuhiYXVYQFOpF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fblmlo7Y; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8323dddfca2so165878439f.2
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727543746; x=1728148546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmV2od697yXP1xZ4Ef9v5IPEDQ6DPMqZn4YDd0qdJKQ=;
        b=fblmlo7YlOVD+Ihex/krXlcEukuOdGRAPs2sI1EDiVXYbgd3CIuOhVGD5sKQyc7qtI
         aXitPtbD90e/p7J1B8S1FaIbNia8KdJ8Z+KyTouxoN0bLfx1whcVRQFPaE3lpiVL61Ej
         LnQxpOH6KlOzvIZKp/AOUt8la807huv+m5qwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727543746; x=1728148546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmV2od697yXP1xZ4Ef9v5IPEDQ6DPMqZn4YDd0qdJKQ=;
        b=NUe+C/2siKh8vjXEW7bIFQUJS7X97KKd7BKLwufJtmK6ASEvjaTZJbPDHxZYjup5iB
         OCr4a5gI15hcxChoLn4MIyMGHfg16SqGrG2CJORA6GYTMN1blNPWxRaH/CShOOnlPe6Z
         GhC+YqVkMYGlFhrBan78FNTHJ2RthqNuwh/U0Uv/Bmf9ytOBa57yXGCf+YW45p23jUY+
         KeDHrUJsNtDSUweDmQ9PN2QoajBkZjX6a/Px6AuG8z7QeM7q3pxwlSTi3glFA1cgnpog
         zJOmKgLt7MOtNxFOHVGBv3tAfUMEtkM11GtdoMh1HORun96Y6lfBxad4sT7xgpStXSJn
         po8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxF16L1LeUxT049LZl7wjVb9+eSUllRyQ/+ts+qaxDu7crW9RmjOjhkE+McWHHQhVRV8JfIOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnEXiXM3gzl717t0dOdCuC1NLwL0ECXidjaaihUXD9eEu1Zbl
	rifQog0oJknnJa05x3Yg4Z68Rtkk4hjt4D6v6KHdBB/Xemi0W73mACskffyImWE=
X-Google-Smtp-Source: AGHT+IEm78FTE60MAO3XfTpy9lAnLFdysKd8G1TzyucE3vFDsQjy2E15BmYrkPIUP1n59S8P5BjfNg==
X-Received: by 2002:a92:ca4f:0:b0:3a0:a21c:d2b2 with SMTP id e9e14a558f8ab-3a34517e868mr68409975ab.11.1727543746145;
        Sat, 28 Sep 2024 10:15:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d88885f9aasm1189688173.67.2024.09.28.10.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:15:45 -0700 (PDT)
Message-ID: <46033b6b-69c1-4254-8056-6e8ca8061f14@linuxfoundation.org>
Date: Sat, 28 Sep 2024 11:15:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/54] 6.6.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 06:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.53 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

