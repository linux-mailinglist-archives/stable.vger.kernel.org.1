Return-Path: <stable+bounces-235488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BlrAP/y12n6UwgAu9opvQ
	(envelope-from <stable+bounces-235488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:42:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FF93CECB7
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4CD030115B9
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9963246EF;
	Thu,  9 Apr 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWSbS/t1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FA239E75
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760122; cv=none; b=JSVI6swKB2mEUum/7eCNTfTHW8QuxZ7e2vtZty/YKgRI1UdI7FWmiT1wTwVU+r2PRwfYZSVCva+bXUM4FfSFhIJOZwNpp13yP7Vn5RcTcMaVVf/YnpuuLcg1K+DEquux2nqDdVh9FPse2lfhBWRRpbyKl5jOSbM4yvHD5eqR3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760122; c=relaxed/simple;
	bh=s8MIl578KTQcoEBQfpo+c1sgyqdA4Wu9I61jd5+tSIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2AV7K9Uldqvxj1nzRm9kMzS8hgzByW2w1cSwYwjzJnZ/8dNxuRVXSvmfpueFWjtybh/qC8ypYNT/fBa0/w7/VGHQ4P5qjDe7Ql3UVD0KFRYaWeijLo7vmiKYBffPnICRXMjBxUqoV05UTgsLiR8KEpg9mHqi03PJp6wjGJGs6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWSbS/t1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d4f78fc9f6so135920385a.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775760120; x=1776364920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRmCUdhZKwH4QD8153zHmJo6T6OgpMUjlI9kfqLfR4M=;
        b=LWSbS/t1TnkDRUZQ46iRmBMV0O+OkBM7JRdYvg5S3lt72ge0irmnd0t4SfA8avafaz
         zCVGkmeKWQ96PNMPiiw12UmhstWcV92XYBm3VstTVtioZmZVIxmMSzNwgWgGrY43B95x
         DM+oJpQJfM6y//VWzsGGGOp/NtO2ESZeVe8DJDT7pJ0FcKBUYDr+UPHJqmqSxkIj4kWy
         zwL8Rg23PNNjXUw6jDSAD9mdW6Zzon7gMK+OM/pBZr/h6vpDD9IaH9SRG4XDYASSffdW
         pXjX1gBUEbATuAVtbqmDTpbsKbbr+t2JtB7iCWA1osCc8jDtp+BqNGziEWZNXx5BZXbD
         C96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760120; x=1776364920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRmCUdhZKwH4QD8153zHmJo6T6OgpMUjlI9kfqLfR4M=;
        b=mRIyn/CpIsbJqPEKgn7ajCWpWySJ495m7XVtb1GqeYnLaQabD+nhnBoYvtG+zvTwja
         ATH0M6Hd6kg7hjygWwoyg/U9JzOx9dG9p6EWgOZ5Ky8LJ9BvgPSWyzub+Aw0itAk0FgW
         ssY1O0r6n3d0IJ9tKY6pIYvnyuf3uaUlW0rnBYAGBNo+RZZ5S8mR73UQxbHGeKwrGFke
         6BrVtuAnLokHytfxJkxnoOOpvcfTXFIN4Dk2h7zhFxRFTPrDW/CzBBZrspcjniBzOWZ8
         Bguuprrzs9edRPPHG31FyDmBtG3mh5g/FFWJVS8qyCy7MLOVCrItTzKw/k1anuKDLrUx
         8v4g==
X-Forwarded-Encrypted: i=1; AJvYcCVid8xRwiHOOSVHMkJ1I3zXBefqFPsjLHeROBCkFfBW7Hjwn38IFEnmq3KKPOIGbXm9LjMe+1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUA1dFFehpITu6lbif/pB8OZxDRxTOMZhecOGCW35HpmTS/RHh
	eKUEJuaG+c3T26gCDr4JKvmsbzX95aPIOcCOFkGygvzW/AOkUG9Cm2/O
X-Gm-Gg: AeBDievez1N9jOwCbRGDChviD0fv9cXE3t5Hy8FJoyYAKGIMJbSc5BhP/Bv7qnMSRdP
	sJCW+HR/5MGPd9Qq5AKi1FXxyf9URs3JpnjwPvW/a3Fli5l8OwV2dLyFVS/ZqcDoQztrc0Oo0wo
	JJcEO4X0fSX6Hu4C7ur4AszU9XO4av0iERHLNqSqa9u2taFr7AUYPechJ02l+GM1oUcw9db8Yrp
	VDRyt6GKtC8IuWbf+IeiaYMOsK7TSWc1DNHmh6PpOHLbWJE01YMSB5P6dcaF7wMxO4qZpK6hQAC
	qMvRA9lKOVU9jkJiisXOqDQSJq/ft7bSN0yQJJUKZDf9MzE+joTrUuJPnFrUgDlaVmY5dHbZXUs
	PCutVzMTex5ZUr6nTCGean+6hsLlKoxqOwCgwWWZoPzXKpD7kP2ncT/FdQZuF3KmA98q2yVNwKq
	WV9uYi3LRAczOpte2i4ir4AigEqZVZ0kGVCcLqAzQMDOc2QRWhig==
X-Received: by 2002:a05:620a:294c:b0:8d6:bd01:a67a with SMTP id af79cd13be357-8dc3bce874amr691692185a.26.1775760120457;
        Thu, 09 Apr 2026 11:42:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9637c5esm16141585a.38.2026.04.09.11.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:41:58 -0700 (PDT)
Message-ID: <7c470568-0bce-4200-981f-b9fbfa94ef31@gmail.com>
Date: Thu, 9 Apr 2026 11:41:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260409091742.514769762@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260409091742.514769762@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235488-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51FF93CECB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 02:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 11 Apr 2026 09:16:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.12-rc2.gz
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

