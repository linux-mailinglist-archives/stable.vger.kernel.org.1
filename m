Return-Path: <stable+bounces-59205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9292FFC3
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 19:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAD9B2413A
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C5172BD2;
	Fri, 12 Jul 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZw/4A+c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8411DFE4;
	Fri, 12 Jul 2024 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805178; cv=none; b=FnYFUW/JC6hZAv1aqpQlnY4xZ3YbQP3zwZNs1Wy2NAM9vF+n6IKj7U80TYu0oR5gReG2zpb2yOd3lmrGWA1u8SmCFHy6hb0eJcWRLapDYOlsz1itQ6uQyA0nyz4b/XgKbbVQqweLJlAtdmqckLPMGQgkfA+QRxaduJh51Alt//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805178; c=relaxed/simple;
	bh=/VjqO/3zgNDdhMTYe4USUSkjtpPhw+zF5KO3FgdK6is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJuTCLqHTZ678rCpG735qLdU80F/3hWc78EU2u3BNbE8UXueXX72axmo6YWTrFWqm+XEvHZJu4Kb/EiGiCCS1yCoiYLezQ0nw8Gs/nlTN7tyHt+nl8T5OPsm3eOtjszE+rt4+6ZqbgOT+vRJ4HR7ADshJLVJvcaAW5DNEvCmiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZw/4A+c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fbc09ef46aso19736485ad.3;
        Fri, 12 Jul 2024 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720805176; x=1721409976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSpJ3GhelfOwQSGbY8nRGIriyOJSpRVJlayhSCxpKeA=;
        b=aZw/4A+cpwaXuFgQYsxcqANCDVjmjgaf5tJ3Qhko37AI7WrJAgY3d4UKUnkAnBg5q3
         gWs3YZkPLzR3K/IlK+9unJw7RdwdcNdm3/ho6pioBcBWa/tl2e5l4TVH4nUpHuGnZrSa
         eCDh90AX0lwyPB7FHE7WknPBUusdVkEQT1Tgi5w3vdczssJ3QHz16kle26PEof9KJyBf
         1ARcjTMyECu0sCgkN/uQs4Wv2NTWQHj58uPu4DyHhDzorGZO/LCSS1VwyhuBF05Wyw8B
         76EaQS+W8CodP+fjE9NsGoy1Il8DpLQJgqMLNc0UQ0gNwV+AGNGPFUAsUBotlQp1kXRw
         KS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720805176; x=1721409976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSpJ3GhelfOwQSGbY8nRGIriyOJSpRVJlayhSCxpKeA=;
        b=Nh5i5jnP93qo9MqbgTKvjh6jD8tr/d/TP80N1iqsa0rFfttYZznFL74CsFnF4DOPic
         OhJBJol5IoRLHs081RQleGXB13DYQFfmRLPSRo5M9wFmRgPakCYIS3eAX5vQ7zoo5heV
         VrWY6BTNrIKohrM2IR3kZigQrj5KthgQmRxOkA7Dq2h0Nz2ZZUwEmQOtsmspuLdkCPW2
         eOxTEXpDH4Gx+YZMGHW2v6+7I+Uw4PmQJRJxEiAnlMJM9A9lZOwOsME2LiiiC7bO2Ww6
         lth7v5CQVUife7flQ6gnvTFOVXmi0e4E2VMNQIP/pClAmIRxjtXrIV5m2t+qlp5sLb82
         MO8g==
X-Forwarded-Encrypted: i=1; AJvYcCWPsC2sTZbnjFR2GijLOH11kTOjLxQz4P7NjumfYqbA0Gjkx15KJdKI3uHT9t/DQNWD+zZ2G83CElbZEf03G99e/3Fh33AS7aQ9mB8Xkv2E8aw3YmBIB2GDoSJdDDHfI/80AXKX
X-Gm-Message-State: AOJu0YzJhK2BDWlQKoh9pa2P4jkDVAKLeih2P+TEPAO9UbYcZgxD9Zhb
	x6v4zch5DTG6SkZrD4nLHnf92oNL5wurLCWm9OdORkQeSYFZIqiX
X-Google-Smtp-Source: AGHT+IErfbWmHh1GB/4b1sv1DCFWnYZqR3hDLlRsz4fkcPL5203zFPWukODV0KU23ANjTwLjhdLrjA==
X-Received: by 2002:a17:903:2291:b0:1fb:5c1:2681 with SMTP id d9443c01a7336-1fbb6ce1320mr120155055ad.21.1720805176195;
        Fri, 12 Jul 2024 10:26:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6ab6b9fsm69708425ad.138.2024.07.12.10.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 10:26:14 -0700 (PDT)
Message-ID: <ba6cea8f-85cf-4248-a373-b761629a7e3f@gmail.com>
Date: Fri, 12 Jul 2024 10:26:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240709110658.146853929@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 04:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.39-rc1.gz
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


