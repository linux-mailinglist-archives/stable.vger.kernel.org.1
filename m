Return-Path: <stable+bounces-225239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPiiFZWDs2msXQAAu9opvQ
	(envelope-from <stable+bounces-225239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:25:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B880A27D0FC
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 591F1302D950
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546A345721;
	Fri, 13 Mar 2026 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AlDNB2ZD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EE304BDC
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372306; cv=none; b=XkKqxXsuDj3I+po68Y5dDv7FkH7uNX2k066Va4vSZkKeTO0F80s4xvib0r/nyyk4qqvLvS5OZX/x41r8mr7R1kDrDgw9qsz8YCBXBVh3sxZ+0NBtLyrM8LKTj1rCRepDby7CyHJLn8RhrDyQ8Z3yuKnduOirsBgmI+FdRVO2Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372306; c=relaxed/simple;
	bh=UnpoWyQV7I2G9oKCVZTTUlyjEKgTNZRO7I8Y2CTany8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0FXNATqvy18w/srlMu1rNMlTGQQI6SLb3eqJuCCRMDxv+9P6ZjgaStfmUiQS0ENCdZHaiFydVlH0epbapqmuReZQHIaTXLxaLk1JaOrG0Y2gZ2q9ljxfaAWihx+W4Id2kFyaMZOP1IPrrNaNtD1S559PiF+sKjtxn1VOZ+GOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AlDNB2ZD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd71fb9f06so115526485a.2
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 20:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773372304; x=1773977104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNtbuNDe4pXFksjcrSvvrnUEDc9BgD3q2Pyzectx8xg=;
        b=AlDNB2ZDwXbYDhcNFz+voCqIemvw1LCv/05eO/EGKIi4GKxZhdfgvTumVAPQsnorvS
         hBXNOYd3/gwne11FzassoABCuw1rMTBYwTXdxYvuixvg3lhHu9Iil5L6HfztS943DzI9
         lwShDVO7Wjoew7aFh2cLTdfaJiqy4Pg6bKd2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773372304; x=1773977104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNtbuNDe4pXFksjcrSvvrnUEDc9BgD3q2Pyzectx8xg=;
        b=INpVpjxtGlUG5C+KL0zdRRivO0me6B7q1WTvqxaHCeX7xCgrXu135jPIiUExe07HWO
         uwkwheQK1hI/2oAHepOFV8QhwkO6c1Mk+RQCXN1K6gipB/bm6jzArro/X8BQfRRCCw1r
         FSptIlG+nXBeZzorqjFSjYW8u4L3X68ZpbLwx+op2rPis5SgSaCn1L0sysCjPGdstZEY
         aUkwr4HvDSzM/782gx6bBgXX1a4AcIRAkgvyrdWZjaeAvytLnXBw00f4c/x8735fiMdW
         uqpTN9Gleg2x+li2TxgwDi9g/CbzaTrzspHsoma03qSoB6poBr8/cAnpz+0ksiSfiaqH
         jLdg==
X-Forwarded-Encrypted: i=1; AJvYcCUVsL2ZR78M5o0tnxt6/FXB4XeOQFrbNdN7dEdyn0u45iVO4Xx592W4Qa5WSsSrzuss/74KGsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOGvTrfmta6H0uAyD3/vV+DzjypQsCYAQfpVS1jFN57Rnveno
	FdWkC/BUDAwNywkarXQ5ZSBSyjCj7nQzl785SvF8HymWruOwml++tw9ycGn4xgW6VKQ=
X-Gm-Gg: ATEYQzyJ1N/PjaV7juCwkFfs3NbONuz1dZ6fYBUnHdG0R2vCufME0i5lS68oGqEVDw5
	V88znrapl+F4UR37X3ml6SV71dANrBmzna6/Y8VOEQvvtxlTGfXGk4L2i89kwBjcZyg8XZZXwUp
	RSgpUDORVSpOwDL5ioiNy2o5KyeayZSpIzNxS4x2dkVhmzIcz1KaFBVBusrOfE/bR02053ofChC
	YJ2v5yAA8NBOXpmInJbbXwOLxPERX7LJrWZW/j1I5tGJunh7puCAc5W8IKt7btPwV7hWGbEMAs1
	oCUTVTRARvJ7jWNkscLSMBDvodrDNqVH2w3DfDhu2qq59FC/f4R1gcnZGNPh0K3x30cMi6jyRry
	gyMjxpXNbNGegVOk2mgeVtouO19JekGcdlHmPrK/g6jwwN6Eb1mH9rZMnAtbpKurS02ZD6cfCqE
	ctNU/cEElg9R/j1QwM2wp7kWQebpnw8mTuHPElZZUd1ibfFw==
X-Received: by 2002:a05:620a:46a5:b0:8cd:8f94:2598 with SMTP id af79cd13be357-8cdb5b54176mr275792285a.61.1773372304103;
        Thu, 12 Mar 2026 20:25:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1ff7642sm529673685a.21.2026.03.12.20.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 20:25:03 -0700 (PDT)
Message-ID: <46ec4dae-8422-486d-b2cc-fb4c0d385780@linuxfoundation.org>
Date: Thu, 12 Mar 2026 21:25:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/265] 6.12.77-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-225239-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B880A27D0FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 14:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.77 release.
> There are 265 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Mar 2026 20:09:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.77-rc1.gz
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

