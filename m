Return-Path: <stable+bounces-214357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ4GHTCog2m2sAMAu9opvQ
	(envelope-from <stable+bounces-214357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:12:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D7BEC600
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EDC130238D1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5C3B95F9;
	Wed,  4 Feb 2026 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlgcybTl"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9D31A7EA
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235865; cv=none; b=sRGwjPGgHu/h9OktFxJWcUMR/z6gN7F7MRn6mnlhyKh9BRz2KPxVhRzWC++kcjM1v9dQoEDXA2mVMkjaA2avW4oI3cfZXcmdigcW8gq8GWOxm6OYOHu9kMEqDgSHX/5u+rhy+zjwuCED1RIXtextyN7Wb8tuwiPkLSHfH2+xgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235865; c=relaxed/simple;
	bh=TCyssPZboGbxxDII2EULs6DVjfgqdpFkizVzVPMOWYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyELV/n5KxlcjvMBOXZKRrKSQbecvWBUG5VfIspSIwviHCdwW/WJFiT9AFL4l8f8GwlsB+1weFWtHam+Bn9qUXhAkv5tFp3OwZPvwTynNSbIGFCQ7wBsxDdzGVS5hfHDleWbELawHUdTz1eXlD038Yptd/P0upMw+oP7vl4iO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlgcybTl; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40a62601731so142586fac.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 12:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770235864; x=1770840664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgESDrbhOJMii9m51k5IWwkl14XFcJYuWviMIIIfabs=;
        b=RlgcybTlHYCQGa87PKOVbn9opR8eU5j2068enbTJ4tcFsFQ9+gnLSZlvcmSH86X6ao
         o8mjWZYSOVDvjIABK8aZ4Jp5pCIPVAwZyvuN4Fpsm0s2TOGKSGaa+R5GMAmTDgNhL5zt
         DD2dWO3MPBhiUWsEJevU3u9RyNuqSJoS5jS5s2+RiuKq+kcUAeAyoqSUVofTNDJfzxGk
         3zZk0ESts4/+aeLRtzwYmIjCC6QEjoLsqOV4XIWC+SP0mk8259JmluTFEH/bSchR34J+
         hGnNJL2CgkEDZPjl4SGeTH90y0GwDj1WGBE17jxTx0yhrpFUlKuRZ95ZpDBoaYd9zQ2w
         Tb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770235864; x=1770840664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgESDrbhOJMii9m51k5IWwkl14XFcJYuWviMIIIfabs=;
        b=CMkN8H7vbTlqUqOpo9bjRx7gN/SVFIIH0RSMbkBVhN1K9hdFov9OmXWdSwAYsLJysZ
         Fmac3jYgEweiyQlxPAwHM3JTEmXhquydXGp3GUtfXkKyMYy3RTZnhY3/HH0n/GMY4AbD
         sBypeACxia7DdHizzsYlClqL/DnrSOdGWijunmKgWo8BeqMx1bjnu0KQv8q4fzk0KdjS
         G1cad5G4IP/0O7MMOcl1tuGB8vR3ySiRQZA9cuMN4yvstrHCH5CYxiyW6Z31TByCvK1/
         mqTNuFZTgAKwvgI438Dos0zG0ZS6vcVUQg0xDYo6od0lJljCZOzhumNrcg+13ibRz8WA
         BDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrKRteDvfAzgTKPirgrSH3HUoF6/YvYsLRnrF6/xyVu8WZxepzim+oD3XgXHkOt4BE5mGd7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPeNcJ53WtUVREq52Kl6/YSr2VxXRlhX6dr+5FW0XBXJy88yC
	d93w/VhLgv7DcutuoCWQAExa/MzdY3VsrMtH6QDuDLomZllePTram4nP
X-Gm-Gg: AZuq6aJJ16lWk4DXnX/NMAejDwEC75Uu6LE8SsZg3VdY9NMlaTXIPSmiebtuZTse4JK
	mJh1OS85qrSQSX6ge7pRsY50yBQRrStcZPMbsQYg6rBGdxvas5pv0KxcRIRVPxC3t6xHP3ZAdav
	XOBekXAWay0QbAGbfcbROSCMXsBhbiFQBSrnUbsvwj6MKN10Zeqi4RH+p10Vacran08UsVWDfR/
	u1kj9qbn4dLg+xvGUWisNpceOhh5Rxxb8bXtZZn3569z2J1wMnA2TbceL48KdKzDh5pNnbs9yht
	JbmOW4J8QfNZCnOUghVsmHkYOdgkFeFH/ff842BCC6g/DIfgcTwHLCEk5Et02vfaQlF8O13X/UK
	1okNtQE3uXW+BeJ8wEqWOs8cNQFVIQ7mcRlXA6FhVZMTfgLGL5F+JZHfTNcpU/syVeddglNCo1r
	QlA92r+NtMihm7aOUKL3tTPv9iaryJOSs0LdowtA==
X-Received: by 2002:a05:6808:23d2:b0:44f:e7bd:274c with SMTP id 5614622812f47-462d5a13c93mr1849743b6e.51.1770235863737;
        Wed, 04 Feb 2026 12:11:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d67d07absm1905840b6e.19.2026.02.04.12.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 12:11:03 -0800 (PST)
Message-ID: <fc04d4ca-4a6a-4524-a6ec-d8427a94e90a@gmail.com>
Date: Wed, 4 Feb 2026 12:11:01 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/87] 6.12.69-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260204143846.906385641@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-214357-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 02D7BEC600
X-Rspamd-Action: no action

On 2/4/26 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.69 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.69-rc1.gz
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

