Return-Path: <stable+bounces-211184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOpGOsBkcWmaGgAAu9opvQ
	(envelope-from <stable+bounces-211184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:44:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED175FA2A
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA473501D65
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635A44DB61;
	Wed, 21 Jan 2026 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4FtqnSc"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FE450908
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039033; cv=none; b=CZbQ50Fok4tanVbwK1sckY4xQ7JUHoDFA+rUSvtWVayoWb0L1cPRXXGDsaX3beJ8xZKoUhTwAHKMna+kkb62IyxZvU2Lx5EEvIcOuU3DP4mupoO0t67jCfoQYm5FsdQPbymG91fmyhlVM5o0JSmWXfYVqLwM82BxhX5DjekbWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039033; c=relaxed/simple;
	bh=9HH2ST+6YAomJJ5sRQVl3r/BwtxPLEbEQWXMBApKL3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvaQPuO8flWXTgDmEArmuJh+fGhDJaD6l63OxYSH9KTwBn6RSXfZZeQ/aH7yaBmc9dAEmY/dNfrePwS+aU+rjw9VlvmM5bLOYV1GoEwPjjtsMO1tzxUrUu9rFjmygpdgWn6Ue2LsK7k1VkrYkFwXPIdam+YWvp1hJCcIvwvwZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4FtqnSc; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233b172f02so645673c88.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769039030; x=1769643830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRhGi1QIfFeTS7wFhhUbasQQpPGOG/cl8/8BZth9tJU=;
        b=i4FtqnScFFymRvx560ljPXBha53rNQLsf3kjBupqKUZKiQvD1KtBHnsAZxprecqK2T
         o1+aP5dwbDuv2OoSdDFNijF9HDtywwV3QC+ZwhIvT1NAqOegBpbj1QW9Du3mLvPcGSP1
         A12w3eJ0ikH+OgJUqLkbYlurNw+x1SoCtRr383T2S4kmxxTtSzHDviCtBGzLbtJ9CVDT
         Bbrk9Q+kIfDXlo/rC5tlBU1K8Qy/rcBSY/fVi6gBL8Y8j+SB1h1ct7BS/xONM3CoZ38f
         iqpuKTITT75LcalsYDdN8cRD5qlb1sZr3ULR5iishwb7L9Q5s6yBtiaQFwblg1MkTtFy
         xbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769039030; x=1769643830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRhGi1QIfFeTS7wFhhUbasQQpPGOG/cl8/8BZth9tJU=;
        b=NWReTwOyDpQf4M7bdAZTw6kPR3odzHX79tzQxSpc94TLUSS8NU4Ys1whSE4i+YT44B
         CXF9cRUbLLkr4o39rLpvWsmkcZaKks5/qkOS9mLM1aLfwf+2A2+8j39WVbGY1HtoXQR0
         Fl6uQksCkZhFSHrTnEKFaEf7be/0OHtRgrS/Bw3Vd3P8oEXMcAaKy8b0FtcglUrV4RPj
         c2I+8hw5wZy2+UAFhQhhfLsD09eE+W/WJyaumsxWOVettaw6Hwd8UhJsMcuGoYgVjDki
         P0PRC5zSWM3L2UK5p5kl6oeBf52gw5BMOhabENoOyaHTsAAepqNvPmRaQDtxr2wU2xre
         7L9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxgvweVWU84vzgSwhLDNPaJtDLK3xlUlCELd7h4DVET+AKP4SH0JTYur9ffCARIRjdzlXy3nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRDBOBEwy5nntO/NUcbg7V6sG4/MrZJKJ7R/YMBvDwq8e+J5L
	XJipasfzJp23a/BvsZE0cHpsuZ9VnS2dgIJOwqOpMWr7ExUi6YhvSl4B
X-Gm-Gg: AZuq6aJcD0JclZFRbDaJ6wt6YD4zaHj6R8mgo2yNetard37+T4NJyZzF2HFyhJ4XVUm
	cuFNhfh6lt0KPS6YIN6bTTmu3BHvk+mSBQEb54wmcxWYH4JTWVvQMqUWkuFwFj54gh583BFw9CG
	D/3bTLRlgcSsSgbvJpEnJe+vdtps/fF6LuyLB4rF24nR6X0IjpeRtLRplHTZ2oHUNDRicWdwElb
	yHBqrBJe0bXm56S1THDJgpbNCP8Ki8zHkO3xQfWi0dURbVgojmHWYK7YJMP9viSdyo8RCrKYOKO
	TkQNIo1mckUXfosUMYH6EGHHYljSdu8bbHer3leecJXsHvmAXI7sAcgc4JHn+xhotyGIJOtnmpq
	CbSg/sgvTSaK0i/6QYJRr2AXOk6pegS9Bn0YyVx9H4gZuC2HZFNsOXxpVrR9OFYNqjlY1pXyQnK
	D1uIGylljTpp/A20rpyBEZ92Qh37GvXNwo5/MK7k0AoQGyJsGu
X-Received: by 2002:a05:7022:689d:b0:11b:998d:bded with SMTP id a92af1059eb24-1246aab32d9mr4116309c88.28.1769039029789;
        Wed, 21 Jan 2026 15:43:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af22aaasm24410674c88.17.2026.01.21.15.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 15:43:49 -0800 (PST)
Message-ID: <fc6a16ab-881c-4a6c-98b7-2aae6b4c6884@gmail.com>
Date: Wed, 21 Jan 2026 15:43:46 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/139] 6.12.67-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260121181411.452263583@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211184-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1ED175FA2A
X-Rspamd-Action: no action

On 1/21/26 10:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.67 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Jan 2026 18:13:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.67-rc1.gz
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

