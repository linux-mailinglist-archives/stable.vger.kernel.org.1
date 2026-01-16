Return-Path: <stable+bounces-210094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3523D385B9
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C728F307E06A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038D34D937;
	Fri, 16 Jan 2026 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk9iupEK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100EB34B40E
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591287; cv=none; b=Nygbto/UAtDKgi8pvseqwIR3zq1mYTAXAES3JHRtm+SRxkP1+BEqxKV0g3O47ggwabvtt4OB9Vt0jyYjGIMcMBttY5Mf/UJtYmiRlpxhtvb7m+xDsBwNQwzzftRE/zKDRsBxYeKEeFpsYfB2SKWOfBK9wr3FZEHMDTx6fPHp1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591287; c=relaxed/simple;
	bh=mLblJY/WfcxVHQPwGPf+iIsaiqpV8ySLUYA74U3WKGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzDW6Ab184J/KDpiGnfVQuijvwUpBxG8s0jXpCBA05+7hmZDcftNF7R2467hMTqAVd0CYeMDKi/+0uP1jgqEwtFiWxhoY1jwkyZd8PR8WXNRZ9xi1HWzMgjZzOBqy0YKQjGOzINdaHmn/PzW/zQdWjrnA5EMn2CYHnuwfG7ix/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk9iupEK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c52e25e636so363505285a.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768591285; x=1769196085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6rxTSuFAQ+LCY7I/oFIqogqmmEKdbPz8hlQA5YRb58=;
        b=mk9iupEKZqRMePCsPQ9pLNWm4cjAnCm7ee3u50exUaLVy8WpI22aSj2qiv6FAMjvnb
         jnJOJGfplocYi/PawOLG6ZEnVtAWvSh0k33zozcB8LHrOA2LtPj7OnAvh8f++xlvhSQ0
         SFdv4oiflqbsq28wbeUJwUZgHUdvWFADptlry+U/+kPMDV/MjfbJvFFbAOTl+ZdTXDHd
         huqekKZauGNL4PKqP6SoLr9ZDazMlRkw32whm7QKpePwBAo761oJu44msGc7N68zUR7K
         bZR6qtNGBVdpqXIMJr2Fih1dkgM4ROR8Fc0CcZFe13ue2RSFjnGzam2CJ71nl+f1+qkf
         UzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768591285; x=1769196085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6rxTSuFAQ+LCY7I/oFIqogqmmEKdbPz8hlQA5YRb58=;
        b=MCgBPHkZB2CwhjQITWbQNxBHCHDZlRxXCR/00ucAtxO0N58zn+OkJw/UnDcf9ramST
         cerf9meRfkTpjqv4Gmpn/uP69A3/wWMzNTlN73ZQa4DTRwZwgPBSeFhnSGFiPGgyG9Im
         sXP6gXpLZyZmelhpbvr2g3XB0KWFa91X4TKqVKROjGy9Ik+0k9Sjz2AH22IIkvutj6AQ
         BJmdUI3tpj/3kDvfYpbviEsNcRBKyxWsfyQRQLa3n2FTwxjfKj/UCX/5SYM7JAKwxqgO
         ihsXzfp2sbDqIEYYBFBkLZechyvibz2F9xV/xVsnJ/xWI8pUdynDLweBxHGRJDXz+BF9
         FUFw==
X-Forwarded-Encrypted: i=1; AJvYcCVghZb0pnIuWXBRk/BDYeur3G/yWSq+YGnEP3EVJyCikWhgKqjtGy1HWrMMMM/hsXstQ2nWmaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKFSUnI8xAfrBC0u5dktBLvuR0w3v1xpRrRL3YdNnAjg6/EXQ
	IIb+SSGUPg+eX1x9609TTzTUI+ErfXdLNZ8TM0p6ehA/OCHjOJmH/2rp
X-Gm-Gg: AY/fxX47+i1qV7USE4DQTwrZ/yVc/elYTYiTxm0IK2QL4/HKlwq48oiYNpHMMuoiZJA
	9DIo5112Z1c5ZdEmr2Yl3hP0v1TrNY1O8nA7eBpWQ4LurK4JgLZbBuh6XmiLxz0OgR3xSvGch0r
	Mxtfu1HJ5IiT4CoU7LWAumR9YdZQLVAa4qPE8g3yct+crGUq2VWoeFIliGvvbQqydknY4xx08J8
	XU0Gmhr/zUQg21Ki3t9ayg8XKTVB+LRZaiaXjaGRDvBTTWIBXIBt7c/buliMVLrdoCzrL3bVXd8
	QwcXLPoKl2EfzAK8sxctcowekNAlIJbEHq/c+sZFc/NUe+sqHe5ecsM8+V8n5Sk2p2RmIHCirI7
	PUReuKBH291Tl902lLR0oibzZeKQqMknFvtyntGz5hLKydPKB6DI770ObVxpJxrprhmwesMYS49
	Tnk1mwdP921Ap7ev8JnZHthTSgaiK7l5v6qZNV/Q==
X-Received: by 2002:a05:620a:2913:b0:8c0:cd96:9bd9 with SMTP id af79cd13be357-8c6a6979feamr541813885a.90.1768591280240;
        Fri, 16 Jan 2026 11:21:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c9a9dsm31150616d6.43.2026.01.16.11.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 11:21:16 -0800 (PST)
Message-ID: <83adb8d8-7b42-4e28-a447-49b99544d85e@gmail.com>
Date: Fri, 16 Jan 2026 11:21:12 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/551] 5.15.198-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260116111040.672107150@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260116111040.672107150@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/26 03:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.198 release.
> There are 551 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Jan 2026 11:09:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.198-rc2.gz
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

