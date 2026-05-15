Return-Path: <stable+bounces-248907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHe7NIh+B2qQ5gIAu9opvQ
	(envelope-from <stable+bounces-248907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:14:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8AD557543
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D6E230247FB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5B390C9E;
	Fri, 15 May 2026 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmDYld5l"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD912BE639
	for <stable@vger.kernel.org>; Fri, 15 May 2026 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876031; cv=none; b=KbqhMpOmKjlen2zmqmomUcY++5uVPgZlOdLp12yVdyG+SpCh68jttpx9giu4xBFgQfWofs2OBRZV+3DKWhldd4ZNcIHTO+rm/OH5ABP99IzRfUfWNUpqZNKy+A5Gc5TBd+9NpYPmQCtdpFAuq13hGxJrkae5EXcQcgiJ2OUQAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876031; c=relaxed/simple;
	bh=qSLAYRFgcD8HemAM/3vpyq3v9PCVAzUa1f9ESlzdo8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNeKbw37Lk9iNIy98ocDE+7IDPXhp2i90mqqfzZ3aHX8EwzpGzTBpvS1w+r1XAw182psBjoz0OBjbgFfnizJbslEK0MsJ0y75Tl3KqflhKvBL6TIUOTVC1/5sJb2x6nSwUSTLEQdNy2VCqTw/Tnhz9PHNqzJDtGJxXn6FHxaSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmDYld5l; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-910bb291688so39439585a.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778876030; x=1779480830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1I27Gap61YWLp9iMgpMvGpKIyvaiXyPWsvjhQp/5f4Q=;
        b=fmDYld5l17MhDj6JestGACrwVdyRrQmkvyAD9/kRDEE2v3wK05jzSPqh94w5LBu0fd
         HDcmZ4cqsC3djDuTQUwVGEd9Ssv8o36MGHOFnZz7jISJdMNWDZiyHKxRw2rBBsLs9SIH
         V29n4TscziUV1K8VUzKERInv5VzwjD7qyDttrRiFIduh0I6m+XAnFExoTcE0fXjNyXRv
         lXuOsKvkGl9mWkoAuqpRs4V9ndh+P7zRFA+1U3v9Ru0ZtWjWlj9v9K6chDR1XzsFM0s8
         2NSYMsYt2ec5U06+9wW70vZrH3DAYueP7I9r0fvU3CgIVhC3Iz4hyQRTtTK28GsD7/S3
         sIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876030; x=1779480830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1I27Gap61YWLp9iMgpMvGpKIyvaiXyPWsvjhQp/5f4Q=;
        b=Wf94nIA9RfaMORTZ2+jW1Uf5p2XvqCzxKyKAlOlE62Td6rV074jAOWxPZW8B/J9Soq
         w++wbQ9LCY75N4N2hZT7gLyX4ip9MPolhuHntkoiPsAzUkwQCjPid+bKv2YDbXaWLUA2
         WYMsXP6hvJKTSK6weLfxSrO70UA74Ah+XOERbBE0q8J7CIRz0Ql2KGptmTtXb2am1pbW
         B/H2hdX7BmXPC4akSDS23wABRf1KwZCzzu32tTrLR50oq0sSi8ZI3x0I2w9j1uPIr46Y
         G2w0Xfq8dOo3cFx6CKGiyt21TcW8H3vbmBNzvzBdL9yTVW9oVhE/2KHBg0UkiL7kd4TT
         rHlQ==
X-Forwarded-Encrypted: i=1; AFNElJ93dJYjkskvrKXG9wF5lDePS6d+lrs1ijS4sLQeHmeNbWRS6tM2CA4bJ4oQzRUOdGyyH0/4wyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14ZKRw8mYTt4f1lIErgSAmwLu2tB5nZUOn4q4ay4BtzIhH5v4
	0iqRZAjrDk30H5EJH/bELC4J9gA2o6Ch3Pr/AwWAYC8uy6/10M49sf3y
X-Gm-Gg: Acq92OEgfo+M+hXnBmWePeTnryHE1rMEziK/ppPoyfXfxon2Ryex/CLtdG25RxHTfD4
	qYGv2Q8t/SiVYaFVlLcS/2GaBvbzFRBcbwNsGylr5cdstUGdFtk7Xc9yAI/YmqIBIn3zVLMS3tf
	9SG7eGaqqVSocQ7ZdSSrHJPRkQkTVtbXsx6/gkzDQNXcgca68y8WtpwDz03HiahhDP96wlsnRe+
	KWeM4RJ77hc8X4Nwx2HMrz3SzksnpbqDhhz2tmXtvY/dOWYoYGQsvKhV0OxYTAL5ThCWzTL5hiU
	9XAQ1+7pLOx8TbY5wnDD8epUswOrby0EYTso52gwLdWgICQm5H3Qw2BVGZIYP7CeSeHF0U7DaGG
	Gue27uCNFvRCwyShjXlaiFxquudkPr6KrWI4Monfbu9WqsjXzbxLpCDuCPQzbMzxvNye+sbL8Ah
	sB1/bmhhkF++OWOdzKWWSllTzAU5/ASRow72bnNilzQTkp9Vvs35ASsWuMNaTi
X-Received: by 2002:a05:620a:3708:b0:8cd:c01f:fd25 with SMTP id af79cd13be357-911cd07b23amr915110485a.14.1778876029646;
        Fri, 15 May 2026 13:13:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e638sm647870885a.9.2026.05.15.13.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 13:13:48 -0700 (PDT)
Message-ID: <c8cb8168-7b49-4820-bfa0-7ce7e6404d91@gmail.com>
Date: Fri, 15 May 2026 13:13:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/144] 6.12.90-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260515154653.469907118@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4A8AD557543
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
	TAGGED_FROM(0.00)[bounces-248907-lists,stable=lfdr.de];
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

On 5/15/26 08:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.90 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.90-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

