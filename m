Return-Path: <stable+bounces-235480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CLrE2nv12kbUwgAu9opvQ
	(envelope-from <stable+bounces-235480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:26:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B89DD3CEAB1
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 765ED3033897
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56463DE42F;
	Thu,  9 Apr 2026 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLBrOc5a"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791523AB27C
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759199; cv=none; b=Cvn2ZOTgyhOGPMA9PHpAhnERo92ru2WdlxquzaEN8Y/wDfryK9CwIMXLHvdg+4x1A9gB/RGysBNhnq9ZuzTxQ6fuhnR1fD0CMz5ErBI4caLEJurI04wYKt7JuSnXHOixz/cBqhlFR1pWldVFa7TdNeK29JAsA7P3SOi+jayI/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759199; c=relaxed/simple;
	bh=CFe4r5rqzqt/Sp7WENq4hddAY2QStw41+2r+0OQ2yto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBh3t3hQXbDY+HwNTMHakWyt0jukiJNI319YThMnghW4S5EQrHLBJ07X+wECbceXk2e441yllti2urVPvh0tW2zOlWjmaYYw4YKdgg5J4oNtFv9PuZ4T3Ag5w9Ko2qL2fobpbvnKuKKQv5uiMBSLZDV8QlUTxttHz0fbTJ4t5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLBrOc5a; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c25b90264so1150923c88.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775759198; x=1776363998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdKL7tHwSlpCH9ecELkoXd/ttoxemvIIYgeBw2frtN0=;
        b=OLBrOc5atUjmlZ3yQqHjbphUwjKOBYIqMOqptt1ODy1UzauTJJAd04ncO4YisNp7bE
         zMicFWBDUQUpqwfwGTRqm5Azs/hE1cq73xbV4IbLGJ14H41XqqrBGWn00NMkhj/mqSCI
         QrmpK9z5Xi3+AGzZ/ol2BnaeH/Pti/o95BJwCDFKWNRe8zNiDoAegll0BYFSyvpXY/p5
         xAu2EOs0RiwjHcxajQFFmp9H72ckaLXqVB3GWi93lRLxTAVu5eHkX7vv8cggJWaNnTB+
         mqi+/v8m1rxsL+KYvn+JEIQU1O45wkXXEOmROfOQf9vTvVbA8uHXnRV9spzMQDiNo2r1
         kn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759198; x=1776363998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdKL7tHwSlpCH9ecELkoXd/ttoxemvIIYgeBw2frtN0=;
        b=Og3Qwd+BxsDDEGKGQooshHmYxeXD3LoHI/WlyY7LzRrBSGGEwQh1fTQPA0Wh3Cb9dX
         4HqIq6dzvocJs4c4Y8nSMCeYqI+RgmQpXDkCWE6nVM/Li6C/zRqtLDa0WxdkMXCw22TP
         19FjNrSWWWtFW3u34f1npypcBGZ+MTt2+bExW+ypqzPPDV+xgOVrrT7+IYe+djqY9dgi
         CuKpk8uHTFEGs+q3i9mjJGviI2e6n2dc8e0u1FDXjiXN9w9wNsfjsj8cX/Yl9d6bPOZJ
         q270HbezVuUISsCucag5+RJuiYkLsANRFuwdiG5Iddykaih8e0C4CjCU9qM6LGGpfbhm
         b7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUhB5uz8oyjJGqf/fbul3KchLzKA9MetpULvUEKb4zdqGU63kbgU/l0ZsDme2Rl7Go4rBK83c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0G6vxHrY7mtArUlAkNSjc08qBEx4CVDc4+ONbU7V+70ADtrS/
	V7fJLljdNfOYhnhdyPhzUVH7OKWRohqiDwcPC7YRK9gaP2tQyFmgKhB8
X-Gm-Gg: AeBDiesQZVGhFIUX2abe8iIHh1N+ObepLZQ4DhqP8oOHQ/SvlqHYRnDO7JYJPNEIx+e
	SV5mixwvx3ZRSUdrsH6bTlTk7zEC88SC+k1BbTMIPRPlDtxIFUjGbJUKIZOIeTUzM4V09KZP76R
	BtYgR6qHsufaXWEtsInhlSXohwisinq4PKWxS5/S6mEiGxJ6A1eXRNKyA5z+6QNchlGzAHmjUEw
	Gd5Dzg2tFLPq00pVIJWvqGuDcWzqP5PE8OpKT19YVTtA0iUsuiFfgOn073TRYwyB9Gb/swNEgXY
	aignpg3KXM9W1YCizLv7u4fiWGLvCz2N2Se0A8iwcd5SZE+JYxKtu4w7R9lBhcYcTzTlwOb9YHt
	Sb4bPEJbiZNN/fjb4K1ZDxtzVVPhExcb2aKgfQ1gHYRXYc+iOOKwyl97ldESltmekjKDDKC4rYr
	j6S/GWXs+AobUrWAPow0SqZgzQpMa9MvPImZ3WYg2PzVPrnhrQlQ==
X-Received: by 2002:a05:7022:670a:b0:12b:f881:d8fb with SMTP id a92af1059eb24-12c34e3979dmr94352c88.3.1775759197531;
        Thu, 09 Apr 2026 11:26:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa586bsm929906eec.11.2026.04.09.11.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:26:33 -0700 (PDT)
Message-ID: <88bf92ac-80fd-45e5-af96-c3454cd0b911@gmail.com>
Date: Thu, 9 Apr 2026 11:26:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/276] 6.18.22-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260409092720.599045151@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260409092720.599045151@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235480-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B89DD3CEAB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 02:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.22 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 11 Apr 2026 09:26:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.22-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

