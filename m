Return-Path: <stable+bounces-223118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG3UOftwqGkkugAAu9opvQ
	(envelope-from <stable+bounces-223118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:50:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CBB205733
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D600D3069E6B
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21D3CCA1B;
	Wed,  4 Mar 2026 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZU6MxMV"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C93CC9EE
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646448; cv=none; b=CJuuMacp/xPs7wV5Xu9E4R5v/nhB7f5Cg2HC77Q79HsDZjmDhoYoHAxOnWYib3u9PxegsOQw4UPS4msdvVubXMh86iUV3eHmD/95lHFtPpsIRtv5+XCKaDlWRG8JiHX8eLSa+ULTG3amcuvG3ouAHKo4MSs6YFHexNQ6HF4hvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646448; c=relaxed/simple;
	bh=lyhuETUFgbcsXWmbTYd9lwW+f9JOzhXzkA98V+ls2OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGb98afyeisbG2bG/OldoRXiTwiiOyEx5xTu1GTcx9lnDTD2Hu/tjU07QL1u1iZfY6B5D8dH5zBdT0f9+FkoNIjZI9V/g4+kM4aLGRQwEh1AEzgIlSI0K15YLCqsTt6Pyrc3n41rLOSft9q3d/+OB5uZFpiYNbY1sbswseEt7vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZU6MxMV; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-463208653d6so5388179b6e.3
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 09:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772646445; x=1773251245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IfiUhb9CAEtVBxzFGoHFgkLPiN+xfkS3PmNKwc8D5vE=;
        b=OZU6MxMVGyWnNHbREA2bDTv8J5zLREdU5IswKOA1aQfuZmHkqtlB2rnXUF9RVxTkaX
         /n5zpmjR0OCk4y7ttnmEPGsCP4Rse9e4vzXYKNeNS/Qp8fWXFQmHVzuseE6TcklelnCn
         B9+R2KNfCEQtEsKGiwoJcB0pb3n2+wLrHWUeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772646445; x=1773251245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfiUhb9CAEtVBxzFGoHFgkLPiN+xfkS3PmNKwc8D5vE=;
        b=vL1gpkBGwThV3e+HxdDGlBEhBOE40OLHrIRZRlqF7h7MkcT6dTcZoGDDTvgn4h+r/7
         W0PqIMATT7VBhMqYqsF/IMy29XUVMiL7uGA2DGek9WIgma6So4zCi8XJ3n+xY/4Sxz04
         5NX8Src9x0T+6YdUrDHhGlmve4vi22oXCkW0IRf+gvywChoARgCx1Sfn9v/AtpVB9s5O
         QzV9Do1G4cBhhH7TMLRLz9lwFfqkQirDNALStxDqwzT2SJxYY19aX+iQMZrTLU1VbUAT
         eGHI9dSdq17+o3vYjSS9ya6Ie6iqxzIb6VyzPu8wewMTNEVv/kQd9MAxTv8qeXdpD54+
         hlEw==
X-Forwarded-Encrypted: i=1; AJvYcCUpLvNLD5NqdBRjKlUsuFK+MaKb+4eU7qeC0h/57Pl+TfJ6T3HX8f0RdENnfk35DknVMO9w2cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqNorbJG3PWcumKevFcG+zdmNEXLYpICWbhnr6wlDxPkCQh77
	Ag5byHlFFmcuT2E4qT0Vc40OL5SQj53rlUjrpW8hioeJyPHb0xJkjGZ8xSbScny5If0=
X-Gm-Gg: ATEYQzxYUx+1aZQEwMNQfngy9eVJ/s8Q4/8/gzkPmg1m2p1lvmRkEEjihrVLp/XVWXA
	owptzHKbdIGUVoeB276PrRL09qKm51zqjd5gaTtT1MJhhiwXtSDo55CUN0yasH1OkVKuvlbdzwO
	sD6IjYLSwE1/d0i5wreFzS0UdDttlAstT0BNO41dt8lpuq9KylFVt3099dQwh1d8AzVMTUs5BOy
	wsKG5pN4WEg3mMV5hQPvRFM7hIl3mCd8/UE+708xSWdsgfPaMbeYmjdfO/34J1bCQMkhd/fCpkT
	TDyepg4rmTySx4Din67Bs212AwvzRKLt/cPe3urNWwhnpKUE+JKDkZL3QBDs37jVsf7QCHkFlw6
	PJUGaZqj7EQO5zRXsVibUo7AQ0woHs2O3n9C7B9q5dJ+oYdBXykJ4nHQmUf4p22znYKyhAue6K8
	T4cycKe4Vi4KpXnthQn6JnE4Fiqhq0UIoEDbE=
X-Received: by 2002:a05:6808:150d:b0:459:9630:3742 with SMTP id 5614622812f47-4651ab9afa3mr1416852b6e.22.1772646444767;
        Wed, 04 Mar 2026 09:47:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb352720sm11903384b6e.2.2026.03.04.09.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 09:47:24 -0800 (PST)
Message-ID: <0583d74b-b677-4e49-96f7-c881dbec6743@linuxfoundation.org>
Date: Wed, 4 Mar 2026 10:47:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/850] 6.19.6-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260302160834.2518716-1-sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260302160834.2518716-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 61CBB205733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-223118-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Action: no action

On 3/2/26 09:08, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 850 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:07:42 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.19.y&id2=v6.19.5
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

A bit late - but here it is:

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

