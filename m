Return-Path: <stable+bounces-272930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UrNfN9qlT2q5lgIAu9opvQ
	(envelope-from <stable+bounces-272930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:44:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 340A5731B76
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 15:44:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bAriyK7J;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272930-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272930-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9D43035D53
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682FE27FD6D;
	Thu,  9 Jul 2026 13:31:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9B28C87C
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:31:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603912; cv=none; b=mne73DzPOWeQstOtgEx54/scgtk7HGv91Pi/+s4Q2lg2KSGzJ8O6JacSBHr8kldQ6sWG7dmfqNUH6ZNzfjwYuWiftPO23+udwfO8Oh+YoyT8ZhjfBfzmJMrjNCfxhXel/kDl+l8pSl+wfH9MC9OE3jionzXTYzooK/5SZdDxSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603912; c=relaxed/simple;
	bh=nK+XWSu+Tw+t9agE8i4GBCd/GLcgTvq6lhVAwjuSSYg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SpXcLofybJyoltqeoUB0rlL93NukbJIeFp0f2/k77JLKFvfTR9Lfg8NHyCGDIj/ejInQBPCNBwrLuGWvYca5zLR11Lu4kgAbryd4BYu+FtTfFAVrBfefO6fmyjVwlvB0RkJEY2sNhOSaRMjhyqk8Nl5XuyxFserDz5OXBbeoieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAriyK7J; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-472326ca506so1327809f8f.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783603908; x=1784208708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/M+W6LXlcmdxEuUQROOr/3E+bmWxRBOl/fTyxk2NmY=;
        b=bAriyK7JsSYhxZ3fgpKB5VOMCNYWjDHj6q9jFUK41h94MIIFiPiu28+bSv9DthvbG7
         SZKiUUjNkXnwPXMgCRdqfpEAmi0RcUuRjoLUHou7prG2197MNO70ttQQPaCN0BY0SqXj
         HXoLeo0k5v99rMCaZjktxOGyRDGnHazlAaV066KFmhL5M8Gn5nBTHMjJ3SyBwVV5cLjI
         e1+uFFOAxdK/lYfUmrk6PTBmlZ8EDi8B04jtOBBg/jytkHhB9icdrdA1CIWG7OfGRbI7
         yJQBBEKnlSh15I4WhAwOImbKah4uv/O2pvn+J7LGWnrDQcZDLqQ5vnd4S7FTk48ZP9Wh
         kD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603908; x=1784208708;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/M+W6LXlcmdxEuUQROOr/3E+bmWxRBOl/fTyxk2NmY=;
        b=FRn6ZZk1ZWcNiN5CHT9U621llQkucxmvXtW5nNaFr3Ts8NnGpREnHKHTKLZvFPOD7v
         qgMAGyZ9gPB6nu6FGS4uWq2PVUyxV9xr9oFCG6ui2uWmb2gUpW8WI4xeIhSh0Egod468
         SkLHoYqrCfkgc978kmTVk2XIXISa4Ab3CSUoeingTLeqeN643s83XdvGmiYeZLSuovrv
         7cQConsgrGcr/XqWUPj2h6pg7+NM64yWvJMZbpTikK0uR7X6qWoYrWmMoQFEhEsz8E+m
         O2Rlc3JMAUVJY3JoKS5a/2KBQsPRVIM3O11DM0898gCyQpAnVkn0fUkOBIU9n5YQ3lGU
         EYgA==
X-Forwarded-Encrypted: i=1; AHgh+RqqTiPzgnmToeYXTp3un5yqR/SmcinWj7hW0tcO8cPkE7Fb/9uI8puLkmNajA6hrQr3HudVabc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEZRjZAxFTWU3A8EzMQvWRjwS6w4yU3GMwi9JAsETa0JTMJwQ
	2/3BLnPv13t2CCnPcTDabeCX9dpodUUnwogPXM1dx1Hjo/swIOQVytnA
X-Gm-Gg: AfdE7ck5t7VT77/sv0RGg/PffU1zapcZVcZnqOuiihPTMxaEicj5fLW7k/Aob0Vt0O0
	dTSznIPcb99EPGkoupxYFtz77E6ztJ857aNYeRTK+XRnVm2KHNunZdJjPjM5HbeNa91FO2kiZep
	uEeCe8gV/eUyLbBU0tkI/heS9y6xvUPayt4k89MWOzbIqy+7oO1A1wl++0iJIhjXeyHQXYMSin1
	NCl/EZI6hnvId1rPSm76ueLIFlnDvYqPvkHiLqcfhl40pt1d7BxOxO823Z+7icHTIXNepMkjHpd
	MtGNOXX/UE7S9VDO4F56TXlntzho7PEmoG280jxF6cTBsBAxHSncep8LoSnjwgCg5BklFgtWv9p
	sBXJy7Lt/kat6Ix1vq36K5YwtlCN525OPdQ6qAF8CNRvG5ZIHb4roY/guO6j+Q5WiuSXmexjjZZ
	M9bcssP3tYm5dUPzxZqvRao+LhZeC5BPJQxIUBpOa/QXkRkma/AzuntVJd5mmWZQ==
X-Received: by 2002:a05:6000:24c5:b0:460:3233:beee with SMTP id ffacd0b85a97d-47df0775706mr7751817f8f.42.1783603908110;
        Thu, 09 Jul 2026 06:31:48 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm52356756f8f.22.2026.07.09.06.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:31:47 -0700 (PDT)
Message-ID: <d4579324-8e59-4113-9409-6c4048b5dc00@gmail.com>
Date: Thu, 9 Jul 2026 15:31:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.18 000/109] 6.18.38-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260703072816.644513463@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260703072816.644513463@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-272930-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 340A5731B76



On 7/3/2026 9:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.38 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Jul 2026 07:28:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.38-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels. Please backport 
7ee7f48413c42b90230de4a8e40898b757bc8e82 ("perf trace beauty fcntl: Fix 
build with older kernel headers") for MIPS builds of "perf" to work. Thanks!

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


