Return-Path: <stable+bounces-150732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F5ACCBC1
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32DD3A6124
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91001D63CD;
	Tue,  3 Jun 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GBKS9zv2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3D1A0730
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970673; cv=none; b=M3tLCZpX6/ZqZFzyDyMjqkL/mFOZlYth4KJoMeweeL0UX00ZQ7xj4kFXtKCatLQis/3lWrluaYFUZZHZ+yJ12/oBuSLzBb/9UZJf8G+A6MNdnTIhnPsxzz34SL7ssKOcT231qy8/xnKCVvdi+XQQJ/XWUt0BblnXOUCQiGkz5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970673; c=relaxed/simple;
	bh=aQQBhohjQIsXAAA8OWEgSE8iiPBsicB0x/KzfQnnE5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLQPiZSyggnGCZb3YNt2aDO4GjiMDsNuliFh2T8bq8LpWrBCb2yerJ2QzRcLwbqmBcHqn0RAQfAcSnhdPF56icWCKd6wC6Qo2LgIOFfj/9pF8oOqSdVYCCUH4A+u9ESaVaDQXyARF5WU6vNVswisBQRjN6b+FFXbB7BdHTYaMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GBKS9zv2; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-407a5b577f8so716023b6e.3
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748970670; x=1749575470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ge/FLJ6X+Z+KwzpsNzy53QG41bQPIW8972QpUYS6LZE=;
        b=GBKS9zv2SqhIBcdEG0TuhFcNIq8/TLhfNhSiieU30WEvvZWhbo2Y9aqTHbRKYXg5hk
         v5snZLVY9t4MYzVS3eFF2ewwSHlrmyjQhy436IhAAYS4VRSiAyG3pXJabY/OOs79DBmP
         DmRDKS+ACgwn3VD81yDqBTzS1ZR1kBmCj3OXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970670; x=1749575470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge/FLJ6X+Z+KwzpsNzy53QG41bQPIW8972QpUYS6LZE=;
        b=XtdSGLOI36f9dnfKgky6QLGgvaeVeCzLLqHRqCiWOLO+FmVrEe9YiSv8Ld9PeK/M1p
         vOPzbxVga74LI81GH6lfZFmhTsyQkgoDE2ZbizIJ4oUBeunIfjR49esuSmplQ9uN76MN
         vhCAv97ljmnJzq8mbmHTWPReBxFYMoJoLwOoH9O/+QaFzk/YKYUEnPdcnB3MrgRCkFWi
         SuAdT1/nyFAwcY9CxNcpYi6UIrnjJ6yZwaytYedTqtOsy279FLtSotzwQNAIxg/e5yVD
         e7EMt2SufHIlriDJspnyaUZCpFblcRYbQ9uAfDFAdhAGOE9DY1M3+CX3daApOpRW0DQi
         9DJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXxsSf/WCuaCS8GEKRpxapvI7wNz7Tifi6gSvPPOevfYQbnYQFXrUdyeGT+C9loqUdX+CcWRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIEBgQp6gSPYskTdWDJ570a/u8Avok+8KaaA1JF1WIWPhMG0U
	545898vC1g7cCZ0qOMDHIO0ctLOf06fBJQubKE+I9RCQ0dcBuiMjWVvn1scCujxfIYXd+OtCWXX
	ia6l7
X-Gm-Gg: ASbGnctNi7bqRWAnzShKA56W6OzVFAtgTtB/0ony6l4kSCNWfwrRj7B0TndqzXfnf2o
	hcX4tWl1ONKG/0HuM9ewhnn46Ak9cg+nJbFsrShFMWjlnHJSA0wnFfFBIJsPTt4W3/g3Jl1RXC2
	3raEjkb4RjabhK/l3RHlbMrvuFsCLO7jvA5lOSaUmd7xkCTRFjgvJfNGcregUzC0ISVHDPUTQjz
	bsJwVUorWxuepW3BFI7p7Uwo2Ru1MrpbQmZ8yRRP7tuJBFQBRk2wBtgDXNLD50Rr51btZTiyodz
	FdmJyXZiAOXJkDXA+I2MkQFattKphTcd0JY2Qyd1UGs2vyU4BeMYQu3sOKDxqg==
X-Google-Smtp-Source: AGHT+IHan2FSKbS0x4O5vzploOaIxfhJ7Es6upmUdxSGvzf3ySgMu6gpZ24LXAKPXHs/2zci6fpapg==
X-Received: by 2002:a05:6e02:4416:20b0:3dc:8b29:30bc with SMTP id e9e14a558f8ab-3dd9cc15926mr127450175ab.21.1748970658903;
        Tue, 03 Jun 2025 10:10:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd9353d994sm27175185ab.18.2025.06.03.10.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 10:10:58 -0700 (PDT)
Message-ID: <bfa7e3c8-b497-4b06-b7de-db6f97ade6bb@linuxfoundation.org>
Date: Tue, 3 Jun 2025 11:10:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/55] 6.12.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250602134238.271281478@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 07:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.32 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.32-rc1.gz
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

