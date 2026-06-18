Return-Path: <stable+bounces-267107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jVf/HMnVM2o8HAYAu9opvQ
	(envelope-from <stable+bounces-267107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:26:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC0F69FBD0
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:26:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="d3/iiNJ4";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267107-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267107-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0A3D30465C9
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002A3D7D83;
	Thu, 18 Jun 2026 11:23:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC73B42E5
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 11:23:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781821; cv=none; b=GIsUa9PolZqGsF4pHjRrGNisvyAbSe8Li2a4hUXp71FiYAAkE9BcfF1ALh5dtRfeFY4mCASCZbLYLaNkgcDh5e6R4S9RjRKU/LEgup2KUqbIvhCzlP/iS3nlPfkBh7mvwGr48EtdxB+SF8k5DhVJUPQS+Km/K5Su/Bi6aOiv/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781821; c=relaxed/simple;
	bh=Kdo03FWGHsloa+ebkfj+J1rIruukAmQI1i7Xhe1d7c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDiUaczJX2mrvNRVgEjbJ/v9ScizI9QsNbM8ijg8WpcQgl7qrkH0k6gdsRu+lh5rJkYhUygzVI4N65oCLf1t4N+czEwIf8BBr+y07lVjXPEEYh0HEzvak5X9+npZUU0aHOVvXAca0SoQm5SGfOffxzrUw9kgAmGdCUmqdITt0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3/iiNJ4; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4923139e940so4439675e9.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781781818; x=1782386618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDy9b/yhQPJBeTVG+UJTnPxaGac0NnatlIVMD6aa6mo=;
        b=d3/iiNJ4nJknZ6uSDNSh93tsVM4rwNGor1Uc/JFQ8Wx4XiAet0ufel5RWeu891VOKC
         ZVxR7BMUWcG7eF3z73Lo6KHj447xkR9Muy1digDFkZF9j4s+5+APpJClbFvaLMySpim5
         YJOoyvW+wvazy2/4AMRwPgVWvQM586uGFIAi0VkM8IS7KNefQj6Ik4QYXgSwcLRFAonM
         POjNlwoZcbgEhjZ3rDHKlloA3PcribfxHqrCOHHNJG+fSAlCrqzi14Ue/Hd+2lBWr6PO
         kWI7W5SgivMWF77lp5s5D3FRpdQZG3W8lsT5NCIuEJhvrFuQWBpjQqtNwB2dA41EY/9H
         cKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781781818; x=1782386618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDy9b/yhQPJBeTVG+UJTnPxaGac0NnatlIVMD6aa6mo=;
        b=Tv0cqLYkIDHTamJHCPCv3YGs6wNhtJ5jmuz8Oal0lFbVYK2E1Ao8K2/ORtGFEEzHJ9
         GtjiWr+RiLMuXndY3qq+zprGIxyjYD4mDqc6Isa5ERvxnx9PJU0xq4lOpyAbvnuur1iF
         ipI5BSb87f8i/Lm24yQ15POV3eURsLwO4E1FQojOwPX1xhA5FswK8NF+skZiXsQ0eLbl
         k4e/Vw2T5ab0SX+2bHnH8be7rXqSXlIHIvk1H6BnAUgaO07k1Pv/YfuKerkN7qOq0v8W
         v/vaDju+dvH3XCHAAJjBh5v0iXZlUlyQWb4LQmZhi0Ye2Zzww0FSu0dsrnalQjrsUzvg
         UiZg==
X-Forwarded-Encrypted: i=1; AFNElJ9T6vuRBrQHNNI/lYhBXFwoTo07zWTh/i3PcnpymvxyWzr5tDad8HNUE72CaRAH2TFN6REf6r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCR7MogfZbr+1Cxu/PIxgGKmFFiN+tLlWheth7xhjeEOJA/v0k
	9PTBpaRJEZ07//HGRoK7MxcKFlfqVnbKQwZ68SMU4so5kqF7ymyEJ22W
X-Gm-Gg: AfdE7cknymgDpVHHEMfvxqiN2hY78efz/McYq1ZJJjBJ7UCgQU3ehnz1CwE/co3vU0M
	qglfjqsM7tXsIhdisVsUrPK8I8x5YVK8ZDPdyzXnWYlkYPC5ycWlVIuztd4P02PhNVnTRrifwCB
	8byp9cczpBAi8to9g8XoVnGTTB9DB+JEU/QAh7OAM6zmB9YE/m3YhjVpCDqxG2cE8nqQ459FAKm
	t0RDyKfbyL/UClZW7n0A97KrQ2gC4L3KMNXXprYJvdpTAsu6DgKuCypykBnk2LTTHY/cvNNVZCo
	gjmWWmcFqEjLbdiE99h1jFtOPJJqJt+EePwn+4LpyTv4w2PpuDVW5fYI8OvL4i8sKeRxNE0mm0q
	xB31ySFfm5JPl8LlDmLYxHBoDZLpnQegdPwAbYLQdg8QYAz6VScqtotg97xAM747JIozsCrtWIY
	GhKNbY7pfn+EbIU1bBtGZE8oK3e1zAGQ==
X-Received: by 2002:a05:600c:528c:b0:492:39b6:5a30 with SMTP id 5b1f17b1804b1-49239b65ab3mr38563545e9.35.1781781817973;
        Thu, 18 Jun 2026 04:23:37 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4601esm262106005e9.1.2026.06.18.04.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 04:23:37 -0700 (PDT)
Message-ID: <05fac223-92f8-4c1d-8699-43b105214b9a@gmail.com>
Date: Thu, 18 Jun 2026 12:23:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/522] 6.1.176-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260616145125.307082728@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267107-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCC0F69FBD0



On 6/16/2026 7:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.176 release.
> There are 522 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.176-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


