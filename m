Return-Path: <stable+bounces-232815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DDOHPVGzWkkbAYAu9opvQ
	(envelope-from <stable+bounces-232815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:25:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1887A37DE49
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F2103084585
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AB53E0C4A;
	Wed,  1 Apr 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WjTVKyRZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E76407568
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060361; cv=none; b=GUjLNf7v2lStu5Ta/2TTpFpt2vokBPJ5vthoH/kZ2bxvjOD5Mnm1fyi+lrDB8pjYRMnxxibI1gNTLI5hANRlEeNTgaatE4IUr9+cKDQbUH2n6FtTmbbRB8nrgQQdHOZuYHI0o+w0wqLmYhQgC6UaS2DjVPXZhNTHGLAkscvsBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060361; c=relaxed/simple;
	bh=25LG9q6Aiyfv1hJPJZPXPUkzGqO9cJdGQBOemEyScVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpx9Mzsc1vckBv3XZ6YwGjEOU3s8Hje89G3JPJaLfDLGtoeTR584PHdEjfZV7pYdjnvTM5wfiksY96wjzpoPSk59HBMu3XLnoP9jvwSrC+EWR5ukc51vhiUFkTuYb7FidX71e70nmCA5RM+7pB0rqmJxjZc85jM9fqx22UVL18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WjTVKyRZ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-46704177508so4292473b6e.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775060359; x=1775665159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMNvNaqAMcEfqob/rgMLpJZ2UNEAnteY63/EMPMRj/o=;
        b=WjTVKyRZc5ZtHEcPonG07i6CXdEpnSJTUxDnVmnrQtPBvhQ1qW/cejhQ3QcUob43R8
         lchebgoa/wpPdvGg4LGsgTuC7EvI3O7eRm6pVeDy3QSHFWn5v4QUlq2RyXv4H8RhNs+L
         8YJBRO8T8WwjeroyVWjGAGXI9fitr0B6XkoPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060359; x=1775665159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMNvNaqAMcEfqob/rgMLpJZ2UNEAnteY63/EMPMRj/o=;
        b=qS275gk0eF4taoI5zv2jymBc7uILydLYv7O5BPRCOfDDQjFOSeR97rumPGytTWy4Wy
         nkKP568i9mDApK76ly9VsJPk3ieEyQpYe/EO8s7mqPA7RhlxUtM0yVxG4R+AoFn/KuTx
         gPgzgymzcowxKrtFc4cPWRLncVsvi2pPvrtoMQGnd1Z2Ycrz+E4QE1yZeGfFIwyy76fR
         IrZ+PttTco7QA4lQ8iTdiocZXnjdQFJe29osiW2vjBimBMylBmbv7/FC2wvwkwH9W+1z
         OpE+oxmSBkE75MqiG+yh36odlkWg/Em+vmrKjVJN6+ueBdAMXApIJygDnYF9h7lz/pbI
         a5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWjzxlPI4KTPHq4xYLM8DAydm2ufTZ/fw7LKjfO5X8dPVRNRvuyOq4wzBKL4DPr46wEkgBZoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNdHr3FRK09Kq7b3XMsVQzm/eJgwUkxAE0VHM6aDgRjzEX9uS
	GP6LMSu2ftSRIWvilsHX2mlNWJqyNyOv5C9IVQS2+QctM2q1VkLFvUc0ve3U4uebUL8=
X-Gm-Gg: ATEYQzxBSTNIZey2LmF9oduSAXh8TF206NaaMpzD52NgojgWVdEBea8tUsUSHBZEiWS
	WhmgiBZqEOT50797AnlH31d95X7rOpXHXd0XJ2pVrVvSDDm3xu6sKUG1ES9QQ+znP/SX4k77On/
	nR3ivsOTaB5UkEyK1wckQjMouCrqnoeTQO2JxyfkyGFem9+IdgUXXyHutvxbptoiLnvKMKfh3R4
	xsXGF3z3BUgnmR9+IJwzx0LnA8VzIWvFuALtJKI6iaAhbQyFR7SZp7qvn/xa5vaBq2J/ykzk2gb
	UwOWGhXR1fhzqV1c/fEph8nS9TajElmeBwpCzohAC7UcX/pG6iPbyhO1MBzRIMx4Kv/PtlqhAX5
	jm3yNTueeQM7Xceo/594l1cXs2cD7vJsXBC1FNyflV1278H/1L0aT0BKs85C/YxhBaE0KP/9k12
	zEnX+INLgucaPWF9tQC5lGL5iTqfxqBqAjmtSAjZ4t5/ReOQ==
X-Received: by 2002:a05:6808:8958:b0:467:3f4:9075 with SMTP id 5614622812f47-46ae0217d37mr1973511b6e.54.1775060359214;
        Wed, 01 Apr 2026 09:19:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa03656e2sm8795860b6e.11.2026.04.01.09.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:19:18 -0700 (PDT)
Message-ID: <79bcfaf1-a242-4e43-a091-6704c89de8cb@linuxfoundation.org>
Date: Wed, 1 Apr 2026 10:19:17 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/309] 6.18.21-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-232815-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1887A37DE49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 10:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.21 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.21-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

