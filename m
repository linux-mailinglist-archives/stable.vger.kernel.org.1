Return-Path: <stable+bounces-237942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE0FLN193mm/EwAAu9opvQ
	(envelope-from <stable+bounces-237942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:48:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 485DD3FD3FF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C3E330E568F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984523F0A8F;
	Tue, 14 Apr 2026 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IGLcAkcu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFCF3F0770
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188554; cv=none; b=KqO26SN7YiW0nMcZ6DsPm8281DA+6OfHpaNj+3L/qS2fEyPFynvOAI/nElHdLCwzgHeSCmXj73MngC+TY5CkN56K+kC+69ZBj+QL4C3JxuI0wxnpMECnmRRR8GwqeSJfZrruGqQqaru735AEkjejE7QgRJnPgj7OuoMwXmekc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188554; c=relaxed/simple;
	bh=Ois9b2YQKSdls9G3OnkB8Ik6CQNYIVLdA2Q5RNP8bwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcsvgU77fOXFYYOKIt2z+BRvK5HpxHzF2qWN+dFCEfQzbJt9fGHvijNocFQnxvMizhVoKH37ZgQeBP6b2x6f4L9CLcmD2iNzKwDSMhYDqTIIRE8/KFWm90ONUx0ZI+j3E0Jzuggn+I9pmGVf93A06Jf0rp6F4BhKlpmowdn1fRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IGLcAkcu; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dc35728a57so3262021a34.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776188551; x=1776793351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/N6CFMaTFFsa0f3fHbBuhGxq2igKNglB0pB3FZXpIs8=;
        b=IGLcAkcuOITo81va7GXQKEjxEUSqEWMqQXNZWUjIs1daoPEELpSjxS4N8oab9cwQDM
         YUts5lz1JZU4PMxpKmHHk9N6aXJ8vgtFGB92n4l3pI3ayOCZfKScO7Tv8rzkYGUO1+MD
         XJ5EsJlMmHnGrO5Ru/AheXX5YSt0evXUCHan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188551; x=1776793351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/N6CFMaTFFsa0f3fHbBuhGxq2igKNglB0pB3FZXpIs8=;
        b=Hvfz1ACNHc4mK2oSvUcBNGHOvueVU/yIfLMoZNdA0wr47ae7mZwoRCmEla4pGlO6qR
         T6KlMnqMs8za/wpilpbEJMBtbWzT2Bfgy0UNCC972t5saNK3x0MtYLO1ez4U78wmJVI7
         kK4CJbJn8LiEUpcoSIexzvByfk1Yr4r+XKzRchVmM75qMJ3djUMqRi+R4p20s2OCb/lT
         oBHJ6GLYuBh5VbFmKS/U2AURvufXNAyvi2DhlPuMmcBpgudke+f/FPrLul85g5P06tNJ
         rj85akME9nk7cD5dcDu64Moujibytj83x+oKWY9yAhkvL7mhpXpoxrsVAQSruWlXheOX
         tvxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/a8hTe+E4nwOqzSPW7sVrzLN5pMsSDzWGeq6sprZrV8PZCBCwPI0tr6Napc4+UkXj3cOMuAFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEX4NrjjmC9hxNkRS4PcxtmgB3kyS0POu74v4Ro4MFWexsyFhc
	hW6pEBY6XCfkgkRQ+AzF8NaXm3uZeA+VxGOZP2AjvEntfq0lD7HmxKqtlFq0jsMEAks=
X-Gm-Gg: AeBDiesACO5kjl7lqzV50Lf0u4Rmeevm3ccWvykuK28zQb5mueu9dtSGiz0Qu8oIbOe
	YJLIig02AbskpGSlwO1K7JDqQf+PxwcM0iY6Qq2amgIOJcZF1hFBxx6tOcxajMWs5l+vbi/gNVQ
	2VSc8UeUU/8BwPMRErlJ7qQiL75p2ES1oQI6uwxNbA2dhW8eZuc2oMu1cgZOmDkCnfD2mVrTtb2
	DlenAym+3+2+nRPE7NmcHKb4qo/MRaVkBYEhUREBsfwjghLmbupPBFdg1eXzXNdzkUeEwIEN0bR
	kx9VZ6RErgoJ7scEPfa2NPVGn2bvl3D94R/DHuxxBtb4uce4lW5yMLTk6fYcJXi1BlLKwbkXnno
	oucFHDP2URJLcjG9puAHvZuC2QRpB1//8fo3vE07OQUNaHNQQfEqN3SguXLSMUVCyP4+q+hyKqO
	s1QmbTKjpm6RjkZ5u49Y8Na4KGc5Qj6qw=
X-Received: by 2002:a05:6830:829a:b0:7d7:dc92:f73d with SMTP id 46e09a7af769-7dc27cd6fe4mr13403744a34.9.1776188550879;
        Tue, 14 Apr 2026 10:42:30 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26573350sm11449418a34.2.2026.04.14.10.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:42:30 -0700 (PDT)
Message-ID: <6c721566-f20d-4606-93b8-944674d471db@linuxfoundation.org>
Date: Tue, 14 Apr 2026 11:42:29 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/83] 6.18.23-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-237942-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 485DD3FD3FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.23 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.23-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

