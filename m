Return-Path: <stable+bounces-248906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIwbMcF9B2qO5gIAu9opvQ
	(envelope-from <stable+bounces-248906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:10:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A002557505
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1CDE300AB3E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C44391825;
	Fri, 15 May 2026 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwPd+LGQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC438D3EF
	for <stable@vger.kernel.org>; Fri, 15 May 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875827; cv=none; b=RCccMt8fvRC8KPQ4NP3nWhJ9ehGBCfj7Kopx8djtOs3REiB4RJ8KHBipMrwPStpx2dH242M+ADHigDZsD7Q+1twELE11ghEupWdAXn0VKcrlNhFrFNonEMealOlkJgRaPUq56/GTcn4l/O4qP8x0KvXLudzv/Retcjt6g9Aviwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875827; c=relaxed/simple;
	bh=iMr6F+XGh+agbt6BAuCgoA8GaHVB1+Ut6Yp8z1X6hPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLKn2xEm4Qohc3UM7VhhA68T6YL7Od6dFrhvkZ0WKqHOiabMcA2wI0+UhZWFYxhdPH2KlApSQ6Q7SmRYP6TT3Dg9iAUIUC8DmO/JqosiX/2QhPp7qwr3P6ajL/OtPYpSn97guNEkLa1wH+Ul3t3qc4KntxnksDVOvXrddH6cHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwPd+LGQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d75bfb259so1841721cf.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778875823; x=1779480623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3mTIxvGa3/JHUzogiVDiFKb5HJChtCasPrDO9YJqwk=;
        b=HwPd+LGQSlRNfzSbZ2SjgR02Sk4i5F/DXy1lecV0a/+FYuH3JiNbRjSDbTcEdpP3+0
         frpDx4gOwhvILh9gYnhw0ixTVdTpmS7EUOpeK+S69nzk/411kpy9d/Qt3Y3Vn0cDC26v
         F60dmh4C5fYr/QfO9eTZ8kN6bt7vqhYLcJFG6A3utZ30gYnux/8yLhCJUH4wjjvSzyOL
         EvponHFEN1FMPNvkGypz74oKYQfx6SwjOiJgelGYdYq8V27pmdlMw35zU6waMOhClFuN
         UHJtmBPEug7ApPWcYux8fulpiTSSj08pWtQ+ohCDULZFtKVkWDVH6ilQIXbbf6qE81S5
         4vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778875823; x=1779480623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3mTIxvGa3/JHUzogiVDiFKb5HJChtCasPrDO9YJqwk=;
        b=KX3rrqgzUzOcwZvOTy9APLiOLmiHFB6vR0PRyJd8eI7E9fwwFZKynblQro+Rdbw90r
         dK67IAgtmKU6zfq+GiCfPuGzSEqCN3akbpp3LdbxT6O/2K02eDLf14grzOpFa1zR/I/o
         Uow1bu5zO7KilQZYIXK/rOqO0y998TPEbQ22670sKqCKRiJf2nBPigyr2CeovWEGf07l
         KFwzIs8q/S24zoaN7pzlj2f59JdrKr4lilL4gzhbOFIGT3tXec5/EaoT1qyjmURpxwOY
         sqN1fiG5ln9xrMcdtYmNWwm4jXpHgBDYZ3Cd5aOgyeeTeIiwjCdBBVVG+cVYEkCOLEi8
         SBJw==
X-Forwarded-Encrypted: i=1; AFNElJ9xjDHxfuQm3KoDDRe+Sx1Xu99tQVQfOp7XpVf+Tnqjo0GT/xCFN3Lj3HDF8031Shef7VQ9MRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXRHOnBHFLW8UkPm6YEWmMpc4LFaNLs6lkmel93MXBOeztTxf
	K7N67h5xpe9BAtTDersypjy2XZkwyCw66ydTJ01rYb8pklTH5/uKAyqb
X-Gm-Gg: Acq92OE/sUvqorU35Vr43uRJUwRefMIkLT7mchLRKn2TnIe1yXpQ5jVMRbogdXLn4sP
	s3q12mhLIuj5sJ9WkruE9CQJ8vLmoZJX4xrZV63iE+JXm3mvd9XCOQl8kot7FMhzJwQGCjIy+33
	iBY9NZ0/Q8B43/kLuDIzZOE/s5f8F/Xyegl3wlkFQJW44mxT7Tw+uVw7h3CcdtyULSVYWiOxOT4
	ahxjybOWBt45p+4AzLC+dHtScdP5jF/6IT0+SdWYNQrRyFgkkMq8ueMvoXgZja1iSo5iPwWREQz
	jG6rTeU0lcSxFrlmq6eMzYahZ2vgXlACRYrZeES7Y15n54Gtig/8LstftQeKQUq2+j+Ndr0K+Qb
	Pg4GGHOxBZDjF7Rk+NGCv1e8lZU0Z412LgUe2h6Hen8uyF9sZV59Igt+tY1KwHub9I36dPuZHoL
	yk3sAYCNnT26UJQohZGZ3fJTdOHHmicJB3P2T6cteXHVaFFubaeA==
X-Received: by 2002:ac8:5c92:0:b0:514:6650:eea4 with SMTP id d75a77b69052e-5165a296e10mr78269661cf.57.1778875822893;
        Fri, 15 May 2026 13:10:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164581fdf9sm54220651cf.24.2026.05.15.13.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 13:10:21 -0700 (PDT)
Message-ID: <2767a740-b8c1-4bf8-ae1f-fcb3d357ff57@gmail.com>
Date: Fri, 15 May 2026 13:10:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/474] 6.6.140-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260515154715.053014143@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A002557505
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248906-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.140 release.
> There are 474 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.140-rc1.gz
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

