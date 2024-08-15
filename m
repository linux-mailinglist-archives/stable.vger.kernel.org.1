Return-Path: <stable+bounces-69259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09307953D07
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 23:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B828528849D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118B1547C6;
	Thu, 15 Aug 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOyrCfp2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC315442A;
	Thu, 15 Aug 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759175; cv=none; b=YC17bBhON1yPOi4yY6tI5XnoldkOtWP9+XjIDSgJpvXeN748MnszJWFJS5qK8KE9/CJN3D6Wy7IelOnLG5tze1pQgImkhaPt+p2HHFErVVV/5Ygk/apMk3uf0WR5UNLgKeAI/C7nH4NI+9+ksOdRLhY75rlXALDJTwCBL9aCniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759175; c=relaxed/simple;
	bh=rK/esUI2zvQLYhcVj5TnR2iUyYOWNFYJgeHXx4x5oKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+k4+E6TrHmzupBSmeeBIFf4LCO20oP81ioFi8vbNzdPsPiowCAeMtDqYsJzGFjHV1rzaeE0NGOYGLhGSV7BAr0oiysqneQaTOPMLUsApI7VGPU7E9IwpYXxQaPNGaXUstnOOG/xkkFdMFHu/HziFjWVfJJvFFIVB7f8EycXFCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOyrCfp2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201ee6b084bso11947835ad.2;
        Thu, 15 Aug 2024 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759174; x=1724363974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyCVy6/conWBhY9JGn6L9AtFibyi83h6CoL5Kafq9P4=;
        b=NOyrCfp2p/8860dS5epnYrhlTBBHVE0GKjluk0/ao4OgRW1LiX1XtIKUzWwhUY/TAM
         bs++qlN/JSUkH0WykYbuy6efHSDKagEuc7qNDg+f5V/13Gfz2b0OVcgv71AS2DRsDJn2
         PC8/jSd5yjmgFALcGaO2rrHegmDZCANSK9sD88ajigz5SALEE043qj1+R4XATlEa4bVY
         lIQrYbKm/8Fw9Fo2gQVhj2uvlVzNhDFxWpcK4GQpSnlc0kqlj+faGrYH2o9AX5ODLIVF
         2pYFSYlTjsgH+v8IyaAHoPN0AzORJcHmqJhRLbZao+RNNE06Ub7C6DdPkQF7p7zMCxh9
         niDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759174; x=1724363974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyCVy6/conWBhY9JGn6L9AtFibyi83h6CoL5Kafq9P4=;
        b=ffPRu3I8jeUqWIkrlrM5tb50IKhJfMZtEfrFzSK3255yva4UKmkhvucmoaSEH+4/X+
         JeD5xwBfagjqp1bz8lFkw6AerGCO7vdDHiX4CMOZFg8kHXNkX1I1Syu2JBPclvb7eX1/
         9/fqhPVNp+jET/lMRFpdz4AYnd/eKg/bpPiXNgiuC1VzsJuAX2uITcAy1KLvlb3AYs7A
         4bzhJ8JmreaCtZuO2ufenPtXTm+6JHGQex141DtwUlL5tLV0YRSkliJvwSgoqSCTHtUa
         vI26ucq14jg6GHhYUCwBU3QL9P+SxYuCsoMO1VBhImlgIWPWigKDALzdpDQ8ivz9fvow
         H2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUX4ykSZ0PHZJXsBTm4TF8j3aJ5oLEkGZJTniFG3TFVsd8l9KSnoHDnKOtJ4EraS9yHt2SjP9+5Pvqc7/zne1UCyn6BM+l2mzFNF63eWW/TrxNpky5sfQlR4rf8YQmoGGgIn8nX
X-Gm-Message-State: AOJu0YzgADaOVfQ7ADelqd6j+aC9AxjAjYXYrbfrW6o/bAE8rKt1RgdB
	iWjJkxq1ZJKpYq26fDZ0M5RNwN0atrghRs/GtZaeiOrtYclS2Uhi
X-Google-Smtp-Source: AGHT+IGKULXVi6fLxnWIIPP4BFu9bhcEGVkP+X0nnciCIiVVwfSOC9wUt3In96jhiXM6H6Png4gLyg==
X-Received: by 2002:a17:903:32c8:b0:1fb:9627:b348 with SMTP id d9443c01a7336-20203f53eb2mr13430475ad.58.1723759173559;
        Thu, 15 Aug 2024 14:59:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f031bd99sm14549465ad.79.2024.08.15.14.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 14:59:33 -0700 (PDT)
Message-ID: <840e5ad2-5baf-4c74-b3b1-f18affa4b39e@gmail.com>
Date: Thu, 15 Aug 2024 14:59:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/67] 6.6.47-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131838.311442229@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.47 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.47-rc1.gz
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


