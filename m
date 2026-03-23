Return-Path: <stable+bounces-230020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMulLPC6wWm/UwQAu9opvQ
	(envelope-from <stable+bounces-230020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:13:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53B2FE201
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 633AF301068C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7B3803FA;
	Mon, 23 Mar 2026 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8igY2KN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A285382292
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303972; cv=none; b=sOD7Ja/Wf9F3BrJ1HkKcfpX10zwygaxug2Qpiy9L9N7Z3JuoGbU1/aJq2nAkisZHXMMqVBuPNx9uy8V3i8KwhOQFiPPjQC5Jv6M7NvnOsnRMCocDoiLJa5OlMQF3kXV3sbQQFZtvlU9jH+usgGur6ajyuBSWvUa2bVFFgO5NIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303972; c=relaxed/simple;
	bh=HseCfv+0/ipOm6FSJT5oqvK/wBj59MHU6UTscO70NqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwmPEcxaaRdWFkwauv9kxQdiPWKSWFakhxG1oG0oZUd0Hg09I+7ePxnNlLc8/d408L4IYIimbuSqTfC4jYW4gN0qzxdcS2Mols2S2omhTQRAmw8uYk7wOzWcrpyx8y1hKGS1iAMQZdE4MyeChUpPc2RJcaU7yeALs83PmnUo+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8igY2KN; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4094b31a037so3368445fac.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774303970; x=1774908770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1n4ZyunnMns5vYFQa/Ch37HfVQD+w0TQd8emnrTKxBM=;
        b=a8igY2KNBQiR8HlQlUUMHeht+f6z1c3CfGj1dnnCBdjnQ/WXQxfwNCwAdd7yO4MToH
         Dz5qI564q9spiuDw8RHtK3Smi59YU1NuUwBE4dyRdp0gbHL9R1cyMDG23Oh4D3WXvvqq
         NEIQ7vjIMg4BAuGa8BG5d6vEi1tFT74qOHbDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303970; x=1774908770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1n4ZyunnMns5vYFQa/Ch37HfVQD+w0TQd8emnrTKxBM=;
        b=LvOIfD/22Z3q9jHu6PvkYrWKEhYf0ZTE4O9yAltOtDog1/cpBmMNfTKhq10VnmVUsT
         RNXpbM8CVlfqfiow6+vzO+zJLtFFAt7jQZh5jiyFugGcnMo7/xQjoHBh0AFT0b0IyCiR
         ZCfL337TWWXw87aoulfDIHxCCfH2p8EVBa5NIT7OJf99SM5KNdyUlCVuMjWTZ3Uty9YK
         zZXd8PeA8FeNXZ4FeRsUrWj7SYQoSLG7XQz63QEnZcqlrtUM01Z+8/cR6KRxX9quSrYt
         rqdwZvlVYmS+ZrH0ckoa4pFKRm9ivN7aBr/MxwbFfwVwSEwbINT0SJiOqCCs8+wkrNys
         ietQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu8tPkdokOM8635RpEf8vNK6UAvy68FlWKnK0+JRYx5YZyG5lirw3oUSGYHNEiuFguiqfKBEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKjifKddoFyH3589//qRBCXgW/zn6rquaGfa65lsq8W55GGhH
	wNY/vYFjiq8pHzq5k8GW+mOog8PQKhK6bUnQ3khV5ECHf3MQ/7mNLFPj2TPNT/XKbwg=
X-Gm-Gg: ATEYQzzo0vH4BvBLlW7vDd7IvxOLUDxTrXr6s2Vxxdkm+FTt/JQUahjbIriYqC+O7OB
	g6x6EQ28EuiLOI/ax10ieuXBrau6EhfcLBujaiuYb8LNwE7HI6xQ103mo04YKUvG+kURH0EBL4p
	0ocp/s7mfmuwPJoE4k2yBYlG7asYBRn/y82WLK0MxZWskfbrx7IBsDHEnWf5HZ50a8X+ebcrRIh
	RHn5of7+2FU6m2MWlX9z2nCwIGxX6FypSjkJKdVIZ0x5wp/WZI5YvKeZ8T+NbpgtBROryPAsM+Y
	J6Ke0kwXWr7+GDHNJtOsgJ9H5TSngllIV6ZBNrSEIH+kVunpjMy9ve0hiCCKBUQvoTHG9G5CorY
	STx8tNL2xwlMJKOl2OMyUb92gz49DYLJwb3hZ176GEH3MPMgKl/+W732txNnYwhb55NSz2Uf6PA
	l3pcG9W7PRL78VouX5sLkqr8E8ZCp166N/46c=
X-Received: by 2002:a05:6820:c83:b0:67c:2c29:216b with SMTP id 006d021491bc7-67c2c2924f0mr8673118eaf.48.1774303970461;
        Mon, 23 Mar 2026 15:12:50 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14e45213sm10643641fac.18.2026.03.23.15.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 15:12:50 -0700 (PDT)
Message-ID: <e74f5e07-7a02-46cb-b6b1-ffb7304f81e6@linuxfoundation.org>
Date: Mon, 23 Mar 2026 16:12:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/567] 6.6.130-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-230020-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D53B2FE201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 07:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.130 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.130-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

