Return-Path: <stable+bounces-247040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJooDgf5BGpuRAIAu9opvQ
	(envelope-from <stable+bounces-247040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:19:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B053B5F0
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B1C13019D18
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 22:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A18339182A;
	Wed, 13 May 2026 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA0PZi0g"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4038E5E9
	for <stable@vger.kernel.org>; Wed, 13 May 2026 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710785; cv=none; b=hb+IpnaopYVayjErE4CAU9swjNH0KCVnxkN2MyiZUTaTAc4s4V5Hv66L8Xy6DA5bMxySnnAb9u3ms7IuzKLWCJjaL3W9Ord/K9gNan4bxblHv05GcQTBwOXgAJgGtGzdo9az9ofYOQpM0PFEUsZETTxOXxkFVDBRECE8BWVeSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710785; c=relaxed/simple;
	bh=cxTxPuiEpchvxoE6s7FBoPyKjzZaCBOY4cXbh/fZYUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcMb+ugC6kSL3I4aX/IVQpYeKZzGdrbpRGNda+IAf7EXTsxgQoDSVu+MK1TDCBDTRLK0HPkq+U8BAW3r/LyEVUwmxMmOnaNMAVNQ6j5Hdwy1ulA1pauFedSsDy8ITN+qGIEm7NC3eq8jbuY7sXsrm1aetC3UbS5QMvFP2yKJfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA0PZi0g; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d6b9bca48so88411981cf.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778710781; x=1779315581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgwA9bz7u/SZRuejSIAFTZG+KPn1vJm2yiXaNhSWDjg=;
        b=GA0PZi0gZLbJwkRHN69s7zqccJ3XXGDJ5YKHrMxyBZzBkq90Xw56HXOTV9+pfrbTSN
         H0Ayd2fxTK23tkXl9rQt73e8SpTjjNEin0yc6yNCyfR8HWGG7d2DDqF9qx3GHaLfLUMN
         ZU/cUtV1L/blbeYjRzAzedtDIK0dsieXRTVspC4DKrOduv/fW4J+ADjuNRp3HY5bWcBd
         vr3HZuu44zf2GcwBaha+I/Xh0jTHkVE3oYVCJpLw6dt0pXnju+QC6s0Gvj/+A2hyO4AW
         NHFqENmFzDcZIFvSx5QD8uLMb8foRVgRbZMc0kgJXlOxJTjYcumcNea0uqtRWvFY/fFr
         yKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778710781; x=1779315581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgwA9bz7u/SZRuejSIAFTZG+KPn1vJm2yiXaNhSWDjg=;
        b=On2pjxR/2fOHCwK/NEqmqhihqsQHb/XDYijB5YJ/Hf15Kt1LFTQ42lOjHQLeBNU2Y2
         ttW60xq/56v5pMZnh2TCs9hQ/RUcZnpyXfci9dBpPiaXrZEzxlgj//WgQ0GJXCuIt9LK
         25pp/i6coLNJtl+5xNm5mcGQ8YQ7qLnjJibCOcd9RE5hXCTHN5b0l1eOvQQPVk0uez5s
         h+xPpsV3yVp412/CHGBfyT4MRYKB1zF5YjTHtDZrbSyB0xQt2W9fyHWnzaJkj9iEnc2K
         sayIvVlaT4W5TWg8rCqJOOjcF8aKrvxPOs4Wb7ws3pl8JzWrNtLXfxn8Rwd5UI++P30N
         Wxzg==
X-Forwarded-Encrypted: i=1; AFNElJ87M280aRuLua+r5Hs8o98Iwqq5KH5kQc2FrVqEZKrkrBHSJngEz6Hb3SlkdpET/PKvfOgqIcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aDJpkzPiuD/cRovxDsPXxlV4mJxLRCyJwlJ8BlitwwIQfzJp
	lybyzYnXMUdbKO0Dnzg9HNrRfSipXqsfvF1wXNsqtUrObYHqYTyqwJ8i
X-Gm-Gg: Acq92OH1CocIJylypIWoH9QdcwEeBTA6IVNZccc4/l6cUYyxtmvHk4AOY3HJ8SzXCb4
	++e+F4oHOsnkxPZ1jfwnmbZPk+s1/y6LqfM0kGEY0Qf5xzXN2o4gYZSX+Bc9882GkfemP8gojo3
	u12VGmlBT4JNsuofSaJYt/MhIiD1b8OeHW3dDRZX4YoDETmjmjQLlr8A7vCboRBy4A1pMqGTTyV
	4O7jgOdG976lso36r4Ea4PiKot5BmIpUnS3AnuWcbshgOXRyQOjSkQundS/MWiPDy8sRlT3IYGd
	iI+SvHZt0edpZzaT24U/SDNL1Gp+RXSDsGJDDyzzCe3fYBLVCliyfzk8YhF05NrLn3rbVG+gniP
	nBAn68H9ggJ4ZsFRk9BmzGYLWtzR6W2+BbP7chG3dv2EeUOBIgOeU5Xrfz5p2I58AayG+Kx7Z1H
	RwkVTcMPxuIeZ/sGC0tEMZio1N7HYQnCVrMHXvHuVn02qhSZ+xohmsIXD+Euae
X-Received: by 2002:a05:622a:5c85:b0:50b:3788:ab59 with SMTP id d75a77b69052e-5162f4b00dfmr75902121cf.22.1778710781154;
        Wed, 13 May 2026 15:19:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456b6cf7sm1499921cf.8.2026.05.13.15.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 15:19:40 -0700 (PDT)
Message-ID: <2ec12f83-9d43-4c07-928d-a300dd0f48f7@gmail.com>
Date: Wed, 13 May 2026 15:19:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260513153754.934923793@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BD6B053B5F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247040-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Action: no action

On 5/13/26 09:17, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

