Return-Path: <stable+bounces-106152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9B9FCC27
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BB31603BE
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD44513B7BE;
	Thu, 26 Dec 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j++oy//U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0C13211F;
	Thu, 26 Dec 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735232704; cv=none; b=fh/U+O2IOnBPN3J/Sor3+T8CTyrsGuckhp8il4TuGtNGd3IybC4mk8x1dAKuKFzbKh5OIItsJJMy9AT7h6cSaIbCnlXn94Mb3FXMdBIK9pmJigfDJldSJcYV++ybQOs/BPZSpey+098kk8oamIRce30RXmdeH8eIw562q2vgbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735232704; c=relaxed/simple;
	bh=9A/6PzajXK5v4MXEyYgp9WroyGXvmy32NVlSU5Sq3SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkvwJOKAA71IAPIbBgOzhbHHLcKBjdacBNUccR0Atu72E9vOPjNx0DJurkzzoh75rp4A7zAutEQJ87H5Mt55FRoWhFMXJaB3PGFyAmuCJ8FM+131dqnmn1ZK3y8gafmdqxOpeJZOEiV+BPywPLJWXQIeaPJwtydEZ6XKIwnEbMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j++oy//U; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso6037118a91.3;
        Thu, 26 Dec 2024 09:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735232702; x=1735837502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shCuTrBPFRV6aWt1Qyudh0OpHYaMP1Vq1gdc2qO8gV0=;
        b=j++oy//UwltSAAwv+dC86HMzW6lbE6MTbPB2P9UV4UZdgShc3x8zBPU20WLctJ/sia
         wYE19XsCFx6W4u2L0zoIswdOo9D4F+x+hxFUkOEOKziX7Q3ZrV24ULNGXsFUy0E8sJu5
         9NWlSRFF9C9bPcoykcDxLeqqzzyqEq+nNavB5jNwHHEbr6mx9u4hy9iACkit9tUBn+8U
         rZPKkX3vaNXbeyu0edBEVQ+yul4rJytzm+tHTp0dhinLzkf14W4bP+XPesaaBRWxRB3P
         2KQtd9i71KOqVMJLSaOmUY3LDVMEPXFD/85XCXbRZHcROMB9MGtax2eTatreRz62Np8J
         ARGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735232702; x=1735837502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shCuTrBPFRV6aWt1Qyudh0OpHYaMP1Vq1gdc2qO8gV0=;
        b=ulbnzuM3z1edWbEMQKI8+cvjLRyTnLCoAIW8+z0AqxsXDyixMPW7L+TRRz6gfSUawT
         XW3Y31acNDcCoJvGmG6PC1WdQZM8xWUxv6HhUMtOYR94i/6O0YyqPhyWepzMf1DhkIDh
         6GhgKPkSDH+ge7S/jpuk0ZmHxuGDN99jRM/w0XRLDC0Wg2SPWzSMqLDoiw/ICfMBmRec
         cKWc04/4j6nlfMpsZo+Ci8GWaXyRoEkFsbXeXgPMa6em539us3VV/Y9emR4gyNWh2jn0
         nY7OAhn/v2bB9UzaczsvNgA42qdMX09zKMA3YGaI3UkLhFLPleD7Y/KHyiCTC607elUt
         VWgg==
X-Forwarded-Encrypted: i=1; AJvYcCVr3k0eXGiChX1oIeHRb38ncKh4MDuO7l+F+OhvyNXm0oIoCZKrcOi1b06WQKcPKzvewDQmprFUxCughL8=@vger.kernel.org, AJvYcCX19mDkHAxIXaKxDinB6ClDGfmdg7bIih4LSXyzHWs4eOa7omQ/C+Lw3cVrCpkgQo4XkqBgcRtG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjd0akk3DPVgyeBVgQwyLHtOZytR2/PTpx0zoHborkF/VSnnrR
	49M2q+ieaP8PpDKbFGlXrQbl5bIK2jwncEkaxikF7XyD3c+rb2Ib
X-Gm-Gg: ASbGnctJn9nOIfEVL0Jxv7lCDjzmAYn4PJcPyNOXCtGGEsT6DRb/sB/p6sk5AveCx4+
	BJaACMvS3Mn55R7luG26zKdrHcV+E+WagsCh8TPv3S+10ATPf24Vvv32S/z9LAUJStEaWaclVxO
	D6SE4CWpDrgk7bmNOO2kUAfAfeuK5U5hUFurkm3+4m3CCNcgRdYFn9ImLpZy5PP//6eg+BK2Ben
	45/d3BgAYqOjqkp6LGX4oiQla1Saht9Y8gYPxOPKhlgC062erTDx6Lus0o9Jy7dPfzcCHs6PFt4
	U3fRISuH2NqfrBdbyds=
X-Google-Smtp-Source: AGHT+IHh3SDf8LNdeKDwt2IlivkjP5Ho4QllWL86HnVR8gf2ESMAuP3EwvrFYqQqKWrKagwtQj3+7A==
X-Received: by 2002:a17:90b:2802:b0:2ee:8358:385 with SMTP id 98e67ed59e1d1-2f452def795mr35817629a91.4.1735232702438;
        Thu, 26 Dec 2024 09:05:02 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26fee6sm16143662a91.53.2024.12.26.09.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 09:05:01 -0800 (PST)
Message-ID: <69070f57-1f7d-446d-a77f-495a18ba5b02@gmail.com>
Date: Thu, 26 Dec 2024 09:04:59 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/116] 6.6.68-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241223155359.534468176@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/23/2024 7:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.68 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.68-rc1.gz
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


