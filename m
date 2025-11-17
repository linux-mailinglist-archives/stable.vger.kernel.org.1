Return-Path: <stable+bounces-195006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E285EC65B3B
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 924464E6B86
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9F309F09;
	Mon, 17 Nov 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcqNt+Q2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E612DC333
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403892; cv=none; b=UThAFK3sfxqzTWR3M4SvlytaNUzihhovJZWLtYHlG8fz2ogNa1FOt6FiIe4Iw6mCW32A5RavHuERXuJnEa5OwbuyvyU8coNQQ+7RhbiNNgH3/weUiZ0w+qlM6kg/q1s5Hi6sqRHlUJ86hmDJFIqGYuznb52ZM/HaZMYqEOvUNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403892; c=relaxed/simple;
	bh=nWCu/trDXxW3B6/TdLhIV+Uz0Gi8HCcBzS/dDDfVyo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apHbaAPbyD23u1qYWA5XvXHeVTDQ0ehUodJ0INcnaK3qIsIQR7+Y8veEcuq4g9fQz3AzK7sJkLRnPtPorOizYK22sgMdzcCFzE3briG4wYADglWHfOHA5AbQmmhhGXaGXvHIwWy7yr+237eZ67fXFB72LLImMZWMxMFy2jzLvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcqNt+Q2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29844c68068so45705185ad.2
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403889; x=1764008689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWCu/trDXxW3B6/TdLhIV+Uz0Gi8HCcBzS/dDDfVyo4=;
        b=FcqNt+Q2idck+DBtgoZ3TB/pzPAaL4UGOMJ3lgqtOFvxL1WY5//093nMGUnZLiTPAD
         CaEV/A2LVZ9+7i2otVJ4CqHzj+Oo22ZNVIPc67J9VnV9esQJKaNNXcm73eHkTdNrxET3
         aFWsyEbf7/ontf2C43x+IjyLYVg29n+kSB2j4X8MBMflLsfxPzmHoJyvxIZPlpDVmj/B
         yaG3Ls7W2JZ/XHKoDaEvDzuJP+0LeLxGkxlZgoszVw+SOH/I1rCgMZOXeasRnjvos9vX
         UXQPy33ZWZ4UT7a3buRjwdPOdT8AiC+Y1o6JB3Rp2x/xukOWMPvoHfgTLcW7f17ZYOw/
         tP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403889; x=1764008689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWCu/trDXxW3B6/TdLhIV+Uz0Gi8HCcBzS/dDDfVyo4=;
        b=obI/BLVU7lcczk+GgqRFchLpjy7IHFZdrfQ1bI2ox7UJ4/fvWWSTTGUF6THiEm+e7X
         1MVBQP/6smq3yWmysf6ShgqVgy99gGLCgCxcj2dciHgmuy6T5EdFz2mp1TYIbl45a++K
         zmuvJ7L0p8N3ewqzO4301cKi7yPcEr2l8+pn48G2friKX64RegnHSgZDCgtC9fx6PQem
         XSe5xjDgSQ6UaXGbuWt9ZJXFDAjnYxPKHv+jhnscGyAIRh3Du4yby6FoUNV+JGOmh5vx
         ovyawx7ofp4Lqo/EHFOEr5V5sZh14YrRqF5aq56+IK607JTd/KKeuIvnO6APATxC2z6I
         T6iA==
X-Gm-Message-State: AOJu0YysjjcfWBd5mR97gNJTcGEhck8TarLdjicqh96ZOq/GGRLoFvlW
	EcT81W+rq3GGG8H8IBqH+WoDFyLrstYSwOTye173xrNpunKU0W8Zj69t
X-Gm-Gg: ASbGncv5jikybSBbTprnfZQ2UnmnH1CgdOtrIkoF/85F2M0Eov8enMQDxTnZ9ZPy1m6
	QBjN5138zhKysS0cC9df2WnQS9z56FK09WBRy3tAp6Bg+zxrxLVrOTATkrVBoB9z7jozmZiq9po
	ZubUWuQV5bp9VnR4AlrMNfPCD+Ivjkpffqs6TfVEpghMRjfvlizlM4f15z72xjhM1DIN42883Wv
	ZxhzTW9MIO0WT/fGeR/SAQMZOcx/vgQQxnddjzul6EUKlqlVpwuX7UhDiC7gYfXbC39KoQv+yAo
	r/Xtk2gRYeK489E14h5NYzA9O0Lu5buEytu0nCosj3qUC1SJlCsOo8xGZvz236hRgkgmCH0nz5d
	ALeRCVueWG6egoTVSH8PPhz5297rzxc7UVbqAQzu3eUTN0Y1wmMNVDVFoYR1fr5Tc1T6TMgzgvQ
	i/+/m6nCyz5FwggqCgc3sW6LOQGUfcpEoeUHqUS6wKGN5rKGGdkGFv/fLgfyT2q2qT
X-Google-Smtp-Source: AGHT+IEK8q3p5oP4pfUxQfOukfrlZoR2lHYhz+NqEC4HfhChKVyfgw4XYylOJ904KNqTUysQtBRSdw==
X-Received: by 2002:a17:902:f550:b0:28e:aacb:e702 with SMTP id d9443c01a7336-2986a6bad57mr154027305ad.2.1763403889484;
        Mon, 17 Nov 2025 10:24:49 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:9e41:3032:2fa3:743a? ([2600:8802:b00:9ce0:9e41:3032:2fa3:743a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c24a5fdsm147730555ad.43.2025.11.17.10.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 10:24:49 -0800 (PST)
Message-ID: <62086c8d-ca48-4d97-bb73-e991ecb3523c@gmail.com>
Date: Mon, 17 Nov 2025 10:24:48 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rate-limit capacity change info log
To: Li Chen <me@linux.beauty>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251117053407.70618-1-me@linux.beauty>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251117053407.70618-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/25 21:34, Li Chen wrote:
> From: Li Chen<chenl311@chinatelecom.cn>
>
> loop devices under heavy stress-ng loop streessor can trigger many
> capacity change events in a short time. Each event prints an info
> message from set_capacity_and_notify(), flooding the console and
> contributing to soft lockups on slow consoles.
>
> Switch the printk in set_capacity_and_notify() to
> pr_info_ratelimited() so frequent capacity changes do not spam
> the log while still reporting occasional changes.
>
> Cc:stable@vger.kernel.org
> Signed-off-by: Li Chen<chenl311@chinatelecom.cn>



Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



