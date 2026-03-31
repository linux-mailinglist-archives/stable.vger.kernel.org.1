Return-Path: <stable+bounces-232591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBLBKYdGzGm+RgYAu9opvQ
	(envelope-from <stable+bounces-232591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:11:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F4372553
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B103022620
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE5D466B44;
	Tue, 31 Mar 2026 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhNXqkLc"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8545BD6B
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994958; cv=none; b=b6XKTkayWlHFoYpJBMTuOXpXXBtDCvnSd5ngRkZTq1wAVQugevS+R48oNOHoL6+NxvFGCGcaP20c6TuemmNMSZgtxYjILxkniXAeWAqjXBvZ7qjvSRYcNLrEOVMkN1x5K8b5fctZUQcnjfJch9nq7pyJvxdtfaC4VEXEIVgYOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994958; c=relaxed/simple;
	bh=aCIzUS24G7f7mlW4FQqkMFZge3gDg/UjgmEjiZgCFQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMMF3wiBJz7MTYdC3ipBL2oboLMErQcIWCwMRofWPWhNhRGYuuMC7D/8NDB2XSjijP6+nBT8qj9vn2XXJrrvU+hb7I8XnLdznF7L21rIFqOLSEaZCfn1JP9YZwsQ5j6CO1yFH2/OZvbKCERdnxDfuiBPO87CNKlCWNA4t2QVuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhNXqkLc; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12a71ade78cso7433109c88.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774994957; x=1775599757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIYjut8AQhdxjU3934zP0YIqNhOY/AQmYnZZkfDPxAc=;
        b=DhNXqkLc2ydh1bF434QrGnaSQS1Cw9+jYOKJbqNzOjG2TLzMse2BCONzsMdMBxly+o
         f/lxxilc0fmzjTq8nT2OGG1jfHmfGXe0uG2mLMkfQXhY+8oFvLFiwcDf53qnw5duFIAa
         4j/Uppky9prmYEU9Xj819+MrNEZv8tV+EnwuhEYRk6JFVBri9RzC1Fcm/PjDtm4J2h7P
         /z/SXIxNsUfcxtI7dE3VECi7qe6eeoLOO4KYrS1adOs41eL7EllUTy6wEV9t4jNilPdH
         OB8QtLwdOnkhF1Ks2aDRXMGDIXYE3XjAXMhSVaCLqd7Tt+J+J1yomPpuTQAQtgAOrpku
         lBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994957; x=1775599757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIYjut8AQhdxjU3934zP0YIqNhOY/AQmYnZZkfDPxAc=;
        b=cfcwNwTbHQ1z0QVx2ew+LYjl1bR7K6solysPKE1GXuNLIVV5z2O0fe0FWJq2ja1gyh
         Vb9FsFiBaN59fjk41jFT5nunwJVtFPQHb+eNpRVzKVjMpyvF/1FyV1ssnfnZuYpAh2f2
         xvB1Qk4E9/NS9k4VMAZO1NSg4It096lA7Nw/c1Ds3iA5tTWp0y/Om8GNdIf05IeMF8Tg
         2Oo6elhU+qARiADXKraUwkgsifxY6x6yU6V/kqQ5ctiVmGTkcUAGUnu1QHyP/ySiH0l1
         UZa2cgxt1ArcOaNmYDNwjydLQlAJ116j397+HvL0tWwI+nnFoaQnCfNKvHLoOeJkpSCg
         NW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq/151c5v0sOiixwWSnuVOhs4oQsL3AmQeOuJ2U83U3jaHFSq02TAXiXjGBfEakWSRaRfj8jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37n/e+43bpzv7LBJaXMoE/m7GXO4PkWoh07euKTIWeSwQB7h9
	q7ogJAmpC3sqfBsLkdjZGL7OQsar3Sh24wrko+I53jh6fwehFdt6JbxgcLkizA==
X-Gm-Gg: ATEYQzy0I0FCfV3LdrZHPrjGicwbr7LutUzxL0XPcl9HwmiwYs3cSMWR3IT3pJryjdf
	MqrSEZD0Wk7oNOZfrSjCG741x3Wwqh1HQGJDoXFvYMPSeYtJKBlHmYwOiaUj9PZW+OvwE4iV6xy
	TRnHfcFiKZHEpeXANA6QR5IGWB9MhsulJ4eS1LMB4pYUqd4L8G0cqhMws+EPe8OXJtLaMmzGsVX
	3zATl+uYfrGTk0LA+CzsTCvdo4+35pwrGxUwjN2oEJAl0NHsRz/I+rXPBMYpE+CNWIib6fKS52f
	newhtsqjHLmkRU5n/imXqhDxrZksBO0Vdxsk2fg1YmAQXt9owtL6s71/D6nRfSFT3iYUWaV37Iy
	XU+GoASsLnmxOy6bRyanGWK0/mO3robqsj6QPWDFtyxpxu+MF/ZN+fMY+0Bgbvu5ed7CwJ0ZQoA
	RYNPmKjA614wYvstP2bKZun43bTINz1r5Qpvxi49SPOQJeHHWorpK8cpFBkqzC
X-Received: by 2002:a05:7022:6624:b0:12a:6c7e:bef2 with SMTP id a92af1059eb24-12be645def0mr693705c88.7.1774994956715;
        Tue, 31 Mar 2026 15:09:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm17996118c88.3.2026.03.31.15.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 15:09:16 -0700 (PDT)
Message-ID: <b5782135-b241-415f-a492-dd585c820edd@gmail.com>
Date: Tue, 31 Mar 2026 15:09:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/309] 6.18.21-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260331161753.468533260@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232591-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 287F4372553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 09:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.21 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.21-rc1.gz
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

