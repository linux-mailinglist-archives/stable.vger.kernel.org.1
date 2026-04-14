Return-Path: <stable+bounces-237977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE9ZLsO23ml3HgAAu9opvQ
	(envelope-from <stable+bounces-237977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:50:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D91673FEB5C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D70173020D26
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0E038757D;
	Tue, 14 Apr 2026 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b1c2h4N3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A588330D2A
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203385; cv=none; b=GDVpUiUKRAqZY17Rcq3KXUnowkYiRhBFQXRLvTbUXiXwQmRBj1SheL9SDaHwTUcEbX1q8A1KBab39/jJHj2SU1JtHXZrrDoJUMX2VMKMPZZsW46kqmXWFeX1Kg8d1K0tngDFLjpHxmVFL34tJLP+dOXn/m+1pNz0kuNq1x5bKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203385; c=relaxed/simple;
	bh=ytcqA41zrL7QUs8Xha+hnKTXzfGRT0PvGOlj7ME6CtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8rQdgIbkIQYLbKKFyWmDD/uC3hvml1gBlldSbYmhMZNxE3I3suakKaRiYwRGsQ3C5gcRv0nL5RWJ4T97HZ0G09SgrQHpLC5db+3zL1Nu0/IXREyK+6ZgaDdJCrtExBoJBqiy4QdLKsrRDF6DoDj7TdkGj/y420ikou/x15b8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b1c2h4N3; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dbccf6a23dso5850036a34.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776203382; x=1776808182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ls/MF5YlFX8eWIIa5wJrWeJBI0E64mcpAYTvQqf+Io=;
        b=b1c2h4N3XYCScWfn7/Omdgh4mI1jAufQbCbNYPPIVfCA5Z9fyXL+9mcG5pxZEF1aC1
         tpxSrtn+vQ5jxOkdL15iyGbA3jq34zZZA67pPtvR4lvojK6zJrl0woCftz7w5Ux8ImsU
         j8x3gFRVwil8KV2QD6enUnRAr39FHbhkLi6Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776203382; x=1776808182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ls/MF5YlFX8eWIIa5wJrWeJBI0E64mcpAYTvQqf+Io=;
        b=OonElY8dk7069ZFoC3qZeIyGt5xU1eZtfC7KrpyHAVe8SgoMYHhNCzPmUZJEO0b36I
         iTGnbhHcXCuEtx16pNsdqUJu7312qYQXyTZciU+2dahjyF9hh7KmtQIwBzJPhHM8Nboi
         knRZB4HGtItVAH6puMPiH4rcDa4n8OrK+rsNiUOazmrsY/sNiWNLxNRo9I4nifSVhzfX
         sKQVWIH5XDoxxYa44h/6aBu8EGvhWETDT41Ug9JyUoAHbCmy6mhRkMvnchGntQsmhcNs
         eeS/eSyUo4Ee5V/qAP9NK7tCqdJbmxiQp9C0/RcWKAlgzQ+LEE/kSbX4MH68KnZXsiXo
         XNNg==
X-Forwarded-Encrypted: i=1; AFNElJ+7pHgOpNz1TYzrHzaL9KHz2UpiW6yDDKk4bqxoxNhdPOM/hSKeb8sLCRBDIRPhmKBdNVTn4zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCsPKMUOfiXEYA4aaDv9kF0l1Q5e4fDS0FiAr91gkbAvY32koE
	qyqad76d+2bDVZLYkgPtSKRcbVLQrkVIybS4m9yi8sjttWFxjQYGKFklLZ+7hWPBDKM=
X-Gm-Gg: AeBDietMqO683lAvMlz8XZTJivBJ+fh7f4znGEYYjaz9+DrKhWbngTPZNaiYgiyVkSI
	els2p8CdEnR6wPwmXptVTXkn47Ug7zZ6b5ujmAd1Xhh6EjU0Bj16W8eRqHYnoP5KTWjRSIYs8Wc
	QtiYiBzUSRqdEw2ovOc0yoQsLogaRCx7uxKN9fuG0mFouqjnLzSspplarpY3VTkKaFcp8wo/vBj
	mn3Qt0Oh05x8jFVgSUxAXFxTqtIfWtOzBqxKFr6Bx0GZxNUDgC6x7quYibYrouyp9JEX3+1lzet
	PpPjOERK8KQ1pWr4WheKXibWKTAPb3zH4N2F8zNsqFixByj8K8AyB/fZJGO7lUG6Lk+wzPok3pR
	2XhHIecutDoZdGt/wkem1iQ9TCLE0gD/D68e4rhvmTDg+YFMundWCrMTkHIPgBRIVHrK7leoECL
	76E5xUbdE50UVTBaK9JzANvQ2Th1hXCI0=
X-Received: by 2002:a05:6830:67d7:b0:7d7:ef0a:1ce9 with SMTP id 46e09a7af769-7dc27f0b2d3mr12296295a34.14.1776203382297;
        Tue, 14 Apr 2026 14:49:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc3959099fsm8932418a34.9.2026.04.14.14.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 14:49:41 -0700 (PDT)
Message-ID: <356f0b83-9338-4b23-b417-8b72f760d0c9@linuxfoundation.org>
Date: Tue, 14 Apr 2026 15:49:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/570] 5.15.203-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-237977-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D91673FEB5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 09:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.203 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.203-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

