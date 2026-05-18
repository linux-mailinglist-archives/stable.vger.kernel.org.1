Return-Path: <stable+bounces-249358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKOuCexZC2ovGAUAu9opvQ
	(envelope-from <stable+bounces-249358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:26:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18F5723A5
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD9A0303EBB7
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8080380FF2;
	Mon, 18 May 2026 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieuJS9Ok"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C021380FF6
	for <stable@vger.kernel.org>; Mon, 18 May 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128358; cv=none; b=vEawNj093Ik2X2xEm68lMvU8k/NIzEvl6qY7jpodhD8/s4PKZ2D5miAiEL71U0sAfxmfb+oC3aOeVwkc847IG173yKxmJzgjcJRqY32AYkbHRu4bbU4euYk95XRzpEyrWu9jff+KUvW5yL9y9lZKtW7/H/PTGcKcvRw6PJGb46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128358; c=relaxed/simple;
	bh=L5I1Egkty18Oxhk+NikpBY/EXVWM3jPPMiyr+xwgYmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kt9gfiBALJzFRS0OYkLlB6H7C3Z+mTc2byoRX6TvO8f4nO1ThMvjAN5oGP4S7wXMAaS++B1g2apYbgVUAtBkvwqWa5CRz3IqaZVQB8DC+IJjMtm37P9vBflh6A7ZKo+kr3mTB1D1gIyJz6tHLbiH85YgIJ2l8PCPPt9eXatHEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieuJS9Ok; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-47cacb4ed99so1712028b6e.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128356; x=1779733156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCtT6xuhMHaXw1nHALH3FFemEU2JIAPerrti8zvo02Q=;
        b=ieuJS9OkGmfbkMit7KRuyZCg4dzLvGTnsVbD2C14Xen0WMR8FmhWoX0TcRbsuPOquY
         4w/N/WgiosO09kp7Fll0Q1auiupyBBiBv3E/GByVTx3+V5n+fb3ntXTudOrpGP/ooXtu
         mNeSGe0Hlmh6KJvs2E01244t/MBvAIghDnXaXjEA7q4pPIyq6cMJVMhLOkILv0xPg7Yd
         gI9Z6JtO8h20RMVmyCH5lSWCOfQl6a/kHqcmjos0YPJHUtSUdF93UDsLtrRzrDdPiLS2
         SRLovhrre9dZ/O6mCPMbOv6l/tZYnSUxxQ00k3ydKggMVSwqmbA8yXLMJ+ye+p3Hm4vW
         RIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128356; x=1779733156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCtT6xuhMHaXw1nHALH3FFemEU2JIAPerrti8zvo02Q=;
        b=gtWyIj1jxq24ygd6CNvCmpeJnsTecR07heGpi5RVOQlXNg6RvA221g99+X/DFZoIst
         hDyxCwIOR2cIa0JQp2wfoiI9kOPAViwmZ6pbcYLJcR4wjeuUBaLwCbMpMXSsfxX8i7sv
         UQyt+EdIn1JZ3gzS7gJ4N3nKSXqNIspRMUDYeUhdtOzRXLg5aGEO3e0/fC/rwbzviyv1
         NSG9IuqJ0xHEflc80nkhQY6SAfXmWqCjUPGd6oysCX9ldOKjSEU0pqgCJtR4PXE1fGut
         lGbMc4A65H6wblMlHaC9rtTLDKcSqkvWk/PRGfLQ23qY9HwddReApd8TJkv1Tvt5Pdjp
         OhoA==
X-Forwarded-Encrypted: i=1; AFNElJ+j97ymwQonkCuXSIkTFg0wsmVKDXGdMRPXsTSW/O2PsPY9lfC3RM549ZSivKxGyWQ4bdbgyJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5DyPdUESDWBIvvIZ+WiTElW4LOraatlPJQiUB7xkaN7azJx3
	GJ69W23odukN4yqV8K8gUzjvzoiRfgu30rV+wW2KjUtYbQqJWE7kbH55
X-Gm-Gg: Acq92OHtZ0Lg8LKSYcFEVrAryr0qjFwv1hBVfzUTq+OEHpg93aDjuAZKkE7bXBpUueX
	zDG2GyptZw4Nl3A+jS46Z36R5tTntx7w19euktM4YJN+8AXqNnBnfGSRWvbebnNK8Y9wvlkXSy7
	ZdiH/2/qKrbsxaHy6XRBoo5041CZ1w+4slkYlLu3JpV/a4XbQVQoWyEz1keTNpjDbKEhzeBbqga
	JiUWOxazxqo0EsuaR1N0vMYAjRsptmdV0hrkEtp3ik5l7o5hG6xCPoFX1/nUkQ81tBe76JGcxJj
	4SgjMcNbGSPgqlc9AVnQ6Hi2R9D2oYU5IWVVJzTmdIFRp2/1+PcaCFFjoSmbwiebCS0l+iQmh+F
	khsLOv98hthmScxJBCncSg6P9HprNDawoyRMcE2Ahc63iB74cy+YnvGd0A6KaBRsYdpTBS4AVjU
	7Y3uqLbye/Na9PIRPCiNSgLMn/Q1mTTEKsmThFIU2uzeUXtJPbHw==
X-Received: by 2002:a05:6808:4fc8:b0:463:efb4:f9a2 with SMTP id 5614622812f47-482e59468bbmr10642289b6e.28.1779128355915;
        Mon, 18 May 2026 11:19:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee389209sm5469316b6e.5.2026.05.18.11.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 11:19:14 -0700 (PDT)
Message-ID: <537ae7dc-c2a9-4fcd-b5fa-0fec2831781f@gmail.com>
Date: Mon, 18 May 2026 11:19:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/187] 6.18.32-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260516102236.209957148@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260516102236.209957148@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249358-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AD18F5723A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/16/26 03:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.32 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 18 May 2026 10:22:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.32-rc2.gz
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

