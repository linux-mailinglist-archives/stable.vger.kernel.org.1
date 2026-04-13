Return-Path: <stable+bounces-237638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIk5FBc/3WkubQkAu9opvQ
	(envelope-from <stable+bounces-237638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:08:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AAD3F2756
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A892A301DCEC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B6390239;
	Mon, 13 Apr 2026 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BveXdg4S"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C638D6A4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106926; cv=none; b=uwWYX6JX0LF9M9ndYGKqTzNl30W4MjcUNd1ReUu7Nc34wW617rFtPgO3LDdzoQ3i3Iy9mhZCyBbQm5NWaHr/6ynIhKZIQMVqBEnzWWmD6flkX0xAGfsAgLjQIRYmvkwihoaA+nF6n8lK86dp8FARFHOT2dX2SvarwM4rq9p/bAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106926; c=relaxed/simple;
	bh=FYLXt6nBIjV7qo8LTQfcO69fMqnwEzdpKkwxeYgMW8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQnGqioE+y6ag9UEXgYbw7qt4UwjfXGGmdhFzGVyxXcHW9mNqSyky77c6ZREGLZIxafQ0RpuZz1CZ+kBhTBFfQbG1Dxhk+luHKCmDzmq5uD20hwkdeoP/NUEDSO8mnavI2cO3Mzx7tCOxugZ4bXbMhEiaUiJ8/a5gcpKe96+FWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BveXdg4S; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8898634eec.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106924; x=1776711724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWbV91gJHTrmHWm4pr/s2+bLQmWIv1BQANB6LkVTVZQ=;
        b=BveXdg4S3449w4ewe6nwr6hratH1nsXZzxQHU6d+NJJXwS7jXoql/cNQ63WpCUoUXF
         5xmxECgsPt19PBK7cYiksWlLPZgkJekZvzMq+CNYd8k1Je9STAADjYgd614n+n4gJzdm
         aWfBB2ua/FaU97NNJyDD+jFSX8543O2XnZZcUS1x+9m8L7mwX5akMhBcoU+IRnq7aH4a
         Orbh9G3q/WbAJJZV3cUWNsCbJ47YBT4LfSXAlNm6qEnKe561pxT5ABmbFMfBvAGj0iqT
         Uyz6rmC4LlXYtInOr9QrAK++INygFcxTcb5EnvcXmh71GWHPifL4HcJWQHMw16082byf
         ra1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106924; x=1776711724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWbV91gJHTrmHWm4pr/s2+bLQmWIv1BQANB6LkVTVZQ=;
        b=dkRVzOIz1HamATdE5Dxy71GNCoEKcwb150DIabK8Q1mym0uhn9rA+jStnqp793Aoom
         e5lGupq+K6kDjyiZ3jpvh5pq+TEcKxTjLUMA9l2IWo0znUObzVVF7nym0so7rjBx2kjH
         0gpwcV79gnguLI9/uMN/ksj44+ffT7lP8qAEOSBTGIV0og86B39KyJXQ/YxQ7ZzKY0R9
         iGWEwerHULAoba/hJxYRvKfcM4+P7PLy8B7B9WRFyJc0WGIBxLo3r9hKDEdv/UZ7JK4x
         7gLyTl7wQRJujBMDM+Vxh6GKTsXxNc90nTQpLIhrfzD39fC9HXum3UMw+8MfvJUz6ia5
         Ojag==
X-Forwarded-Encrypted: i=1; AFNElJ/BMPUPPyawtbowpluHW26r73buK7KZUOwsSLLr7xNEwdVuDzyZYHM1xOI5zgLeWBgqaoY2jl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHrNvsnnM3l9MZWG3b7nT7XDiCKi9Lbsr/+gRTr1TxA79ZSOM
	uUO8KBfPZ1eLEMkL/n+z9mzhcPKmiz5jx4CwQ1mnm3z7z7+4ziu1bm7n
X-Gm-Gg: AeBDieu/8RVmmcPv9M6FhpyxzHTDS6cPcUzEpZyBKXCZzJVRZjjcrj0Am+GYWahs9lB
	72OGNgEsR9RJq5iHJQtaqZgfTJN0QuShVI1bQSpZgcqAaGu0hjyCb25ZqIhsy0KATnxLUoCWNCc
	EMPKpJa18WhBA2WFANST3UX5IeDuj9bAL3z3RaXIHafd4LdEMLDTET8jVu0bdfSkF8rJQNTr2Us
	HyO8K1+IOtN624Nds1yNUNgTMV81DXzTb9lq/4UV4267mxpVDHOQ91agGk20fZYyIAHeEfaSEfQ
	G5Jpm55ZriUPgAvzvvYT4gGiFTp5TfR/1MEoATrYOKnPFoeeim800utGMOGFxLPBv4brevake9S
	TsZhnG1zvSqWKJOvWEkWKw0tvX1LApcyxScZvi0sbTKMOMeb35FUJBjtHk3r6UxNXd5xac8KQzQ
	RKum92CzVtWq94LQ1CYdgQNVvgoOmZb+ERO9h6DZ1k61HL8UqQLQ==
X-Received: by 2002:a05:7300:7316:b0:2d0:239a:23cb with SMTP id 5a478bee46e88-2d5891766c4mr7776032eec.16.1776106924287;
        Mon, 13 Apr 2026 12:02:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa556esm21000010eec.8.2026.04.13.12.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 12:02:03 -0700 (PDT)
Message-ID: <c67f8b22-7bf3-43d6-895c-3ff7492a1c02@gmail.com>
Date: Mon, 13 Apr 2026 12:02:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260413155728.181580293@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237638-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: B8AAD3F2756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 08:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.82-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

