Return-Path: <stable+bounces-223119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IChSJAlxqGkkugAAu9opvQ
	(envelope-from <stable+bounces-223119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:51:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202A20573A
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A38583074BDF
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35793CCA06;
	Wed,  4 Mar 2026 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+N+9udA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82108374E73
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646477; cv=none; b=Pq1dMO5SoSdukUCtt9yO0Jca3LnpNyTbJ3ImEEZdCYPqgx2MgKeWdnPxafCB5qNLzBpfBE+4Ijt0T1CK5uAY7WlHYHoKkWV8mIV8aSNyJLWOQ3CACistPZZAzrlSmmz7F9h8iltrzAUfxquO9JmZQnB6pjtijoXnRMAudMfIcqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646477; c=relaxed/simple;
	bh=gHkdNKVcIMCx3JF8WFK4Tom5aTnEdnHXdcfVtYRn5lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujcXSiLA7EVd0Y24UFd3h+J3TVOOsRVF5a9BBAFo9kLSZJKGMv+6RFv2MgAh5xr7AGzgYHdG0W7U4PH4cs2VskfmL/i5nYgRHgMEaLCdShRRtnLU0eDfRakI4VFmGdrNt/feUmBAZCl2fXBfDGn01R0jv29uGvDPf11m/Ez5LnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+N+9udA; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6759a5576f5so5047239eaf.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772646475; x=1773251275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFS329oI199iyk0yECHEQFTEx3H950AE0WIADkJXPNo=;
        b=H+N+9udAtilR3Ub72/54mwiI1f3HACbfkdvOZ+nONz7gIXijVXbUKmHhmYEJQLIk3T
         jk7p78kIbfvOuFT+pwmJTP3BKVSWgod1HRy6PTBwTnJtM6KXX8qvJdJrTT8d/CvWUdHU
         9ybBMm3fv1D+4xOGSMDA0cvX03FFS6WF+hD1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772646475; x=1773251275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFS329oI199iyk0yECHEQFTEx3H950AE0WIADkJXPNo=;
        b=J7N9qBVwtENq2d5lPVy4BN30UG50mPtKw9uOqJdAfWCzmegAdgEwzQnSgCmXipa9HI
         SeeQxw8r1xkJc42ZvRqgHudBkH2zlXwGKOap2MvDmIT2+EalldPOsxdItmlNBdrH51Zz
         lkloywWh7WNDRkKbk4U7uyTDksKq+DEvD4g1DO7rjjCqQG6BHeArbrYIdcNq1S2MEBXi
         DgP7Bia0Ny4dvFe2KIuk5V5ulkebAI5ARq5g4qfmuZ3kc+NwuivTEd9ACJKGBAYGNJoI
         xpnkmiyPGKgFZZMNsn9HmL9M48j9IiaBG5n/WCD8Rrpiv40BXNe9VMwORG0fKBCRMNc+
         2EpA==
X-Forwarded-Encrypted: i=1; AJvYcCVj0IwG6pBy1bMkSJ0LeEzyO8d+pxeOSDnpswnFPJ3Gn29suqneZv0rAcv6pHGe/0v97z98YjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7G2wQ9y1DWrIuMp61MRLYJlSSBkg4PmFmXHGKHaJ3lpkvkbk
	IhwC0CXhXNEoxWk/Ll339+h70U7iuHuiJh4usxGeyhpNNbJf4zrDrlpvejem9ugG9po=
X-Gm-Gg: ATEYQzwFitBvuoT1n94x0lhM4QLhEUMdalyG4/BtSvSWkZZ+jFGW1Mc9gROdHZXxDUT
	3s+s/6D+SpzRtV337670dsHL1khcMBkQr/uxaDPDxVSarVPhll7c7VqF3P/Hvd8a4c1BKiDy9Cn
	gLpY1mL76xrBhDiGA2ny467702qmlo/oE6+H/6BJRrjFPWJgfsTkaGQ1EsbS8/chFxmthL3HjPz
	XZ9MHL5Ne7gx8yrKl0TFGMWgTkAZO85pVRXjYu53eEBWiaRelZ4nXy+V2LOYeIPsXaL0+YuP6gz
	sjs8MO6JDy8L754poq4EDypzPCpl0t5t8Iqy0qAtCwhaR9jjA+sRFe6aqRm9M5kbOvNn+L4xbq/
	i1ZL87zuh40Bc2ybfndC+zJNxWwAyKxvNau15757XtjoDRTqVIsOT+qMJYkOaB0eExf7tE/NYsx
	/V5G3SWVsEEmvzB2s1hDmg5Ltr4SCmlGBNXhk=
X-Received: by 2002:a05:6820:1888:b0:679:f226:30f2 with SMTP id 006d021491bc7-67b177454e5mr1558379eaf.44.1772646475491;
        Wed, 04 Mar 2026 09:47:55 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41640b99b39sm13607804fac.10.2026.03.04.09.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 09:47:54 -0800 (PST)
Message-ID: <7fb4b6e8-9d43-4a5c-abac-157d9b631cac@linuxfoundation.org>
Date: Wed, 4 Mar 2026 10:47:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
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
References: <20260302160943.2522184-1-sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260302160943.2522184-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1202A20573A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-223119-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Action: no action

On 3/2/26 09:09, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.1.165 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:42 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.164
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

A bit late - but here it is:

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

