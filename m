Return-Path: <stable+bounces-246925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMU/H0amBGogMQIAu9opvQ
	(envelope-from <stable+bounces-246925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:26:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CC537059
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AD5D30F6FD8
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091A4C77C6;
	Wed, 13 May 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HIcTQ/0U"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C373911C1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688987; cv=none; b=rFca73xDY865FZhWcPwQ6XqDSoB8aAci8P3VdBlpYoqGczDwb6170YUv8ErMuJL4GdDNRtrQDOCHn4MFlAdQOEr/i5HRzs3s/nQiDajnHQsu6R78cNK7S7n3axZlK4uM6Zfu/MGcHPHvD8mRVVAm24txP+fFtf/KLUzIBwDXFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688987; c=relaxed/simple;
	bh=XQTwzYPVURBlHWEdONVSVsJJzSDY9nkNJ3WY7xVrkA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxoeJLv/MHTUSgI9NoXX6HFDL3fttADioRSJGENDTzLsHm+rIF/4IXDuCY4k+l7q+QLdSaZq3tHjasYxGGQT8Z6X/GpMsCjv0RfGpN8LMqn7mQGPspJ3w0nr4QVCLSlh7LuggfH+5VYfkJ8f5ayHTZxpstZf4L8V8IE0N309hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HIcTQ/0U; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67e09232daeso4298753eaf.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778688983; x=1779293783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6Eejlp7oSyunKKcN3YLsdzZb+7PxrsXrqFJYgS4Kdg=;
        b=HIcTQ/0UnqF7k8RGDABg6MsuM2re4Ky4LMcJ5tMRFoe/kkKWXd/9qsZI4GwmFZcoma
         sE3D8hRuUM1SiSsQiK+3orzoGSM3PqOMs+nPv+KBD0ZoTcDvsNefhLZyGLvgv/cPteMP
         zvm61oL7sR05RbZ3cbH76hbW9k2pgZ/jBk4xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688983; x=1779293783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6Eejlp7oSyunKKcN3YLsdzZb+7PxrsXrqFJYgS4Kdg=;
        b=MG9jMaqoEQp38cODt9jlrOa2gguve9HmG60MlHLXWlFc2Xlzt31OxQUtmsPlVUtxav
         6rrByEI97PIXuoSinPsynk95dGg5/bBL3YNle4E5ZmDpoT3k20e7961Lze+9K6Sw97QK
         ROuWQCqxvuB9s7ANcDI5+pErCv1l53qLvlCvMl3X2kmON1YDiiMUbczV66HoRqUGDfaA
         0C0QorsSM2+/Ij9KiIbIXNf/8xy++8HmicSdQiXc/Iz4/UL319LRQmF0BAR8Xh9fM3en
         aFSX+49s3k/9Zx1kA6beeBGMkJQhbZe/bKNYy8kfggpI+qVHdYPmyvpCPTRle9fD/3Fb
         AM4w==
X-Forwarded-Encrypted: i=1; AFNElJ/iunrKFjhtJ7bkC6VrCyJzstAV/ARkyjoxnsMHiZcp2CPTyVuVvs2hbtVGIPtukLcDd/cCKKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VyNKTOJ5lqCtIl89VNJOQwVdo7u4N9VDZDue1N61vEOtHUXz
	Cd7TDCi10uq5yxlJj1CBj69a5pZlrkFTDyqj4nJBa82Us5E/x9L9d7ZuGuoaXtZZx5g=
X-Gm-Gg: Acq92OHEjhCb/r4cU+2N3sNjUOzM68BW47ZORfhUtqCGVCGBhWk39A6G1JD2/6zCYhK
	bBzVzOrdz3LcS2Pot3npjWYFw09pA2OCL4pPMCQOxlBhn9yy8peS/DpUo+4CXrPwhgZH58YM5Zp
	3LyUN6QhupfTcS4+t6MYzK3tYylMy4rpjpl4Gq4zbIZ3FRCebX97GMJW7GPoGCoaz4cWCfzaNan
	2lTCuEsYMEq8/Kwrx5+/etmnfLjdCqF/2Dos6Bm+TENF4Ouj8daKuwxZaVRsrXSli5zhBmkDBkX
	FXvu4/vjSG5wxboKXneNsGcTCtdE/MtRx0yT/keDPrasgcK4XVlaycPaa2vt6dvxcHdaee1YigH
	5NhhBGy0kLkp6hs42BSfJfu5YcMgBOMgJgLKx/oLqDIO6XOpoImvAiM3MXL+/K9m7pM7FFtXdMv
	xagOrNrXy5j+oAZed/iDJDhIosLU196eI=
X-Received: by 2002:a05:6820:994:b0:696:6c93:e81f with SMTP id 006d021491bc7-69b7ab3361cmr1853130eaf.33.1778688982936;
        Wed, 13 May 2026 09:16:22 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25e0e79asm9499281eaf.14.2026.05.13.09.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 09:16:21 -0700 (PDT)
Message-ID: <b8ed00fa-26ce-48c2-9deb-a08efb1ef8ea@linuxfoundation.org>
Date: Wed, 13 May 2026 10:16:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/206] 6.12.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0B3CC537059
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-246925-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 11:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.88 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 May 2026 17:38:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.88-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

