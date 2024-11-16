Return-Path: <stable+bounces-93668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898129D00F0
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 22:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861BFB21473
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B61A3BA1;
	Sat, 16 Nov 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fl8jWp7Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5A194A63
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791945; cv=none; b=tK3IiYjzhDoilBjnnvpNNoIwl9I3NG0oeya3SBtIyiRBJteVxV0ZQILaszp886ZRxLI7BD8+TIaCoVSLzHb9J95JN5ke20OlnoURK3XCE3z8NOF7SLVTUs2f/vzGS/3xjS20zHMtuPUIZnKeyGOw01NTuzmk/FsUb7QJhrebCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791945; c=relaxed/simple;
	bh=ATCDMfq1ap+xVM6eDu6GAm8UuTQFcxafUK21WEUFtU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUYj3zmjiZQZEgvON0hlMQ1OjdjcjDUe0sLR/mIdkO268kq+tyNlOyBzThDsf+sAQ/6Kfnh1G7pyEHt7vJV/nSe71ArReolVusHZm0cHHsRWy3SuAnSpbqEd8zfcaoPVebexoAdRm021kU3mYCc1gKknUpd4068+984bBa8oB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fl8jWp7Q; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83ab00438acso86861939f.0
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791942; x=1732396742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vH/N1Ah7ld00p34JtPqzQ6F88eNrq8g0hTlulRI55uM=;
        b=fl8jWp7QZICDZy/M8eH47TzGHxgspbaaMHbwrcHTvofYSqsosMVBLDknJBQm0O17qa
         FlzQaOrYByRNfoAtVhKEXgb2b5Q4GqvlYIMedmN9x7LJhkDx56Qcw33dBqpPy6obchjV
         VzWFZjJNCu+WIt2thdTQZaJ9EbFut2kSXHBlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791942; x=1732396742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vH/N1Ah7ld00p34JtPqzQ6F88eNrq8g0hTlulRI55uM=;
        b=i+x2wnqx16S5pt+guPTM5LI/6y3kYaq6W1saXvz8r/FweeAD++en2OfVx25np9eEEi
         HUFOvBbyFaVKD2nOjs8EsOczWc/XNOJvV8GNsIDIdWwnhOM4DVAhvAbfVcA7w8T0ClQL
         x50fU9uU5K+xsUNkmNx/6X6jGVgEBjp/6j6CKW0Y+buenyBnVpEKcIJVfPN+SAcUkV2k
         m+GTpuha5VwyS402TrFCS48dZxT9xW6C3XuGe/Mn9TXYWmNKlkDtEGMBaPlVX7eneKHt
         nUs4m5CADFh3zcSzW1MeIOWBUuJrJyGB7ypAqJ2lrpinJTjKO7UPpWmuk3PdzkjCQyqA
         jxvA==
X-Forwarded-Encrypted: i=1; AJvYcCXx4lioyL0kHN61+VHxQEOWN16lM4RB4CvN7Fl5twV4tQQomOUT4nHG79h0kHw1f3OSefW5qKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNieY3C8PMGuFxEcdy1L0L9PDJAhyEbg0Nm1aha6R1FS4iUe89
	TKMkAbtF2pdTBAqWMu1ArEyEt5Uxjsy5rRP2lSu/PQjVXBqE0URmdX3Ecmr8qe8=
X-Google-Smtp-Source: AGHT+IFq5s9Maiz8mB72S8XNfESsKb86sKgq78MZpNxGDzORIvnWzE40RzcCjyYFXkV9FGACyi9G6w==
X-Received: by 2002:a5e:cb4a:0:b0:82c:ec0f:a081 with SMTP id ca18e2360f4ac-83e5cd850d6mr1054234339f.4.1731791941764;
        Sat, 16 Nov 2024 13:19:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d707987sm1206884173.34.2024.11.16.13.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:19:01 -0800 (PST)
Message-ID: <ce63b792-7430-411d-923c-39aa962ff35e@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:18:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/52] 4.19.324-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115063722.845867306@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115063722.845867306@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 23:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.324 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.324-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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


