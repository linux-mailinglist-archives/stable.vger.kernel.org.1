Return-Path: <stable+bounces-247022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ej9LeHQBGr0PQIAu9opvQ
	(envelope-from <stable+bounces-247022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:28:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F1539F12
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21E27317246A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846153B27C1;
	Wed, 13 May 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDMG+VS+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3B3B0ADD
	for <stable@vger.kernel.org>; Wed, 13 May 2026 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699352; cv=none; b=LRGpTP5nlHH9rbaBFIjD15wMCOipNTLMVBlm/52zZxH22/hS1T7ld08aN0sYvzfdhP4scdg95cDuTQ0ZNnFUU7oYDcNf6rHkXRFzdKXED3Yh5hvSMxnt6obU5Wp2/0Vn6GHVWyQNRburihWNLu5NYB0nUe6ufn/Oin95h/p+ISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699352; c=relaxed/simple;
	bh=QX5G2rB7ifXMkwPdHvgF7zs1jKDfOFey5yX8c24qomQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HFTqS5EzepUJqa8vhRezJuKoE51RZfLfCMuS5v0oVjn7mwIsugXj+X9Unfj2AsZj4PB9FuPsU3RKcHjavFZMtyq7oVoG5D2gEA2SWSbTp2VTi9wETbahRrSj/aCIbtJ8Ml3DO0AdHmSUQvJtBybEOHT6wVW3d2vGDy+yR+JBXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDMG+VS+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e5c7eb565so69174991cf.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778699349; x=1779304149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UtNWbA0oJC/4NfkSFTFtpG8npNpENo6PjEJYah1z9Iw=;
        b=tDMG+VS+/VC3E27ViYeUohtgsl7JtVSrAu7HEmoUUOmupKVj/rvNBwZ6n+67m3Z8n5
         wE6FOEiS6tJImUJ5vWLok0hh2I8gNBB+M+yL4LHoCKj4sRJD0R1OjdVP0v3sWvQJQKKK
         f1J2vctZQP1bjVkw6+kpMGjV+jiuNwCnDKdqnxY42HN8vrd/lRt31JApO93pFjZbtQUp
         1z/xITr4PLHFmGgiKAoA5/G6ub5wDaYQUMF8MEJ2jhBdJDbB69rMBZ3XWDk5E10NyN+1
         cWylqxSobSo/Fb29yvUuMViPlOpaJfUH8h31aT8UFt98BUzRJtDX+1YQ7YAP+bSM4MVR
         09HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778699349; x=1779304149;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtNWbA0oJC/4NfkSFTFtpG8npNpENo6PjEJYah1z9Iw=;
        b=qBK/ewrCCnu9Jg7zAfrTLy6n8rP9F8t1RZ82pxuahbvuQL5eCOM/PQps1MXzlKw3Ej
         x6Yi3UzvBNVOUu9tDBPk2RK3ddLJzMsTaVbDVWFP0m3zwrylBu+uDk4HeLoCk9Sfvxmc
         KWlrq9v9m/vS2igWRhzMXAHCi6baNNyD3yD8Mx8Q3xBNVrJcGEjuylsGiJKo7Dq/uU0w
         N0+kl5hrkBg9RDOolOuyyPqQf38FZ70p0I4lszUynmA1NQ6qdXGDWMRaDmFM4NBO78fn
         R0s1iznuuIlvnKq76/LI9klDwNi2pQSpM5UA+uHjJGVu9+EYshzmaf1wrNfzPgQJ7j1H
         lu9g==
X-Forwarded-Encrypted: i=1; AFNElJ+3vCIzwenDCDd1N7PlvIshYi+MFWU7GMK43hUXTo5lU0iChp0sFvXtoy374spIOTlcZw2+zsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTuTdWN5n0T/rZ2o75TcVRjxiA6JEdYwb9F0PpSMYroj42AsAj
	i67+AO/2BUtBD1t2HxUS94587//orgw+E7meIeHj0U9UZAd5ewKGa2db
X-Gm-Gg: Acq92OECcpuhPv8Q9kHhGVvBDLU5vK/Rstw2/iz+t+7aiVHdrY89lyjAUPR62uWZlFU
	Tur0V+M5Egv9Ei+5+Gxd9c5zuDqb56rceVNYtAtqLnp1dAO5mRDZl3u2jBH3sYR0exZocGQTVhh
	52fwD6bC0+11mLFE8CyxsojD0UBRwbbN0h5dfFh8igBALDwOJUS5QRuaOJG26nXMbBMnTfYLe/W
	eh/rURt+ffrRc4B4YzKYMGM+AcaLZTMkSF7A7f0+WoFLA/7hJn/9GCeOQGS2XbhSdL/1Wpr7x/a
	m17vNubASYhkYGjon9N7jizAnv1kk7cK49I7+ou/jwfpLijiJowOIcU3lhelYxArGXoM7isAaOA
	19V3dTJp2lm7E3kWM+bss8LEu58ShJsK/GGpTyiooAWiDhNjx7ECd0UICUdevhUldiELS+fKvgw
	PO8GrPJybvekVi0b7nNX1XLGGPlt+aGm/kw7Evds9gfQIJp+c3yTKZ4/LE+fx5
X-Received: by 2002:a05:622a:64c:b0:50f:b81e:c655 with SMTP id d75a77b69052e-5162f68d146mr63497791cf.57.1778699348501;
        Wed, 13 May 2026 12:09:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e830ddfsm153785331cf.27.2026.05.13.12.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 12:09:07 -0700 (PDT)
Message-ID: <268c8519-84d4-4795-b06c-4159d8bf48f4@gmail.com>
Date: Wed, 13 May 2026 12:09:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 7.0 000/305] 7.0.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260513153754.934923793@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260513153754.934923793@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 421F1539F12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247022-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Action: no action



On 5/13/2026 9:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 305 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 15 May 2026 15:37:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Same perf build issue as reported for 6.12.y (and 6.18.y FWIW) due to 
older kernel headers with our toolchain.

Thanks!
-- 
Florian


