Return-Path: <stable+bounces-178843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C31B6B48302
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B936D189A2DB
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592DD2153D8;
	Mon,  8 Sep 2025 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/6gJXPD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09ED4964E;
	Mon,  8 Sep 2025 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757303427; cv=none; b=idTgfGe0nTN7Qg6IlMBCU9aiLvTpczHQA+BmGhTKExwbJYivQuonQJZtLD/6HTH0tCC58t6KavrbDz0QYvoGpnCke6E0iD2mBxKLiqexQh9i6tWDErL4W9MPDPG8vpM5s/zL+yrvb2USHojRg3giag+vLZFF0iFeFtHnXbR2n9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757303427; c=relaxed/simple;
	bh=hUOJUjN7uZ56WvyOp34yQKa4syixecTF4g5kMWnFvG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvEvpNtldXGvPzVVakzNh4WJHwAuT/8p8i1T6/aii1VcWiynL9NGWk/Ky/FvRCvQEjzJTde/UYmTjwe2jfhIdAwCslU7+enOTZY/3ZEFjJMCfBwUGCcqZllWU8r/wBM4+DUvPJF0zw1qY6Iuv1XBwAaw1w/6g2pXLjrJlXJ4LKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/6gJXPD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so2557810a12.3;
        Sun, 07 Sep 2025 20:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757303425; x=1757908225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcU7raKB0xaPr1u3hysKEvXRC7PvlwZV/t+nAxbL6oA=;
        b=C/6gJXPDbI5OhEWxaPpQYxFW+7vSVWNb7OPN+uWhl/tdICbi7LpmxKLbfEpA4NakUW
         Xdkubnkz9GH+982+sBKOSowN+Yzt0Jc7WJKpy7XKD+hU3CzES7jJaNbJDwISjMaO1vCJ
         qiZktj1iGW4U0zpMq6vUhYIhUhZYVTf+YAprYTQFsdrRs0JRyPWEFcXfkX+pkj+vlaeY
         Opu9f62jibcrqt1FpKSqSQD3TZr8RmBQ/CSOpgwhmRjci0YnjPvOSJSjw/ZtD6pFbbxV
         0IgEq2bLM1akVj3UE70HwM233MATFak5pLWTdIknVuncvasyHqW6wl6wmjPBuEAZ7ngT
         RAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757303425; x=1757908225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcU7raKB0xaPr1u3hysKEvXRC7PvlwZV/t+nAxbL6oA=;
        b=P9uhDPWRThiuI0tbweXCKgB2OdnqnzlVMnJCkcpNdhwURj4bUhvllI8lpgdcoTSGWh
         NZifvUap22Xw/0wphmmz+X6QTrPlt04/IqlZkoQJ57jFpIiLtfGG+4bMlFDiCxWip6f2
         4+cWRa/AAt4mMvyFEnwNN7C3/U6e9q9Z2CrfGWhbgQTEtc/qOKgOb3xuwHwStVV+F324
         ivWOnneYDWXGRMRs+RxBnJdvfdGHi0zWhmf2STrmNnVQ8GC53mYg4x24Y/7Au9QUK1Ni
         uwPL76t+w1gamXwI50ebP7EIKIRSXssZonr/t/anmKzZKyTTis0jeNzAHolcItaaKc+3
         bOig==
X-Forwarded-Encrypted: i=1; AJvYcCU4Zlgh6J7K7BepeVNJ6imuvPdM7RLLx6gVsSOJeIizq1321SRgzaf06EyWrMAOaMaS35WyyVbu@vger.kernel.org, AJvYcCVkmC8oA60TKwrRkVKjC2hsnoI/+snWsshQmSf286jehnXxBGKN68d7Rn+gzVTvR0bkS4+ezoU35iyqtTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+fEB9m+nLszvCtSHitU51uEP23yatW69VsaYgrPLtKZhuL3w
	hv2TtfLTAqE98lgNqwc1Vs2X8xYENmgwpOktADEK+Cmp2E/BxB6OV+2D
X-Gm-Gg: ASbGnctoQObJtg+XRBSgnQELH6nyZzC6GGnt5GTXPFDeuOLLGnWGcB8BX1UPmHD71S/
	tQAWkEWqpwmOTmhVNWdrbdTRbNFIPX2+Y3assCSovv6dGqeVVAQw5Pz8jmUlhgzJkVYjKst18iQ
	15/0VRBlokA3wi/UW7byJPDPU0Mis9ao+YWrsEW0oQSaNDVQ0lOUukwQT99oaECz0K4gtUrxfSh
	O0AmGOsrdENEdjLNgoo7HIKGCWHj2oPaP+Qr6E7zga6J6wyNVQsX8DI8uZaHh0leboh02AQ+ud6
	ozU73KB5VbRZdA44nf4fUwbb0x0HCMvteSYrld0dz4v5F9AeuhbFK87sv/JoJfT8Rcu/n7NFK7p
	vVgxSthGq0LfCkV68dFz4WnR+eWKTm1YZsmoGo6YleOntQiWIcPeUlcc96J0eRgy6zeopkWxUfn
	A=
X-Google-Smtp-Source: AGHT+IE7aI8NDiO3dLx8ia+TD+Op2GcTZb4D3WGE/zuPERgoRDXMR/mu8A35BvvWsNINZhsClG1D/g==
X-Received: by 2002:a17:903:b0e:b0:24c:bc02:78a1 with SMTP id d9443c01a7336-2516ce602e1mr82931435ad.2.1757303424837;
        Sun, 07 Sep 2025 20:50:24 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb34e9783sm111548785ad.50.2025.09.07.20.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 20:50:24 -0700 (PDT)
Message-ID: <2a8e98fd-2904-4cd8-9571-d73484618cb4@gmail.com>
Date: Sun, 7 Sep 2025 20:50:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250907195615.802693401@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2025 12:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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


