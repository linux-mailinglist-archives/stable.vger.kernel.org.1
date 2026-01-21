Return-Path: <stable+bounces-211185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NfjBQtocWmaGgAAu9opvQ
	(envelope-from <stable+bounces-211185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:58:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F75FBE9
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1418B747FE3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18693ECBFD;
	Wed, 21 Jan 2026 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtJwUP7m"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385E4418D4
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039855; cv=none; b=EodHe+R+SS3hxHyNsR6KEGEFZtNifrymabVjsonCyqr9wyv6V5x6LgI2nfvsW+RKyQ06XQVG59jIIJzshIgZ7aahCPPVOmAWEYxGDfytj4Q9NEfYta94f57a1vswbMSv3PlXUU9pR+92AL7FH2gZWlakHeQKx2hApGZKRgZ6Vb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039855; c=relaxed/simple;
	bh=71JdS4nMo/FS58NU+6GP5reojeLKtDF+/Zpu5qSEMUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLmgbrZnkRL4bkHW+2kppUqSQ8jjvwTlqqwydw5G/RR81rJfKKP7pSuobFMx3jIvTIJZ/HOJLp7PHxH+z+KpWgoRe773j8N9a7fmY1p3HX1aJGDcwPvmqR+A5GpuhUnjA4mDHYGKBOBk2W4s43sZ09M/xisaCZdYwFXplBFvg3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtJwUP7m; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b70abe3417so842516eec.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769039852; x=1769644652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KANMVHhWuIaqormxj4ZjkLPh9PtQL+9rIhglDxqvv1o=;
        b=dtJwUP7mswP0wNQ5kDFUJCUymd7gQFw981zD1ZNVcz5XTA0tvCyTDVe2/3JAxdq+E1
         VzCdkbxKa+ja4zIuR9Rwbg+Xi3VV5e40GdKf8Eh5x6dpGw/s3vcaDKEEIdVx3efF8aLW
         udxBIP6E6Z0mBV24BhZJwWXShfhhJknWcagvqD26wZJoE3IGiBU/FnEEGcUIU9ULi9md
         KCBu9HhzlOuVAktw1Vn04KwP/+6BQMFYqKZi90IsEm2E0mW2i+TxwbLB4U0kM1QvN2XQ
         8eV/GOcLPB78UTHOov1qRdw8aBVgb4bWkH8ysl/4x+RHB8xQjB2WU6aEcEK4GkCX9mb5
         hhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769039852; x=1769644652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KANMVHhWuIaqormxj4ZjkLPh9PtQL+9rIhglDxqvv1o=;
        b=kogVhBxPKG1zKEYUEUT5KW4dIHA5dTIpvwHqeAFNkVzeK+TRUQrIwc+1gEGc+s3Usb
         W7ud1gNSQ5AXHlEHmHVzfSGZYegGEgvhX+AjuVZzThIUg1tu2D0ZGrInAc3BAl5pzf4d
         Cb6HJhOcUKr6dSFibdqNqbdiTvvNImQTYP7yaTLNaO3xAyMMv1cW300BwiNoJfx68j8P
         mwof2n0aTLAMm3MpxvFjAb9+xKB3BFvqUmrtx2h/Aa82SgJSMvLBkhAEibZEBLl68TL3
         kjMOlOZSa9D3LVCSUlDjLMkmydPi7FHytfHRhUF8zlDevAnzpgvtt92NH7wHbRS5HTBu
         2YZg==
X-Forwarded-Encrypted: i=1; AJvYcCXlzTO7HbVAnu9Q9GCrKVTBm9nGPfzT+9Xftjnjzb4MvIu2Jm4fXvWCegDg+xn+l8R7vryN7cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBsAaekCQuhih7dQnWXgQb6M33wGNMrsEprx04RZ2ISh5sMzM
	v7d2724eu61BOtfeq7cqJDrFDBx9r/sH42c/1vUWvl/oRqlYGUVV3ZVN
X-Gm-Gg: AZuq6aKGcUbei3Iltr9gWcvQMFD0oFAZs7ZfSUbKwWtGRlJUJcty5alBRgkFIu93yyX
	raVLhlzy97AFWPUGr820j+gXfXnnEZ9W0knFqM/fJLP0sk1e+78Ihh7ojiUdAi2BiKXoH7xNMen
	KJS5Uka3GPY8QUg5L9FNf2H6U8qpook4Cbq4Z5Jz8giH/ijAxE1YP8k1CR65bw/QzorLkWAm+aK
	ytUOFSRa+Tl25wSZ1RlEU8KbNAeUeuwNQCCfLV/qyPi9foYxAcqZnku7ILoyaVRjK5CGJuMYpuw
	0PpdaPNLCwSlljfeWjiAg8k8YmCQRoNHNDvArxNvcp/VGU79szkhoSGFV0Uw1y7h28JYkr9OdsU
	wsOwCkBZrF/tVnena/uw5oCIM12OICJNCCyx8bkBMKP2qLD/kf1FAVgT/53MiqOztRusySY5J0D
	7QiCAZNCcJIuiqnLdKWSwpJaQCj2kN1fQw8JKiUw==
X-Received: by 2002:a05:7300:e7a3:b0:2ae:5ffa:8daa with SMTP id 5a478bee46e88-2b6b3f13a00mr14244651eec.5.1769039852012;
        Wed, 21 Jan 2026 15:57:32 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm23030014eec.9.2026.01.21.15.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 15:57:31 -0800 (PST)
Message-ID: <0d06aabe-94ac-431d-a121-a7b935037885@gmail.com>
Date: Wed, 21 Jan 2026 15:57:29 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/198] 6.18.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260121181418.537774329@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-211185-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C24F75FBE9
X-Rspamd-Action: no action

On 1/21/26 10:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.7 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Jan 2026 18:13:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

