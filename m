Return-Path: <stable+bounces-123128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF503A5A527
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 21:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E71B1890033
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AEE1DEFE6;
	Mon, 10 Mar 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcD5fpOs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A21D514E;
	Mon, 10 Mar 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639287; cv=none; b=ob1vDauAzmHnV6rIpOZWJ/zvziccrPz5k0jMN7n/VDJFnZ5lrGvjBRB+q1PE3xahZnUr2JYJGmT8d7oQNwp9h6ybkY+0XoXkp8QKX1soCmKyeEOGLsblT7eQzu0ulUAzRDZ/Pgvngr/EW26XGkl26SBbGy+smjt9izmRpdEAya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639287; c=relaxed/simple;
	bh=iOFeGEkeYwKNw3YjGLa4PAADjkpOns1puKEPrbXm/R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evefkxUuTyWDB1ZpkDz9dM3t5lnvtZGnFob3Df+PDyauCeFiv4c8wMwwNmWW4rzk56OO/vx3w/s8M/t9935+66eWI6+SCGP8h1Ov7YF8aCIiRWukYPYej5GYLeNjW4RbMHUiRIuNYtsPztGnu/kS4y9mPRRXR2pEzPNHKtRZVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcD5fpOs; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72a1c42c70dso1794755a34.1;
        Mon, 10 Mar 2025 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741639285; x=1742244085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt8lLeNOphLGI2TA8iOt/B8rG8B3lX/1L2wm03BOc/Y=;
        b=FcD5fpOsQIG/lCs0yiN1Xq78D+Q0VCL43I7/Ue+AK0X9EXxcBxJSxtZ16jSnRQJn0x
         cjRxn7QXpS82sG3oEYw2/hGMHBT6JDM+td0dWYrqiPZo41fJxzSo0+uYFL96W9l80WI7
         i2/orGQxRk4bJv/fShy0vmMl6UBO/uUp70/DAVidYkWZwoUqyh3Y7n05W1tlp35Va2xq
         Lam8A6bBLAHFc8Iz1kSGPe/9VbfeEOI32f6yi0tZjp0asapIYXy6o6zRNxuu7h1+TZ5I
         IpYbn7QblJZTKu5ej5cqmpuRH1ub3ilYC9ePup0OuPchyZUPHAaXeBIj4R7cM9SGeejE
         N7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639285; x=1742244085;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt8lLeNOphLGI2TA8iOt/B8rG8B3lX/1L2wm03BOc/Y=;
        b=TqgisOOguFwwwNxTjSHpNmTMCbVNUxJ0tWaab/8qGLOIcFlu07cf20pLzfhVCdqmUL
         JBfaKF/+lhPxbPNemRYp9VBAdfaM+HP7PwuLUO4NK+wKAzxmsLz02HQxKgh32X/632Cd
         x3i4PijsGaXtS5u+wP/rw/ao0DzTYh55WTwdDrNBYUcVVTZJ/A1S0pr4LjbsQaTy4zag
         fmqXkRkYm54aKI+mMHSZ0oK56DrRgpiPTwKfE2Ediy2UpjiEXLSeAXW+VRHlt+z/jL6I
         oYtkQ9Xs8WWR6MypD8QmbjBjtmUGMO+GYqE7+cuUetJ4edQNXx8uoLmaCiCD8RBmf67P
         V4iA==
X-Forwarded-Encrypted: i=1; AJvYcCWBJzc3e6M+SMnaCgM4WVzKGH4vJMOzPT8nDyvNi+Z49XxGx7CBp6cWn+3b7Mgs9C/RdUgDCT0i@vger.kernel.org, AJvYcCWxfcN3BJR1dJHpp4WaRvn5QbObOsdpPEx29YwARV3W89R+WD45A2iqD0HOW9lTuiXJ9NusBOoi4SlF/A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxzADUIVb6cUMbDP92RrCN4lbQU/OIT8hOZJDGON79KbgYcnn
	8dBjgczzhwB4AwLq/8QBXzbhPT9OutwNHGuaudSw2jsWNZAYpLK2
X-Gm-Gg: ASbGncvP1/jw+kWsc+DMCPPYhZC6CNlYC2m5JB6NzHLCl1g9XEDozKRJdlGQrgMa0qO
	wZjJXC48tfFMpcZHg6uteBsx6iPwuODCn/PmMRIejYsp3X0eOFIMEYcXTKTbqMUBRAbxl7j+RPU
	4Ej6tKofZb4Z2D+RBjY636olBnalN1qwgeikELidn8W5ZJe6xkNfQOJoabIro/NowOI+iEyycwd
	6j/dQRW6nfO/JefcgtqxrhF2RO5tCYY310kRb0k9bgdukVyMPng9euAMrEEqZbEjr2bOnPmVhCn
	//p6nVXltWXo5Op23FFg1TDAfO+LN+GM82UMuxHIHMRYi0//9v0uXF9O59nXcFWccxpdz1aw
X-Google-Smtp-Source: AGHT+IH9Pa17O3DgN1ZWzumsrv6i27njbnYFEjZVmLWI+Bck5mchL4HicXMwOe+/QWv/1Ky6N1hX7Q==
X-Received: by 2002:a9d:5385:0:b0:72b:2513:ad54 with SMTP id 46e09a7af769-72b9b73e937mr570131a34.10.1741639284767;
        Mon, 10 Mar 2025 13:41:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248d5ad7bsm2305532fac.34.2025.03.10.13.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 13:41:23 -0700 (PDT)
Message-ID: <c7719f5b-b56a-4f6f-93d3-18c46f713a00@gmail.com>
Date: Mon, 10 Mar 2025 13:41:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/620] 5.15.179-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170545.553361750@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 09:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.179 release.
> There are 620 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.179-rc1.gz
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

