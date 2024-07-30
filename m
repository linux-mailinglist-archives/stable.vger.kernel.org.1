Return-Path: <stable+bounces-64684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF494235E
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 01:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A10028541B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 23:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B5192B64;
	Tue, 30 Jul 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DbrPwNLE"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B6190070
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722381514; cv=none; b=Bcyr14goS5Atpo2LWOsnDa8sii9NP33CiUYwxJC3QYvWXmp5kwUO6AqOlLQykjNbBhY8GBDIEaxfKNvV76hu+m+TFXOhMRG4MDo7cHfGjFys6v+MwXsDInuu7nFs7Z6A/CrtyIyaiFCRlt3D8hZn5lKycwwsBnLRKSYtUuXEFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722381514; c=relaxed/simple;
	bh=BHpnOjHsaw3hGBR29qRjNfSHbrZWROLb8eFVAKfMx6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkWiRSLPfXs2TR9ibGw8lyOTgA84tzJEOk0hOz7R/JDsgnReBaqMxztMTjmtTvzSQB6PkmH5kRTJRhhsEyws2ZO53KYdki3GxQKUWruIzqVWpzuZMC8mkIZqc+G/yPG8VCDVRfGmGeohCjDLyFTkc0gA8SOQg7amFT6ygVueJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DbrPwNLE; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81f932ede28so27483939f.2
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722381511; x=1722986311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pfnz1Mhod0xB0jg/7UultOZotMIwcjsz34ryNq1e+NQ=;
        b=DbrPwNLEBLlyZpUuqHVqbP+PBXF2ugsjVg7CXEH7zcgRkFq1G/YH5knpgs78iDLW5+
         DM9ithpXkCc+Sgr1Z1hj0kWwulBG9p0f+mL+35MG6TFhtBu4PHEK9wyOr28OMmktc9OA
         Eot9bj7QeMTyM4tvPTiGay865rx60gmQSQBbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722381511; x=1722986311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfnz1Mhod0xB0jg/7UultOZotMIwcjsz34ryNq1e+NQ=;
        b=Nh86j+oC+ly5QaIyC8+9LamXVLku1490jC3sCdin1/BlVz9kDo4DSdARvNF2pan2nv
         5hJxAbMSZcyMBtbePOh6Tc6SAviVZrTi9mY+kJKlG/6nBC0nM+8xAHVarkKNE0BmtIBu
         /2M+VmEmb74UDYfVNZJedB30GxGTB5EUZ9tr1+8o5Gwgg9iXE6nwVNpG2LlolM7vhbaG
         iIYdpWBuDF2fw16QxxJXM9uPHXPVgYmsLKstKE7oUzmU4j6IN+uAtUAE1F6gzm3Tq7aZ
         kF2dZSoZE5D7bbJExrPO5lkraoEJ34iu9i98aS/AeTbxMeUMnLyA0173joCXMg0SB1eH
         Cm1g==
X-Forwarded-Encrypted: i=1; AJvYcCWdhoyA37WjIRxkdTcJFy9NdaTVVYyJXX8MBp3p2mLOQxdhCCHdSesCoqnMaS48tMVczMmRoUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaWrAcpq8tcDBtjak+RCRbSmEANI/5xGfSUlo/ef+gG14yksDA
	EzenXwhkMtwlWW/Prb/pcxb47pRylYa1KFv4cnTT48Ve6uri5k6KjahiWtmoH5w=
X-Google-Smtp-Source: AGHT+IFPYVEDGwXLv3ojVCIG4y5kw975DDdJ1Ftcw9CCAG+4ZNh4B/SMv9IBFcQwK8WwRKd2Y5lOAA==
X-Received: by 2002:a5e:c116:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-81f92194514mr840008839f.2.1722381511530;
        Tue, 30 Jul 2024 16:18:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc5c850sm2935042173.167.2024.07.30.16.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:18:31 -0700 (PDT)
Message-ID: <061886f7-c5ec-419b-8505-b57638c5cf31@linuxfoundation.org>
Date: Tue, 30 Jul 2024 17:18:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 09:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.103-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and failed to boot on my test system. Panic during
boot. I will work on finding the problem commit.

thanks,
-- Shuah


