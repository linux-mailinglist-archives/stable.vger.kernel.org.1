Return-Path: <stable+bounces-105077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2389F5A0E
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8211891111
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 23:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8AD1F8AE6;
	Tue, 17 Dec 2024 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Chz1vVX7"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2E18B46E
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476616; cv=none; b=FFmPCC8cIeg/LNsW0SEnIMXerd7OsIM4hyVt9uv492t2oOJ/7N9Sh4i9XyJWJennbXnoPOpYMOMw0SN/ploRgYvOeThmf/MhO3q4D2mTF0AHKMZToyBZsjLO8RbP1a+TSY40xpPYrOeL/cqDVqB8+oBMiIgJ2a+1xJuqvl4EEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476616; c=relaxed/simple;
	bh=LsZ1ZAGFzhLCkUumArMICoun06GecZ1j6+dij9s2dZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3iSpODqHLP0FQULphnpZ4amBXL4iyaIG9SRoDSSPpNLxlaCGW+hxR9P1+99Zxxi5YuaRWJCJNW2Q0ZWWKFM2NR52R+5RcK4Pb3QvbX0uWZAvlz3DWF5bnXFJG4GQHvasJK/fKtnED19Q+CwTw7oku8lWQhDCiQjOBG5I7Gd/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Chz1vVX7; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8442ec2adc7so195852739f.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734476613; x=1735081413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0mtT107iSHWzSANuPu2CjAzaWYVw9mVugeiQeIiH7w=;
        b=Chz1vVX7Ev0fXBi51fHdB4aso1bHcXO234bdGkNioccXoe8siMSGpQGUgIFlmsgiuE
         vAE9R89i5gvTSAbW9Lan8btF3g6SlTvGYUw6MhdvJQign3oGnTcevembfBg9w+8eLyYk
         zWlBtwtVmZguraCkz98R5qkIaIfdEYP/UN8lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476613; x=1735081413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0mtT107iSHWzSANuPu2CjAzaWYVw9mVugeiQeIiH7w=;
        b=OJTyMhp35I6i3qxGj9pjczYd2ksSV0GTfG53KcTq2Fzg+YGaH0ZrALKct3C8BL6lL0
         18irZ6omUfIk0mETvI6UH22aVbuRws3wd7KFznnTwfyErErt1iZc2lhVCPn+l2RgAgOc
         a5P/f+Dh6yAA4Xxu7++W4KvkCFmeArY0lDQYSyhwz3n8g3FPJoABZcuJOWneT5U4haOD
         MU0YfbVRK3e73sXvCMo49zLWkwN3L9yCu7M9CrQ4hDPcXvnK7LT/vd78a+sgXsiB3SMb
         cfX2Cr7qAf6K27KeyE+D2kr6BHlFcjwYV4FBFlxiv+NB/8v6H69+ve3OGs4Jy1o3KR/X
         L6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWHFXDPt+AtVH+s9mAjoY77Hs6mdQbLGYzQuEV57m8Fq1KdiQ7/y1U/KYIvdnRG/l3m4ceUruk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqtk+0nWciM7CW/R8VWQxq9nYpibPo7qHyJO1eSCseEP3EnRlX
	lTTejY0NM6kSU+xkFEw018+8c3NqxXzMYjX5CytiPqawjdNribnXGSmOYwstsB8=
X-Gm-Gg: ASbGncsIwthUdjbKB926MueTEMwSmQtTODHB0kri1qMepdK6yEqt6fLd+McPzZCh+pf
	2IPvCUQuMjQxlkhyUJaAhj0s+PDO/VdNg3lFG0flrPUXY8oeE8WDsSNZa+3M27/avkyttKpDAK8
	TETe+DE02C1QGh9H5lRLDHARXmcmBav6yL8N1yvWZe5/KeZjZCL3BPKV/2hvaBumm9XHl8/3lrO
	nLhMgcrNhJlQFCWk6KidEuI9PoaqsZXs4gIpETOu+LzlUGICSeUZF7NjHFHIBdOgSSo
X-Google-Smtp-Source: AGHT+IFbiQG2jydmVYuqIJ9wUCpDmlOF6LOcO1cH5JFWnd6a/BVjSfS+sjBumA2syMJeOaIemZj88Q==
X-Received: by 2002:a05:6602:15cd:b0:844:bd90:d45c with SMTP id ca18e2360f4ac-847586073dbmr57522239f.13.1734476613537;
        Tue, 17 Dec 2024 15:03:33 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e378242asm1909129173.128.2024.12.17.15.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 15:03:33 -0800 (PST)
Message-ID: <607d68ea-7af8-4350-b3d4-d4ef1341dfe4@linuxfoundation.org>
Date: Tue, 17 Dec 2024 16:03:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/76] 6.1.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170526.232803729@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170526.232803729@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.121 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.121-rc1.gz
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

