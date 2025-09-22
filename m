Return-Path: <stable+bounces-181415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E81B9381E
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 00:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 534F64E29D7
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 22:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9627B4FA;
	Mon, 22 Sep 2025 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC08TBCY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34A199E89
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581314; cv=none; b=Dro+ZPrrBhUYmCfvpVeWweUiGbFCRClkMf4/lO5ruUgFsIwj+wKCQTC88JrADMgg8FeUSvA/kNWrFNnJQhNToYoGeIpqfWX3mrjTZket2jpWz2Tu+k3JyQY843N4K2o0fJ2Mezg3trNTASneyg0wNPBCE3lXxrWO4inqVO2H3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581314; c=relaxed/simple;
	bh=2Z2tTtspoe5psrZmrmmvyzFTIj55orHfEAQOmXO0Qiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBDX+eck/XPl6QVUFHruTY/2JZcv7uvxm8qFS2tnJ9FlGOcnOAnPE1coM0e01F2sWJrQ4FBdKryu2Xx3D77ivXLKXUg/ouVLI8UIWfCA3JwgDLN07tWDr53tG118RMPFMoXjxNUjX8PUNQz0WOvSy63Y6fZvt7zORTOtCIAD+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC08TBCY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-279e2554b5fso11116035ad.1
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758581312; x=1759186112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLU0RdHoW7PoANfhukGPTAXKBWaFmMBiRRNW5pcWh4Q=;
        b=HC08TBCY4k81rro3sV69umSmch0BvxfIBsTpd/o/ELCU9Od+LjVmxzd3uxc/F+TZEH
         tvrt5KvvgGfTO2Bm68j36Lh6IE2lHA4Yc75MXG56JySVWf65+6sWFX0IjT/2gbBsTHOD
         p/Qj1rPLExJpMv8pf/RIn8McciC2+0dMv0uRj0hXeL3yivq76j5vnDrA2p5RrRF11LTS
         WeBv0lSmjGBAoH80PNgHJ7i9GRFdeKRNe40SrzMJB4zdGlDGAOVo0PDFxkhmZ8Yx7fwV
         +mgJvM8CWSr7N6/CtqJDUiYrW3t4cwohCZngNpVTKz9tAUS43wtjkBAXlWEtvLBZ0M4f
         iURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581312; x=1759186112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLU0RdHoW7PoANfhukGPTAXKBWaFmMBiRRNW5pcWh4Q=;
        b=bUap3IiNHIFLrgQ/5ZraI2MGsZJ6DmCxi9flzppaiJo0Ks1kdYVksFmyo4mfnBdRa1
         Fu6MRtvW5Y8EltSgS+yc38rNafVmSA6wnju7ZATorCDQOE1boofR2H0XG9boOxQJB5DH
         dqJbTpSLUIXUEsA1Uegpiamj/4fOVfzQ5CKiPO8tWisWEcbjLZbgOtkWCyXUQCfNEcZs
         HwjgoOilWoUcPOcwo6EMJLzW3LCpKpWm8IGG0lK75MXs2iwWoKK1TGxsMIoeGqpMvUhC
         dEgF7YQGRiO5lGUwZ2HbZCnlVxI75+Uf6oz7ipuh0RMDUtrd40AJUAG5MDHrN0xmBmI9
         ueew==
X-Forwarded-Encrypted: i=1; AJvYcCW3txjR/fgCV4/QhbfERr3oWunZk7Rc9Yw/1XAX+hlHnIZskPiNsVtbsHBZ9/XW1i4mGzn/rNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3MfI59iwMuXxjhGseqnc10iQGlxI+DXh0WAif5mN+HVG1faW
	RX6QwFyJfTZ8I9k6tapBOyn0faIygM+Z/nMgdrekC+qCleFmN8CnL4IR
X-Gm-Gg: ASbGncsf4N0p2RvrOgjy9dm2pbewnzbOoTwAe00zci1tjLf9TADFfo0P/0KWlEOPCxZ
	xjcrmhMk/BrzGCOmtlMZbOiPLKhK3Vbsl2SXX+vDEO9LxcGQKxUiUBLEOEHlXs4mKCDoerpUt10
	ZSaWx9FueQMTsPFuCgEmgD2MD+jVWIVC+LtJIiGTFiF60NIntYsBPVWPLWJJDRGozbTuMJRCOB4
	qM1E0kip7Zs10q+Hc8EFFFtLuDkp+Ehz80OIV/qLZpVGDPXlUs6O47nrCDRmtej/3vU8aob8IYd
	o2tbOsMWHvvpn4VQwUg7uPyfLvSemCTaVvl+oegeRz/nG/1BUVlX+tTYiJsLrJ0UusXm3QF02GU
	0ITfJp0GUvTCIAGjKAEhhDXXw1EAAL1qvJVQy/1YJ+xHSIKj2iRNVfL2HTo5h3pQajsuaTqjdzf
	oVk6t1r8No7M4sz7G1BR8=
X-Google-Smtp-Source: AGHT+IH+XQhrEjeck5jGys4mBDO15ghzcFF7hUwWuk/zDaYKmd6hNMS+rOvtx2mxlHZTk3VSN760sA==
X-Received: by 2002:a17:903:1a30:b0:249:71f5:4e5a with SMTP id d9443c01a7336-27cdbbd1124mr3539555ad.26.1758581312340;
        Mon, 22 Sep 2025 15:48:32 -0700 (PDT)
Received: from [10.255.83.133] (2.newark-18rh15rt.nj.dial-access.att.net. [12.75.221.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980357043sm140133185ad.138.2025.09.22.15.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:48:31 -0700 (PDT)
Message-ID: <c27d2fdf-0c99-41b2-977b-cc9551084fd7@gmail.com>
Date: Mon, 22 Sep 2025 15:48:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192404.455120315@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2025 12:29 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.108 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.108-rc1.gz
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


