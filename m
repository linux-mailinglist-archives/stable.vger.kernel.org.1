Return-Path: <stable+bounces-191339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DCC120B4
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 00:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81E16500107
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 23:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E432E14D;
	Mon, 27 Oct 2025 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="ZlLxUQbw"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88832E129
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607601; cv=none; b=GKuKMIZEmxAdZSeEo4NYcaNNCBmsrtmOpkBNy2o9SE/F7ybeaquH4+TVT3YW6YRRRATiTEfLIhY6EMkA3A4E4XCgJ/BQGRHMAgyP2EqlxYmJZyRSbtTHgr6u520ssTWfhXeLe2eulAGfLG91bhw/n8zD3vWTz3+01dFs4PMSynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607601; c=relaxed/simple;
	bh=Nbr5JRXmrsBLv/PGndUKfdr7dz6K8kLXCFBOlT6YKXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFM/SW09SlMIQYdtzyK/rYaRlOgD3/nhwm7fBczgjW+f5DhCK4mSs/A8AengNt2MdBgrJvr0GnlA1GxHKSfP86jkkdD+/60Z3izFbT7lLrMqrgF7s8fxqQV6qgIVYQOpgbZUWnwQM0qaqu8bIdzy3YSCP17i5zjgQqqXfYfhL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=ZlLxUQbw; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430b45ba0e4so26477825ab.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761607598; x=1762212398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iikffhOT1WMi+y0dl8K7FDqmN86CXPbZoc1p22Fu0gk=;
        b=ZlLxUQbwpTb8731TUgpoOkmMxZCfqef3isSGfOv5QSDgnoMYCxUlMCbbKBh1koLiW5
         FJr0ttmfBI8YJBlpqMGS2IcCa+6sxe5XEVeZ1yG11XRJuUxJWwg25agU2rsufC1fkI+b
         F7JcdNsILAxvpyb/IbUzfo64haQbBLoDYLnapY9b5K4CRr/6qfPTeh3eP/iUbU/hHb7h
         FvnvVEXpbcyiDF4yzpMJbVs+KxVCyEAORWQpbgKN0mOCYVbiDAXoPRKBwYLcfcC4hF/R
         OA8Yc2FBKqnV0IFl0uFxtTw5yjsf7KWkcSGI1SH4XS0dgVkMMxAUiRbbUnJpI4yfy9/w
         wXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607598; x=1762212398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iikffhOT1WMi+y0dl8K7FDqmN86CXPbZoc1p22Fu0gk=;
        b=jxsMZQROFWjD68rtWBAra46x1Usl581nnpojBCpxZZ1JDPRasQxWq3m6ssj8XRtoY3
         IffO41l2pSEKiXS/1wQEqyqCX1ABgjG/Lh7VygHzyJj6DS8J8xtHzNjGaRjiO0tFFVEk
         VgSznuGw+QjD5THPT/Q+IKeYvO9ErygjA0weLQ3zPkJioKXC4Yf85XIcQ0/Hu9BwTyRF
         tjsx/tAPXJzhA3EFwSGBlItmiy2AoCXsKogawGFmK+PCyUqLXHMV0wxp6vAeOAvMHdDl
         jQTQJaejBRoooGBxk8mhvf8sPNQdp3QVk4oVDcd0IC6ObTjinsVYM3UqBcSYZxTYCuu7
         7yJQ==
X-Gm-Message-State: AOJu0YyLHrg/GaOEsha9na+2FjQZ2gibTvUc2Br4Id5fYqn3qIpmpKax
	37MipB2h7KnEI7BUz3sZ1VQ0s825a7ndsNdCTm4mesIPiypXHRbUAZhEZzjJX1rOAKo=
X-Gm-Gg: ASbGncvESOuWb6Cvgk/YbWJ4ZLyrLP3fWQJKgrEFAkZrh1Y5W/e3uHmNwiumspYp8ZV
	s6FPfAp7+daUY1l56xzcFSKeHsFBq+tprraZsqzFb17oKXQWZ3ilebPxjvyTW1TOLkhcZpopoHf
	1K1T76SyHqDBfNQ8Yc7tv0t5cJnDPS+uOW6d4VAqoi7jWHMUqVY9+Eb336XQlG/fR4Rkizw0qbT
	fbUN2lvJyiRdlweddKjlett4vZM9aAATTf7OH63vh/9EjRhjB0nxD9FGXzc9PFEZr4CGjbuDjrx
	Fg8FburgsPtysRQ9sqvVTMNSKg/RLQ9iayZ65/sr3wB5HcnwT4SvtuEZCiypEJL+Zc9UkG9BaNk
	BGhtMrDmGbrnQp3OzlC2qAIx5A5ZgobRTMZJb6VcytQDeyCGhNg0mDlbFydoopBtfpOdHTVciSq
	GpSWkqd6VPqzn9Bb4=
X-Google-Smtp-Source: AGHT+IF5tkBwJGXPq1ayP4IuAEH9VPpB7/PafjKE6njHLWA5SWNWEajU2jWwAJH4Gs9Tr8tZJmXM+Q==
X-Received: by 2002:a05:6e02:b47:b0:431:d7da:ee5d with SMTP id e9e14a558f8ab-4320f7bbd9emr25705695ab.9.1761607598127;
        Mon, 27 Oct 2025 16:26:38 -0700 (PDT)
Received: from [192.168.5.72] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688c085sm35588285ab.26.2025.10.27.16.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 16:26:36 -0700 (PDT)
Message-ID: <16a5f83b-c2f7-42ef-9685-38fbfd45c207@sladewatkins.com>
Date: Mon, 27 Oct 2025 19:26:34 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/123] 5.15.196-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183446.381986645@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2025 2:34 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

5.15.196-rc1 built and run on x86_64 test system with no errors or 
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Slade

