Return-Path: <stable+bounces-216293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJnpFkhzj2n7QwEAu9opvQ
	(envelope-from <stable+bounces-216293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:54:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D537F139099
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A4C3041A72
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DD13C918;
	Fri, 13 Feb 2026 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2p7ij59"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC33285068
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771008834; cv=none; b=qRfQS5/yrj/ifFGdWv7Z/gg6lthLTwsAwFsk6AoXbEdBTzNQWWLfLVPUkLT4itAejB2fdm8IAKXat+d/+wtXpsqq2xisXXEvxzxqC/LtU6p6yJVp+DWsx7kwPSxtR6RTiskeA7mHPavNc5PmomTe910gvnGwnzPPBI5h+G855+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771008834; c=relaxed/simple;
	bh=6J1JGPqdiiuqTduUdf2hg07JnTUTZ7naH5Odbxz0EmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoZhI5P31pSq9d8d9Mu/vVuJ/ikDIhqzr6oNnUbcCWQw+BFMIFpIqe9mtHLl8zyQNunQd2lm9XS9kgbHsP8TDULj7dcLWonpdXd4qJE4nMfTtYWK/hdih8wZZDclNz6g5u0SBiCl0PjE9dKaLkvee7HmMDf5wzt7flVE6fNIGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2p7ij59; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2baa098ffc6so1085534eec.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771008833; x=1771613633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMg2FXtQsGlquKwWiDWYXGWQkzM+56kQI9PsYm8ol3s=;
        b=V2p7ij59tEvQQNb1BTY0tnrEG90pCWy5cQsXPbi+6SjmPtj8gCvDv59Ba6cJ/PnTXT
         FxTfiPZU3TqX3roYnbJbpWVNK/GC8X4PLY4RjZSc8bpDXOpr7XVq+dJXgmUrDvOcOak7
         SJVX2j0r/VlH0JMpzwku6YCyGAVLyqh7DF66IE6w/v/vWvoyekpqlveehtuHme3TBO/W
         4j3C0gaz4X+mxlrgOR4Lb5F4rzo7kUHiU01acWVlBoDVvYcpjQfjhhNIR8LfLKJTSseV
         H1ZcO0Scn8NvjuQbOFdmiI6iiX/ZAWEq+e5hYlqbI8FyNOrunn2CjQeVRKIq2qt2TTAH
         4X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771008833; x=1771613633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMg2FXtQsGlquKwWiDWYXGWQkzM+56kQI9PsYm8ol3s=;
        b=NvaIS4A4zh0JmKzf+NV8+moXfMLritvDEc7AVZrrSf9zq23pH474Jb1rdx4OiIbQvK
         oElJlzpp4awsAQdNGkWgm+jg+wLw0ekVZj2CfMpmQWe+M3l+AJWaG8CMxrzAK0JTJoX/
         mEmA5v9fr5sBKCw4CfL5WtH5F1a8NYO4v9BiazInuBZ7Imj6alfzNfsF+wt31uefjErO
         8Gn10rqhYJTCa3zH08MOPrrkpTuUUCOki2jIZvVFMBja5g52bA3SjmuBkzfE2C5gjXuL
         RhYOupzadRpG7QYDbttpieJTyVZX0jDtNUZmpBG8V+8Qt1+gUG6p1emw7p1n/35sPmhd
         2JrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTdGIc9jIRaWYUGrNdjg6VoQWWKfjAFBwbTQObJdP30c9hyZ6Vbv+3nKlZnZ7T7W6yyUjAbAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxH0uchzArxqcxU7Hi6VMxvvolWWtUBxA2QdoG+wZ+BbO52jXG
	S3WyHBTj38JZWc7KqOgBaWGFfLW7Wv2XVA687/+ECvwY+6MjRpYHeZDk
X-Gm-Gg: AZuq6aISq13QlDp3SRh3zipxTx2VuJnWrMr2kaGm4uPM0alxLEKQn5gFqNNtqHUxG1F
	F82hUmGo61842vr5o24nE2bBWX8wHd4YN1GOpQHEHHOXiKpPFVwLFEdSEzSi2fTKE3kyLtOH9nA
	Oo9I1evrdTxuQ3hMO0os++I+Y3O7eU2Bv/hoMheMkJjUcR6qWA9Z7bZV8QFdrL9mdQcmJ/n/0Do
	Fw++Ax84jreXpfMn+WcFk1ZUMECBNQjh8azH+C+Nr97k1WAz6CTo3qMbXpVv1w74ufUswuTE9Xf
	jj8u9hN8+KxzUurtSEuI6Kur/igk8YGgZCT8Pj2xYcsubiGDGhRXWHIHG+NPviac+xhT/Lc0xSW
	6QltH5h0Vz5gZKY6NKaOwmnVJgiLkULQjNiVSCKLV6D5kEw4+MqLy0tav8H0CiD7ML/w01ISI8x
	tlH1UeSNq6lEIqejMnArbdpPzQekJE2kxpIO4SdRDq7vtKnJdsWmlDNaDJ78m2
X-Received: by 2002:a05:693c:300f:b0:2ba:8706:d022 with SMTP id 5a478bee46e88-2baba071d26mr1431947eec.18.1771008832673;
        Fri, 13 Feb 2026 10:53:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dbe123asm7244089eec.13.2026.02.13.10.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 10:53:52 -0800 (PST)
Message-ID: <35e0503f-ca5a-4c87-b069-1a97c06407b2@gmail.com>
Date: Fri, 13 Feb 2026 10:53:49 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/25] 6.6.125-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260213134703.882698935@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260213134703.882698935@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-216293-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: D537F139099
X-Rspamd-Action: no action

On 2/13/26 05:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.125 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.125-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

