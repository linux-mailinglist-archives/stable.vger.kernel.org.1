Return-Path: <stable+bounces-154584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ECCADDDCB
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 23:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49493B18F4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628542D130C;
	Tue, 17 Jun 2025 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F7ThKIyE"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E52264B0
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195056; cv=none; b=LZb4/I8UVlEhQrK1GsmRpd7oTRzLNSq5GBbxFyB8oio/BlJnUf3jH1xGwHk2d4sAuVddlMziEJpMBGberCzinCsNykT/6jngTsfcsZ1QkHwCZN8T5GlVuY+ipz1HbjommZ4h8f89fFmbPGht8ZDOYClFmUDxalg5Vh5fZQtcFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195056; c=relaxed/simple;
	bh=C3zqzvgxnqkEbq6gbzY5/vJOF5ioN1uUUpyG3ec7Dwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtPBzModbeGfENAAQ9I9UqR1yAW91qjKpmkBUcc1vTISHGb9Ay9IFy274NLTS5ZMpEDDgE3G1uA+R83fXjbPsd9TBqrAyNkVtMQTYTcSwyFkL6+49kFOFIEzadnAr080jCU5XQEQUfPe6iN65OSq5llB5mbkqbF1EmL/ulSCBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F7ThKIyE; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-86cf9f7abc4so494274339f.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750195053; x=1750799853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3o2EErfEHnz3hmNQBgh5TFWazInBuO1PKdU15xcdgw=;
        b=F7ThKIyEVePaKLkoeEVUdQTxW23Icn8gtKbD7mHVSAOVw6dxGefDiiSUC8OezMd0lK
         UOppLtppe/HXqYks1xgrdASr3bQDd9VPVGTfo8LGo/uYSWetXmI1Ye2mftD+OgC361F6
         Ze2LixocxkIOT1eZJjGjTvMf8MM3SLJDapfa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195053; x=1750799853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3o2EErfEHnz3hmNQBgh5TFWazInBuO1PKdU15xcdgw=;
        b=XOvPApxa+6xqogNGSwsa1UTb6GHvY+PnapPmObQAi5jfrm5xNArfHVIN/0l+eYsj2D
         We4VfR4F7IB3jWYh/Xwpd68JnSbdVXMGDrJN3wPoPxMTYESgAwiwmTOkdu+wpVrd8nSk
         2W0dkWKmHiRFI7++oAfpcsmLG2w4uqR5slcEyQIj7U+STSbqVO9EPFBQTxpXVGNBZTJi
         18oRtCT9uhlCZRBa8qA5bMwuLe/I/fEvVT04PTraO9RvQsFdqeISABG7O53pWfWOZjrN
         jsDX1KNk4hxZVNBB+HyJA5uCkyl2kGoiFULW10moUjG4rpFqDylSt7vSIODyrfFsza/9
         Q12A==
X-Forwarded-Encrypted: i=1; AJvYcCVvtyuIA/0xDg4U0jAYxxD/AaGsXlxZSPqh9+NltpMh/G2yseaDejrpuHqxfZ6LkTrdIsFDiVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbat7AbuEpnGE95voXTU232pzekZrYtgljFlqJxy24vfD2EYom
	hbEP5rAFbKgO7s6jBpM94iacq13CQYmZhdEmhM1tb7ZDMstTyFa02GKjop+HtwJ5IJFm4UUMea1
	3ONQu
X-Gm-Gg: ASbGncuXQhxq6DX7UDztjerXgapkR/MD3FvG0St2JRn5hDzLGm+6QRKLUkqZUrOgCsI
	seR3e7t7iomPGXgVa2AfKWWaM/fdECADPEaE6Jz3CCvamw3cOYvD7Umf6MdiXQFSa7mKwxlYEi9
	LcCJMyLp2ZKgTH076v9tEfV53iwh9OXbRAPL7IyfcDcvkY6gZI3pzsDTgRNNmCLvNUhppDcFYKu
	GKh+ZVAVwBpWwSaGEIfeCVy/TUmsI+Fi88n8nnoyMGiiDDZlj1hqdgv12VRHmlR3XObeqlBiQov
	984mZS+LFcAERqFmkbA+suLzksydIPvFRhrtRxHzcbtc0kTPAceNx8SkI4OkW7SWmwrY4q9liQ=
	=
X-Google-Smtp-Source: AGHT+IEBgMyPOW6hAMXcdTuzK8RVSxmS3n+6K8lB0g5WvUu0MVvxKgSVKQVBgJhZmKEfgPNtN6loXA==
X-Received: by 2002:a05:6e02:19ca:b0:3dc:8075:ccde with SMTP id e9e14a558f8ab-3de07c272dfmr162449005ab.4.1750195053421;
        Tue, 17 Jun 2025 14:17:33 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de019b4406sm28236045ab.1.2025.06.17.14.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 14:17:32 -0700 (PDT)
Message-ID: <31757a3e-7c44-479d-a75f-baba2d436658@linuxfoundation.org>
Date: Tue, 17 Jun 2025 15:17:31 -0600
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 09:15, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

