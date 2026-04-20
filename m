Return-Path: <stable+bounces-239972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA22BRhm5mlmvwEAu9opvQ
	(envelope-from <stable+bounces-239972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:44:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A53A1431FB5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32C2E303F688
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9D3A6F19;
	Mon, 20 Apr 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssLraHLc"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC593A6F1E
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706919; cv=none; b=DAlvDrQjDMQaivC3RcNR3T3KJVPjv3Mg5wWtGTHI7o9P1iFkH/LJhKZkR+fNEua1zFKVxfQQmD2j0s1x33EROwxk3aVvx+r+8Gl3AucRi/LoX9pG0ZjXjdJbK1xmyPjPGUIYIb+aX3kl2es5NqOBCh5NQzVMavf+Rvu+O7qYSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706919; c=relaxed/simple;
	bh=6mi9vFMIa04wljYpzGoEMr7NIMDp0gt2cIZj3a2+bP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxh6rdKaBkyaV3NiPqsNM3Tf/jARCfUAn6khOVu1pQvQX90dZlT0lypBwIpjuMRX5b6+dGLxfwKwDeRhG1e7xDHOUeTCK+hwnYUmQkFayH8MR1qTQOPZBQsO1zv3vZOwGuplRweAXDDFcmDQBYqN6aDg2LfImb7+WQVg2gkXjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssLraHLc; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c8f9846c8so1515608c88.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776706917; x=1777311717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eF+5pDaN6FkJBacKO2EApxwPjev2fE092Gz+F85hoYk=;
        b=ssLraHLcV4+fR9ARa9zfwJWRje901EcMMNlUwL3RRyupruXa6/OcvRWGOY65AfTTt0
         JcVIrL0lLhaXUxfOIUj42iCaSX+p700lRRHaxbeptjLAQla9Xzeb/Ru62TXcBbrShKHX
         XFXGsJ06V54iEPG+Si0PwNaGpk4XZly2LBcbNuKhabeE2/Q4ceDjgAIpZkpvngcMuyFs
         R4VCftAR+yoos0cxHtTqCpzepT1cGl3kpS1hc5GBiXSuDyrAm/FJtfKGlGrfzcQCBSxs
         WLhJe22I+mk/RO+2G6BlZaKYQ6mn/lkkYegg8SD76B7pl3lIT2Hmi2E9mbrSHgsutzKi
         KiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706917; x=1777311717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eF+5pDaN6FkJBacKO2EApxwPjev2fE092Gz+F85hoYk=;
        b=irpGIfWzkDkCW2dWCmVcinHAWGFZ1S8XALs8XkUQ1JEHGqIOYT7fPDSe45QnvmU8Z7
         HZIWvw3bzLQeCYc+SuupZRU06cZG1VeoAX4XFsYIA2dUFEm/T3lYLGdh/dCaOomGmh4C
         vCCkKmnQ99Tot3x7rBgIcWjo/IKcZx1V1PqPq1+JAsMCFKzniyPQvbpBZmpI8f9DV8hp
         wLBggPWtazkYBdJZPWQF94F0FW/ND5szBeHsUJ/95MUmGKCi2k/1GgjJ0ViEMvMx9pXW
         ENf5zcwB0V/5QFLFZVtGfeB7HLb9BFwKCRLUz4ZX04tmUsxHrBtLGZL04mJ4pi6NZl2K
         E5xw==
X-Forwarded-Encrypted: i=1; AFNElJ8raVq13tXUMuGI09GXcXyTShzpv4fFEUzD+MLCyBKND7Y0euz0RdSwh/fJkl/sMtu/Pxi7cdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MP57QVy85jnhnu4lmugtuMpTP8kOdN0SZyc+sXKn16ByQOtM
	63kzDuRjYnyCcX13NVqPk/yqrkOZ2TMRqfNzbQk9lnhd8LHAksgCeKfy
X-Gm-Gg: AeBDietAiSIuEaPCxC4rCdrccAdM6gT04Og1XsaeOumTzfd2P11KCOeQMWSVSPodH1w
	LZruZ3G5X5oJX2nqxjQ+MnxosyRdPySjJCHSJUKAEt18rp5b9gDzdSs5zVQ8ZWxMVNRa8HQKiUi
	KSuGYTSijsN9qciu/hnwC1f76sMq+yA0qiWPml61j865I1r6IOX4XNhyxuykb1c2XRE4aGmpNfT
	XC8kmowFqIKqOaGiJXsyGChQEEzppvz54mZiBpaQcX2mm1BSz/bAAMv7RdkbDmeb3oM7TekV6aw
	zAyhJCQQLFReGMJTIxWao/WVaon/R2ehCHgpbO4cVA5nK8BSVzQ0LoCfapyBqYexOQ05B5q+oq+
	IGETypT6/8FNygK/9TyFPmT3PuIUTEmR33BkMBw6PlSNQrqoYHA9JgJF6s3V953qY3fZb99d+an
	hyURsnFSZdrwwNhR3EYp+SXUqzPuoEPjGowmjE22XDlBHFE9SH/TqVvoy51k00
X-Received: by 2002:a05:7022:793:b0:12c:8cd7:d438 with SMTP id a92af1059eb24-12c8cd7dd7cmr2451612c88.9.1776706917221;
        Mon, 20 Apr 2026 10:41:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm22787328c88.10.2026.04.20.10.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 10:41:56 -0700 (PDT)
Message-ID: <82329956-697c-45d9-96c3-44859ff04483@gmail.com>
Date: Mon, 20 Apr 2026 10:41:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/220] 6.19.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260420153934.013228280@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239972-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A53A1431FB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 08:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.14 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

