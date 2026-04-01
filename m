Return-Path: <stable+bounces-232809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +In4FrtDzWkkbAYAu9opvQ
	(envelope-from <stable+bounces-232809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:11:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1998337DC03
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84C3B301F6B1
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339C3DE425;
	Wed,  1 Apr 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OgRgWR1O"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BF3F20ED
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059764; cv=none; b=LHeBnie4UOIPGsgXFmGKkNMyhqRCm7WI/fUN5HmkPp1Tgd5EvPSoMd1f/iuOaJDtMEVREJuXmiLYBOG9ZAPlXFECayYPcqQcCYiHQzji3VtMVNVYXGwUa5N0kFGaMW/aNoysh/TjXkAaSvdxpTtZs9aSzXPqeCrViwl4h+3pVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059764; c=relaxed/simple;
	bh=935BkEE5lr0zTQrtS4U25NRhKMY58Nq4atDR1BxUcik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jtg6yTD9KfE2EiE1xdFmTrfOnvyPbqLJr2EdhTC4NRceT1OvzdA2iVwFL/rmbyQDcI6JtdOol0g1NYurcBwa2kD2VzyMQuMdnzkt6U6xfT5TUzZGXgFTkAPkzZ2nDWGCYb+kfShzUG/BbrB+n605Cjc5Ds0LETmqhIA9MeqoJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OgRgWR1O; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7fdb922a5so5790390a34.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775059761; x=1775664561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7W6WBNC0sNqGoPP+a9+blf4M+1VWCeYjcBMnkhHmWk=;
        b=OgRgWR1OIyLF5arJVsFSZckRaVlZ3mGFrFYrEnORk1+2cWlEe2LdBXt1pcet0fGnWO
         t8URmu6s+GPMVk2NvBvXCInJ5m9jwpmoYTU4fj9cuSjcXjByf7Ooma4jWzG2/P1zoPOB
         cn1rZWmrt2pkm6jSqOTKm1iCjN9yHi+5iBFIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059761; x=1775664561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7W6WBNC0sNqGoPP+a9+blf4M+1VWCeYjcBMnkhHmWk=;
        b=MFe4rUeowZAoQFkvgk0HK6KOFepkyQa7Qz80vJqgKN96u82royPHbeIn0XRofx9iNp
         0iR5nBwYI9dcc/gY4OdR4GpAh7E5V0iNHbZBJGdhwYsWAwqrJk8NjAQwedzyqsW2886g
         TFi77SGaDAwTkNPsO+1IY0FP2WuMd4usFFA27jJthE4QAK9jcRYhiukxD9wC9l6HMnW1
         q/HzDAxrgt9Fcrv92F8xJ0jiDWpTVpMTrM0O9yOKQ2ttgRa40vHvgyc1VM4AKy+xZqtv
         BPZC48V6ehHrYgk5KfnwHkQYndpCuUfBgHQbsX1I7f7k05GWKvTGPs3zt609EMkzMncF
         N1EA==
X-Forwarded-Encrypted: i=1; AJvYcCX0zy2CopqE6wbB28fYIduFXgJv51CkmXH6vOqaOvJUDKFIHezIIRyHOKjh2z/byoV+HQqGplI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9YVnj94GTeOI7JioYQjgCZxFOSmmJDWmUcd7MKysHdY/QScc
	FZttVv5/Mnk5HQCMx9AD/mgP4sH1VDGrnKOAeyuKP9kFReu3qxHEhv4bPIzzbaLrTiA=
X-Gm-Gg: ATEYQzyqgWUnM9XwTWCmTSUCC2S7tqAyXEm6XI6CJj5TfBIph4D4uKbxhFpwXWAXGvR
	e3Dxy9UYhIIEqnSgOqVy7gE2/TDbnrsB1NUD3R1LDpKf3D/X8JTRtqrQcYMgSIOpYe3Urf7xL3+
	mpeQavPjoegA6KDQE4KZrB2FxWBllh7wXV5E9Od1bBf3/Ynjd7btH/PyDBb2G+ymollXcRNMHHR
	uFX43g6zgCprLIbppbno2eKL8M+q6ytMj747qbDyq7+55HDMkVG39kjopKrvZmZQDbjDhfN0RXv
	XxJ1b6IQw8m0y8lmYrZuUpYS49c+iV/gie56lDB7739fkVVvSIXqekmMgAH/TZiUQ9CRRopaeM4
	TE9X+/a6xH8HCc8Es8DUArJhSpRr+TBsHVEH0kNkxm/ZY1l2b7bw8q49XtWJJlXwTXr+GRLBlAq
	11H1mMI+HL95YBCogMRnzDFaPg2ytvlVbI30o=
X-Received: by 2002:a05:6830:270b:b0:7d7:d524:bc88 with SMTP id 46e09a7af769-7dba7d3aafbmr110974a34.10.1775059761076;
        Wed, 01 Apr 2026 09:09:21 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba73d8126sm138538a34.27.2026.04.01.09.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:09:20 -0700 (PDT)
Message-ID: <dcddcbb0-e4f1-4fbf-83c5-a0af92794238@linuxfoundation.org>
Date: Wed, 1 Apr 2026 10:09:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-232809-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1998337DC03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 10:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

