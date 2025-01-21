Return-Path: <stable+bounces-110042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B6A1856D
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FE31889557
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFD43D6A;
	Tue, 21 Jan 2025 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV6bhKRu"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8631F4285;
	Tue, 21 Jan 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737485829; cv=none; b=rwo7gjO33IylrH1htckVcY6uaenobZygDQ+24hceE2XFc4TZWxBNX+nSCCSyQkG6lkCXYigD18UiGzSQr1aSv8vTnOjYEr8IzSwImmaGpaafR56NxPbLu3NgiEeTmKjymmE33rTK5uSrAwphVY/jdxgJ+bxdyB9SlEhugJa9yIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737485829; c=relaxed/simple;
	bh=Tvw4fZSWyLzSnzvpIl7iBrKkMCoVkohH68kYuAM5wjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpyjzbTBD9VKI0BVc4FYUqj+wwAZ5iu7Cs/F4Ez0GFrxlBH6J/vj1V7wSMnPtgExrvUJSmFFRv47ByOpOCOfg2cRsCFCsos2vT5VkgjLJBOPbyRARwFSqLNI2vxpfNoYceJ6mkdsDhUFSY5pADEhDGhuPO4NUK9zJGkFJHIefnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV6bhKRu; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eba0f09c3aso1734325b6e.1;
        Tue, 21 Jan 2025 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737485826; x=1738090626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eC+WpwSNPwGjygQ8OK50SRTra6qeZjZzzhr3vyFEbt4=;
        b=OV6bhKRuPese0LaxRP29aUSgYKxjjKjadS8T43qUmiqe2dfGzl4LY+GhasosRzPN4a
         YWKnyjg95mwUUzhbQmoBoMX1T2pse3VUs6ldb3ZDm/ZkCHYSRiwUB9fijIJSY0Ti1BSw
         wlIzPfIcdLUvCJwc8WJNoyx5Bt3a0q2J3aNLcRfBg9pM0KDHZN/YXty88YSUse366VL6
         Q/8gJ8g4u+TIalOvDPruMSCdoSAY9w+aiaPoCwZZbtZsXo/SUo5IUZwXh2KwmtyJtPDc
         B/4rs7X7DtvOslTX6fh85g1h8TfRx1Ku3TxzcgscQy7akSga/JXunKifIH2NG+I3E1iX
         +SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737485826; x=1738090626;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC+WpwSNPwGjygQ8OK50SRTra6qeZjZzzhr3vyFEbt4=;
        b=B6UPajwW6PX1kAt6WJ1kGLDxicT82pDfJSq+TK7aK0W/lFCL+3XV/Zj85cKxrsmTuN
         prDQiHllrZXfiX4yMf/S54kp6Ol9EA/9S+zZxJrJn9FSoS5/tCrP2hIcJcI48IhfCtgQ
         9VgtR8uCBRcUG6CeV/gSXYQiP4zLke/Biso3rviBVs8Q76TsowYFWuLkAnV/CryOgdV4
         4PYy9GfmKX9ChVS56QrdD0LIaAiNRGHBDGrr3nouBsDfsXqauqT8kdQ8n4Z8AvEF9sqZ
         fz+VEdMWL3CdRJv53kbmBdgem1zjusHJSz9fJ2ODBSaIh4yKL47Io+rklbzLSmPBfpJj
         iF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5bYmGR0cIDHMAIHzKe/wmQvo/qYbu16iiQliP9GeEKAnzHKB+n0kz7H4L/SxVr3eUaAwAbZMqClzDeIM=@vger.kernel.org, AJvYcCXB5QtOd4dack8LwIPlDLqA5t5H6YBXdIWJDN1EE5m0uWyKufO4vQtLX9ZDw8By5X+ZTIkpE0Rh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BJnnPca9fD8ulsBEIFDZXjqoJKHXeiaW1vFtkFkPI9XeSk3+
	SLbdASVsXgFw9CwFbN6IVhvsKJXBNPngMbHlvrlaT/lk1fnD/nqM
X-Gm-Gg: ASbGnctlFkxf9l8HXxREw0Ors6Q6rN5D770KzaQIz1l9q0c3tEtTosvkMsmUbKn58OU
	hNGNi/9vSW/2SMcazUAU5p6DXVVFauYHaLrw9U8VMvNGLGAuUPwYjZaIAh9ymqp50Twj9v+vTk1
	ueE5E9LDnuSrXHW1546YwY43WeUeNLRg7PfP+hx9oEm3PBAtGJIOfjzG8kFjZJAGFfae4KNAXt6
	uCV5ogdwf9jVEOGTlu63Q4ZutFzxGFcq1/nWStg0pfw9/MT8NNa+fGi4mZMq8NZO8h0BsNn/bHh
	lPJXZR8ARJDBgEtM2wNqJw==
X-Google-Smtp-Source: AGHT+IHnCepBG2g3DkWHK7YuE7xz2m/AChhtm6Cuyuq20AUAOE8zPAooasgxDKlivTwmB7TrnSi/Cw==
X-Received: by 2002:a05:6808:8515:b0:3f0:4019:2764 with SMTP id 5614622812f47-3f19fcc1518mr8976066b6e.29.1737485826567;
        Tue, 21 Jan 2025 10:57:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19da7d00asm3148889b6e.21.2025.01.21.10.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 10:57:05 -0800 (PST)
Message-ID: <a1b3d61f-f4cc-433a-a97d-9209610fede3@gmail.com>
Date: Tue, 21 Jan 2025 10:57:03 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/72] 6.6.74-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250121174523.429119852@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 09:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.74 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.74-rc1.gz
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

