Return-Path: <stable+bounces-106577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140519FEABB
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 21:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0196618834A8
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607A219CC33;
	Mon, 30 Dec 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X5MDJaKA"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C591487DC
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735592290; cv=none; b=SZB4+lQ7CWWCnO/K7xO6ydeqMcRBARLuCYlnTdnW7iglD6uvFSWiFV8xMNv0QCNM3F+/lslxQ9qqLYre6g2JrRoQ9dmg/GyS02Hu5b4TSbORUWX6g+UQd4Gc13iCtwSDN6TuJLyZiY82zBQeLvPXtHIKTfsmZretMJ67s28Kn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735592290; c=relaxed/simple;
	bh=H8N6a4tWwoPYuLV+gldL2S1ncL9sQ+rodDK1OUz1BiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuGzTemCkfypZPQ+XRscDVETEua3Uy7GsnoIdLAaubjkg1J1iSMU0wmpRj+NPXEbvWGrl3OM8bNFgfoa5N260cxJG3urzMaYOcrRY9PRVJlJy2IlPcGKxu/FcvxTGcfDeptX5mAfI3qPT7rbzy7xOtoLB2kXEleweiRVO5gYnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X5MDJaKA; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844d5444b3dso345841939f.1
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735592286; x=1736197086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IipZ0qQKC4K8cot7QR37D3+65FJ3YdRAftDW4yRG0W0=;
        b=X5MDJaKAbfMjFfgAl+SeRcUHNjM5fyh3Kz7Yj4IWrDFDB84JMQXWsFJsE8XTJRgCNV
         An9aPhwgykGPQhbyUup5LP62rfDTbCt/wik/zfLbvPI8zicc7yX/znK0ytwAwCy3poVo
         REBKmzYWv22PLvBeIRtK4GKboTeAzMhmFY5y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735592286; x=1736197086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IipZ0qQKC4K8cot7QR37D3+65FJ3YdRAftDW4yRG0W0=;
        b=B4kFlgxGeICWGofAND4Ecwvsq30L63B5NyhddhPs57ubZ2pCbo4+B3x5aWgW5Rm3h3
         QiacE6yLDBquqHmAn7CL85gvQUBrmgoqMZ21ZSD7szotKuEwIvCAIvFSK3V3bHtR7AV7
         h2tzNaJUg/aVjof63BxPPIQEiSltfMYTbFBsxNVLe41OITw5IkfL3S7DAfKHFrjucLmt
         qRsuvqYV/2Aq5EZbiuFTu+9/6KucOVVoR7H5zE+MWFP6/80exB+ymO0ssLoxoS0uKGD1
         ZdBfYKJAuA4eACvb6jG3g4Ib3H9c90xK1DDMkACoF+OPVr/e0YDN/eiEjl2aZtv9SA4I
         ICCA==
X-Forwarded-Encrypted: i=1; AJvYcCVhXtoYRY2X/X3AKawWZoyK6VEtBdhLp4yF2mHqmv9QymYa2y6FLY83bNYgJbv72VvAGqlz6h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8VEPS2pfHpl3U+J8eN6gg1QXf7o+fSt+L+0N4WT9NuZJlSkm
	RNlJnaUIulDPvyOVz5xfuTbDFZ5l1Cr0mSQKmhumeKIQ40XR85P0+lK6vk3rugU=
X-Gm-Gg: ASbGncsXk5fSFmUZzhECevCjAweZMdB/OPoMtB8Q1SH7+J2qP5DVbrNEwCcM2Znaq/f
	VnKhFppVEjnJ5yD4t3nKG0yVW7j71f/kfm9leISk84hy6vhqSPr5L2iihvuO9WtLCgR4P10N1eX
	j26r59XOdBpwldLCHCAPal7Z627TJZTcIATGFAqonpojUJmKw889dG9VEDUckltRA5oIamUSIyy
	VYlUjE+SGkfvx15VCGKExI0n1ESYL5ch1wYnGea1N/Yz1rpWTZZJrXmcvn0BIgLlnyV
X-Google-Smtp-Source: AGHT+IGgVs7BldTqI5pIHAqkhcywO8lpEIfYRehE73LDMbpEk46lG6oYiuSlRXYySbFmIZ9MNglGOQ==
X-Received: by 2002:a05:6602:1656:b0:844:e9c4:8bcd with SMTP id ca18e2360f4ac-84988d257b9mr3078453439f.8.1735592286638;
        Mon, 30 Dec 2024 12:58:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f360sm5819290173.27.2024.12.30.12.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 12:58:06 -0800 (PST)
Message-ID: <d4261c30-2286-4a69-8439-3e77138ac88a@linuxfoundation.org>
Date: Mon, 30 Dec 2024 13:58:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241230154218.044787220@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/24 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.8 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


