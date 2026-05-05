Return-Path: <stable+bounces-244208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN3jA10S+mkWJAMAu9opvQ
	(envelope-from <stable+bounces-244208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:53:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC24D0A35
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A97230A698E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C6D48AE04;
	Tue,  5 May 2026 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PfqklR+K"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E85363C50
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996271; cv=none; b=HBeyXR3QF4v2n4csTW2zrOdojrOuBWfGx7yiqkodMRuFO6d4ag9ik7qgcJ1QBAGbVa8VCrRDXPbhgXPxDDDM2D4A08ZjA3vm7DFFn3q8TGtqJQBSH9DJhy+fsIiwRzbi+JQWWb5jciC6OeyJ7/BHNWv7QECe1aQYn49B6ue8pIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996271; c=relaxed/simple;
	bh=w146Uut7UMGYvpnLmP1yuMot4XAU7Vs4pCdLB4GWUuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PH8/lAqB1XU2kI8I1aTTtMuWAZF+tndSGEwJsfLyWLFEtOC/GZh8C9L2Q6ftVw8bGLbMDen4EIWJ3J8mU6/BX7fBI6WIyLRBGNKFA1yGigJfIqmokZQf4rNX8qHEKwB+Z5TziwsFiU5idPQ8Sls7kBA3RJBatqlcQkDwVh5qJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PfqklR+K; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-42fdab683a9so3950937fac.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777996268; x=1778601068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4RUK3AbsfMjANJLz4VS1j9XhA69zN4V5nVay6vTV/A=;
        b=PfqklR+K8Nwsv9YZMB5CYws6NP/PkVZab7NCDuC5wW7fhFSxX7s5dWUo9lsXGbxRvC
         Z4oFoRX/kzUTw+nNqj5eI62xe9uuD56JdblEL+fhZS2iuGDBZCBjSHvbXpuvpzuHjgT4
         GrbsQYmMcnl590Rfz9vQuSO3p5IBKWgR2K57E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996268; x=1778601068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4RUK3AbsfMjANJLz4VS1j9XhA69zN4V5nVay6vTV/A=;
        b=BbXUbxGc1ST7xKj2HnUoV8jP6YR9AXLp9k9RtbO6m06mBKStIC0H7cYol2i0/t4rJQ
         mRDpSgjYnWQW6O5h6RM+eHUQalorEXln0lrMYYJAvuNjfwDExo1Fe7s7aEqkNcU59otJ
         EcQ61y7oYj3N6uO6OF7yJNShuHyCHR0COhgaR3f6SlCenIx94YEHu3f+quTKxEW72UUW
         iYXgyb1rlUEGdc552dAew9INkdQ5BUXRh+uTE3ZaF4xGmLLS7ZqC9hFuK3fBGh3EI2kp
         gkEjU+dYrun4iSoZDqKfq6LWJInn0xe3l5BbIPnGd5UfZQ32Ho3VG/fsYOI7LZfAwnHi
         F0lg==
X-Forwarded-Encrypted: i=1; AFNElJ+aYv4dKx2BW3oHM6860RRwq0XetMTGON0tMH4Fn6cPLf1OtkQK/ovA7y4ItJM8GgbnEyzf0jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtGV+YQ2SsThgLYwyAfz/ulwgvaBtufjK/KJz0BO7LeEMjTtU
	7Fo+/VdKTh2VJW28wuBZ9FXnnHqOW6uplyvLaiMwZAb5piic5G2rAsL4n/BlRk+QWiM=
X-Gm-Gg: AeBDievz+TZtN1VJ413b8E3VdxRRzyqWLaWIM9ym7UzzwjpXK6PyhpYcwXhckQdn3UM
	5JpY2tzlBLtqmi9qrbRwRZDT+GYQhsKE1VpfdQ3KF7IEVx9wtkMJbQh9S6JNJGWzPFogNj8yYsO
	/6YOlqotHzU0je/OJ4btzSO1J07IoOAuRT8Cr/YDxeG/g+YNGmUeQ4m1+yxf7TAMc5ajSZbGkDS
	oFhcCU4vSrTpXN9F/RKdDBDEJBwmwyMK4t+z8fnm5XRHR7DR1Afdett/i7BxwlBbqAMHQqHw04T
	vV99GRuPTm31qCtHafZDNtZqrqCj3AOWlaj5dDtd88kBTiIHAKKZeDQokswX0BUDGCD0Nfpzi3a
	QULGA9w5KBcPIK1s4qeNyRRFORa/HEn/FSqvBV50pxpGrm12dUUGcDmHFVhe/xTzbkpRdvDd68K
	rIVx+P4/pXhK+x+S2MMaAPM5MC5evRpHNQubUj9ejGJpzIQngk+rVB
X-Received: by 2002:a05:6870:780e:b0:42c:d6c:726d with SMTP id 586e51a60fabf-43475fc151amr7869745fac.8.1777996267731;
        Tue, 05 May 2026 08:51:07 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4347294b5afsm11563315fac.8.2026.05.05.08.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 08:51:07 -0700 (PDT)
Message-ID: <484804c2-9a07-4ebe-beae-341829c11ea4@linuxfoundation.org>
Date: Tue, 5 May 2026 09:51:05 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9DBC24D0A35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-244208-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 5/4/26 07:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.4 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2026 13:50:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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

