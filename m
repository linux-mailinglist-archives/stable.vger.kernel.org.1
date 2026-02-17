Return-Path: <stable+bounces-217189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNtiHfnnlGmjIgIAu9opvQ
	(envelope-from <stable+bounces-217189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:13:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D98091515DE
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA127305CA99
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126C13148AC;
	Tue, 17 Feb 2026 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDyYGK0z"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89C313527
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366322; cv=none; b=KCaKyZ+CR6mxQwKTPxfVUA9wcUg1qOFrynRqEICJOpTr2zadxcQLkSljQKLt84f9F4ji0ErwSnCLls8gnuDpO4o9djX5HkRT5k7VDaAyK2Cv14Ze8aSIH4HpLJIefidcS0rE9GDBz2D03jOSuRlV2kEGIjx9RVXLUBQ23By9KZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366322; c=relaxed/simple;
	bh=roEb2ORdy3Sj3LiCS7nk18n1HYWQa3KItLUCioMyWKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VO+gpYPQyigX7AHo9u7462fR4Ir3KhpH4Y/EFd0l5OMv37wltt3CZgbMO9wbNCm594s0V8yr6aEbx1rYNKOMHAmrEdUVpxA2rxzFjGfPRcuGvJixskgHqo34MGgoZRuFFGD7kkJTEst5mqfPb4YN3EQL3KXLQuK6jW4juNGaybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDyYGK0z; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270be4d125so5390563c88.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771366321; x=1771971121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lozsS/7o38zbQYiHv44V5EImHqEpM39AYU+mvtpIJxQ=;
        b=aDyYGK0zri+fJibG/axX73HWpiRiBUBz42pEdbw4xIFhBeIFAbjhgYUJQIrsUok7vr
         9egdkGZQXHuuaX4+3Y6y+3a/yOiZq2oiaqflyssTmiaJOVFHopnXYzWUjFoaMOehvSkm
         Gj3uNIKuXRSQcv1awzdkhvSlMAUDZqLDbmOxzJbB+EYSgHvdhPiHaN0ABP97ajZDRStE
         6YfYHsV487aip1LAA4HdPBA44jujgoeMQeWTIpGcd4L5RsJbzE8adHt5x+4uL3Mo80oL
         kuGPdnQi2dNgzNdk/tjTeJYImixo712Ro9aiNJakNWrRfNx5Y2ZKPZp35zpbgmz3gdVQ
         zpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771366321; x=1771971121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lozsS/7o38zbQYiHv44V5EImHqEpM39AYU+mvtpIJxQ=;
        b=J6Z5IjIQKK74zWZwgjuDyzUwhq/QhBAqS0m2CHj/JLVRi1xObgBTRaZWPrR0YtQ4bd
         DC2VhoFvabdfS4L4RBfTXdU+x7WSN5qdKAOtFDentixbFYQ0j5WUk6Q/aoxS9QADdFvZ
         +GmBCru1RjDNDHQJ86OpA/JKLmi0lat2hi5bqovloXMA/6dz62wPI9/CHkw5kpzNHVw6
         0OnmWWtlirCtMpz+9sI+D4rXPi4wA35ik6EU7A+yLmHTjx1SLU6p58NtotFr2lYyJHiS
         cbBFWg/Cr2hX42XxcAM982omQmua+M5+Y1OCvDchzW7awAiXFmoWzYSo1HFJgMgOL4eB
         x+wA==
X-Forwarded-Encrypted: i=1; AJvYcCX02MtSVVWVA9yoxOfb81ytvScNrM23XX8Nx6MIU4a43193W/ly4rmmJjIwqDIPze0Elf8imIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA15Fqizs0AsuiinBKKh7vmzViiV+3J2kSoNhqB/f2cBA5JVWp
	8DuOquFXoOWM9/RX4FJOo3Y8jBNVN6FrdJBiMV4sncK/rqO/sK5uEQY5
X-Gm-Gg: AZuq6aIxGDjo/XEdreVBaiGxZR27SDgVmoSt4RHsiopKT+nDthvEuOGeuPOunU6JlDS
	i8L6wcfm7a0m8fmoO4tfg90impc8hJMuKslSdoVMYFgnb5tpnWcHj6hpFGBPRzkt7ge8TaNxnCl
	ZuaCcgGTYXdyJGlBy+vIxVR+G+M3PwC6KTAwvrKOsWl+IMXG+s6Y/7DcoD/BqEiN+eK4UDQA22b
	SPdoXs7ZIP/OqLOGae9HTpXhO6cwgzMvYSqu3NOUPPLG9Pt8bJoNVSGaikpAD451uxkL7iv+VJ/
	L6YaU8+KFvYgjVYZXS6UoSktjByInVVYvHD8BXOZ9GU1Uq24P9DPEvlL+vNctCcmq5T22EJMRMk
	aggGNN1jCLswynjkfHhKL9nvHx9PdmHbWbvz6KQz4ZmWk8dFEkKB0uI1uG4hDnX/QYJWuSl8u7h
	Zgt67iwQjJD3MQ5i+1NmsMm4nIXXKMpdM0FODfr5kh5/Tnn5anYA==
X-Received: by 2002:a05:7022:2387:b0:11b:ca88:c4f9 with SMTP id a92af1059eb24-12741b6352cmr5432797c88.2.1771366320759;
        Tue, 17 Feb 2026 14:12:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b61ff7sm15593121c88.2.2026.02.17.14.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 14:11:59 -0800 (PST)
Message-ID: <5a20f94c-655e-4ec0-b421-d9cc28ea3ceb@gmail.com>
Date: Tue, 17 Feb 2026 14:11:57 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/24] 5.10.251-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260217200000.708219618@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260217200000.708219618@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217189-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: D98091515DE
X-Rspamd-Action: no action

On 2/17/26 12:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.251 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.251-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

