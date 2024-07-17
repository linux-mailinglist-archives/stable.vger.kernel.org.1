Return-Path: <stable+bounces-60454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C6E934005
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 17:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE32D281DB2
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B61E87C;
	Wed, 17 Jul 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0hpCKu+"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3A1E536
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231477; cv=none; b=kBe+xDfrUYwFrfWz6zuS3PjTDaaz3wMQDmaEFBYKEU4MOqMPMee6Tm3GidiMUvd4VUgiSHgk80vSsJtepM6lelmFXro7dnszt+bzCLLHWK/ekCFqB3iSbXxBS6O5oAoXzM2rNqTuDJ9o39IbfDhiiR0IYZsLU+lea9qN3GHPST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231477; c=relaxed/simple;
	bh=RT2E8IgjQ+esWzustcQ79s/43qy/PvDGd2M3admWG6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYkk6okV/yl8JBC/jG0VhVX9cnTtqogj6DvW0cRpnliMmBXfjK2NkVMhGj0L9P6+Qth9zKreYW97Ndg4g1O0F6uU2r5O7KuSaRTArxPHTjlOzm7oKtP2rMmLSjcPXQr4Ni2wqKVE5QvlNhEVAK1tY8dWz2cwrcw8bJP/YTXHPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0hpCKu+; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f906800b4cso4589639f.3
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721231475; x=1721836275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYnYtQtSATBdLSe4GSr9qVfw3Tn84Itp/iiWILaybaM=;
        b=M0hpCKu+Ihj7msdLyUGbaLGGxU1hUq32brJ0RpPwXUvyB5IvCAH9JzrmECqb0rmXCL
         Ra70cSS4Vzx49H3w51G63HY9zf/5f6P0Bexdb+uYO/TrdVY8ZnItlYGNBLShhOHzPjG2
         GM9d8gz4K3ACEY8AfKXIlXCnGOG/ogUsNLOpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231475; x=1721836275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYnYtQtSATBdLSe4GSr9qVfw3Tn84Itp/iiWILaybaM=;
        b=N04qmLdIxP7PPfgWJmbZPnZUjtudT3Kdtw2QNBzsHafc1IA2j+8Vnz14d8x8nGRQ5F
         1PpImIqOkaA2A035QhoH526XIyYwefCy3j70gwze3YQaWPtOgpwQNHiYGYNebJs16XYa
         6iCofwXjLSSxTe9pZh3IiKKypuQ60CnRD5N+YqCSoZuPeKcSWt8rWjKGi3/cJsDKrS+5
         NGL47xG8UbMli/+AWsNPKbfzn5lJz0hIIWaw6GKdUnDgCB/tRJiYYw1DtddTYCv+Y23T
         BeKsXLDGT7Tt/9TlQfTu4ZcX67Ba27Xb3VYOGVVN9vJzfwP0I/tCV80BMIga36GZJBU0
         4Akg==
X-Forwarded-Encrypted: i=1; AJvYcCVxNuOp0RFhEInkbT6qQFiRfAJ9OMDSObDkH3fjcBbjV3NH2yZpK57hSaKuFdKRcLZrIR61E8I2/65MlcAQTN1YImKPQQU0
X-Gm-Message-State: AOJu0YwrMmOnMTxLZTr5Fz+/kim6tumq0bhsb0gTa+EPwv0B4UYdAq1z
	UXaixlvwfFvdUOdjYBlxoBkMpSUIVcQJuZh+FZYxnr3jW46ih3eAVt+R9gJ9067ySi60aEUK0Jq
	5
X-Google-Smtp-Source: AGHT+IGbmhAM61xxYTubsIKvFuOrqkQMdiMfd0yDLTqmjOm0hPcVfZqtZOkHALmz0YTX6MxJcCUh5g==
X-Received: by 2002:a05:6e02:1c23:b0:395:fb15:280f with SMTP id e9e14a558f8ab-395fb152a5emr6780115ab.1.1721231475239;
        Wed, 17 Jul 2024 08:51:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950aee02b7sm8378585ab.5.2024.07.17.08.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:51:14 -0700 (PDT)
Message-ID: <7cbd02fa-cc6a-4dd6-bf97-2bc6b5e14646@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:51:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/96] 6.1.100-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152746.516194097@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152746.516194097@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.100-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


