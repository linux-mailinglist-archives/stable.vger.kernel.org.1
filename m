Return-Path: <stable+bounces-113953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2ECA297D6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 18:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6122C169ED6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 17:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C31FCF41;
	Wed,  5 Feb 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmtDKr5i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404191DDC0D;
	Wed,  5 Feb 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777284; cv=none; b=PMMuIpBCVxFtc/1kJTmnt+s2r7HeujwDemrhsso/yl2iT9g+ySVlVRKK5o24Y4CEWiQAACTyvGtxLkccxGzWkIIsnU1VEiYK6IO5ch/KMVC2aUPM9odyhA+vTkGGCIzrs1kykh/mxxYE4QIo231ZGwjjOtMKpnUqRcZFXVivf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777284; c=relaxed/simple;
	bh=qK8LCX7OG+Lpp+lf+znYUBF65w45hd7V1sPfz9dedeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vpi5ttOZ58AN87PGOwUQcB02SyC3umeouEZ+S2SJ2XBeRMhbulbpAC+sBQG/NcLc1bYN8T32IKW/tuDiNS+TcL7DwD5Hz/yQNsQEUAFN08buTurBIrQqilp8+oyf6rWByt4Idv1lkOE5wfYGgplvRAPjVov9a+zQcaBcH3h0qwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmtDKr5i; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-724f4d99bc7so24769a34.1;
        Wed, 05 Feb 2025 09:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738777282; x=1739382082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P2I+AE75ayJRLzPPhA6yQrL20xtvTEfMhQVZu3c/aYk=;
        b=CmtDKr5iQ/6N6KJx8rckQ7wNgbQoafT+1evmVs+ZcoLXg40G4FOyGGUX9GuXXY5kQy
         VbyQhSeFi/h0VWcFWdHbC9U5tmSYY0bb2tdu5NkgwKVKgn7KezokHHpndKvO/rI29Rcx
         zY0l4nVmFSqiLPORhGXiLl91tpZb0jzfnVWLFSe/lJa2UlD6Y01ywjTx6aWRs4iZ6GvE
         yKnboBZ0A2z3VhvHLAMAGwNh9Revwl1DYdowl/XvNDPOsMPET0Qe4kWX8WXzwFll/maz
         koLyWeQZOArehl2qkBu0V3swlbcuLd4SS5TfmrT+2GmSbob4BoOAfI9OrR2SDUTdsICB
         CVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738777282; x=1739382082;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2I+AE75ayJRLzPPhA6yQrL20xtvTEfMhQVZu3c/aYk=;
        b=cWQo6PtZvD6DcE5C+qUPVe/H8VJMiES0FS7pDSASt+1oYLYjTsLTv5bqvSgT5E1zdW
         wNWCRmm5k1E1OpdYAL2TlbAJio1+Jo6VBXyJMvCGaS04kPfScMFUQprDLOv47GRa6wbx
         MON/yenrrGCDsBQrQmwmk+7NeJ1kYnu/zHpjnABTQjpSWpPgmuhAvGXQSfJAtCmb59yn
         QbIELsV0Gtg9RbMWAnMpnhtTRTz7/Jg6WtE9QMNK831Jq/9cZ0dhUfvw4SwhE2TYCBUg
         X0HCCajOWRKlwLna8FHs/ftj39ikH5MDE/XaZig8GO1Lzrm2awNH8MpFRC0fkzqG3KjU
         MipA==
X-Forwarded-Encrypted: i=1; AJvYcCWIjr49OChaMthdQBlSqJ8kw+pj8PjSwprEUPoPF02s4x0tz7XeV1Akt5TaxTbDNI2rLk2FVty/kacUy9k=@vger.kernel.org, AJvYcCXnuiM4wrINJRmwFg0LZijbecQQF7B7mPp+xlZTEh5ekjZFHvb8k9uN4ljJs7oJXROE4lkp1tyo@vger.kernel.org
X-Gm-Message-State: AOJu0YySiHbWIDDoZiGFFiJ+xQWNoQ6tp87uA5GJHUOcy4ISdm1NZVmP
	oxqnOBbCrHDuf9/SFA2ohwUWotEdqOlSL4sYU9aR7awzILzfoq4T
X-Gm-Gg: ASbGncvZQvV5gKIWMk/rMZdMwKXYwSs9AEgDta/+s/AH1RnRpxfcMGl0So1hiR0Y2LH
	4RoJKRQ2T5YzEqKyBd4cqQbb804ijwBtcHFIRvCzPwPL5i8Q3hmC1twLj85jCCImMxVdqTHLwuy
	655GlxOPhLLEFTTH+ZWnnoL3xDoT+zWe6c4Xg51PiJAHLT1136stmeNCDemhcKF5/ASJgQGSka/
	mmxSfG83pFe3f2RBZRsUMSQXN0nz6XKKRyiQbRX/10bjzp2m/SyPDSI+SvQ+3kcpnmGgUnSGGwN
	mYHnVocyhzqjuinNvtctsTmi01SxnQfJ/3bwa0Bdjwk=
X-Google-Smtp-Source: AGHT+IGCCV/djrPhG7I/tsvKJyINrTjM5vCqp5TLh0vkRWyb8yypfVuYrOzfffZkTjhGbkE+Rnh/iA==
X-Received: by 2002:a05:6830:6787:b0:71d:4624:3f45 with SMTP id 46e09a7af769-726a4251be0mr2737150a34.18.1738777282035;
        Wed, 05 Feb 2025 09:41:22 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726618ba0acsm4019345a34.48.2025.02.05.09.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 09:41:21 -0800 (PST)
Message-ID: <a3756bd8-8595-462b-8cdd-a39a7bce3f18@gmail.com>
Date: Wed, 5 Feb 2025 09:41:19 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/590] 6.12.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134455.220373560@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/25 05:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.13 release.
> There are 590 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Feb 2025 13:43:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.13-rc1.gz
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

