Return-Path: <stable+bounces-126593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261EA7081C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D31162D3F
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A251F463F;
	Tue, 25 Mar 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYTVAY1K"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53B25A351;
	Tue, 25 Mar 2025 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923530; cv=none; b=Ztir8JThlBDmicMwWel4qSjBVGEV7f2evViotfeihGEtRzS2BBp6LBYwnh8bDx2lmxoyT0M+uPU/JGSsLSlyLS9cfK3HlZVs/w3EHWhF6ZqDBWjd571wGFmBx2dD2DNR0OoPUZsVFbs9CzGF8mWgSnUGUa0A1oKW0W7f9EnP1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923530; c=relaxed/simple;
	bh=jCGftAdwUvwSjqhvK2JTU58i7utMdfc9xgi/jh8KIsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2oMru7sinXwmm1h2XKrSoKky71tVwWYUQbeSnpNe0f3uBR+OT04f2xGwznH8DCotWhm52ha1tYWhg9i0+gsmt7qHNLFofx7qohiomKh2SmdqCvtFJVEp8/r1VhPWWYOpxTKyPsIbCh9bweD2Lld07aeZx/+vbR7fd+SS6kmOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYTVAY1K; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72bd828f18dso2005451a34.2;
        Tue, 25 Mar 2025 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742923527; x=1743528327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=97PUfAL/8h3avcD4JrjfHb6Spstam3hgf+isWLN1TQ4=;
        b=PYTVAY1Ko8o5kACBUYkAIxNUFeXzPPFDIxjHGYbAIxNtyXjAdkjqCw8AD6j2U2VgkO
         I9JRzHQPzOSpKgCR+sGsKmi2bHmJ2yPFSt3A4ziNCffSRAWNQQT5nLaMt4bv1q2Ix9I2
         nJDfsqCCPGp1wYu4xiPBCtZHowDrFDVgshX7hE2M4pyGI5SybNjnV+Ck1WC1QxqIq+Tv
         TAbIEBJ+JljCn50bndKv8g2AQRCQ+wKDVWBvh4To9G4XHgjTFIBhw4QuiNSWBiMMmh76
         jD5FcRCdfRU/89guLpsnbkA0k11FVxYjYgkDuXoCp/on5qj7tIzqCDAQVX3ORvVKnGX/
         W4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742923527; x=1743528327;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97PUfAL/8h3avcD4JrjfHb6Spstam3hgf+isWLN1TQ4=;
        b=kj7JDkRmLCp0aqBAQWFr/FfRiCJRSdrDy4LofEpNgSxG9fapKr4Pv7VTBDQUZ49XPv
         IcLZU8tcWDi0h9hMvmgjSXyP3r1T9QEfLZiOZSPbsToDenlgaYg7VydrPxsTF6kNccYe
         EfkkKLmfHgiiSwa3eT+nO593x1nfc36A8bLnkdArtpXooEqJAb/KAYnejkNiaMn1+Gh0
         uPgL/zENJXFwUj3sD8ja1NVh+1m23zE/JPq3RDYqudgSMM2kiltle5tRn65M+q8mVhXt
         21CB/7YDIlvai+0ZvSSQvH2sN6oM3VhzbdDxVg2yOK9vD9J/lXYu2o5pJ3JWuvHYcH/l
         E7PA==
X-Forwarded-Encrypted: i=1; AJvYcCWpxwjL+aKvknqEZECGVyC2vmZkglCojZQkeN+iHmqRPg4eqkRTOjXEnFpjDS6JZOeQQydUKxTtkOPHOTw=@vger.kernel.org, AJvYcCXyeBC+QcZicLOAkhwybNs9PCRoSjkgi+sn3JmbpZx2cQs0zM0Sg+XQz9VRRgsTAGUjQZGQ+FLP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qZzcPXpOnO3/8za/2o4XwZefavIs1OiQMdkqaYKPGplS7ltt
	7P8QQDHTm61AklSE8z2Hcsg8/6YWt3gb0pTZY3+AbUpi3ESVKUZs
X-Gm-Gg: ASbGncu8Uyi13RIYXA/XX8Ef0XaQeFLZGbTYRMUEDnEJyIQNbnMS3H/K5P0y5ZY4Tr0
	qFU8FRKlDu/0Y4rwqX7Zha0ttZr0J1COSylMxdqHjsNm6rK2UveEF4UwklLQKLE+bOzYw9Wf6G7
	l8vX8iEdmKaRslUsSuoKFuSty5kfwVIARIj5rY7Qxtawm+p4h2yjAQarU7gCV9tU3YbeUMR9rDs
	7QosHgJ5Eia/LQq4T96Huu3i7045qWellea++8+IakOb9+1/wd0mo7GVz8I3FtAN18nDKz4aTen
	C0MJ08KH1fbDILvLFghpYnTZ+7Y701ZTDYqiX6gKdVvwACrjXuZKUSDZAvME0ZNf0koiU0ut
X-Google-Smtp-Source: AGHT+IGxJwl+ciiuLuxvQmDKAkVfh3pZiVb1nGFD8pabWWUgHnGHyCX/5Ral1DkskNgZKXMtB4P/ZA==
X-Received: by 2002:a05:6830:6587:b0:727:3e60:b44b with SMTP id 46e09a7af769-72c0ae99914mr10733151a34.14.1742923527304;
        Tue, 25 Mar 2025 10:25:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0abac21dsm1997130a34.2.2025.03.25.10.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 10:25:26 -0700 (PDT)
Message-ID: <726206c3-163a-46f9-aef4-dab0f15c5b44@gmail.com>
Date: Tue, 25 Mar 2025 10:25:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/77] 6.6.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250325122144.259256924@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250325122144.259256924@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/25 05:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc1.gz
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

