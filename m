Return-Path: <stable+bounces-83104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD379959C1
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC27286936
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE4215F47;
	Tue,  8 Oct 2024 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FvTdkP+M"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511F213ED1
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424992; cv=none; b=b7Xo8Atrv3UIcFekKPpGy/3Q38KxBfQWyyA5rMaAKQ8XMi2B4xHGUazJa65o7Kpr3/jVJP+dSLVz/ab2/k9u38ghp5lmh2cdGM25OSmB3tZvHB2tkb6chFV3Yu0s6h2WpH3USjjEK6xYnLyEQtvSjMK1cq7Izj8qPuRie+PY8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424992; c=relaxed/simple;
	bh=BXAmuJ7ILq+rT+k8LO3lE0/nVu01ECozpjquJa006AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVReZ5DTXyxmqgFWx3FXBSkAyYfGeAYKM6A8ijuD9OTRx2VTw6NkrfcjzlGfpkUHOAr+QHZZlx0SemGWNTWPilHVzAkk00CianmyrBPqyEqploD+gpklkjhv1utkp0FDs44v6FBjLoPP9JCkRaOQgXUC2pm+by240WDl93BSSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FvTdkP+M; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a39620ff54so1945465ab.1
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728424990; x=1729029790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8k/h1zc1if6v/PtO4/Z0OMrVugcpBclAQ9weFD2DFTs=;
        b=FvTdkP+MnPJQYu87Gkf3KG7l+uMDDNd3Xz/q1cunLFadjCr5ckCZrAeCoTA9l+d1bs
         p93dn09mo1Bpf9xB+pwBWoR/7helGIDcHFoq9/VrbbR3S7uC6hkEnyqogV2qvjYCKBft
         3/G1VAEIVC1lDCQe8zMKr08TVAB64NULVpDFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424990; x=1729029790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k/h1zc1if6v/PtO4/Z0OMrVugcpBclAQ9weFD2DFTs=;
        b=hQaSbWG7HLSJnZX2c9Wrlyn9OUl9EKthu3yhE/xO55+2om8Bv0cYUAt8xYLlZ2fCbh
         qwXqDq6FHPq9FrEq6BdD+ykCUbjjEg+aKM/oG2ReGqlTRJ9VcDNb7zZbm2xBXYwZyZWf
         fOXh8UcexT3brMwST36yJml+mnltREej7akUmaWi56dl5V+j77EgNS1b3QQsSLMcyPNU
         61z1U+NS7N90qBN3NlrU6E4eco4bJKTwbbdB+RW++LCuPsXEDYUOSXRxcWNJvibKFWkC
         viuVqhjHDeKuimXejLNoyyrEbdVPwD0myErVwNUpkSc+5axnpmZY1TkjdX6o7L945a+6
         PebA==
X-Forwarded-Encrypted: i=1; AJvYcCVXeRGXQkuhf4ogWeER/xJZzeBnzIxRccYpEPLjillUCgGgk+CJGol6eN3uUo5QIBoqU6ZGzoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6uad6mCIr6ybqerwyMrhggsSl4Th7iIat8JAgmPKvU++PPAFa
	7VEcjzRIXz82MJvqbTmjzXBNbrw6clNikQ79a/hMO3pI9Bd2H0QRRvzaum1BIQ8=
X-Google-Smtp-Source: AGHT+IEbwfQqS1rnCN/fqKqbgzAthDXhnK25PIZwnEuU6F500jfrAspi+MkyW7GIBwdWt2QIv/P83g==
X-Received: by 2002:a05:6e02:1a2c:b0:3a0:9a32:dedc with SMTP id e9e14a558f8ab-3a397cf78e6mr4402395ab.6.1728424990268;
        Tue, 08 Oct 2024 15:03:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db7db303besm1461620173.107.2024.10.08.15.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 15:03:09 -0700 (PDT)
Message-ID: <b1659a9a-66a4-4a07-a76a-31222bf8cfc5@linuxfoundation.org>
Date: Tue, 8 Oct 2024 16:03:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 06:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.14 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

