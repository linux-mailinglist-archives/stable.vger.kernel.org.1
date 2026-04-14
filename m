Return-Path: <stable+bounces-237945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD4xDeh83mm/EwAAu9opvQ
	(envelope-from <stable+bounces-237945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A19313FD35C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 975D930364A5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E353F077F;
	Tue, 14 Apr 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZrwCT1ml"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C383F0762
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188645; cv=none; b=mQH93hT0VkcLUcxc16sfGUXkmrB6BxzKQsl4SiGNHakSJxniPgUQ4X2Mxyxwx4DwwVE4SkhwxCpSzxIIw+8qYxq9+ErCb6QgKAdjf0qs8ScMD7tPgfIc14HSc8QWUO+FGQuR4Y5hTd3+2iPKytl4MnSyqEq90oy+aHx8UN4QW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188645; c=relaxed/simple;
	bh=dW+CVxs/CRofxgPG4UcHeZ9b3FzUcZ6G8lii97SL2VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPyUWoJqZXq8Saqj+SxobkZXJZJi2KwMaTWWVvCQNZa4n2q+3xEBG9kipZAVEMfX/1c+renh3KMfsPjeHTKeND0FCkvziAqYGNpL4K/XwjX0JkuFoqywGUE0xSPEci+heUaNL38dCMIPDWLQ2Joz4XiisDRtH8tEZhiMKBG86bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZrwCT1ml; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479554880bcso737552b6e.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776188643; x=1776793443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrmDWbThq3bQOFyy4Ba5d3JbT+VbLbI3qf204VvN754=;
        b=ZrwCT1mlz6ucyq3JUeIdudBL5r44sHBQwNZySEmSp/qD1Wu+DatW9zL2iQJqjumU9D
         98pbrmCTOW/hhrZkuj3Xtq6ntb/Vf0twMAe8UV7bvX0DiQax6rrvtjMHUAoXLRqTVdI5
         p9qzwiUdkd+pm4i+fu80WBoRu8AAtepdJXsqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188643; x=1776793443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrmDWbThq3bQOFyy4Ba5d3JbT+VbLbI3qf204VvN754=;
        b=Swy3tFPC2xaqTElyexBjPozLA6zuh/LyXIJjcW6D8+UdicXQui0LHGNOo3Q5KNj+BK
         PFBsJtoRBwhItC9wqqD5Bi9qDFMobFvxB92VWcZxUfR+sikcfImsUGMmKXABs2bUG2HZ
         2MLW3b+SLOqOqTS0XLNYrz0l52TzQSkNGSUR2k2AKpDVZtf8rD+sd/nP1Pm0tWWpt6Sh
         0tbimcSLeqgdIGhIwnS/Q7cmn/Wi4HJKrADMUeZnu+Xl9rHDExZ+a5ANeEHjG8kBqmHt
         MJ4HWbxEAQmXocFGc5gSYJ/CSSyrlH7Acz/bEJs0/+ZVnRkBv/pQdLHU1/43makLXE2V
         pv2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+5veuHr2L3vMEA29hoafIVGo2HsAVqG4EASuDzoqXx9iGMBhPb250OnenYlEpsR6Uk0Y2+Kp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4YJSxvmWRAkxCT3jVEqDWLMsTcY+upn/l43BSo9zRCLcQOPc
	l03iYj3PdboPUORUTjZPdAyomnus/4dqbrLqLlHgK2/71/6Gw8tB26FGL5iyyy8P6fk=
X-Gm-Gg: AeBDievQ6VHu+H/WApof4t5hPnu76J7tg0j7z9dZvhDsT7vGKjE+dab0PLkSC+iT4bK
	KzS4UWRf1D4Sgtrz0H6SUUwketQC/kledcdmP/rquoxoUFamSgC/2Bikxcuwfere49U6eX7cswC
	wSsxjkz8drqmJtY/IVBaI1cylV1BdQv22qtIJziQjDxOiT8hoUpN8FHIBDWV8+rIMS8n3FjQ5fI
	2tWLFK7H7PbIoq5iQdcsIaJ11a9FPJuLgno3pwzUfq0gwKTQ6/yb1ttq5IZ39dJhv2U8zSnQWRl
	fRIEkoQJqH4JuXKWvrggupLNo8HNla7OLTdeVeLGQIQxjQ2tlNKN5aE57DRjUjKyVBwV/1zeegh
	pY9xB1Qp//1NMbp/6KzaNoiFyHH6T5PIFI5MNA847lVg8llmSL/JuGCC4XbRTzquw2hIpKL0m4N
	CDOUUP9boBu7tzHo2qtq/Ug2zyMI708DE=
X-Received: by 2002:a05:6808:444a:b0:467:32c1:acf1 with SMTP id 5614622812f47-4789f00c7cfmr8963274b6e.39.1776188642873;
        Tue, 14 Apr 2026 10:44:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a080c237sm8502418b6e.1.2026.04.14.10.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:44:02 -0700 (PDT)
Message-ID: <c16923b8-6e2b-48d5-ae68-7b345e3a2c9d@linuxfoundation.org>
Date: Tue, 14 Apr 2026 11:44:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/55] 6.1.169-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-237945-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A19313FD35C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 10:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.169 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.169-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

