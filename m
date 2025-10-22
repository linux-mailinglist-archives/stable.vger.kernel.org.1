Return-Path: <stable+bounces-189018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB1BFD551
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 18:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2ED7581AF0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78E29C339;
	Wed, 22 Oct 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0+836r4"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B429A326
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149848; cv=none; b=oOGyYuMuC0PVxTk1gH0hkUrzNTGOmiMjiyRwnUEvq1dzM+cPPnPKP+9gP6PtV1fFfShW645jCm3z92c+qHODYJ6nJ/u+7TPXxOMLJFTKt8oHzYqGgNp93AASQ4pav4YIfJdeO1nrbag4DYa0B9kcAJxO56SXVgVUsECJgKz8M38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149848; c=relaxed/simple;
	bh=bJnDcFIdIHGxiONbn2/mN1YrXxkCQ69AXDwYI3D7Ojw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myiLQnDb0woAnGWzq0uM+kfbKzPw8bZqgaOkojO8qJEa7T9U/i2GGqzXt4Bd7iUbeXGORMacis0rZgD5ndEB9dOeBqFHyuaWdwVfuTQdYVTq813AJKPJ0QeZSoRnSbwpz4zPCzCglgBLQLwWPwhDTgIbhgthUBh6/4BWPHSqDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0+836r4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-940d2b701a3so420260539f.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761149846; x=1761754646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohIPApBH9FOd6VfSJ6LwqJdcHsRV0vgebW42BSjwjLI=;
        b=A0+836r4epO+xX3d6pNKxpILxLXAxbA8LVrO+vNouFSKbY34blWi42DRyQ8tlR2Vk9
         UPGSzna4fwrdvdVpwoQYfkdVHWZRCwgyDWXecuchKd/17py0XmtQ1rmWoIBeIYmtMWEn
         w0qxynlTWrljhRXhUCt714gfbh1/Faw0/yRX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149846; x=1761754646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohIPApBH9FOd6VfSJ6LwqJdcHsRV0vgebW42BSjwjLI=;
        b=CXNvgnPya0DE8VU/ajurO6g+CWPed9bVpc5c0TBRrjy5AnCYGQO9k5oiO7Nl8kAQJt
         zYDUL3Rn33B1kL5QULvEMAPsPo/a444wwPQXJsjot3xQfSBxPbmJq2IUjS6aKyWF+APe
         lpOKgVEVzk5tt+Xizkb59n27yE8nySWKXZ0B8pCQuYXZ9RT3V0B2GFHYXIyg3IXDfRTf
         eLyedBXzMpZQNcavFihMhBP5FoMyJUMH/Q5t1gK0l+bYpArpkrtByusJRdgq1/4UXErZ
         TgaxHgWjoAymKPtdBtpGuPkCfv6CsREA5TUqzgdZFCq3cW0Ny1AJ9leY1Dpn7LIunHud
         vRnw==
X-Forwarded-Encrypted: i=1; AJvYcCVKg5rQmDkUEvGx2yhmCWAFrCo6LvG5ON1gdcCj1To0X05nmXe4QNVihhXn69iBoc8GcRXgEJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybm7VrDBXncLIM6oyc6HemvQbExt498Y0ttCJoqLcpwCWA+d/e
	ap75EE7WIfNIMfii3P4jyDlmiAXfH5oIgrK0kpjyMc6n0GWUNaAY+gv7b0r/218/QSfexOS0gFv
	tq6NM
X-Gm-Gg: ASbGncsJcO6V5cjiVWZvBTXSpOEz/W8h+WOS2ieFt1m6/Aoatsvh63SmKLwbVA9Ppzm
	z0y6f0iWMri17l+Px9rQoIcQto5twvpv7cg8yghE+5kHPfROekDLpSzfASn9obV3jXMiY06YifJ
	DwPUNrySBeGppw7nOZezguu40QeWJDJlb9A/acjAFVRNM0eby0uYEV5BhwrHndKwxrsZFMxyKc6
	5nj0o8uPr9Yk2KPx7+CmV1/IvlrEiGWA5G9w5vPIrboY5WghDvA4Ijn720rDOlsKJUteKWgWB8c
	+xY5hzhj5TaQuWbWsmxQrYcuUz/h6xFC0jEFGZmlu8GPuPqSIXYdN4XbrcyGAG/S/N4JI9C4LP1
	4DrJgGSq1LNxJcNnBEcIJ/KBQ0dPh44P+dKVKh82bfYbGuTaZLcgDz96MKUHQfhPFWsEzIpkTyU
	IW41u+I/VrnryH
X-Google-Smtp-Source: AGHT+IENId+3otkyvFCVvSbIP7aMnHBbcVmNJLxAqp8FAcojgNqEhNO66lf7DIELTcRS0+v4li/Ckw==
X-Received: by 2002:a05:6602:6416:b0:93e:84d8:429 with SMTP id ca18e2360f4ac-93e84d80763mr2540500339f.6.1761149845759;
        Wed, 22 Oct 2025 09:17:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e8ca2d51esm469991139f.21.2025.10.22.09.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:17:25 -0700 (PDT)
Message-ID: <e4ca190d-313b-4c0a-9100-9c351b1be22b@linuxfoundation.org>
Date: Wed, 22 Oct 2025 10:17:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251021195021.492915002@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 13:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


> Mario Limonciello <mario.limonciello@amd.com>
>      drm/amd: Check whether secure display TA loaded successfully

Verified that the error messages are now gone with this patch.

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


