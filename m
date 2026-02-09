Return-Path: <stable+bounces-215546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOFoHkwsimkjIAAAu9opvQ
	(envelope-from <stable+bounces-215546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 19:49:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D27113D62
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 19:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316DD3017263
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AB53803DB;
	Mon,  9 Feb 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5EsyCPI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A463ACF1F
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662951; cv=none; b=QNiCa+Yx8U8DlrSVSyh9/MiIm8g8iAceL3t7SWi0HE8V/6siaJVCT1evUYJ0zpKOaPOINLf2Sv4rU5O3GuRh2DDQ3D2zOUCJvAIiEaRH1N5KwEwqeE735NCGyk6K24vBx/s7iJQem90FapLCwE61IMr6M4MB/ak2CIkQ4Ex80uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662951; c=relaxed/simple;
	bh=OBP9YfsO1ONxZ+Nu9hHPILZ5miGi+cYyFL4ueH5k3eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1H93PF8MYqVNkxXu8FKwe2NspyvlvuL2RnFaMoOodC0JGD1RN6PZZ/bQi/Icevf7/3r0YSTeZmrYVMfVxRC11J2JSUSHCDfRw67Gb/88c0Qhruc0cu7viYeVVQtaL0RF35J2lGwTxZKiXIR8dO86ASuGyBwtiFmKjEtkdlHZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5EsyCPI; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4723985eec.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 10:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770662951; x=1771267751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ew0PcY5M7Xc4Nitj9H2O94wUPDQ0Cr3Y47he92sxLuo=;
        b=H5EsyCPIVTbWAdKYsZixbdxhASkOHMVQtRZHwqfpS6LQT1YA+ZVsDMvvRNHLgRCwMn
         jxK5Q4mHa+jtO2krBvh05NFmux1ZOf/eImHj6Vs1L9uklUNLpJV/h3+7UC8k4S4/Fg3V
         aQNu7eIu8rgFJ32jgJhGLGhfhhaLMURFSBudC3NefSgG3mU1aP1loVxqmQGIQDjWVThQ
         CmhQEp1O09+/RJDqqV9E8zfonJciMgLEo7SmPx2f7LVOhnpQj2sCCGv9axUMOlclUGj+
         2oXgvmfsggEgDoDMTCnzF1Ruj1uCB6wdLsUj3hYauF4E/mw0/G1Pe4ZYxJw9Xaa/aINs
         CwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770662951; x=1771267751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ew0PcY5M7Xc4Nitj9H2O94wUPDQ0Cr3Y47he92sxLuo=;
        b=FSUNHf5ga5D3eOdh09q9ucBaSnS5gdahCYrgbemDiGRNfqvbL571lBQfJpQEN87vsk
         6GZn7yZ2KCbeb6EOmNO8i4TWtxC4GgOeBOALIkO3Rlvb+G/IPaHaQswu/mskbG1DyHNI
         G+4Hx4yU7w9wh0U3ttptKFbDx+KyqhP7vyAnbDf9vwjyezoy3U0A+dnafXwNv368XgLF
         SCQToFbsDqpU/Cuj9YIunmYezQazQ83voQyWf3x+zcdOavmSyAHnBN7UBFY4FrGn2JiS
         u93759zgSvxuiG7vAS8eiy3VEqwLQj/v7ciXDmX+2agUdml4ijzN4bddNK73D5cIAS9C
         x43A==
X-Forwarded-Encrypted: i=1; AJvYcCXfM/rv1I3qLSXHHym9+j2MIbvLZRWpbUdXmVsOsuWSxYByjav3xieD2D5AAMd301H9/k1ucts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3/5rLTgpmbMMfEyrTmwGxDgv6jyldzVQTvnywnCgAhEvbB72
	bCqySjK6M6aAUOjLTcj35+e7RJnI7YzN8eaW63wTHsD6GYE3vPPKwyg2
X-Gm-Gg: AZuq6aIZMiJ83RsuYkRcvEzALnzvfOu+siwqcmylz0FblqNsuwV9H00+BaGE7RcYkv8
	vh2RruwAg5j1I0qSv2Ic0F78uywfUddVfkMld4Ugr0oonHX8mVCzustxbHEXCv0LfouhhLoIA6C
	4VNcB0Dzx3xryS6uWh+zR64f22rgm8NjEaX1oR5xGi3ZYw9S8o+oe1ojQIFzfCzXOiDtNv2+ofc
	tJJPpCkOxRJh5kUKZFs5jsdTXCWO7OhLCH2WePB8nT1gA8+o8jBB3V+ptTv69qWCat9Bs3PzYYw
	zWZryIvDtmUvxUFj/T2tiaxrornP0HhcTPB4HRrzApptUzoUCcRE57UtizOMcDUOKOlH8RWZ2ww
	oR1aVvKhErGhteL8a4Cqvr0LzH2n70SrqafOBGL1mXRTFJA7j35VFJwK9ZrdkJDO4SOfDnG6fnb
	GIWouICLXgHa5cU1XGH8zVR37gmMfzB4ZOhmIm2QU6RnW4A6chmqNt
X-Received: by 2002:a05:7300:641a:b0:2ba:6d87:cf68 with SMTP id 5a478bee46e88-2ba6d885c37mr1639927eec.16.1770662950495;
        Mon, 09 Feb 2026 10:49:10 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba734ed83csm2419418eec.23.2026.02.09.10.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 10:49:09 -0800 (PST)
Message-ID: <be01e537-7df7-411e-a4e5-061f43b08b28@gmail.com>
Date: Mon, 9 Feb 2026 10:49:02 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/75] 5.15.200-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260209142301.830618238@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-215546-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: D6D27113D62
X-Rspamd-Action: no action



On 2/9/2026 6:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.200 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.200-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


