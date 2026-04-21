Return-Path: <stable+bounces-240207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEG1D/Or52kM/AEAu9opvQ
	(envelope-from <stable+bounces-240207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:55:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F143D9D9
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE5DF3040C51
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C237F8B2;
	Tue, 21 Apr 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fKt9B+02"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155C31D74B
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790470; cv=none; b=AQXobTBY8+K6MTe1KrVUyb7pZXtOdIdJx9P+UIH6hpjai7xalybu44KffmTQdfMHWIXVAC0AjhRDNhPQejllF/BjQrxB0obu6Zyhmlidx8NJUy26e5xtc540LAFvd9D/FzjNwbYKdnOd6oNPktkLL4oey/Dtqv8HYj5HUlhvYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790470; c=relaxed/simple;
	bh=kqn1+fEG+cfQy6eUAc2OHCPTOcWwUqrth1w+Id8q6kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gT/YclJ/JYqd1MMI3v45Y3bY6IAp0stUCimo1ADprMHWuIa7yHUEedu4zSEiwdM4cDVi9cqctWuR1p6xgwQCFyxgzQKvlSKeShkYhwbb05kcWb2RH05PUUg1VJ2y+bXLzIV1u5PrEmb+wDxtos+xqdcUNp42J4hdVY3k7lCAqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fKt9B+02; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-679f6ee3fb0so1674661eaf.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776790467; x=1777395267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2z/QHvIa+oproeoDjj/whBsGx2yqXPU54nMOYa/a5U=;
        b=fKt9B+02R6oAPyYL9y6miyjAxjhkfp5TTdYhV4YVo1WXSnQzcLd8fxMIGMlDTEiomi
         nY+tTS1nRFo0aVPkhV0Zk5UKrmsEHhDxUC92jiHbsDKz1Yi5cNdqPxXd2GZRfDBC4dej
         935w3gDWYzEwZUgOF9VSmu4AxtQnG4V74Tp9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790467; x=1777395267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2z/QHvIa+oproeoDjj/whBsGx2yqXPU54nMOYa/a5U=;
        b=lvJbDleGJPc3GeEU0gSWLvuMFI21PpGgm8GFCowTYRzrxwvLlSYzwfmr8aptd20ByO
         HwpFepMM+Gpi/dw5GLAiOOXyi3saSSs3xuRtxFMPlBAWA9fuGMPKRA4O9Qnf+DSKoFHH
         xIQvO7wYcN+kuIQBjrWYzTId0jT6eDdLqRWah4AncboL8D3tI618Pr0T+r0ELTtjaTEm
         5lFXBvb9olxfunXNDlSqAThOGyK8io5GB7qcSB0GCjw8T4OzG5/NsfNH/RYwmXYFQKqy
         5nUFUk5h7UZsIWUbxZfMqRmEZxag1x9EvYP9egHHq7LZVXtuUeoJJ7+AWY6+Szj59ZBE
         ioMA==
X-Forwarded-Encrypted: i=1; AFNElJ/UapX8A1ZoQ/OuPC9UTXo7V/z/g/VaGsMuqMBjcOaynNn0CqCKbw4VZUoSSKOw29pnDHHOmjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2UhfdjDVK3eVeXeVmOuzEIFuiXplCgTErOK1j1HPUnvWb2Bk
	AbRQrkM3uCWHALe2TKeF7/ZpIdacg5zmI0nIf5RKJ1N2mlF2XbK1tdE55KdE8Gu0/EY=
X-Gm-Gg: AeBDiesbLU7UqDYnOlcpn03twHtFCL61K3ISWwyT6SjWR1g1qpbKWvddnsSOE7l0kz2
	r2PQlnDQgLrMsnoie29XHRM1wUOOOuIriGjHvW6xL0Z5aALOMkpUKFcDqZZslMBRSf0OCvcdgWQ
	nV24wfCXlluXddfZPDQQLV3sbkjZ0TMHksv1Opaq8SvuOvUvU3Sc6es9DZhMH/GIAWY1LNAyU2H
	fPvSfu9o0H1qPghQJTUrCKYuQqjmKhHsNmwlzXAXks5VggfLt5FQimf9tTUEgsySRmnR8SNvTGQ
	twtECrqKe15aFKE+bivBc645cYL88nNtKtARd7Eyy+MA6sGRFCGRaEZ+AsckIKHS2HFor8pDqS0
	29m7eRoOqk1ROlvQnDFxT+wy1J72L3K7IDMmYD0QeTCBC4WlABKl/95npjo2fLaIhsa7lR7oF7V
	g1HwCCwOKjpXYJ705g2f3Akug3CHiIUdbgK3kgsW3PlQ==
X-Received: by 2002:a05:6820:a29a:20b0:694:8428:dfd2 with SMTP id 006d021491bc7-6948428e0e9mr3577578eaf.43.1776790467137;
        Tue, 21 Apr 2026 09:54:27 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464eeee56sm9082421eaf.8.2026.04.21.09.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 09:54:26 -0700 (PDT)
Message-ID: <d7d09653-73fa-48bc-88e7-eefa5b3bacb8@linuxfoundation.org>
Date: Tue, 21 Apr 2026 10:54:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/162] 6.12.83-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-240207-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: C87F143D9D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 09:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.83 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.83-rc1.gz
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


