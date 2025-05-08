Return-Path: <stable+bounces-142837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E9FAAF8B6
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 13:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6390217D899
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 11:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C214576026;
	Thu,  8 May 2025 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRQWW4h5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0481DF725;
	Thu,  8 May 2025 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746703735; cv=none; b=Alcn8w3ad7Vn69QIhdVk2wTawnGxKSqD6bOTZkl9IU2xv4DZh9VU4ktrneeggs8AwFE0odhou1yopQwcs3pOl8aXWHnCbmiyTCG52VxYVprLdlhTvNe+Hurdv1jpUYHVCwliMLJFYWiK1gc2xeePBYLG1W6B60s8hTF7AlWfk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746703735; c=relaxed/simple;
	bh=ePVMJrci5a6gsDKgasIReeQ+KmeDWNFbqsiLJWVnZIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEtxh2v2dNcoTu2vnJlAI01mQwKEOpSBP60Ag6j9CyTD01jDk5Tm3fwVEtJIpeBBXoJYajpaPuSfdSrDLVhO9NjfO59OSz/l+C4qoEZeV41G4gOXYimhDlPvvFau6LAWoSsjdSW/5oDSQPJ3cSSGAQpAoRnsMpX1ZM2jAUSj3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRQWW4h5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c277331eso1821533b3a.1;
        Thu, 08 May 2025 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746703733; x=1747308533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ETTo3X24htG3fP69lxT1GJXXIlv2h+d0ANyyGTcXpr4=;
        b=KRQWW4h5GN50/8UELfq19CRmZVjcdmpn0LmYL/+Y7JAmp8nZfu0mzJjMdRzjmnRS6w
         qJWzROEqBw+eKIeuTmcGI0j5CP0MCQfFVVmpndPqenwdnK4Oh/itxhIi9gYDk0eHW12V
         lwdt4queTyGdEzKzG6x+X7JRgsBh2/z6lzan4oFNPklbsCU4Ql9/DfGm92BSk6xpXw+/
         K2f7igDcBeR8IDqNg13A1XoUimVnOasm1qFCOlDexI2BtTTiR6UwVHY8pS/q+npX7Def
         clwCQ95Q4S0i46Zk2HjvVBagd7EsQN5j1PgBmdInAU1em9CmhTnkae+gUzpxu2d6RnOe
         G4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746703733; x=1747308533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETTo3X24htG3fP69lxT1GJXXIlv2h+d0ANyyGTcXpr4=;
        b=LjKtcSUCW7IsL93Q8yw4T8eJcn003vBcfR/IyRq3Ls8sJ713Ow5DhwngsTil39idz7
         wykBg+Uz5dvCI2r7edb//jUY0Shc1a7bvMa1qEpfGkAt2R3BwuPmDbPxuRLmlUV9UFDi
         Nsb/MNbV6UYeAf99SJd36FgC1bHfoWSSahzAYQjJsMILFTWVGtp1vZ/AGiNxQKPJzRcS
         dh54F2JN4myCN3cFdiioDWCeH/T8eDkHL6GH/azSmvO7yAnavfjwtd7O3F04pLrZYKBS
         fXUret4F+gz1b0bVD08W60D/4hr+aZ79E61HL/80HMUwDqZ4x/t6emJetqRltrvW3roF
         Y/CA==
X-Forwarded-Encrypted: i=1; AJvYcCUrUkoQ1tlKnm4You2T8XOyRYo1LpRTyoipOO869nce/VOnrX5cV3Jm5LsUxKrct/TERO3t3Nej@vger.kernel.org, AJvYcCWQrBoqQuXWnC58ECjIVSvCwSZ9GMsRp87hmNVt2xIFg1w8FOGBqqHmh5f0ZUVef4cMKPD1SuaJhFM3naA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83w9mTaft+YehO5MXeQ+6YHmwR3+H6QyTbLbfUvUyxpPVSF1X
	CICCbMZ7otgBuGfp2+MAi14n3AJmqFhX4pjReQDujLV8OpqKABR9QO4AXmp4
X-Gm-Gg: ASbGncvBrPv2eq8XvwaUiVRldGEKuJUC6nvMtpd1eS0u4857YhP2t4J7oawrnOiU3wn
	Q4FDJFQ5faM9LYSlemfbHfPAbL+vFUNgo1RmIzpC8xV/7HUX7kguwRh8HmpPA1nyItJaH5vI+jD
	H55vKFsq5XIeHXL8cT3alK+Eg0Kg3x/fuzDUpyelArmoxyYGicYF+uxXXs7wNOovQE4+FfVPkSC
	Z8/J+nudAnGA/6A/xGpZ/sbv9xi4cMMWWxRpVDzhrQvGb73e8BPZyDmKSuEUIbt4ZN4OgOJb1Kw
	wfk7DxSibg/97xr/LfasjaMJHhUqhZ0zj4oga4AVMDIqc9eavbwGXZSpYQXRCc5TMf1ipWHO9Io
	KtyQPjr5v7vT5p5FvLzYVSvZkRnyIj0rAfQ==
X-Google-Smtp-Source: AGHT+IESHWDY7y5RbQ9IHVL2ng24jwwQsLrxKl/uwDZHB5UuzgZzHJquLij4t2Y1qHFZDlTVL5GdlA==
X-Received: by 2002:a05:6a20:3d95:b0:1f3:1ebc:ea4a with SMTP id adf61e73a8af0-2159a05e8f7mr5284247637.20.1746703733324;
        Thu, 08 May 2025 04:28:53 -0700 (PDT)
Received: from [192.168.1.123] (92-184-98-225.mobile.fr.orangecustomers.net. [92.184.98.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c6a590sm11181769a12.66.2025.05.08.04.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 04:28:52 -0700 (PDT)
Message-ID: <c79dab4f-9a42-49e3-81ce-8fd4a8676a43@gmail.com>
Date: Thu, 8 May 2025 13:28:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/97] 6.1.138-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250507183806.987408728@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250507183806.987408728@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 8:38 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.138 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.138-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


