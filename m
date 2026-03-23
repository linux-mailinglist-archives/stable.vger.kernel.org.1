Return-Path: <stable+bounces-229999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A7eAZmRwWnFTwQAu9opvQ
	(envelope-from <stable+bounces-229999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:16:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA802FC0CF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D531301DC3E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E1C354AC7;
	Mon, 23 Mar 2026 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpwRoRHK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1D352C2B
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293368; cv=none; b=QAyrjN9WC2kS2IxadoCgrCGdOvCA1TGwhsK/WuJyGB/xNSiy5QhRWYDuomtT2TwCxZxFr0qSzp92vS7B+Gg7GHqGpoOXEgr5Irb4BB6O60cdn5z4/DeNhieVHBBEhb05VtlpQ3dCpKCHNW59PuRCf+30rbP/JpnlFyRqZXGsOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293368; c=relaxed/simple;
	bh=LuskhlyNg0ufpBPxP7wKzs3JY0fbuHaYe2UNjI/yZOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+gULaSCRoWm8Tipzbv95IE5W2BpsGYtSuTATOEazYwjHu2sIJ/1zt94Y3S51jSDkWWsICzJhR17ir8iZ02ixH12pz93b5XuAijmIvwvsPg5627BimgeOXVBROOhieGRun81pW2GSS97WgEFgABRe5EO3fo4qvtkegXFTt/9AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpwRoRHK; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so4476094c88.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774293365; x=1774898165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ib4kRlGirFvOGOu/hN40SMIxQEJK6ZOLlpFibxVMz5k=;
        b=PpwRoRHKe3TC6o0zvBy6AgZ9IV0OUbTzOJJGKBRCybmbcq8LUZ1z0dSFZ2F9JyyGmW
         b543tc0IU/lZgb9sAp0FEK8uGjZOEAFu0lpEYBTODJpYV1uu/NVkf27A+o6uo6OFuXOe
         KIc36qC6x2oFLVExiNl7PWrZmxXYtZrfVR1pQEEyQJLfjGT/bmkXUlR87ZmeH4J78I6u
         7VVtAArHZJfXAXoKN2eyq2uYUWakKuFKXzud/4VvrVAjLLTI3tLQ3/kKgYHX/FkjTQSe
         FZUCMZYAxFQGvwD6Bhuw26xE0Nhw9gsOhTHikSPxJdtT6vFdlaXuHirBmP2J2QtWJAus
         WL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774293365; x=1774898165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ib4kRlGirFvOGOu/hN40SMIxQEJK6ZOLlpFibxVMz5k=;
        b=eCHiyn4vtkXfVlxUY6Vz1VU3HO7FFXb0pASGoslaCwFd7CnitRh0va9lAkM5ZnyBSm
         OCLEuc7IqlsaUfZTcJ7ixz/ldFwDMQVNnzisqurTJ88TzgBJymDQOtK0cuFTSxgBWkOo
         kyYKcASyf08vzXOpj5EAC1oHWjdoYNig60d6uEzXOXdEDw/8AjVPh8iGuaOQr4HMaS8a
         nRusEBpUmvBHN1OmmmX81W6zM0nHLU6On6hqqX9GjTThhm5mWH1Mz7xaR3hwCQImQDtP
         lZcJ4es5hsgllqT4QrjljBTbpVn8Ps4sZeHgMenjQwOIKi9pXD0i4kwkSdjsoNvEslSV
         HWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSMRAREniGcR77X+aW31nlP8f4u4+GnASl0X/UudI86uGP31JS1aA2u+sz2SQuE4MBvaZuOhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJ944q2Ic3CgnI4oo65KUUqpXLtci8OtfbpNH1NJ3grHCtHhZ
	ZaMC3Dp1atRDEkbPbSUxm9BZFR5hhS/xUrLtlZIAQt8sIjT2ySOr7t/C
X-Gm-Gg: ATEYQzyNxfodtP7sEKMCDpfi8OJlOFr+6HEjS74/WkdWw+WEYaTreRH0wkSx0qeYmbC
	EZCJ6sgk4vIegK0GGqz4jvCP/mYirbmn9mfwGcoAA/0GZxHAT7nCVMoYspAXh5/z9NB/Mu0+QkS
	tlz2dnlBbloRfQptg6tKtA6AZ3JfkoLlX7p9snzA9s8/Y0qzZM4Lgn/FQk7gabny5EJp/0Rv1fx
	+fpNqyghWCyGgVRSDPLjVleNADmyYzJW66AwLlqeP3QlByd//PBzUo/sB04ajTRB9De8uR1+T3h
	JnOVTDJKPQR6HjaAglv+tROOVyrv5pzn+SjNd9dB2XvQF87fwwrnK8zqEIk5MiZivjsSgBo59PE
	78diQX1W2EW9bvkpcO6Ox4tl2Y02Z7pGggfpDNg3kJ3A9KZZOwCJZ8gwFDf1nk6l2vzAd8P6zPV
	Pi5K7ywIyvxc/l/ND19UvGnPpuhW+Sm8qM/E67YPpUwobwB05jCA==
X-Received: by 2002:a05:7022:6725:b0:123:345b:ba05 with SMTP id a92af1059eb24-12a726e1bc9mr5647972c88.22.1774293365429;
        Mon, 23 Mar 2026 12:16:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733d199asm9456675c88.4.2026.03.23.12.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 12:16:04 -0700 (PDT)
Message-ID: <7f93eb95-7092-4780-9e58-a13e7634026a@gmail.com>
Date: Mon, 23 Mar 2026 12:16:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260323134525.256603107@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229999-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EA802FC0CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.167 release.
> There are 481 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.167-rc1.gz
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

