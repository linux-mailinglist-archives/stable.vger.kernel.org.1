Return-Path: <stable+bounces-171840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8FCB2CE48
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 22:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C1E5A0A4A
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6E343209;
	Tue, 19 Aug 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y41r3R/4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB63246BB3;
	Tue, 19 Aug 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636676; cv=none; b=HqRcmAHAIGtzwMp07xABHRBF6DyThj4ZIvU3yzBpyB2ZiR2P1BZMVqR2Tr3VKt9NWi0ZJxbZUW7EYbnFzHC/jIOwvdez0ai6AT3vlehcd12X+cZZWZbPt0TQOn1VmVQ7+Uhrha/YTKnzRKyMtG1ZRV6wGJFnXQEblr7ATAH+8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636676; c=relaxed/simple;
	bh=fbXKqVb2JPhnvekqqoKj7sdPLgf3Vmir0X005Q94bOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egb+vxnb4PG5FxsnKu76mK7pwWquiVd3cGIjOj5kKuhHdT6Wc4eEh+Ids14BPObdAfyv5EogSXuX+Aiu5pFgyAeROScG9MCgNSrICnAACPuYrIznEYidrpGOqcD4F0rx1wIPKhmI5X3G8BaArmLpFNz0AwoeRfOoHoBK1K04GPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y41r3R/4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4761f281a7so481033a12.1;
        Tue, 19 Aug 2025 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636674; x=1756241474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsf75o5pbqQ/RVrm3BZ39NsSKgyTHItMNr8xH9NMGBY=;
        b=Y41r3R/4Z7NRTcKOo1VGvUtg1aXrrWikF55bd5HSBYZRAKh/dUBx4YsunMDVVvnq25
         xjrDIB0usle78/Snur7XeV6iDRWSJgmhytKl4XiJBkHiOHLf99mjDy+/yLLn7Kuw2+re
         /RzBcku8B2XRrr9iF9r0wkhnci1wD/AHKIlb1c7e0s0IV5gdy+Kgv2JhFt/k/RleVlvA
         rRcRv6H3uTDbDzTMubXsU8EcMljIpUf5+rmsR/qVufpF3KheJipnMJa8HZWI07pSNA5t
         BCdC+zpIiiPHL35ln9mCGkYmlFDL5Id7wTijIPrBRTPTvODSe3fCTT2HW9tauCZrbZG7
         Fa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636674; x=1756241474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsf75o5pbqQ/RVrm3BZ39NsSKgyTHItMNr8xH9NMGBY=;
        b=I1l5kwx3YAaGnFW721j9uD9GigTVGAAlwq4NN2Nh1T7QLquFBhiEAoCfPjXNDE7DjO
         1AEIXAkUl9yci8ZArjlOnMqjZAtyn74XF+EyEwPNSFpwmBEStIS6NSA7GFPCDDiGU8nH
         mD0zSxqbN1yzTqOl0sGSuzOs6Cai8aLNeb5ZdeHnBd5eNXTcJfQBzv8JWGbWw4jc5jPQ
         iUpilGaMG3af4yf36/2zvbPSLoetaBBJFdaAY59+xWFrD7DaKZbHQKcG/+CUaGMsV7sy
         8rRoj+CAJ/X4LsM2qinakYeSMaYr9LESJueg1D4o4CSHSfbk9KI5tFcZjCetuhCe6sCO
         IWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9y3kkUO9KRAHlGuBETw4SboO+6/U2n1LR8u09cUJRmjFh0YEB2N4hh/NPWd+XaklMPnUzRBpW@vger.kernel.org, AJvYcCUCSLmJZyYyy8Nw2WM8vSHA/utoUi9DI27ntrd2+WZSxuKO0iZ3usTstXJjesvBFGH5UV1AIj93uOdzL68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqCLfvdE14mO/3eOkz/tF1iWvaYAN4GMqznYC4x8/dKF/8gOA1
	60heOlmZwTwoYVVER6QVn8wuyj/u2eW7hbNmJtqWneM7JDeB70KTa3fl
X-Gm-Gg: ASbGncvG1joU8v2HcvK4M6GXsqXgaXqwOQK7VZWFnTHmJ1L0YIruXPP1pBcfFST2mSc
	51fUTq9bR735Q8GA//0nPRyY809s3Bm72qa56z03BbDCBHEF8Emqo3SK+bY1ZS3zSpALudvP85G
	mQJiSl53Gj4nvbwxkxuBV7LdmGa6EKD8hKmpvQmcoZ1hR/lgRDAVR7rpqQEeY8Ntvi+CGWdzqZ0
	D/IzUm5JWG2A+JrUVxvuPHOvedGTWdV0+4vm3ETWqYgwimS0fzmeUoBwRFjG7zu+2eFbywL5+aq
	jbCk78k9TI2u6Eq7m1n3LGQBIK8My/Utvdcn28N7m1i8akrjF4+/hZYQZBb5DmLEV3YraX5QgzB
	oc/s5JeNHJVyg23JcLCovNhkWNZCjxtYiGg9rjjOdeI7EDMi+65yts04=
X-Google-Smtp-Source: AGHT+IHdnDqTAdFyfeuwzzQ3e0xeMJNl+vkkS7OmIQ8wnmBFdLlf3gL3RHuTH+7osbvxSs3vvwWYTA==
X-Received: by 2002:a17:902:f64d:b0:243:e3:a4e5 with SMTP id d9443c01a7336-245ef2854a0mr4139625ad.48.1755636674267;
        Tue, 19 Aug 2025 13:51:14 -0700 (PDT)
Received: from [10.236.102.133] ([207.212.61.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdd6sm3411398b3a.29.2025.08.19.13.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 13:51:13 -0700 (PDT)
Message-ID: <8769a705-6343-4795-8df6-bac3c851f225@gmail.com>
Date: Tue, 19 Aug 2025 13:51:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/509] 6.15.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250819122834.836683687@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250819122834.836683687@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/2025 5:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Aug 2025 12:27:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <floria.fainelli@broadcom.com>
-- 
Florian


