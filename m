Return-Path: <stable+bounces-244209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBf2JpsS+mkWJAMAu9opvQ
	(envelope-from <stable+bounces-244209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:54:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C894D0AB0
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9BCC30B96F8
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB048AE16;
	Tue,  5 May 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aE+XkBc2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30B48AE03
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996310; cv=none; b=OEk3YUAOV8yK6GQMIxRUKxpcKv2Oepj9F3LbH0kQz3SAWwTj9sY6lO24zcFY9V37MmTil8/rWsfCp9c1x6DVuR2aZklp84GSvjn8sxX+6eiUZDvc8IMc0/Bjj17GbDsFGxGo+YPMvfiyjYftLxYzL3C6eE2vQZ4WKnjM61sqRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996310; c=relaxed/simple;
	bh=awcIw/4fwJ1g0c3g2Sh7ge3eFIYyfDIecRfHiwyGW8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfejLagazQE7uMwNbZfKF82rdDPKNjx66TTgw6IuWiTdM7Cy+sc+URKI6x0ItciaDCFihDLBIN74dbiKUbhTxa7uS2yqU69clk6OIMl4AfoqL+TeC4vEFiMGcnREFRTNGy/NAhflQ5CDQ5+fRtFboua2L1U3XcjDQ5S8MdefhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aE+XkBc2; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-694891f8f62so3035199eaf.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777996306; x=1778601106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAHPocfZ9QrMyLyykTWYGDm3AQeZnbOC9erlVzF0T5k=;
        b=aE+XkBc2w8UUUHSf0BA0fWA11zivItyncvnOM/RYSpy4ghFhrgtw5NCTGa9gE4hwLZ
         XVS6Cfv+qUNNtjr+msAwPGY+x44NZtp5xrXYOJ0RpKqSiv4oZOb9nCEY95vyxrQHwQdD
         UmX7HumvMscZh+UvR3rWck1W3AEZ6lOXSOd8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996306; x=1778601106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAHPocfZ9QrMyLyykTWYGDm3AQeZnbOC9erlVzF0T5k=;
        b=ZTTcQr8IkkGsTd/N0vVVSyThePUMZefszMbMW9zh95BAkKxx1HpbFWaU0hrWHrYnaa
         SocMbiZHWSIwcbcFnYC4Q8Z2AeeGNFOpJGIVdr59p7eQgGpxjZQX52zQXB3Z90iX3whu
         ya8NkB5KbInf4UAarFABNvwhg3ku9Jyxmrb8qNQ3aoAQz9NpCkPFGW0Qc5alEKBKkLuS
         tBw3jxOPJB321Km44Px9n3pGV8hqYvUlXMQt0lKUiLh7iom18OoKZ3Lg0eqStGwFxrHE
         yYlOHRXrS8G8eoFlHirUaoD56RiN3SNZyfoPaCuTdL4hcvYpye679k3I48YUo0k5MP7p
         rzAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ct6W2gIlo/fzb8zlDSP7JkUS95fDT9bGCA6LFUpcqn+T64Rm7v/PzYDOU5LT1GORnd2Qo4dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCbpIuuNwiJIU6oUTHNpXV2MWqdKecwEndebXfmLClsxUTpAt
	2wQRJRhrauaOPjvOe1dPnjFJ9sZHakz4KQapmK5X3NFWINgEY1iSI6Uljwqvy/JQE5c=
X-Gm-Gg: AeBDietfYRa/zwBFsep/Rlr0tV8hYIChUVDT1+pbuKJWPylnd1GRQ41lZjG7lk4yWlC
	osaFJDTHmpnlpBeaRouk8Nu0rkzAplyEvDbLIZlBgpdgf1XfQfqHtg6O1vmtejAmIOxmvKKxEz+
	VQiRBVacWsImj7Wjqv0y1fKDcyChLCOneMk4KIwKVIa6QvKQDS+8uIlLjh0Vpqz6F3jDhjYNEW+
	5MD2i18avyujY8M+dJqeWsIuHL56IzeQ0AwyYelKdpsjGOEE0LFZ/dYkE05788qyimnAPoFPQkb
	bS5HMmyCS8i8O3/fPu9aVIuhgTNbBrbJFbhU9iVSG9gT0hcTHjOUZaIHNiw6kfZWon14t8dhxme
	tF4nGCprANopwiyIAY3ITzCGhAZPmDrgjAQa89Uh2EOg9iMaUp9kyYFY/8coOPzQg9kAsUsGbTv
	wSbHhfj+y0SNsL/sr8wqVKiZ/AmTWGnNQ5SKpp1cvXxg==
X-Received: by 2002:a05:6820:2109:b0:694:8b8a:b44f with SMTP id 006d021491bc7-696979c99f3mr7538140eaf.13.1777996306387;
        Tue, 05 May 2026 08:51:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548c56fcsm14510405fac.4.2026.05.05.08.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 08:51:45 -0700 (PDT)
Message-ID: <a243571c-1ba5-4978-8ee1-0d01ca132277@linuxfoundation.org>
Date: Tue, 5 May 2026 09:51:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/275] 6.18.27-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 22C894D0AB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-244209-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

On 5/4/26 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.27 release.
> There are 275 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2026 13:50:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.27-rc1.gz
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

