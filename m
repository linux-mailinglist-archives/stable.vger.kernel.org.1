Return-Path: <stable+bounces-232816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAAZDHlHzWm4bQYAu9opvQ
	(envelope-from <stable+bounces-232816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:27:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C7137DE82
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 829DF3003981
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C83BD239;
	Wed,  1 Apr 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1styleq"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEB2F6911
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060455; cv=none; b=i7HAW0KzNClNGIBueqRDZoqSN8PRxpLMI8u5FOKQ8yvLM18q2+9y5Ms0tGRVwnNwaZ3hQI/ATnpV6Ied7hiAJAjdRJQrc4WHhkRsMLSn+vo5D9oLJpEfd5vTvCxhzi+wWaj995pP5miJ4oXXvheakExgDvL9xQYPzqFHZ8UMByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060455; c=relaxed/simple;
	bh=1DDtHzgrdfkKCkx0OZ6wRB0AX9NvikiGnVCz+Vob1a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twSRlTP0RxOCvATIAziRz39dvvi0unFIKE0xnKYv3oJa02PsDfawGfPe5bl2udmp6SoNYNDYU43mtIkwYwFQdKTvxqSWTBZuUcD837Hp5W+k/9DpVFTbjTpldzDKGIPWZg80nd4eCfxhdYWmmf4QDxHsaXrAzfChxJF3M9BrKaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1styleq; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46a9ae3f857so1779573b6e.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775060453; x=1775665253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WujfaJSCGDeMyF313yVCjBGKmFvswNOtDRgJ41L3Qo=;
        b=N1styleqZMyhAkUNBEkPMGdSIgfS6PykPSztsnLj4meqLmDWeZ+Fvo/KMg86OAatW9
         QDaomUpbvSVx1FdSDlJwSicuy5ro/D5eCdoM9VHw/vEe1E4Ag89FjPDt0ulob0o8/xGM
         51jlVOXjJt2LI0rQM3I3CflUp+0/2lakl02Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060453; x=1775665253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WujfaJSCGDeMyF313yVCjBGKmFvswNOtDRgJ41L3Qo=;
        b=hrz2x90j3eM3scsdmQ142epUlSx5B3UcO7noKcCdWlPogdoe9AysKe85ZxEmZMbBp5
         RyCVJO2MNGtsYGXXXwlb7SMNHLeaTg7YiJ2lR761AkOoT1XMtGO+y85fKWtobPiuZ/eN
         R1o/kKEwdnJvDQTAsSybIaa0acAlrX85y6oMJeLMtJEwgMoLutDNm9/XpAp5bzCIeVJA
         JC6sk7bPVHPs4T8QlxSHnGMJTpKLiHjz/H/1OO/6jwvoCCT9Iprqx+rCTqZZcqEPewI2
         BWvnKbKGChhEzGBqiqeLfGPsuOzYdyKwxM99uBLZz9r1lG+DZUpeRvz00ZCG/Q2o8zm/
         062A==
X-Forwarded-Encrypted: i=1; AJvYcCUUrvgwVeLqx6vZsARViI7q3e5aX1bgWeUzki5i8PgLHn3RLtX/vOA/fPWm0uSKXpvCLFScyUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKiEeAgtFfgHo77CA6+mwZRG6/yQZgzleK4dmNww0QxescE4n
	TSlfrCceMu7vxXI7xd6EotfZnksAK4kTqoVr8epZUe3yHYElMBA62sMAv7xQ1Yh7Zbw=
X-Gm-Gg: ATEYQzzYlE/bloef3hIROU0Te5ZORD+IhLJ58J+Fl48PjXenBPugDuAg5H3ZreX1ZTm
	exG/17HkeC2rTiHXVKSPa+rEt1SrU2u/2xEV2PoNYN5iNTicIjFeiNx60LEBrQNElrVX/JqbZJ3
	1Q308WdUOBYzELOYb/gKfhmYxgK3M1FEXobrAbDB9eqP1b4frYAATm/xWb5mmcHi5lPEqfRpqU1
	DYJzaJmArSibPAFx5V2mjyFyqK8SI6zjxe6CShYzO/clKmhqvtTwtKTosDP3TiCbAx/SanlGYc5
	Us/tI8OIAaYwqyKkZimNlLXjGyE97LAIxxH19nmrJJwZHWqod3yWcXKfou4Ms5VU5M/SuTgZsxp
	xncrk9z7aDyVRcV0BewHr1ClLyK4Qv6D73Ryg6IWBMdUDFLWwS7FmbN58XxjyiMKZy8yMGUI64s
	DM3i1xFFZ2jdrsjNBA40+d61wlnULDHa365ihRWWT3BAWC8g==
X-Received: by 2002:a05:6808:4fdf:b0:467:1e5:6764 with SMTP id 5614622812f47-46d8afa09fdmr75672b6e.54.1775060453070;
        Wed, 01 Apr 2026 09:20:53 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa03e4acesm8942997b6e.17.2026.04.01.09.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:20:52 -0700 (PDT)
Message-ID: <5fd503e0-363a-463d-9de9-004e35012c38@linuxfoundation.org>
Date: Wed, 1 Apr 2026 10:20:50 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/244] 6.12.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-232816-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C6C7137DE82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 10:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.80 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.80-rc1.gz
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

