Return-Path: <stable+bounces-241032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGnLBkvS62lERwAAu9opvQ
	(envelope-from <stable+bounces-241032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:27:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BE463309
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F183301BEC3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21557381AE4;
	Fri, 24 Apr 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqmKZxvx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5E347BDC
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777062471; cv=none; b=X4TARC/kd58GqF271HYIRCWsUemLLzoEWN66ySyPcAqijxYZRI7uTecIVo3PgRrJL4pQ5dcD1WbgFvG1e2oSaBtUQRGK4ekp/5rLASnHiYxXaDVPofjaDQRnUqwuQaHuMaxX9BMLU/aGf5LcgNhLxvcycqTffIjFfApCfAQrZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777062471; c=relaxed/simple;
	bh=72/e5fgKea2425Wp13m68CVeq1yzKE0EtFY55hVE0uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGpQI7VMLHC2ZoDAPCYK4ZNAPVAGKxltVTpQlaMjCHjZMIJW5pOEA28Q/SYPa6HN8uSabHgxsl0eWoFQ+YVRk0HZVbWp7bjyaPvb4nieHV21z0vLtWE4LJqYra9d4SDkAq9jy2YvVD2ICDmp/zaUT0net9PpuqtdItxGsK7YPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqmKZxvx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso91102486d6.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777062470; x=1777667270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hns6WlVS3Vqy77Haz+q8JSAZERUIlWuXdOePL/cMISI=;
        b=RqmKZxvx0/0A7s/4g4Z8P+/bIXFKMlyKRqt5DTmm9iOBiD/JxDkiYXryeNNbmB1A+C
         bc2R+WDj5qFAYU5wj9DZjy23VspRb/GMk2bvgVxFzE+Y9NVegjRok/2T1OaBQlTHcBjS
         dWwdL3nsPbJ/PvpaUdWaTEXD2Mf8YoWpOIu4FyBljYaR6PtvOiN2cyVvmqTcUK049jjq
         uE86DyJLGnNIaPPC9dEKw3WpLN94klt3nUDtS49AHG78GZlPKpoGO0KRrZGS8a1lm7ZI
         ZWHfbOxd2YoKFzDcFWgnq6sZU/RA/wt2USmuGWM+vXCpoAY8v4PX85MfE3vcycCyq7mm
         E0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777062470; x=1777667270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hns6WlVS3Vqy77Haz+q8JSAZERUIlWuXdOePL/cMISI=;
        b=oOV2PZ8AQm8Ka3zLIFTHtuda483JMrGi1CnJeZjgHSe1SJ7qACFWoxDU4BFetFyj7J
         +tKMTDjT66/3wyLkMMSn2yhtr2Map9CGNZjDeP/fmAF6waWfwr8i3gtOWof/TMkIPmYI
         EGPaQhqxe/UGuldUDzgmoLCJngxebdSrvOW2PSmAHcbDdZzL3wj+f5dCpu149voyKuSd
         Iim3PSys757H2o62ozE0qBt1JENBoE6kD2NIm95brdsC6pTuRD+rpec/Ve1ggo3dRC6r
         GX9qYP+Z5PP7pq3qGK+mQ2fgYxk3UjIxymRZ/bhYQD1TBF0AjZ+R1MrbeeGHeYUXrl3P
         bvxw==
X-Forwarded-Encrypted: i=1; AFNElJ9FXM7cm67Pmm2zawLhSmbgCwfP6sHYxSWze40VIlv24WCsISIvlJO0gEBrL3XHyIBbQrgh4Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzMLrIFe2+XfkH8oada7aOXrQ7Bk9pTKB2IySZ0RvLNOa3QdW
	t8floV5Ykt7qAiqgiwn/w1bGf3FSNJ0xsFXaFBvnTqyUiiNDmCUFtqUU
X-Gm-Gg: AeBDievvMx0J/G3hvUqhz4EoZAt0ROdtJmypLP52jyPFPLiS4AgMvuGW+u1VjN58YfL
	4tm9DzeFOAOd7hT2kfTxtj7Vfrv+ujTLWGaWRjN1abqVgbcD2w2KzstgmLyblhAPvms6HtLHq2b
	ao8ts8ShBY2nmbAO6/gEeyF9BQXVJWLdEgCyl2yyNF1QXN/mDr+WOfFBnbl4cLXSdNYKtjvuCXA
	1rqWmTzXJEkf5q6Z6J84P30hhODE1Kq/2TqAZUJ58ADTYtg6xMLEA2L4EWCvDORa3TpxZFr2/sq
	sp+mbmWpVmiqgphOAJ8qw7EcsBg3t8FpfKudSRDwJ+Pd7hbv4yp08AxF49RVODfW+dLjeirlZAq
	/3cY7uuGzqOe4ft9PSrIGzindTkUzehn3NolAuvVfWtP8TOANduQzfMqtaw5QZb7Sh7WbIUHpjP
	tWVhSuXhTPZr8z/ps3n9nN+sYJdLZRtSHSmh+hfWFpUezufy0LuCk8KzqwlEG/
X-Received: by 2002:a05:6214:3385:b0:8b0:22aa:7137 with SMTP id 6a1803df08f44-8b028156be1mr549744156d6.45.1777062469640;
        Fri, 24 Apr 2026 13:27:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac77546sm183330706d6.17.2026.04.24.13.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 13:27:48 -0700 (PDT)
Message-ID: <f16a0538-cf04-4e41-bb0a-d667281c49f9@gmail.com>
Date: Fri, 24 Apr 2026 13:27:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/55] 6.18.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260424132430.006424517@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E1BE463309
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-241032-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email]

On 4/24/26 06:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.25 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.25-rc1.gz
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

