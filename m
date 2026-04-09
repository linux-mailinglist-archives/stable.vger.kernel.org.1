Return-Path: <stable+bounces-235475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMZkH1vp12msUggAu9opvQ
	(envelope-from <stable+bounces-235475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:00:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E993CE63E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26E893009CF6
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8192EBBA4;
	Thu,  9 Apr 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WtzjpPvQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963451A6829
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757654; cv=none; b=oXLqdn0D9kYJ1tiT8Cr5u6T+6pOl7T1J1A975lksO4DhdvHWrWbt0yz0HoI8cuAHMVPr7bRP7QhCzvT+kq0RLEYuWoXYc5Xz+8qD4t7r/eXjkjmxkgQd04z+jNQ01QReAuj6m/GLyclzfxZuRc/IjHYOmXt0SUAooa2XBPFmQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757654; c=relaxed/simple;
	bh=tLzuZ5f+4AF2L3/trodKxUni6co4Z6wzcj7FwL4YsCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSdUI5gHtqWLziMeXXioDtr/QOx/7d7KvRvEIu9ts0Y8c/G0rQDR298BCY/wyKiiM4pyGcl1vXZe2/trWbYoF0ljQofuIn+E8P5AkGxTjN4THZyABBg+4ojlHZJMKEKNsX1xH0L2ZOit7jbnmOa94oJy5HacrTzZix1A1wceh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WtzjpPvQ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4645dde00a7so952667b6e.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775757651; x=1776362451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbEBQGcCqoeU9ugfJ6Hl1O8LrF3MTW9Tl2J0oWaCucY=;
        b=WtzjpPvQXtdo+i4oxNK26v0FlVR8rRoz9weqFTq0RxKPF8PsKe2ZMSo5saJojvdk8m
         /6peqix7Z4/TotiHyhS2SxyUhI3PJvsyx7/jRrxJcTqttAhGIC0hAwPG/TID+a6UeBcO
         RgX0Ef6u0tGqR+jM3ZT7sNnfwx0pzdV9iyLc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775757651; x=1776362451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbEBQGcCqoeU9ugfJ6Hl1O8LrF3MTW9Tl2J0oWaCucY=;
        b=bcjKDiTD8SMjYoSICcuy9mmgkNxGhtneMoYUZuuc96vGaiLu8pr1mvw9cltOf5BqPB
         kUeNaiiw2JGPwLMGUA1aLpJg+2kdN4cb7cMCovayMja3otOq+cIu3KaPZ4PeAUpY/ECD
         fbhd09d8O9k0FqKoZvek+rL1cmbR477FhwgOjRIidmdQ6quaPnVCNP0Iz4+4yhJwZMNH
         ehF1mNw/52j/uoyj6rJPmosMdUIpGisET0dAJiOapqH6tBmCy3b9aBwkznnWwS9jyT+r
         XHUtX8tv6c51KhirCdgULbb9xaFyv7wueE0gLVCgULYgV3iP8WU2fqHj6DQWIOBCsLGW
         kn7w==
X-Forwarded-Encrypted: i=1; AJvYcCU0qCooziICdOhvuXKUcm0wGvhaNRgp3Qvb4/GqkrAJdgFPjhq0mSk99rFcwAEkLHPXbHvCTJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4D6PJEsJ3VjswoyaJ9dlW5dcRexTAwrw2tt2xuKUf4s//PuQI
	dQAuEiAsHNRQmwLDjiR597Rf9KAGk9GrY4+aANmnwOfc/4tWVdmXJHV6BByo84HvKNk=
X-Gm-Gg: AeBDietCuwu2iY4aO/qpR/Lpnr+Mj6H1+XaKufncjLGT+ksbk4VbRK5e/tNlYnuTPoT
	ypFx2NKP+Jhl9idb2JWt/a4k48tbrLbnFEEK+mtXDa6/h//Mco2CMBeUKSpWNnZTNdi0W/kx8Fu
	uYWVTmk8exJnG+QlgzyRow0NBZNsV3ahG3i+5Xt8xGVuCBpBxQffGuiIyIINbd1ykRrvJc53845
	Q0xVD9RRSS2mYa+eIMYf00sZJ8YQ0Pjqmr+yUtIUhfKTULV42ph2OGoiiUQiquBAN7o/ZOVMd50
	JNUgZ97Q4TN2KLFmx8+5QK6gZkXjCMSbsMfXIY8BKJbC9qbRijA1CTbZHL12ia0daq+U+LElUU8
	5jjyIlzAt9fKwZsMUg17U4FbRIkflfUhztt0ohoXKk5KW1APu6AX0uCQvSl/FnlI19NmLT8EODj
	+afCwxirX0OoZIPGMK3eLn25XQUMePFPeuJMY=
X-Received: by 2002:a05:6808:c1a9:b0:453:58dc:c006 with SMTP id 5614622812f47-4772a863c6dmr1962631b6e.3.1775757651321;
        Thu, 09 Apr 2026 11:00:51 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a3a72f6bsm50044b6e.17.2026.04.09.11.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:00:50 -0700 (PDT)
Message-ID: <91e440e7-620a-4166-8453-a8195b8c4913@linuxfoundation.org>
Date: Thu, 9 Apr 2026 12:00:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/160] 6.6.134-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-235475-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D5E993CE63E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 12:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.134 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

