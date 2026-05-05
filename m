Return-Path: <stable+bounces-244211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMhCFOkT+mlRJAMAu9opvQ
	(envelope-from <stable+bounces-244211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:59:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE0E4D0C71
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB32307FB0D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB8936215A;
	Tue,  5 May 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpcPdzyZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B74B48AE09
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996512; cv=none; b=OQy2lWUOUKFt01svZkv1wuBzIZLUFTmbem26/ZknXWwB7RUa9Oo1RvwWytrIBehgSVlK88EnpLHKls31jgEHiDtrQ7Z3pj9Hz3g1oGTqUYU7VvPLhcA5CTF7t6S6GmBrNOsrOPalPLoxc0r00+ofkFv/O8/9c9OvdNnkujMLsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996512; c=relaxed/simple;
	bh=ztb0aECqkdj3lXdK3o+ezqOaq8qKXy8MXKKbZTgoFF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svgnc6RKRicT7s0GsOeshSGWWftCOlFcD46ahThxmb8gZBdAs8KgD/R4sm0LLSsBxeKXh4X5sbMMZJwj8w+Hdr16N1P8FsuDsNkU3FY/9mlb3DYbiPXFC9uqd8DWoXoyjtCiP7GSovRufCOi9xU7Qnqef0aSO2YEyhC1zY1xEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpcPdzyZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7de44ed7a11so4399518a34.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777996509; x=1778601309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJrrVXWHd1p8zVo0A7/cFUcaF3X+H1nPtvANH+xBNX4=;
        b=KpcPdzyZGfeRWdDeLsI+9EfyIxMR/ViyQG6phNVqxiFniIP19bvAMKkGgn5Uz03TDx
         7Fdtpg6AzfSFI9XlxzmUVPBnrEpX7yrBXgvCM13PqDpJSckKv54fnQyH2UCTAS8Z3wQt
         a37sxD1oviNevU6CoVHzG3zSEBOTb8DvdSIzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996509; x=1778601309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJrrVXWHd1p8zVo0A7/cFUcaF3X+H1nPtvANH+xBNX4=;
        b=MYQGbtIWJmuia2ClOxdPmI+KjOYa9gVpFPt+LgDL7G6H9TEOzqHtZjLzhTXOasv/g5
         gNHY7/uBKr9G2tvb263ykNuD562BifVfAbioLWbRbK/+MTYrlCk//wm7fbs17D23iJo7
         VLgHTE2OaGf5syIIlZuIMNhU7G/Ae6NOmyGHUkozagvlZrw9Km2PkVmdS6pmkIDolZtu
         fMq1jO8C8RP7E/mR+HSCZc24CSG9ahaVQIjvyflAEX1H/aGi2gf33mqTeQswKTH4u9cT
         K8lbmYLBBhF1zmrHlcAxCdeuFiMENAWG59YCrDawpZ+duUGWXTvWM+FUohhAjWEDJ2ro
         yuxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Oeb8IPSfzklTdEztvYeCQHiw9rZCiIQ/ZrmihLG1UOJLevg9QKmJ7j5jzpAMoGjbGITJnOn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4lZ+yjGa1X3l3s34kO8A6ktZY+YEVaHxRKUVptUg6noLB8Sq
	GVMY5MkcDovOHG0N9nWs5u+k0EGC3bOl78hPUDggdbi6uQ00GxwSU3I5PbA7RPyYrTw=
X-Gm-Gg: AeBDiesS6+43CAcpn62dLHJElzYQDeJM2XmrsHGyaYWq1gvaX6HAnYDDqSjv0s+u6Un
	TbVmwt+6xmgdBMmqlGyXUbrj+4qc940JKbTTmRWM20QgO/iLW8WSqIuQGO2A8NQJ9qwyYboiDkW
	dqqGDvgE8XFK/F12Wam8WRpRuY2b4Ei8bIyuJOn+asksEsdTb3tdcQifTOUAuUj+bgWSOL705Mo
	wawoG333OtmHEPQxbe9TX0RNDWa5ZTtXJ7go2YEtPC+r7QKokVN+DHQE699KLnvPrY7xktAEmaT
	HRRLrf9/Kx4HEosS82VOllz2r6uyV4LnfwYv+8DjrVgaWUod6gOdgNaR6xXn7zCuu6I02aEQyeq
	2y3+fFQbKddEVsS8sUUcM99NhCcfaBXZTXK7v1DOv0XFSJMcfpxXi78ZY5kub8W+iKxr5r0TOpW
	qaYqq9LoEARWLT2N/2GPj06yyZAv+RV5o560VCc7nZaQ==
X-Received: by 2002:a05:6830:3881:b0:7dc:c926:4f87 with SMTP id 46e09a7af769-7dee1395cafmr8505249a34.16.1777996509452;
        Tue, 05 May 2026 08:55:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decadc2906sm10257665a34.23.2026.05.05.08.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 08:55:08 -0700 (PDT)
Message-ID: <24d25230-c180-452e-a7ee-2ec36df3a522@linuxfoundation.org>
Date: Tue, 5 May 2026 09:55:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/215] 6.12.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9AE0E4D0C71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-244211-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

On 5/4/26 07:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.86 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2026 13:50:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.86-rc1.gz
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

