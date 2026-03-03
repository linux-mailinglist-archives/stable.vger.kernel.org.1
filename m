Return-Path: <stable+bounces-222940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFlrFp42p2lwfwAAu9opvQ
	(envelope-from <stable+bounces-222940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:29:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFD21F5FA9
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32F83300CE54
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C73264D5;
	Tue,  3 Mar 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZYOWzh6G"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F312153D8
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566008; cv=none; b=GUhjGSZOM/L8yKK3wmRHa6nWMpNTTkjio2TBmkZxiBnG0CzOF1nu8IL0nImTos93R53ttESJ+irHcNoMw7pTArgdYYG3sk1V7mrLn9DGu33FO+yXpD4+YqIBP9vzJ9YoA5aOxucv5mGlb7ZVd3Y3quzAf5yavhCsKF/krSb79gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566008; c=relaxed/simple;
	bh=rIPO1Kqv6O4QEa2oBwkvHIqVo4fKVDHYOJoqlRTAqi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kS1G+6x1yx+6eVgdq9YAVNU+PIfdZG+FoBGcmA4sPOrFqQ9FnkqCGH8rUOx8Qq0TC9Dd0Rl1ZPBMhrcHnR22Lfve07LCxwoIGSAInG2ZJDQlPxc5E7vIa0Cl17xS7YdbcfeYqKNbYpu1JgSSmzEHTAdw72QITmeizitrKhxUYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZYOWzh6G; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4094b31a037so805805fac.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772566005; x=1773170805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R28fSbZ/y9OH3agGYv0rHtrb5fNITiawjIip5HJdbIU=;
        b=ZYOWzh6GPPF+2oqIJfQCWa8K6NR8hpBr98G/4V50tTHX7pksioYgHNkBINsbcve0Xb
         1M33wJf81KudYXXosX+uB/+ZomevWywBBDSHcKKifGt/pkFIs/pX6Ru/Y0gMIwI4qxhq
         4AMN41pSDEWnQKAnN+2qsnO3gh/T/OLGf1G3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566005; x=1773170805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R28fSbZ/y9OH3agGYv0rHtrb5fNITiawjIip5HJdbIU=;
        b=nqQbpGP8O1VdCzcqo5NC+e9JTnGNDVUDihcoBf4+Pa8Y3HNimYc2KB4aQboKyadrr+
         WkB0ZQPEXVoydvHsPwVA+2XmDDG5WCfz+ZQSKNcuQIuPprjDdXHyRS5HxRqWaKme+Pzn
         WE/7hNwlHRT2OQFhu1Nj1fbaZiLTg+OM8+tqpMm4jg5OmtMn6B3Qbjefb32g4HIvJAlY
         mhRTO15jx6Suon1Fdd0BaXlLLbOSecfceXd70Ll94RmuMJTSEwi6lxL6NZJEejyE3nXa
         ZBBZ38cZWaKoaO8C8jKNgUAabtCsipF+fh6WH2aDInDdjvO3+PTm2cw89LXiyo+c5Xi0
         kJFw==
X-Forwarded-Encrypted: i=1; AJvYcCVe34e26GZQNFAPHIHlSsochXCw/MYXhw6eZH3C8cvsxrpsEa5jeMHq3gAhlO9vrqi5v2DWlDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgrc+RBOTfBSif0RkRn/wEaG5EQzZ6DimXhfbJBFVZNry6hVSe
	i+WjMPhOCNNXYu1FDkNneXLce5ZDWHjffsudf/FVqMg094ycFggxhFdd05OF6k+e8Ro=
X-Gm-Gg: ATEYQzyFOQ6axhQ1Si/ox1TXjZxVDUEMkRSBlhbrcPE3dn94Z9mxBO/2H6J+rungvz9
	nhSuL9pfEyOz1J0ItQnKy8r4BupzFukwpgfhrCzLnE4TMmu8zMAypAjZNUwtdXXNMZlMQoyYrVg
	n10Pe2Ev1cTJwinWbqGm3kemWIzzBadzxZaA0p6XaNcz0ir5wo/yaDBQWEYZ1HNg4ObJ2cYY5hZ
	r0uUe8qtOa/yElnXDeLFxGo4cfGA/Wze6lZtEaBzEJM7hSGWCOfh095De8k/2qgwFXz4PLwKeTp
	SBx4gkVuIvS/AhS500a8rr3/gkPXJdWyDOtJDnvHva/9LYLEOpJ2BRzNyEki+I88ARZHvekC5L5
	3CzgSFc5ZB0nppCfr9a/Ln8lAxLhHtChIW9HI/LsQ2A/5w9q9TM5xI41YMkuxz51DuiUsqwQmX2
	U/DONisuMTS59acRd2DSGYLKy9fxGwobBUXsI=
X-Received: by 2002:a05:6870:c26d:b0:40e:95b9:40e6 with SMTP id 586e51a60fabf-416270fec36mr11373030fac.40.1772566005464;
        Tue, 03 Mar 2026 11:26:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d20ec7fsm15796275fac.11.2026.03.03.11.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:26:44 -0800 (PST)
Message-ID: <83675329-87ed-43c9-aefd-7ffc0436da1f@linuxfoundation.org>
Date: Tue, 3 Mar 2026 12:26:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/956] 6.12.75-rc2 review
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
References: <20260302160918.2520730-1-sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260302160918.2520730-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ACFD21F5FA9
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222940-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Action: no action

On 3/2/26 09:09, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.12.75 release.
> There are 956 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:04 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.12.y&id2=v6.12.74
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

