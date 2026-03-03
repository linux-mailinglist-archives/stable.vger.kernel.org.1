Return-Path: <stable+bounces-222933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNnzMzcyp2k/fwAAu9opvQ
	(envelope-from <stable+bounces-222933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:10:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392061F5B29
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9EA30A8465
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3003ED5A3;
	Tue,  3 Mar 2026 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="STTrsyRW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153DA36DA17
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564762; cv=none; b=Bna20XDPCgLWPI+TMHqKo0y4D8nPwlxtgZuw9lxmH9kMbdfcQ3mwUyUIyCyNkjtNm9xWnmjfR7z0Pl85wCAoYqpPARWNHr4r/HDR0zu6aldCnZM4yWUg9VOUPPQ/4+0ortnmWr317/FYMlvAkINxQFF4sj/OidLjAfgIy0JjFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564762; c=relaxed/simple;
	bh=2ygF+FjlJwVJzP2Osn8d0XZHc7MUwb31MowMfzgYVZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X19E7wzo6kNXMFSVZymMrMPk7kkg+HZ50E70gP2xWh63jnGYre23y6L2QNVrG/enKH/u01jGmsxn4Vkm5ZFpdjqifFKZ0dW3cSYfiBPV6zyrax3bt1PmRjxIZJKG0xJxuZ3TqqA/sc36ZfJ+Iyv5NMjUs3AvmyOYFuCT236qSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=STTrsyRW; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6726f320b54so3560997eaf.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772564760; x=1773169560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGWQLkDUn2HWC4MUXfBboPa9sF8g7U5fx7BHwMKQ3Uo=;
        b=STTrsyRWw0L9XbaIQQUPWi2z5b6BCovGsv4fHBfYz4aOpFGmtGxbLcHONysDx6V5cJ
         n5P15/uCK3bS/mC35SNAX778j9yS1XBvx67u8uOocHBhp94Rs9Fhol61xpwjbsFTk2wm
         9Q7QRGBv2/zPz4nc+k/llmAg9EgVf7BG5QJQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772564760; x=1773169560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGWQLkDUn2HWC4MUXfBboPa9sF8g7U5fx7BHwMKQ3Uo=;
        b=gGZwfi5Xe7S8OA/lksS+2R3Ax78W31FaObDWXvsayJXApIPfJoR4L+AHfRcZYd97Pe
         l0k8Sb9iC5TIeJMx9QFgWpcuR1T69LMcMqfSurM6DCnb+zIzgytYgYpskMx4tiPlz2sM
         VW6rpiidLjN2paLqc72WFcGzWMtyt8N/PKPiyKuaS6yNrMcXyEz1i+hCjuL+9rN1bF/K
         4Mu7MSEYd0o2WRBKodgVksZRhdYeNXjLmulyHIwBLrXQk+RUP8iOBXXWs026Em1yVGB1
         peA3IX1TEsfjm1jYj4ZHiZzYhX+LuzQX+5df3Nq8zy0UeMh3O2SkcS2NVpIZYNO4809d
         XNSw==
X-Forwarded-Encrypted: i=1; AJvYcCX/QzRmVomtkW4rwtPB+621+VPZQ9rW9R3WSioEbFn4/WdtbAPAVGb/i9y3E/dA6UR3gMWgXoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqMVWN2RPp2+z/FutmlWoKtB6F0amb/vyQMMLyq68GkdGowsr
	JfTdUfi/+GYzwQuAOmvdTMBXpSBkFGI/xR5zB3MGytM4FiRE9fUAUpA1Edp9+i0t6vk=
X-Gm-Gg: ATEYQzzqwYEGCpQDLPx5aFyYXY2hhF3BUQOugadqbJHoEHSkcBx/1/s/Bs/xzZNoy6/
	w/EttrfhnlXUFmCFjGcDqRUojjuou/meoYdpUyb4CMNC5UkB/w7zOKyag2LLS/K452r1CEakVuH
	q3i/1tvWkwV7gWYXoRxClLzPca2eQkgEQk7f/tsLqN6DRi6C4G3Zi4ooFx1k6WwX4KjZu0tfUSk
	uTMVikZAApXMJ0IC+URumgSP/DtLfuIyOuLD+W2OL26kACaqG4Jc/dSU2+B6ewEfkGf1YUzioD4
	fy2ih5QThw5lHRbgZwhSP2gYnvMbxZEh5OF5aaS/jYssytlxmCIbTJvh6sTWGtHZCGzeRjC813f
	JAjU7K4vDzmPmTzgL6cegBhZEu+yIDaVebxRy76aT+i4WavIhUHTeCCmdmiEwptEbn2jnWcYvRi
	5ePy4qdGYXhbWhLpM6J4hUwl0eXS7+eTQkdUU=
X-Received: by 2002:a05:6820:828:b0:679:f05e:f143 with SMTP id 006d021491bc7-679faefe831mr10360610eaf.35.1772564759974;
        Tue, 03 Mar 2026 11:05:59 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d26d9absm16223836fac.16.2026.03.03.11.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:05:59 -0800 (PST)
Message-ID: <0adb144b-e3c3-4129-ac90-6a41463b7925@linuxfoundation.org>
Date: Tue, 3 Mar 2026 12:05:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/757] 6.18.16-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260302160853.2519610-1-sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260302160853.2519610-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 392061F5B29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222933-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 09:08, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 757 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:08:47 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.18.y&id2=v6.18.15
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

