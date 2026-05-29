Return-Path: <stable+bounces-256731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKgoJ8/mGWoZzwgAu9opvQ
	(envelope-from <stable+bounces-256731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:19:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC594607C6F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 426973025935
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288803AC0FA;
	Fri, 29 May 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyNTB5Q7"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F52390C94
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082369; cv=none; b=V6kczrTqf5PBCdfV4CgG+aIfDu76YgHqhrwwFWnstQEOv6wqPoD9tjo67qy1evTD1j8jm+gG1wGfHKN0YwjHtjpJbIqAyxQK3wA9VBQ9jwc+A8kHxcoMSI51KvwqjndVXoXR8DNBhnKh+4GqZPh6nN0ZYoO+J+RuZuoUGhQPLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082369; c=relaxed/simple;
	bh=fOemvi70JZMFN2GyrEzFeQhd0Y+wBzm190/Q0QI9nF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j768UlqM2bbisuSE1X5SD0PKWVCHeICBswew3x4nxMyewiBqaDrMDokxEtxDG8uDn0zJg4Od5kRcN1gkVfYLrs3NC4DG1qESc1pdzKKkQ7K31UEUVur6lmovbd1+OvvRfoQoTVNkpyrbFXAYEyFXKqYnbCjQIP7nZEyvZmr8ONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyNTB5Q7; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-136b46c3540so7567167c88.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780082368; x=1780687168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZINR/+yOkvzg9+RHXkOB0a+V3afB675Utrw9+VyUxyw=;
        b=nyNTB5Q71gdH9ayzNj3xPlqrms/bxWrcTl4OKMXz/AbcCPkKpoP8Q064S40IbeZh7b
         8aISjOltMf+0XTXG3xnTXT7GQkVnSP/12p8ZRNxnQKzn5bZ3a8OmxfydfNzND+Hi5We5
         gV2/AeZfGK5e/IA212FhStDlWN1etDrXygrTJx0sdeOU4thMVADQtl0xnwjvlQtqlxIe
         knWxYR5SFMXoHKEy4MyFfSAncaHdT1PjF1B4PL0lJuU13/YrsnQEBQl9rba0+WHnpCMO
         zefWnr7xgpa2/a+Nz/+FJJgkD4iHtIZY5bPJIv9S8OhpkXQzmAUwOJKDw104RZXskgZm
         UyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780082368; x=1780687168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZINR/+yOkvzg9+RHXkOB0a+V3afB675Utrw9+VyUxyw=;
        b=NA1nfreDixqL+vVKCIOmBiNUgpx+v+rncymxlGGaKTfIzBJEShZbO7hTe5/PvsKVmt
         Qj6wao06jlz2DpzEj5XnWa04BnzW3NNtCGIuYcfhl5KIXaIYCOYCkthYUChAkgKIo5q7
         4K2ytrXLCnkkeK6JR4ZYRY+Xcsw+4IpqQpV0ZqSw/rNtQqKC9YaAaDw7XsrqQlQGTFpE
         igwO2e20Ewk8kWJrt6OMoc6TAd2s2nUEVFZd3Ihdtev8klc0mhvMutlAES9q8T6EP5RH
         rRE5aMorEP+P6uzfhqIFM7wZRRa+hqGCgPJN4bVSm4OKkjdufdfEl7wN+2fEEzkxCuYo
         nu6g==
X-Forwarded-Encrypted: i=1; AFNElJ8EzoUVfwSusnnTTsV8kTA3cQexpB1WTxlaOKmht0VBY/64xHht41vaUGymfeNWtGkcPisfitg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUeX/ih9Zg4YrXkqPETM6j/2m7kI8Zzb434S5KWeNvc1wK+VWe
	rU0ft+mUfPDVXGM9Kai3L5d85fALHQMQ3pdBItDcawZJS1KklClOY6cH
X-Gm-Gg: Acq92OEI6WiZROtJyTBtXLnai+f1JJhshHtiK7/B4/JprIce/zLbBLMqkKpI+4icH1w
	gkVaueOqiE4/JY+cJRRWa/09JdftxI/o5LInIGmRup//+akXVORp11FNk1VXEqicMyazihwRkAf
	qcuXiUA5waj8pm7focJ0Nsum/bStqWW7N7K9XA81CpADiNyaJ02gIUHpZ6E+/WCexj/bU6fGuiG
	ISHGTSJb+2jRgRJe426WVPd4l6zDjxMewha8zoQgWz2JGUEadVbej+Hsy5DxmRW7LsBlBXg2i1m
	0V1357WG2ueI54zxs/AsS6UQ5sdcCZKCFYeyAfDY30IMkPCXMDxshz29Cq1WHy3xQiE2XGwOE9A
	abIPe6INth3b5Q5oNq5pf/fw1G3wlY+luV8YPFterzDhVqgHQ3yu5kiQegLHu5qjRdZlaRjJ10m
	bOgEkIUKPkzFSloJFPyGzebGctUmNP5Pw2uqFKQ7pIuP9UDVl55hWhpsW9zDNp
X-Received: by 2002:a05:7022:438d:b0:136:959a:abf2 with SMTP id a92af1059eb24-137d3bf6096mr456088c88.2.1780082367586;
        Fri, 29 May 2026 12:19:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c7e4ebsm2013630c88.12.2026.05.29.12.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:19:26 -0700 (PDT)
Message-ID: <dc4e1209-57b1-43a0-8657-c3bad1a070aa@gmail.com>
Date: Fri, 29 May 2026 12:19:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/272] 6.12.92-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260528194629.379955525@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256731-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC594607C6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 12:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.92 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 30 May 2026 19:45:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.92-rc1.gz
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

