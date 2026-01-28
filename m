Return-Path: <stable+bounces-212668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGPfBbFsemne6AEAu9opvQ
	(envelope-from <stable+bounces-212668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:08:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C8A85FD
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 202C630138B2
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FF36F435;
	Wed, 28 Jan 2026 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBAVvXnK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC93375CD
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769630893; cv=none; b=GbHJFuqO3Xxf9xKTzYQFitXi0RtXx4ypDbobeLGrlo/zxNmJd1NqcILo8fgPz7uINX8Iui4z1kH8ACfBjS16vcYC9YVN2V4heDsfz5K2tAnC0ysp4zhrFViyPLyZSy1dO0ih6QEFDqqWxBwoMnTCRcxAlS/0ZWgWszT3ayVyh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769630893; c=relaxed/simple;
	bh=DD2lnKYsXQi8JTHAXXry/C8D52xJPkI4ktiba23CyXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i64v3/hQn9TyBpVdwHDfRN61ATIJAD+/DEjWAXi9QX8jERa2VpPxc0FA59nVrAkjY/FJk4uqxyBWNLJbXlUKpBTyevmBonHxigsNCs/hrMVyRHXv6GZDs/Xs80bQ6n1koUDdaZ2ehgt0qUfJtPTpjX6giqkEhHCoHhpXNC5ZCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBAVvXnK; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso706815eec.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 12:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769630892; x=1770235692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VKrgT3u8Ct9Lfwm5qvvMFzTEIzMXojRzDK6hYzoIcI=;
        b=NBAVvXnKLp0zA7zx0brghgRgbw9OMiVCOjVzwsD0H/q2+lfutyTBHf4vX+rNPApYpO
         dYAflVGVxikKPnIilNIyqEwQ4r/zbnnzMHdr3BvdSG2OzxpfB77jRZdwGwqpTIcoikzL
         hw3GYdQeaA3O58tLT2XZG+9n3zF6kqUDl9xvH5TcRJSowuGuxeE54HME9Tpz1n60Qqjt
         nHu0O3XGkjpM/eagiMQTsXk6zPmZhtIw/KVYbI1hjHcxck+yon7kMn24XNu+f2jAPuq/
         FERt37Gu3NpnNpZLSWksxTiVYWI1UOqX+C+YraVgx8IIhNiUdymFYyiIp7tyBj6SXNhd
         kSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769630892; x=1770235692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VKrgT3u8Ct9Lfwm5qvvMFzTEIzMXojRzDK6hYzoIcI=;
        b=DRmC3Ud6SY4yirVUMbMSRd7Q5KpCBjnOlHZWhPK5UUiYzqFSVl09pTit3rhhZtodio
         I9GVInfguzUM8Ob8D2LXY/bYXeTJNI8Q6ag8zLw/16wC1OFNOYYBr7OHhrSHWJi29rJB
         etgvud3vsBetKakg6M7gtt7IiNpt1VKMZezRgnlbANwjHOYrnkQO38jNdEGi9z0S+suS
         lfW11omMMibDDcK8EqEjhVuPEfzD89FANNl5aoghizVZV0zZ0NqB4CoImzvf3CI3ChbM
         BFT2qh1hpoOjZM6bvhwLmFjRlGshfm9vEeaLvwLH2w5ChulmjevwUqdr4byvBPEH7Cum
         N1Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWKvRj2ZnPeHjugqAMsX2j+4L84zkr5wb9DqrwG2HWT0wvHBQr+oI0XuISfpVE0JdD85I2+68o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83nby2ekxaQAxxh4b6gXm9lrZmtaFpclbZiudhfTR+PUSTvZD
	6PAlNtfvtsrYoFizy1fhSXFf/o4GvsmDyHA80YUxW1srpIG53tVrwVmg
X-Gm-Gg: AZuq6aLU1ZQ0J0i94XjE1qUFRApRDbwEIwOA0+YxI5uvDbySTESLrerP7hYy28Jy9Iv
	HWH5+O3l7FJexLdbgb60sxvh80LB0ZgXoSKhkq4Y1FupM/rlv9CSMizUX2p6/nOtZtmglCyyxjC
	DJvTZYCik3iznbremYN2RtNhCEyEezHFJZ8pm+4liwtu4SInEPYPd7zpqNN12ZmBNJZYtiryqbb
	CmTH2h7+7GzratHJENFYXKKs+pZoOp/k4dE9zI0dkqR6Z8TgwpxvRUSNDUfsjT3ZsxQUGcpNswE
	roPbUei0vdUOT+fEbgTZZyX4Fnl1/sRn7B/e4G0Smks9MfEaDrBlvyvsLrn6g1pMIqbwwz0opw7
	lhQSpDX2efFeoR+e9984QRHJhSpytSYx+lGk3DnywB5WLaZ4L/dma6RONmmIuQqe3cDqBwC58jj
	aKEYfTBDHMyl8buVBLABgVmo8oS10HzDk5bYT6Jgfy5P04CbTD
X-Received: by 2002:a05:7300:72c5:b0:2b0:51a7:509a with SMTP id 5a478bee46e88-2b78da12271mr3671598eec.33.1769630891616;
        Wed, 28 Jan 2026 12:08:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfa25sm4051993eec.5.2026.01.28.12.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 12:08:10 -0800 (PST)
Message-ID: <61211800-c308-4fe5-b9ad-d33978900650@gmail.com>
Date: Wed, 28 Jan 2026 12:08:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/169] 6.12.68-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260128145334.006287341@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212668-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D8C8A85FD
X-Rspamd-Action: no action

On 1/28/26 07:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.68 release.
> There are 169 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.68-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

