Return-Path: <stable+bounces-256742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHqLD+XpGWqFzwgAu9opvQ
	(envelope-from <stable+bounces-256742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:32:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A0B607E77
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35D9D3031807
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350DB376A17;
	Fri, 29 May 2026 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KglyRMRc"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061A370D62
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083114; cv=none; b=REtUKjNHSc4C4vnstdJWmK5qrpgtebX+SUKKUqCKFsGKEIjKSMWgAehmafETjIR9PjGJL6UmuWNA/T0x/37JlB+KWv9JG8utqk7j1FjSh3i2iKDdoebQmMwxN8KJnfqTP6SfTxhCdVjlFqcFNI9AAVShtw1fi0PuZ2GhkmdbOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083114; c=relaxed/simple;
	bh=rmivC7Vsnlq0Bffptwm2fb6KzeUULgpxpo2pG0XYk+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7iDpft5ZNu38wbCH3seYgXhq9lBefOXkdihT9OIs3MaoYSVF3I1q+5xU0PPXRU+SxQZ8705Dj862G1HJ0Uw8YBvGykGVbQgn75H3hTPKyt1hPsHL/MWUkO137iwkWUwUn3UL0UU3gUScToQ8iX7Nl6MqIvkvghBw09tTIEdWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KglyRMRc; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137d452574cso471394c88.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780083112; x=1780687912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEjW67BYxgfB8TQaCwi5eVTcJeJmSm68YAXf2XxNoog=;
        b=KglyRMRc1LsGPnbTAqL5DQ/N31urfouq4vayz1N7/zWmCTrV0UfR7nVCiGaSqJFCY/
         ksNd+9DbxGQoAayRr/IjCPDdXWxIYJtD4HdgmrXtzW7qFEYySb3BhoQY1JWVcS0EEg/J
         my/4Duf2RoF5onkLOynquVVrfevvViOGUQkGp5c5sDsdlb1rNyAHguOzAsMLbtu4b1V9
         JcMli78cnHuZoQjKMo4ZJIKSuNKLX1TdhESLDRhIwzUJcQrbQjyilyRVvI2L7Ukctr0m
         TXBXbqrqYu5KpFwpwWybrAmwIiW8K4SZinYZxF/eo79O0/AjeHiChJIuj8j2zB62ot85
         bSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083112; x=1780687912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEjW67BYxgfB8TQaCwi5eVTcJeJmSm68YAXf2XxNoog=;
        b=obi1pP5gCfgKHK3rGkX0DxJHC4FCUtM1ZnbMN2Lxwyy9q/mTwmSiZFBPsUvksqILIP
         kZJwqxMC+bpfV7CidM5+ut1LPUmeHvqNIEd+XX1nBoU3zLoEuQ7Zc9iuLkWze0DdVySO
         Ac5fL9P+SQoJp19232hei2iup5iwkxkO/1ujUJB0v3/707+iw4GhUCQpamdFM7EUIyAZ
         KEkYCtRxJOQbsMsmeDR/DN0VrLyRSsKaifptD/LCAvTZHzH0f//5djMVGiuUcPFLW9IO
         9ASsgXaKdHEpesZeEYpajPx79f6F+u3QzGvPrxDJtA5oG9VxDgO8PodKlQUPTYN6NL7b
         Qbvw==
X-Forwarded-Encrypted: i=1; AFNElJ/8a2SRFNJqh7xvm2+goCejBRh4nv8FY6bKp2Q4UzITtxcqY6td1hUATq3hBD42gsgcBkTa5XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaom0ZWq/kQ9zgPb3qbDxos9pX0uAGdbD7TEX2G+eRHUwgQQDh
	PoW98+vn9+UQR2I9bQcNE/QYH7X6jZxOZYZ9QvqaD3Ovv0oE50doVdGo
X-Gm-Gg: Acq92OHM8qL4q+niWNlX3+1gK9mjwl40a3d6iZeqDjIzA/vSeBAmWxZqdLKymr5eChT
	CyNac9qZztgHVAEZILFN+YWPpeXPItW5dV6pz/S8Z7pqN2kCnUPtGvXHbC2XdfP4C4P8VJKmGC5
	8WWl2YICKw0tihOsr4YcYHL3olw6lw14bN+rikt8E1joZucC4O2t11ygeGkWrC9q0AWgxGJfBuR
	gjP4Dbv7yNbTSX4/shde9uUzUygx1bZ3C4dMRLAfPK4SM6so8lVDprA/z5q+Q6oH1EXyM6SMGi2
	pB1zNBmK+L8pRMnZMI/slisD49jpzrDPWqXIlJyZyM7kIjqGXhVF9HMyp2MhTYOaf8BxQRypZgf
	8iRK65z53k9y0IZy2ge1CjKhGzS3XyxBDk5iu3NisZEJpJi8sD7VNlGOHOmLuJdyNlXToFHFKJY
	dyukQBKta/2c/4/EdkjBTfDOx5lTH9UGUGB3O//zfi77+MpprbSHn4E7zCxDCGw5BFlpwNQpc=
X-Received: by 2002:a05:7022:f418:b0:12d:ff1b:92f5 with SMTP id a92af1059eb24-137d4283a00mr455015c88.28.1780083112008;
        Fri, 29 May 2026 12:31:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36af6edsm1788667c88.5.2026.05.29.12.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:31:51 -0700 (PDT)
Message-ID: <58e9bcb4-f73f-4687-a497-511cd9786ca1@gmail.com>
Date: Fri, 29 May 2026 12:31:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/377] 6.18.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260528194638.371537336@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256742-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B1A0B607E77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 12:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.34 release.
> There are 377 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 30 May 2026 19:45:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.34-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

