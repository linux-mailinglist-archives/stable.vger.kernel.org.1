Return-Path: <stable+bounces-116327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C03A34E9A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 20:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6947A288F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3AB24BBF5;
	Thu, 13 Feb 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQNttBFb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3324A07F;
	Thu, 13 Feb 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476029; cv=none; b=ZubyyZFFPCnPNtq8P64G8u/hqXkaKD9YnHjNSmqC2UOpHFgzJsZamk8kiJEfk1XuOMhFrA3JCLXaH/iwYL05EXFfREBUts2VyR8k1H+UU2zmwLvp8uIIRlgbthy5SE0ltPbfcPMIsDQ7AQ7ln0wDaC3pLdqVC9Ss9ncDYec4PGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476029; c=relaxed/simple;
	bh=0w1ZZ4jmCmrLlObrMPOrE7ftgtzMdiwWCFPrH25+OhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU66Inkznrhoeot5qx93HXlkYDt7Jt7a+Xb4WeAM0ZnswWJWNWqzuFSCoAYRI7irzmsru0cGMIwKlbZ0joFB0man0JKjW+PR0qLT/b0f1zAi2d3X5bjy8kDrNwwIPEfFcq4/40aw47mGR3i8dKdKZlvaDbvwhvScspr5Q936m/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQNttBFb; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b2b6019a74so698830fac.0;
        Thu, 13 Feb 2025 11:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739476027; x=1740080827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cKirdMKnWH3+52YbNQyVAyvrUnCUZzKET3AeafaIxXs=;
        b=DQNttBFbJHeKnhJomw4PlJiPnH1FwLo8/ea+rvS0v1WC0GCNpJ9FT+V4jIBBGBVCiE
         IHAPc5u6kQ3KGuK23oDtzKTCr9Eng+d8Za1v9Wow4QG68jICEqqHqh8W1PjwB0Zy3HWR
         EKFWg9/GyC6F9Mr8S6KmXI8XExm2aUPn631KEl+iNi1sWs4SCS0LPbQ5Hqw7KxBRB9ZZ
         TZ3A/e+57LGxSpJ3bDi1APsIKYOldJRSO/UF0fhPsGp4Rygemu3930knQZnRWVdpMN0F
         uZ4wS5Gk0lFcaz+rj9+Urvi5S+XCU9NVYCmJLdiRSVcDm+G069g/GgH4H7MNM5ge4OK5
         gh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739476027; x=1740080827;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKirdMKnWH3+52YbNQyVAyvrUnCUZzKET3AeafaIxXs=;
        b=Kpgx94pPvxaotplSTh60d3opuQ6Cjguh6SqV/s5PG1ydRM4rmi06CKAuiRbWmqLW9f
         NOx9b+u7I+ejDMHYWquoEAYNp+oU1jNJEXi8NBQfNle8C3eIKCXK9dzjBnGw+oe9cAC+
         dyNulgvoOx0xd51WaP7cN16kFnONVh8vq/uWSVHo7v113jaPOHxohIg/r8MD//fTTtn8
         aHMQ804pLlfObAHsx3poQ945UemxTL8lm1w2XPsQ224wgtfCG+vX62FRMuDYwz2sHECT
         iznNMPQnGcy9YpiDEeHKyThlDzHjjpXK18gSAJzF7zF3lYpqHugm3+tghSBSPohFXXeD
         m70A==
X-Forwarded-Encrypted: i=1; AJvYcCWrPaGKLucB8ygdzwWsAOqNzZovJzghKXEADt/lk8Uv7XFa7F3znq5yHITlhB7a8b4Ni4KOecjI@vger.kernel.org, AJvYcCXXi5ZCDjD2hwmdr730dSAdMVkn4eVA+zmbd27tu4RRm10CEt7BWbxVik5ItDQ15cZir+CBfNwcd7Yw+k0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xEwknLYs6qR/jD6z68pK+gSFpEgRPwnPLVu+mTQ021urpOg6
	6sJAG4Y50Ck8adRjNK5PAaw2V2JlicR6cyPaZV1Hj51uXPZv11QS
X-Gm-Gg: ASbGncu0WRKvz4/mc8oyaqVRN6OoQbhqNNrrhJY6OyCR21lTjzzThIzAJ5vxhEMHIOQ
	QKdryO901hyp5HXXbJ+S7GJZ4qrrrsqQSlpp3uaaHO+/94XUA24NEXnogaekjAeojjvFB/qiBTh
	M3sM00a0UbgzHgLcot0ryDzp8TLMQZespuwSEmLqvcxt+QhFSDAwE8XgtqJIZ541D5MJX/UynP6
	2ugaCwRXZBOgy25O2xtbY9QYkkJZx/aj/8DgEiEpjuFNoPJ5gew27LAF+w2H1ufLeVHQ39rWLwr
	WEAk3Y0LI5Rtfhzn5Vz8B97pHwEVOCnU8iVTcEGfBw0=
X-Google-Smtp-Source: AGHT+IFt/xuLE0M/RZ5+g8kk+czdfelmH7CEYVcTZZGQoUpaTiEJJvB2WIxtfenzRn8sqtJlwoWeAg==
X-Received: by 2002:a05:6871:20c:b0:297:285e:ecf8 with SMTP id 586e51a60fabf-2b8d68a30a3mr5120107fac.25.1739476026778;
        Thu, 13 Feb 2025 11:47:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b963a100d2sm1011611fac.44.2025.02.13.11.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:47:05 -0800 (PST)
Message-ID: <446b2ef3-844b-470f-b5f8-f21f4bd399cb@gmail.com>
Date: Thu, 13 Feb 2025 11:47:03 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/273] 6.6.78-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142407.354217048@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/25 06:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.78 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

