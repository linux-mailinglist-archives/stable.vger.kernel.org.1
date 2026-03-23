Return-Path: <stable+bounces-230012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL3DJfKqwWmUUQQAu9opvQ
	(envelope-from <stable+bounces-230012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:04:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4F2FD8FC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCBE4308FBF9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43953603F7;
	Mon, 23 Mar 2026 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6HLOjIc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813B372661
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299692; cv=none; b=YdcEeNHyhGca1rY1/lEUjF+VzI/1XrA/fpkHkGCagHQQ3kQ05dnFzaEyCUn7AtoPuBgk0aCUjKuZ+S8jDVhz2KPaQqXnAQWFIaYRk6zyqjFjBHYLKWJTqqubnINJGQJdLz7QfNMbGmPDaWOaFvrUc1pz04vfBovCcA6MllE92bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299692; c=relaxed/simple;
	bh=1ggRSxfqVjf+Nkyd6/5CnLXPxn5r8Z7UtuC7H2J1Yi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SV0LFeyP9RnvBZai3tp59z3fDBdq6rxBDSP0/HkRk5iT4BzzjDVHOh4Go8qzVzYVu9kZxI/Rw5SPA7Sl2TseTl2v03pHWAb7Iwk8c2mSvj2mhP21ayp9G2idgvieHfRy/nZbBdGWpWJcvC/cpFR1JrJNjyU4T4JnuIsG4JkZ3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6HLOjIc; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89c5340fed0so49259346d6.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774299690; x=1774904490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7OYuNJrumOUG8swZz30U31phe5D0Nn9dOcsToznFEA=;
        b=C6HLOjIcIrrEYXfXq5X7ifC+5rg60p+vbeMje/q/WuJwgF6p1B52Xd/32OkHdq/X1G
         23lRUTUvYBwhyxAhoC+Bkp7W5K1XAPjLLHXumf1LhwObBcTAMfokA6qDupsxgOr+kWFb
         N3Taxry/MrmD8GPycKxPt+qfvYDyD9V8NhGSQYZ3kb9IPedEKSIlggKU7VCXHWe6e7Sc
         +9C0z3Vp1Bvf7+WoGlRTAwwizeT5V68k1OuZxzLOLAaPq2WHPNFIob3GfJ6GKrRlTjKM
         jcwUyOJSfvlahuccY4+XWKp+e/uAJH9kiIFXaF3YXpQirIRYHUH+PXHlssmk9nDqgBGX
         trag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774299690; x=1774904490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7OYuNJrumOUG8swZz30U31phe5D0Nn9dOcsToznFEA=;
        b=eTj3pKTobYda8B2gyUVQIAYr8kBuyjL7hU8YwDzRGbDIJAujHt7hVBl/nVWx5WiXQi
         ub8nMILtGkXLTc+qS53xNGMzPg0LDl9vtnwMkJ54lUjMted+GLjzUSW9BCzI44KbReVW
         AL8QtorE9xnbw1J52W0KEqzFtapvephMPIvRwvHL8JlVg+tPnB/WrxjKQaiUtaFeiPs4
         O/QjUprMxnOVV1UY64X5W1Gbjrd22YCSdH2IWa/NjxdBsGV6fxxyeXvcqNLDrhN794fA
         +ARW0CuPfHvt3cUTs6czaXRJTuVnfJ9dn1+4iPvlYoHSGtmHJ7YS91ksgxW30yVB5DPP
         b5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXFMScZOmVzfdkGHpc6DkrwTXmua3hPBAqhqraZWyFg6RaRcwOymeLVVRqktP2vil59y0PSteM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYCTbFS3Sle17vV54HDAJOqerCEVEVmw9C2aOxckV58iSotNW
	61Ar1KzlLeurru1Htnr2/wMAj8ooa8BR8ADMIEY+O7AEl2FOHgcDH0Dp
X-Gm-Gg: ATEYQzy+EQToDbOFtbP8iNUycPGjKTIst25XK2wSOtzFUS80xK3CcVEFd5Xl6pA8IkJ
	BKDcd0/bBRISDUc34FYkrfI+s0+9BHEWBlf2eB6bUM8VrwlUYCshJojoS0pyIGuLSaFem1LkyIo
	nlMHhkqYj/QhbhfWhcD/eJ7MHikedpoj3oPzgccoqQvBLvJtrMynq1xychr6CudWZ/8GecLLJNk
	X418Scmuo8AJjeUH2dQrwaz/Vwovsrl6WJ+//ewC+hBAThFCsLfA0dAyuLNwfKrOXcnkDWIezgp
	7EU/w//26quOxSOPL9npck3XObyWgJBdA43ObKw1SJEvsQpQHq8/UD6TAGul3PRi/UjP82xnuqm
	AJ+7qoic80GYORGT3eeycU/OLuIvykAKGZo77er+54nEfUD1aVTAfg6LT0S5uxfol7zQMGPwucD
	JXriqmN6aDQI1+NaukuPEZXWkeB3C5cTO+jE2fORPCsW7U6v8HZw==
X-Received: by 2002:ad4:5b8e:0:b0:89a:1c81:65a6 with SMTP id 6a1803df08f44-89cb4e708f6mr16097336d6.17.1774299690158;
        Mon, 23 Mar 2026 14:01:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c852148a5sm116660896d6.1.2026.03.23.14.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 14:01:29 -0700 (PDT)
Message-ID: <10619618-8256-4fed-974d-361fa12b12db@gmail.com>
Date: Mon, 23 Mar 2026 14:01:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260323134504.575022936@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230012-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 30C4F2FD8FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 06:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

