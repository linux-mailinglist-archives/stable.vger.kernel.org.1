Return-Path: <stable+bounces-93664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6669D00E3
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 22:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD591F22141
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1012D1ABED9;
	Sat, 16 Nov 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JUduwfrx"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E518FDAF
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791430; cv=none; b=nZSvLR6359NsuPaH6lPoIwAfncR3s1AISQu5NBkgUme7sdq1NaA/5wF4kzwBqQEhqv4wU4Ox1QBRb0/jJWas/dDrBC1mdvAXfn7HpanrKL48r3IX8IFbgKB0ctINcIkZwK/5yVL+8zkCcHChE5Qd1GiXYI2hOlnJZY1/XJPP+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791430; c=relaxed/simple;
	bh=eJb1HN3fwnkvx2NdbSKfI8Ywjm148cLmw4I9CYv54FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvoXUCMzgbwpVxV7mQrpllZdbTpWStGSEFMNhRcaXTUAlAoNAlHmrts03VVuYcG/LrEfe1LhLaj/QjlOBZiFmG2JYGK2w4NcEoa5hFahQZ8ddtTUPK2WGMcQ0dv4x+MZ5RIcaAsTvomgkhnqaM68x65CM1sQ4TK0jtPzKISDFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JUduwfrx; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a76156af6bso393965ab.2
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791427; x=1732396227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbBud2naf4JubCnVmY9ZpR/bTsHDUJktK177sfeaBcM=;
        b=JUduwfrxiOv+altWz42usoXUhNaK4i+lwCikqQSvnxTBvCxWz7R8Mu/bqK7MM76bg9
         26hTL8N/bb9PqkCJlZC0MkqZsYzc8A0czHa/dUS7KRYmHlZiGErKTZMjACoNw/Ml6vK8
         sf9oQCPBf+oYE6uXkSxj2MY6yJ9xeYywikYIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791427; x=1732396227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbBud2naf4JubCnVmY9ZpR/bTsHDUJktK177sfeaBcM=;
        b=ZMuoekIXQx2IL0ol9kV3xzNIYzhOx5hZnFo9gUPZGaWx+9F0HqDNegNAkhqPwjDnp6
         ugHxiL6dOjgf8zLj7m2pRg+05lIFsqabK4ozbeg22sGEynC14oyO3KMbI+e9orAqSiQ1
         HciP3EBJDA46aPngvJ6KVPTGfxZaLMplqwxlFO00P876fs81JyiB6AZXHgw2A5yVQYDg
         LzzYciAALLrWiFN3gYmEwqhPvNP3nudGUHGR2SLhfc/XVuPaV2w0DGzqZemYj4Chs1v+
         1HxLdN2MP9Q3NVwN+W7eKu33i0NeoX5zbIU/1aiwUKr/sUtB46fYJ8noF9GbQ33ak8e0
         4DkA==
X-Forwarded-Encrypted: i=1; AJvYcCVe1cwD9SmJAqj2Nx+by4FxKAbOs9mLDcB7YmdYlCYxU4wuIdzOv3snk2hcQKnyeIFaTOVtdGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLViBw49+TUYGHCrS1V6rtPcAZ26HYRytU7DXVUcfXlGLr1f+y
	S2AEA7XmgwFsmBt+JVYClZMUxoT0lc7gu1fo3aTVY9fNtiR+M1V0OaJxtyeEwME=
X-Google-Smtp-Source: AGHT+IGv8usQ9MgOT1JphpO19XQbtTjj7RUcbeRCZ2oDOI6yUyOM7ELGdnc3WoLZny6B6hwElr5thA==
X-Received: by 2002:a05:6e02:b21:b0:3a5:e1f5:1572 with SMTP id e9e14a558f8ab-3a7480d4ademr52241665ab.22.1731791426914;
        Sat, 16 Nov 2024 13:10:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7481159desm11603515ab.49.2024.11.16.13.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:10:26 -0800 (PST)
Message-ID: <87ec0578-5355-4a1b-8271-8e5734aae626@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:10:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/39] 6.1.118-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115063722.599985562@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 23:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.118 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.118-rc1.gz
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

