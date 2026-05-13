Return-Path: <stable+bounces-246963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHkNBBC0BGowNQIAu9opvQ
	(envelope-from <stable+bounces-246963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:25:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B681537FE3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 108E730731E4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5923A2E07;
	Wed, 13 May 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEwYNd2t"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDA353EE5
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692585; cv=none; b=mqWhsMjfCngJQT+FA0IxZmRaIzMjGOhUtsLptbgf6W5wGecV847IAlmobn0rK6bv9uMRLwcdZkjQy5N9+us2tiz2YuBZCypi1EbIMM0SVmLmAn76R0njKw1NKb7/XuxMvgaqwJ/kHwGUZfxJV0uhXEmEbIL3iiUgEO0yoCCjgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692585; c=relaxed/simple;
	bh=K90sbdV+ulm99KUT0SeI9AT5YPATm3JEyQ27ovWRo9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhK4dmxp6O6IdJHHfP8eA93Xn1cmpq1mpTJpBoSjl1CGYKs69C7C0Tqi8sbPWcYWTvdybCewKPsJJlYaOQLD5Gd+nx1VLnYmYOmDoVIvp77M9bX3Wdqd25b3hBPeBKzrJrz3tyHrH61+UyCOYzMgPR/U5lLwItImqZSeeNli4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEwYNd2t; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so7426232eec.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778692581; x=1779297381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bMevHUpxvHgmnggs8mtB8OZjWsvTBxv6UxHli9n5VM=;
        b=fEwYNd2trtmxHflDs7G3YKlkE345smRSrqqvJ6KXXTBzPKebr8Ilez+5o2puIKJofj
         /awnm7B1LP8Ct6hZGDRhV/poOH3SbQNLcdLelEphKHvQZk5cfyHhGKpJYep79EY8FrCm
         XAEIa1Wpy7dY/s8gXdJ46K23CCSv2rnRxcdH+fqOPRf5cnob2n7rGs5gKKtg8zmeWARD
         9qY5NZdM2W2yULE/H3LuD9W2JemSKRB8NhWkUS3y28mOCAjPkr0EhB6ZJ36vYRLsZyBY
         690Bg358jzLNcx+OJbLn8eMFbUHEQU4MnIdfV9Hf+8krihwck415nJHaSZCaahdoDPS3
         /7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692581; x=1779297381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bMevHUpxvHgmnggs8mtB8OZjWsvTBxv6UxHli9n5VM=;
        b=GSYY5TiiISwWyPQ06jmvENUwo/SjKm5qxNlYB/KNwmgDcl3qBHplsqwgaUe/Mp/I4W
         gug8pPFG7aU0ecZ7acYNFRt/tRSvfAvOQPYkpmWwK1No0g7uaWjfU9zK3e+2jKpcqvhY
         F8Z6BFINY8dH0CUC0BaTPJ+7Y8eJxZLAU30wHyyco423rTkgho917Psp3AGczcwRvymp
         rlsublBDY5My4CVh1Uhu3X/faTaaSOWiwdvwFelc/vbLm1Z9YoeWiCX3tUwHzSna6JZh
         GOpbU5eElj3s1FqysU5huNG4xRJ4oTgqRc7UtHcza7GUmRpwupSM2DQu5h4cqqNHaUm7
         I+FQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uk68l/Y3xOVih5I7q6QYolFxY+D/+r5aWXwo4bMEwFMICLRNaVl/A7gGCEZF6QkoAStsWx78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67IystkFDmAm2F4KmZ7etlhdo0xf+297lQlJnpmdrBxSNyFPV
	dd/tEpMKa/+nbmRzgy7l0f6fPtrewD2QWXxgtcAVlbShTAt1nYTVFN1mtEwFJA==
X-Gm-Gg: Acq92OENrEC8qUe/AqnOvK6DRoiwznfW7YJrvcZ18UXAvcsBVTyoBGQkcrNvsaY/7u5
	/G/Cau70z6BCsUwuHnCyiH+FYuTN1qh30foHFrCLSV3oQW6A7kd2a6IrqbcmY+q9lXC8zHm8Z3a
	8N4qoZ559uL3+8e/ZB0HWDl8nCGfACEoJ7G+Q6Fev1Cn9134YFPjgu9RnGGuFfksDGZzjyVygXY
	N3ZyJumYBaucgsiJwhotNBNH5wZo0lwecnRHrkoiZsfK1irbGXymjq6LWPXYEIBoG6MVuYDx5hc
	jhSYXM6gatRIPueXT3GTQ8BALFhuPR+s07qXyGXxlabVOCMNNcVqu2Y2DC9wO9xFLrDvlKiNRw5
	9F998TExZe9m2iwiSeOQITGRsG70tC88oMD4Wr6WMMkH9hmIsTTGDUxfxayzPZuYXgvD8Jvtd0u
	GUd4TN5+l9w+j56EMad3oN84S+83IAJk08PFQ3FmF1932lgJDeJ+Aow+NnVkc3ybtk
X-Received: by 2002:a05:7300:a984:b0:2dd:5641:f01 with SMTP id 5a478bee46e88-30155b4d27bmr1922956eec.28.1778692580578;
        Wed, 13 May 2026 10:16:20 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm28901475eec.4.2026.05.13.10.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 10:16:19 -0700 (PDT)
Message-ID: <481cee2b-1deb-4093-8b9c-b3f1e982ff6d@gmail.com>
Date: Wed, 13 May 2026 10:16:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/202] 6.12.88-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260513153743.326058350@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260513153743.326058350@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0B681537FE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246963-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/13/2026 9:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.88 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 15 May 2026 15:37:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.88-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

perf for MIPS fails, largely due because it assumes newer toolchain 
kernel headers than what I am building with, which we hit with the 
following build error:

trace/beauty/fcntl.c: In function 'syscall_arg__scnprintf_fcntl_arg':
trace/beauty/fcntl.c:96:13: error: 'F_GET_RW_HINT' undeclared (first use 
in this function); did you mean 'F_GETOWN'?
       cmd == F_GET_RW_HINT || cmd == F_SET_RW_HINT ||
              ^~~~~~~~~~~~~
              F_GETOWN
trace/beauty/fcntl.c:96:13: note: each undeclared identifier is reported 
only once for each function it appears in
trace/beauty/fcntl.c:96:37: error: 'F_SET_RW_HINT' undeclared (first use 
in this function); did you mean 'F_SETOWN'?
       cmd == F_GET_RW_HINT || cmd == F_SET_RW_HINT ||
                                      ^~~~~~~~~~~~~
                                      F_SETOWN
trace/beauty/fcntl.c:97:13: error: 'F_GET_FILE_RW_HINT' undeclared 
(first use in this function); did you mean 'F_GETOWNER_UIDS'?
       cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT)
              ^~~~~~~~~~~~~~~~~~
              F_GETOWNER_UIDS
trace/beauty/fcntl.c:97:42: error: 'F_SET_FILE_RW_HINT' undeclared 
(first use in this function)
       cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT)
                                           ^~~~~~~~~~~~~~~~~~

I will submit a fix upstream for this.
-- 
Florian


