Return-Path: <stable+bounces-248911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEqEIeCDB2p06gIAu9opvQ
	(envelope-from <stable+bounces-248911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:36:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0411F5577EF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BEF2300E3FD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC230C176;
	Fri, 15 May 2026 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF3tAhKY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F423A9BD
	for <stable@vger.kernel.org>; Fri, 15 May 2026 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877405; cv=none; b=cLYTtOqjEnjkqQAiiHH2zLUwb6V0Ozzw/p2SK1fuZ/lUwgIGyyRDdtrV04ZLdHiTL6kVC2r40pp1yfHtZS0/cSs03gbVnvEM3JRUuK5DxF59jksjOSQUfmNCY9IERi7GNvAUX3+q6PdVAo8eJ1RXQ2dwNG1yyJ1vW1nyc2tMapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877405; c=relaxed/simple;
	bh=AUGauvpW8ZQdtrjJ7+4XT+ajh18tzmyPgzRezBAnS+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU6CyNxmpNAQJpr1oxf6HP7kHDd+F9u4ZUbVBypmHR1sSNxpwxERU6+m8Q29KgNTmNRq3C4BqPZqytJpHRU8UTF1AwI/QmbU7OGrdcIeXYtnefLvmsmNWg8T/dg4Db55t4OOE01aH/rN0F4fUapzoU+Fp0EHEyVhnmNa+yEEb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pF3tAhKY; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso299387eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778877403; x=1779482203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4mFFwQJHfvlMsdIT8D+sKLdk6VQRqNMYh+zPM0xL60=;
        b=pF3tAhKYaH0fnouX4rpJs8WUulK6h3AJCwvbdbfOXTF72QL045cJu1Tcqvgq00qupl
         3pxmgYaHPJrqpa6K+VuIagJJ9ndthJmRcyyYaBwKkbjySXgT7eUULOuJP3qycDlTkjZQ
         Ubh7DYQHV0KgbPymtZS+KT6l4PEVRDJAplk+bEnCqt0XLKmiHxNdyAbALXDcyaPn4ry7
         ps+uoRM14Mkw2AC2npWeMvVaCKKiZfJotj9beSFLZfm22Ic/aiXIK/hL1qQGQ1PKjFf0
         IBaMd+Dlsb9taMVj7JyPuvX/LZyIvhQpBGQ4+52uYdmI/J2Pf091QxPrAUYVnuvedycu
         7RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778877403; x=1779482203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4mFFwQJHfvlMsdIT8D+sKLdk6VQRqNMYh+zPM0xL60=;
        b=Y06qN5PX2NapPgEfhrBp7VLrXRwDC75btEkwCsHYQkigk5BXx5noyRD/uvkVOoyDq1
         XSjOSrrHgO7YE+lATBi6m1UkI0gx4PNwVyp9nRGNBheIjL/EzcF7HuPICvxqk8rFPonA
         uze65qRbkQXUmHf+2VcCVKEr8L+u7OwrYWgjfZQZxNYODFLsLZF1YBz1FcLiChNX+4kv
         YBM2+2TZ2CqSUmumOcNnQ3syLJ3ahn5EM5Qd41AJttPu+Op2M+mpBRkQPK6xWm8jy2g0
         tuMNj3MRgOND/sbb6GNx0m5jH9ltAJqzja3tdxjHw1VC5smLRfkcr6beBrLGPpvtJVUq
         jzSw==
X-Forwarded-Encrypted: i=1; AFNElJ9ewbLS5q6xZhyRYb1+Rn7/RsEkddJVLg1yXxk/XpwGytb2lvTGyVBg+ElMB1RBCPnArGLkJwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJWf2B3Q+kM3sbfrPernA0pxmbUDTKHRpLB4s3v6j4bqYjHLa
	dGpKyMNA3rByJIrL5RIWGiObH1mbAUBzQsErc7+8TYCeCtJ0n31pqref
X-Gm-Gg: Acq92OEq+8Tpj9BatCvTLRK+z33OXm73Uhpk1+U9kkhHnxPWMDeTnAvqXERJFL72/pR
	UTHOCQh8lGkdXLTdiQQgraIOFM+KL2XCNf/jV96on79IWdY8ompPgwScyrcxOq+LkDkvbkhCdAi
	zl8AhL1RLk9Nu1DDSBRttY7xSpVMCQE0ulOP+wyrMRDaYu++oxz+dZ7oFpkjGAVCu5m8E2o88I7
	bPObAtX7NOPkZXo6Tn2CkoIQnY65GkWg31JW+Q0Ro92w+9lkpaPJTCxvHT1pPmT7ii619WXm8Vs
	Q+3ZNRt9bfKgDdIFhccpnZ6ZTsJG0NYR7/3e62Zs+1b5RNVmn6EPvFPX9YWzk+dd99sotRexfEi
	q3SWTcnXphliuNpKdC4/W1PcFnGdERMAH2K/yZStAczAJDFBWEFbitZFbrJQQhGqIk6P1/2+HwR
	cLJD3uKRk4zUmxSMetySt3iCijyNk6PwbD7JyEoLlgnploJmyt2Q==
X-Received: by 2002:a05:7301:644b:b0:2f0:4268:bc42 with SMTP id 5a478bee46e88-3039869954amr2698850eec.25.1778877403273;
        Fri, 15 May 2026 13:36:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm8188616eec.4.2026.05.15.13.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 13:36:42 -0700 (PDT)
Message-ID: <74244fcd-5ff3-4886-a28d-fcaa49a91a6f@gmail.com>
Date: Fri, 15 May 2026 13:36:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/201] 7.0.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260515154658.538039039@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0411F5577EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248911-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Action: no action

On 5/15/26 08:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.9 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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

