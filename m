Return-Path: <stable+bounces-142929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5943AB048E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED651C049DD
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2271C28C006;
	Thu,  8 May 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApeXQDUb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435628C03F;
	Thu,  8 May 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735924; cv=none; b=kmDefHM2n74RbNI7bGetEArqkg7U3bHo083ECgHwQL6Sj4me6/1+LIdbiywrQYdpVN+/rdYXbDorKLNg9tuYfO96zPlL3e4zU8fzmFYxz9neMURyFe5bCsJgpIYSi0R/lUPQsQTpIfls5RuHwvE7Zj3gD4EeNCniqDlnRLLWX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735924; c=relaxed/simple;
	bh=MsJOMVn1vxQ25UIx25I8nR9qjt4TSlX/PtY0sYN3QZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgZQpkmDXbkdZPyUzo/0VFOe4GYZX+HewtVnXsljwK38NiCXrgHwvCpFDHLmsIBSrISAc4n8lWiKHJA6F7nCF/KVusSvMVtmZgPUt6CgdMxuqFTheD7d2epj9ta6VKLyds2oRjOyIW9hF7KSqPvEWOHKzMSqkYnUmc9wkLfpgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApeXQDUb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74068f95d9fso1491483b3a.0;
        Thu, 08 May 2025 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746735923; x=1747340723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2KKhlirT+mOzzcqtCv1gw0CpqB8qUWHpAj5Ser8V4Q0=;
        b=ApeXQDUb0cY0v74ClzTg7uM/RZq7dRVvPSZglA5OAh/xTwtTQIz2+EtM+FaTI0DL86
         AALfyQAd3HQEluLnD7HE5CbVIHJlzcluHANGO1be0lKA3RnlNlf0TAJ94Rgc+gJjvEXV
         HIAdFzEAvR1Pnmz3xAvpmhN75GNcxDd1/mtqYPceSz5R0Op3e/f4D+jC/WMFOYqdr4q7
         oghQwonJCExkDJECwmo8yzw+XeeJiHv+uzQHnmtWCahACefwzSNZ1kFn7AfAyYB3Pmrr
         jCbMoV75+y1lT6xgIlPQ2npLfk9E+kCf7c8Dwx5jP1Ck7ZC3wqR4c78C9feJ+FxfV80k
         lr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746735923; x=1747340723;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KKhlirT+mOzzcqtCv1gw0CpqB8qUWHpAj5Ser8V4Q0=;
        b=igO322CpwoRYvpY/4vvx1fsgjkWcw9E/PlqAVxNvlnjrZYpL+Qm3fiTkep2TdgZLwN
         PuAY0gqw8/wwxXOE+gprwDFkHOaQVxZTedmtYKi+ci30NSeK53We1n3pNXJ6xEGCS9P/
         ymu/5BbU+LRiryH4fYk2RctDMrrc2+HnT93W4XSQSGPO0SVP1CXVvrqiQ0uLKjUhdS/5
         wyHRUBkQcVtrO6LqUS/DCqDNUBfG7cuafnlhAjVCxYUUt8/1OQVq5xhDTT21AuSLtbyJ
         gI9sr2K4oS2KBzkAlegoxWiOIp1EYjWyZdt5tFRkZfnRW7tvE/gfqJ76qhKvWaUoxq51
         Q7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkFpBBW40AOOouWoQgGkJ2Odydr0A5Jmn7ky3psUzLuCyw1/5yA17eue7+mCp2mr1X/3RQmis3@vger.kernel.org, AJvYcCVCTsDinUEv+jxLKWzq1Eimt1fRakpkAEaOHUcF/aQvco+nA3xcoz3TNqweqakktbgpy4zcQNlPgnQ/6Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpc7pSXH7uNgX7Osm+umBifLhzyaimUciwp/H6zSXs4sCpJ6J
	PQh1JerasOMt06qoeTGRLkDHhnzRY+EbAli7hwCh8Pv+JsH94YQD
X-Gm-Gg: ASbGncss6HsgIjqvf6BH6xxeq+zlAVfqowem5GkrbfwtEk1i7s4E4LHOO7GxlqlgeG9
	RhtQ76mtP7zyNuhExp+oTeemRrDPU16OcAfvE2VydICHZ34WzPxM/DxmlQcPda/hWtp5fi3OpiI
	OIUD/KZ+Sjo29juPR/xRoa8hbVTgbVDgTACmTjyqw4MAidVS18ZNniNnblA8jelkIClPa0XpY5Y
	MRLog0yz6m0k+ngrQRvSsUJl5BHtk/jcmAUmNEcUi5WlyCt8KUMYDyNt8WQ1ju8baDvBo46yQTx
	dFNr8g+vWu58/AjuSQ2AffAWL4zbBkT3p6j57Jb1kpShPGUNzkqOKF23fFHjo/xJ7JYkHXWx9EM
	lyg/knaBwFCe3EcM=
X-Google-Smtp-Source: AGHT+IHkcU1/5M2Y+YPbh19OnZdCSlbYkXuOCfgJLAdBmpfseejR1+XFvAy6P48EsXxIs5IGQKWxbA==
X-Received: by 2002:a05:6a00:21d0:b0:73e:10ea:1196 with SMTP id d2e1a72fcca58-7423bd6c3a9mr980529b3a.8.1746735922594;
        Thu, 08 May 2025 13:25:22 -0700 (PDT)
Received: from [192.168.1.177] (46.37.67.37.rev.sfr.net. [37.67.37.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423770414dsm460950b3a.23.2025.05.08.13.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 13:25:22 -0700 (PDT)
Message-ID: <3eccf673-efe0-4feb-906d-ce860497469a@gmail.com>
Date: Thu, 8 May 2025 22:25:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/164] 6.12.28-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250507183820.781599563@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 8:38 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.28 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.28-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


