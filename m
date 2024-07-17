Return-Path: <stable+bounces-60488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0EB9343CE
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3BB1C21679
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647EB1891DA;
	Wed, 17 Jul 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LluXf06E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDED188CA1;
	Wed, 17 Jul 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251558; cv=none; b=gmLi6PGEMrD5MSO443sW1eBxuE1iBrH0Ds8pgSXegcnvhMbZyxAjmpf0O/Cc4NCcBnxwp6TUxjPT+kjzXSpoWC9rrPApNVccL1Te93jQCiFVwH2TlozBKN6BCuD7VXyS3zp4Oy6yi8idv8gc5LuTeWLgqLxPL+hA9sTWU0PIGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251558; c=relaxed/simple;
	bh=AODMLuRwPchbYFj0U5w0p7CWGnFA2ybIfL9Hq8sHjUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR4VXCXwieBmTWmdz8AB3s0XVxNopVGcy9V8/87Z4QYyxBfRBRkP0umFtg5pgdtE0LWDyA8qM6lLtQaylqKSXUKb7B05mYGIvvAf+cFP25oKlTcDXBEUAlYyaDgRGwa/5W7x6Q7LmBS0h/yuUCkIeZe9sqIbYQNd4DZl/I0jsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LluXf06E; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso84000b3a.3;
        Wed, 17 Jul 2024 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251555; x=1721856355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2FZIW3YSi1wBOFs9v4R+8sE20hCRwn6eVXzZjVhxJ0=;
        b=LluXf06ECkN2DxIb5rj0PpfAOjHSr5RD5gx1GBgYmaAmuu0/5IQBMGje6dNbXoMkJa
         0P8B8efxZo64H6XHIpWwjF1K+2Vlig5PFy2cEHlHz2vOr/ShG5hSpUEbdgZAZRpokS0B
         xl1Os5l126ZiM2mlBLLOtqIchUF99Tf+lzNhdZVHdc0rHSlwXR/9O8+iJUNujzxSEaPj
         C/b0fV76KS61hE/TCmqgYzZVPHQlFJXAE99q+l20nROeYC+ukNfXODgyJWFYLRhR7p4K
         A7ZQXgADXMo3mGuxsy/OnzcBepQrKNylDi8iEApoiEaBS7SfxipGsqHGSgrPgirQtoSc
         Rnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251555; x=1721856355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2FZIW3YSi1wBOFs9v4R+8sE20hCRwn6eVXzZjVhxJ0=;
        b=Vbxmkb9NVU3iNnUeV4ZIR5McmjWqCmGLXSIkloQ6kEbsCCNsn3uGvmQ857q6/Vol2d
         gE20ZWreXXBEZaScxWKhrDa+DGORhQ18XJvtg7wEBR1SHrm246yMpuunm42BKkDmql+6
         v7nEbM9KEvqIl53YY9LX3IBe9fYjUjIkvd/HJPegkCNzOjJ6C+Xe2XnpyeEHP1X0Pj+G
         CnPqkiBcRcdgaeqcIjJ3u/uC4FGYgt7Ht+GMCAv9Ha5lxvYViStX5Wf7cXLkOhAVSOCS
         eGo/QmurtTMhG7zf9/WgePe0EWh9Ag7AwursYQxVt7kWTq/BMB6TABs7iL7EZxKzgz6G
         XZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIV6SDLgr36NIn7PzSY5sgFG0TQEHgFAVcjiDsRf0Yx6yRcDesZCy9bN5u3zbkpSR5ANi+bbabeMSQWhypphy7wHY5a+5Uxn6qflqA6D9nXa0LkOs4/LaiN3SSNvGe8DmhQ0Kr
X-Gm-Message-State: AOJu0Yyznh8pHP4BRJX24gXljsXOxgNjtlY1BcHxx7RcfHyuMdgPK+RE
	PN49wsfChhGwgAoR/gYV42mVAAuQlqST15wv5wDzIk39qEJZeF4u
X-Google-Smtp-Source: AGHT+IFQbW0ItxFef6sGCxXNrAyaZdWSeSUCCyVWiaZ7ROXW2Ds47eCnyUtG28t0CqTWQeUPGKsCOw==
X-Received: by 2002:a05:6a00:851:b0:704:2f65:4996 with SMTP id d2e1a72fcca58-70ce4f902b2mr3485587b3a.11.1721251555311;
        Wed, 17 Jul 2024 14:25:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b7eca8c12sm8864645b3a.171.2024.07.17.14.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:25:54 -0700 (PDT)
Message-ID: <b6b4c58d-8731-456e-9ad5-f83f3934ba6e@gmail.com>
Date: Wed, 17 Jul 2024 14:25:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/95] 6.1.100-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063758.086668888@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240717063758.086668888@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 23:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.100-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


