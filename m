Return-Path: <stable+bounces-214552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFofOTX8hGlh7QMAu9opvQ
	(envelope-from <stable+bounces-214552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 21:23:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DFF71AE
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 21:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55813301DC3A
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58E930BB83;
	Thu,  5 Feb 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+5LMXmr"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17C32ABCE
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770322992; cv=none; b=phou8XsyEKnMI/yQj7yDt+/jIJw6T2IJbSjGqhF7blUeacX64deBlIE2YbrzX9aOMXZPK3lKBXd5oZeZ5moYhNV9fi8wFjb0hijncTGC6f/Fj26QQTu7Cb7EpZU1HLzn30rp3w4QS7UKZK3X32AZLzz5L4eAzicK1nIpVTY5hAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770322992; c=relaxed/simple;
	bh=1H6yOvlkgfRdhfiB8b4StbElJFSjTj0AYv822Df4Usg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTGbNB/BP/RRjFk7ByjzaGdTX/Gfi885KOr+V/BL7YFAaJKklVg37wLGTb32BhaZ/LIy5xm+o2rwRWUZkl2YF30HcGHiukNs7HvBrgU3SMjrzHak8UzM8oHx44bZMPxhJgu2svRnGIpud9Odg4sOjmZV5342oqw76I/FfiD2oBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+5LMXmr; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-662f30d3f1fso1437553eaf.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770322991; x=1770927791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQDPSDXDektpkBXEs0zQ+AUHNiEaUoVGQ6uI5fG7CkA=;
        b=U+5LMXmroh4cGDQrUTb9q/6gaUDN1kJ0rH1uxsVpkXxSKrcJLK4sDJczm1PK5Aa+Sy
         mHfba8IKMGHxbbVKPjJzTkCAQTvQaVXuhl6U8D/iKxW7YF7Z8JvDTGsHMylMHaM+0LRY
         WAy7Nk8qf0gDgzV8EQGw7rXa4JEYiJJY0VS87gotvvMYr0z6Ul47m29b3o3PrIJ3SBHj
         k0YdOTeibOsrpDAbSS7in9zUhhodkd+jVKmBEmTB1OdDufe92C3hHIXQRTAAGIsOO9Ur
         ksD5mzy/7peG45u4SzYFcW9z70+0XMvgEN9X28ZSUUoAaL11Xjk9DdXHERhjU16RaK9D
         MGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770322991; x=1770927791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQDPSDXDektpkBXEs0zQ+AUHNiEaUoVGQ6uI5fG7CkA=;
        b=LKt7Pv6n6UFZIf+rMcKRaqj8EYv4xObbKrSSeNVWUFmnJMskcEaOwQQ+me+XrIFurZ
         BQYVGNM1QpLgDNJ5A+zOXKmvK9L7CVPGAZjWgy5AnlcJ90Rea7hlk3Bu4PQkT5//I4wL
         K0nP8x+Tj5v+ah3MMwgW0/wohYiS6/pQwSXDv5b8lyCixXILENqEcbYV0xXgip9NB+3B
         qfnmAxH799P8dBteTAW29AZWyjInB7+VEmDx/2xtS+avd2Vs6aAOGpPXBgRJgbfo6BnR
         N4vJRsllI2TbekEq8BOp6JjKVejSG194vjAnxIh5u3SCligqWGhMppvH8GNt/UnyWCqc
         QF4A==
X-Forwarded-Encrypted: i=1; AJvYcCVctletOQahUDEe5WC5VzAxo5VN9NqMKpbz3vNI2+po0LiGmU7DX/GnEtieY07ISfS0YmWtVAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1V9uDbU7L84Zy4S3DpgYYCtB+1PaL4AYC5iOSGNAgS2nJI04b
	zXe+ELSKUjs/ronXEbvv/zuEpFfDFviL9Epjwnei11O18prKj71+xhyp
X-Gm-Gg: AZuq6aI5DCIYDSQ8Nb8iMfFfTkjlu9QEudMMjXnpRyafhHEPNeIRDAl18TKJDNAkzit
	JHzEkx2FQYPouPumll7udT2HCeSFfw+Ml/5L7cukvQRCCL1hF+SVpMlWlvKXHgxTRoM81YAK8Y0
	FRht/gQjyKsjB9WbtA+JPr9rJPi8qcUVAR534+xGJ5qSZnlHUyBb97Ccl3d5qsjBC8CiKJnth8I
	006mOU/NFI10vOQZ8GTxFir3pS30+yM3nPYrVNu2rYIeDx4tZVRFUoEc7y7uvnDGqPn9h17birS
	RmMdU4jJNk3yDyAhtFIMWn0Jd7PhVeV9bMw5IuDtXVTmZduJ3PM3rqWk/avUB5ld5xbHFL81cZF
	w5ceTS9hxfPW4bMFaEEIITGrLeWLw1wwH5qBiw68YMvLuJSYWGx6DNjJT8rHlq8y3JJWS8Epp73
	KuviiBhMq+qGBOWyjVwyt5eQWT46kZXN9oEM65Ew==
X-Received: by 2002:a05:6820:160e:b0:661:154a:c289 with SMTP id 006d021491bc7-66d1534f706mr274351eaf.31.1770322991028;
        Thu, 05 Feb 2026 12:23:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a992ede02sm157502fac.4.2026.02.05.12.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 12:23:10 -0800 (PST)
Message-ID: <bb053dff-cf88-4750-b678-09c215579e20@gmail.com>
Date: Thu, 5 Feb 2026 12:23:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/276] 6.1.162-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260205143450.492803005@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260205143450.492803005@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214552-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 5E9DFF71AE
X-Rspamd-Action: no action

On 2/5/26 06:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.162 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Feb 2026 14:34:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.162-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

