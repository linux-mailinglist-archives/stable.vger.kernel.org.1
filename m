Return-Path: <stable+bounces-110038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372FAA1853C
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE3A188B97A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B31F0E25;
	Tue, 21 Jan 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrzbJBuG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEA1F76A7;
	Tue, 21 Jan 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484203; cv=none; b=axMUvfjRDBkcAsKkLpOcxItEH14XM1PQjbskVYOgQf5Yovw33V7PNdOLPcKmltFqDdDt6J7jDNo9llsXOxUG/Kt+F1mXc7hXAo+aSw8q1AaLojkg1eIiIQcupjAAjTW19GsNEoXIaLkxltx5HHqaTnSKp34KgGGNCZ5c8+5dZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484203; c=relaxed/simple;
	bh=/vutXnYVmyhQsjwRtKszcejcdcDtsokLDp9RgjxyHgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJzLA5AbYisSW3D6dpYZCcRqR7so5+1+F8fC+PBhPfW+KiDD3mHm2mJYrma2N4jfHAgHEP1uSeZQygP0oeArcXC4BWEaKVofa1cPLuVj7GWeDXyYXsKV/5OVo6RIBdxV/VSW3/UwYW6kOvDj6GFtHCiFwPf8XPGEDDmXak3CAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrzbJBuG; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ebc678b5c9so3424672b6e.3;
        Tue, 21 Jan 2025 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737484201; x=1738089001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh47sbhBkhnOFM7hc3tO3sny/2UZwRiDWNjSfYgQwow=;
        b=SrzbJBuG8WrmCF48cgXs4HakTJw5Y1V6Bc9Y5D3I+A0m47rC28jB741ASH7IvJtiYa
         hD0gwZtzpNw/w05GC039MuH7U5nFI/jC7T6kmWIdkPM/46jt/wrS97CpuefmRnN3Q18U
         GtInhRd0J0OVBdsHjbttBu33CVZDA1dd3MAFebGjT5G3tU+iV+78NBf9qcoGfIRiRVwZ
         RwH/xRO5MhreFkJ/yIgb++8xdMOQqOmjIv3XvYKHa+pHsA2ob/7iSOS2SN+AoBD0jjR9
         9QmyTbTwPgCLforYl/+nTXby6UEV/13cUP0SmsFDVO4RAszp+UwxE4nqXZOo2TIM+AVf
         B3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737484201; x=1738089001;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh47sbhBkhnOFM7hc3tO3sny/2UZwRiDWNjSfYgQwow=;
        b=qnMN/J+zFMfiNJAhZ6kBT4zXI0LwazE/arhWQ2+XAkPpvwfS6b07uWCntL/bItIeFn
         9oxeX4/mJPekm0j68+KBbI30rwclFJdVMxto+z4WchR52Zlq1lU4iY/ZDF90z1rKbhFC
         mTxGeY3SFQm57Xiw6XEfdr+O5P0Sl0h+I3ULCUvgG/rJc0NfI2XOeGaXo6HfnXngIzO9
         VHDYZGXR1sjrO/fb0AhDcDDvUwmBSOybgN0mikGeg6tnFKX67qElUK056jyihRIS+bOc
         t53YOnJY93BSCasuJLCQFB743eoPePXWJNhgTJzetH2Bds6kaooWHrZN+XwXwWcBoHYR
         gpKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2BpfXbgLfXc91esoMG6DJDM9qm2zIivjDAvLgieZdlrc/T8t8eByfmp7+tqL1eMjdCeZeUe4J@vger.kernel.org, AJvYcCXZ2K4yNsU/W65SdkkiJoG2dMB1GRf/AYy8NHKQeOFEUuZPOaI/iJzuSOkm15PBJYiW/9136f1h8rAJeG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0qXQNgk8TuDF41tBAfC+7WFvNF2RbOnUsIme6lD4HcBxlnah
	1tFNiyd32K2NpAymV8v7k8jrNF/CsiEKE5bBdRDXTEcJX1KJLAq3
X-Gm-Gg: ASbGncv0SnBbqdeD30QdeRQfHvuI9aEqO4z4el7pwtGdA99aQKZeHT0Mdmm+Ug/zJQq
	DfZtiRZ1KaGggaeAriajAG/xvloUcZ9uqxyVfsbRxl+jvb/8icQXBGcwf3VRyL+tNY2qB+sZWVB
	AD/ALPFKAfciRsP5xc/u2TqdbAtriUXBfzr+antD2goL9vAauoBd/zpEzrEhOHgWsqK6RKbQXnF
	EpB0tUxm00OiqwtItscXCX88jbh0l05y55elJ7zDmwF75h5q1kxkuOXF96WwVEEOTtd2yp1uuYg
	hYLnu1zBgNMqrlx9sO0tVA==
X-Google-Smtp-Source: AGHT+IFpnp6zXXziD/ch0fbPFm84SczsVSxBkEfBF9GcIwu4ur0suMyBrGb5I44oQYGXqHrP+45bCg==
X-Received: by 2002:a05:6808:831c:b0:3e6:22da:843b with SMTP id 5614622812f47-3f19fd30cf0mr9520809b6e.28.1737484200775;
        Tue, 21 Jan 2025 10:30:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19db9ebebsm3125883b6e.43.2025.01.21.10.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 10:29:59 -0800 (PST)
Message-ID: <910f9798-cb69-4c00-9980-57fe799b5a4f@gmail.com>
Date: Tue, 21 Jan 2025 10:29:57 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/127] 5.15.177-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250121174529.674452028@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 09:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.177 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.177-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTb using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

