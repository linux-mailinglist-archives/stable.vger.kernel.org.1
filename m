Return-Path: <stable+bounces-154376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D72F1ADD818
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34B07A6369
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E431E98E3;
	Tue, 17 Jun 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6B3kJ2U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9E2264DD;
	Tue, 17 Jun 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178997; cv=none; b=onpR4uRkrItCbp/GfekwNkZbK6JgzVSTfMrsEQoOtWAHPGCel5DfIN5yfrlvPNFI5HfuU3f6okn6fl+bAS0lVpIex1XFZKvO0pjbQBhedvPGteyawB1XEVBEnOkKoBZbn1aJ7ubUAZ6F57VCaJOdw8hXEX8tCvYYddMmTGgoMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178997; c=relaxed/simple;
	bh=PoMp27oskVu/SCAt5yUxemcUEZfpX08olGOoATzlNQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLdSK0c446hGclUSHB3n5PzwnyYLdVfUpQEiiEome/b6fjrpn1lIeTwedTysDHj+eK2cwHR97UTWi1dZG00Jj5I0B8oXrwn2/usUfygXwV2aFFJMRRu+WAGwL+w/OGZNwcdLQmXV2v8Mq23LyHh9HrKOMeTxXpQUVDcAh2S4auQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6B3kJ2U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23694cec0feso8616895ad.2;
        Tue, 17 Jun 2025 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750178995; x=1750783795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7wUXb4VopLhdBixP2euU7i6YD3GTNqJ4plwFX4HKrkQ=;
        b=L6B3kJ2U2AVZGO4byN0f1C5T9rMqV9UVxWkO4ig9V6x0/qtSTmE+edjdOfPa8xbv0c
         aK1OaxMOaQPKKlYyhgd9vQj5ypBTxAIOZIwwa2kBihV9gF+oOtA89vzxwTPEjbRPXNjG
         ksbaf+nFEtBUp0fnXg5eHMy3eymxoKDGu8FeRUi/CPykS6EM6kSQSCbUu9Q5viYbLgX5
         ieCx6XmWkUVNexSJGftB8wDnyGoJQUgrdTmBPHnZdPxdolOD8bDa4nh2NULF9O/94wRa
         qFOgmv78UZffG1CXY+TsGKaCPKXoe955fcif9B9tavgNpKUw+wz/FxIktVgLOKgTzkNh
         RWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178995; x=1750783795;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wUXb4VopLhdBixP2euU7i6YD3GTNqJ4plwFX4HKrkQ=;
        b=lfC/tqy9lD77OMgr+pU2ByDBCB+Kl0GEh171dbl14BEJLM+GTF3p0x6GecogYBaS0i
         tKmhE8Sl8ePN2xn4JJNSgawUrGlh/R9vF4tbVed0qVEFKv1Ncnp8YnQUw+ESOUtrZaXR
         pxlgFwu92jz0GJyiookC0BAG/c5Nn/inJSca/bftedjN0DtSgb7GdWOfjv0yjv4ifYlb
         tnBZ22fiJgd1ManK3AItzcxZ9cmOJju101iQ+7sdbJnJvu5FGzVK195aSV//SH7OjqG0
         QikIGpaOpWg8lulUnGP1LPZRPxbgxFC/anFxv9O2dYS/z380idyFf2d+vRhmxHBI31B1
         sOIA==
X-Forwarded-Encrypted: i=1; AJvYcCVAK2BVDd5Hrpwm+RMw4hRY82iq7FBUvSCQqKISnYvOFRv2jH37WNlMIgMvNwjw/HDBvjrMqFDam7OFWt4=@vger.kernel.org, AJvYcCWabJPC1c4zYICMDhmGZxUBVCKFLmvbHJgZb9scSLTgPTvhqh+NhcTj3Diop34hS8gs7/C9grL1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wwCUc6h4yAJMC38LehgG0JV0c4gDjjfRp5mSg7FSniNHUvE7
	N3pd99BY1CDNSakRltfy22Y7YYyjen5AxTzbxkWxv4gJOhsNt4zv1x9wTPHaNa6V
X-Gm-Gg: ASbGncsj11WRO0T+93DGOu0ybMGfblYJQPH1udhz24sc1u4yUHNNy3oFFECtRQ6Qd9T
	uDich3LV4vuYujAZGqbQ8HPRGrYX0yRYA3b+EoTTcyCE3AKGci30ONIcubcf77J7qCu70FsH+55
	2s/HjfceMhljSGkcHI8TlKG+2JnTW9y3ty3Lg6OUY6nJwDLggdKzVGpWg/waiQdhSJQiN45cHad
	Nt9PdJcAP1lN0nwHuY6TeYvCYP5GeF4cDNrFy87n7MZq4unyHIbwHdLCE2HAWg3fFjyS6CJGLtG
	LaqQB7KD55MbpPtldMlT3QwMWbLafGXzE7r4cwaG3E4c9kmfjXFuSIKRsvlWi0BjclxscJschrn
	LLU/U0AelagJoCg==
X-Google-Smtp-Source: AGHT+IG2AKukAwLRDN3u53uYznYRhhH7+IMkI9gvcbwGrrPaEyNf3Y7ktarcPLqFpvBLBGlv0xNO5Q==
X-Received: by 2002:a17:902:c94e:b0:235:779:ede5 with SMTP id d9443c01a7336-2366b139bb6mr224634075ad.40.1750178994625;
        Tue, 17 Jun 2025 09:49:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0d1444sm82137965ad.256.2025.06.17.09.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:49:53 -0700 (PDT)
Message-ID: <d5eab853-dbad-4336-975b-45b3947ed793@gmail.com>
Date: Tue, 17 Jun 2025 09:49:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250617152451.485330293@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 08:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.3 release.
> There are 780 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jun 2025 15:22:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMTB using 32-bit and 64-bit kernels, build on BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

