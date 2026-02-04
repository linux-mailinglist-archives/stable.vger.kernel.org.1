Return-Path: <stable+bounces-214344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p54gCIqeg2kLqQMAu9opvQ
	(envelope-from <stable+bounces-214344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:31:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F1EC138
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 798CD302800E
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 19:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF51C6FF5;
	Wed,  4 Feb 2026 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpUAVuVW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178D23E320
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233477; cv=none; b=FkiN1DigpRUUiO/YVA/UHswAmmrUfJb98DVbugG12ua15VTc81zpx0nh1jwb+TUtLjscZOJLlfmY+DH4Bz2NFacSb0y/Q9ZJpv+VJKqA4vUKzcWNiCl2AEE04OLnD5dt0ehG4H/X81z/2nKWHHriX66DXb1ydeJjOGIoFsBNRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233477; c=relaxed/simple;
	bh=1wVbNCL7mJuBFv3mVOLcFDU0DouuXiCE9Qn43xJuscU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4/ySyUDP6nKugJxaQJnj10Qsy1FrRrq8jnefTKgRpao99hzsUGiXbDM6DqNzxbQA3STRyCC0sc+uwd+qwZmESwO2BaJKVYXDK23QDS9I8v7XjsS8ut42+rWznD9QsEPwwmox0F7VqeZqlV6tfJa5m/7U5Nca2CuPC39hzqzk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpUAVuVW; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-66307e10d1dso102181eaf.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770233476; x=1770838276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/NZCfJ3FeJBJ3Z7n7uLLlEjb4EHcHxxuD7Rih9R6Vw=;
        b=UpUAVuVWwEGXZtVRKe+8TvJYPbTpUwJKG5V3luBIkxe/1N+Q8qhMVeEoAf/M9az1Ly
         uDjvNUGOVx1NcWPYOil43SynOwsB4Ft0dBhHovtemvlKOnoPUBKGWpzUtUz0jVk43oZg
         ehTDjVLc+cFny7BPnM9SzGvziMamKUwZH5sTRAsjLOy7pXK/3z1LVUA6+H19S3GuUGTU
         KdBC0MK6iCYSzcTwQHHrnIZ/L5uzLPUBGLGkfqj71hus5nCTaP1UPuWWZx/at+gKOxR2
         ygiZAQit9EUNdmQqqup2EwX0gkpPvzCrwam/Cvbv3qUV6eEe2sZpwkqwdrYvyx7n+Y+A
         E0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770233476; x=1770838276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/NZCfJ3FeJBJ3Z7n7uLLlEjb4EHcHxxuD7Rih9R6Vw=;
        b=U5/TmX+Dch7CR6jRRz9j2X/DNps/MWUZZjAdxqBytdfmLjqiSQ3k7oWjoILtPgPst3
         QibXDeZzXwIM2u9F1XK2GvwNfPkyWBa0gYnySuZtHURtFvzoYLTUsH3SQYaqgzThdFth
         d5Mm0X4LLHi8gaGl/CrF2P8CYsn9R52XIOZVU1JdLKd7nG89frylOui6I72S7EdWvtia
         2Tneq0lfxkPfeGEgPeQ1JMbxIyVPk3M4NcW5LnbA2yfbWJ/oETji7hzs6VE9KN3Td5sP
         x7m9nd9KBtDnDfOC+Z40+geu8zudsTMj2FWI1QH5q5BdVvZYxFKJy8TXrzDa9Nofyevm
         Kq4A==
X-Forwarded-Encrypted: i=1; AJvYcCVhkl7ZDAH/5Z8NOEHm2uQtIZAJv5/+U++3hwVm/ZsdorGu2LJHRjaI1OR1vC2kG7qaALEhAA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OAkGP6V/2DW0UQ0l8+iTvCsc/zA3fiEU0SkpZRYP1dYzeTxU
	S7DxNoOtLScaVgVmg+kfF+2BsKHGq+9eaXpQkedhlclb2hrJ9YjR5/r6
X-Gm-Gg: AZuq6aJaeNX/s0060aSTdE2AIGSu1odKlCw/fSMfnnt9o2tVynTfPBFRAu6uTsnP8yp
	m1R7d8uNpqm3A6U2gqT2CAmJVpFl6qPWcUBp0STo+Mj5ph193651ZmEe+voGPlxSbMfSNOfLcZt
	v5csBe/eC5djJPPf/OwMa9rZxRafhxVWmbOb9mcsOF9TtgUtra35I6XLIztgCbtr8QW4RoGi3H7
	ZNG1Pv4gMRrm8Zwke3Kz0t6DPz+cuP+l48O0g3+fNnX/cCEEtBIfZpRHNLJgFCnqHXdWDmVrK65
	MNuFqpumdPoavIbf4c3BTOFzkU2roSPpp+0IM8Ial5wqxg1OusuzoOOtxV9qQWtHnJLBSVfqgYA
	jSQ7sInYOuhzbouPcQsAPTc15Zsujinquqpe8FTVI9tI+H+jKIIWUOzoDjZ3yhR1lT42waSY2rg
	y3YvmoVlbMUnsdoKnwJkS0kVoSW7jmdbtMDBhO0pcl5wh5rQmo
X-Received: by 2002:a05:6820:6ae3:b0:659:9a49:8f70 with SMTP id 006d021491bc7-66a22979c30mr1849320eaf.53.1770233475810;
        Wed, 04 Feb 2026 11:31:15 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a354bdd76sm1813640eaf.11.2026.02.04.11.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 11:31:15 -0800 (PST)
Message-ID: <5598b605-df7f-4490-ad73-45d6dce9dfa0@gmail.com>
Date: Wed, 4 Feb 2026 11:31:12 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/161] 5.10.249-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260204143851.755002596@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214344-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 634F1EC138
X-Rspamd-Action: no action

On 2/4/26 06:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.249 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.249-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

We have a new warning:

drivers/scsi/scsi_lib.c:321:17: warning: ISO C90 forbids mixed 
declarations and code [-Wdeclaration-after-statement]
-- 
Florian

