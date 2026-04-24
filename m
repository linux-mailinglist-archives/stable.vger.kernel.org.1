Return-Path: <stable+bounces-241043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PnzJPva62kgSQAAu9opvQ
	(envelope-from <stable+bounces-241043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:04:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A400463649
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AC563007A44
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0331F983;
	Fri, 24 Apr 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT7dwBs6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E728B4FA
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064691; cv=none; b=K3Z8v+3E4hWlbwNp3epxNXgwLnTRccd1qtsJ+NvCyXVl0tDlXqcAyo6c1T4dIvEM1DHgGepImJaB2/TjMATmh3aCsj+qluiqJBGTM1z99Il39eBZC/l/+D/j7hd1RibIUcEr9I1rQTJFaf1V2LmMP3kih5NoOvhsHZnIdYlUMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064691; c=relaxed/simple;
	bh=0/KAzMQh92kq8MZFZL5e1nLouaj1ZWDwRaanPlShioI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSex2Y7oaSgvp5rSu2/xs68/aJuzB8uViCK300B+S40XVBiAJoQ2jdktZVQCJQnTYEmd9a2DDgaeakkvABsnWMaJB1l7ZKU0cy9eTVUcJ3IlLVtMnFWv+nzpL31SBUpx+7HAV0TlAl2lrBe9YyQNDmvFaUIV+n1TVezFnFnqRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT7dwBs6; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c1a170a50so10664394c88.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777064690; x=1777669490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJF2bMoTCrgLrGhdgLcSDtTCpej3MrR/F/jXKc+xbKo=;
        b=GT7dwBs6XBAX13uL7vZewJwiaar0bSFdJxyOXdtkClUv9xuGVXNWpulecZb8IWDlSa
         /YfOmUcIaarjGSssdGTs1YWQ1O475HSA5QKyb+JlcRHqswbsYSIr7cC4te2rWltbo81s
         QgJYNy6ylZxZy0FLjnnw5ZSkZHquEHkvPU39aGodzgJzGgHoaDVV2gPk00DxLy5w7NqM
         CIIwBjdwB+h2xNw+LZ8tgpPo3PTZM0MKQESLCp2rJf6uccDwFZpE0qArmAMY5bM8ezED
         X4X2moBVF8YEx0Rx/rtlH0yeZCX4xeDZkQqzbJ6HcxXjhRWrP4Ov6N9yuJG5zrJnhsIr
         tvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064690; x=1777669490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJF2bMoTCrgLrGhdgLcSDtTCpej3MrR/F/jXKc+xbKo=;
        b=oirPsyn5COleWoxBHTgRV2McN0UAarfdbut6ZGl8nWilnGoVEcFIrl2pdDHsA4dW8D
         6HPppBAXEwj3KBYB7e/T4Q8GO6rPsztab1wXhx/xDmurYGaD2pqFi4fJ0JWKmOrhyT35
         2hv5Hx2IJPq4s3Nqjt9gHG6CbhXmyRwlINXVYVos5gNEaCwS9dDUJRJZWfCdPzxdW9qy
         6NJOrZPHTiBVAi0bIwjGZ6PjjsyUwJdM+OMPWJOeQC1c03Gse+vvsSPeVL6X2BnldXry
         C+A1nsU0WFaJPdedaIclxf1BRxIFHADus3lYz7jgurFtr2SwobOikdcKYhPLAOyJrl+g
         MagA==
X-Forwarded-Encrypted: i=1; AFNElJ85OYgzWyRwr9u2ftPU8+WxT2iWqQsksQnqbVPUKfKra4z6ru7jGNZCeIKOab/gb9gKK9DjDuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIUo9Nf3eXqKhJ349qJr6Tf5WEcUuF/cqX+k6lc5MiKMR+kzs
	Tc/IwZZYF+Rx022oibAnsrj0wio7sZFy1A0wnVPubJkgSojaEAsagV9Sr64wbg==
X-Gm-Gg: AeBDieuk5ChwYwHZN+bHc6OW2tTHov6yoCcI6IabWc7WY65M5ICV5+TNCcAHg20odf1
	0Bo0XVpHBXkqG6b9zcONxaIz6UFAmmGNN3mKTf+pR5hYD6ESkTShg+pIgVWCLn977rlKlwI1r9j
	T9rOqBB8aAJhMiT0QMNXQcMPdo2Boi3202LofFmWRK0P0tQ/9bEDwAzkLZtyXBxvAwh02lf3y/2
	NxoDS42/SVqvxGh4wmb+FbnHKjIQzhzbBlJ5SoyRqrBNiom1jyW+b/0AdFYETYk5KnCkucQjYMx
	ZRJmvDCf2EFFlAb1D9JLVMxM4jCN6vG9RiDgUKeKHsf7BusZAR+NRlQYRXWBic5QDOt1g5euGBB
	5h3Syi+XWCRxIXM/PX67mEkJQkI1++40l1QEo41KQYqPDkFunZva8zBIelpEDzMieGe7Xkikknx
	TNfVI7EVkg/qnx2SbGzYLeM8igMfPNwS7VntfpVlqJ7rkgrc+mbWkoSNL7aEhg
X-Received: by 2002:a05:701b:2306:b0:12d:c3fb:14ac with SMTP id a92af1059eb24-12dc3fb1874mr1929800c88.19.1777064689672;
        Fri, 24 Apr 2026 14:04:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12db8684f90sm15698896c88.13.2026.04.24.14.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 14:04:49 -0700 (PDT)
Message-ID: <8a46ef04-1b7d-4457-9d1e-d9da18221e64@gmail.com>
Date: Fri, 24 Apr 2026 14:04:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 00/42] 7.0.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260424132420.410310336@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A400463649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-241043-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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

On 4/24/26 06:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.2 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.2-rc1.gz
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

