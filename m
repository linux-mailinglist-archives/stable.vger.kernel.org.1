Return-Path: <stable+bounces-86367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079E499F38B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 18:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859BC1F2467E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AD1F76D4;
	Tue, 15 Oct 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY+0TWdQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF71B395D;
	Tue, 15 Oct 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011542; cv=none; b=Dy4EspaIzHbNiRkKPvs0//CUl5mFzXoa4EWTKYh2HdF0FZ/z3xVkIOlRztDPO7GP9LCkVk3aHsS4bjhA6owKU5vToZI0xibDBhV3s9MrdNL3rn2LH9Y7mm3+DugKy/JB//OBZgHiW3nZkzsEfDATyTYDKxaHm4Ue90OLg5nWgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011542; c=relaxed/simple;
	bh=LY5e0pfBMmr0tPkR4EG2dK6KAR7H+HJXuylRHOHfVHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3Wt/3wfnOGJuaErEdZIlCXYASnQ/3E6j63uoqQwD/n0MDoAKDg+3pmZNi7lrDM4/3VCvEseBNqZDMkFKiO05cIzoZn8vmNP6jPr3UrhDgDLX/YnLgv7JLYoIrDC0Zg8a9hGUSWjmO2IhmD3IzXlyvZ6pb3fGRNWG+w5oJFP2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY+0TWdQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cdbe608b3so20671495ad.1;
        Tue, 15 Oct 2024 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729011541; x=1729616341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nyu1yPxcga80diGUeU1x+jBa6MqXXN56ZF4anC84dg8=;
        b=SY+0TWdQmUckrFQv7RP2vUn9KFiKAaAw0rRGbTdm8t1cxkt1s9dB3fsf9kSPxE1UKN
         BEZ8dFYt/nbXGwYWvQURaFgKZmqMCTWwTR457/4MTIgv5hQBpv/17s3NP2fPNUQ7/sAY
         Iv0l5Ng1Y26qGzYo0BJlWEZFUBR8k37816uyjTEX7Xa4Ftxnjl7hgycA3nz0GUK7W/Pk
         K8U9qQ+1DM/Nw2XlieIW4uXlClqLAab/ui9oR+TYETjUwZ+snPt0LhGvm8iy+M31/Qac
         aHsliRIcvrFWlvJH2ZhT0xndEjQdCkP9kjpzhH/XkVjFm3vGdJJNkuEBoZbwWfhXe8Im
         v/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011541; x=1729616341;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nyu1yPxcga80diGUeU1x+jBa6MqXXN56ZF4anC84dg8=;
        b=RDmu0bDpu05n4Z/svmM0JPXkdvZLwDYKrKgFMtMPiiOzvT2MlMMK4umH5QImDM63SK
         qW414RxX4DuQYVWKkBmzvz3lt26UByS2hiNFwE1fzgYoaXiOfJNNnA/HgSCwQ4b4APX3
         2XBJpvHMOn4ZJzBz++RNkS91xMQ4Wcyqdw+1FJUWsYzLMZ2A9ZytEM+O3xIduexDHHkh
         HjtZZw+xnG5725aPoAFxrEx21C6gcpdO1VUL9GYmEtPtd23KTYh2N+18TJVoxriJhhru
         MUpPwpQbpoG36OOJXL3RceNVQm7TGc/sKNnGG1g09cwxr4agdnFfj834+rv7nZbURa2a
         xcnw==
X-Forwarded-Encrypted: i=1; AJvYcCU9zvYIsJmnI8quHfSEol5ZPWM+S4w2GxEPpQdrzklkkwrz8CHXMDQe7LSAzhK1vDXXHkOeZROZstuoFgQ=@vger.kernel.org, AJvYcCWXSkDKHi5DHmdtR+QZ1O1cq6QCjlukh9NvGVUP50NMeFdY1PIDSZCQM2kCAiN1DWaQYnrRrQ4a@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHaWTPeaNlCjDXF8H9z2wk56GUsniVFjbm6OK4+zNIEaDXihw
	IhqLONbuOL5zaeHhBBzqPKFqeadD83LcBIur+bpSHXR87QKxGfJ0
X-Google-Smtp-Source: AGHT+IHV0tFJdUiIYlDZQ2wtXoPwuw82uwdIRX9b+Z1vIYJoS8UEESQskRXQie271vF5zEQYB2ZtBQ==
X-Received: by 2002:a17:903:1c4:b0:20c:2e3:7139 with SMTP id d9443c01a7336-20ca1487b6amr213194235ad.24.1729011540629;
        Tue, 15 Oct 2024 09:59:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b74asm14189875ad.219.2024.10.15.09.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 09:59:00 -0700 (PDT)
Message-ID: <656ac3f8-be64-4275-b0ba-7d202515a2aa@gmail.com>
Date: Tue, 15 Oct 2024 09:58:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/518] 5.10.227-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241015123916.821186887@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 05:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.227 release.
> There are 518 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Oct 2024 12:37:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.227-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

