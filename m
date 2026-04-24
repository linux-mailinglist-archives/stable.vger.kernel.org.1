Return-Path: <stable+bounces-241026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFFKHlHE62liRAAAu9opvQ
	(envelope-from <stable+bounces-241026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:28:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E894E462E91
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 717F93028349
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953836895D;
	Fri, 24 Apr 2026 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSlsZC9a"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41492365A00
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058672; cv=none; b=Qz5SY26IJFPhSbs4oLnyr6tShNGBPgcR5I1ZCEp4/fVEp+XIvXHCNHhbBH94E8B03R1NWlI8fjDWhZAFO1s/CzLpTjJJ9i8Rmtu7mAx8t3vxiG8+Arvbf28g4ubTKg/OcvsMrGC0dN/LyS5SEQ10rudys5IKCUb+Ug1HYMYZUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058672; c=relaxed/simple;
	bh=8vADkQE1+kvpmQPAkB6KDeoJ+/zOXaTQ8Gf+2tvNUWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXksLk0CMZz2vNM6WPmx+cLGFxTyA0t1F8U4NbwAzI7Xv33CoVDF2YK60JcFZ7w+0SwcTEc/JpUvS1qxIgB7zFTdSQ7HOKoozclqgASXvbNFQVrl485xJfbDAPS2/GV1faCBBInGYqMXFYYGNL+/vsUUDzAng6lAMkQtdHkv7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSlsZC9a; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba895adfeaso9067417eec.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058670; x=1777663470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqBKFLkfnS5UJck4WAoyvk2PosDlu3H91T8tM7aG8cM=;
        b=JSlsZC9aCTM6IHd66JRp/1euLe1ck3O8GqAtB+t39TPCs4pop8Pt4kG2JS7YmNpcL8
         WZilrSbjd8DCqkVF/YM3UT6EFG/3sDLLbirinMlgngyYwaRjOOIqGEw9C3wemc6mjttI
         re1nSrOUDH1izACpzx6ui1wzInOxB23O1BnYoOgYuRwHAJYassE+Py3sgc2ID/mt+zwZ
         TvTvLDY1CU6it4Vy3H8zqFcpJpiytwK27gUfKKZWtoI+ns71F9aEmrE+jCOmw5FCH7cl
         0QyZGdUw06ueKF4a911jf71L6cPnzdHLXtLCeZH1qN3zLYALBUf+NVyBLyHai+j3SfmK
         wcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058670; x=1777663470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqBKFLkfnS5UJck4WAoyvk2PosDlu3H91T8tM7aG8cM=;
        b=nupxuMOsiWa7s+GMDo0iylauL1sgx9KRqvxDdLTflaWKIOnKEXcY26jNTvrK9sIXF3
         fB4XEY0SL5vIB/IA8VAbfwZ1Mk/ENE/yia2qw21Dzf22j+7UwFaprKPsh7REk7ZCmyPr
         PeiHtw6a9xqoQmb00IW8RKe8xVgxMvMcgpLxKOypN0Wq6ay3wwuMgp0WYERE3f1m13oT
         dsyZ5C6fftikYLDSYKGIbvDzDFx91+bExsi2sayHIUzmjCwjG9CkPifme8BPojYliupu
         DgRVnqZNGKVCdhZOsXHaVvvERl7NxO9w3jfeMjc/Fi2dl1SoKJ9ejoHYDrv7JL0yfNzs
         17Ug==
X-Forwarded-Encrypted: i=1; AFNElJ/Zon5nFBfC5vWKh23KL8OZbs9iLD74TVO8k44ocWjvi2CUHfMSo+ZNptpZt6Xb/C6DblERS18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSzU0xlOFAYHxDdz0uNbsbWsbdQ25ezOPCbNLi1TfEMFdmbYb
	qsGNJ7tfavs4VdquuRbQNhjbgkUEu5vtwyk7SIZbjFU8sTaYLytK06WH
X-Gm-Gg: AeBDieuW8U3/9gS2gH42MvqoxgwewAFsHU1IBWoR15u0089HLOTXdYs6Dee/pE2iAuL
	TKEurtPOxdmjDDvXQ+FBPgnwKB3yBd+Zt7DwfTpf1S/yCiY6NiKvJBtG33RG6G5P970Nsno1Ze4
	vWzGsE/SkYufw3NWCkiM/9GcVZ21eyLBB50v8DtOKSRM0e8x+1+AdX5IZDgiqg3KqXswciA8Jwb
	Asf+H7QgqzXT9XhFLOo4rzOXaDVly9ohQbV/K9A8RWAfEVtVBjkL73tyNTjsZw4pL2H7EDYloyO
	CYOFIAKOCWPcqFnlMgrEKmYylcEkJNzmMx9AyrP6nmGSPHw752CJpv4PTrx2xGx6J2JC9nNnm0m
	FuzMSN+rngcBHvlF8hwfr/5t2W+e3CYB6xDnvJO81+wPXBnTCh0lENlrIzyZhZFEQk2dWF+JXKJ
	thPslORLDNAm9Nj+iELkDV+i+NfHUPkEm6r0GtPgJW317fQRpIv0NT7wRDRKEj
X-Received: by 2002:a05:7300:51d1:b0:2ea:ed29:5a73 with SMTP id 5a478bee46e88-2eaed295db0mr56056eec.19.1777058670315;
        Fri, 24 Apr 2026 12:24:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm43560585eec.29.2026.04.24.12.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 12:24:29 -0700 (PDT)
Message-ID: <ba5f6e92-286e-4789-8270-040e55e6a24b@gmail.com>
Date: Fri, 24 Apr 2026 12:24:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.136-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260424132532.812258529@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E894E462E91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-241026-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 4/24/26 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.136 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.136-rc1.gz
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

