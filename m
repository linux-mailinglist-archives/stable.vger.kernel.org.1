Return-Path: <stable+bounces-233120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDOiHOLyzmmCsAYAu9opvQ
	(envelope-from <stable+bounces-233120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 00:51:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B538EDFD
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 00:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64A5A3020FF6
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 22:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32700388E7A;
	Thu,  2 Apr 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN3TtCcF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E237C108
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170267; cv=none; b=sAyABNHIRR2mNEmW42zb31ZmNdzwl4/jkt+ET7w9hS2T8aq+bTQz4oVOThCbaOBS1a1V13WSM2uIYSCssiZvxkn0bg7bC02kdMnVsAVdyCASuKQsr9kphwZv4dTRg9KWirtefiZ0IaB5V0O3c1YaCxia+Nbrzev4Cs6kxp4jaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170267; c=relaxed/simple;
	bh=0ZeeJM4QuJubzdrVlPnaK6gT4u5etGNsimdm2s6C0Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pi8Ps8lGKnrYtSSLDrogpvSEyLmWE/FGiK/pdNaWswDqYcNHgA/XwBL0ZFSTn+LN+A8Qhi2JRp5EjCqJxD2uaoVOZN3OaVrAEF+pcnp2O0c4b3FDQouYhJwgnhdgI1HXVgWl1ovZZZQ3KeAYy6SEfzaqi2BKER5t90wOpAFWGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN3TtCcF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a3342d301aso17554766d6.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775170265; x=1775775065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cIQ39JUfKxuV8oXRIw8XFZkJM/CpnZ94rlBPTcNXAms=;
        b=gN3TtCcF/3DJi6KVA191CRNIlYWP5pCRmNt0z0b6ij2q+03lNhQ2PQZMfuxSEVCgh1
         Z3piHqg7KBNAyF8xPkza1ULVj5/MKfOVOeZC2AoxMBW8PoaVYzu5rixyY9L0DhLpXu/E
         KhVyFxXP6AtGlt5AkFucdgh1BzQLSmcE/CuPpX5/QJ+ijkUhmsfVubFmuEYxT+S91oRQ
         T1tRwr5l/FfKVwQE9bYTAW1lIW4F1XUV9khuB+6KpuIHYfex8Zz/EqPx/dbKJHCVUDmX
         DYsvSwlD0OdK2XHqFvphIMRvh0ED8aQ0sddZG45u+hiQwCpQV30cakoFr/skus1MXPTa
         cj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170265; x=1775775065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIQ39JUfKxuV8oXRIw8XFZkJM/CpnZ94rlBPTcNXAms=;
        b=D4TovJZw329jnrRJuAFebD5Hlx/YYE2gXPVA1YE6940p/7uPP3lTMHadNqiLhMCDXK
         2eIaqeuqrMuqfJ8oefCteoc+szRFprYES0MG0vNxN/VFQ+Zj015IxNPpXqdjYu4K6cuh
         wlFSDfhyu1arxAsvEr/WWcpyCwVFqBKf+fHuOvVAhKqVZX2HahP0aoVITOwNDFWbNHd7
         kpZA2N893f3lZHCYCdujUeHYfLk+c/AQkxbp3g+l/D91vCgHL25eIx9pCUNLrUacJGTt
         Fb44sI/x7rw3QBNdOa9OcWaEVxfoOHc5iM4XwyRNDqKUTspaUv+idKl7nvpict/Nc2JH
         mvug==
X-Forwarded-Encrypted: i=1; AJvYcCXODK/juygm5lQUEbNLMEBadyc4IK8/Z5+1UETCH88FEaeLkYHAj4jvRmJzL37NRA66YCX9ZD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBuJmYRlK6sIShnCedfpm3PCCVxjPgkue6t67GaBOuezbzpeI2
	rqVE0pLT/u127njGtJ7rG4BRThXjCsChcMe1n2S0Wi17Ni0/SjaN2n9b
X-Gm-Gg: AeBDietJYdBgEFEFPi5QxKutvSa3LliEm0GP+nBRf0ZlZpuMJgeQbp79dNFOOA5w00P
	KDTiC7CXDlr/D+ps7LAk/M0V1Y6Rh4zbtvlBch9BuqRijLKW+kij3xPUR9IbQ6ADFelt8Un4ghF
	Cggn/KczCYsWzifGbs44BVteasTkq2f3ZwNoPITCEw9/Nx88IcrZJb15onVViX+cF2+aUHgAr22
	EyjZd384ekLu+RW27kRAc4ScG/i8jsKZ0IpbXDgdC2htyeHI3tf8ISf6WIoN7ei/ipNeh+yEnxf
	VpdXj7wbGbnRf986PIUIOLXYdTA384QOnb8gIKVw3pRa9dAp4Cor/jF7BYzb59miZlXyvfB+fOI
	S5klEgSZl37rJb5ezfiWTUehOC84j4iVq4Trg6kTSiSzCUSMQn24zIxrtbiw/JgLxeQL9ZGxeg/
	AhUAd6PEHuKl/gk1xlHTUlR5QZbwlTCM79li74I+WeKMmvc7LnYg==
X-Received: by 2002:a05:6214:4e1b:b0:8a3:d463:da96 with SMTP id 6a1803df08f44-8a7046daafcmr15182986d6.43.1775170264726;
        Thu, 02 Apr 2026 15:51:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5977dac0esm32556306d6.46.2026.04.02.15.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 15:51:03 -0700 (PDT)
Message-ID: <fb0e46ab-6ad0-4ad6-9113-89f8363df6d1@gmail.com>
Date: Thu, 2 Apr 2026 15:51:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/244] 6.12.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260331161741.651718120@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233120-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 634B538EDFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.80 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.80-rc1.gz
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

