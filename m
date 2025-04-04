Return-Path: <stable+bounces-128326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC138A7BFD7
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392D017CD87
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A31F76B5;
	Fri,  4 Apr 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4ieiCyq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327F1F7076
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777969; cv=none; b=bdebLIPvCSXYru4OgC43r7vnAGdh5o/K7I0N6kEXyZBeDwiqvZ6UQvhRmIWghBNBDdMTk0pRyFViCuAk7N93JtpgA3kyQ8Q7+5G7vt3GSevas8KVDPRYL4/+Bg0VwT/owRGhdzs4PA05K4a54qbn9c6XhPFLZXO0tosjgAA+q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777969; c=relaxed/simple;
	bh=e8o8BmTI9LJ5Xp7bpW29EBBSU6s6C6evw9WYpy625cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdjfooVqA09yLgK45vCAVBgwg13OoZT+t4XX5GkxJ2GFDU6e2THeFb7+zWQLiy9eF4EWGs7WgRYXoVtj/TEWBuUtxBW0ofyTPGbcZ7OiXkhdQfliFaizv4P/FN3mcFO59NFgMmBHk4OUSLdqXfiX+9BBd59l+PCLqaFuQJyw4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4ieiCyq; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d589ed2b47so7166045ab.2
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743777966; x=1744382766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=If8+GB0jSdfPLP3IvZq/oz7j7TFWAF4rJnIO0c2k6PM=;
        b=H4ieiCyqWVQ3c+6aLbh84R/mwfmums4yeWOyi2XS10XJBYHbA7vTEJcydor8Lkua6y
         32dapT2jo5psjK9W5jhgnHWKLWK8Dv/+M0SIuAjMApZ9YDiXYIivo5suYnXnk+oIS2uc
         wFgShCuN/HB6OSxNKZp2LQ299pkwvipGhZL94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743777966; x=1744382766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=If8+GB0jSdfPLP3IvZq/oz7j7TFWAF4rJnIO0c2k6PM=;
        b=fYYhjE54UAQZAcJ4yu0Hd8JAHe/djboD7L/1ipk1yqunvfx2di0Yxxw1NzPlrPKwP0
         c5B82IP8OYb4NFCTFiQY7V1ZVHQiLZQgdBU22KdZOmbqJbUDlQ+Q07TOWGGOh0GOFAhZ
         JhIWP/4AfmhBHaUKNYmjp6aQv2YbQTmZxdmwTChOmDRW/xr423m6F63Yffcyoi4KsLeO
         NNG/f4CS4+3JNdm/qgXCJmbmw5+fjPOgf/U48/d1TA0sYvHzhRc/2EuXJnAV6vHYXf8O
         gyGYfn1lNQc4aHJlkfHuioTEpxtubEi3RbPt1HIcSPIEmzBq0IWhXfCskw42n3iGSsZj
         Ocww==
X-Forwarded-Encrypted: i=1; AJvYcCVNStzkKeqCcJM2hicyGfTmc8sU+O0aDIJmdSSYGOu7klRCKxiLFdiSTni2mZa6TEEleaxfQcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbRcfmeiy6SU+0S5U/0gvWwI1TzufQejg4xdFGXtS6yOj5OhP
	ljFhCMd/1EziwUDz7VeCDjAZQO93wA2tARy6wkU+D//vEeIjq1bxuSzDmgjlTls=
X-Gm-Gg: ASbGncvbw4ci9pbyNPJzRikb5NXZOdyHrxMlTA1cu9z1YcdrAQbftGtZxupPcur1L+G
	qFHVAiTkaZkEb7AmRWjPY39vNZSj63pFMq+Wft7rx6XWK4sSopLVtJjTIjAhoraC+jtyWu4ySvh
	MEwL30x9b9yZqApPxuKHx4wbPn0AbB7M1Sa4tVSflIT7SnHr3wGCOdhxAkQDfT1rlMf8N8V8/eU
	AS7ahKBXYczV6P1dbq6LrN+3t3vApLjoTU9/CxXofu+QAohXPJhF8620VN22aN1nvwur3FzullL
	9V/Tbdq8nCaHsdaPZJjHybsERVMN1jebOwb2io50QNdljIgC21PJIKA=
X-Google-Smtp-Source: AGHT+IHC49zN3kIaY1D2eId/TedJ/qgZbOEFiirHmdO66xfiFOnnnkBBWZEK4pO0xJtY1CuuGzjsKA==
X-Received: by 2002:a05:6e02:260e:b0:3d4:28c0:1692 with SMTP id e9e14a558f8ab-3d6e3ee198amr42916255ab.5.1743777965689;
        Fri, 04 Apr 2025 07:46:05 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5d243f5sm836895173.91.2025.04.04.07.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:46:05 -0700 (PDT)
Message-ID: <c0c9ac27-efc6-4eac-a386-daa89130eec2@linuxfoundation.org>
Date: Fri, 4 Apr 2025 08:46:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 00/23] 6.13.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250403151622.273788569@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250403151622.273788569@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.10 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

