Return-Path: <stable+bounces-144141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54971AB4FC7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07693AC940
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079DA226177;
	Tue, 13 May 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHXFY5q6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE52222D3;
	Tue, 13 May 2025 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128592; cv=none; b=M5uQqvSfbA3NzmWFj62jg1yZtwNHupD9h5Vs/03VlkzogFdFth926MlrPumFX3WXnhgsqF64p1lxInSEhCpZn+KZGBtFS9WHC/t3qXf1yvibaoM/8hAlo/6lM6Sb1DtxAEWeLt+JWFzwUPyw5nsEqy5tGCcPF0XUfht6XN8Dx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128592; c=relaxed/simple;
	bh=lwuNQzkVZY+r3BjYV69YcvGsn1lcu7z4FuHiHAtN86Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCLI80sOik6eLMuVubliYvW19Ck9/1+0ozsrG2svG7S4Gq+SfVvWvBZqChd4b2/G9bI6Khb0rDmgWVcp94WlIySiGYmm3YA5IC7jAUlWD8cysVZmY4WMJ9BpfmD40b6dkgg7GwXXan+AUhM6VrNwRm3Gn1DoujXaYr3QmTI/edM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHXFY5q6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22fa47d6578so54305625ad.2;
        Tue, 13 May 2025 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747128591; x=1747733391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g0FbxF4j+yV005ArDJfZEQRtUEXUG2HW1Azh2TjM6qQ=;
        b=JHXFY5q622JRys8hWA04YDSoY1yTn76eb8ONcjs3H+lfD+MJgB3IQrdmaBkLyOF2yc
         QEwdQ+ebrg1OWe4SKEWckJZMM3jS+Hn1Cbbso8jj9iSbudNk7O3lXag/KVMR9uSjOnLW
         yLBfEgQjaRt2Qge+0+SyUkw37K9fNKb1UQF4KrdylCIQD2FPR5NpMxZZWo0c+fXztCU2
         VFYVKlrscLVehulTsQK24Xjdug8DEWgRSBKT/pU12oUs94JlLd5Wc/k3Q4ceJGZ6bdCz
         DarzNTBbOtPkRNdhZCCXzxn/fATP3hWxBFl0cgI5rbgdK6rZ5wADHvfTe4Al10/BNvkw
         dXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747128591; x=1747733391;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0FbxF4j+yV005ArDJfZEQRtUEXUG2HW1Azh2TjM6qQ=;
        b=msJHYVh6r81ZRre9zVnb9ZrBxT1WgN146+gk9dXaZRRqLZSKtQNAtavPJmL5DBoNFx
         zNT2fYNk3GOAMwxD+PLcS4LkN7MY/Q2zKd/pU+ZOg1h7klGUxdFNPtp7WozXoZGgCpna
         x3HsinfkrS1tz2FE1KBfg6vzJaGpd4+4vnwM0vwCuQf3GpAsbQNG1v4Ljw7gZ8ndoGiY
         TYJ65ffTOM1FkA2lTcpaQ9FOPqPwD7zahga38G8oCnN/DhBMTsCGufHJ+T7AnERyEmC0
         Rf0mrN/cYeXM8C0ZAepBwiNPiHErw8U7FZuyy7aJkbByuRCwNtk8msloInA4FwEMGP5p
         G5yA==
X-Forwarded-Encrypted: i=1; AJvYcCVX2QK4uk9n4HJ/wgozwXommXOyfMhnvudjbIVilkYV12Xy0au9OaSOQtfwiFs4IDAaNhgbCshM@vger.kernel.org, AJvYcCWXD67elpysVFaXkpXpU4dg4c7RitNxSpKWS0z6enZHetJUIDpN7Im8YaRYbxzz+xu6UMXTv6ICRL7FzGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByk7M2H4aDb+A+3nZcMb0zk247udIE/YjeHdfuNo5/pNsfg+1
	MWwYBdRGT2wqNT0QfmweR7yLWoLJoloigMYkV5brXFBKQCWP2WDe
X-Gm-Gg: ASbGnctL/Ub8doPI6K3dKCjR4kweCPmHvfNNWS4PkSPU3kXtZPbA9H4KnYh+cSSdQ61
	gvRLAV/zyntNQOk/A73P2hIIlOa6Iobf4mjQGjmVeQpBB+w10KwueXstAkSCOuGEyV5NpE4CXXf
	f8JrgihlZx0hsevHLFqBuHor+6MSEe5jG/BZ2ko1h7MVcaRVO19teTPZciidgT3KmkBhDy4MDhd
	vQfjInGojtq0JsbCalUK56OiPVOPYyoXfBvjrY9zBydtFslu7jHGbgScPQ3gHvsWqnhiNTTsT7/
	+6ZlbOBC4Kk+MT7FhsLoLPzcLlCIfwNAZ4/BjiihJ4RBJGsTiOAesgZvyG86lUEu5pRWnL11aQr
	GhAWeQkYaOUTJy4fNxiEnp0arbP5TK4Mx8juPzQ==
X-Google-Smtp-Source: AGHT+IFajfHqbu4LbEcFiAzWJeLvYPulEit9SQtbrCnulAq3KRzKom7xG3bcmHEz+/YVp29nrxS5BQ==
X-Received: by 2002:a17:902:ced1:b0:22e:4db0:6b2 with SMTP id d9443c01a7336-22fc8b107f4mr214961565ad.9.1747128590674;
        Tue, 13 May 2025 02:29:50 -0700 (PDT)
Received: from [192.168.1.24] (90-47-60-187.ftth.fr.orangecustomers.net. [90.47.60.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742e1dsm76849965ad.78.2025.05.13.02.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 02:29:49 -0700 (PDT)
Message-ID: <ef73c998-fa93-4681-a87c-ef9dcd70034f@gmail.com>
Date: Tue, 13 May 2025 11:29:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/54] 5.15.183-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172015.643809034@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250512172015.643809034@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/12/2025 7:29 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.183 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.183-rc1.gz
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


