Return-Path: <stable+bounces-178987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956EB49D0A
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DB57A2706
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5232EB87A;
	Mon,  8 Sep 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="db29rrud"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC4224247
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371271; cv=none; b=Rwk/9Kx5jzNCj/HG61AGQawx0cE04eObif6Nmf4mMoG/TfjduLOmhyzGDvHRp7y0pc5TNRpB/xu53YIriV8RmQaNN9ELZ53+zojhAqNyTjuiF++Ywc9WuJbjmZ1hQRSEek3CNsNoi7J0ZHRD07kwtm1M5lKVcc8OAYYCmt6VO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371271; c=relaxed/simple;
	bh=fSqFCqqM3AfsbXjLxbGREr5s7O84Qb4Z6tn5ZtnOX+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLCV26QRwpwI3/g8diKH0Pp4BInJ/TT6+cKYzsdZPh+z6EGhcOJqyEnKFlJo/F4xP1ZCxxfPKmRHPf33pNAcVKmZ0V+snPO0PShLoXNiw6yyvx8OiVTaNr40Nyx6Alzg+FAfLVNiAMGekGQv10XnepDP8fXNOhYVz+SMbbqZTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=db29rrud; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-40b035b23c6so5646035ab.2
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 15:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371269; x=1757976069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68HWy37O10tqXYXKmGukX5WuN1MUrjL9lhDEm4zk/jk=;
        b=db29rrudK4SDjPl66cmsSi9HxLFiwW6eFeq+FQCnBBAomGdS+9N3v2pvQt0M2UKeeK
         qp4/jWHncluDuYUSaXgelQsV1hFS7bwAgo69t1ONpdBMbkiix3sn3hx6wfkZkvLP8vmn
         Czt5d7h/mVhVxmc5pwBnX5BgEH0Hwwe63f89c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371269; x=1757976069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68HWy37O10tqXYXKmGukX5WuN1MUrjL9lhDEm4zk/jk=;
        b=sz5rJv4w3thlbxpVgqQesNHMpbPJnAUsb0fNk8pEP1JhMEF8yGqQietLGmoSpn4c7r
         15+Sz6mrwed2MQg8clURco0xPT5vX4d+laGrVzCMP92TX8wa1Wnsi/rPSniAPAohJCvI
         fdkSu/ioucs+elbSJiwYShvs4npg6712d06rAA3Uioshi70syackS6l+erR+SeBxrAOF
         7gJyYHrvxPwL3SrtAnTcUSiAFZWkjU74svJXzEOm3voU8x8VdjVIDBzbmStuv156zJqB
         uON/+QSRVM7S/oYsMYmF1+Df6N+ozv949setlEOocAUQrcx1+m9MR5ljQEDFV6CGNdMv
         3XoA==
X-Forwarded-Encrypted: i=1; AJvYcCXX0/qn68iasf4EWai/LqGvdPwwlhN879gFXKJTwjZUi9yj8NFtXsekyYq3pfdmiTbPzSZqP0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwKezgVq2YoedElnM5UwCoTBIup198orHT6c3Lq0IU6vHQSnb
	ukT5jlsUOp2w809bTGQz5EV9fcnUDBiOk2WSMUHsoIJmZ/GdTSvU6YxWxlySiDW3HkmN6bNhb/Y
	N48UI
X-Gm-Gg: ASbGncv/dWXUYv0gC83VeF1MlRjemevYO5XYuWOK2dFoFs7PUvc80ZFprfpRz4NjMnK
	6mDT6IFiLLIz1MR3iCbZObDebrdSpzMymULQts7Ylq0O2UiuAi7KKT5orwMbGBYD0Cs9puahB7w
	YssWODe8helwPC4yGSXFaWsXMRwdDlkbDyG3Bn1PAfFsodx5uT8r944BFKracmuyFg/biDrlcT1
	/C1K43bgMqwQ8xLtw+iK5GYW1r8B/P6wzb8kxN2VAjD0xMzz6TklHGKviNPZCBuRNJxtEbO0Enq
	Opr/WCgIPOCYO4HnEK1hG/2sQQBJat9hZZrq35FsQRa8/cpF4bpoVpqQpxaqFqE5lAfsE61sGsr
	+pmJYvEZOwmqBH7B7UggYRbSBmfwEZeWW2gY=
X-Google-Smtp-Source: AGHT+IFWCsaTSHUpmf8Cx1hvBeqVbtqoKD11vWy//iwDgAihm5QVuVHARPtrG8fFcTTACW6fAA4FvA==
X-Received: by 2002:a05:6e02:1d86:b0:3f2:9ebc:ddfa with SMTP id e9e14a558f8ab-3fd7e252fc6mr118637925ab.7.1757371268960;
        Mon, 08 Sep 2025 15:41:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4007fc6c9bcsm28400385ab.14.2025.09.08.15.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:41:08 -0700 (PDT)
Message-ID: <1d872101-6e5d-41c2-81da-db7dadc6484b@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:41:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.105-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.105 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.105-rc1.gz
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

