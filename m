Return-Path: <stable+bounces-178838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE2B482D6
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8E43C107E
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6241FBE87;
	Mon,  8 Sep 2025 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOieyuBw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A27263E;
	Mon,  8 Sep 2025 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757301875; cv=none; b=fVLlIPn6KUjIujyo+/bAChxzUkvBpgHUtzVzdWfts38Ce43eGT+ZfOLooFwlsZPwdF4xO//tyhLN1emQ2b8lxg7wZQyFqXV9WJ9LFpo7xnTIiG4tL8gVDC8lEgbhjQ8vlzAm71YFooQbG0yyQq0tghP/jlhknsDaSHkkdBbBkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757301875; c=relaxed/simple;
	bh=4KMKE3rf7nGiE4o9mzO76A86cw0C5sJX1SugltkYX9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgRvA3xNXCP8e5In+hiDmqtP9d/3s6iVVDe+WYjcefwnLmEN36OVyybg/r6e9qW0RYbUacSeZpN8WA0djaYugvXuIHld0cb9QIParYnhocqQxON+vFz1U/ypvHiZRNBvAXadBtF4GnPqS6KCwR34iiu8o9TEL9B/IJmQXye43g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOieyuBw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so2367418a12.1;
        Sun, 07 Sep 2025 20:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757301874; x=1757906674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YdlViIZHKUzYpjlo2f7uFhrNB8IK0wvfe/kRf2ExMM=;
        b=FOieyuBwUKr/vDEfOnmD8kQh8cDEPA8gXyFBVZFWtKXT2/r7a60shF7dJxjqgesMT1
         XGANxcHs4g3q5hLqGOvJjOY0t2zXQPZgLCJfhLopjatdB9ZoSv8peUQEfWSs8UkU66bu
         hjPMG327VzopYh6g3Gc+u2lHF6KhNDCfom9moHo8qbJqZmyl+5Gv9KW9R9PMMO5xllmt
         USRYUiQr2Kz1Ym/xADwXZN55u7qiH5hWm4cE2ZPYPXOtD8+B5K8R25GSG9n+DkF6+AJ2
         5Digp+QtUBIOIXOQ/rxnS/H0rLPGWlB4MMHLXfPM64TGW2Cy9euWSttv2+K/D52Pfvpl
         hHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757301874; x=1757906674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YdlViIZHKUzYpjlo2f7uFhrNB8IK0wvfe/kRf2ExMM=;
        b=dnI1y/urKhUwXlW+HeyU1q8oTcvppBDbgcU87K9EcdkeNsuXesRUg0EeTKws42EZG+
         WiycyCxgJnPq3FAS6oYyPqLSyIqR5jAv+A3Pmv/NdF8sW/JLECf/PCjRZEH8pl1nzhuh
         yM556hBvQlXdhiXthgiJV3WrWOD2GpBC/tuXxlyAKO/oAD0ZsqgkUASDIg926lRhqScZ
         eyeWrtFxPiMQ5qv27u1JXyJHRTp+zDBNnovhpfZuRfJutk3gTTx29h2O+jGN+xjRTkDN
         8TzbHtvR9zgL5YxStIZyOFz04cZO26TUdFrQXwQrh35Rzm7YpvZYnKBIrDzBjudVAXit
         bmDw==
X-Forwarded-Encrypted: i=1; AJvYcCU4bvAyjiE3rigtTb8LRrJX16iymq2FRTs46PhRQAQ1sIvHzD505YTHzzqoGdNqyG6hU5n7Abt1hNlLFgA=@vger.kernel.org, AJvYcCVDVOZCJJjDjfHXODaM8bOPKJ6cHXy8dIKyOjLpcFzaoAsT5BBkyse0bnXSBzr9YRFdYVedeBU6@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwQdsRMMsA99BtvYmfsYQiilv+bJOuvc9fIAyMhLPnS3E0LUg
	SdKXoBTkKD0QJs7+PgkLjdr+kk1evfRxF8E3b+Oq/cVUWnQf2oFaxZU0
X-Gm-Gg: ASbGncuHiYVbDBD9eC09NQnGVLw4MsagwNCtnIvZNVD+lx0RRBhuMoYoltfgkIYKd3Y
	URFjsOa1y2J6EqYkR5vaiwdXQqh23KjyBZTAy4Mtfv2VBtINi8RQCFNbUi/AP3xGeUDFpvCY8Wp
	jF557Nuns/8QQDXVFcyB10qn6BhZWjCIdEA15WHzgCaZ1LFeTZKTd9TD6MWKOYNpWPvJk2RMwmQ
	9ha9XvrNaSva6+heZoYsg41+i/Jwd1TzX8YEHgnq5VxpLh4S5Ez0louPw9y4D5mYorPUWvlq2qM
	zIEPLKAPCucOr4RWKHX/JWANzDLnK938+gJmeUec9QV3VnPZa+bJNgZp+Q5KNc/8+Qy57gqm8fe
	BjMmZ3EZzUc5slsq2CPF+hktYe1Ha34K1SzgLIpHCH7WqBgNDp4h5AdUN4IIKNUQH
X-Google-Smtp-Source: AGHT+IH1B5ZE2vW99JA0qH8CCygG0lWswOWJA8nDyDWgxquAxw+pqFuu9wOxwpISgnD3lkc1Gw2lFQ==
X-Received: by 2002:a17:903:2b03:b0:24c:e3bf:b456 with SMTP id d9443c01a7336-2516da0618dmr95348025ad.15.1757301873762;
        Sun, 07 Sep 2025 20:24:33 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-252a0e700a7sm42273775ad.15.2025.09.07.20.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 20:24:33 -0700 (PDT)
Message-ID: <ed431dd0-b044-4923-80a0-63abe0309f78@gmail.com>
Date: Sun, 7 Sep 2025 20:24:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.105-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250907195609.817339617@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2025 12:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.105 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.105-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same perf build error for 6.6 as reported for 6.1:

util/bpf-utils.c: In function 'get_bpf_prog_info_linear':
util/bpf-utils.c:129:26: error: '__MAX_BPF_PROG_TYPE' undeclared (first 
use in this function); did you mean 'MAX_BPF_LINK_TYPE'?
   129 |         if (info.type >= __MAX_BPF_PROG_TYPE)
       |                          ^~~~~~~~~~~~~~~~~~~
       |                          MAX_BPF_LINK_TYPE


caused by ce6db078aeb919d5fff7846e18bda2307c8a6ba9 ("perf bpf-utils: 
Harden get_bpf_prog_info_linear")
-- 
Florian


