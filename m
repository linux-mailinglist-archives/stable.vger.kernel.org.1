Return-Path: <stable+bounces-191323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA98C11919
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 22:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 805A94E1DEC
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B7311956;
	Mon, 27 Oct 2025 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoJFj9Br"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E92F691E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601234; cv=none; b=meHpkFE/6drbhnBEC2+9+hLeEdKN5Y19bBDqfVS0h59S29VM/v6ZJ7ARteM+6pQaXVmmo7QMJrIDw5QVQgq0LZYzhG+2rSRM3e8PjaSRCizJxNzu0ZgivPkQ5d8DyJ+ZimNAjnuYS8+kYOk85jR4uSDoqcdJk+WibH2Tl96/ZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601234; c=relaxed/simple;
	bh=p7tIlPXsYZ5Avel+J+izx/jHKu3N4qM4abUQEluRedc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQRV1Ss1Wh6xPqJaxs3/QRHKNtBKhPYHgKGWrz99DPPr3dAGLRQ5DpBE5LD4yA8gpq/HjR2n7PopIzxtU/kmrmcSuHXFPm3vZbwrMWuVmfljx6jplyRubff6FlAe8FR0nh+ngaIVqCju8Yo3aErZwEQIBivXjhyBwADYPCQ7zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoJFj9Br; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e89ac45e61so50331851cf.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601232; x=1762206032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omu87Ze+GCEablLZ5Y1kVHweKQ9CM76WnBDADZ59AOg=;
        b=PoJFj9BrUNPixQ0Rrx3/GAtim4BqYW6vxIxOEHRFp063fh1ZBIJ35ERMGQvqLMqq5M
         G3UN3jY7tdvSsg84MeYRVzeZmvCfwxaKZbo52nQgFJoaYyVOHLrybq1M8m4GlrRc5Vyl
         YCiEvyFnD2a+A2IjM0uzIwr10H0o/FTGD7J2IT7F80WcKjB28xCV1MzUYv1SgG+Ar8IG
         sqLwlCCoKQPTHDfgPj/GnChfOlgd/YOYI4dmVv/Pl6ciunkAupUjo2ZAgXTQu21Mxray
         YNOeFL70HAZnSLWHEiyH+nEgKdxoo4YGXtvXAcb+GH8Mch7zA+qDPkQq+YazTt5UNmfV
         FZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601232; x=1762206032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omu87Ze+GCEablLZ5Y1kVHweKQ9CM76WnBDADZ59AOg=;
        b=ppggHR8+7n0ZVhjG9paqoVlNrO5qERv1S7VSU1jxquViM2FoSsBQ63WqAiDfwq25X6
         oxLSTb5+r+wRZRQ3rgrFjbxl55L0ENIxhUGqN1Zdp8Fr94Kbu5Hj2RWWYz8iI0LYjPhB
         Uil0dwCmt0w1bKlWX0eOyAVMu8aDTH3iRVzljJVKL22S86mjDYadPZ1Fn6COobjXzZJK
         lYo7gQWuqUuRi1gIzT/GPBQPwAabGKasgQ1+Axu3jhdupjHa0D8J/jpo+dXW8a3qUTTR
         DLfdGHT38xsZLHYRfeoxxQbmwkgS8VQ8tckkSZCPUFa9bIpeVQ1zxh26dencZSOfzGMM
         xP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9ELmjCOV7kg4dFKx2573rZB5U8qWIbwbfg4nWX5fhBPcUjbWAFOKAQJcccSRceMDIxxsPK6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1z2j//UXMHqJDN0h+ClONTniNJTyUGvFHOka1kiS8b7i7Zty
	S1vhOCRnNtF0HeNiCO/6vryTPbVLyQHOhHDr7puE6iCxCPjqOUhWqSaF
X-Gm-Gg: ASbGncsxArbRlo2ENFX4FoW/iN7ODTw/hKoSUevGdI6yF07o5tFCfT41gXnBS8pLSqn
	rt232g6DyaLAW0pmAcdE0aCcUC5EjqNXhn1p1PjvDV8JPMf2nRWK7yBoMQvnF17E41/JkOP40Ap
	EgOdR11kzrDwGHHZWOIW5ff9B3PJa/tWCTaynXmhVtT7Y9AAZx3vnzeRm9FRq2Y2uw7y6nocC07
	QhCf3GgXQqW8aZr3PZLgCBpAegY69hoaT4dZT7PFklbwd+NdwkdpZvjOIRwQk8AL7B4GT80AQpY
	cuXT2cF/NwI3oXX5nkCSriZNJyGces2QPPN5VjpGCOL1mBdHt6KSLJTXfxh7r0aGcJN/e7rw0VL
	j7/G4aZ2vrfFgM9m40a23rvtat5tOoGw7FG+X3QRHElkxT8WChztvAApwAgNIIrqTiYs9UuxjTe
	VJ5XJ9tsQsloc1b3P209q35tgRJlcIy+k+/KJ9eg==
X-Google-Smtp-Source: AGHT+IHRMBR5sjtlPhpv5oFEsUc8g9V/hwydBp726BZW0B6O5IgDfBJOEDvIgpDlBg09ewyz074CIQ==
X-Received: by 2002:ac8:5d08:0:b0:4eb:d83e:2e71 with SMTP id d75a77b69052e-4ed074bc1afmr21527911cf.18.1761601232179;
        Mon, 27 Oct 2025 14:40:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f247fce0bsm679653685a.13.2025.10.27.14.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:40:31 -0700 (PDT)
Message-ID: <47ffcfe3-f9b8-457f-a336-bba4b7977a44@gmail.com>
Date: Mon, 27 Oct 2025 14:40:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183453.919157109@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.56-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

