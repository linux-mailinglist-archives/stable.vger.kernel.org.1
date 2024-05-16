Return-Path: <stable+bounces-45310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABC8C7A5F
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA781F21B20
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69415099F;
	Thu, 16 May 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF+51iB1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9A15099E;
	Thu, 16 May 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876991; cv=none; b=iHRzQNxEBNar43uwSrL695RY0uS13mSUFA/ICD4+n62lXZJ+Lnwgt+3mfQAXQVO+g99SzSpDlH5oxIv58uJlBF0imt45Mg3uDG57qXW0IGvtf/vuwRFjD7+YqCXsDsMGoM/hBJOdGgJ/YRZ3nOHltj4n+BG/czru4aaIbpzZrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876991; c=relaxed/simple;
	bh=VJa82yhmn2im6N/4IW4PrdpHXnPhynKrnUJl06uH2Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1SbUklZBHxzkLAGB2danTRcjQC3smK1OCBZzVBFEunNHhyeGz8UxeYwjMC/Bkcb8xq6ZFaZxI9FyGUApTgbffuSeGz13SnFGlb+TyS9xs6YsffdqkWwygR4/ynJvjasV2j9viKPvsGIdGl/wcCJugCGLuhIcS8rNLB2/tRAWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF+51iB1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b4aa87e01aso325968a91.3;
        Thu, 16 May 2024 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715876989; x=1716481789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C58EmLarDuraI5No+cuof+OfCxS4CadtEGy5yB6YfHg=;
        b=OF+51iB1Xuqi2AhMj7f3FSv4QTC77ekV5/HcjMPke1csDiTmwZ/MyxeeJlwojE8ty6
         uwJBFs3mbLmYwJrBE8Lfcl702AGNUBL+bZuUS5hOj9JgGWXLcwn6PxvP+DFC57hUoWG3
         s5+hEI/EgO2RQlopzISpgs1Av8OD3KUN+npr/0c/rky6ST4W1TDC3IuHAbGubMQkU6JI
         xag5o11SoyBabOqB+bkr2mFju4YZgQpjSB0DkFESQRcMqbJ4kEr4ElbS6z3Buncoxryh
         EGeTaeTa164YEW4HKse2MLrwNQ0eS3fugsLSEIkpPp7kM5S9wxz/79VUk6V+AQUz4nGB
         soMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876989; x=1716481789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C58EmLarDuraI5No+cuof+OfCxS4CadtEGy5yB6YfHg=;
        b=GDW0rDYhp6c+awlMWX+W1NV8nbVAYa4KreePorKzu+qQ+/hxmYIu7Bciz1lltQYLHp
         M9UJBaCxOYdYkB9bog+dOC8LO+Jy96XcCrWKeFOZmWmD2eFJ9bCilAUEv8TJZcUdI3uE
         n2HM9qTTpYRJE3Z+4SBOnA+iADRUSrOSYxX2Hb75QgazpCRKnXiWuNTMNKD8PCFZy1yG
         X6mmKKplaiqTyWcJUz9KUHDtqUfBNAo2bT2+Fzl7fmXjZ8b0dI+/zyb30fCVuJ/WiJ+I
         K5iNhAfcgE3dorU1mGSr0x1zG+3eFMjHM01Kc18WcmLiDAtgDXPfqzuooYLT73ofJrt+
         MlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH/diXmUYfGEN64psVt8p6Cb0z9fmAc8+wYTaZDS6Flkf/5h7CmNbkdxpTpkrWjoqVXgAF/HxpJhUm2KhlDkzg1/HsFPAfYQDbuKCYmzmvM/hQjO4QtK+13WQDjhGg63eyNxue
X-Gm-Message-State: AOJu0Yy34VovArj84DfhdvxRB7wf8nqRv4JWRrTbwgRnpCF0zNuptw3N
	/7syjEW9agxhfH0c8bZ8Q2X4ZXIyFykI4H8y5b2HhlyOA0Y6RcbG
X-Google-Smtp-Source: AGHT+IGbB2vOTcAQ0CQTy0AHMGQu0uxuN2/qI5sFGkPcfizztSbMB3CuPFVhNN25mwLFUcDFoJTHKA==
X-Received: by 2002:a17:90a:cc8:b0:2b2:9d08:82d2 with SMTP id 98e67ed59e1d1-2b6cd0e7be7mr17253653a91.42.1715876988979;
        Thu, 16 May 2024 09:29:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2b671782d89sm13856392a91.55.2024.05.16.09.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 09:29:47 -0700 (PDT)
Message-ID: <eae40ad8-48a8-4204-91b9-37514d05e0b2@gmail.com>
Date: Thu, 16 May 2024 09:29:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/339] 6.8.10-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240516121349.430565475@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240516121349.430565475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 05:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 339 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 May 2024 12:12:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


