Return-Path: <stable+bounces-246923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB4NItulBGogMQIAu9opvQ
	(envelope-from <stable+bounces-246923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:24:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F0753700C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4413E30873B2
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B6E38E120;
	Wed, 13 May 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpEAd49A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D124C0433
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688896; cv=none; b=YjdI6cmzUDS0hF9XS7zB8nPS55uN0WykNNRvJptE0UOcxHQpsaLITTAGNZvwLJwFY/CDvInwE1zi1XL9h80Kz9sOW4BXCnjV/W2HbNwX7Hhqsp6zlpcyLuXxP3lXW3H+ruYBe2xKKrX4LNsgiADT77VqBGx21PrLODgzVWHZkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688896; c=relaxed/simple;
	bh=IMl9rhAhPrsURjRw385PZ5F450XhA27rjsXquxxSRvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpU6k0PZv2yevE3X1/vYvPzmeeqW7GPFjGsvsBfHAUGooI9XH9llPpwpNBqCEXvrjxANo0wq5zB443qlvgE0PlXS+ZhNipv8/2OA+KPZoBglOt+Hlt3sEX7eKoa5Yrjn/hRsrbY6RQFByF+WWIldiXvNaxkUxsUNVqND3Ld4cgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpEAd49A; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dcc9b506d9so5671075a34.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778688894; x=1779293694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1z14a1NSTBZsCRhz0ugTYwEWpkWkPhC3ttrFpH9DYvY=;
        b=cpEAd49ARXkalqMt97L6es+Hbbgr/T8UiRVTh2e2Mv+y6atugXTtwAWRVLPwisjKss
         c/RGyDBM8KM6fJJKiQ9tJeh7aSelrmtBRVLrSgoh3LLXrGGrjqsXcPuV0HaMfWeK92Kb
         ewvGl2zr1mIa+YfugW1h0ZTNkp7UmNrTYbCh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688894; x=1779293694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1z14a1NSTBZsCRhz0ugTYwEWpkWkPhC3ttrFpH9DYvY=;
        b=GW711BcpPxFdxDFZ4sPhUnOQizIUcXL+lHdeVP8Qg/gkxbD7zkWiRlxBp4lrq87rup
         SjA0YkyDXjrdwuITebVA0u/1EiDjceXjX5xd2horczRMWX5oDgsjWgZvOb82oH9SZ4cc
         AkoHiPvsEbYnhvH7Ge+TbNzK6rSoIe65AWBxCGeBuJfcHKmTlgLfwa6j5sHroeAN+OD6
         Md75BCMtUPsNAc4IdUZLCHKk3veqPhrSdO0svMzccf2leDxj1lXeOP/AfNIh87+TUYRO
         B0LISwdFWMVD3eWeKADRqcip8LgemUDP6FNG6n97qhe+BsrDZAQimvbggv8wNoojIaE8
         gCvw==
X-Forwarded-Encrypted: i=1; AFNElJ86nz7BYarYInBL8fTpV/Qrqbc+ayLFPucYyY/LdJsLIvOBYa2xjuJKa/703pcJMHMlDQrV/EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEz0NgcG71ff0qRm5p75FZHtiRLhlnYaUj5JY4REQsgtO+eHQ
	YQp2D7hLayLQ2DD64xzRTnYH4ljlom8Vnyvi6T6eRPEtPiGTJYMYop7ZvJwj9cLnlgY=
X-Gm-Gg: Acq92OERhxHgHkmJ9wZfn9Nt/FrPGj7WQontLxedfhrbXSe9TjA/QIVpz4KMbagI4O1
	XJD8R9lNfZE3Z5ikKruL5CHF0zBcv/mKTY3ze+WDcaVnQpbp4tStq703FQf+KTv3YOD12u8h5bu
	cb3hRc4oqyVxHz4hIh7m4IKgRWJnk8/4SLhEFDQlsuZmaGafMETzUuq1fClwBcCD8WpTr4qYVqm
	fcSAhRwOV4V+u/+okOdar7jha3Z3LmUOCHdbjNU/rmiZpL57NQoGSCCNHo/l6kevoy7R2n5xxUe
	wfQbGuKLwZDB0fsqPUZrerwfKFdbJWqaxhJ6QBbT8FXNbeBonQFKLamwHx3Ad9W7BPwgtXdwS8x
	p3ciNfhaA1dnmoGOA2mUw7InoWWUMqZ+kqigohY6JHiJVlkJdNO0rcC4tnp2y8GtF375bCyER89
	21lHZPA0dW2eSVg66wkQVS7S4Uri+QfFo=
X-Received: by 2002:a05:6830:43a9:b0:7d7:4639:43ee with SMTP id 46e09a7af769-7e3dc61b823mr2202671a34.3.1778688893789;
        Wed, 13 May 2026 09:14:53 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d8fd96sm11468947a34.19.2026.05.13.09.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 09:14:52 -0700 (PDT)
Message-ID: <775a2878-b038-4f9f-b44b-f7235da62553@linuxfoundation.org>
Date: Wed, 13 May 2026 10:14:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/270] 6.18.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 19F0753700C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-246923-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 11:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.30 release.
> There are 270 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 May 2026 17:38:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.30-rc1.gz
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

