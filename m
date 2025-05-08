Return-Path: <stable+bounces-142869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7752AAAFDA8
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B2F982B7E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2390278167;
	Thu,  8 May 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWjR8rVv"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4001CAA82
	for <stable@vger.kernel.org>; Thu,  8 May 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715652; cv=none; b=BuZSKkAklML/kuh/NuLlw2sGri90eB5vgvD1ZPlcirHvKEgMdgVybqz2Fa01ITr9j3JCgOgJs462szuR8whxOa8iGGc/kubcPy0LW3PxwU2uQYqHQT4Ee1ZCd0Wd1JlIGHUwww7HEOe9uNEV/RoszUKHOnQHOqZ/6zM5F5/ukjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715652; c=relaxed/simple;
	bh=luUJyA3uAaGs/PyaYYxxJvQIzj2lSb8XygjS9Rd72wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCooEgqG1+YX6hLRz/+N3Yi2+gHt/Dkm2HnlEGGrPQbgmuEhRxvjC/n9/kQqLOliVMJEcNn7WOcws9kqoG3k5xcret646ypRkISiYSuDut7Ck0r2rqC2d9AWdRxabl1pIae2c5hllUe4eRMupOaINJX/65JY/KKiHCIl5kDWDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWjR8rVv; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86135d11760so76702539f.2
        for <stable@vger.kernel.org>; Thu, 08 May 2025 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746715649; x=1747320449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrqpCdSBggVj7dmGh50mibgH8h/HbWjldXII+uWa/Ng=;
        b=CWjR8rVvIHl1SIC04usauXWnvyBmFePWwzG34bzk4MxItz7a4x6+m5ilQjR1qysaWj
         Ff8P3xgNzPzPigmofMBHEzg5Sb/mdW6qzSvVvJfXQW+DjnVaGa2SDpgkZDbJFz7686k8
         +GJFMO/1NYt4koKXasHuSl/F49WHb2eYLnEL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746715649; x=1747320449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrqpCdSBggVj7dmGh50mibgH8h/HbWjldXII+uWa/Ng=;
        b=fnkN7raJ90z7xLpQ1vA5MMyhtKn4Q+6M6i78reHX0D5LUUd764UW+Ummuu8c0kAuWY
         zyc8sSJsCBnCUdaVzr99nwmmrvaeRjUo5IVoHHnP53Nrm+ZYdr3OJOLM0Mz5NIjnVeQb
         RBa66hPPODpCmltDSZRVKbKHCDSQKfwjNK//CmjT5TLcj3ltgEuyecnQataFIvt6JbfL
         v3dKLqlJsSfaSIiJghlVpO6Cd3N7ci5kjEb5UE15iJHC695/+eJNJDVaezEsKMWG1VxD
         X13wow/nYqqF1ivKrD02QEJ5RRqBEgfluzz7A/XoHOCAuoIuk/AFCGfucjKxY2JD85PX
         vi/A==
X-Forwarded-Encrypted: i=1; AJvYcCWOmrg4McZUYjWIMjMKUSL3b1eJ7wPi/mfAfH8q5vys9Xc32m6iikrozhQ3gcZqdZ1y/o/odcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZxIZxzUis4CMJCeuUcfMNxqO/i5ArBRqKk2fdSX7qL2rAzbi
	7Pz8bkBCaWqIlcXz4NPipfhCGJMPOTQ3RAmZ/+lnAXOtgPDN8AqSkT0Tc1d5/ys=
X-Gm-Gg: ASbGnctBJefsxza8OHhV7j3K7hLxT03lhEt1S70oJ1jCmAu8maEN+OkBjtwDy3lVeGu
	0c50uZCTzHTnjiyJxKEEusuTm/zb9kLW1In7Jhc1lyAJQ1+wfvw69EMzMdevE8SPLpEnsvC8uL8
	NbUQrFcwQ4aOaBPs4Uc+o7zbPP/qWvbBelzu4EtNZHLf32P89d/+NRvgQ7mRTO0lQXNKta9dRUQ
	q8e4QAfl0MATWckvm6FTv4QL/2rUo1tvL/MPMkSSs4QNHcMg4MOvVXJiS+SBvh2Oa2Ywt06uZzB
	c61mWBcZWTxcPvDDZ5EOvPLTxGtLb7H0EZLE/+iO1kFlf+zYZjo=
X-Google-Smtp-Source: AGHT+IGxYglVOnzP6wSYH0JFEU/1vIQ7nILmgdTbPRyB1ivX5F+qBWHF0YJIRlfVAST6F9A35ixJlw==
X-Received: by 2002:a05:6602:1609:b0:864:4aa2:d796 with SMTP id ca18e2360f4ac-86755073684mr422835339f.8.1746715649197;
        Thu, 08 May 2025 07:47:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa43a361sm308633939f.38.2025.05.08.07.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:47:28 -0700 (PDT)
Message-ID: <c2d56742-8156-4069-8843-9e004cb1472a@linuxfoundation.org>
Date: Thu, 8 May 2025 08:47:27 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/183] 6.14.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 12:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

