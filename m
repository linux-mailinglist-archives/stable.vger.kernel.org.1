Return-Path: <stable+bounces-248946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAYCIiijB2rP/QIAu9opvQ
	(envelope-from <stable+bounces-248946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:50:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A355912B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B42F3009B24
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBCC3F5BE0;
	Fri, 15 May 2026 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dhebt6fu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C1340282
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885390; cv=none; b=CE5bLkS9UfL06mk+Z16lp6LHkIoiutHJeStTTzA+h7aMUV19pm3KKlil2hVfmbguvYwkQWIlCY/k3M9lYGaxgMsC4dBpxR2Hey0jiYYDTKHzjlCASvsTyIs2In0qkce6LH4ChYIiGWfw5xAVhfB9C8gnB9cNfMl3x6oMwERNOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885390; c=relaxed/simple;
	bh=8CDKojgg8bc2d3j+JPs4NRsF8N917fIy9qh7ITHOf8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsE9wkf5VJ4eT3GsQGrJNB6MpR1kATJgjUrKtyfc+pMTAOCOG1fqOo8t4ia+7o6B2hcBJ3IIsSNsnDcfxZfd3lqx6XAVYQqUdw6o97aKuO+Mp1s6sO6vk/vthkgHcQ/Xnf8d0R/Wxjufnl8qWe2+XLkn9M/qsDGht8kP3ODg0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dhebt6fu; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e55b95ba13so213672a34.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778885387; x=1779490187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOwHkwRBXTZs9rh5FCfiGoR14he+8Hhk6XucwBx3k6E=;
        b=dhebt6fuVGWE0Rlxwma0tCyA/OwEpObfVDVc+yvPNPvblpyZ7cTCWtX782wNI6iEI4
         HdZhT7PhLozdS7fFAeOYAd4Cx9KPZlmnlCJipEn7jRRdTJGQ9mGlger9Zytv/ntjnSdB
         F2ocKNB/PyLQvS+8i2mn44QLnaAqGikwFKN0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885387; x=1779490187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOwHkwRBXTZs9rh5FCfiGoR14he+8Hhk6XucwBx3k6E=;
        b=VzqgPJ/M58EkkdiSZCzP2w5Y+932+9YkZf/+cyVIxte8YePhkP2p/8JQQk2S7iTnbI
         QpO/D4DIAnORilrGJ0zuBjyKT3zOmhL+ht6mt2lcZmBSrORxzVsAIdITb78LkoXrXAKp
         MTTRD6/I7lZWsOVJfE2J8mgTC/ybZ/u2M/oZI6bnprmOTpNmAbU+8muDzMYJyjbn20v3
         N31Q5FVGvPFc3g+p2PLhIhtaitdArmS4qhoB15Xl6FiQLdpZCCz85WzUE/ylRVb7oK9y
         tUMy8Hh8gHMJp3A76qdqOmsNN0G6lW5ygl5jgrKb6XWTvR72N3CJal61XL/RaDW8k1Nc
         jGbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tbhEdmXsl72z3FStkgP09qq1DXzSm6lgyKBCWOM/8cmorQfUXoXywBusTiHmdR00kitY0wsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+vuYlqgQtMnq1Npf13rvAv9SRj7vuNoj4/rHksmw23NUi8Xy
	XoGMprSkLCCtAqn1Eov0IFh50JawMMQVYX0FjLjP5Yr6w/7dkzNCY8WoIHxKxRcvlHk=
X-Gm-Gg: Acq92OGnwl/e5w7kSIPdwiYw4lekyF9SZLlHy9VbYnOpNsEvZA/OidVZGw6uRN/QYuD
	a5NbRfPnefLRKlNyAbhSyzgIbgbuwTiG4LiEAKs+eq4OWUqpjPVAlghwQ4q4b4AoxiVcc6Rj+Nh
	VjtHr8+3rwN+4cGfm9upjLXQj0OXOl+AICsnjnx0csPEyxyWW4ZzeERniiqQrHzQ71pRczZntup
	2m3747szmKSG3cxDoniVmQE7yoouH1iCfjeC3epBFjpnzdUO3Bz311Kmq7nF8jwii0thXVZs5x2
	gYwZiE4LtqkKUso5Xdk+CIQ4wBLQGJO6E2aWYbOfErbi7jFFFZCc1SqxqPp3JKXeZWYlHIfikAV
	1FWjh0/eGLahpmsvpYSxjJSdJFecXiIbuHqR5Qgf1PcTniWGxgcefcdXUrucj7BjOJCLnvlWE3A
	L9KFXQiXh5kFcg76JSlvKDsr27QwDNOI8=
X-Received: by 2002:a05:6830:6f48:b0:7dc:d7e8:cb37 with SMTP id 46e09a7af769-7e4fa0657a5mr4988597a34.21.1778885387306;
        Fri, 15 May 2026 15:49:47 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b8203a3sm2289753a34.11.2026.05.15.15.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:49:46 -0700 (PDT)
Message-ID: <bc334402-c212-4a1f-8c81-6bb6d1de2f7f@linuxfoundation.org>
Date: Fri, 15 May 2026 16:49:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/474] 6.6.140-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 028A355912B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248946-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 09:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.140 release.
> There are 474 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.140-rc1.gz
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

