Return-Path: <stable+bounces-191324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76897C11940
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 22:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862791A20A60
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A402E6CD2;
	Mon, 27 Oct 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3rMXqmj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FA2DE71D
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601868; cv=none; b=Iu6vBScO9Tu5WSRmldvNo2eAa/250s/hztWeYOQwf64wJuvBOywH9M1KzE7I38NT1oJgGOmLKJxPUEQprBmMGlSzGlBDuf48q7IyS+qdSkDr2dfObB/UwfdhGqNN9K7sIf4kjpT/rJw2o0FzgMU7xR7/K69i2iIss5b+yMCj73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601868; c=relaxed/simple;
	bh=c0b2t3qnr5HsGsKFjLxBwS4JC9oQ+YneowGykdOhJkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsI0ha864dDvh8fYmC2iqgmLyZLvkK8UuZJxS+nSoP41BBSErcjNgCrlPqnoq3uIFAH2+S0X767kRAJFqRnLJ94QsDjQdo6XS1ptK1o4SHAtZN49F02oHBS8phMCyIy3ivCr5NddfWZqNovAosN5QVp0mMheQkf06Yxo4wfm3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3rMXqmj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-87c20106cbeso77620156d6.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601864; x=1762206664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrREd7iHeiHOSpPNpoHh/ywRu6TBc92FEkyLuBrGSa8=;
        b=k3rMXqmjMAXg1XE+pGT4zs7rFBSsjfh5H3TBBy535PWnwreRSYGMiaG5dfUKIdq/Ov
         rxU4ir5oeFc8EzFK7eN/Z1NllUnG1RCXSVB1qxE4d3EoAjUCMzQdctjrpxuwL0+rpMxI
         +Kb6Q22Iyk0Sc/NhUpF3FgjQ6kDU0ppUQ8zYAFEDWnq5vC8dp5PSJgC441jMTbaahCSV
         wIeZQpn2S9NUcJuBMiokOdvq6mIhTkPOm7eUrUhhV49M12IcTDoftDUa8A/+BeB3Lj0K
         K1kVhbxUu4knCF2f6qBeUFCHv3uGfbT6athxeU0SSolA2zX1SBpKzjdfZw+0vUSh2IUG
         lI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601864; x=1762206664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrREd7iHeiHOSpPNpoHh/ywRu6TBc92FEkyLuBrGSa8=;
        b=fYimKesvKbYXtoORDZBWI0OynBMJi2zliMHyXsjjWhZUlrrAmeTi6DI6g3rQ34OdxE
         dJGUlOoKPQWdCz+e6l49M9V4z1ef2Qn8Dqn2iERqitQ8QPP2xVoeuBcpeUV6Zl9G2Yn4
         lyM3NXRJ3LUZ5VODFct/6pga7FtbIloabgAi5NJ4Fx50Gn1AmusbXHVufFjhgJz63qBd
         xJJJnld6c3C9xTExTa4AKxcC1YZJUVlHCtNNzlht2ULbAbCaDhEYLGEc1Mn//Y3PQ2/1
         OUMu+kumJjKjjzwPzXttuvixJ1WYmw89t2HZUgtngIEsrWfmnyAUzoctVWszXfYMl3aA
         RqNA==
X-Forwarded-Encrypted: i=1; AJvYcCWIZZETAVOaouJLoQICrBasHCNu923SiMS1rZuyxAtdaaGU6bJyZWYJzbPiKjxRcFk42ikB+AA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cG9qAfc/RXtU0+u8+MzKw1W+PWWwGYcWHsvrXarjQyaQmBWT
	rIX4+pQituSyGmTZg6AV/aAY67IWqMxSdm2UQY+GQfAe1BDswhJ50k93
X-Gm-Gg: ASbGnctweqbeozvCNv1aETBpBwtJBl4I6RYjYP1apWWM13Orvr2BG3knQ7JWHZhbINb
	4UaZOLFdIQgT334ZHXsgyW2AO4pyrrfHHD6A9+/BsV7S77QUSAuJsZidUIjiLIZ5gkFQ/mZTTdw
	z0g7YVX6r/ACbCW+OwsltSfDKcWgrIDqdWS645lwvx9xShpXWCcUV2mmt8tUQQ8NLKtyPpYFvcm
	8iAe34HK0RXGW01pa5SDFsrTXavPrjL1dls0SLrJPP0K/qhqbURZLXHn9zBu8qAAzuQ/emqvPuQ
	1qHWpUmSKme7wiI2TAUdaBd2/yIq7AOVmcYuHCQ5dMLb5myMO6/Rca5X8ROnYl1dZ60/HZm69gf
	WoqLTn14ltzyHxRaOJnivA+0ZmD1XyQNApXXjW3dXtw0FDP8yvV9/C7jIvl+JHl3hRoOosxCtMO
	JFcjlI2o689Zd1eTUWay3r/eHW4tG1i3RAoo62yQ==
X-Google-Smtp-Source: AGHT+IEwMMAsl472wJTKvmKmtOeEVAzkmf55c6RANBm4nkhvEStvP0PtCn8QQl45Mv31CE6MfxiCZg==
X-Received: by 2002:a05:6214:2122:b0:87a:aa4:4b47 with SMTP id 6a1803df08f44-87ffb119637mr15831806d6.53.1761601863876;
        Mon, 27 Oct 2025 14:51:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48f7323sm63559206d6.29.2025.10.27.14.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:51:03 -0700 (PDT)
Message-ID: <7cc00d0e-1cf6-4abb-a3f2-e96e30cd9128@gmail.com>
Date: Mon, 27 Oct 2025 14:50:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183438.817309828@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.115-rc1.gz
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

