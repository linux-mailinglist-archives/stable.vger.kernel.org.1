Return-Path: <stable+bounces-224547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJMiFxZpsGmNjAIAu9opvQ
	(envelope-from <stable+bounces-224547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:55:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DF256BA6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D985730C234D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5683B7B91;
	Tue, 10 Mar 2026 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buo0Tb5X"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C03C0639
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168813; cv=none; b=OqBASiR/fl04v5USXUqkKfTxziu76gBKHm6iI4WI8Dc2SyCbmWCUiouzMwuMDTL1N+GQTwDd7F6rmXED+IdLRghgQFEbU4LyBodqpx7pnoiXsGXJMLPaiIX8Vcde2gnjJYg8w9NHQA5V98T/SEEUTe1VkwGK2heuVk4YITJKsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168813; c=relaxed/simple;
	bh=C+YhAYa/zpX9wWGnavj5axbhk3T9OzYwmyrcso6nRMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHNeOifjxeGL/zE0JDXcpxcm9BKwrXqSEfyUg96nF7OBdFbNJaS11sWgeoXyZX9bRHV0GR47JV4V8O9UOl4rKoHmMvvVU1VJDqSYt3AIWmcmPsCevNxcvqv6q7Dj8smEjMhQ5PXM0AuPYKWp/XqppYjlXy4fnHa9XgZZxUL1g8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buo0Tb5X; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd7ecedf2cso292281585a.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168808; x=1773773608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLQ8LDeGKXboJUnLLEJGwv7md1mGO7c1nRHDugs5XoI=;
        b=buo0Tb5XFPMOr5o3YHwY07FgKunGAppXTs5J3OA4aA4gLfwCaWT47/YkHzXrHTvXFO
         r3D2KCOimBMxTF2Zu9xZyQXDAv4JN0JLzzAfSbzWsD0tFTmft5QFe53uwDgHBJYk3lnZ
         CT50o2O2gKA/5GdarXukfj5LGSFmOZ1EYqAs2JA2QI4fyWdF2uA+IAa0sXQZdQF/iXQO
         x7zJEDqqn7MeVbr/Fu+8u+2LTVConCZndczGjZknOPAogFEMOeQO3UV1hvmXLGRgqoHs
         xmpNf02k+dS2yyTtQ0mt7jM8oJOsa+84CTQyTaTk43MIKchwizled3lcx2Y5R3C2+tNX
         Cupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168808; x=1773773608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLQ8LDeGKXboJUnLLEJGwv7md1mGO7c1nRHDugs5XoI=;
        b=obeaZAZ604ccwnPs6NqNmOU7E0kSGebBUT+HcgfKZDgUSOpPC+NPWRHf7o1x9E4/M9
         S/qvzHUVeAbH4hq2thEb0Xd9ucbQOig63TfXLbHzxLvmHpiWstYCr1gqjuHd6595hSQ4
         ASpG5rePub7/3L2Hu9v1j8WYEd7N9p2Eqyz9VrHPWAHyK9hDGEJYi/qXIyevCwMobKCr
         rUFgzVcRglR+W94XwLb8u6ZOZqg0GW0oc94lbenS39/hsRB8j3zO/ISby4i8IowsKwmE
         r9bvR/0FT+3bzCNayoUzN5moOTOdYWY6GEcyeLjO6KCS9//W7fzRIb9sHW/TAOrf2xQH
         cjGA==
X-Forwarded-Encrypted: i=1; AJvYcCVF4cQGlBswA+K7GljlfB7DHCwb9kizBYxM3JS8gA/SdukkT4iZ6Tp41QRaudShlqt4uX7vfw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDdIz7etErks61ZP8Ir6jXOlXQZJ2jXyqoecQ08jS2yruoOkX
	1ooJSQu/QlrpZA/Q3ezxJuocnBS4OLy07ttUBaM84ep3C9TvNceanXiN
X-Gm-Gg: ATEYQzyrrxpOZblP0DewM/BpUilNbLd4vwpOJGP0J+tTIzxMggZbwcV/ElUqNTSeap0
	tci5VRye19BF9tW4fy0Miuvttgnw9Hz+jSyw/24j4K1y4f03QYGSxYjXYI/CmWfwRWFnviUXGnX
	ml11OgI0wtuD137hmttsPbgZX6rtA4QlZTxPRacCZfMqDA/39VAMfTDx8pQeH5d8aeAuStzrnKv
	UhABZNsg7uSlMXv/dNyUKC6C9QgvSDGTldlviyTymoGzwK3LVaw3VWD8NYTCit24d9Q+JTro2X0
	oPr6mY+9XxoEFUG4wIPqZbEbujMmK562F8oJmJv+NYIQHOzT/ib+51EIyvKWRCraDwKDzdhbaLm
	vvyumDAOQg14QO576oefMigzGoocGdHMpGqT4SYPL0tNHWQUAeoiQIhpskBxOQl+BBmPRgMtuA1
	iMgSzN9IZGWwywIvARSsnQIeNqM4vVbbPQIQ7B72C/UKtIKhkpcQ==
X-Received: by 2002:a05:620a:27d0:b0:8cd:7547:712 with SMTP id af79cd13be357-8cd75470fbcmr1680711485a.76.1773168807908;
        Tue, 10 Mar 2026 11:53:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda129d012sm12863785a.19.2026.03.10.11.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 11:53:27 -0700 (PDT)
Message-ID: <8d14f8e4-26fb-4824-bf3a-4e8f8ff16dd5@gmail.com>
Date: Tue, 10 Mar 2026 11:53:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/314] 6.18.17-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <cover.1773141554.git.sashal@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 021DF256BA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224547-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/10/26 04:19, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.18.17 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:19:16 AM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/rawdiff/?id=linux-6.18.y&id2=v6.18.16
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

